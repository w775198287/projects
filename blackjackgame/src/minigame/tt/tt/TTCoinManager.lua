--筹码管理
local TTUtils = import("..tt.TTUtils")
local TTCoinManager = class("TTCoinManager")
local TTCoin = import("..tt.TTCoin")
local TTGameData = import("..tt.TTGameData")
local TTConstant = import("..tt.TTConstant")
local TTEvent = import("..tt.TTEvent")
local TTMsgId = import("..tt.TTMsgId")
local TTAudio = import("..tt.TTAudio")
local scheduler = cc.Director:getInstance():getScheduler()
local bezierSpeed = 0.7
function TTCoinManager:setTTGameNode(node)
	self.winSize_ = cc.Director:getInstance():getWinSize()
	self.ttGame_ = node
	self.Panel_gps = self.ttGame_.resourceNode_:getChildByName("Panel_gps")
	self.Panel_coinBank = self.Panel_gps:getChildByName("Panel_coinBank")
	self.Panel_coinSelf = self.Panel_gps:getChildByName("Panel_coinSelf")
	self.Panel_coinGuest = self.Panel_gps:getChildByName("Panel_coinGuest")
	self.betCoinTable = {}
	self.betCoinTable[TTConstant.POS_ZHUANG]={}
	self.betCoinTable[TTConstant.POS_ZHONG]={}
	self.betCoinTable[TTConstant.POS_FA]={}
	self.betCoinTable[TTConstant.POS_BAI]={}
	self.Panel_head_PosTable = {}
	local headNodes = self.ttGame_:getHeadNodes()
	for k,v in pairs(headNodes) do		
		if v.seatId~=nil then
			local Panel_cardStart = self.Panel_gps:getChildByName( string.format("Panel_head%d", v.seatId) )
			local x,y = Panel_cardStart:getPosition()
			self.Panel_head_PosTable[v.seatId] = cc.p(x,y)
		end
	end
	self.Panel_bet_NodeTable = {}
	for i=0,2 do
		local Panel_betName = string.format("Panel_bet%d", i)
		local Panel_bet = self.Panel_gps:getChildByName(Panel_betName)
		self.Panel_bet_NodeTable[i] = Panel_bet
	end
end
--间隔飞出筹码显示
function TTCoinManager:intervalShowCoin(  )
	self.intervalShowCoinScheduler = scheduler:scheduleScriptFunc(function( dt )
		local function betOne()
			if self.cacheBetTable and #self.cacheBetTable>0 then				
				local c = self.cacheBetTable[1]
				table.remove(self.cacheBetTable,1)
				self:bet(c.betGps, c.coinIndex, c.seatId, c.isAni)
			end
		end
		local x = 0
		local y = 0
		if self.cacheBetTable then
			x = #self.cacheBetTable
		end
		if nil==self.frameFlyCoinScheduler and x>0 then--一批动画分散到每帧去加载
			if x>math.floor(TTConstant.CACHE_FLYCOIN_NUM/2) then
				x = math.floor(TTConstant.CACHE_FLYCOIN_NUM/2)
			end
			self.frameFlyCoinScheduler = scheduler:scheduleScriptFunc(function( dt )	
				TTUtils:xpcall(betOne)
				if 0==(y%5) then
					TTAudio:playEffect("ttaudio/mp3/bet1.mp3")
				end
				y = y+1
				if y==x and self.frameFlyCoinScheduler then
					scheduler:unscheduleScriptEntry(self.frameFlyCoinScheduler)
					self.frameFlyCoinScheduler = nil
				end
			end, 0, false)
		end
	end, TTConstant.INTERVAL_FLYCOIN, false)
end
--清空缓存要飞出显示的筹码
function TTCoinManager:clearCoinCache()
	self.cacheBetTable = nil
end
--获取缓存筹码自己下注的筹码数量
function TTCoinManager:getCacheCoinNumSelf()
	local cacheCoinNumTable = {}
	cacheCoinNumTable[TTConstant.POS_ZHONG]=0
	cacheCoinNumTable[TTConstant.POS_FA]=0
	cacheCoinNumTable[TTConstant.POS_BAI]=0
	if self.cacheBetTable then
		for i,v in ipairs(self.cacheBetTable) do
			if v.seatId==TTConstant.SEATID_SELF then
				local num = self:getCoinNumByIndex(v.coinIndex)
				if 0==num then
					TTUtils:Log(" TTCoinManager:getCacheCoin 筹码错误 ")
					dump(self.cacheBetTable)
				end
				cacheCoinNumTable[v.betGps.betZone] = cacheCoinNumTable[v.betGps.betZone]+num
			end
		end
	end
	return cacheCoinNumTable
end
--获取缓存筹码总下注的筹码数量
function TTCoinManager:getCacheCoinNumTotal()
	local cacheCoinNumTable = {}
	cacheCoinNumTable[TTConstant.POS_ZHONG]=0
	cacheCoinNumTable[TTConstant.POS_FA]=0
	cacheCoinNumTable[TTConstant.POS_BAI]=0
	if self.cacheBetTable then
		for i,v in ipairs(self.cacheBetTable) do
			local num = self:getCoinNumByIndex(v.coinIndex)
			if 0==num then
				TTUtils:Log(" TTCoinManager:getCacheCoin 筹码错误 ")
				dump(self.cacheBetTable)
			end
			cacheCoinNumTable[v.betGps.betZone] = cacheCoinNumTable[v.betGps.betZone]+num
		end
	end
	return cacheCoinNumTable
end
function TTCoinManager:cacheBet(betGps,coinIndex,seatId,isAni)
	if not self.cacheBetTable then
		self.cacheBetTable = {}
	end
	local item = {}
	item.betGps = betGps
	item.coinIndex = coinIndex
	item.seatId = seatId
	item.isAni = isAni
	if seatId==TTConstant.SEATID_SELF then
		table.insert(self.cacheBetTable, 1, item)
	else
		table.insert(self.cacheBetTable, item)
	end
	if #self.cacheBetTable>=TTConstant.CACHE_FLYCOIN_NUM then--超过最大缓存数量，将最早的删除
		table.remove(self.cacheBetTable, TTConstant.CACHE_FLYCOIN_NUM)
	end
end
-- betGps = {betZone = 1 2 3 中发白三个位置, betRound 看对应的常量
--coinIndex 0 1 2 3 四个筹码
--seatId 用户的座位号 ：
-- 
--	seatId=0     seatId=3
--  seatId=1     seatId=4
--  seatId=2     seatId=5
--			seatId=-1   
-- seatId为-1表示自己
function TTCoinManager:bet(betGps,coinIndex,seatId,isAni)
	if isAni==nil then
		isAni = true
	end
	local coinStartPos = nil
	local coinEndPos = nil
	local betZone = betGps.betZone
	local headNodes = self.ttGame_:getHeadNodes()	
	for k,v in pairs(headNodes) do		
		if v.seatId~=nil and v.seatId==seatId and nil~=v:getUserId() then
			coinStartPos = self.Panel_head_PosTable[v.seatId]
			break
		end
	end
	if TTConstant.SEATID_SELF==seatId then
		local x,y = self.Panel_coinSelf:getPosition()
		coinStartPos = cc.p(x,y)
	end
	if nil==coinStartPos then
		local x,y = self.Panel_coinGuest:getPosition()
		coinStartPos = cc.p(x,y)
	end
	coinEndPos = self:getBetEndPos(betGps)
	local bezier = {
        cc.p( (coinStartPos.x+(coinEndPos.x-coinStartPos.x)/3.0), math.max(coinStartPos.y, coinEndPos.y)+200 ),
        cc.p( (coinStartPos.x+(coinEndPos.x-coinStartPos.x)*2/3.0), math.max(coinStartPos.y, coinEndPos.y)+200 ),
        cc.p(coinEndPos.x, coinEndPos.y),
    }
    local bezierForward = cc.BezierTo:create(bezierSpeed, bezier)
    local ttCoin = self:getCoin()
    ttCoin:setCoinIndex(coinIndex)
	self.Panel_gps:addChild(ttCoin)	
	ttCoin:setPosition(coinStartPos)
	if isAni then
		local coinsChg = self:getCoinNumByIndex(coinIndex)
		if TTConstant.SEATID_SELF==seatId then
			TTEvent:dispatchEvent({name=TTMsgId.UPDATE_SELF_BET_COIN,userData={coinsChg=coinsChg, coins=nil, betZone=betGps.betZone} })
		end
		TTEvent:dispatchEvent({name=TTMsgId.UPDATE_TOTAL_BET_COIN,userData={coinsChg=coinsChg, coins=nil, betZone=betGps.betZone} })
		ttCoin:runAction(bezierForward)
	else
		ttCoin:setPosition(coinEndPos)
	end
	betZone = tonumber(betZone)
	local betCoinTableRMIndex = 1

	if self.betCoinTable[betZone] and #self.betCoinTable[betZone]>TTConstant.MAX_COIN_NUM  then
		local curBetTileEarlyCoin = self.betCoinTable[betZone][1]
		TTCoinManager:freeObject(curBetTileEarlyCoin)
		table.remove(self.betCoinTable[betZone],1)
		curBetTileEarlyCoin:removeFromParent()
	end
	table.insert(self.betCoinTable[betZone], ttCoin)
end
--获取中发白下注区域的随机位置
--1.betGps = {betZone = 1 2 3 中发白三个位置, betRound 看对应的常量
--2.betGps = 1 2 3 中发白三个位置
function TTCoinManager:getBetEndPos(betGps)
	local betZone = 1
	local betRound = TTConstant.BET_ROUND_FIRST
	if type(betGps)=="number" then
		betZone = betGps-1
		betRound = math.random(0,1)
	else
		betZone = betGps.betZone-1
		betRound = betGps.betRound
	end
	
	local Panel_bet = self.Panel_bet_NodeTable[betZone]
	if Panel_bet then
		local randomW = math.round(Panel_bet:getContentSize().width)*math.random(50,950)/1000.0
		local randomH = math.round(Panel_bet:getContentSize().height)*math.random(100,900)/1000.0
		return cc.p(Panel_bet:getPositionX()+randomW,Panel_bet:getPositionY()+randomH)
	else
		TTUtils:Log("TTCoinManager:getBetEndPos 错误错误 "..tostring(betZone))
	end	
end
--根据筹码索引获取筹码的值
function TTCoinManager:getCoinNumByIndex( index )
	local num = 0
	for j=0,4 do
		if index==j then
			num = TTGameData.roomInfo.chips[j+1]--lua数组下标从1开始
		end
	end
	return num
end
--是否在指定的下注区域
function TTCoinManager:isPosInBetZone(point, betGps)-- betGps = {betZone = 1 2 3 中发白个位置, betRound 看对应的常量
	if betGps.betRound~=0 and betGps.betRound~=1 then
		TTUtils:Log("不能判断是否在指定的下注区域")
		TTUtils:Log(betRound)
		return false
	end
	local Panel_bet = self.Panel_bet_NodeTable[betGps.betZone-1]
	if Panel_bet then
		local Panel_betRect = cc.rect(Panel_bet:getPositionX(), Panel_bet:getPositionY(), Panel_bet:getContentSize().width, Panel_bet:getContentSize().height)
		return cc.rectContainsPoint(Panel_betRect, point)
	end	
	return false
end
--下注区域的筹码飞到庄家
function TTCoinManager:zoneToBank(coinNode,pCb)
	coinNode:setLocalZOrder(TTConstant.LOCALZORDER_COINS)
	local x,y = self.Panel_coinBank:getPosition()
	local coinEndPos = cc.p(x,y)
	x,y = coinNode:getPosition()
	local coinStartPos = cc.p(x,y)

	local bezier = {
        cc.p( (coinStartPos.x+(coinEndPos.x-coinStartPos.x)/3.0), (coinStartPos.y + (coinEndPos.y-coinStartPos.y)/3.0) ),
        cc.p( (coinStartPos.x+(coinEndPos.x-coinStartPos.x)*2/3.0), (coinStartPos.y + (coinEndPos.y-coinStartPos.y)*2/3.0) ),
        cc.p(coinEndPos.x, coinEndPos.y),
    }
    local bezierForward = cc.BezierTo:create(bezierSpeed, bezier)
    local function callBack(node)
        if pCb then
        	pCb(node)
        end
        if self.nSoundIdZoneToBank then
        	self.ttGame_:stopTTEffect(self.nSoundIdZoneToBank)
        	self.nSoundIdZoneToBank = nil
        end
    end
    local function fadeOut( node )
    	node:setVisible(false)
    end
    coinNode:runAction( cc.Sequence:create(bezierForward, cc.CallFunc:create(fadeOut), cc.CallFunc:create(callBack)) )
    if not self.nSoundIdZoneToBank then
    	self.nSoundIdZoneToBank = self.ttGame_:playTTEffect("flyCoins")
    end
end
--庄家的筹码飞到下注区域
function TTCoinManager:bankToZone(coinNode,betZone,pCb)
	coinNode:setLocalZOrder(coinNode:getLocalZOrder()+1)
	local x,y = coinNode:getPosition()
	local coinStartPos = cc.p(x,y)
	local coinEndPos = self:getBetEndPos(betZone)

	local bezier = {
        cc.p( (coinStartPos.x+(coinEndPos.x-coinStartPos.x)/3.0), (coinEndPos.y + (coinStartPos.y-coinEndPos.y)*2/3.0) ),
        cc.p( (coinStartPos.x+(coinEndPos.x-coinStartPos.x)*2/3.0), (coinEndPos.y + (coinStartPos.y-coinEndPos.y)/3.0) ),
        cc.p(coinEndPos.x, coinEndPos.y),
    }
    local bezierForward = cc.BezierTo:create(bezierSpeed, bezier)
    local function callBack(node)
        if pCb then
        	pCb(node)
        end
        if self.nSoundIdBankToZone then
        	self.ttGame_:stopTTEffect(self.nSoundIdBankToZone)
        	self.nSoundIdBankToZone = nil
        end
    end
    local function fadeIn( node )
    	node:setVisible(true)
    end
    coinNode:runAction( cc.Sequence:create(cc.CallFunc:create(fadeIn) ,bezierForward, cc.CallFunc:create(callBack)) )
    if not self.nSoundIdBankToZone then
    	self.nSoundIdBankToZone = self.ttGame_:playTTEffect("flyCoins")
    end
end
--下注区域的筹码飞到用户(包括在座用户、自己、游客)
function TTCoinManager:zoneCoinsToUser(coinNode,userId,pCb)
	coinNode:setLocalZOrder(TTConstant.LOCALZORDER_COINS)
	local x, y = coinNode:getPosition()
	local coinStartPos = cc.p(x,y)
	local coinEndPos = self.ttGame_:getGpsPosByUserId(userId)

	local bezier = {
        cc.p( (coinStartPos.x+(coinEndPos.x-coinStartPos.x)/3.0), (coinStartPos.y + (coinEndPos.y-coinStartPos.y)/3.0) ),
        cc.p( (coinStartPos.x+(coinEndPos.x-coinStartPos.x)*2/3.0), (coinStartPos.y + (coinEndPos.y-coinStartPos.y)*2/3.0) ),
        cc.p(coinEndPos.x, coinEndPos.y),
    }
    local bezierForward = cc.BezierTo:create(bezierSpeed, bezier)
    local function callBack(node)
    	node:setVisible(false)
        if pCb then
        	pCb(node)
        end
        if self.nSoundIdZoneCoinsToUser then
        	self.ttGame_:stopTTEffect(self.nSoundIdZoneCoinsToUser)
        	self.nSoundIdZoneCoinsToUser = nil
        end
    end
    coinNode:runAction( cc.Sequence:create(cc.FadeIn:create(0.1) ,bezierForward, cc.CallFunc:create(callBack)) )    
    if not self.nSoundIdZoneCoinsToUser then
    	self.nSoundIdZoneCoinsToUser = self.ttGame_:playTTEffect("flyCoins")
    end
end
--下注区域的新创建筹码飞到用户(包括在座用户、自己、游客)
function TTCoinManager:zoneNewCoinsToUser(zone,coins,userId,pCb)
	local coinNodeTable = {}
	for i=4,0,-1 do
	    local num = math.floor(coins/TTGameData.roomInfo.chips[i+1])
	    coins = coins%TTGameData.roomInfo.chips[i+1]
		for j=0,num do
			local ttCoin = self:getCoin()
			ttCoin:setCoinIndex(i)
			ttCoin:setLocalZOrder(TTConstant.LOCALZORDER_COINS)
			ttCoin:setPosition(self:getBetEndPos(zone))
			self.Panel_gps:addChild(ttCoin)
			table.insert(coinNodeTable, ttCoin)
		end
	end
	for k,v in pairs(coinNodeTable) do
		local x, y = v:getPosition()
		local coinStartPos = cc.p(x,y)
		local coinEndPos = self.ttGame_:getGpsPosByUserId(userId)
		local bezier = {
	        cc.p( (coinStartPos.x+(coinEndPos.x-coinStartPos.x)/3.0), (coinStartPos.y + (coinEndPos.y-coinStartPos.y)/3.0) ),
	        cc.p( (coinStartPos.x+(coinEndPos.x-coinStartPos.x)*2/3.0), (coinStartPos.y + (coinEndPos.y-coinStartPos.y)*2/3.0) ),
	        cc.p(coinEndPos.x, coinEndPos.y),
	    }
	    local bezierForward = cc.BezierTo:create(bezierSpeed, bezier)
	    local function callBack(node)
	    	node:setVisible(false)
	        if pCb then
	        	pCb(node)
	        end
	    end
	    v:runAction( cc.Sequence:create(cc.FadeIn:create(0.1) ,bezierForward, cc.CallFunc:create(callBack)) )
	end
end
--庄家新创建筹码飞到三个下注区域
function TTCoinManager:bankNewCoinsToZone()
	local x,y = self.Panel_coinBank:getPosition()
	local coinStartPos = cc.p(x,y)
	for k1,v1 in pairs(self.betCoinTable) do
		if k1~=TTConstant.POS_ZHUANG then
			local tempTable = {}
			for k2,v2 in pairs(v1) do--v2是TTCoin
				local ttCoin = self:getCoin()
				ttCoin:setCoinIndex(v2:getCoinIndex())
				ttCoin:setLocalZOrder(TTConstant.LOCALZORDER_COINS)
				ttCoin:setPosition(coinStartPos)
				self.Panel_gps:addChild(ttCoin)
				table.insert(tempTable, ttCoin)
				if #tempTable>TTConstant.MAX_ONCE_COIN_NUM then
					break
				end
			end
			for i3,v3 in ipairs(tempTable) do--v3是TTCoin
				table.insert(v1, 1, v3)
				local coinEndPos = self:getBetEndPos(k1)
				local bezier = {
			        cc.p( (coinStartPos.x+(coinEndPos.x-coinStartPos.x)/3.0), (coinEndPos.y + (coinStartPos.y-coinEndPos.y)*2/3.0) ),
			        cc.p( (coinStartPos.x+(coinEndPos.x-coinStartPos.x)*2/3.0), (coinEndPos.y + (coinStartPos.y-coinEndPos.y)/3.0) ),
			        cc.p(coinEndPos.x, coinEndPos.y),
			    }
			    local bezierForward = cc.BezierTo:create(bezierSpeed, bezier)
			    v3:runAction(bezierForward)
			end
		end
	end
end

--清空
function TTCoinManager:clear()
	for i=0,3 do
		for k,v in pairs(self.betCoinTable[i]) do
			TTCoinManager:freeObject(v)
			v:removeFromParent()
		end
	end
	self:removeCoinsNode()
	self.betCoinTable[TTConstant.POS_ZHUANG]={}
	self.betCoinTable[TTConstant.POS_ZHONG]={}
	self.betCoinTable[TTConstant.POS_FA]={}
	self.betCoinTable[TTConstant.POS_BAI]={}
end
function TTCoinManager:removeCoinsNode()
	local ttCoin = self.Panel_gps:getChildByName("TTCoin")
	if ttCoin then
		TTCoinManager:freeObject(ttCoin)
		ttCoin:removeFromParent()
		self:removeCoinsNode()
	end
end


----------------------------------------------------------------------------------筹码对象池-----------------------------------------------------------------------------------
--初始化对象池
function TTCoinManager:initCoinPool()
	TTUtils:Log("初始化对象池")
	self.coinPoolNodes = {}
	self:asyncCreateCoin()
end
--销毁对象池
function TTCoinManager:destroy()
	TTUtils:Log("筹码管理器销毁")
	if self.asyncCreateCoinScheduler then
		scheduler:unscheduleScriptEntry(self.asyncCreateCoinScheduler)
		self.asyncCreateCoinScheduler = nil
	end
	for i,v in ipairs(self.coinPoolNodes) do
		v:release()
	end
	self.coinPoolNodes = nil
	if self.intervalShowCoinScheduler then
		scheduler:unscheduleScriptEntry(self.intervalShowCoinScheduler)
		self.intervalShowCoinScheduler = nil
	end
	if self.frameFlyCoinScheduler then
		scheduler:unscheduleScriptEntry(self.frameFlyCoinScheduler)
		self.frameFlyCoinScheduler = nil
	end
	self.cacheBetTable = nil
	self.winSize_ = nil
	self.ttGame_ = nil
	self.Panel_gps = nil
	self.Panel_coinBank = nil
	self.Panel_coinSelf = nil
	self.Panel_coinGuest = nil
	self.betCoinTable = nil
	self.betCoinTable = nil
	self.Panel_head_PosTable = nil
	self.Panel_bet_NodeTable = nil
end
--获取金币筹码对象
function TTCoinManager:getCoin()	
	TTUtils:Log("获取筹码对象")
	TTUtils:Log(#self.coinPoolNodes)
	if #self.coinPoolNodes==0 then
		TTUtils:Log("需要创建一批筹码对象,同步创建筹码")
		self:syncCreateCoin()
	end
	if #self.coinPoolNodes<math.floor(TTConstant.COIN_POOL_CAPACITY/5.0) then
		TTUtils:Log("需要创建一批筹码对象,异步创建筹码")
		self:asyncCreateCoin()
	end
	local ttCoin = self.coinPoolNodes[1]
	table.remove(self.coinPoolNodes,1)
	return ttCoin

end
--异步创建筹码
function TTCoinManager:asyncCreateCoin( )
	if self.asyncCreateCoinScheduler then
		return
	end
	self.asyncCreateCoinScheduler = scheduler:scheduleScriptFunc(function( dt )
		if self.asyncCreateCoinScheduler and #self.coinPoolNodes>=TTConstant.COIN_POOL_CAPACITY then	
			scheduler:unscheduleScriptEntry(self.asyncCreateCoinScheduler)
			self.asyncCreateCoinScheduler = nil
		else
			local ttCoin = TTCoin:new()
			ttCoin:retain()
			table.insert(self.coinPoolNodes, ttCoin)
		end
	end, 0, false)
end
--同步创建筹码
function TTCoinManager:syncCreateCoin()
	local ttCoin = TTCoin:new()
	ttCoin:retain()
	table.insert(self.coinPoolNodes, ttCoin)
	return ttCoin
end
--回收金币筹码对象
function TTCoinManager:freeObject( pTTCoin )
	TTUtils:Log("回收金币筹码对象")
	TTUtils:Log("对象池数量"..tostring(#self.coinPoolNodes))

	if #self.coinPoolNodes>=1.5*TTConstant.COIN_POOL_CAPACITY then
		TTUtils:Log("需要清空一批金币对象池金币筹码对象")
		for i=1, math.floor(TTConstant.COIN_POOL_CAPACITY/2) do
			local ttCoin = self.coinPoolNodes[1]
			ttCoin:release()
			table.remove(self.coinPoolNodes,1)
		end
	end
	pTTCoin:reset()
	table.insert(self.coinPoolNodes, pTTCoin)
end
return TTCoinManager


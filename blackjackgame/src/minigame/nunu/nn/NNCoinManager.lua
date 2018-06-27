--筹码管理
local NNUtils = import("..nn.NNUtils")
local NNCoinManager = class("NNCoinManager")
local NNCoin = import("..nn.NNCoin")
local NNGameData = import("..nn.NNGameData")
local NNConstant = import("..nn.NNConstant")
local NNEvent = import("..nn.NNEvent")
local NNMsgId = import("..nn.NNMsgId")
local NNAudio = import("..nn.NNAudio")
local scheduler = cc.Director:getInstance():getScheduler()
local bezierSpeed = 0.7
function NNCoinManager:setNNGameNode(node)
	self.winSize_ = cc.Director:getInstance():getWinSize()
	self.nnGame_ = node
	self.Panel_gps = self.nnGame_.resourceNode_:getChildByName("Panel_gps")
	self.Panel_coinBank = self.Panel_gps:getChildByName("Panel_coinBank")
	self.Panel_coinSelf = self.Panel_gps:getChildByName("Panel_coinSelf")
	self.Panel_coinGuest = self.Panel_gps:getChildByName("Panel_coinGuest")
	self.betCoinTable = {}
	self.betCoinTable[NNConstant.POS_ZHUANG]={}
	self.betCoinTable[NNConstant.POS_TIAN]={}
	self.betCoinTable[NNConstant.POS_DI]={}
	self.betCoinTable[NNConstant.POS_XUAN]={}
	self.betCoinTable[NNConstant.POS_HUANG]={}
end
--间隔飞出筹码显示
function NNCoinManager:intervalShowCoin(  )
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
			if x>math.floor(NNConstant.CACHE_FLYCOIN_NUM/2) then
				x = math.floor(NNConstant.CACHE_FLYCOIN_NUM/2)
			end
			self.frameFlyCoinScheduler = scheduler:scheduleScriptFunc(function( dt )
				NNUtils:xpcall(betOne)
				if 0==(y%5) then
					NNAudio:playEffect("nnaudio/mp3/bet1.mp3")
				end
				y = y+1
				if y==x and self.frameFlyCoinScheduler then
					scheduler:unscheduleScriptEntry(self.frameFlyCoinScheduler)
					self.frameFlyCoinScheduler = nil
				end
			end, 0, false)
		end
	end, NNConstant.INTERVAL_FLYCOIN, false)
end
--清空缓存要飞出显示的筹码
function NNCoinManager:clearCoinCache()
	self.cacheBetTable = nil
end
--退出游戏取消间隔调用显示筹码
function NNCoinManager:destroyShowCoin()
	if self.intervalShowCoinScheduler then
		scheduler:unscheduleScriptEntry(self.intervalShowCoinScheduler)
		self.intervalShowCoinScheduler = nil
	end
	if self.frameFlyCoinScheduler then
		scheduler:unscheduleScriptEntry(self.frameFlyCoinScheduler)
		self.frameFlyCoinScheduler = nil
	end
	self.cacheBetTable = nil
end
--获取缓存筹码自己下注的筹码数量
function NNCoinManager:getCacheCoinNumSelf()
	local cacheCoinNumTable = {}
	cacheCoinNumTable[NNConstant.POS_TIAN]=0
	cacheCoinNumTable[NNConstant.POS_DI]=0
	cacheCoinNumTable[NNConstant.POS_XUAN]=0
	cacheCoinNumTable[NNConstant.POS_HUANG]=0
	if self.cacheBetTable then
		for i,v in ipairs(self.cacheBetTable) do
			if v.seatId==NNConstant.SEATID_SELF then
				local num = self:getCoinNumByIndex(v.coinIndex)
				if 0==num then
					NNUtils:Log(" NNCoinManager:getCacheCoin 筹码错误 ")
					dump(self.cacheBetTable)
				end
				cacheCoinNumTable[v.betGps.betZone] = cacheCoinNumTable[v.betGps.betZone]+num
			end
		end
	end
	return cacheCoinNumTable
end
--获取缓存筹码总下注的筹码数量
function NNCoinManager:getCacheCoinNumTotal()
	local cacheCoinNumTable = {}
	cacheCoinNumTable[NNConstant.POS_TIAN]=0
	cacheCoinNumTable[NNConstant.POS_DI]=0
	cacheCoinNumTable[NNConstant.POS_XUAN]=0
	cacheCoinNumTable[NNConstant.POS_HUANG]=0
	if self.cacheBetTable then
		for i,v in ipairs(self.cacheBetTable) do
			local num = 0
			for j=0,4 do
				if v.coinIndex==j then
					num = NNGameData.roomInfo.chips[j+1]--lua数组下标从1开始
				end
			end
			if 0==num then
				NNUtils:Log(" NNCoinManager:getCacheCoin 筹码错误 ")
				dump(self.cacheBetTable)
			end
			cacheCoinNumTable[v.betGps.betZone] = cacheCoinNumTable[v.betGps.betZone]+num
		end
	end
	return cacheCoinNumTable
end
function NNCoinManager:cacheBet(betGps,coinIndex,seatId,isAni)
	if not self.cacheBetTable then
		self.cacheBetTable = {}
	end
	local item = {}
	item.betGps = betGps
	item.coinIndex = coinIndex
	item.seatId = seatId
	item.isAni = isAni
	if seatId==NNConstant.SEATID_SELF then
		table.insert(self.cacheBetTable, 1, item)
	else
		table.insert(self.cacheBetTable, item)
	end
	if #self.cacheBetTable>=NNConstant.CACHE_FLYCOIN_NUM then--超过最大缓存数量，将最早的删除
		table.remove(self.cacheBetTable, NNConstant.CACHE_FLYCOIN_NUM)
	end
end
-- betGps = {betZone = 1 2 3 4 天地玄黄四个位置, betRound 看对应的常量
--coinIndex 0 1 2 3 四个筹码
--seatId 用户的座位号 ：
-- 
--	seatId=0     seatId=3
--  seatId=1     seatId=4
--  seatId=2     seatId=5
--			seatId=-1   
-- seatId为-1表示自己
function NNCoinManager:bet(betGps,coinIndex,seatId,isAni)
	if isAni==nil then
		isAni = true
	end
	local coinStartPos = nil
	local coinEndPos = nil
	local betZone = betGps.betZone
	local headNodes = self.nnGame_:getHeadNodes()	
	for k,v in pairs(headNodes) do		
		if v.seatId~=nil and v.seatId==seatId then
			local Panel_cardStart = self.Panel_gps:getChildByName( string.format("Panel_head%d", v.seatId) )
			local x,y = Panel_cardStart:getPosition()
			coinStartPos = cc.p(x,y)
			break
		end
	end
	if NNConstant.SEATID_SELF==seatId then
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
    local nnCoin = self:getCoin()
	nnCoin:setCoinIndex(coinIndex)
	self.Panel_gps:addChild(nnCoin)	
	nnCoin:setPosition(coinStartPos)
	if betGps.betRound==NNConstant.BET_ROUND_SECOND then
		nnCoin:setLocalZOrder(NNConstant.LOCALZORDER_COINS)
	end
	if isAni then
		local coinsChg = self:getCoinNumByIndex(coinIndex)
		if NNConstant.SEATID_SELF==seatId then
			NNEvent:dispatchEvent({name=NNMsgId.UPDATE_SELF_BET_COIN,userData={coinsChg=coinsChg, coins=nil, betZone=betGps.betZone} })
		end
		NNEvent:dispatchEvent({name=NNMsgId.UPDATE_TOTAL_BET_COIN,userData={coinsChg=coinsChg, coins=nil, betZone=betGps.betZone} })
		nnCoin:runAction(bezierForward)
	else
		nnCoin:setPosition(coinEndPos)
	end
	betZone = tonumber(betZone)
	local betCoinTableRMIndex = 1

	local curBetTileNum = 0--天地玄黄下注区域的内的小块里的筹码数（每轮下注在不同的小块上面）
	local curBetTileEarlyCoin = nil--小块内最早下注的一个筹码
	for i,v in ipairs(self.betCoinTable[betZone]) do
		if self:isPosInBetZone(cc.p(v:getPositionX(), v:getPositionY()), betGps)then
			if curBetTileEarlyCoin==nil then
				curBetTileEarlyCoin = v
				betCoinTableRMIndex = i
				break
			end
			curBetTileNum = curBetTileNum+1
		end
	end
	if self.betCoinTable[betZone] and curBetTileNum>NNConstant.MAX_COIN_NUM and curBetTileEarlyCoin then
		NNCoinManager:freeObject(curBetTileEarlyCoin)
		table.remove(self.betCoinTable[betZone],betCoinTableRMIndex)
		curBetTileEarlyCoin:removeFromParent()
	end
	table.insert(self.betCoinTable[betZone], nnCoin)
end
--获取天地玄黄下注区域的随机位置
--1.betGps = {betZone = 1 2 3 4 天地玄黄四个位置, betRound 看对应的常量
--2.betGps = 1 2 3 4 天地玄黄四个位置
function NNCoinManager:getBetEndPos(betGps)
	local betZone = 1
	local betRound = NNConstant.BET_ROUND_FIRST
	if type(betGps)=="number" then
		betZone = betGps-1
		betRound = math.random(0,1)
	else
		betZone = betGps.betZone-1
		betRound = betGps.betRound
	end
	
	local Panel_betName = ""
	if betRound==NNConstant.BET_ROUND_FIRST then--第一轮下注
		Panel_betName = string.format("Panel_bet%d_%d", betZone,0)
	elseif betRound==NNConstant.BET_ROUND_SECOND then--第二轮下注
		Panel_betName = string.format("Panel_bet%d_%d", betZone,1)
	end
	local Panel_bet = self.Panel_gps:getChildByName(Panel_betName)
	if Panel_bet then
		local randomW = math.round(Panel_bet:getContentSize().width)*math.random(50,950)/1000.0
		local randomH = math.round(Panel_bet:getContentSize().height)*math.random(100,900)/1000.0
		return cc.p(Panel_bet:getPositionX()+randomW,Panel_bet:getPositionY()+randomH)
	else
		NNUtils:Log("NNCoinManager:getBetEndPos 错误错误 "..betZone)
	end	
end
--根据筹码索引获取筹码的值
function NNCoinManager:getCoinNumByIndex( index )
	local num = 0
	for j=0,4 do
		if index==j then
			num = NNGameData.roomInfo.chips[j+1]--lua数组下标从1开始
		end
	end
	return num
end
--是否在指定的下注区域
function NNCoinManager:isPosInBetZone(point, betGps)-- betGps = {betZone = 1 2 3 4 天地玄黄四个位置, betRound 看对应的常量
	if betGps.betRound~=0 and betGps.betRound~=1 then
		NNUtils:Log("不能判断是否在指定的下注区域")
		NNUtils:Log(betRound)
		return false
	end
	Panel_betName = string.format("Panel_bet%d_%d", (betGps.betZone-1),betGps.betRound)
	local Panel_bet = self.Panel_gps:getChildByName(Panel_betName)
	if Panel_bet then
		local Panel_betRect = cc.rect(Panel_bet:getPositionX(), Panel_bet:getPositionY(), Panel_bet:getContentSize().width, Panel_bet:getContentSize().height)
		return cc.rectContainsPoint(Panel_betRect, point)
	end	
	return false
end
--下注区域的筹码飞到庄家
function NNCoinManager:zoneToBank(coinNode,pCb)
	coinNode:setLocalZOrder(NNConstant.LOCALZORDER_COINS)
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
        	self.nnGame_:stopNNEffect(self.nSoundIdZoneToBank)
        	self.nSoundIdZoneToBank = nil
        end
    end
    local function fadeOut( node )
    	node:setVisible(false)
    end
    coinNode:runAction( cc.Sequence:create(bezierForward, cc.CallFunc:create(fadeOut), cc.CallFunc:create(callBack)) )
    if not self.nSoundIdZoneToBank then
    	self.nSoundIdZoneToBank = self.nnGame_:playNNEffect("flyCoins")
    end
end
--庄家的筹码飞到下注区域
function NNCoinManager:bankToZone(coinNode,betZone,pCb)
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
        	self.nnGame_:stopNNEffect(self.nSoundIdBankToZone)
        	self.nSoundIdBankToZone = nil
        end
    end
    local function fadeIn( node )
    	node:setVisible(true)
    end
    coinNode:runAction( cc.Sequence:create(cc.CallFunc:create(fadeIn) ,bezierForward, cc.CallFunc:create(callBack)) )
    if not self.nSoundIdBankToZone then
    	self.nSoundIdBankToZone = self.nnGame_:playNNEffect("flyCoins")
    end
end
--下注区域的筹码飞到用户(包括在座用户、自己、游客)
function NNCoinManager:zoneCoinsToUser(coinNode,userId,pCb)
	coinNode:setLocalZOrder(NNConstant.LOCALZORDER_COINS)
	local x, y = coinNode:getPosition()
	local coinStartPos = cc.p(x,y)
	local coinEndPos = self.nnGame_:getGpsPosByUserId(userId)

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
        	self.nnGame_:stopNNEffect(self.nSoundIdZoneCoinsToUser)
        	self.nSoundIdZoneCoinsToUser = nil
        end
    end
    coinNode:runAction( cc.Sequence:create(cc.FadeIn:create(0.1) ,bezierForward, cc.CallFunc:create(callBack)) )    
    if not self.nSoundIdZoneCoinsToUser then
    	self.nSoundIdZoneCoinsToUser = self.nnGame_:playNNEffect("flyCoins")
    end
end
--下注区域的新创建筹码飞到用户(包括在座用户、自己、游客)
function NNCoinManager:zoneNewCoinsToUser(zone,coins,userId,pCb)
	local coinNodeTable = {}
	for i=4,0,-1 do
	    local num = math.floor(coins/NNGameData.roomInfo.chips[i+1])
	    coins = coins%NNGameData.roomInfo.chips[i+1]
		for j=0,num do
			local nnCoin = self:getCoin()
			nnCoin:setCoinIndex(i)
			nnCoin:setLocalZOrder(NNConstant.LOCALZORDER_COINS)
			nnCoin:setPosition(self:getBetEndPos(zone))
			self.Panel_gps:addChild(nnCoin)
			table.insert(coinNodeTable, nnCoin)
		end
	end
	for k,v in pairs(coinNodeTable) do
		local x, y = v:getPosition()
		local coinStartPos = cc.p(x,y)
		local coinEndPos = self.nnGame_:getGpsPosByUserId(userId)
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
--庄家新创建筹码飞到四个下注区域
function NNCoinManager:bankNewCoinsToZone()
	local x,y = self.Panel_coinBank:getPosition()
	local coinStartPos = cc.p(x,y)
	for k1,v1 in pairs(self.betCoinTable) do
		if k1~=NNConstant.POS_ZHUANG then
			local tempTable = {}
			for k2,v2 in pairs(v1) do--v2是NNCoin
				local nnCoin = self:getCoin()
				nnCoin:setCoinIndex(v2:getCoinIndex())
				nnCoin:setLocalZOrder(NNConstant.LOCALZORDER_COINS)
				nnCoin:setPosition(coinStartPos)
				self.Panel_gps:addChild(nnCoin)
				table.insert(tempTable, nnCoin)
				if #tempTable>NNConstant.MAX_ONCE_COIN_NUM then
					break
				end
			end
			for i3,v3 in ipairs(tempTable) do--v3是NNCoin
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
function NNCoinManager:clear()
	self:removeCoinsNode()
	self.betCoinTable[NNConstant.POS_ZHUANG]={}
	self.betCoinTable[NNConstant.POS_TIAN]={}
	self.betCoinTable[NNConstant.POS_DI]={}
	self.betCoinTable[NNConstant.POS_XUAN]={}
	self.betCoinTable[NNConstant.POS_HUANG]={}
end
function NNCoinManager:removeCoinsNode()
	local nnCoin = self.Panel_gps:getChildByName("NNCoin")
	if nnCoin then
		NNCoinManager:freeObject(nnCoin)
		nnCoin:removeFromParent()
		self:removeCoinsNode()
	end
end


----------------------------------------------------------------------------------筹码对象池-----------------------------------------------------------------------------------
--初始化对象池
function NNCoinManager:initCoinPool()
	NNUtils:Log("初始化对象池")
	self.coinPoolNodes = {}
	self:asyncCreateCoin(NNConstant.COIN_POOL_CAPACITY)
end
--销毁对象池
function NNCoinManager:destroyCoinPool()
	NNUtils:Log("销毁对象池")
	if self.asyncCreateCoinScheduler then
		scheduler:unscheduleScriptEntry(self.asyncCreateCoinScheduler)
		self.asyncCreateCoinScheduler = nil
	end
	for i,v in ipairs(self.coinPoolNodes) do
		v:release()
	end
	self.coinPoolNodes = {}
end
--获取金币筹码对象
function NNCoinManager:getCoin()	
	NNUtils:Log("获取筹码对象")
	NNUtils:Log(#self.coinPoolNodes)
	if #self.coinPoolNodes==0 then
		NNUtils:Log("需要创建一批筹码对象,同步创建筹码")
		self:syncCreateCoin()
	end
	if #self.coinPoolNodes<math.floor(NNConstant.COIN_POOL_CAPACITY/5.0) then
		NNUtils:Log("需要创建一批筹码对象,异步创建筹码")
		self:asyncCreateCoin(NNConstant.COIN_POOL_CAPACITY)
	end
	local nnCoin = self.coinPoolNodes[1]
	table.remove(self.coinPoolNodes,1)
	return nnCoin

end
--异步创建筹码
function NNCoinManager:asyncCreateCoin( coinNum )
	if self.asyncCreateCoinScheduler then
		return
	end
	self.asyncCreateCoinScheduler = scheduler:scheduleScriptFunc(function( dt )
		local nnCoin = NNCoin:new()
		nnCoin:retain()
		table.insert(self.coinPoolNodes, nnCoin)
		if self.asyncCreateCoinScheduler and #self.coinPoolNodes==coinNum then	
			scheduler:unscheduleScriptEntry(self.asyncCreateCoinScheduler)
			self.asyncCreateCoinScheduler = nil
		end
	end, 0, false)
end
--同步创建筹码
function NNCoinManager:syncCreateCoin()
	local nnCoin = NNCoin:new()
	nnCoin:retain()
	table.insert(self.coinPoolNodes, nnCoin)
	return nnCoin
end
--回收金币筹码对象
function NNCoinManager:freeObject( pNNCoin )
	NNUtils:Log("回收金币筹码对象")
	NNUtils:Log("对象池数量"..tostring(#self.coinPoolNodes))
	if #self.coinPoolNodes>=1.5*NNConstant.COIN_POOL_CAPACITY then
		NNUtils:Log("需要清空一批金币对象池金币筹码对象")
		for i=1, math.floor(NNConstant.COIN_POOL_CAPACITY/2) do
			local nnCoin = self.coinPoolNodes[1]
			nnCoin:release()
			table.remove(self.coinPoolNodes,1)
		end
	end
	pNNCoin:reset()
	table.insert(self.coinPoolNodes, pNNCoin)
end
return NNCoinManager


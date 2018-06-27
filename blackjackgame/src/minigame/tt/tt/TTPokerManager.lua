--扑克牌管理
local TTUtils = import("..tt.TTUtils")
local TTPokerManager = class("TTPokerManager")
local TTPoker = import("..tt.TTPoker")
local TTEvent = import("..tt.TTEvent")
local TTMsgId = import("..tt.TTMsgId")
local TTConstant = import("..tt.TTConstant")
local ANIMATE_SPEED = 0.8
local scheduler = cc.Director:getInstance():getScheduler()
function TTPokerManager:setTTGameNode(node)	
	self.ttGame_ = node
	self.pokerSpan_ = 128
	self.pokerTable = {}
	self.Panel_gps = self.ttGame_.resourceNode_:getChildByName("Panel_gps")
	self.Panel_cardStart = self.Panel_gps:getChildByName("Panel_cardStart")
	self.Panel_card_PosTable = {}
	for i=0,3 do
		local Panel_card = self.Panel_gps:getChildByName( string.format("Panel_card%d", i) )
		local x,y = Panel_card:getPosition()
		self.Panel_card_PosTable[i] = cc.p(x,y)
	end
end
--发牌
function TTPokerManager:dealPoker(resultInfo, isAni, pCb)
	local cardsData = resultInfo.cardsData
	resultInfo.isAni = isAni
	local speed = ANIMATE_SPEED
	local gameStatus = self.ttGame_.gameStatus
	if false==isAni then
		speed = 0		
	else
		isAni = true
	end
	local function xiPaiEnd(node)
		local pokerTableIndex = 1
		local x,y = self.Panel_cardStart:getPosition()
		local startPos = cc.p(x,y)
		local defaultLocalZOrder = 1
        for i1,v1 in ipairs(cardsData) do---i1为1-4 四个人的牌信息(依次庄、中、发、白)
			i1 = i1-1
			local pos = i1
        	x = self.Panel_card_PosTable[pos].x
        	y = self.Panel_card_PosTable[pos].y
        	for j=1,2 do---v2为牌值
				v2 = v1.cards[j]
        		local poker = self.pokerTable[pokerTableIndex]
        		pokerTableIndex = pokerTableIndex+1
				local endPos = cc.p( (j-1.5)*self.pokerSpan_*poker.poker_:getScaleX()+x, y )
				poker:setPosition(startPos)
				poker:setNum(v2)
				poker:showPortraitBack()
				if false==isAni then
					poker:setVisible(false)
				end
				if j==1 then
					poker.notifyPos = pos---notifyPos 0 1 2 3 庄中发白
				end
				if i1==0 then--庄家最后翻牌
					i1 = 4
				end
				if 8==i1*j then--翻牌的最后一张
					poker.isLastFlipPoker = true
				else
					poker.isLastFlipPoker = false
				end
				local function beroreMove(pokerNode)--发牌动画播出之前
					pokerNode:setLocalZOrder(defaultLocalZOrder)
					defaultLocalZOrder = defaultLocalZOrder+1
					if isAni then
						self.ttGame_:playTTEffect("deal")
					end
				end
				local function filpPokerAniEnd(pPokerNode)
					if pPokerNode.isLastFlipPoker and pCb then
						pCb()
					end
					if pPokerNode.notifyPos~=nil then
						TTEvent:dispatchEvent({name=TTMsgId.PLAY_PEEKANI_END,userData={pos=pPokerNode.notifyPos,notifyResultInfo=resultInfo} })
					end
				end					
				local function flipPokerAni( pokerNode)--牌翻转动画
					if false==isAni then
						pokerNode:showNormal()
						if pokerNode.notifyPos~=nil then
							TTEvent:dispatchEvent({name=TTMsgId.PLAY_PEEKANI_END,userData={pos=pokerNode.notifyPos,notifyResultInfo=resultInfo} })
						end
					else
						pokerNode:playFlipPoker(filpPokerAniEnd)
					end
				end
				poker:runAction( cc.Sequence:create(
					cc.DelayTime:create( (i1*0.25+j-1)*speed ),
					cc.CallFunc:create(beroreMove),
					cc.MoveTo:create(0.25*speed, endPos),
					-----------------------最后一张牌移动完毕时间               翻牌间隔1.0*speed      两张牌同时翻
					cc.DelayTime:create(  (4*0.25+2-1)*speed+0.25*speed  +      1.0*speed*i1    -     j*speed        ),
					cc.CallFunc:create(flipPokerAni)
				))						
        	end
        end
        for i=pokerTableIndex,25 do
        	local poker = self.pokerTable[i]
        	if poker then
        		poker:setVisible(false)
        	end
        end
    end
	self:xipaiAni(xiPaiEnd,isAni)	
end
--洗牌动画
function TTPokerManager:xipaiAni(pCb,isAni)
	local function xiPaiEnd(node)
	    if pCb then
	    	pCb()
	    end
	end
	local xipaiTime = 0.5
	if false==isAni then
		xipaiTime = 0
	end
	local Panel_cardStart = self.Panel_cardStart
	local defaultLocalZOrder = 1
	for i=0,24 do
		local poker = self:getPoker()
		poker:setLocalZOrder(defaultLocalZOrder)
		defaultLocalZOrder = defaultLocalZOrder+1
		poker:showPortraitBack()
		poker:setPosition(Panel_cardStart:getPosition())
    	local multiplicator = (i-12)*(250/12) --牌反面向两边移动 最大移动距离250
    	local action1 = cc.MoveBy:create(xipaiTime, cc.p(multiplicator,0))
    	local action2 = cc.MoveBy:create(0, cc.p(0-multiplicator,0)) --牌反面还原位置
    	local seq = cc.Sequence:create(action1,action2)
    	if isAni then
    		poker:runAction(seq)
    	else
    		poker:setVisible(false)
    	end    	
    	table.insert(self.pokerTable,poker)
	end
	Panel_cardStart:runAction( cc.Sequence:create(cc.DelayTime:create(1.2*xipaiTime),cc.CallFunc:create(xiPaiEnd)))
end

--撵牌动画
function TTPokerManager:peekPokerAni(resultInfo, isAni)
	-- if table.nums(self.pokerTable)==0 then
	-- 	TTUtils:Log("撵牌动画播放失败，没有发牌")
	-- 	return
	-- end
	-- if TTConstant.GAME_STATUS_KAIPAI~=self.ttGame_.gameStatus then
	-- 	TTUtils:Log("撵牌动画播放失败,不在开牌时间")
	-- 	return
	-- end
	-- resultInfo.isAni = isAni
	-- local cardsDataIndex = 1
	-- for i,v in ipairs(self.pokerTable) do
	-- 	if cardsDataIndex==6 then
	-- 		break
	-- 	end
	-- 	if nil==v:getNum() then--顺序遍历依次是庄中发白
	-- 		--撵牌动画
	-- 		local lastPokerNum = resultInfo.cardsData[cardsDataIndex].cards[5]
	-- 		local delayRatio = cardsDataIndex-1
	-- 		v:setNum(lastPokerNum)
	-- 		v:updatePeekPoker()
	-- 		delayRatio = ((delayRatio~=0) and delayRatio) or 5-- delayRatio 5 1 2 3 4  依次庄中发白的延迟时间比率
	-- 		cardsDataIndex = cardsDataIndex+1
	-- 		local function playPeekPoker( pokerNode1)
	-- 			pokerNode1:playPeekPoker(function( pokerNode2 )
	-- 				TTEvent:dispatchEvent({name=TTMsgId.PLAY_PEEKANI_END,userData={pos=pokerNode2.notifyPos,notifyResultInfo=resultInfo} })
	-- 			end)
	-- 		end
	-- 		if false==isAni then
	-- 			v:hidePeekPoker()
	-- 			v:showNormal()
	-- 			TTEvent:dispatchEvent({name=TTMsgId.PLAY_PEEKANI_END,userData={pos=v.notifyPos,notifyResultInfo=resultInfo} })
	-- 		else
	-- 			v:runAction( cc.Sequence:create(cc.DelayTime:create( (2*delayRatio-1.5)*ANIMATE_SPEED ), cc.CallFunc:create(playPeekPoker)) )
	-- 		end	
	-- 	end
	-- end
end

function TTPokerManager:clear()
	for k,v in pairs(self.pokerTable) do
		v:stopAllActions()
		v:setPositionX(-500)
		self:freeObject(v)
	end
	self.pokerTable = {}
	if self.Panel_cardStart then
		self.Panel_cardStart:stopAllActions()
	end
end
----------------------------------------------------------------------------------扑克牌对象池-----------------------------------------------------------------------------------
--初始化对象池
function TTPokerManager:initPokerPool()
	TTUtils:Log("初始化对象池")
	self.pokerPoolNodes = {}
	self:asyncCreatePoker()
end
--销毁对象池
function TTPokerManager:destroy()
	TTUtils:Log("扑克对象管理器销毁")
	if self.asyncCreatePokerScheduler then
		scheduler:unscheduleScriptEntry(self.asyncCreatePokerScheduler)
		self.asyncCreatePokerScheduler = nil
	end
	for i,v in ipairs(self.pokerPoolNodes) do
		v:removeFromParent()
	end
	self.pokerPoolNodes =  nil
	self.ttGame_ = nil
	self.pokerTable = nil
	self.Panel_gps = nil
	self.Panel_cardStart = nil
	self.Panel_card_PosTable = nil
	self.Panel_card_PosTable = nil


end
--获取扑克牌对象
function TTPokerManager:getPoker()	
	TTUtils:Log("获取扑克牌对象")
	TTUtils:Log(#self.pokerPoolNodes)
	if #self.pokerPoolNodes==0 then
		TTUtils:Log("需要创建一批扑克牌对象,同步创建扑克牌")
		self:syncCreatePoker()
	end
	local ttPoker = self.pokerPoolNodes[1]
	table.remove(self.pokerPoolNodes,1)
	return ttPoker
end
--异步创建扑克牌
function TTPokerManager:asyncCreatePoker( )
	if self.asyncCreatePokerScheduler then
		return
	end
	self.asyncCreatePokerScheduler = scheduler:scheduleScriptFunc(function( dt )
		if self.asyncCreatePokerScheduler and #self.pokerPoolNodes>=TTConstant.TOTAL_POKER_NUM then	
			scheduler:unscheduleScriptEntry(self.asyncCreatePokerScheduler)
			self.asyncCreatePokerScheduler = nil
		else
			local ttPoker = TTPoker:new()
			ttPoker:setPositionX(-500)
			self.Panel_gps:addChild(ttPoker)
			table.insert(self.pokerPoolNodes, ttPoker)
		end
	end, 0, false)
end
--同步创建扑克牌
function TTPokerManager:syncCreatePoker()
	local ttPoker = TTPoker:new()
	ttPoker:setPositionX(-500)
	self.Panel_gps:addChild(ttPoker)
	table.insert(self.pokerPoolNodes, ttPoker)
	return ttPoker
end
--回收扑克牌对象
function TTPokerManager:freeObject( pTTPoker )
	TTUtils:Log("回收扑克牌对象")
	TTUtils:Log("对象池数量"..tostring(#self.pokerPoolNodes))
	if #self.pokerPoolNodes < TTConstant.TOTAL_POKER_NUM then
		pTTPoker:reset()
		table.insert(self.pokerPoolNodes, pTTPoker)
	else
		TTUtils:Log("需要清空一扑克牌对象池扑克牌对象")
		pTTPoker:removeFromParent()
	end
end


return TTPokerManager

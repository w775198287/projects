--扑克牌管理
local NNUtils = import("..nn.NNUtils")
local NNPokerManager = class("NNPokerManager")
local NNPoker = import("..nn.NNPoker")
local NNEvent = import("..nn.NNEvent")
local NNMsgId = import("..nn.NNMsgId")
local NNConstant = import("..nn.NNConstant")
local ANIMATE_SPEED = 0.8
local scheduler = cc.Director:getInstance():getScheduler()
function NNPokerManager:setNNGameNode(node)	
	self.nnGame_ = node
	self.pokerSpan_ = 57
	self.pokerTable = {}
	self.Panel_gps = self.nnGame_.resourceNode_:getChildByName("Panel_gps")
	self.Panel_cardStart = self.Panel_gps:getChildByName("Panel_cardStart")
end
--发牌
function NNPokerManager:dealPoker(cardsData, isAni, pCb)
	local speed = ANIMATE_SPEED
	local gameStatus = self.nnGame_.gameStatus
	if false==isAni then
		speed = 0		
	else
		isAni = true
	end
	local function xiPaiEnd(node)
		local pokerTableIndex = 1
		local x,y = self.Panel_gps:getChildByName("Panel_cardStart"):getPosition()
		local startPos = cc.p(x,y)
		local defaultLocalZOrder = 1
        for i1,v1 in ipairs(cardsData) do---i1为1-5 五个人的牌信息(依次庄、天、地、玄、黄)
			i1 = i1-1
			local pos = i1
        	local pannekPokerName = string.format("Panel_card%d", pos )
        	local Panel_card = self.Panel_gps:getChildByName(pannekPokerName)
			x,y = Panel_card:getPosition()
        	for j=1,5 do---v2为牌值
        		i2 = j
				v2 = v1.cards[i2]
        		local poker = self.pokerTable[pokerTableIndex]
        		pokerTableIndex = pokerTableIndex+1
				local endPos = cc.p( (i2-3)*self.pokerSpan_+x, y )
				poker:setPosition(startPos)
				local function beroreMove(pokerNode)--发牌动画播出之前
					pokerNode:setLocalZOrder(defaultLocalZOrder)
					defaultLocalZOrder = defaultLocalZOrder+1
					if isAni then
						self.nnGame_:playNNEffect("deal")
					end
				end			
				poker.notifyPos = pos---notifyPos 0 1 2 3 4 庄天地玄黄
				if i1==0 then--庄家最后翻牌
					i1 = 5
				end
				if 25==(i1*i2) then
					poker.isLastDealPoker = true--最后一张牌
				else
					poker.isLastDealPoker = false--最后一张牌
				end
				if i2==5 then--最后一张牌
					local function moveEnd( pokerNode )
						pokerNode:setRotation(0)
						if gameStatus==self.nnGame_.gameStatus then--状态没有改变
							pokerNode:showPeekPoker()
							if pCb and pokerNode.isLastDealPoker then
								self.delayCallDealPokerEnd = scheduler:scheduleScriptFunc(function( dt )
									if self.delayCallDealPokerEnd then			
										scheduler:unscheduleScriptEntry(self.delayCallDealPokerEnd)
										self.delayCallDealPokerEnd = nil
										NNUtils:Log("最后一张牌移动结束 回掉 延迟一帧调用")
										pCb()
									end
								end, 0, false)
							end	
						end											
					end
					poker:runAction( cc.Sequence:create(
						cc.DelayTime:create( (i1*0.2+i2-1)*speed ),
						cc.CallFunc:create(beroreMove),
						cc.Spawn:create(cc.MoveTo:create(0.2*speed, endPos), cc.RotateBy:create(0.2*speed, 90)),
						cc.CallFunc:create(moveEnd)
					))
				else--前面四张牌
					poker:setNum(v2)
					local function flipPokerAni( pokerNode)--牌翻转动画
						if false==isAni then
							pokerNode:showNormal()
						else
							pokerNode:playFlipPoker()
						end
					end
					poker:runAction( cc.Sequence:create(
						cc.DelayTime:create( (i1*0.2+i2-1)*speed ),
						cc.CallFunc:create(beroreMove),
						cc.MoveTo:create(0.2*speed, endPos),
						cc.CallFunc:create(flipPokerAni)
					))
				end	
				poker:showPortraitBack()			
        	end
        end
    end
	self:xipaiAni(xiPaiEnd,isAni)	
end
--洗牌动画
function NNPokerManager:xipaiAni(pCb,isAni)
	local function xiPaiEnd(node)
	    if pCb then
	    	pCb()
	    end
	end
	local xipaiTime = 0.5
	if false==isAni then
		xipaiTime = 0
	end
	local Panel_cardStart = self.Panel_gps:getChildByName("Panel_cardStart")
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
    	poker:runAction(seq)
    	table.insert(self.pokerTable,poker)
	end
	Panel_cardStart:runAction( cc.Sequence:create(cc.DelayTime:create(1.2*xipaiTime),cc.CallFunc:create(xiPaiEnd)))
end

--撵牌动画
function NNPokerManager:peekPokerAni(resultInfo, isAni)
	if table.nums(self.pokerTable)==0 then
		NNUtils:Log("撵牌动画播放失败，没有发牌")
		return
	end
	if NNConstant.GAME_STATUS_KAIPAI~=self.nnGame_.gameStatus then
		NNUtils:Log("撵牌动画播放失败,不在开牌时间")
		return
	end
	resultInfo.isAni = isAni
	local cardsDataIndex = 1
	for i,v in ipairs(self.pokerTable) do
		if cardsDataIndex==6 then
			break
		end
		if nil==v:getNum() then--顺序遍历依次是庄天地玄黄
			--撵牌动画
			local lastPokerNum = resultInfo.cardsData[cardsDataIndex].cards[5]
			local delayRatio = cardsDataIndex-1
			v:setNum(lastPokerNum)
			v:updatePeekPoker()
			delayRatio = ((delayRatio~=0) and delayRatio) or 5-- delayRatio 5 1 2 3 4  依次庄天地玄黄的延迟时间比率
			cardsDataIndex = cardsDataIndex+1
			local function playPeekPoker( pokerNode1)
				pokerNode1:playPeekPoker(function( pokerNode2 )
					NNEvent:dispatchEvent({name=NNMsgId.PLAY_PEEKANI_END,userData={pos=pokerNode2.notifyPos,notifyResultInfo=resultInfo} })
				end)
			end
			if false==isAni then
				v:hidePeekPoker()
				v:showNormal()
				NNEvent:dispatchEvent({name=NNMsgId.PLAY_PEEKANI_END,userData={pos=v.notifyPos,notifyResultInfo=resultInfo} })
			else
				v:runAction( cc.Sequence:create(cc.DelayTime:create( (2*delayRatio-1.5)*ANIMATE_SPEED ), cc.CallFunc:create(playPeekPoker)) )
			end	
		end
	end
end

function NNPokerManager:clear()
	for k,v in pairs(self.pokerTable) do
		v:stopAllActions()
		v:setPositionX(-500)
		self:freeObject(v)
	end
	self.pokerTable = {}
	if self.delayCallDealPokerEnd then			
		scheduler:unscheduleScriptEntry(self.delayCallDealPokerEnd)
		self.delayCallDealPokerEnd = nil
	end
	if self.Panel_cardStart then
		self.Panel_cardStart:stopAllActions()
	end
end
----------------------------------------------------------------------------------扑克牌对象池-----------------------------------------------------------------------------------
--初始化对象池
function NNPokerManager:initPokerPool()
	NNUtils:Log("初始化对象池")
	self.pokerPoolNodes = {}
	self:asyncCreatePoker(NNConstant.TOTAL_POKER_NUM)
end
--销毁对象池
function NNPokerManager:destroyPokerPool()
	NNUtils:Log("销毁对象池")
	if self.asyncCreatePokerScheduler then
		scheduler:unscheduleScriptEntry(self.asyncCreatePokerScheduler)
		self.asyncCreatePokerScheduler = nil
	end
	for i,v in ipairs(self.pokerPoolNodes) do
		v:removeFromParent()
	end
	self.pokerPoolNodes = {}
end
--获取扑克牌对象
function NNPokerManager:getPoker()	

	if #self.pokerPoolNodes==0 then
		NNUtils:Log("需要创建一批扑克牌对象,同步创建扑克牌")
		self:syncCreatePoker()
	end
	local nnPoker = self.pokerPoolNodes[1]
	table.remove(self.pokerPoolNodes,1)
	return nnPoker

end
--异步创建扑克牌
function NNPokerManager:asyncCreatePoker( coinNum )
	if self.asyncCreatePokerScheduler then
		return
	end
	self.asyncCreatePokerScheduler = scheduler:scheduleScriptFunc(function( dt )
		local nnPoker = NNPoker:new()
		nnPoker:setPositionX(-500)
		self.Panel_gps:addChild(nnPoker)
		table.insert(self.pokerPoolNodes, nnPoker)
		if self.asyncCreatePokerScheduler and #self.pokerPoolNodes==coinNum then	
			scheduler:unscheduleScriptEntry(self.asyncCreatePokerScheduler)
			self.asyncCreatePokerScheduler = nil
		end
	end, 0, false)
end
--同步创建扑克牌
function NNPokerManager:syncCreatePoker()
	local nnPoker = NNPoker:new()
	nnPoker:setPositionX(-500)
	self.Panel_gps:addChild(nnPoker)
	table.insert(self.pokerPoolNodes, nnPoker)
	return nnPoker
end
--回收扑克牌对象
function NNPokerManager:freeObject( pNNPoker )
	if #self.pokerPoolNodes < NNConstant.TOTAL_POKER_NUM then
		pNNPoker:reset()
		table.insert(self.pokerPoolNodes, pNNPoker)
	else
		pNNPoker:removeFromParent()
	end
end


return NNPokerManager

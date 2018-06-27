local NNViewBase = import("..nn.NNViewBase")
local NNUtils = import("..nn.NNUtils")
local NNPoker = class("NNPoker", NNViewBase)
function NNPoker:onCreate()
	self.winSize_ = cc.Director:getInstance():getWinSize()
	self:setName("NNPoker")
	self.poker_ = cc.Sprite:create()
	--适配
	local phonePlatform = NNUtils:GetPhonePlatform()
    if "Iphone6s"==phonePlatform then--fixed高
        self.pokerScale = 1.6
    elseif "Ipad"==phonePlatform then --fixed宽        
        self.pokerScale = 2	
    end
    self:onNodeEvent("enter")
    self:onNodeEvent("exit")
	self.poker_:setScale(self.pokerScale)   


	self:addChild(self.poker_)
end
function NNPoker:onEnter()
	--翻牌动画
	self.nnFlipPokerNode = cc.CSLoader:createNode("nnFlipPoker.csb")
	self.nnFlipPokerNode:setScale(self.pokerScale/2)
	self.nnFlipPokerNode:setVisible(false)
	self:addChild(self.nnFlipPokerNode)
	self.nnFlipPokerAction = cc.CSLoader:createTimeline("nnFlipPoker.csb")
	self.nnFlipPokerAction:setTimeSpeed(2.5)
	self.nnFlipPokerAction:retain()
	--撵牌动画
	self.nnPeekPokerNode = cc.CSLoader:createNode("nnPeekPoker.csb")
	self.nnPeekPokerNode:setScale(self.pokerScale/2)
    self:addChild(self.nnPeekPokerNode)
    self.nnPeekPokerNode:setVisible(false)
    self.nnPeekPokerAction = cc.CSLoader:createTimeline("nnPeekPoker.csb")
    self.nnPeekPokerAction:retain()
end
function NNPoker:onExit()
	self.nnPeekPokerAction:release()
	self.nnFlipPokerAction:release()
end
function NNPoker:setNum(num)
	if num==nil then
		return
	end
	local spriteFrameName = string.format("nnpoker/poker_%d.png", num)
	local spriteFrame = cc.SpriteFrameCache:getInstance():getSpriteFrame(spriteFrameName)
	self.pokerNormalSpriteFrame_ = spriteFrame;
	self.number = num--牌值
	if spriteFrame then
		self.poker_:setSpriteFrame(spriteFrame)	
	end	
end
function NNPoker:getNum()
	return self.number
end
function NNPoker:reset()
	self.number = nil
	self.pokerNormalSpriteFrame_ = nil
	self.nnPeekPokerNode:stopAllActions()
	self.nnPeekPokerNode:setVisible(false)
end
function NNPoker:showPortraitBack()
	local spriteFrameName = string.format("nnpoker/poker_back_1.png")
	local spriteFrame = cc.SpriteFrameCache:getInstance():getSpriteFrame(spriteFrameName)
	if spriteFrame then
		self:visiblePoker()
		self.poker_:setSpriteFrame(spriteFrame)	
	end
end
function NNPoker:showLandscapeBack()
	local spriteFrameName = string.format("nnpoker/poker_back_2.png")
	local spriteFrame = cc.SpriteFrameCache:getInstance():getSpriteFrame(spriteFrameName)
	if spriteFrame then
		self:visiblePoker()
		self.poker_:setSpriteFrame(spriteFrame)	
	end	
end
function NNPoker:showNormal()
	if self.pokerNormalSpriteFrame_ then
		self:visiblePoker()
		self.poker_:setSpriteFrame(self.pokerNormalSpriteFrame_)	
	end
end
function NNPoker:visiblePoker( )
	self.poker_:setVisible(true)
	self.nnPeekPokerNode:setVisible(false)
	self.nnFlipPokerNode:setVisible(false)
end
--撵牌动画
function NNPoker:playPeekPoker(pCb)
	NNUtils:Log("NNPoker:playFlipPoker 播放撵牌动画")
	if self.number==nil then
		NNUtils:Log("NNPoker:playFlipPoker 播放撵牌动画失败")
		return
	end	
	self:showPeekPoker()
    self.nnPeekPokerAction:setFrameEventCallFunc(function(frame)
    	   self:hidePeekPoker()
    	   self:showNormal()
           local event = frame:getEvent();
           NNUtils:Log(string.format("=========",event));
           if pCb then
           		pCb(self)
           end
   end)
    self.nnPeekPokerAction:gotoFrameAndPlay(0, false)
    self.nnPeekPokerNode:stopAllActions()
    self.nnPeekPokerNode:runAction(self.nnPeekPokerAction)
end
function NNPoker:hidePeekPoker()
	self.nnPeekPokerNode:setVisible(true)
	self.poker_:setVisible(true)
end
function NNPoker:showPeekPoker()
	self.nnPeekPokerAction:gotoFrameAndPause(0)
	self.nnPeekPokerNode:setVisible(true)
    self.poker_:setVisible(false)
	self:updatePeekPoker()
end
function NNPoker:updatePeekPoker()
	if self.number==nil then
		return
	end
	local spriteFrameName = string.format("nnpoker/poker1_%d.png", self.number)
    self.nnPeekPokerNode:getChildByName("pokerFlip"):loadTexture(spriteFrameName,ccui.TextureResType.plistType)
    spriteFrameName = string.format("nnpoker/poker_%d.png", self.number)
    self.nnPeekPokerNode:getChildByName("pokerNormal"):loadTexture(spriteFrameName,ccui.TextureResType.plistType)
end
--翻转牌动画
function NNPoker:playFlipPoker(pCb)
	if self.number==nil then
		return
	end 
	self.nnFlipPokerNode:setVisible(true)
	self.poker_:setVisible(false)
	self.nnFlipPokerAction:setFrameEventCallFunc(function(frame)
	   self:showNormal()
	   self.poker_:setVisible(true)
	   local event = frame:getEvent();
	   NNUtils:Log(string.format("=========",event));
	   self.nnFlipPokerNode:setVisible(false)
	   if pCb then
	   		pCb(self)
	   end
	end)
	self.nnFlipPokerAction:gotoFrameAndPlay(0, false)
	self.nnFlipPokerNode:stopAllActions()
	self.nnFlipPokerNode:runAction(self.nnFlipPokerAction)
end

return NNPoker

local TTViewBase = import("..tt.TTViewBase")
local TTUtils = import("..tt.TTUtils")
local TTPoker = class("TTPoker", TTViewBase)
function TTPoker:onCreate()
	self.winSize_ = cc.Director:getInstance():getWinSize()
	self:setName("TTPoker")
	self.poker_ = cc.Sprite:create()
	--适配
	local phonePlatform = TTUtils:GetPhonePlatform()
    if "Iphone6s"==phonePlatform then
        self.pokerScale = 0.8
    elseif "Ipad"==phonePlatform then        
        self.pokerScale = 1	
    end
    self:onNodeEvent("enter")
    self:onNodeEvent("exit")

	self.poker_:setScale(self.pokerScale)
	self:addChild(self.poker_)
end
function TTPoker:onEnter()
	--翻牌动画
	self.ttFlipPokerNode = cc.CSLoader:createNode("ttFlipPoker.csb")
	self.ttFlipPokerNode:setScale(self.pokerScale/2)
	self.ttFlipPokerNode:setVisible(false)
	self:addChild(self.ttFlipPokerNode)
	self.ttFlipPokerAction = cc.CSLoader:createTimeline("ttFlipPoker.csb")
	self.ttFlipPokerAction:setTimeSpeed(2.5)
	self.ttFlipPokerAction:retain()
	--撵牌动画
	self.ttPeekPokerNode = cc.CSLoader:createNode("ttPeekPoker.csb")
	self.ttPeekPokerNode:setScale(self.pokerScale/2)
    self:addChild(self.ttPeekPokerNode)
    self.ttPeekPokerNode:setVisible(false)
    self.ttPeekPokerAction = cc.CSLoader:createTimeline("ttPeekPoker.csb")
    self.ttPeekPokerAction:retain()
end
function TTPoker:onExit()
	self.ttPeekPokerAction:release()
	self.ttFlipPokerAction:release()
end
function TTPoker:setNum(num)
	if num==nil then
		return
	end
	local spriteFrameName = string.format("ttpoker/poker_%d.png", num)
	local spriteFrame = cc.SpriteFrameCache:getInstance():getSpriteFrame(spriteFrameName)
	self.pokerNormalSpriteFrame_ = spriteFrame;
	self.number = num--牌值
	if spriteFrame then
		self.poker_:setSpriteFrame(spriteFrame)	
	end	
end
function TTPoker:getNum()
	return self.number
end
function TTPoker:reset()
	self.number = nil
	self.pokerNormalSpriteFrame_ = nil
	self:setLocalZOrder(0)
	self:setVisible(true)
	self:setOpacity(255)
	self.ttPeekPokerNode:stopAllActions()
	self.ttPeekPokerNode:setVisible(false)
end
function TTPoker:showPortraitBack()
	local spriteFrameName = string.format("ttpoker/poker_back_1.png")
	local spriteFrame = cc.SpriteFrameCache:getInstance():getSpriteFrame(spriteFrameName)
	if spriteFrame then
		self:visiblePoker()
		self.poker_:setSpriteFrame(spriteFrame)	
	end
end
function TTPoker:showLandscapeBack()
	local spriteFrameName = string.format("ttpoker/poker_back_2.png")
	local spriteFrame = cc.SpriteFrameCache:getInstance():getSpriteFrame(spriteFrameName)
	if spriteFrame then
		self:visiblePoker()
		self.poker_:setSpriteFrame(spriteFrame)	
	end	
end
function TTPoker:showNormal()
	if self.pokerNormalSpriteFrame_ then
		self:visiblePoker()
		self.poker_:setSpriteFrame(self.pokerNormalSpriteFrame_)	
	end
end
function TTPoker:visiblePoker( )
	self:setVisible(true)
	self.poker_:setVisible(true)
	self.ttPeekPokerNode:setVisible(false)
	self.ttFlipPokerNode:setVisible(false)
end
--撵牌动画
function TTPoker:playPeekPoker(pCb)
	TTUtils:Log("TTPoker:playPeekPoker 播放撵牌动画")
	if self.number==nil then
		TTUtils:Log("TTPoker:playPeekPoker 播放撵牌动画失败")
		return
	end	
	self:showPeekPoker()
    self.ttPeekPokerAction:setFrameEventCallFunc(function(frame)
    	   self:hidePeekPoker()
    	   self:showNormal()
           local event = frame:getEvent();
           TTUtils:Log(string.format("=========",event));
           if pCb then
           		pCb(self)
           end
   end)
    self.ttPeekPokerAction:gotoFrameAndPlay(0, false)
    self.ttPeekPokerNode:stopAllActions()
    self.ttPeekPokerNode:runAction(self.ttPeekPokerAction)
end
function TTPoker:hidePeekPoker()
	self.ttPeekPokerNode:setVisible(true)
	self.poker_:setVisible(true)
end
function TTPoker:showPeekPoker()
	self.ttPeekPokerAction:gotoFrameAndPause(0)
	self.ttPeekPokerNode:setVisible(true)
    self.poker_:setVisible(false)
	self:updatePeekPoker()
end
function TTPoker:updatePeekPoker()
	if self.number==nil then
		return
	end
	local spriteFrameName = string.format("ttpoker/poker1_%d.png", self.number)
    self.ttPeekPokerNode:getChildByName("pokerFlip"):loadTexture(spriteFrameName,ccui.TextureResType.plistType)
    spriteFrameName = string.format("ttpoker/poker_%d.png", self.number)
    self.ttPeekPokerNode:getChildByName("pokerNormal"):loadTexture(spriteFrameName,ccui.TextureResType.plistType)
end
--翻转牌动画
function TTPoker:playFlipPoker(pCb)
	if self.number==nil then
		return
	end 
	self.ttFlipPokerNode:setVisible(true)
	self.poker_:setVisible(false)
	self.ttFlipPokerAction:setFrameEventCallFunc(function(frame)
	   self:showNormal()
	   self.poker_:setVisible(true)
	   local event = frame:getEvent();
	   TTUtils:Log(string.format("=========",event));
	   self.ttFlipPokerNode:setVisible(false)
	   if pCb then
	   		pCb(self)
	   end
	end)
	self.ttFlipPokerAction:gotoFrameAndPlay(0, false)
	self.ttFlipPokerNode:stopAllActions()
	self.ttFlipPokerNode:runAction(self.ttFlipPokerAction)
end

return TTPoker

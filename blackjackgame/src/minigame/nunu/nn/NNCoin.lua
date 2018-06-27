local NNViewBase = import("..nn.NNViewBase")
local NNUtils = import("..nn.NNUtils")
local NNGameData = import("..nn.NNGameData")
local NNCoin = class("NNCoin", function()
    return cc.Sprite:create()
end)
function NNCoin:ctor()
    if self.onCreate then self:onCreate() end
end
function NNCoin:onCreate()
	self.winSize_ = cc.Director:getInstance():getWinSize()
	self:setName("NNCoin")
	--适配
	local ratio = 1
	local phonePlatform = NNUtils:GetPhonePlatform()
    if "Iphone6s"==phonePlatform then
        ratio = 1.0
    elseif "Ipad"==phonePlatform then      
        ratio = 1.6	
    end
    self:setScale(ratio)
end

function NNCoin:setNum(num)
	local spriteFrameName = string.format("nnpoker/chip_%d.png", num)
	--local spriteFrame = cc.SpriteFrameCache:getInstance():getSpriteFrame(spriteFrameName)
	self.number = num--牌值
	--if spriteFrame then
		self:setSpriteFrame(spriteFrameName)	
	--end	
end
function NNCoin:setCoinIndex( coinIndex )
	self.coinIndex = coinIndex
	for i=0,4 do
		if coinIndex==i then
			self:setNum(NNGameData.roomInfo.chips[i+1])--lua数组下标从1开始
			return
		end
	end
	NNUtils:Log("NNCoin 设置筹码错误 "..coinIndex)
end
function NNCoin:getCoinIndex()
	return self.coinIndex
end
function NNCoin:getNum()
	return self.number
end
function NNCoin:reset()
	self.coinIndex = nil
	self.number = nil
	self:setVisible(true)
	self:setOpacity(255)
	self:setLocalZOrder(0)
end

return NNCoin

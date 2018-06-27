local TTViewBase = import("..tt.TTViewBase")
local TTUtils = import("..tt.TTUtils")
local TTGameData = import("..tt.TTGameData")
local TTCoin = class("TTCoin", function()
    return cc.Sprite:create()
end)
function TTCoin:ctor()
    if self.onCreate then self:onCreate() end
end
function TTCoin:onCreate()
	self.winSize_ = cc.Director:getInstance():getWinSize()
	self:setName("TTCoin")
	--适配
	local ratio = 1
	local phonePlatform = TTUtils:GetPhonePlatform()
    if "Iphone6s"==phonePlatform then
        ratio = 1.0
    elseif "Ipad"==phonePlatform then       
        ratio = 1.6	
    end
    self:setScale(ratio)
end

function TTCoin:setNum(num)
	local spriteFrameName = string.format("ttpoker/chip_%d.png", num)
	--local spriteFrame = cc.SpriteFrameCache:getInstance():getSpriteFrame(spriteFrameName)
	self.number = num--牌值
	--if spriteFrame then
		self:setSpriteFrame(spriteFrameName)	
	--end	
end
function TTCoin:setCoinIndex( coinIndex )
	self.coinIndex = coinIndex
	for i=0,4 do
		if coinIndex==i then
			self:setNum(TTGameData.roomInfo.chips[i+1])--lua数组下标从1开始
			return
		end
	end
	TTUtils:Log("TTCoin 设置筹码错误 "..coinIndex)
end
function TTCoin:getCoinIndex()
	return self.coinIndex
end
function TTCoin:getNum()
	return self.number
end
function TTCoin:reset()
	self.coinIndex = nil
	self.number = nil
	self:setVisible(true)
	self:setOpacity(255)
	self:setLocalZOrder(0)
end

return TTCoin

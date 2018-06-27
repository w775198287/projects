local TTViewBase = import("..tt.TTViewBase")
local TTUtils = import("..tt.TTUtils")
local TTResult = class("TTResult", TTViewBase)
function TTResult:onCreate()
	self.winSize_ = cc.Director:getInstance():getWinSize()
	self.itemSpan = 3
	self:setName("TTResult")
	local ttResult = cc.CSLoader:createNode("ttResult.csb")
	ttResult:setPosition(cc.p(self.winSize_.width/2,self.winSize_.height/2))
    assert(ttResult, string.format("ViewBase:createResoueceNode() - load resouce node from file \"%s\" failed", ttResult))
    self.ttResult = ttResult;
    self:addChild(ttResult)
    --按钮事件
	TTUtils:setOnViewClickedListener("Button_close",function(view)
		self:removeFromParent()
	end,ttResult) 
	TTUtils:setOnViewClickedListener("Panel_1",function(view)
        self:removeFromParent()
    end,ttResult)
    self:updateMultiRes()
end
function TTResult:initView( resultInfo )
	self:updateCoins(self.ttResult:getChildByName("Image_2_0"):getChildByName("score_boss"), resultInfo.bankerCoinsChg)
	self:updateCoins(self.ttResult:getChildByName("Image_2"):getChildByName("score_my"), resultInfo.coinsChg)

	for i,v in ipairs(resultInfo.cardsData) do
		if i~=1 then--除去庄家
			local scorei = self.ttResult:getChildByName("Image_1"):getChildByName(string.format("score%d", i-2))
			self:updateCoins(scorei:getChildByName("score"), v.winCoins)
		end
	end
end
--更新多语言资源图
function TTResult:updateMultiRes()
    self.ttResult:getChildByName("titleBg"):getChildByName("title"):loadTexture(TTUtils:getMutiRes("ttimg/p0_title0.png"))   
end

function TTResult:updateCoins(textBMFont ,coins)
	if coins>=0 then
		textBMFont:setFntFile("ttimg/numberGreen.fnt")
	else
		textBMFont:setFntFile("ttimg/numberRed.fnt")
	end
	textBMFont:setString(TTUtils:formtNumber(coins))
end

return TTResult

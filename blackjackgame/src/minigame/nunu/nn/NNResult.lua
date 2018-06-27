local NNViewBase = import("..nn.NNViewBase")
local NNUtils = import("..nn.NNUtils")
local NNResult = class("NNResult", NNViewBase)
function NNResult:onCreate()
	self.winSize_ = cc.Director:getInstance():getWinSize()
	self.itemSpan = 3
	self:setName("NNResult")
	local nnResult = cc.CSLoader:createNode("nnResult.csb")
	nnResult:setPosition(cc.p(self.winSize_.width/2,self.winSize_.height/2))
    assert(nnResult, string.format("ViewBase:createResoueceNode() - load resouce node from file \"%s\" failed", nnResult))
    self.nnResult = nnResult;
    self:addChild(nnResult)
    --按钮事件
	NNUtils:setOnViewClickedListener("Button_close",function(view)
		self:removeFromParent()
	end,nnResult) 
	NNUtils:setOnViewClickedListener("Panel_1",function(view)
        self:removeFromParent()
    end,nnResult)
    self:updateMultiRes()
end
function NNResult:initView( resultInfo )
	self:updateCoins(self.nnResult:getChildByName("Image_2_0"):getChildByName("score_boss"), resultInfo.bankerCoinsChg)
	self:updateCoins(self.nnResult:getChildByName("Image_2"):getChildByName("score_my"), resultInfo.coinsChg)
	self:updateNiuCnt(self.nnResult:getChildByName("Image_2_0"):getChildByName("bossPokerType"), resultInfo.cardsData[1].niuCnt)

	for i,v in ipairs(resultInfo.cardsData) do
		if i~=1 then--除去庄家
			local scorei = self.nnResult:getChildByName("Image_1"):getChildByName(string.format("score%d", i-2))
			self:updateNiuCnt(scorei:getChildByName("pokerType"), v.niuCnt)
			self:updateCoins(scorei:getChildByName("score"), v.winCoins)
		end
	end
end
--更新多语言资源图
function NNResult:updateMultiRes()
    self.nnResult:getChildByName("titleBg"):getChildByName("title"):loadTexture(NNUtils:getMutiRes("nnimg/p0_title0.png"))   
end

function NNResult:updateCoins(textBMFont ,coins)
	if coins>=0 then
		textBMFont:setFntFile("nnimg/numberGreen.fnt")
	else
		textBMFont:setFntFile("nnimg/numberRed.fnt")
	end
	textBMFont:setString(NNUtils:formtNumber(coins))
end
function NNResult:updateNiuCnt( imgNode, niuCnt)
	imgNode:loadTexture(NNUtils:getMutiRes(string.format("nnimg/niu%d.png", niuCnt)))
end

return NNResult

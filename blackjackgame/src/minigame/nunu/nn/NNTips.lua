local NNViewBase = import("..nn.NNViewBase")
local NNUtils = import("..nn.NNUtils")
local NNTips = class("NNTips", NNViewBase)
function NNTips:onCreate()
	self.winSize_ = cc.Director:getInstance():getWinSize()
	local nnTips = cc.CSLoader:createNode("nnTips.csb")
	nnTips:setPosition(cc.p(self.winSize_.width/2,self.winSize_.height/2))
    assert(nnTips, string.format("ViewBase:createResoueceNode() - load resouce node from file \"%s\" failed", nnTips))
    self.nnTips = nnTips;
    self:addChild(nnTips)
    --按钮事件
	NNUtils:setOnViewClickedListener("Button_ok",function(view)
		self:okEvent(view)
	end,nnTips)
    NNUtils:setOnViewClickedListener("Button_cancel",function(view)
        self:closeEvent(view)
    end,nnTips)
	NNUtils:setOnViewClickedListener("Button_close",function(view)
		self:closeEvent(view)
	end,nnTips)
    NNUtils:setOnViewClickedListener("Panel_1",function(view)
        self:closeEvent(view)
    end,nnTips)
    self:updateMultiRes()
end
--更新多语言资源图
function NNTips:updateMultiRes()
    NNUtils:findNodeByName("title_tips", self.nnTips):loadTexture(NNUtils:getMutiRes("nnimg/p0_title5.png"))
    NNUtils:findNodeByName("Button_cancel", self.nnTips):loadTextures(NNUtils:getMutiRes("nnimg/btn16.png"), NNUtils:getMutiRes("nnimg/btn16.png"), "")
    NNUtils:findNodeByName("Button_ok", self.nnTips):loadTextures(NNUtils:getMutiRes("nnimg/btn15.png"), NNUtils:getMutiRes("nnimg/btn15.png"), "")    
end

function NNTips:initView(content,pCb)
   self.pCb = pCb
   NNUtils:findNodeByName("content", self.nnTips):setString(content)
end

function NNTips:okEvent(view)
	NNUtils:Log("NNTips:okEvent")
    if self.pCb then
        self.pCb()
    end
    self:removeFromParent()
end
function NNTips:closeEvent(view)
	self:removeFromParent()
end

return NNTips

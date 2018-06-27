local NNViewBase = import("..nn.NNViewBase")
local NNUtils = import("..nn.NNUtils")
local NNHead = import("..nn.NNHead")
local NNGameData = import("..nn.NNGameData")
local NNHelp = class("NNHelp", NNViewBase)
function NNHelp:onCreate()
	self.winSize_ = cc.Director:getInstance():getWinSize()
	self.itemSpan = 3
    self:setName("NNHelp")
	local nnHelp = cc.CSLoader:createNode("nnHelp.csb")
	nnHelp:setPosition(cc.p(self.winSize_.width/2,self.winSize_.height/2))
    assert(nnHelp, string.format("ViewBase:createResoueceNode() - load resouce node from file \"%s\" failed", nnHelp))
    self.nnHelp = nnHelp;
    self:addChild(nnHelp)
    --按钮事件
	NNUtils:setOnViewClickedListener("Button_close",function(view)
		self:closeEvent(view)
	end,nnHelp)
    NNUtils:setOnViewClickedListener("Panel_1",function(view)
        self:closeEvent(view)
    end,nnHelp)
    NNUtils:findNodeByName("Text_version", nnHelp):setString("v"..NNGameData.version)
    self:updateMultiRes()
end
--更新多语言资源图
function NNHelp:updateMultiRes()
	NNUtils:findNodeByName("title_help", self.nnHelp):loadTexture(NNUtils:getMutiRes("nnimg/p0_title4.png"))
	NNUtils:findNodeByName("Image_helpInfo", self.nnHelp):loadTexture(NNUtils:getMutiRes("nnimg/p0_bg13.png"))
end

function NNHelp:closeEvent(view)
	NNUtils:Log("closeEvent")
	self:removeFromParent()
end

return NNHelp

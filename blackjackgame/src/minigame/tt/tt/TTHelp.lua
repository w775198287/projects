local TTViewBase = import("..tt.TTViewBase")
local TTUtils = import("..tt.TTUtils")
local TTHead = import("..tt.TTHead")
local TTGameData = import("..tt.TTGameData")
local TTHelp = class("TTHelp", TTViewBase)
function TTHelp:onCreate()
	self.winSize_ = cc.Director:getInstance():getWinSize()
	self.itemSpan = 3
    self:setName("TTHelp")
	local ttHelp = cc.CSLoader:createNode("ttHelp.csb")
	ttHelp:setPosition(cc.p(self.winSize_.width/2,self.winSize_.height/2))
    assert(ttHelp, string.format("ViewBase:createResoueceNode() - load resouce node from file \"%s\" failed", ttHelp))
    self.ttHelp = ttHelp;
    self:addChild(ttHelp)
    --按钮事件
	TTUtils:setOnViewClickedListener("Button_close",function(view)
		self:closeEvent(view)
	end,ttHelp)
    TTUtils:setOnViewClickedListener("Panel_1",function(view)
        self:closeEvent(view)
    end,ttHelp)
    TTUtils:findNodeByName("Text_version", ttHelp):setString("v"..TTGameData.version)
    self:updateMultiRes()
end
--更新多语言资源图
function TTHelp:updateMultiRes()
	TTUtils:findNodeByName("title_help", self.ttHelp):loadTexture(TTUtils:getMutiRes("ttimg/p0_title4.png"))
	TTUtils:findNodeByName("Image_helpInfo", self.ttHelp):loadTexture(TTUtils:getMutiRes("ttimg/p0_bg13.png"))
end

function TTHelp:closeEvent(view)
	TTUtils:Log("closeEvent")
	self:removeFromParent()
end

return TTHelp

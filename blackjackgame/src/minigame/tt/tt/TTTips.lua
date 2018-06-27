local TTViewBase = import("..tt.TTViewBase")
local TTUtils = import("..tt.TTUtils")
local TTTips = class("TTTips", TTViewBase)
function TTTips:onCreate()
	self.winSize_ = cc.Director:getInstance():getWinSize()
	local ttTips = cc.CSLoader:createNode("ttTips.csb")
	ttTips:setPosition(cc.p(self.winSize_.width/2,self.winSize_.height/2))
    assert(ttTips, string.format("ViewBase:createResoueceNode() - load resouce node from file \"%s\" failed", ttTips))
    self.ttTips = ttTips;
    self:addChild(ttTips)
    --按钮事件
	TTUtils:setOnViewClickedListener("Button_ok",function(view)
		self:okEvent(view)
	end,ttTips)
    TTUtils:setOnViewClickedListener("Button_cancel",function(view)
        self:closeEvent(view)
    end,ttTips)
	TTUtils:setOnViewClickedListener("Button_close",function(view)
		self:closeEvent(view)
	end,ttTips)
    TTUtils:setOnViewClickedListener("Panel_1",function(view)
        self:closeEvent(view)
    end,ttTips)
    self:updateMultiRes()
end
--更新多语言资源图
function TTTips:updateMultiRes()
    TTUtils:findNodeByName("title_tips", self.ttTips):loadTexture(TTUtils:getMutiRes("ttimg/p0_title5.png"))
    TTUtils:findNodeByName("Button_cancel", self.ttTips):loadTextures(TTUtils:getMutiRes("ttimg/btn16.png"), TTUtils:getMutiRes("ttimg/btn16.png"), "")
    TTUtils:findNodeByName("Button_ok", self.ttTips):loadTextures(TTUtils:getMutiRes("ttimg/btn15.png"), TTUtils:getMutiRes("ttimg/btn15.png"), "")    
end

function TTTips:initView(content,pCb)
   self.pCb = pCb
   TTUtils:findNodeByName("content", self.ttTips):setString(content)
end

function TTTips:okEvent(view)
	TTUtils:Log("TTTips:okEvent")
    if self.pCb then
        self.pCb()
    end
    self:removeFromParent()
end
function TTTips:closeEvent(view)
	self:removeFromParent()
end

return TTTips

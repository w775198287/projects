local TTViewBase = import("..tt.TTViewBase")
local TTUtils = import("..tt.TTUtils")
local TTTrend = class("TTTrend", TTViewBase)
function TTTrend:onCreate()
	self.winSize_ = cc.Director:getInstance():getWinSize()
	self.itemSpan = 3
    self:setName("TTTrend")
	local ttTrend = cc.CSLoader:createNode("ttTrend.csb")
	ttTrend:setPosition(cc.p(self.winSize_.width/2,self.winSize_.height/2))
    assert(ttTrend, string.format("ViewBase:createResoueceNode() - load resouce node from file \"%s\" failed", ttTrend))
    self.ttTrend = ttTrend;
    self:addChild(ttTrend)
    --按钮事件
	TTUtils:setOnViewClickedListener("Button_close",function(view)
		self:removeFromParent()
	end,ttTrend)
    TTUtils:setOnViewClickedListener("Panel_1",function(view)
        self:removeFromParent()
    end,ttTrend)
    self:updateMultiRes()
end
function TTTrend:initView( userData )
    --winHistory-[[1闲家胜,-1闲家负],[]...]}
    for i=1,10 do
        for j=1,3 do--中发白
            local name = ""
            if j==1 then
                name = "t"
            elseif j==2 then
                name = "d"
            elseif j==3 then
                name = "x"
            end
            name = name..(i-1)
            local imgNode = self.ttTrend:getChildByName("bg_0"):getChildByName(name)
            if imgNode then
                local posWinLose = userData.winHistory[i]
                local score = nil
                if posWinLose then
                    score = userData.winHistory[i][j]
                end
                if score~=nil then
                    imgNode:setVisible(true)
                    if score==1 then
                        self:loadTexture(imgNode,true)
                    else
                        self:loadTexture(imgNode,false)
                    end                    
                else
                    imgNode:setVisible(false)
                end
            end
        end
    end
end
--更新多语言资源图
function TTTrend:updateMultiRes()
    TTUtils:findNodeByName("title", self.ttTrend):loadTexture(TTUtils:getMutiRes("ttimg/p0_title2.png"))
    for i=0,2 do
        local texturesName = TTUtils:getMutiRes("ttimg/p0_bg"..(i+5) )
        TTUtils:findNodeByName("Image_pos"..i, self.ttTrend):loadTexture(texturesName)
    end
end

function TTTrend:loadTexture(imgNode,isWin)
    if isWin==true then
        imgNode:loadTexture(TTUtils:getMutiRes("ttimg/p0_icon1.png"))
    else
        imgNode:loadTexture(TTUtils:getMutiRes("ttimg/p0_icon0.png"))
    end
end
return TTTrend

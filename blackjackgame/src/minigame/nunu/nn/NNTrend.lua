local NNViewBase = import("..nn.NNViewBase")
local NNUtils = import("..nn.NNUtils")
local NNTrend = class("NNTrend", NNViewBase)
function NNTrend:onCreate()
	self.winSize_ = cc.Director:getInstance():getWinSize()
	self.itemSpan = 3
    self:setName("NNTrend")
	local nnTrend = cc.CSLoader:createNode("nnTrend.csb")
	nnTrend:setPosition(cc.p(self.winSize_.width/2,self.winSize_.height/2))
    assert(nnTrend, string.format("ViewBase:createResoueceNode() - load resouce node from file \"%s\" failed", nnTrend))
    self.nnTrend = nnTrend;
    self:addChild(nnTrend)
    --按钮事件
	NNUtils:setOnViewClickedListener("Button_close",function(view)
		self:removeFromParent()
	end,nnTrend)
    NNUtils:setOnViewClickedListener("Panel_1",function(view)
        self:removeFromParent()
    end,nnTrend)
    self:updateMultiRes()
end
function NNTrend:initView( userData )
    --winHistory-[[1闲家胜,-1闲家负],[]...]}
    for i=1,10 do
        for j=1,4 do--天地玄黄
            local name = ""
            if j==1 then
                name = "t"
            elseif j==2 then
                name = "d"
            elseif j==3 then
                name = "x"
            elseif j==4 then
                name = "h"
            end
            name = name..(i-1)
            local imgNode = self.nnTrend:getChildByName("bg_0"):getChildByName(name)
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
function NNTrend:updateMultiRes()
    NNUtils:findNodeByName("title", self.nnTrend):loadTexture(NNUtils:getMutiRes("nnimg/p0_title2.png"))
    for i=0,3 do
        local texturesName = NNUtils:getMutiRes("nnimg/p0_bg"..(i+5) )
        NNUtils:findNodeByName("Image_pos"..i, self.nnTrend):loadTexture(texturesName)
    end
end

function NNTrend:loadTexture(imgNode,isWin)
    if isWin==true then
        imgNode:loadTexture(NNUtils:getMutiRes("nnimg/p0_icon1.png"))
    else
        imgNode:loadTexture(NNUtils:getMutiRes("nnimg/p0_icon0.png"))
    end
end
return NNTrend

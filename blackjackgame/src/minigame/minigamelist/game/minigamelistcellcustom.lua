
module(...,package.seeall)
local Local_UiBase = require "minigame.minigamelist.game.minigamelistcell"

function Create(aiData)
    aiData.bHasOwnInit = true
    local selfObj = Local_UiBase.Create(aiData)
    local parents = {_M, Local_UiBase}
    setmetatable( selfObj ,{__index = function(t,k)
        return search(k,parents) end } )
    selfObj.miPagName = "minigamelistcellcustom"
    if nil ~= aiData.cellimg then
        selfObj.cellimg = aiData.cellimg
    end
    selfObj:Init()
    selfObj:setViewSize()

    return selfObj
end

--创建初始化UI
function Init(selfObj)
    My_Lua_log(" file=[minigamelistcellcustom] fun=[init];")

    local PromptNode = nil
    PromptNode = require(G_Fy.MiniGamegLobal:GetMiniConfig("COCOSTUDIO_UI_MINIGAMELISTCELL"))
    -- 在这里要判断本地是否有此文件，没有从server下载（做处理：如弹窗提示，进度提示灯），同时下载完也要做相应的处理：如重新加载此cell

    local callBackProvider = function ( path,node,funcName )
        if node:getName()=="itembg" and funcName =="OnItemButton" then
            local function OnItemButton1(  node,eventType )  
                selfObj:OnItemButton( node, eventType )
            end
            return OnItemButton1
        end
    end 

    selfObj.miPagObj = PromptNode.create(callBackProvider)
    selfObj.miPagObj['root']:retain()

    My_Lua_log("cellimg === "..selfObj.cellimg)
    if nil ~= selfObj.cellimg then
        selfObj.miPagObj["itembg"]:loadTexture(selfObj.cellimg)
    else
        My_Lua_log("cellimg === nil")
    end
end

-- 适配
function setViewSize( selfObj )
    local tSize = selfObj.miPagObj['root']:getContentSize()

    local tPlatform = G_Fy.GamegLobal:GetPhonePlatform()
    local designSize = DesignResolutionSizeList[tPlatform]

    if G_Fy.GamegLobal:GetPhonePlatform() == DESIGNSIZE_PHONE_NAME.IPHONE_4 then
        tSize.width = tSize.width / DesignResolutionSizeList.iphone6s.width * designSize.width
    elseif G_Fy.GamegLobal:GetPhonePlatform() == DESIGNSIZE_PHONE_NAME.IPAD then
        tSize.width = tSize.width / DesignResolutionSizeList.iphone6s.width * designSize.width
    elseif G_Fy.GamegLobal:GetPhonePlatform() == DESIGNSIZE_PHONE_NAME.SUMSUNG_S8 then
        tSize.height = tSize.height / DesignResolutionSizeList.iphone6s.height * designSize.height
    end

    selfObj.miPagObj['root']:setContentSize(tSize)
    selfObj.miPagObj['itembg']:setContentSize(tSize)
    selfObj.miPagObj['itembg']:setPosition(cc.p(tSize.width / 2, tSize.height / 2))
end

function GetRootNode(selfObj)
    return selfObj.miPagObj['root']
end

--刷新数据
function OnOpen(selfObj, miData)
    
end

function OnClose(selfObj)
    Local_UiBase:OnClose()
    --移除
    -- My_Lua_log(" file=[minigamelistcell] fun=[onclose]; remove   ok")
    selfObj.miPagObj['root']:removeFromParentAndCleanup()
end

--真正的退出删除
function OnExit(selfObj)
    -- My_Lua_log(" file=[minigamelistcell] fun=[onexit];")
    selfObj.miPagObj['root']:release()
end

function OnUpdate(selfObj, aiDelTime)
    
end


--endregion

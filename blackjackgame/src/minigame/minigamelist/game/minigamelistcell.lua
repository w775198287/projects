
module(...,package.seeall)
local Local_UiBase = require "comm.uibase"

function Create(aiData)
    local selfObj = Local_UiBase.Create(aiData)
    local parents = {_M, Local_UiBase}
    setmetatable( selfObj ,{__index = function(t,k)
        return search(k,parents) end } )
    selfObj.miPagName = "minigamelistcell"
    selfObj.miPagObj = nil
    selfObj.miZOrder = 201

    selfObj.aiData = {}
    selfObj.aiData = aiData

    selfObj:Init()
    selfObj:setViewSize()

    return selfObj
end

--创建初始化UI
function Init(selfObj)
    My_Lua_log(" file=[minigamelistcell] fun=[init];")

    local PromptNode = nil
    PromptNode = require(G_Fy.MiniGamegLobal:GetMiniConfig("COCOSTUDIO_UI_MINIGAMELISTCELL"))

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
end

function OnItemButton(selfObj, node, eventType)
    My_Lua_log(" file=[minigamelistcell] fun=[OnItemButton];11111")
    -- My_Lua_log("TouchEventType = "..(ccui.TouchEventType.ended).."  eventType = "..eventType)
    if eventType ~= ccui.TouchEventType.ended then
        return
    end
    
    -- local startPos
    -- My_Lua_log("ccui.TouchEventType.ended")
    -- if eventType == 0 then  
    --     -- 加入一些动画效果
    --     -- startPos
    -- elseif eventType == 3 then
    --     if nil == selfObj.aiData.cellgame then

    --     end
        
    --     G_Fy.MiniGamegLobal:setCurNodPag(selfObj.aiData.cellgame)
	
    --     local aiEvent = {}
    --     aiEvent.type = MSG_TYPE_ENUM.MSG_TYPE_ENUM_POPUP_PAG
    --     aiEvent.miPagName = selfObj.aiData.cellgame
    --     aiEvent.miData = {}
    --     selfObj.miEventMgr:Dispatch(aiEvent)
    -- end
    G_Fy.MiniGamegLobal:setCurNodPag(selfObj.aiData.cellgame)
	
    local aiEvent = {}
    aiEvent.type = MSG_TYPE_ENUM.MSG_TYPE_ENUM_POPUP_PAG
    aiEvent.miPagName = selfObj.aiData.cellgame
    aiEvent.miData = {}
    selfObj.miEventMgr:Dispatch(aiEvent)
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

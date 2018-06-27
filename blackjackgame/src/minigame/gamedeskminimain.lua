
module(...,package.seeall)

--
--aiData
--aiData.miNode
--aiData.miGameDesk
--
function Create(aiData)
    local selfObj ={}
    setmetatable( selfObj, { __index = _M } )

    selfObj.miMainFrameObj = nil
    selfObj.miGameDesk = aiData.miGameDesk
    
    
    require "minigame.miniglobaldefine"
    
    -- selfObj:LoadLanguageFile()
    selfObj:Init(aiData)
	return selfObj
end

function Init(selfObj, aiData)
    My_Lua_log(" file=[gamedeskminimain] fun=[Init]; ")
    
    G_Fy.MiniGamegLobal:setCurNodPag("minigamelist")

    local MainFrame = require(G_Fy.MiniGamegLobal:GetMiniConfig("COCOSTUDIO_UI_MAINFRAMEWORK"))

    local callBackProvider = function ( path,node,funcName )
    end  

    selfObj.miMainFrameObj = MainFrame.create(callBackProvider)

    local tPlatform = G_Fy.GamegLobal:GetPhonePlatform()
    local designSize = DesignResolutionSizeList[tPlatform]
    selfObj.miMainFrameObj['root']:setSize(cc.size(designSize.width, designSize.height))
    ccui.Helper:doLayout(selfObj.miMainFrameObj['root'])

    local tSize = selfObj.miMainFrameObj['root']:getSize()

    -- local twidthOff = 0.5 * (tSize.width - DesignResolutionSize6S.width)
    -- selfObj.miMainFrameObj['root']:setPosition({x=twidthOff, y=0})

    local tDesignByHeight = G_Fy.GamegLobal:IsDesignSizeByHeight()
    if tDesignByHeight == true then
        local tWidthOff = 0.5 * (tSize.width - designSize.width)
        selfObj.miMainFrameObj['root']:setPosition({x=tWidthOff, y=0})
    elseif tDesignByHeight == false then
        --local tHeightOff = 0.5 * (tSize.height - DesignResolutionSize6S.height)
        selfObj.miMainFrameObj['root']:setPosition({x=0, y=0})
    end

    aiData.miNode:addChild(selfObj.miMainFrameObj['root'], aiData.miZOrder)

    --现在弹出主页面
    selfObj.miCurPopupPag = nil
    --弹出页面列表
    selfObj.miPopupPagNameList = {}

    --弹出页面列表
    selfObj.miSsystemNotifyPag = nil

    local tGameDeskEventMgr = aiData.miGameDesk:GetEventMgr()

    tGameDeskEventMgr:AddListen( MSG_TYPE_ENUM.MSG_TYPE_ENUM_SCENE_POPUP_PAG, SwitchMainPag, 5, selfObj)
    tGameDeskEventMgr:AddListen( MSG_TYPE_ENUM.MSG_TYPE_ENUM_SCENE_CLOSE_PAG, CloseSwitchMainPag, 5, selfObj)
    tGameDeskEventMgr:AddListen( MSG_TYPE_ENUM.MSG_TYPE_ENUM_POPUP_PAG, PopupPag, 5, selfObj)
    tGameDeskEventMgr:AddListen( MSG_TYPE_ENUM.MSG_TYPE_ENUM_CLOSE_PAG, ClosePag, 5, selfObj)
    -- tGameDeskEventMgr:AddListen( MSG_TYPE_ENUM.MSG_TYPE_ENUM_POPUP_ERROR_PAG, ClosePag, 5, selfObj)
    -- tGameDeskEventMgr:AddListen( MSG_TYPE_ENUM.MSG_TYPE_ENUM_CLOSE_EXIT_ALL_PAG, CloseExitAllPag, 5, selfObj)
    -- tGameDeskEventMgr:AddListen( PUBLIC_MSG_TYPE_ENUM.PUBLIC_MSG_TYPE_ENUM_SHOW_LOADING_PAG, OnLoadingPagVisible, 5, selfObj)


    -- tGameDeskEventMgr:AddListen( PUBLIC_MSG_TYPE_ENUM.PUBLIC_MSG_TYPE_ENUM_PLAYER_RESET_UI_MSG, OnStandResetUi, 5, selfObj)
    -- tGameDeskEventMgr:AddListen( PUBLIC_MSG_TYPE_ENUM.PUBLIC_MSG_TYPE_ENUM_START_SYSTEM_NOTIFY_PAG_MSG, OnStartSsystemNotifyPag, 5, selfObj)

    -- tGameDeskEventMgr:AddListen( PUBLIC_MSG_TYPE_ENUM.PUBLIC_MSG_TYPE_ENUM_TRANSITION_VISIBLE_MSG, OnSetTransition, 5, selfObj)
    -- tGameDeskEventMgr:AddListen( SYSTEM_MSG_TYPE_ENUM.SYSTEM_MSG_TYPE_ENUM_SCENE_POPUP_FRAMEWORK_ZORDER_MSG, OnSetZorder, 5, selfObj)
end

function OnSetZorder(selfObj, aiEvent)
    selfObj.miMainFrameObj['root']:setZOrder(aiEvent.miData.miZOrder)
end

function OnSetTransition(selfObj, aiEvent)
--    selfObj.miMainFrameObj["backnode"]:setVisible(aiEvent.miData.miVisible)

--    selfObj.miMainFrameObj['logoimage']:loadTexture(LOADING_GAME_LOGO_ICON,0)
    
end

--初始化loading界面
function OnLoadingPagVisible(selfObj, aiEvent)
    My_Lua_log(" file=[gamedeskminimain] fun=[OnLoadingPagVisible]; miIsShow=[" .. tostring(aiEvent.miData.miIsShow) .. "]")
    if selfObj.miLoadingPag == nil then
        local LodingPag = require("texaspoker.game.loading.lodingpag")
        local aiData={}
        aiData.miGameDesk = selfObj.miGameDesk
        selfObj.miLoadingPag = LodingPag.Create(aiData)
        selfObj.miLoadingPag:OnOpen()

        local tPlatform = G_Fy.GamegLobal:GetPhonePlatform()
        local designSize = DesignResolutionSizeList[tPlatform]
        local theightOff = 0.5 * designSize.height
        selfObj.miLoadingPag:GetRootNode():setPositionY(theightOff)

        selfObj.miMainFrameObj["lodingnode"]:addChild(selfObj.miLoadingPag:GetRootNode())
        
        selfObj.miLoadingPag:SetVisible(false)
    end
    selfObj.miLoadingPag:SetVisible(aiEvent.miData.miIsShow)
end

function OnStartSsystemNotifyPag(selfObj, aiEvent)
    if selfObj.miSsystemNotifyPag == nil then
        local SystemNotifyPag = require("texaspoker.game.systemnotify.systemnotifypag")
        local aiData = {}
        aiData.miGameDesk = selfObj.miGameDesk
        selfObj.miSsystemNotifyPag = SystemNotifyPag.Create(aiData)

        local tPlatform = G_Fy.GamegLobal:GetPhonePlatform()
        local designSize = DesignResolutionSizeList[tPlatform]
        local theightOff = 0.5 * designSize.height
        selfObj.miSsystemNotifyPag:GetRootNode():setPositionY(theightOff)

        selfObj.miMainFrameObj["lodingnode"]:addChild(selfObj.miSsystemNotifyPag:GetRootNode())
    end
    selfObj.miSsystemNotifyPag:OnStart()
end

function OnStandResetUi(selfObj, aiEvent)

end

--主页面
function SwitchMainPag(selfObj, aiEvent)
    My_Lua_log(" file=[gamedeskminimain] fun=[switchmainpag];")
    local tUiMgr = selfObj.miGameDesk:GetUiMgr()
    if selfObj.miCurPopupPag ~= nil then
        if selfObj.miCurPopupPag:GetPagName() == aiEvent.miPagName then
             return
        end
        tUiMgr:RemoveUi(selfObj.miCurPopupPag:GetPagName())
    end
    local tIsCreate, tPag = tUiMgr:CreateUi(aiEvent.miPagName, aiEvent.miData)
    if tPag ~= nil then
       selfObj.miCurPopupPag = tPag
    else
        My_Lua_log(" file=[game] fun=[switchmainpag]; error no pag")
    end
    if tIsCreate == true and selfObj.miCurPopupPag ~= nil then
        selfObj.miMainFrameObj["mainnode"]:addChild(selfObj.miCurPopupPag:GetRootNode())
    end

end

--关闭主页面
function CloseSwitchMainPag(selfObj, aiEvent)
    My_Lua_log(" file=[gamedeskminimain] fun=[closeswitchmainpag];")
    local tUiMgr = selfObj.miGameDesk:GetUiMgr()
    if selfObj.miCurPopupPag ~= nil then
        tUiMgr:RemoveUi(selfObj.miCurPopupPag:GetPagName())
        selfObj.miCurPopupPag = nil
    end
    selfObj:CloseAllPopupPag()
end

--关闭所有UI到初始化状态
function CloseExitAllPag(selfObj, aiEvent)
    My_Lua_log(" file=[gamedeskminimain] fun=[closeexitallpag];")
    if selfObj.miCurPopupPag ~= nil then
        selfObj.miCurPopupPag = nil
    end
    local tUiMgr = selfObj.miGameDesk:GetUiMgr()
    tUiMgr:ExitAllUi()

    selfObj.miMainFrameObj['root']:removeFromParentAndCleanup()
end

--关闭所有弹出页面
function CloseAllPopupPag(selfObj)
    My_Lua_log(" file=[gamedeskminimain] fun=[closeallpopuppag];")
    local tUiMgr = selfObj.miGameDesk:GetUiMgr()
    tUiMgr:RemoveAllUi()
end


--弹出界面
function PopupPag(selfObj, aiEvent)
    My_Lua_log(" file=[gamedeskminimain] fun=[popuppag]; pagname=[".. aiEvent.miPagName .. "]")
    if aiEvent.miPagName == "winratecalculatepag" then
        local winratecalculatepag = require("winratecalculate.winratecalculate.winratecalculatepag")
        if nil == winratecalculatepag then
            My_Lua_log("winratecalculatepag == nil...")
        end
        local pWinratecalculateNode = winratecalculatepag.Create()
        local VisibleSize = cc.Director:getInstance():getVisibleSize()
        pWinratecalculateNode:GetRootNode():setPosition(cc.p(0, VisibleSize.height/2))
        selfObj.miMainFrameObj["popnode"]:addChild(pWinratecalculateNode:GetRootNode(), 100)
        return
    end
    local tUiMgr = selfObj.miGameDesk:GetUiMgr()
    aiEvent.miData.miGameDesk = selfObj.miGameDesk
    local tIsCreate, tPag = tUiMgr:CreateUi(aiEvent.miPagName, aiEvent.miData)
    if tIsCreate == true and tPag ~= nil then
        selfObj.miMainFrameObj["popnode"]:addChild(tPag:GetRootNode(), tPag.miZOrder)

        --是否需要特效
        if aiEvent.miIsNeedEffect ~= nil then
        --    G_Fy.UiEffectUtils.runPopOutLayerEffect(tPag:GetRootNode())
        end
    end
    if tPag == nil then
       My_Lua_log(" file=[gamedeskminimain] fun=[popuppag]; error no pag")
   end
end

--关闭弹出界面
function ClosePag(selfObj, aiEvent)
    My_Lua_log(" file=[gamedeskminimain] fun=[closepag]; pagname=[".. aiEvent.miPagName .. "]")
    local tUiMgr = selfObj.miGameDesk:GetUiMgr()
    tUiMgr:RemoveUi(aiEvent.miPagName)
end

--弹出提示界面
function PopupErrorPag(selfObj, aiEvent)
    My_Lua_log(" file=[gamedeskminimain] fun=[popuperrorpag];")
end

function LoadLanguageFile( selfObj )
    local tLanguage = G_Fy.GamegLobal:GetCurrentLanguage()
    My_Lua_log("tLanguage = "..tLanguage)
    if tLanguage == 1 then
        require "minigame.cnlanguagedefinemini"
    elseif tLanguage == 2 then
        require "minigame.enlanguagedefinemini"
    elseif tLanguage == 3 then
        require "minigame.cnslanguagedefinemini"
    end
end


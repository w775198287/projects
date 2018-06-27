
module(...,package.seeall)

local Local_GIsCreate = false
local Local_GameObj = {}

local LOCAL_TRANSITION_TAG = 888

local COCOSTUDIO_UI_TRANSITIONNODE = "uilua.hallscene.transitionnode"
local COCOSTUDIO_UI_TRANSITIONNODE_i4 = "uilua.hallscene.transitionnode_i4"
local COCOSTUDIO_UI_TRANSITIONNODE_ipad = "uilua.hallscene.transitionnode_ipad"
local COCOSTUDIO_UI_TRANSITIONNODE_S8 = "uilua.hallscene.transitionnode_s8"

local LOADING_GAME_LOGO_ICON_CN = "game/game_layer/common/transition/transition_logo.png"
local LOADING_GAME_LOGO_ICON_CNS = "game/game_layer/common/transition/transition_logo_fanti.png"
local LOADING_GAME_LOGO_ICON_EN = "game/game_layer/common/transition/transition_logo_e.png"

local LOCAL_LUAERROR_NODE = "uilua.hallscene.luaerrornode"

function Instance()
	if Local_GIsCreate == true then
		return Local_GameObj
	end
	setmetatable(Local_GameObj, {__index = _M})
	Local_GIsCreate = true
    Local_GameObj.miMainFrameObj = nil
    Local_GameObj.miTransitionPag = nil
    Local_GameObj.miMultiDeskScenePag = nil
    Local_GameObj:Init()
	return Local_GameObj
end

function Init(selfObj)
    My_Lua_log(" file=[game] fun=[Init]; ")
    selfObj.miScene = cc.Scene:create()

    --selfObj:CreateTrasitionNode()

    local aiData = {}
    aiData.miParentNode = selfObj.miScene
    local MultiDeskScenePag = require("hallscene.multideskscenepag")
    Local_GameObj.miMultiDeskScenePag = MultiDeskScenePag.Create(aiData)

    --selfObj.miEventMgr = G_Fy:GetFyEvent()
    --selfObj.miEventMgr:AddListen( SYSTEM_MSG_TYPE_ENUM.SYSTEM_MSG_TYPE_ENUM_NOTIFY_OPEN_DESK_MSG, OnOpenDesk, 5, selfObj)
end

function OnOpenDesk(selfObj, aiEvent)
    local aiEventPag = {}
    aiEventPag.type = SYSTEM_MSG_TYPE_ENUM.SYSTEM_MSG_TYPE_ENUM_SCENE_POPUP_FRAMEWORK_PAG
    aiEventPag.miData = {}
    --aiEventPag.miData.miNode = GameMain.Instance():GetScene()
    --aiEventPag.miData.miZOrder = selfObj.miZOrder
    --aiEventPag.miData.miZOrder = aiEvent.miData.miZOrder
    aiEvent.miData.miGameDesk:GetEventMgr():Dispatch(aiEventPag) 
end

function CreateTrasitionNode(selfObj)
    local app = cc.Application:getInstance()
    local target = app:getTargetPlatform()
    if target == cc.PLATFORM_OS_ANDROID then
        
        My_Lua_log(" file=[game] fun=[Init]; create...")
        local TransitionNode = nil
        if G_Fy.GamegLobal:GetPhonePlatform() == DESIGNSIZE_PHONE_NAME.IPHONE_4 then
            TransitionNode = require(COCOSTUDIO_UI_TRANSITIONNODE_i4)
        elseif G_Fy.GamegLobal:GetPhonePlatform() == DESIGNSIZE_PHONE_NAME.IPHONE_6S then
            TransitionNode = require(COCOSTUDIO_UI_TRANSITIONNODE)
        elseif G_Fy.GamegLobal:GetPhonePlatform() == DESIGNSIZE_PHONE_NAME.SUMSUNG_S8 then
            TransitionNode = require(COCOSTUDIO_UI_TRANSITIONNODE_S8)
        elseif G_Fy.GamegLobal:GetPhonePlatform() == DESIGNSIZE_PHONE_NAME.IPAD then
            TransitionNode = require(COCOSTUDIO_UI_TRANSITIONNODE_ipad)
        end

        local callBackProvider = function ( path,node,funcName )
        end  
        selfObj.miTransitionPag = TransitionNode.create(callBackProvider)
        selfObj.miScene:addChild(selfObj.miTransitionPag['root'],0)        
        selfObj:SetTransitionLanguage()
    end
end

function SetTransitionLanguage(selfObj, aiLanguge)    
    local app = cc.Application:getInstance()
    local target = app:getTargetPlatform()
    if target == cc.PLATFORM_OS_ANDROID then
	    if selfObj.miTransitionPag ~= nil then
            local tLogoIcon = LOADING_GAME_LOGO_ICON_CN
            if aiLanguge == LANGUAGE_TYPE.G_LANGUAGE_CHINESE_CN then
                tLogoIcon = LOADING_GAME_LOGO_ICON_CN
            elseif aiLanguge == LANGUAGE_TYPE.G_LANGUAGE_CHINESE_CNS then
                tLogoIcon = LOADING_GAME_LOGO_ICON_CNS
            elseif aiLanguge == LANGUAGE_TYPE.G_LANGUAGE_ENGLISH or 
               aiLanguge == LANGUAGE_TYPE.G_LANGUAGE_JAPANESE then
                tLogoIcon = LOADING_GAME_LOGO_ICON_EN
            end
	        My_Lua_log(" file=[game] fun=[SetTransitionLanguage]; =="..tLogoIcon)
	        selfObj.miTransitionPag['logoimage']:loadTexture(tLogoIcon,0)
	    end
	end
end

function SetTransitionVisible(selfObj,aiVisible)    
	local app = cc.Application:getInstance()
    local target = app:getTargetPlatform()
    if target == cc.PLATFORM_OS_ANDROID then
		if selfObj.miTransitionPag ~= nil then
	    	selfObj.miTransitionPag['root']:setVisible(aiVisible)
	    end
	end
end


function GetScene(selfObj)
    return selfObj.miScene
end



--lua error报错提示节点
function CreateLuaErrorNode(selfObj, aiErrorMsg)
    My_Lua_log(" file=[game] fun=[CreateLuaErrorNode]; ")
    local ErrorNode = require(LOCAL_LUAERROR_NODE)
    local callBackProvider = function ( path,node,funcName )
    end  
    local LuaErrorPag = ErrorNode.create(callBackProvider)
    selfObj.miScene:addChild(LuaErrorPag['root'],10000)

    local tVisibleSize =cc.Director:getInstance():getOpenGLView():getVisibleSize()
    local tPlatform = G_Fy.GamegLobal:GetPhonePlatform()
    local designSize = DesignResolutionSizeList[tPlatform]
    if tVisibleSize.width > designSize.width then
        tVisibleSize.width = designSize.width
    end
    if tVisibleSize.height > designSize.height then
        tVisibleSize.height = designSize.height
    end
    LuaErrorPag['tipsstr']:setString(aiErrorMsg)
    LuaErrorPag['root']:setPosition(cc.p(tVisibleSize.width/2, tVisibleSize.height/2))
end

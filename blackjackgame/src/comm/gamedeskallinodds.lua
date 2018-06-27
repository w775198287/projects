--region NewFile_1.lua
--Author : chgq1023
--Date   : 2016/12/29
--此文件由[BabeLua]插件自动生成

module(...,package.seeall)
local Local_DeskBase = require "comm.gamedeskbase"

function Create(aiData)
    local selfObj = Local_DeskBase.Create(aiData)
    local parents = {_M, Local_DeskBase}
	setmetatable( selfObj ,{__index = function(t,k)
		return search(k,parents) end } )

    selfObj:Init(aiData)
    return selfObj
end

function Init(selfObj, aiData)
    selfObj.miGameRoomId = 0

    local aiData={}
    aiData.miGameDesk = selfObj

    selfObj.miGameMiniType = 0

    selfObj.miSocket = nil

    --房间数据数据
    GameRoom = require("comm.gameroommini")
    selfObj.miGameRoom = GameRoom.Create(aiData)

    --UI数据
    EventMgr = require("comm.eventmgr")
    selfObj.miEventMgr = EventMgr.Create(aiData)

    --事件数据
    UiMgr = require("comm.uimgrallinodds")
    selfObj.miUiMgr = UiMgr.Create(aiData)

    --主UI窗口
    selfObj.miGameDeskMain = nil

    selfObj.miEventMgr:AddListen( SYSTEM_MSG_TYPE_ENUM.SYSTEM_MSG_TYPE_ENUM_SCENE_POPUP_FRAMEWORK_PAG, OnFrameworkPag, 5, selfObj)
end

function SetGameMiniType(selfObj, aiGameMiniType)
    selfObj.miGameMiniType = aiGameMiniType
end

function GetGameMiniType(selfObj)
    return selfObj.miGameMiniType
end

function SetMiSocket( selfObj, aiSocket )
    selfObj.miSocket = aiSocket
end

function GetMiSocket( selfObj )
    return selfObj.miSocket
end


function OnFrameworkPag(selfObj, aiEvent)
    My_Lua_log(" file=[gamedeskmini] fun=[onframeworkpag]; ")

    local aiData = {}
    aiData.miNode = aiEvent.miData.miNode
    aiData.miGameDesk = selfObj
    aiData.miZOrder = aiEvent.miData.miZOrder

    --房间数据数据
    GameDeskMain = require("winratecalculate.winratecalculate.gamedeskallinodds")
    selfObj.miGameDeskMain = GameDeskMain.Create(aiData)

    --    --弹出主界面
    local aiEvent = {}
    aiEvent.type = MSG_TYPE_ENUM.MSG_TYPE_ENUM_SCENE_POPUP_PAG
    --    aiEvent.miPagName = "minigamemainscenepag"
    aiEvent.miPagName = "allinoddsgame"
    aiEvent.miData = {}
    selfObj.miEventMgr:Dispatch(aiEvent)
end

function OnExit(selfObj)
    local aiEvent = {}
    aiEvent.type = MSG_TYPE_ENUM.MSG_TYPE_ENUM_CLOSE_EXIT_ALL_PAG
    aiEvent.miData = {}
    selfObj.miEventMgr:Dispatch(aiEvent)

    Local_DeskBase.OnExit(selfObj)
end

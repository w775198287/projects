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

    selfObj:Init()
    return selfObj
end

function Init(selfObj)
    selfObj.miGameRoomId = 0

    local aiData={}
    aiData.miGameDesk = selfObj

    --房间数据数据
    GameRoom = require("comm.gameroom")
    selfObj.miGameRoom = GameRoom.Create()

    --UI数据
    EventMgr = require("comm.eventmgr")
    selfObj.miEventMgr = EventMgr.Create(aiData)

    --事件数据
    UiMgr = require("comm.uimgr")
    selfObj.miUiMgr = UiMgr.Create(aiData)


    --状态机事件管理器
    RoomStateMgr = require("texaspoker.game.roomstate.roomstatemgrnew")
    selfObj.miRoomStateMgr = RoomStateMgr.Create(aiData)

    --主UI窗口
    selfObj.miGameDeskMain = nil

    selfObj.miChildrenCount = 0

    selfObj.miEventMgr:AddListen( SYSTEM_MSG_TYPE_ENUM.SYSTEM_MSG_TYPE_ENUM_SCENE_POPUP_FRAMEWORK_PAG, OnFrameworkPag, 5, selfObj)
    --刷新玩家基础数据
    selfObj.miEventMgr:AddListen( PUBLIC_MSG_TYPE_ENUM.PUBLIC_MSG_TYPE_ENUM_NOTYFY_UPDATE_LOCALUSERINFOLIST_MSG, OnUpdateUserBaseInfo, 5, selfObj)
end


function OnFrameworkPag(selfObj, aiEvent)
    My_Lua_log(" file=[gamedesk] fun=[onframeworkpag]; ")

    local app = cc.Application:getInstance()
    local target = app:getTargetPlatform()
    if target == cc.PLATFORM_OS_ANDROID then
        selfObj.miTransitionCount = 2
    end

    local aiData = {}
    aiData.miNode = aiEvent.miData.miNode
    aiData.miGameDesk = selfObj

    GameDeskMain = require("texaspoker.game.gamedeskmain")
    selfObj.miGameDeskMain = GameDeskMain.Create(aiData)


    local tGameRoomType = selfObj.miGameRoom:GetGameRoomType()
    if tGameRoomType == TexasPokerCommon_pb.GAME_ROOM_SNG then
        --弹出主界面
        local aiEvent1 = {}
        aiEvent1.type = MSG_TYPE_ENUM.MSG_TYPE_ENUM_SCENE_POPUP_PAG
        aiEvent1.miPagName = "sngmainscenepag"
        aiEvent1.miData = {}
        selfObj.miEventMgr:NextDispatch(aiEvent1)

        --弹出主界面上菜单界面
        local aiEvent2 = {}
        aiEvent2.type = MSG_TYPE_ENUM.MSG_TYPE_ENUM_POPUP_PAG
        aiEvent2.miPagName = "mainmenupag"
        aiEvent2.miData = {}
        selfObj.miEventMgr:NextDispatch(aiEvent2)

        --进入房间初始化数据
        local aiEvent3 = {}
        aiEvent3.type = MSG_TYPE_ENUM.MSG_TYPE_ENUM_ENTER_GAME_ROOM
        aiEvent3.miData = {}
        selfObj.miEventMgr:NextDispatch(aiEvent3)

        local aiEvent4 = {}
        aiEvent4.type = MSG_TYPE_ENUM.MSG_TYPE_ENUM_UPDAT_USER_STATE
        aiEvent4.miData = {}
        selfObj.miEventMgr:NextDispatch(aiEvent4)

        --打开Sng买入申请通知界面
        local aiEvent5 = {}
        aiEvent5.type = MSG_TYPE_ENUM.MSG_TYPE_ENUM_POPUP_PAG
        aiEvent5.miPagName = "sngcontrolbuyinmsgpag"
        aiEvent5.miData = {}
        selfObj.miEventMgr:Dispatch(aiEvent5)

        --获取是否有买入消息
        local aiEventPag = {}
        aiEventPag.type = PUBLIC_MSG_TYPE_ENUM.PUBLIC_MSG_TYPE_ENUM_SNG_ALL_BUYIN_CONTROLS_INVITE_MSG
        aiEventPag.miData = {}
        selfObj.miEventMgr:NextDispatch(aiEventPag)

        --弹出弹幕
        local aiBulletEvent = {}
        aiBulletEvent.type = MSG_TYPE_ENUM.MSG_TYPE_ENUM_START_SYSTEM_BULLET_SCREEN_PAG_MSG
        aiBulletEvent.miPagName = "bulletscreenpag"
        aiBulletEvent.miData = {}
        selfObj.miEventMgr:NextDispatch(aiBulletEvent) 

    elseif tGameRoomType == TexasPokerCommon_pb.GAME_ROOM_MTT then
        
        --弹出主界面
        local aiEvent1 = {}
        aiEvent1.type = MSG_TYPE_ENUM.MSG_TYPE_ENUM_SCENE_POPUP_PAG
        aiEvent1.miPagName = "mttmainscenepag"
        aiEvent1.miData = {}
        selfObj.miEventMgr:NextDispatch(aiEvent1)

        --弹出主界面上菜单界面
        local aiEvent2 = {}
        aiEvent2.type = MSG_TYPE_ENUM.MSG_TYPE_ENUM_POPUP_PAG
        aiEvent2.miPagName = "mainmenupag"
        aiEvent2.miData = {}
        selfObj.miEventMgr:NextDispatch(aiEvent2)

        --进入房间初始化数据
        local aiEvent3 = {}
        aiEvent3.type = MSG_TYPE_ENUM.MSG_TYPE_ENUM_ENTER_GAME_ROOM
        aiEvent3.miData = {}
        selfObj.miEventMgr:NextDispatch(aiEvent3)

        local aiEvent4 = {}
        aiEvent4.type = MSG_TYPE_ENUM.MSG_TYPE_ENUM_UPDAT_USER_STATE
        aiEvent4.miData = {}
        selfObj.miEventMgr:NextDispatch(aiEvent4)

    else
        --弹出主界面
        local aiEvent1 = {}
        aiEvent1.type = MSG_TYPE_ENUM.MSG_TYPE_ENUM_SCENE_POPUP_PAG
        aiEvent1.miPagName = "mainscenepag"
        aiEvent1.miData = {}
        selfObj.miEventMgr:NextDispatch(aiEvent1)

        --弹出主界面上菜单界面
        local aiEvent2 = {}
        aiEvent2.type = MSG_TYPE_ENUM.MSG_TYPE_ENUM_POPUP_PAG
        aiEvent2.miPagName = "mainmenupag"
        aiEvent2.miData = {}
        selfObj.miEventMgr:NextDispatch(aiEvent2)

        --进入房间初始化数据
        local aiEvent3 = {}
        aiEvent3.type = MSG_TYPE_ENUM.MSG_TYPE_ENUM_ENTER_GAME_ROOM
        aiEvent3.miData = {}
        selfObj.miEventMgr:NextDispatch(aiEvent3)

        --打开Sng买入申请通知界面
        local aiEvent4 = {}
        aiEvent4.type = MSG_TYPE_ENUM.MSG_TYPE_ENUM_POPUP_PAG
        aiEvent4.miPagName = "sngcontrolbuyinmsgpag"
        aiEvent4.miData = {}
        selfObj.miEventMgr:Dispatch(aiEvent4)

        local aiEvent5 = {}
        aiEvent5.type = MSG_TYPE_ENUM.MSG_TYPE_ENUM_UPDAT_USER_STATE
        aiEvent5.miData = {}
        selfObj.miEventMgr:NextDispatch(aiEvent5)

        --获取是否有买入消息
        local aiEventPag = {}
        aiEventPag.type = PUBLIC_MSG_TYPE_ENUM.PUBLIC_MSG_TYPE_ENUM_SNG_ALL_BUYIN_CONTROLS_INVITE_MSG
        aiEventPag.miData = {}
        selfObj.miEventMgr:NextDispatch(aiEventPag)

        --弹出弹幕
        local aiBulletEvent = {}
        aiBulletEvent.type = MSG_TYPE_ENUM.MSG_TYPE_ENUM_START_SYSTEM_BULLET_SCREEN_PAG_MSG
        aiBulletEvent.miPagName = "bulletscreenpag"
        aiBulletEvent.miData = {}
        selfObj.miEventMgr:NextDispatch(aiBulletEvent)         
    end
    --系统消息滚动窗口
    local aiSystemEvent = {}
    aiSystemEvent.type = PUBLIC_MSG_TYPE_ENUM.PUBLIC_MSG_TYPE_ENUM_START_SYSTEM_NOTIFY_PAG_MSG
    aiSystemEvent.miData = {}
    selfObj.miEventMgr:NextDispatch(aiSystemEvent) 
end

function OnExit(selfObj)
    local aiEvent = {}
    aiEvent.type = MSG_TYPE_ENUM.MSG_TYPE_ENUM_CLOSE_EXIT_ALL_PAG
    aiEvent.miData = {}
    selfObj.miEventMgr:Dispatch(aiEvent)

    Local_DeskBase.OnExit(selfObj)
end

--刷新玩家基础数据
function OnUpdateUserBaseInfo(selfObj, aiEvent)
    
    My_Lua_log(" file=[gamedesk] fun=[OnUpdateUserBaseInfo]; ")

   
end

--重置牌局数据
function ResetGameRoomInfo(selfObj)
    
            
        --end
        My_Lua_log(" file=[fy] fun=[gamedesk]; " .. tostring(tPacke))

    --end 
end
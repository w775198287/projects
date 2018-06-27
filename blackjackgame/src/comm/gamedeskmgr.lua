--region NewFile_1.lua
--Author : chgq1023
--Date   : 2016/12/29
--此文件由[BabeLua]插件自动生成


module(...,package.seeall)

function Create()
    local selfObj ={}
    setmetatable( selfObj, { __index = _M } )

    selfObj.miDeskList = {}
    selfObj.miMttDeskList = {}
    selfObj.miZOrder = 100

    return selfObj
end

--创建一个牌桌
--如果是 德州牌局 
--local aiData={}
--aiData.aiGameRoomId
--aiData.aiGameRoomInfo
--aiData.aiMttGameRoomId
--如果是小游戏
--local aiData={}
--aiData.aiGameMiniType
--aiData.aiMiniTypelist 小游戏开关
--如果是 大菠萝牌局 
--local aiData={}
--aiData.aiGameRoomId
--aiData.aiGameRoomInfo
function CreateGameDesk(selfObj, aiGameType, aiData)
    if aiGameType == GAME_TYPE_ENUM.GAME_TYPE_MINI then
        return selfObj:CreateGameDeskMini(aiData.aiGameMiniType, aiData.aiMiniTypeId)
    end
    return nil
end

--修改MTTGameRoomID对应GameRoomId
function ChangeMTTGameRoomIDSocietyGameRoomId(selfObj, aiMttGameRoomId, aiGameRoomId, aiGameRoomInfo)
    local tGameDesk = nil
    local tOldGameRoomId = selfObj.miMttDeskList[aiMttGameRoomId]
    if tOldGameRoomId ~= nil then
        tGameDesk = selfObj.miDeskList[tOldGameRoomId]
        tGameDesk:SetGameRoomId(aiGameRoomId)
        local tGameRoom = tGameDesk:GetGameRoom()
        tGameRoom:SetGameRoomId(aiGameRoomId)
        tGameRoom:SetGameRoomInfo(aiGameRoomInfo)
        tGameRoom:SetMTTCurTableIndex(0)
        tGameRoom:SetMTTSelfTableIndex(0)
        --tGameRoom:EmptyMTTStandupList()
        --tGameRoom:SetMTTIsAllinOver(true)
        --tGameRoom:SetMTTIsAllinOverForRank(true,nil)
        --tGameRoom:SetMTTIsAllinOverForChangeDesk(true)
        --tGameRoom:SetMTTIsAllinOverForNoDesk(true)

        tGameRoom:EmptyMttDelayDispatch()

        selfObj.miDeskList[tOldGameRoomId] = nil
        selfObj.miDeskList[aiGameRoomId] = tGameDesk
        selfObj.miMttDeskList[aiMttGameRoomId] = aiGameRoomId
        
        --MTT不同牌桌间切换，--刷新弹幕表情按钮
        local aiEventPag = {}
        aiEventPag.type = MSG_TYPE_ENUM.MSG_TYPE_ENUM_NOTIFY_MTT_UPDATE_BULLET_BUTTON_MSG
        aiEventPag.miData = {}
        tGameDesk:GetEventMgr():Dispatch(aiEventPag)
    else
        My_Lua_log(" file=[gamedeskmgr] fun=[ChangeMTTGameRoomID]; tOldGameRoomId no exist   aiGameRoomId="..aiGameRoomId)
    end
    return tGameDesk
end

--function AddGameDesk(selfObj, aiGameDesk)
--    local tGameRoomId = aiGameDesk:GetGameRoomId()
--    local tGameDesk = selfObj.miDeskList[tGameRoomId]
--    if tGameDesk ~= nil then
--        My_Lua_log(" file=[gamedeskmgr] fun=[adddesk];  exist")
--        return
--    end

--    selfObj.miDeskList[tGameRoomId] = aiGameDesk

--    local tGameRoom = aiGameDesk:GetGameRoom()
--    if tGameRoom:GetGameRoomType() == TexasPokerCommon_pb.GAME_ROOM_MTT then
--        selfObj.miDeskList[aiMttGameRoomId] = aiGameRoomId
--    end

--    My_Lua_log(" file=[gamedeskmgr] fun=[adddesk]; aiGameRoomId="..tGameRoomId)
--end

function RemoveGameDesk(selfObj, aiGameRoomId)
    local tGameDesk = selfObj.miDeskList[aiGameRoomId]
    if tGameDesk == nil then
        My_Lua_log(" file=[gamedeskmgr] fun=[removedesk]; no exist   aiGameRoomId="..tostring(aiGameRoomId))
        return
    end
    tGameDesk:OnExit()
    selfObj.miDeskList[aiGameRoomId] = nil

    --如果是MTT牌局需要移除
    --selfObj.miMttDeskList[aiMttGameRoomId] = aiGameRoomId
    for key, value in pairs(selfObj.miMttDeskList) do
        if value == aiGameRoomId then
            selfObj.miMttDeskList[key] = nil
            break
        end
    end

    My_Lua_log(" file=[gamedeskmgr] fun=[removedesk]; aiGameRoomId="..aiGameRoomId)
end

function RemoveALLGameDesk(selfObj)
    for key, value in pairs(selfObj.miDeskList) do
        selfObj:RemoveGameDesk(key)
    end
end

function GetGameDesk(selfObj, aiGameRoomId)
    return selfObj.miDeskList[aiGameRoomId]
end

--通过MTTGameRoomId 获得gamedesk
function GetGameDeskFromMTTGameRoomId(selfObj, aiMTTGameRoomId)
    local tGameRoomId = selfObj.miMttDeskList[aiMTTGameRoomId]
    if tGameRoomId == nil then
        return nil
    end
    local tGameDesk = selfObj.miDeskList[tGameRoomId]
    if tGameDesk == nil then
        return nil
    end
    return tGameDesk
end

function Update(selfObj, aiDelTime)
    for key, value in pairs(selfObj.miDeskList) do
        value:Update(aiDelTime)
    end
end

--发送给所有牌局的消息通知
function SendEventToAllGameDesk(selfObj, aiEvent)
My_Lua_log(" file=[gamedeskmain] fun=[OnSetduozuo]; 3333333333333333333333333 = "..#selfObj.miDeskList)
    for key, value in pairs(selfObj.miDeskList) do
My_Lua_log(" file=[gamedeskmain] fun=[OnSetduozuo]; 3333333333333333333333333")
        value:GetEventMgr():Dispatch(aiEvent)
    end
end

--发送给指定牌局的消息通知
function SendEventToAppointGameDesk(selfObj, aiGameRoomId, aiEvent)
    local tGameDesk = selfObj.miDeskList[aiGameRoomId]
    if tGameDesk ~= nil then
        tGameDesk:GetEventMgr():Dispatch(aiEvent)
    end
end

function GetAllGameDesk(selfObj)
    return selfObj.miDeskList
end


---------------------------------------------------------------
--小游戏
---------------------------------------------------------------

--创建MiniGame牌局
function CreateGameDeskMini(selfObj, aiGameMiniType, aiMiniTypeId)
    My_Lua_log(" file=[gamedeskmgr] fun=[CreateGameDeskMini]; ")
    selfObj.miZOrder = selfObj.miZOrder + 1
    local tGameDesk = selfObj.miDeskList[aiGameMiniType]
    if tGameDesk ~= nil then
        My_Lua_log(" file=[gamedeskmgr] fun=[creategamedeskmini]; exist")

        local tGameRoom = tGameDesk:GetGameRoom()
        local aiEventPag = {}
        aiEventPag.type = SYSTEM_MSG_TYPE_ENUM.SYSTEM_MSG_TYPE_ENUM_SCENE_POPUP_FRAMEWORK_ZORDER_MSG
        aiEventPag.miData = {}
        aiEventPag.miData.miZOrder = selfObj.miZOrder
        tGameDesk:GetEventMgr():Dispatch(aiEventPag)

        return tGameDesk
    end

    My_Lua_log(" file=[gamedeskmgr] fun=[CreateGameDeskMini]; 111")
    GameDesk = require("comm.gamedeskmini")
    My_Lua_log(" file=[gamedeskmgr] fun=[CreateGameDeskMini]; 222")
    tGameDesk = GameDesk.Create()
    My_Lua_log(" file=[gamedeskmgr] fun=[CreateGameDeskMini]; 333")
    tGameDesk:SetGameMiniType(aiGameMiniType)
    tGameDesk:SetGameRoomId(aiGameMiniType)
    local tGameRoom = tGameDesk:GetGameRoom()
    tGameRoom:SetGameRoomId(aiGameMiniType)
    selfObj.miDeskList[aiGameMiniType] = tGameDesk

    local GameMain = require("hallscene.game")
    GameMain.Instance():SetTransitionVisible(false)

    local aiEventPag = {}
    aiEventPag.type = SYSTEM_MSG_TYPE_ENUM.SYSTEM_MSG_TYPE_ENUM_SCENE_POPUP_FRAMEWORK_PAG
    aiEventPag.miData = {}
    aiEventPag.miData.miNode = GameMain.Instance():GetScene()
    aiEventPag.miData.miZOrder = selfObj.miZOrder
    aiEventPag.miData.miGameId = aiMiniTypeId
    tGameDesk:GetEventMgr():Dispatch(aiEventPag)

    

    return tGameDesk
end


function GetGameDeskMini(selfObj, aiGameRoomId)
    return selfObj.miDeskList[aiGameRoomId]
end

---------------------------------------------------------------
--allin胜率计算器
---------------------------------------------------------------

--allin胜率计算器牌局
function CreateGameDeskAllinodds(selfObj, aiGameMiniType)
    selfObj.miZOrder = selfObj.miZOrder + 1
    local tGameDesk = selfObj.miDeskList[aiGameMiniType]
    if tGameDesk ~= nil then
        My_Lua_log(" file=[gamedeskmgr] fun=[CreateGameDeskAllinodds]; exist")

        local tGameRoom = tGameDesk:GetGameRoom()
        local aiEventPag = {}
        aiEventPag.type = SYSTEM_MSG_TYPE_ENUM.SYSTEM_MSG_TYPE_ENUM_SCENE_POPUP_FRAMEWORK_ZORDER_MSG
        aiEventPag.miData = {}
        aiEventPag.miData.miZOrder = selfObj.miZOrder
        tGameDesk:GetEventMgr():Dispatch(aiEventPag)

        return tGameDesk
    end

    GameDesk = require("comm.gamedeskallinodds")
    tGameDesk = GameDesk.Create()
    tGameDesk:SetGameMiniType(aiGameMiniType)
    tGameDesk:SetGameRoomId(aiGameMiniType)
    local tGameRoom = tGameDesk:GetGameRoom()
    tGameRoom:SetGameRoomId(aiGameMiniType)
    selfObj.miDeskList[aiGameMiniType] = tGameDesk

    local GameMain = require("hallscene.game")
    GameMain.Instance():SetTransitionVisible(false)

    local aiEventPag = {}
    aiEventPag.type = SYSTEM_MSG_TYPE_ENUM.SYSTEM_MSG_TYPE_ENUM_SCENE_POPUP_FRAMEWORK_PAG
    aiEventPag.miData = {}
    aiEventPag.miData.miNode = GameMain.Instance():GetScene()
    aiEventPag.miData.miZOrder = selfObj.miZOrder
    tGameDesk:GetEventMgr():Dispatch(aiEventPag)

    My_Lua_log(" file=[gamedeskmgr] fun=[creategamedeskmini]; aiGameRoomId="..aiGameMiniType)
    return tGameDesk
end


function GetGameDeskMini(selfObj, aiGameRoomId)
    return selfObj.miDeskList[aiGameRoomId]
end

---------------------------------------------------------------
--(随便获得一个存在的房间)
function GetCurGameRoomId(selfObj)
    for key, value in pairs(selfObj.miDeskList) do
        return value:GetGameRoomId()
    end
end

--endregion

--是否退出所有牌桌
function GetIsExitAllGameRoom(selfObj)
    if selfObj.miDeskList == nil or #selfObj.miDeskList == 0 then
        return true
    end
    return false
end

--放弃所有牌桌效果数据
function SetDelayFoldData(selfObj)
    for key, value in pairs(selfObj.miDeskList) do
        if value:GetGameRoom().SetDelayFoldData ~= nil then
            value:GetGameRoom():SetDelayFoldData(nil)
        end
    end
end

--放弃所有牌桌效果数据
function EmptyWinOddsDataList(selfObj)
    for key, value in pairs(selfObj.miDeskList) do
        if value:GetGameRoom().EmptyWinOddsDataList ~= nil then
            value:GetGameRoom():EmptyWinOddsDataList()
        end
    end
end

--发送重新获取房间数据
function GetAllGameRoomInfo(selfObj)
    for key, value in pairs(selfObj.miDeskList) do
        value:ResetGameRoomInfo()
    end
end

function ClearAllGameRoomState(selfObj)
    
    for key, value in pairs(selfObj.miDeskList) do
        local tGameRoomStateMgr = value:GetRoomStateMgr()
        if tGameRoomStateMgr then
            tGameRoomStateMgr:ClearGameRoomState()
        end
    end
end

function ClearAllGameRoomStateChangeList(selfObj)
    
    for key, value in pairs(selfObj.miDeskList) do
        local tGameRoomStateMgr = value:GetRoomStateMgr()
        if tGameRoomStateMgr then
            tGameRoomStateMgr:ClearGameRoomStateChangeList()
        end
    end
end

--通知俱乐部买入刷新
function NotifyClubBuyinMsg(selfObj)
    for key, value in pairs(selfObj.miDeskList) do
        
        local tCurGameRoom = value:GetGameRoom()
        local tEventMgr = value:GetEventMgr()
        if tCurGameRoom:GetIsLeagueID() == true then
            --通知俱乐部买入刷新
            local aiEvent = {}
            aiEvent.type = MSG_TYPE_ENUM.MSG_TYPE_ENUM_NOTYFY_CLUB_BUYIN_MSG
            aiEvent.miData = {}
            tEventMgr:Dispatch(aiEvent)
        end
    end
end


function OnGetIsSitDown(selfObj)
    for key, value in pairs(selfObj.miDeskList) do
        if key > 100 then
            local tUserInfo = value:GetGameRoom():GetUserGameInfoNetFromUuid(value:GetGameRoom():GetUuid())
            if tUserInfo == nil then
                return 0
            end
        end
    end

    return 1
end
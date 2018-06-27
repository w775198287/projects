--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

--endregion
module(...,package.seeall)

local ProtocolCenterMiniGame = require("texaspoker.game.net.protocolcenterminigame")
local ProtocolCenterPOFC = require("pofcpoker.game.net.protocolcenterpofc")
local ProtocolCenterTexa = require("texaspoker.game.net.protocolcentertexa")

local Local_GIsCreate = false
local Local_ProtocolCenterObj = {}


--处理时长
local LOCAL_NET_DISPOSE_TIME_LENGTH = 500

function Instance()
    if Local_GIsCreate == true then
        My_Lua_log(" file=[ProtocolCenter] fun=[Instance]; 1111111111")
        return Local_ProtocolCenterObj
    end
    
    My_Lua_log(" file=[ProtocolCenter] fun=[Instance]; 222222222222222")
    setmetatable( Local_ProtocolCenterObj, { __index = _M } )
    Init(Local_ProtocolCenterObj)
    Local_GIsCreate = true
    return Local_ProtocolCenterObj
end

function Init( selfObj )
    My_Lua_log(" file=[ProtocolCenter] fun=[Instance]; 33333333333333333333")
    --注册协议回调
    require("proto.TexasPokerCmd_pb")

    selfObj.miMiniGameProtocenter = ProtocolCenterMiniGame.Instance()
    selfObj.miPOFCProtocenter = ProtocolCenterPOFC.Instance()
    selfObj.miTexasProtocenter = ProtocolCenterTexa.Instance()

    --是否切到后台状态
    selfObj.miIsBackground = true

    --是否启动缓存策略
    selfObj.miIsOpenCache = false
    --协议Package 数据
    selfObj.miCachePackageList = {}

    selfObj.miEventMgr = G_Fy:GetFyEvent()

    selfObj.miEventMgr:AddListen( SYSTEM_MSG_TYPE_ENUM.SYSTEM_MSG_TYPE_ENUM_NOTIFY_APPLICATIONDIDENTERBACKGROUND_MSG, OnApplicationDidEnterBackground, 5, selfObj)
    selfObj.miEventMgr:AddListen( SYSTEM_MSG_TYPE_ENUM.SYSTEM_MSG_TYPE_ENUM_NOTIFY_APPLICATIONDIDENTERFOREGROUND_MSG, OnApplicationWillEnterForeground, 5, selfObj)
end

--切到后台
function OnApplicationDidEnterBackground(selfObj, aiEvent)
    selfObj.miIsBackground = true

    selfObj:RemoveAllPackage()
end

--切到前台
function OnApplicationWillEnterForeground(selfObj, aiEvent)
    selfObj.miIsBackground = false
end

function RemoveAllPackage(selfObj)
    if selfObj.miGameType ~= GAME_TYPE_ENUM.GAME_TYPE_MINI then
        selfObj.miCachePackageList = {}
    end
end

function Update(selfObj, aiDelTime)
    if selfObj.miIsOpenCache == true then
        if #selfObj.miCachePackageList > 0 then
            local tCurMilliTime = G_Fy:GetLocationMilliTime()
            while #selfObj.miCachePackageList > 0 do
                local value = selfObj.miCachePackageList[1]
                table.remove(selfObj.miCachePackageList, 1)
                selfObj:DisposePacket( value )
                local tEndMilliTime = G_Fy:GetLocationMilliTime()
                if tEndMilliTime-tCurMilliTime > LOCAL_NET_DISPOSE_TIME_LENGTH then
                    break
                end            
            end
        end
    end
end

function DisposePacket(selfObj, aiPackage)
    local aiEvent = {}
    aiEvent.type = SYSTEM_MSG_TYPE_ENUM.SYSTEM_MSG_TYPE_ENUM_PROTO_DISTRIBUTE
    aiEvent.miData = {}
    aiEvent.miData.miPackage = aiPackage
    selfObj.miEventMgr:Dispatch(aiEvent)

    My_Lua_log("file=[protocolcenter] fun=[DisposePacket];")

    --selfObj:ColseLoadingPag()
end

function RequestPacket(selfObj, buff)

    -- selfObj.miGameType = G_Fy.GamegLobal:GetGameType()

    -- --My_Lua_log("file=[protocolcenter] fun=[requestpacket]; miGameType="..selfObj.miGameType)

    if selfObj.miIsOpenCache == true then
        require("proto.TexasPokerCommon_pb")
        local msg = TexasPokerCommon_pb.Package()
        msg:ParseFromString(buff)
        table.insert(selfObj.miPackageList, msg)
    else
        require("proto.TexasPokerCommon_pb")
        local msg = TexasPokerCommon_pb.Package()
        msg:ParseFromString(buff)
        selfObj:DisposePacket( msg )
    end
end


-- function HttpRequestPacket(selfObj, aiCmd, buff)
--     if selfObj.miIsOpenGmaeState == false then
--         return
--     end

--     My_Lua_log(" file=[protocolcenter] fun=[httprequestpacket]; aiCmd=[".. aiCmd .. "]")
--     if aiCmd ~= nil then
--         selfObj:HttpProtoCallFun(aiCmd, buff)
--     else
--         My_Lua_log(" file=[protocolcenter] fun=[httprequestpacket]; error packet parse error")
--     end

-- end

-- function HttpProtoCallFun(selfObj, aiCmd, buff)
--     selfObj.miGameType = G_Fy.GamegLobal:GetGameType()
--     My_Lua_log(" file=[protocolcenter] fun=[httpprotocallfun]; miGameType=[" .. selfObj.miGameType .. "]")
--     local tCallFun = selfObj.miHttpProtoPacketCallFun[aiCmd]

--     if tCallFun ~= nil then
--         tCallFun(selfObj, buff)
--     else
--         My_Lua_log(" file=[protocolcenter] fun=[httpprotocallfun]; eCmd=[" .. aiCmd.. "]")
--     end
-- end

function OnKickOutPush(selfObj)
    selfObj:StopGame()

    local aiEvent = {}
    aiEvent.type = SYSTEM_MSG_TYPE_ENUM.SYSTEM_MSG_TYPE_ENUM_SCENE_EXIST_COCOS2DX
    aiEvent.miData = {}
    aiEvent.miData.miType = 0
    aiEvent.miData.miRoomName = ""
    G_Fy:GetFyEvent():NextDispatch(aiEvent)

    --cc.CClientPlatform:sharedClientPlatform():StopGame(0,"")
end

function StartGame(selfObj, aiGameRoomData)
    My_Lua_log(" file=[protocolcenter] fun=[startgame]; ")
    selfObj.miGameType = G_Fy.GamegLobal:GetGameType()
    --保持亮屏
    cc.Device:setKeepScreenOn(true)

    --取消语音
    G_Fy.GamegLobal:EmptyCancelQueue()
    --主动清空下lua内存
    G_Fy.GamegLobal:LuaPurgeCachedData()


    --系统消息
    G_Fy.GamegLobal:EmptyPushSystemMsgList()

    G_Fy.GamegLobal:SetEnableVoice(true)


    --G_Fy.RoomStateMgr:Instance():ClearGameRoomState()
    G_Fy.RoomStateMgr:Instance():ClearGameRoomStateChangeList()



    --cocos清空缓存数据
    G_Fy.GamegLobal:EmptyCocosCachedData()
end

function StartGameEx(selfObj, aiGameRoomData)
 
end

function StopGame(selfObj, aiGameRoomId)
    My_Lua_log(" file=[protocolcenter] fun=[stopgame]; ")

    --移除房间
    local tGameDesk = G_Fy:RemoveGameDesk(aiGameRoomId)

--    --主动清空下lua内存
    G_Fy.GamegLobal:LuaPurgeCachedData()

    --是否开启游戏了
    G_Fy.GamegLobal:SetIsOpenGmaeState(false)
    --是否游戏结束了
    G_Fy.GamegLobal:SetIsOverGmaeState(true)

--    --cocos清空缓存数据
    G_Fy.GamegLobal:EmptyCocosCachedData()
end

--发送获取牌局统计
function SendCSGetBillInfoByRoomID(selfObj, aiGameRoom)
    My_Lua_log(" file=[protocolcenter] fun=[SendCSGetBillInfoByRoomID]; ")
    --获得实时战况数据
    require("proto.TexasPokerHttpBill_pb")
    local tPacke = TexasPokerHttpBill_pb.CSGetBillInfoByRoomID()
    tPacke.uuid = aiGameRoom:GetUuid()
    tPacke.lRoomID = aiGameRoom:GetGameRoomId()
    local tBuff = tPacke:SerializeToString()
    cc.CClientPlatform:sharedClientPlatform():SendHttpPacket(TexasPokerCmd_pb.Cmd_CSGetBillInfoByRoomID, tBuff, #tBuff)
    --获得旁观数据
    require("proto.TexasPoker_pb")
    local tStandbyInfosPacke = TexasPoker_pb.CSGetStandbyInfos()
    tStandbyInfosPacke.uuid = aiGameRoom:GetUuid()
    tStandbyInfosPacke.lRoomID = aiGameRoom:GetGameRoomId()
    local tStandbyInfosBuff = tStandbyInfosPacke:SerializeToString()
    cc.CClientPlatform:sharedClientPlatform():SendPacket(TexasPokerCmd_pb.Cmd_CSGetStandbyInfos, tStandbyInfosBuff, #tStandbyInfosBuff)
end


module(...,package.seeall)

--传参
--data={}
--data.address  --地址
--data.port     --端口
--data.miStateHandler    --网络状态
--data.miDataHandler     --协议回包
--data.miEnCode  --是否加密，默认是不需要加密
function Create(aiData)
	local selfObj = {}
    setmetatable( selfObj, {__index = _M} )  

    selfObj.miSeqNo = 0
    selfObj.miSocket = nil
    if aiData ~= nil then
        selfObj.msAddr = aiData.address
        selfObj.miPort = aiData.port
        aiData.miStateHandler = aiData.miStateHandler
        aiData.miDataHandler = aiData.miDataHandler
    end
    selfObj.miEnCode = nil
    if aiData.miEnCode ~= nil then
        selfObj.miEnCode = aiData.miEnCode
    end

    return selfObj
end

--设置连接地址
function SetConnectAddr(selfObj, asAddr, aiPort)
    selfObj.msAddr = asAddr
    selfObj.miPort = aiPort
    My_Lua_log("file=[minigametcp] fun=[setconnectaddr]; addr=["..selfObj.msAddr .. "] miPort=[" .. selfObj.miPort .."]")
end

--连接
function Connect(selfObj)
    My_Lua_log("file=[minigametcp] fun=[Connect]; ")

    function OnstateHandler(state)
        My_Lua_log("file=[minigametcp] fun=[connect_onstatehandler]; state=["..state .. "]")
       selfObj:OnStateHandler(state)
        if selfObj.miStateHandler ~= nil then
        	selfObj.miStateHandler(state)
        end
    end
    function OndataHandler(buff)
        My_Lua_log("file=[minigametcp] fun=[connect_ondatahandler]; buff len=[".. string.len(buff) .. "]")
        selfObj:OnDataHandler(buff)
        if selfObj.miDataHandler ~= nil then
        	selfObj.miDataHandler(buff)
        end
    end
    if selfObj.miSocket == nil then
        selfObj.miSocket = yo.Socket:new(OnstateHandler, OndataHandler)
    end
    selfObj.miSocket:connect(selfObj.msAddr, selfObj.miPort)
end


function OnStateHandler(selfObj, state)
	My_Lua_log("file=[minigametcp] fun=[OnStateHandler]; state=[".. state .. "]")
	if state == 1 then --链接成功
        My_Lua_log("--链接成功")
        local aiEvent = {}
        aiEvent.type = MSG_TYPE_ENUM.MSG_TYPE_ENUM_MINIGAME_TCP_CONNECTAGAIN
        aiEvent.miData = {}
        G_Fy:SendEventToAllGameDesk(aiEvent)
	elseif state == 3 then --断开链接
        My_Lua_log("--断开链接")
        local aiEvent = {}
        aiEvent.type = MSG_TYPE_ENUM.MSG_TYPE_ENUM_MINIGAME_TCP_DISCONNECT
        aiEvent.miData = {}
        G_Fy:SendEventToAllGameDesk(aiEvent)
	end
end

function OnDataHandler(selfObj, buff)
	G_Fy:RequestPacket(buff)
end

function SendProtocol(selfObj, aiProtoType, aiProtoObj)
	My_Lua_log("file=[minigametcp] fun=[SendProto]; aiProtoType=[".. tonumber(aiProtoType) .. "]")
    
end

function Disconnect(selfObj)
    My_Lua_log("file=[minigametcp] fun=[Disconnect]; count=["..selfObj.miSocket:getReferenceCount() .. "]")
    
    selfObj.miSocket:disconnect()
	selfObj.miSocket:release()
	selfObj.miSocket = nil
end

function TeadeCode(selfObj, aiBuff)
    My_Lua_log("file=[minigametcp] fun=[TeadeCode]; ")

    
end

--     function OnstateHandler(state)
--         My_Lua_log("file=[protocolcenter] fun=[connect_onstatehandler]; state=["..state .. "]")
--         --selfObj:OnStateHandler(state)
--     end
--     function OndataHandler(aiType, buff)
--         My_Lua_log("file=[protocolcenter] fun=[connect_ondatahandler]; buff len=[".. string.len(buff) .. "]")

--         require("proto.TexasPokerCommon_pb")
--         local msg = TexasPokerCommon_pb.Package()
--         msg:ParseFromString(buff)
--         My_Lua_log("file=[protocolcenter] fun=[connect_ondatahandler]; buff len11111=[".. msg.eCmd .. "]")
--         --selfObj:OnDataHandler(aiType, buff)
--     end
--     local miSocket = yo.Socket:new(OnstateHandler, OndataHandler)
--     miSocket:connect("sati2.pokermate.net 

-- ", 9898)
--     --miSocket:release()

--     --发送协议
--     require("proto.TexasPokerCommon_pb")
--     local tPackage = TexasPokerCommon_pb.Package()
--     tPackage.uuid = G_Fy.GamegLobal:GetSelfUuid()

--     local tUserBaseInfoNet = TexasPokerCommon_pb.UserBaseInfoNet()
--     tUserBaseInfoNet.uuid = G_Fy.GamegLobal:GetSelfUuid()
--     tUserBaseInfoNet.eType = 5 --ID_TYPE.ID_TYPE_PHONE
--     tUserBaseInfoNet.strID = tostring(“”)
--     tUserBaseInfoNet.strCover = tostring(“”)
--     --tUserBaseInfoNet.sSmallAlbums = tostring(“”)
--     --tUserBaseInfoNet.sBigAlbums = tostring(“”)

--     local tHeader = TexasPokerCommon_pb.Header()
--     tHeader.shVer = 0
--     tHeader.lCurrTime = 0
--     --tHeader.stUserInfo = tUserBaseInfoNet
--     tHeader.stUserInfo.uuid = G_Fy.GamegLobal:GetSelfUuid()
--     tHeader.stUserInfo.eType = TexasPokerCommon_pb.ID_TYPE_PHONE
--     tHeader.stUserInfo.strID = tostring(“”)
--     tHeader.stUserInfo.strCover = tostring(“”)


--     tPackage.head = tHeader:SerializeToString()

--     --发送进入协议
--     require("proto.TexasPokerRedAndBlack_pb")
--     local tRedAndBlackEnterRoom = TexasPokerRedAndBlack_pb.CSRedAndBlackEnterRoom()
--     tRedAndBlackEnterRoom.lUuid = G_Fy.GamegLobal:GetSelfUuid()

--     tPackage.body = tRedAndBlackEnterRoom:SerializeToString()

--     tPackage.iSeqNo = 1
--     require("proto.TexasPokerCmd_pb")
--     tPackage.eCmd = TexasPokerCmd_pb.Cmd_CSRedAndBlackEnterRoom
--     tPackage.cEncodeType = 0

--     local tPackageBuff = tPackage:SerializeToString()
--     miSocket:putCmd(0, tPackageBuff, #tPackageBuff, 0)
--     miSocket:flush()

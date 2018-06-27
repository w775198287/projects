--region *.lua
--Date
--此文件由[BabeLua]插件自动生成



--endregion
module(...,package.seeall)

function Create()
    local selfObj ={}
    setmetatable( selfObj, { __index = _M } )
    --用户ID
    --selfObj.uuid = 0
    --房间数据
    selfObj.miGameRoomInfo=nil

    --mtt房间数据
    selfObj.miMttGameRoomBaseInfo = nil

    selfObj.miMttBlindLevelInfos = nil
    selfObj.miMttBonusLevelInfos = nil
    selfObj.miMttTableInfos = nil
    selfObj.miMttGameRoomRealtimeInfo = nil
    selfObj.miMttUserInfos = nil

    return selfObj
end

function UpdateGameRoomInfoUserGameInfoNet(selfObj, aiPos, aiData)
    local tPosIndex = aiPos + 1
    --更新现在的数据状态
    if selfObj.miGameRoomInfo ~= nil then
        if selfObj.miGameRoomInfo.vUserGameInfos ~= nil then
            local tUserGameInfo = selfObj.miGameRoomInfo.vUserGameInfos[tPosIndex]
            if tUserGameInfo == nil then
                return
            end
            selfObj.miGameRoomInfo.vUserGameInfos[tPosIndex] = aiData
        end
    end
end

--设置gameroominfo
function SetGameRoomInfo(selfObj, aiData)
    selfObj.miGameRoomInfo = aiData
end

function GetGameRoomInfo(selfObj)
    return selfObj.miGameRoomInfo
end

--获得UUID
function GetUuid(selfObj)
   return cc.CClientPlatform:sharedClientPlatform():GetUuid()
end


--房间ID
function GetGameRoomId(selfObj)
    if selfObj.miGameRoomInfo == nil then
        return 0
    end

    if selfObj:GetGameRoomType() == TexasPokerCommon_pb.GAME_ROOM_SNG then
        local tSNGGameRoomBaseInfo = selfObj:GetSNGGameRoomBaseInfo()
        if tSNGGameRoomBaseInfo ~= nil then
            return tSNGGameRoomBaseInfo.lGameRoomId
        end 
    else 
       local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
       if tGameRoomBaseInfo ~= nil then
           return tGameRoomBaseInfo.lGameRoomId
       end
    end
    return 0
end

--获得牌局类型(1:普通牌局，2:Sng局)
function GetGameRoomType(selfObj)
    if selfObj.miGameRoomInfo ~= nil then
        if selfObj.miGameRoomInfo.eGameRoomType ~= nil then
            return selfObj.miGameRoomInfo.eGameRoomType
        end
    end
    return 1
end

--获得GameHandId
function GetGameHandId(selfObj)
    if selfObj.miGameRoomInfo ~= nil then
        if selfObj.miGameRoomInfo.lGameHandID ~= nil then
            return selfObj.miGameRoomInfo.lGameHandID
        end
    end
    return 0
end

--房间名字
function GetGameRoomName(selfObj)
    if selfObj:GetGameRoomType() == TexasPokerCommon_pb.GAME_ROOM_SNG then
        local tSNGGameRoomBaseInfo = selfObj:GetSNGGameRoomBaseInfo()
        if tSNGGameRoomBaseInfo ~= nil then
            return tSNGGameRoomBaseInfo.strRoomName
        end
    elseif selfObj:GetGameRoomType() == TexasPokerCommon_pb.GAME_ROOM_MTT then
        local tMTTGameRoomBaseInfo = selfObj:GetMTTGameRoomBaseInfo() 
        if tMTTGameRoomBaseInfo ~= nil then
            return tMTTGameRoomBaseInfo.sMTTTitle
        end
    else
        local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
        if tGameRoomBaseInfo ~= nil then
            return tGameRoomBaseInfo.strRoomName
        end
    end
    return ""
end

function SetStarted(selfObj)
    if selfObj:GetGameRoomType() == TexasPokerCommon_pb.GAME_ROOM_SNG then
    else
        local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
        if tGameRoomBaseInfo ~= nil then
            tGameRoomBaseInfo.bStarted = 1
        end
    end
end

function SetStartTime(selfObj, aiStartTime)
    if selfObj:GetGameRoomType() == TexasPokerCommon_pb.GAME_ROOM_SNG then
    else
        local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
        if tGameRoomBaseInfo then
            --My_Lua_log(" file=[player] fun=[GetGameRoomStartTime]; tGameRoomBaseInfo.lStartTime=" .. tGameRoomBaseInfo.lCreateTime)
            tGameRoomBaseInfo.lStartTime = aiStartTime
        end
    end   
end

--牌局开始时间
function GetGameRoomStartTime(selfObj)
--My_Lua_log(" file=[player] fun=[GetGameRoomStartTime]; selfObj:GetGameRoomType()=" .. selfObj:GetGameRoomType())
    if selfObj:GetGameRoomType() == TexasPokerCommon_pb.GAME_ROOM_SNG then
        local tSNGGameRoomBaseInfo = selfObj:GetSNGGameRoomBaseInfo()
        if tSNGGameRoomBaseInfo ~= nil then
            return tSNGGameRoomBaseInfo.lStartTime
        end
    else
        local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
        if tGameRoomBaseInfo then
            --My_Lua_log(" file=[player] fun=[GetGameRoomStartTime]; tGameRoomBaseInfo.lStartTime=" .. tGameRoomBaseInfo.lCreateTime)
            return tGameRoomBaseInfo.lStartTime
        end
    end
    return 0
end

--牌局创建时间
function GetGameRoomCreateTime(selfObj)
    if selfObj:GetGameRoomType() == TexasPokerCommon_pb.GAME_ROOM_SNG then
        local tSNGGameRoomBaseInfo = selfObj:GetSNGGameRoomBaseInfo()
        if tSNGGameRoomBaseInfo ~= nil then
            return tSNGGameRoomBaseInfo.lCreateTime
        end
    else
        local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
        if tGameRoomBaseInfo then
            return tGameRoomBaseInfo.lCreateTime
        end
    end
    return 0
end

--牌局持续时间
function GetGameRoomDuration(selfObj)
    if selfObj:GetGameRoomType() == TexasPokerCommon_pb.GAME_ROOM_SNG then
        --SNG是没有本字段
    else
        local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
        if tGameRoomBaseInfo ~= nil then
            return tGameRoomBaseInfo.lDuration
        end
    end
    return 0
end

--获得房主uuid
function GetRoomCreateUserUuid(selfObj)
    if selfObj:GetGameRoomType() == TexasPokerCommon_pb.GAME_ROOM_SNG then
        local tSNGGameRoomBaseInfo = selfObj:GetSNGGameRoomBaseInfo()
        if tSNGGameRoomBaseInfo ~= nil and tSNGGameRoomBaseInfo.stCreateUserBaseInfo then
            return tSNGGameRoomBaseInfo.stCreateUserBaseInfo.uuid
        end
    else
        local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
        if tGameRoomBaseInfo ~= nil and tGameRoomBaseInfo.stCreateUserBaseInfo then
            return tGameRoomBaseInfo.stCreateUserBaseInfo.uuid
        end
    end
    return -1
end

--获得房间的基本信息
function GetGameRoomBaseInfo(selfObj)
    if selfObj.miGameRoomInfo ~= nil then
        if selfObj.miGameRoomInfo.stGameRoomBaseInfo ~= nil then
            return selfObj.miGameRoomInfo.stGameRoomBaseInfo
        end
    end
    return nil
end

--获得SNG房间的基本信息
function GetSNGGameRoomBaseInfo(selfObj)
    if selfObj.miGameRoomInfo ~= nil then
        if selfObj.miGameRoomInfo.stSNGGameRoomBaseInfo ~= nil then
            return selfObj.miGameRoomInfo.stSNGGameRoomBaseInfo
        end
    end
    return nil
end


--获得房间状态
function GetGameState(selfObj)
    if selfObj.miGameRoomInfo ~= nil then
        return selfObj.miGameRoomInfo.eGameState
    end
    return nil
end

--获得房间是否结束状态
function GetIsRoomGameOverState(selfObj)
    if selfObj.miGameRoomInfo ~= nil then
        if selfObj.miGameRoomInfo.eGameState == TexasPoker_pb.ROOM_GAME_STATE_Over then
            return true
        end
    end
    return false
end

--获得房间小盲注
function GetSmallBlinds(selfObj)
    if selfObj:GetGameRoomType() == TexasPokerCommon_pb.GAME_ROOM_SNG then
        local tSNGGameRoomBaseInfo = selfObj:GetSNGGameRoomBaseInfo()
        if tSNGGameRoomBaseInfo ~= nil then
            return tSNGGameRoomBaseInfo.lSmallBlinds
        end
    else
        local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
        if tGameRoomBaseInfo then
            return tGameRoomBaseInfo.lSmallBlinds
        end
    end
    return 0
end

--获得房间大盲注
function GetBigBlinds(selfObj)
    if selfObj:GetGameRoomType() == TexasPokerCommon_pb.GAME_ROOM_SNG then
        local tSNGGameRoomBaseInfo = selfObj:GetSNGGameRoomBaseInfo()
        if tSNGGameRoomBaseInfo ~= nil then
            return tSNGGameRoomBaseInfo.lBigBlinds
        end
    else
        local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
        if tGameRoomBaseInfo ~= nil then
            return tGameRoomBaseInfo.lBigBlinds
        end
    end
    return 0
end

--获得房间创建状态
function GetCreateRoomType(selfObj)
    if selfObj:GetGameRoomType() == TexasPokerCommon_pb.GAME_ROOM_SNG then
        local tSNGGameRoomBaseInfo = selfObj:GetSNGGameRoomBaseInfo()
        if tSNGGameRoomBaseInfo ~= nil then
            return tSNGGameRoomBaseInfo.eCreateRoomType
        end
    else
        local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
        if tGameRoomBaseInfo then
            return tGameRoomBaseInfo.eCreateRoomType
        end
    end
    return nil
end

--获得邀请码
function GetCryptCode(selfObj)
    local tChatDataMap = cc.CClientPlatform:sharedClientPlatform():GetChatData()
    return tChatDataMap['sCryptCode']
end

--获得财富（德扑币）是字符串
function GetCoin(selfObj)
    --local tChatDataMap = cc.CClientPlatform:sharedClientPlatform():GetChatData()
    --return tChatDataMap['Popularity']

    return G_Fy.GamegLobal:GetCoin()
end

--获得俱乐部名称
function GetClubName(selfObj)
    local tChatDataMap = cc.CClientPlatform:sharedClientPlatform():GetChatData()
    return tChatDataMap['clubName']
end

--获得俱乐部id
function GetClubId(selfObj)
    local tChatDataMap = cc.CClientPlatform:sharedClientPlatform():GetChatData()
    return tChatDataMap['clubId']
end

--获得时间修正值(秒)
function GetTimeDifference(selfObj)
    local tChatDataMap = cc.CClientPlatform:sharedClientPlatform():GetChatData()
    local tInt64TimeDifference = int64.new_signed(tChatDataMap['timeDifference'])
    local tTimeDifference = int64.tonumberint(tInt64TimeDifference/1000)
    return tTimeDifference
end

--获得玩家是否坐下
function GetStateStandby(selfObj, uuid)
    if selfObj.miGameRoomInfo == nil or selfObj.miGameRoomInfo.vUserGameInfos == nil then
        return false
    end
    if uuid == nil then
        uuid = selfObj:GetUuid()
    end
    for idx, value in pairs(selfObj.miGameRoomInfo.vUserGameInfos) do
        if value.stUserInfo ~= nil and value.stUserInfo.uuid == uuid then
            if value.eGameState ~= TexasPoker_pb.USER_GAME_STATE_STANDBY then
                return true
            else
                return false
            end
        end
    end
    return false
end

--获得玩家是否在桌上
function GetIsInCurDesk(selfObj, uuid)
    if selfObj.miGameRoomInfo == nil or selfObj.miGameRoomInfo.vUserGameInfos == nil then
        return false
    end
    if uuid == nil then
        uuid = selfObj:GetUuid()
    end
    for idx, value in pairs(selfObj.miGameRoomInfo.vUserGameInfos) do
        if value.stUserInfo ~= nil and value.stUserInfo.uuid == uuid then
            return true
        end
    end
    return false
end

--获得桌上玩家筹码数量
function GetUserRemainStacks(selfObj)
    if selfObj.miGameRoomInfo == nil or selfObj.miGameRoomInfo.vUserGameInfos == nil then
        return 100000000
    end
    for idx, value in pairs(selfObj.miGameRoomInfo.vUserGameInfos) do
        if value.lRemainStacks ~= nil and value.stUserInfo.uuid == selfObj:GetUuid() then
            return value.lRemainStacks
        end
    end
    return 100000000 
end

function SetBuyinControlRatio(selfObj, aiMin, aiMax)
    if selfObj:GetGameRoomType() == TexasPokerCommon_pb.GAME_ROOM_SNG then
    else
        local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
        if tGameRoomBaseInfo ~= nil then
            tGameRoomBaseInfo.iMaxBuyinRatio = aiMax
            tGameRoomBaseInfo.iMinBuyinRatio = aiMin
        end
    end
end

--牌局是否开始
function GetIsStarted(selfObj)
    if selfObj:GetGameRoomType() == TexasPokerCommon_pb.GAME_ROOM_SNG then
        local tSNGGameRoomBaseInfo = selfObj:GetSNGGameRoomBaseInfo()
        if tSNGGameRoomBaseInfo ~= nil then
            return (tSNGGameRoomBaseInfo.bStarted>0)
        end
    else
        local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
        if tGameRoomBaseInfo ~= nil then
            return (tGameRoomBaseInfo.bStarted>0)
        end
    end
    return false
end

--自己是不是房主
function GetIsCreateUser(selfObj)
    local tCreateUserUuid = selfObj:GetRoomCreateUserUuid()

    if tCreateUserUuid and tCreateUserUuid == selfObj:GetUuid() then
        return true
    end
    return false
end

--获得主池数量
function GetCurrentPots(selfObj, aiGameRoomInfo)
    local tPots = 0
    if aiGameRoomInfo == nil then
        tPots = selfObj:GetCurrentPotsEx()
    else
        tPots = selfObj:GetOtherCurrentPotsEx(aiGameRoomInfo)
    end
    return tPots
end

function GetCurrentPotsEx(selfObj)
    local tPots = 0
    if selfObj.miGameRoomInfo and selfObj.miGameRoomInfo.vCurrentPots then
        for i = 1, #selfObj.miGameRoomInfo.vCurrentPots do
            tPots = tPots + selfObj.miGameRoomInfo.vCurrentPots[i]
        end
    end
    return tPots
end

function GetOtherCurrentPotsEx(selfObj, aiGameRoomInfo)
    local tPots = 0
    if aiGameRoomInfo and aiGameRoomInfo.vCurrentPots then
        for i = 1, #aiGameRoomInfo.vCurrentPots do
            tPots = tPots + aiGameRoomInfo.vCurrentPots[i]
        end
    end
    return tPots
end

--获得对应座位上usergamenet
function GetUserGameInfoNetFromPagPosID(selfObj, aiPos)
    local tListPosID = aiPos + 1
    if selfObj.miGameRoomInfo == nil or selfObj.miGameRoomInfo.vUserGameInfos == nil then
        My_Lua_log("GetUserGameInfoNetFromPagPosID no  GameRoomInfo or UserGameInfos = ")
        return nil
    end
    if tListPosID < 1 or tListPosID > #selfObj.miGameRoomInfo.vUserGameInfos then
        My_Lua_log("GetUserGameInfoNetFromPagPosID error tPosID = " .. tListPosID)
        return nil
    end
    return selfObj.miGameRoomInfo.vUserGameInfos[tListPosID]
end

--根据uuid获得在桌上的位置
function GetUserPosFromUuid(selfObj, aiUuid)
    local tPots = -1
    if selfObj.miGameRoomInfo == nil or selfObj.miGameRoomInfo.vUserGameInfos == nil then
        return tPots
    end
    for idx, value in pairs(selfObj.miGameRoomInfo.vUserGameInfos) do
        if value.stUserInfo ~= nil and value.stUserInfo.uuid == aiUuid then
            tPots = tonumber(idx)
            break
        end
    end
    return tPots-1
end

--根据uuid获得手上的牌
function GetUserCurrentHandsFromUuid(selfObj, aiUuid)
    if selfObj.miGameRoomInfo == nil or selfObj.miGameRoomInfo.vUserGameInfos == nil then
        return nil
    end
    for idx, value in pairs(selfObj.miGameRoomInfo.vUserGameInfos) do
        if value.stUserInfo ~= nil and value.stUserInfo.uuid == aiUuid then
            return value.vCurrentHands
        end
    end
    return nil
end

--获得所有手牌数据
function GetAllUserCurrentHands(selfObj)
    local tCurrentHandsList = {}
    if selfObj.miGameRoomInfo == nil or selfObj.miGameRoomInfo.vUserGameInfos == nil then
        return tCurrentHandsList
    end
    return selfObj:GetAllUserCurrentHandsEx(selfObj.miGameRoomInfo.vUserGameInfos)
end

function GetAllUserCurrentHandsEx(selfObj, aiUserGameInfos)
    local tCurrentHandsList = {}
    if aiUserGameInfos == nil then
        return tCurrentHandsList
    end
    for idx, value in pairs(aiUserGameInfos) do
        if value.stUserInfo ~= nil and value.stUserInfo.uuid > 0 and value.vCurrentHands ~= nil and #value.vCurrentHands >= 2 then
            if value.eGameState == TexasPoker_pb.USER_GAME_STATE_CHECK or
                value.eGameState == TexasPoker_pb.USER_GAME_STATE_CALL or
                value.eGameState == TexasPoker_pb.USER_GAME_STATE_RAISE or
                value.eGameState == TexasPoker_pb.USER_GAME_STATE_ALLIN or
                value.eGameState == TexasPoker_pb.USER_GAME_STATE_READY or
                value.eGameState == TexasPoker_pb.USER_GAME_STATE_BLIND then

                local tDataHands = {}
                tDataHands.miUuid = value.stUserInfo.uuid
                tDataHands.miCurrentHands = value.vCurrentHands

                My_Lua_log(" file=[player] fun=[GetAllUserCurrentHandsEx];  tDataHands.miUuid="..tDataHands.miUuid)
                My_Lua_log(" file=[player] fun=[GetAllUserCurrentHandsEx];  1="..value.vCurrentHands[1])
                My_Lua_log(" file=[player] fun=[GetAllUserCurrentHandsEx];  2="..value.vCurrentHands[2])

                table.insert(tCurrentHandsList, tDataHands)
            end
            --return value.vCurrentHands
        end
    end
    return tCurrentHandsList
end
--获得是否有玩家有效操作过
function EffectiveOperation(selfObj)
    if selfObj.miGameRoomInfo == nil or selfObj.miGameRoomInfo.vUserGameInfos == nil then
        return false
    end
    for idx, value in pairs(selfObj.miGameRoomInfo.vUserGameInfos) do
        if value.stUserInfo ~= nil  then
            if value.stUserInfo.uuid ~= selfObj:GetUuid() then
                if value.eGameState == TexasPoker_pb.USER_GAME_STATE_CHECK or
                value.eGameState == TexasPoker_pb.USER_GAME_STATE_BETTING or
                value.eGameState == TexasPoker_pb.USER_GAME_STATE_CALL or
                value.eGameState == TexasPoker_pb.USER_GAME_STATE_RAISE or
                value.eGameState == TexasPoker_pb.USER_GAME_STATE_ALLIN  then
                    return true
                end
            end
        end
    end
    return false
end

--获得是否有玩家有效操作过
function EffectiveOperationFormUuid(selfObj, aiUuid)
    if selfObj.miGameRoomInfo == nil or selfObj.miGameRoomInfo.vUserGameInfos == nil then
        return false
    end
    for idx, value in pairs(selfObj.miGameRoomInfo.vUserGameInfos) do
        if value.stUserInfo ~= nil  then
            if value.stUserInfo.uuid == aiUuid then
                if value.eGameState == TexasPoker_pb.USER_GAME_STATE_CHECK or
                value.eGameState == TexasPoker_pb.USER_GAME_STATE_CALL or
                value.eGameState == TexasPoker_pb.USER_GAME_STATE_RAISE or
                value.eGameState == TexasPoker_pb.USER_GAME_STATE_ALLIN  then
                    return true
                end         
            end
        end
    end
    return false
end

--获取b-a和c的值和最大下注额
--这里b是最大有效USER_GAME_STATE_RAISE的值，a是b前有效操作玩家，c是最大下注额
function GetMinRaise(selfObj)
    My_Lua_log(" file=[player] fun=[GetMinRaise];  ")
    if selfObj.miGameRoomInfo == nil or selfObj.miGameRoomInfo.vUserGameInfos == nil then
        return nil
    end


    local tPos = selfObj:GetUserPosFromUuid(selfObj:GetUuid())
    if tPos < 0 then
        local tEndData = {}
        tEndData.mib = 0
        tEndData.miba = 0
        tEndData.miMaxBetStacks = 0
        return tEndData
    end
    tPos = tPos + 1

    local tTempPos = tPos - 1
    if tTempPos <= 0 then
        tTempPos = selfObj:GetGameRoomUserMaxNums()
    end
    local tEffectiveOperation = {}
    while tTempPos ~= tPos do
        local tUserGameInfo = selfObj.miGameRoomInfo.vUserGameInfos[tTempPos]
        if tUserGameInfo and tUserGameInfo.stUserInfo and tUserGameInfo.stUserInfo.uuid > 0 then
            if tUserGameInfo.eGameState == TexasPoker_pb.USER_GAME_STATE_CHECK or
                tUserGameInfo.eGameState == TexasPoker_pb.USER_GAME_STATE_CALL or
                tUserGameInfo.eGameState == TexasPoker_pb.USER_GAME_STATE_RAISE or
                tUserGameInfo.eGameState == TexasPoker_pb.USER_GAME_STATE_ALLIN or
                tUserGameInfo.eGameState == TexasPoker_pb.USER_GAME_STATE_BLIND then
                table.insert(tEffectiveOperation, tUserGameInfo)
            end   
        end
        tTempPos = tTempPos - 1
        if tTempPos <= 0 then
            tTempPos = selfObj:GetGameRoomUserMaxNums()
        end
    end

    --把自己添加到末尾
    table.insert(tEffectiveOperation, selfObj.miGameRoomInfo.vUserGameInfos[tPos])
My_Lua_log(" file=[player] fun=[GetMinRaise];  tEffectiveOperation=[" .. #tEffectiveOperation .."]")
    local tEndData = {}
    tEndData.mib = 0
    tEndData.miba = selfObj:GetBigBlinds()
    tEndData.miMaxBetStacks = 0

    for idx = 1, #(tEffectiveOperation) do
        local tUserGameInfo = tEffectiveOperation[idx]
My_Lua_log(" file=[player] fun=[GetMinRaise];  lBetStacks=[" .. tUserGameInfo.lBetStacks .."]")
        if tEndData.miMaxBetStacks < tUserGameInfo.lBetStacks then
            tEndData.miMaxBetStacks = tUserGameInfo.lBetStacks
            tEndData.mib = tUserGameInfo.lBetStacks
        end
        local tNextIdx = idx+1
        if tNextIdx > #(tEffectiveOperation) then
            break
        end
        if  tUserGameInfo.eGameState == TexasPoker_pb.USER_GAME_STATE_RAISE then
            local tNextUserGameInfo = tEffectiveOperation[tNextIdx]
            local tTempBetStacks = tUserGameInfo.lBetStacks - tNextUserGameInfo.lBetStacks
            if tTempBetStacks > tEndData.miba then
                tEndData.miba = tTempBetStacks
            end
        end
    end

    if tEndData.miMaxBetStacks > 0 then
        if tEndData.miMaxBetStacks < selfObj:GetBigBlinds() then
            tEndData.miMaxBetStacks = selfObj:GetBigBlinds()
        end
    end

    for i = 1, selfObj:GetGameRoomUserMaxNums() do
        local tUserGameInfo = selfObj.miGameRoomInfo.vUserGameInfos[i]
        if tUserGameInfo then
            if tEndData.miMaxBetStacks <  tUserGameInfo.lBetStacks then
                tEndData.miMaxBetStacks = tUserGameInfo.lBetStacks
                tEndData.mib = tUserGameInfo.lBetStacks
            end
        end
    end
    return tEndData
end
----------------------------------------------------------------------------------
--新版本规则
--有效加注额
function GetEffectiveRaise(selfObj)
    local tEffectiveRaise = 0
    if selfObj.miGameRoomInfo.lEffectiveRaise ~= nil then
        tEffectiveRaise = selfObj.miGameRoomInfo.lEffectiveRaise
    end
    return tEffectiveRaise
end

--滑竿需要的有效加注额
function GetSlideEffectiveRaise(selfObj)
    local tSlideEffectiveRaise = 0
    if selfObj.miGameRoomInfo.lEffectiveRaise ~= nil then
        tSlideEffectiveRaise = selfObj.miGameRoomInfo.lEffectiveRaise
    end
    
    local tBigBlinds = selfObj:GetBigBlinds()

    if tSlideEffectiveRaise < tBigBlinds then
        tSlideEffectiveRaise = tBigBlinds
    end
    return tSlideEffectiveRaise
end

--是否可以自由操作(true:可以自由操作)
function GetIsFreeRaise(selfObj)
    --如果是PreFlop所有玩家下注没不超过一个大盲，必须一个大盲
    local tGameState = selfObj:GetGameState()
    if tGameState == TexasPoker_pb.ROOM_GAME_STATE_PreFlop then
        local tUserGameInfo = nil
        for idx, value in pairs(selfObj.miGameRoomInfo.vUserGameInfos) do
            if value.stUserInfo ~= nil  then
                if value.stUserInfo.uuid == selfObj:GetUuid() then
                    tUserGameInfo = value
                    break
                end
            end
        end
        if tUserGameInfo ~= nil then
            if tUserGameInfo.eGameRole == TexasPoker_pb.USER_GAME_ROLE_BIG_BLIND then
                if tUserGameInfo.lBetStacks <= selfObj:GetBigBlinds() then
                    return true
                end
            elseif tUserGameInfo.eGameRole == TexasPoker_pb.USER_GAME_ROLE_SMALL_BLIND then
                if tUserGameInfo.lBetStacks <= selfObj:GetSmallBlinds() then
                    return true
                end
            elseif tUserGameInfo.eGameRole == TexasPoker_pb.USER_GAME_ROLE_STRADDLE then
                if tUserGameInfo.lBetStacks <= selfObj:GetBigBlinds() * 2 then
                    return true
                end
            end
        end
    end

    local tMaxBet = selfObj:GetMaxBet()
    if tMaxBet < selfObj:GetBigBlinds() then
        tMaxBet = selfObj:GetBigBlinds()
    end

    local tSelfBet = selfObj:GetSelfBet()
    local tEffectiveRaise = selfObj:GetEffectiveRaise()
My_Lua_log(" file=[player] fun=[GetIsFreeRaise]; tMaxBet=[" .. tMaxBet.. "] tSelfBet=[" ..  tSelfBet .. "] tEffectiveRaise=[" .. tEffectiveRaise .."]")
    return ((tMaxBet-tSelfBet)>=tEffectiveRaise)
end

--最大下注
function GetMaxBet(selfObj)
    local tMaxBet = 0
    if selfObj.miGameRoomInfo == nil or selfObj.miGameRoomInfo.vUserGameInfos == nil then
        return tMaxBet
    end
    for idx, value in pairs(selfObj.miGameRoomInfo.vUserGameInfos) do
        if value.stUserInfo ~= nil  then
            --if value.stUserInfo.uuid ~= selfObj:GetUuid() then
                if tMaxBet <= value.lBetStacks then
                    tMaxBet = value.lBetStacks
                end
            --end
        end
    end
    local tGameState = selfObj:GetGameState()
    if tGameState == TexasPoker_pb.ROOM_GAME_STATE_PreFlop then
        if tMaxBet <= selfObj:GetBigBlinds() then
            tMaxBet = selfObj:GetBigBlinds()
        end
    end

    return tMaxBet
end

--自己下注
function GetSelfBet(selfObj)
    local tSelfBet = 0
    if selfObj.miGameRoomInfo == nil or selfObj.miGameRoomInfo.vUserGameInfos == nil then
        return tSelfBet
    end
    for idx, value in pairs(selfObj.miGameRoomInfo.vUserGameInfos) do
        if value.stUserInfo ~= nil  then
            if value.stUserInfo.uuid == selfObj:GetUuid() then
                tSelfBet = value.lBetStacks
                break
            end
        end
    end
    return tSelfBet
end

------------------------------------
---短牌特殊处理

--滑竿需要的有效加注额
function GetShortDeckSlideEffectiveRaise(selfObj)
    local tSlideEffectiveRaise = 0
    if selfObj.miGameRoomInfo.lEffectiveRaise ~= nil then
        tSlideEffectiveRaise = selfObj.miGameRoomInfo.lEffectiveRaise
    end
    
    local tBigBlinds = 0
    --如果是短牌局需要特殊处理
    local tGameRoomType = selfObj:GetGameRoomType()
    if TexasPokerCommon_pb.GAME_ROOM_SHORT_DECK == tGameRoomType or TexasPokerCommon_pb.GAME_ROOM_SHORT_DECK_INSURANCE ==  tGameRoomType then
        tBigBlinds = selfObj:GetAnte()
    end

    if tSlideEffectiveRaise < tBigBlinds then
        tSlideEffectiveRaise = tBigBlinds
    end
    return tSlideEffectiveRaise
end

--是否可以自由操作(true:可以自由操作)
function GetShortDeckIsFreeRaise(selfObj)
    --如果是PreFlop所有玩家下注没不超过一个大盲，必须一个大盲
    local tGameState = selfObj:GetGameState()
    if tGameState == TexasPoker_pb.ROOM_GAME_STATE_PreFlop then
        local tUserGameInfo = nil
        for idx, value in pairs(selfObj.miGameRoomInfo.vUserGameInfos) do
            if value.stUserInfo ~= nil  then
                if value.stUserInfo.uuid == selfObj:GetUuid() then
                    tUserGameInfo = value
                    break
                end
            end
        end
        if tUserGameInfo ~= nil then
            if tUserGameInfo.eGameRole == TexasPoker_pb.USER_GAME_ROLE_BIG_BLIND then
                if tUserGameInfo.lBetStacks <= selfObj:GetBigBlinds() then
                    return true
                end
            elseif tUserGameInfo.eGameRole == TexasPoker_pb.USER_GAME_ROLE_SMALL_BLIND then
                if tUserGameInfo.lBetStacks <= selfObj:GetSmallBlinds() then
                    return true
                end
            elseif tUserGameInfo.eGameRole == TexasPoker_pb.USER_GAME_ROLE_STRADDLE then
                if tUserGameInfo.lBetStacks <= selfObj:GetBigBlinds() * 2 then
                    return true
                end
            elseif tUserGameInfo.eGameRole == TexasPoker_pb.USER_GAME_ROLE_DEAL then
                --如果是短牌局需要特殊处理
                local tGameRoomType = selfObj:GetGameRoomType()
                if TexasPokerCommon_pb.GAME_ROOM_SHORT_DECK == tGameRoomType or TexasPokerCommon_pb.GAME_ROOM_SHORT_DECK_INSURANCE ==  tGameRoomType then
                    if tUserGameInfo.lBetStacks <= selfObj:GetAnte() then
                        return true
                    end
                end
            end
        end
    end

    local tMaxBet = selfObj:GetShortDeckMaxBet()
    if tMaxBet < selfObj:GetAnte() then
        tMaxBet = selfObj:GetAnte()
    end

    local tSelfBet = selfObj:GetSelfBet()
    local tEffectiveRaise = selfObj:GetEffectiveRaise()
My_Lua_log(" file=[player] fun=[GetIsFreeRaise]; tMaxBet=[" .. tMaxBet.. "] tSelfBet=[" ..  tSelfBet .. "] tEffectiveRaise=[" .. tEffectiveRaise .."]")
    return ((tMaxBet-tSelfBet)>=tEffectiveRaise)
end

--最大下注
function GetShortDeckMaxBet(selfObj)
    local tMaxBet = 0
    if selfObj.miGameRoomInfo == nil or selfObj.miGameRoomInfo.vUserGameInfos == nil then
        return tMaxBet
    end
    for idx, value in pairs(selfObj.miGameRoomInfo.vUserGameInfos) do
        if value.stUserInfo ~= nil  then
            if tMaxBet <= value.lBetStacks then
                tMaxBet = value.lBetStacks
            end
        end
    end
    local tGameState = selfObj:GetGameState()
    if tGameState == TexasPoker_pb.ROOM_GAME_STATE_PreFlop then
        --如果是短牌局需要特殊处理
        local tGameRoomType = selfObj:GetGameRoomType()
        if TexasPokerCommon_pb.GAME_ROOM_SHORT_DECK == tGameRoomType or TexasPokerCommon_pb.GAME_ROOM_SHORT_DECK_INSURANCE ==  tGameRoomType then
            if selfObj:GetGameRoomShortDeckTwiceAnte() == 1 then
                if tMaxBet <= selfObj:GetAnte() then
                    tMaxBet = selfObj:GetAnte()
                end
            end
        end
    end

    return tMaxBet
end


----------------------------------------------------------------------------------

--获得当前状态下下筹码数
function GetCurAllBetStack(selfObj, aiGameRoomInfo)
    local tAllBetStack = 0
    if aiGameRoomInfo == nil then
        tAllBetStack = selfObj:GetCurAllBetStackEx()
    else
        tAllBetStack = selfObj:GetOtherCurAllBetStack(aiGameRoomInfo)
    end
    return tAllBetStack
end

function GetCurAllBetStackEx(selfObj)
    local tAllBetStack = 0
    if selfObj.miGameRoomInfo == nil or selfObj.miGameRoomInfo.vUserGameInfos == nil then
        return tAllBetStack
    end
    for idx, value in pairs(selfObj.miGameRoomInfo.vUserGameInfos) do
        if value.stUserInfo ~= nil  then
            tAllBetStack = tAllBetStack + value.lBetStacks
        end
    end
    return tAllBetStack
end

function GetOtherCurAllBetStack(selfObj, aiGameRoomInfo)
    local tAllBetStack = 0
    if aiGameRoomInfo == nil or aiGameRoomInfo.vUserGameInfos == nil then
        return tAllBetStack
    end
    for idx, value in pairs(aiGameRoomInfo.vUserGameInfos) do
        if value.stUserInfo ~= nil  then
            tAllBetStack = tAllBetStack + value.lBetStacks
        end
    end
    return tAllBetStack
end

--获得现在牌桌上公共牌
function GetPublicCurrentCards(selfObj)
    if selfObj.miGameRoomInfo == nil then
        return nil
    end
    return selfObj.miGameRoomInfo.vCurrentCards
end

--没有放弃的玩家个数
function SelfNoFoldUserNum(selfObj)
    if selfObj.miGameRoomInfo == nil or selfObj.miGameRoomInfo.vUserGameInfos == nil then
        return 0
    end
    return selfObj:NoFoldUserNum(selfObj.miGameRoomInfo.vUserGameInfos)
end

--没有放弃的玩家个数
function NoFoldUserNum(selfObj, aiUserGameInfos)
    local tNum = 0
    if aiUserGameInfos == nil then
        return tNum
    end
    for idx, value in pairs(aiUserGameInfos) do
        if value.stUserInfo ~= nil  then
            if value.stUserInfo.uuid > 0 then
                if value.eGameState == TexasPoker_pb.USER_GAME_STATE_CHECK or
                value.eGameState == TexasPoker_pb.USER_GAME_STATE_CALL or
                value.eGameState == TexasPoker_pb.USER_GAME_STATE_RAISE or
                value.eGameState == TexasPoker_pb.USER_GAME_STATE_ALLIN or
                value.eGameState == TexasPoker_pb.USER_GAME_STATE_BLIND or
                value.eGameState == TexasPoker_pb.USER_GAME_STATE_READY or
                value.eGameState == TexasPoker_pb.USER_GAME_STATE_BETTING or
                value.eGameState == TexasPoker_pb.USER_GAME_STATE_DELEGATE then
                    tNum = tNum + 1
                end
            end
        end
    end
    return tNum
end

--根据uuid获得在桌上的用户数据
function GetUserGameInfoNetFromUuid(selfObj, aiUuid)
    if selfObj.miGameRoomInfo == nil or selfObj.miGameRoomInfo.vUserGameInfos == nil then
        return nil
    end
    for idx, value in pairs(selfObj.miGameRoomInfo.vUserGameInfos) do
        if value.stUserInfo ~= nil and value.stUserInfo.uuid == aiUuid then
            return value
        end
    end
    return nil
end

--获得延时需要的钻石
function GetDelayCost(selfObj)
    local tUserGameInfoNet = selfObj:GetUserGameInfoNetFromUuid(selfObj:GetUuid())
    if tUserGameInfoNet == nil then
        return 0
    end
    return tUserGameInfoNet.iDelayCost
end

--获得延长时间
function GetDelaySingleTime(selfObj)
    local tUserGameInfoNet = selfObj:GetUserGameInfoNetFromUuid(selfObj:GetUuid())
    if tUserGameInfoNet == nil then
        return 0
    end

    return tUserGameInfoNet.iDelaySingleTime
end

--获得延自己钻石数
function GetDiamond(selfObj)
    local tChatDataMap = cc.CClientPlatform:sharedClientPlatform():GetChatData()
    return tChatDataMap['lCoin']
end

--
function GetBettingID(selfObj)
    local tUserGameInfoNet = selfObj:GetUserGameInfoNetFromUuid(selfObj:GetUuid())
    if tUserGameInfoNet == nil then
        return 0
    end
    return tUserGameInfoNet.lBettingID
end

--获得好友数据
--function GetFriendUserData(selfObj, uuid)
--    local tFriendUserDataMap = cc.CClientPlatform:sharedClientPlatform():GetFriendUserData(uuid)
--    return tFriendUserDataMap
--end
--获得好友数据 uuid,房间类型,数据类型(30天，7天等)
function GetFriendUserData(selfObj, uuid,aiRoomType,aiDataType)
    local tFriendUserDataMap = cc.CClientPlatform:sharedClientPlatform():GetFriendUserData(uuid,aiRoomType,aiDataType)
    return tFriendUserDataMap
end

--获得用户牌型
function GetMaxPokerType(selfObj, uuid)
    My_Lua_log(" file=[player] fun=[GetMaxPokerType]; ")
    local tPublicCurrentCards = selfObj:GetPublicCurrentCards()
    local tUserCurrentCards = selfObj:GetUserCurrentHandsFromUuid(uuid)
    return selfObj:GetMaxPokerTypeEx(tUserCurrentCards, tPublicCurrentCards)
end

--获得用户牌型
function GetMaxPokerTypeEx(selfObj, aiHandCards, aiPublicCards)
    My_Lua_log(" file=[player] fun=[getmaxpokertypeex]; ")
    if aiHandCards ~= nil and #aiHandCards >=2 then
        local tPokeList = {}
        for i = 1, #aiHandCards do
            table.insert(tPokeList, aiHandCards[i])
            My_Lua_log(" file=[player] fun=[GetMaxPokerType]; tUserCurrentCards=" .. aiHandCards[i] .."]")
        end
        for i = 1, #aiPublicCards do
            table.insert(tPokeList, aiPublicCards[i])
            My_Lua_log(" file=[player] fun=[GetMaxPokerType]; tPublicCurrentCards=" .. aiPublicCards[i] .."]")
        end

        return selfObj:GetPokerCompareCardsType(tPokeList)
        -- local tGameRoomType = selfObj:GetGameRoomType()
        -- if tGameRoomType == TexasPokerCommon_pb.GAME_ROOM_SIX then
        --     local SixPokeCompare = require("texaspoker.game.pokercompare.sixpokecompare")
        --     return SixPokeCompare.FiveFromSeven(tPokeList)
        -- elseif tGameRoomType == TexasPokerCommon_pb.GAME_ROOM_OMAHA or TexasPokerCommon_pb.GAME_ROOM_OMAHA_INSURANCE == tGameRoomType then
        --     local OmahaPokeCompare = require("texaspoker.game.pokercompare.omahapokecompare")
        --     return OmahaPokeCompare.FiveFromSeven(tPokeList)
        -- elseif tGameRoomType == TexasPokerCommon_pb.GAME_ROOM_SHORT_DECK or TexasPokerCommon_pb.GAME_ROOM_SHORT_DECK_INSURANCE == tGameRoomType then
        --     local ShortDeckCompare = require("texaspoker.game.pokercompare.shortdeckpokecompare")
        --     return ShortDeckCompare.FiveFromSeven(tPokeList)
        -- else
        --     local PokeCompare = require("texaspoker.game.pokercompare.pokecompare")
        --     return PokeCompare.FiveFromSeven(tPokeList)
        -- end
    end
    return nil
end

function GetPokerCompareCardsType(selfObj, aiPokeList)
    local tGameRoomType = selfObj:GetGameRoomType()
    if tGameRoomType == TexasPokerCommon_pb.GAME_ROOM_SIX then
        local SixPokeCompare = require("texaspoker.game.pokercompare.sixpokecompare")
        return SixPokeCompare.FiveFromSeven(aiPokeList)
    elseif tGameRoomType == TexasPokerCommon_pb.GAME_ROOM_OMAHA or TexasPokerCommon_pb.GAME_ROOM_OMAHA_INSURANCE == tGameRoomType then
        local OmahaPokeCompare = require("texaspoker.game.pokercompare.omahapokecompare")
        return OmahaPokeCompare.FiveFromSeven(aiPokeList)
    elseif tGameRoomType == TexasPokerCommon_pb.GAME_ROOM_SHORT_DECK or TexasPokerCommon_pb.GAME_ROOM_SHORT_DECK_INSURANCE == tGameRoomType then
        local ShortDeckCompare = require("texaspoker.game.pokercompare.shortdeckpokecompare")
        return ShortDeckCompare.FiveFromSeven(aiPokeList, selfObj:GetGameRoomShortDeckStraightBig())
    else
        local PokeCompare = require("texaspoker.game.pokercompare.pokecompare")
        return PokeCompare.FiveFromSeven(aiPokeList)
    end
    return nil
end

--获得用户牌型
function GetMaxPokerFromUserCurrentCardsType(selfObj, aiUserCurrentCards)
    My_Lua_log(" file=[player] fun=[GetMaxPokerType]; ")
    if aiUserCurrentCards ~= nil and #aiUserCurrentCards >=2 then
        local tPublicCurrentCards = selfObj:GetPublicCurrentCards()

        local tPokeList = {}
        for i = 1, #aiUserCurrentCards do
        table.insert(tPokeList, aiUserCurrentCards[i])
        My_Lua_log(" file=[player] fun=[GetMaxPokerType]; aiUserCurrentCards=" .. aiUserCurrentCards[i] .."]")
        end
        for i = 1, #tPublicCurrentCards do
        table.insert(tPokeList, tPublicCurrentCards[i])
        My_Lua_log(" file=[player] fun=[GetMaxPokerType]; tPublicCurrentCards=" .. tPublicCurrentCards[i] .."]")
        end

        return selfObj:GetPokerCompareCardsType(tPokeList)
        
        -- if selfObj:GetGameRoomType() == TexasPokerCommon_pb.GAME_ROOM_SIX then
        --     local SixPokeCompare = require("texaspoker.game.pokercompare.sixpokecompare")
        --     return SixPokeCompare.FiveFromSeven(tPokeList)
        -- elseif selfObj:GetGameRoomType() == TexasPokerCommon_pb.GAME_ROOM_OMAHA or TexasPokerCommon_pb.GAME_ROOM_OMAHA_INSURANCE == selfObj:GetGameRoomType() then
        --     local OmahaPokeCompare = require("texaspoker.game.pokercompare.omahapokecompare")
        --     return OmahaPokeCompare.FiveFromSeven(tPokeList)
        -- else
        --     local PokeCompare = require("texaspoker.game.pokercompare.pokecompare")
        --     return PokeCompare.FiveFromSeven(tPokeList)
        -- end
    end
    return nil
end

--获得自己url
function GetSelfUrl(selfObj)
    local tChatDataMap = cc.CClientPlatform:sharedClientPlatform():GetSelfUserData()
    return tChatDataMap['url']
end


--获得自己性别
function GetSelfGender(selfObj)
    local tChatDataMap = cc.CClientPlatform:sharedClientPlatform():GetSelfUserData()
    return tChatDataMap['gender']
end


--是否全部人allin
function GetIsAllAllinState(selfObj)
    return selfObj.miGameRoomInfo.bAllAllin>0
end

function SetAllAllinState(selfObj, aiAllAllin)
    selfObj.miGameRoomInfo.bAllAllin = aiAllAllin
end

--最小最大买入手数数据和是否有高级设置
function GetBuyinRatioData(selfObj)
--    local tBuyinRatioDataMap = cc.CClientPlatform:sharedClientPlatform():GetBuyinRatioData()
    
    local tBuyinRatioDataMap = {}
    if selfObj:GetGameRoomType() == TexasPokerCommon_pb.GAME_ROOM_SNG or
        selfObj:GetGameRoomType() == TexasPokerCommon_pb.GAME_ROOM_MTT then
    else
        local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
        if tGameRoomBaseInfo ~= nil then
            tBuyinRatioDataMap['maxratio'] = tGameRoomBaseInfo.iMaxBuyinRatio
            if tGameRoomBaseInfo.iMaxBuyinRatio == nil then
                tBuyinRatioDataMap['maxratio'] = 40
            end

            tBuyinRatioDataMap['minratio'] = tGameRoomBaseInfo.iMinBuyinRatio
            if tGameRoomBaseInfo.iMinBuyinRatio == nil then
                tBuyinRatioDataMap['minratio'] = 10
            end

            tBuyinRatioDataMap['senior'] = tGameRoomBaseInfo.eGameRoomSeniorType
            if tGameRoomBaseInfo.eGameRoomSeniorType == nil then
                tBuyinRatioDataMap['senior'] = 0
            end
        end
    end

    return tBuyinRatioDataMap
end

--获得最大买入数
function GetMaxBuy(selfObj, aiMaxBuy)
    local tBigBlinds = selfObj:GetBigBlinds()
    return tBigBlinds * aiMaxBuy * 100
end


--获得是否最小买入
function GetIsMinBuyCoin(selfObj)
    local tBuyinRatioDataTable = selfObj:GetBuyinRatioData()
    --默认最小可买入手数
    local tCurMinBuyHandNum = tonumber(tBuyinRatioDataTable['minratio'])/10
    local tBigBlinds = selfObj:GetBigBlinds()
    local tMinBuy = tBigBlinds * 100 * tCurMinBuyHandNum
    local tCoin = selfObj:GetCoin()

    local tInt64MinBuyCoin = int64.new_signed(tMinBuy)
    local tInt64Coin = int64.new_signed(tCoin)

    if tInt64Coin >= tInt64MinBuyCoin then
        return true
    end
    return  false
end

--获得是否有钻石
function GetIsHaveDiamond(selfObj)
    local tDiamond = selfObj:GetDiamond()
    local tInt64Diamond = int64.new_signed(tDiamond)
    local tInt64 = int64.new_signed(tostring(0))
My_Lua_log(" file=[player] fun=[GetMaxPokerType]; tDiamond=[" .. tDiamond .."]")
    if tInt64Diamond > tInt64 then
        return true
    end
    return false
end

--获得玩家是否等待
function GetIsUserWaitState(selfObj)
    if selfObj.miGameRoomInfo == nil or selfObj.miGameRoomInfo.vUserGameInfos == nil then
        return false
    end
    for idx, value in pairs(selfObj.miGameRoomInfo.vUserGameInfos) do
        if value.stUserInfo ~= nil and value.stUserInfo.uuid == selfObj:GetUuid() then
            if value.eGameState == TexasPoker_pb.USER_GAME_STATE_WAIT then
                return true
            end
            break
        end
    end
    return false
end

--获得玩家是否Allin
function GetIsUserAllinState(selfObj)
    if selfObj.miGameRoomInfo == nil or selfObj.miGameRoomInfo.vUserGameInfos == nil then
        return false
    end
    for idx, value in pairs(selfObj.miGameRoomInfo.vUserGameInfos) do
        if value.stUserInfo ~= nil and value.stUserInfo.uuid == selfObj:GetUuid() then
            if value.eGameState == TexasPoker_pb.USER_GAME_STATE_ALLIN then
                return true
            end
            break
        end
    end
    return false
end

--房间是否控制买家带入
function GetIsBuyinControl(selfObj)
    if selfObj.miGameRoomInfo == nil then
        return false
    end

    if selfObj:GetGameRoomType() == TexasPokerCommon_pb.GAME_ROOM_SNG then
    else
        local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
        if tGameRoomBaseInfo ~= nil and tGameRoomBaseInfo.bBuyinControl ~= nil then
            return (tGameRoomBaseInfo.bBuyinControl>0)
        end
    end
    return false
end

--房主暂停功能
function GetIsGamePause(selfObj)
    if selfObj.miGameRoomInfo == nil then
        return false
    end
    if selfObj:GetGameRoomType() == TexasPokerCommon_pb.GAME_ROOM_SNG then
    else
        local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
        if tGameRoomBaseInfo ~= nil and tGameRoomBaseInfo.bGamePause ~= nil then
            return (tGameRoomBaseInfo.bGamePause>0)
        end
    end
    return false
end

--房主暂停功能开始时间
function GetGamePauseTime(selfObj)
    if selfObj.miGameRoomInfo == nil then
        return 0
    end
    if selfObj:GetGameRoomType() == TexasPokerCommon_pb.GAME_ROOM_SNG then
    else
        local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
        if tGameRoomBaseInfo ~= nil and tGameRoomBaseInfo.lGamePauseTime ~= nil then
            return (tGameRoomBaseInfo.lGamePauseTime)
        end
    end
    return 0
end

--是否是买入等待
function GetIsWaitingBuyinConfirmation(selfObj)
    local tUserGameInfoNet = selfObj:GetUserGameInfoNetFromUuid(selfObj:GetUuid())
    if tUserGameInfoNet == nil then
        return false
    end
    if tUserGameInfoNet.bWaitingBuyinConfirmation  then
        return (tUserGameInfoNet.bWaitingBuyinConfirmation>0)
    end
    return false
end

--是否是买入等待申请时间
function GetBuyinTime(selfObj)
    local tUserGameInfoNet = selfObj:GetUserGameInfoNetFromUuid(selfObj:GetUuid())
    if tUserGameInfoNet == nil then
        return 0
    end
    if tUserGameInfoNet.lBuyinTime  then
        return tUserGameInfoNet.lBuyinTime
    end
    return 0
end

--SNG
--涨盲时间
function GetSNGBlindInterval(selfObj)
    if selfObj:GetGameRoomType() == TexasPokerCommon_pb.GAME_ROOM_SNG then
        local tSNGGameRoomBaseInfo = selfObj:GetSNGGameRoomBaseInfo()
        if tSNGGameRoomBaseInfo ~= nil and tSNGGameRoomBaseInfo.iBlindInterval ~= nil then
            return tSNGGameRoomBaseInfo.iBlindInterval
        end
    end
    return 0
end

--牌局人数上限 2人局/6人局/9人局
function GetGameRoomUserMaxNums(selfObj)
    if selfObj:GetGameRoomType() == TexasPokerCommon_pb.GAME_ROOM_SNG then
        local tSNGGameRoomBaseInfo = selfObj:GetSNGGameRoomBaseInfo()
        if tSNGGameRoomBaseInfo ~= nil and tSNGGameRoomBaseInfo.iGameRoomUserMaxNums ~= nil then
            return tSNGGameRoomBaseInfo.iGameRoomUserMaxNums
        end
    else
       local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
       if tGameRoomBaseInfo ~= nil and tGameRoomBaseInfo.iGameRoomUserMaxNums ~= nil then
           return tGameRoomBaseInfo.iGameRoomUserMaxNums
       end  
    end
    return 0
end

--奖金池
function GetSNGWinLadder(selfObj)
    
    local SNG_BUYIN_TYPE={}
    SNG_BUYIN_TYPE[1] = 200
    SNG_BUYIN_TYPE[2] = 500
    SNG_BUYIN_TYPE[3] = 1000
    SNG_BUYIN_TYPE[4] = 2000

    if selfObj:GetGameRoomType() == TexasPokerCommon_pb.GAME_ROOM_SNG then
        local tSNGGameRoomBaseInfo = selfObj:GetSNGGameRoomBaseInfo()
        if tSNGGameRoomBaseInfo ~= nil and tSNGGameRoomBaseInfo.eSNGRoomtype ~= nil then
            local tBuyin = SNG_BUYIN_TYPE[tonumber(tSNGGameRoomBaseInfo.eSNGRoomtype)]
            local tMaxNums  = selfObj:GetGameRoomUserMaxNums()
            return tBuyin*tMaxNums
        end
    end
    return 0
end

--奖金池分配
function GetWinLadderDistribution(selfObj)
    local tWinLadderDistributionList = {}
    if selfObj:GetGameRoomType() == TexasPokerCommon_pb.GAME_ROOM_SNG then
        local tMaxNums = selfObj:GetGameRoomUserMaxNums()
        local tWinLadder = selfObj:GetSNGWinLadder()
        if tMaxNums == 2 then
            tWinLadderDistributionList[1] = tWinLadder
        elseif tMaxNums == 6 then
            tWinLadderDistributionList[1] = tWinLadder * 0.6
            tWinLadderDistributionList[2] = tWinLadder - tWinLadder * 0.6
        elseif tMaxNums == 9 then
            tWinLadderDistributionList[1] = tWinLadder * 0.5
            tWinLadderDistributionList[2] = tWinLadder * 0.3
            tWinLadderDistributionList[3] = tWinLadder - tWinLadder * 0.5 - tWinLadder * 0.3
        end
    end
    return tWinLadderDistributionList
end

--盲注等级
function GetSNGCurrentLevel(selfObj)
    if selfObj:GetGameRoomType() == TexasPokerCommon_pb.GAME_ROOM_SNG then
        local tSNGGameRoomBaseInfo = selfObj:GetSNGGameRoomBaseInfo()
        if tSNGGameRoomBaseInfo ~= nil and tSNGGameRoomBaseInfo.iCurrentLevel ~= nil then
            return tSNGGameRoomBaseInfo.iCurrentLevel
        end
    end
    return 0
end

--SNG玩家是否旁观者
function GetSNGUserIsStandby(selfObj)
    if selfObj:GetGameRoomType() == TexasPokerCommon_pb.GAME_ROOM_SNG then
        for idx, value in pairs(selfObj.miGameRoomInfo.vUserGameInfos) do
            if value.stUserInfo ~= nil and value.stUserInfo.uuid == selfObj:GetUuid() then
                if value.eGameState ~= USER_GAME_STATE_DEAD then
                    return false
                else
                    return true
                end
            end
        end
    end
    return true
end

--USER_GAME_STATE_DEAD = 12;          //玩家处于出具状态(sng)
--USER_GAME_STATE_OUT = 13;           //弃赛状态
--玩家处于出具状态(sng)
function GetSNGUserIsDeadState(selfObj)
    if selfObj:GetGameRoomType() == TexasPokerCommon_pb.GAME_ROOM_SNG then
        for idx, value in pairs(selfObj.miGameRoomInfo.vUserGameInfos) do
            if value.stUserInfo ~= nil and value.stUserInfo.uuid == selfObj:GetUuid() then
                if value.eGameState == TexasPoker_pb.USER_GAME_STATE_DEAD then
                    return true
                else
                    return false
                end
            end
        end
    end
    return false
end

--弃赛状态
function GetSNGUserIsOutState(selfObj)
    if selfObj:GetGameRoomType() == TexasPokerCommon_pb.GAME_ROOM_SNG then
        for idx, value in pairs(selfObj.miGameRoomInfo.vUserGameInfos) do
            if value.stUserInfo ~= nil and value.stUserInfo.uuid == selfObj:GetUuid() then
                if value.eGameState == TexasPoker_pb.USER_GAME_STATE_OUT then
                    return true
                else
                    return false
                end
            end
        end
    end
    return false
end

--获得SNG已经报名人数
function GetSNGSignUpNum(selfObj)
   local tNum = 0
   if selfObj:GetGameRoomType() == TexasPokerCommon_pb.GAME_ROOM_SNG then
        for idx, value in pairs(selfObj.miGameRoomInfo.vUserGameInfos) do
            if value.stUserInfo ~= nil and value.stUserInfo.uuid > 0 then
                tNum = tNum + 1
            end
        end
    end
    return tNum  
end

--获得SNG需要等待人数
function GetSNGRemainingNum(selfObj)
    local tRemainingNum = 0
    if selfObj:GetGameRoomType() == TexasPokerCommon_pb.GAME_ROOM_SNG then
        local tMaxNums = selfObj:GetGameRoomUserMaxNums()
        if tMaxNums > 0 then
            tRemainingNum = tMaxNums-selfObj:GetSNGSignUpNum()
            if tRemainingNum < 1 then
                tRemainingNum = 0
            end
        end
    end
    return tRemainingNum  
end

--获得实时的排名
function GetSNGRanking(selfObj, aiUuid)
    local tRemainingNum = 0
    if selfObj:GetGameRoomType() == TexasPokerCommon_pb.GAME_ROOM_SNG then
        local tRankingList = {}
        for idx, value in pairs(selfObj.miGameRoomInfo.vUserGameInfos) do
            if value.stUserInfo ~= nil and value.stUserInfo.uuid > 0 then
                if value.stUserInfo.uuid == aiUuid and value.eGameState == TexasPoker_pb.USER_GAME_STATE_DEAD then
                    return value.iSNGRank
                end
                if value.eGameState ~= TexasPoker_pb.USER_GAME_STATE_DEAD then
                    local tData = {}
                    tData.miUuid = value.stUserInfo.uuid
                    tData.miRemainStacks = value.lRemainStacks
                    table.insert(tRankingList, tData)
                end
            end
        end

        function SortFun(a, b)
            if a.miRemainStacks > b.miRemainStacks then
                return true
            end
            return false
        end
        table.sort(tRankingList, SortFun)

        for idx, value in pairs(tRankingList) do
            if value.miUuid == aiUuid then
                tRemainingNum = tonumber(idx)
                break
            end
        end
    end
    return tRemainingNum  
end

--准备时间
function GetSNGPrepareTime(selfObj)
    if selfObj:GetGameRoomType() == TexasPokerCommon_pb.GAME_ROOM_SNG then
        if selfObj.miGameRoomInfo.stSNGGameRoomBaseInfo ~= nil and selfObj.miGameRoomInfo.stSNGGameRoomBaseInfo.lPrepareTime ~= nil then
            return selfObj.miGameRoomInfo.stSNGGameRoomBaseInfo.lPrepareTime
        end
    end
    return 0
end

function UpdateSngGameRoomInfoPrepareTime(selfObj, aiPrepareTime)
    if selfObj:GetGameRoomType() == TexasPokerCommon_pb.GAME_ROOM_SNG then
        if selfObj.miGameRoomInfo.stSNGGameRoomBaseInfo ~= nil and selfObj.miGameRoomInfo.stSNGGameRoomBaseInfo.lPrepareTime ~= nil then
            selfObj.miGameRoomInfo.stSNGGameRoomBaseInfo.lPrepareTime = aiPrepareTime
        end
    end
end

--ante
function GetAnte(selfObj)
    if selfObj:GetGameRoomType() == TexasPokerCommon_pb.GAME_ROOM_SNG then
        local tSNGGameRoomBaseInfo = selfObj:GetSNGGameRoomBaseInfo()
        if tSNGGameRoomBaseInfo ~= nil and tSNGGameRoomBaseInfo.iAnte then
            return tSNGGameRoomBaseInfo.iAnte
        end
    else
        local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
        if tGameRoomBaseInfo ~= nil and tGameRoomBaseInfo.iAnte then
            return tGameRoomBaseInfo.iAnte
        end
    end
    return 0
end

--是否保险局
function IsInsuranceRoom(selfObj)
    if selfObj:GetGameRoomType() == TexasPokerCommon_pb.GAME_ROOM_NORMAL_INSURANCE 
    or selfObj:GetGameRoomType() == TexasPokerCommon_pb.GAME_ROOM_OMAHA_INSURANCE 
    or selfObj:GetGameRoomType() == TexasPokerCommon_pb.GAME_ROOM_SHORT_DECK_INSURANCE then
        return true
    end
    return false
end

--获得房间保险玩家的基本信息
function GetGameRoomInsuranceInfos(selfObj)
    if selfObj.miGameRoomInfo ~= nil then
        if selfObj.miGameRoomInfo.vInsuranceInfos ~= nil then
            return selfObj.miGameRoomInfo.vInsuranceInfos
        end
    end
My_Lua_log(" file=[player] fun=[GetGameRoomInsuranceInfos]; ")
    return nil
end

function GetInsuranceStatus(selfObj)
    if selfObj.miGameRoomInfo ~= nil then
        if selfObj.miGameRoomInfo.eInsuranceStatus ~= nil then
            return selfObj.miGameRoomInfo.eInsuranceStatus
        end
    end
    return nil
end

--获得用户保险数据
function GetInsuranceUserInfo(selfObj, aiUuid)
    --My_Lua_log(" file=[player] fun=[GetInsuranceUserInfo]; aiUuid=" .. aiUuid .. "   selfObj:GetGameRoomType()=" .. selfObj:GetGameRoomType())
    if selfObj:IsInsuranceRoom() == true then
        local tGameRoomInsuranceInfos = selfObj:GetGameRoomInsuranceInfos()
        if tGameRoomInsuranceInfos.vInsuranceUserInfos ~= nil then
--My_Lua_log(" file=[player] fun=[GetInsuranceUserInfo]; 111111111111111     v="..#tGameRoomInsuranceInfos.vInsuranceUserInfos)
            for i=1, #tGameRoomInsuranceInfos.vInsuranceUserInfos do
                local tInsuranceUserInfo = tGameRoomInsuranceInfos.vInsuranceUserInfos[i]
--My_Lua_log(" file=[player] fun=[GetInsuranceBetStatus]; tInsuranceUserInfo.uuid=".. tInsuranceUserInfo.uuid .. "  uuid=" .. aiUuid)
                if tInsuranceUserInfo ~= nil and tInsuranceUserInfo.uuid == aiUuid then
                    return tInsuranceUserInfo
                end
            end
        end
    end
    return nil
end

--获得保险是否碎了
function GetIsTotalGetStacks(selfObj, aiUuid)
    local tIsGetStacks = false
    local tInsurancePotInfos = selfObj:GetInsurancePotInfos(aiUuid)
    for i = 1, #tInsurancePotInfos do
        local tInsurancePotInfo = tInsurancePotInfos[i]
        if tInsurancePotInfo ~= nil and tInsurancePotInfo.lGetStacks ~= nil then
            if tInsurancePotInfo.lGetStacks > 0 then
                tIsGetStacks = true
                break
            end
        end
    end
    return tIsGetStacks
end

--获得用户保险操作状态
function GetInsuranceBetStatus(selfObj, aiUuid)
    --My_Lua_log(" file=[player] fun=[GetInsuranceBetStatus]; aiUuid=" .. aiUuid)
    local tInsuranceUserInfo = selfObj:GetInsuranceUserInfo(aiUuid)
    if tInsuranceUserInfo == nil then
        return nil
    end
    return tInsuranceUserInfo.eInsuranceBetStatus
end

--每个用户的保险的池子信息
function GetInsurancePotInfos(selfObj, aiUuid)
    local tInsuranceUserInfo = selfObj:GetInsuranceUserInfo(aiUuid)
    if tInsuranceUserInfo == nil then
        return nil
    end
    return tInsuranceUserInfo.vInsurancePotInfos
end

--获得购买所有底池  保本需要的数
function GetInsurancePotInfosNoLosses(selfObj, aiUuid)
    local tNoLosses = 0 
    local tInsurancePotInfos = selfObj:GetInsurancePotInfos(aiUuid)
    if tInsurancePotInfos == nil then
        return tNoLosses
    end
    for i = 1, #tInsurancePotInfos do
        local tInsurancePotInfo = tInsurancePotInfos[i]
        if tInsurancePotInfo ~= nil and tInsurancePotInfo.lNoLosses ~= nil then
            if tInsurancePotInfo.lSysStacks ~= nil and tInsurancePotInfo.lSysStacks > 0 then
            else
                tNoLosses = tNoLosses + tInsurancePotInfo.lNoLosses
            end
        end
    end
    return tNoLosses
end

--获得购买所有底池 需要的数
function GetInsurancePotInfosAllMax(selfObj, aiUuid)
    local tlMaxStacks = 0
    local tInsurancePotInfos = selfObj:GetInsurancePotInfos(aiUuid)
    if tInsurancePotInfos == nil then
        return tlMaxStacks
    end
    for i = 1, #tInsurancePotInfos do
        local tInsurancePotInfo = tInsurancePotInfos[i]
        if tInsurancePotInfo.lSysStacks ~= nil and tInsurancePotInfo.lSysStacks > 0 then
        else
            if tInsurancePotInfo ~= nil and tInsurancePotInfo.lMaxStacks ~= nil then
                tlMaxStacks = tlMaxStacks + tInsurancePotInfo.lMaxStacks
            end
        end
    end
    return tlMaxStacks
end

--获得购买底池筹码数
function GetInsurancePotInfosBetStacks(selfObj, aiUuid)
    local tAllBetStacks = 0 
    local tInsurancePotInfos = selfObj:GetInsurancePotInfos(aiUuid)
    for i = 1, #tInsurancePotInfos do
        local tInsurancePotInfo = tInsurancePotInfos[i]
        if tInsurancePotInfo ~= nil and tInsurancePotInfo.lBetStacks ~= nil then
            tAllBetStacks = tAllBetStacks + tInsurancePotInfo.lBetStacks
        end
    end
    return tAllBetStacks
end

--获得延时需要的钻石
function GetInsuranceDelayCost(selfObj)
    local tInsuranceUserInfo = selfObj:GetInsuranceUserInfo(selfObj:GetUuid())
    if tInsuranceUserInfo == nil then
        return 0
    end
    return tInsuranceUserInfo.iInsuranceDelayCost
end

--获得延长时间
function GetInsuranceDelaySingleTime(selfObj)
    local tInsuranceUserInfo = selfObj:GetInsuranceUserInfo(selfObj:GetUuid())
    if tInsuranceUserInfo == nil then
        return 0
    end
    return tInsuranceUserInfo.iInsuranceDelayLong
end

--保险购买延时修改
function UpdateInsuranceUserInfoDelayLong(selfObj, aiUuid, aiInsuranceActDuration, aiInsuranceDelayCost, aiInsuranceDelayLong)
    local tInsuranceUserInfo = selfObj:GetInsuranceUserInfo(aiUuid)
    if tInsuranceUserInfo == nil then
        return nil
    end
    tInsuranceUserInfo.lInsuranceActDuration = aiInsuranceActDuration
    tInsuranceUserInfo.iInsuranceDelayCost = aiInsuranceDelayCost
    tInsuranceUserInfo.iInsuranceDelayLong = aiInsuranceDelayLong
end

function GetInsuranceStartTime(selfObj, aiUuid)
    local tInsuranceUserInfo = selfObj:GetInsuranceUserInfo(aiUuid)
    if tInsuranceUserInfo == nil then
        return 0
    end
    return tInsuranceUserInfo.lInsuranceStartTime
end

function GetInsuranceActDuration(selfObj, aiUuid)
    local tInsuranceUserInfo = selfObj:GetInsuranceUserInfo(aiUuid)
    if tInsuranceUserInfo == nil then
        return 0
    end
    return tInsuranceUserInfo.lInsuranceActDuration
end

--更新用户保险数据
function UpdateInsuranceUserInfo(selfObj, aiUuid, aiInsuranceUserInfo)
    if selfObj:IsInsuranceRoom() == true then
        local tGameRoomInsuranceInfos = selfObj:GetGameRoomInsuranceInfos()
        if tGameRoomInsuranceInfos.vInsuranceUserInfos ~= nil then
            for i=1, #tGameRoomInsuranceInfos.vInsuranceUserInfos do
                local tInsuranceUserInfo = tGameRoomInsuranceInfos.vInsuranceUserInfos[i]
                if tInsuranceUserInfo ~= nil and tInsuranceUserInfo.uuid == aiUuid then
                    tGameRoomInsuranceInfos.vInsuranceUserInfos[i] = aiInsuranceUserInfo
                    break
                end
            end
        end
    end
end

--[[
--用户设置购买保险开关
function GetDefaultInsurance(selfObj, aiUuid)
    local tInsuranceUserInfo = selfObj:GetInsuranceUserInfo(aiUuid)
    if tInsuranceUserInfo == nil then
        return false
    end
    return (tInsuranceUserInfo.bDefaultInsurance>0)
end

function SetDefaultInsurance(selfObj, aiUuid, aiDefaultInsurance)
    local tInsuranceUserInfo = selfObj:GetInsuranceUserInfo(aiUuid)
    if tInsuranceUserInfo == nil then
        return
    end
    tInsuranceUserInfo.bDefaultInsurance = aiDefaultInsurance
end
]]--

function GetPotInfos(selfObj)
    return selfObj.miGameRoomInfo.vPotInfos
end

function GetNotifyUuids(selfObj)
    local tGameRoomInsuranceInfos = selfObj:GetGameRoomInsuranceInfos()
    if tGameRoomInsuranceInfos ~= nil and tGameRoomInsuranceInfos.vNoOutsUuids ~= nil then
        return tGameRoomInsuranceInfos.vNoOutsUuids
    end
    return {}
end
function GetNotifyPotUuids(selfObj)
    local tGameRoomInsuranceInfos = selfObj:GetGameRoomInsuranceInfos()
    if tGameRoomInsuranceInfos ~= nil and tGameRoomInsuranceInfos.vNoPotsUuids ~= nil then
        return tGameRoomInsuranceInfos.vNoPotsUuids
    end
    return {}
end

--获得是否托管状态
function SelfIsDelegate(selfObj)
    local tInfoNet = selfObj:GetUserGameInfoNetFromUuid(selfObj:GetUuid())
    if tInfoNet == nil or tInfoNet.bDelegate == nil then
        return false
    end
    return (tInfoNet.bDelegate>0)
end

--获得是否留座离桌状态
function SelfIsTemporarilyLeave(selfObj)
    local tInfoNet = selfObj:GetUserGameInfoNetFromUuid(selfObj:GetUuid())
    if tInfoNet == nil or tInfoNet.bTemporarilyLeave == nil then
        return false
    end
    return (tInfoNet.bTemporarilyLeave>0)
end
--获得非留座离桌状态人数
function GetNotTemporarilyLeaveNums(selfObj)
    if selfObj.miGameRoomInfo == nil or selfObj.miGameRoomInfo.vUserGameInfos == nil then
        return 0
    end
    local tCount = 0
    for idx, value in pairs(selfObj.miGameRoomInfo.vUserGameInfos) do
        if value.stUserInfo and value.stUserInfo.uuid > 0 and value.bTemporarilyLeave ~= nil and value.bTemporarilyLeave < 1 then
            tCount = tCount + 1
        end
    end
    return tCount
end

--是否开启IP限制
function GetIsIPLimit(selfObj)
    if selfObj.miGameRoomInfo == nil then
        return false
    end

    if selfObj:GetGameRoomType() == TexasPokerCommon_pb.GAME_ROOM_SNG then
        local tSNGGameRoomBaseInfo = selfObj:GetSNGGameRoomBaseInfo()
        if tSNGGameRoomBaseInfo ~= nil and tSNGGameRoomBaseInfo.bIPLimit ~= nil then
            return (tSNGGameRoomBaseInfo.bIPLimit>0)
        end 
    else
        local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
        if tGameRoomBaseInfo ~= nil and tGameRoomBaseInfo.bIPLimit ~= nil then
            return (tGameRoomBaseInfo.bIPLimit>0)
        end
    end
    return false
end

--是否开启GPS限制
function GetIsGPSLimit(selfObj)
    if selfObj.miGameRoomInfo == nil then
        return false
    end

    if selfObj:GetGameRoomType() == TexasPokerCommon_pb.GAME_ROOM_SNG then
        local tSNGGameRoomBaseInfo = selfObj:GetSNGGameRoomBaseInfo()
        if tSNGGameRoomBaseInfo ~= nil and tSNGGameRoomBaseInfo.bGPSLimit ~= nil then
            return (tSNGGameRoomBaseInfo.bGPSLimit>0)
        end 
    else
        local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
        if tGameRoomBaseInfo ~= nil and tGameRoomBaseInfo.bGPSLimit ~= nil then
            return (tGameRoomBaseInfo.bGPSLimit>0)
        end
    end
    return false
end

--当前牌局人数
function GetCurUserNums(selfObj)
    
    local tMaxPos = selfObj:GetGameRoomUserMaxNums()
    local tCurUserNums = 0

    for i = 1, tMaxPos do
        local tUserGameInfo = selfObj.miGameRoomInfo.vUserGameInfos[i]
        if tUserGameInfo and tUserGameInfo.stUserInfo.uuid > 0 then
            tCurUserNums = tCurUserNums + 1
        end
    end
    
    return tCurUserNums
end

--获得是否联盟局
function GetIsLeagueID(selfObj)
    if selfObj:GetGameRoomType() == TexasPokerCommon_pb.GAME_ROOM_SNG then
        local tSNGGameRoomBaseInfo = selfObj:GetSNGGameRoomBaseInfo()
        if tSNGGameRoomBaseInfo ~= nil then
            return (tSNGGameRoomBaseInfo.lLeagueID>0)
        end
    else
        local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
        if tGameRoomBaseInfo then
            return (tGameRoomBaseInfo.lLeagueID>0)
        end
    end
    return false
end

--获得是否购买过联盟数据
function GetBuyinClubID(selfObj)

    local tUserGameInfoNet = selfObj:GetUserGameInfoNetFromUuid(selfObj:GetUuid())
    if tUserGameInfoNet == nil then
        return 0
    end
    return tUserGameInfoNet.lBuyinClubID
end


--房间是否设置straddle
function SetIsStraddle(selfObj, aiStraddle)
    if selfObj:GetGameRoomType() ~= TexasPokerCommon_pb.GAME_ROOM_SNG then

        local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
        if tGameRoomBaseInfo ~= nil then
            tGameRoomBaseInfo.bStraddle = aiStraddle
        end
    end
end

function GetIsSetStraddle(selfObj)
    if selfObj.miGameRoomInfo == nil then
        return false
    end

    if selfObj:GetGameRoomType() ~= TexasPokerCommon_pb.GAME_ROOM_SNG then

        local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
        if tGameRoomBaseInfo ~= nil and tGameRoomBaseInfo.bStraddle ~= nil then
            return (tGameRoomBaseInfo.bStraddle>0)
        end
    end
    return false
end


--获取现在是否真正的straddle
function GetIsRealStraddle(selfObj)

    if selfObj:GetIsSetStraddle() == false then
        return false
    end

    local tGameState = selfObj:GetGameState()
    if tGameState == TexasPoker_pb.ROOM_GAME_STATE_PreFlop then

        for idx, value in pairs(selfObj.miGameRoomInfo.vUserGameInfos) do
            if value.stUserInfo ~= nil  then
                if value.stUserInfo.uuid > 0 and value.eGameRole == TexasPoker_pb.USER_GAME_ROLE_STRADDLE then
                    return true
                end
            end
        end
    end

    return false
end

--通过uuid判断是否straddle位
function GetIsStraddleByUuid(selfObj,uuid)

    local tGameState = selfObj:GetGameState()
    if tGameState == TexasPoker_pb.ROOM_GAME_STATE_PreFlop then

        for idx, value in pairs(selfObj.miGameRoomInfo.vUserGameInfos) do
            if value.stUserInfo ~= nil  then
                if uuid == value.stUserInfo.uuid then
                    if value.eGameRole == TexasPoker_pb.USER_GAME_ROLE_STRADDLE then
                        return true
                    end
                end
            end
        end
    end

    return false
end


--设置思考时间
function SetThinkingInterval(selfObj,aiInterval)
    
    local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
    if aiInterval ~= 10 and aiInterval ~= 12 and aiInterval ~= 15 then
        tGameRoomBaseInfo.iThinkingInterval = 15
    else
        if tGameRoomBaseInfo ~= nil then
            if aiInterval == 0 then
                aiInterval = 15
            end
            tGameRoomBaseInfo.iThinkingInterval = aiInterval
        end
    end
end

function GetThinkingInterval(selfObj)

    if selfObj:GetGameRoomType() ~= TexasPokerCommon_pb.GAME_ROOM_SNG then
        local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
        if tGameRoomBaseInfo ~= nil and tGameRoomBaseInfo.iThinkingInterval ~= nil then
            return tGameRoomBaseInfo.iThinkingInterval
        end
    elseif selfObj:GetGameRoomType() == TexasPokerCommon_pb.GAME_ROOM_SNG then
        local tSNGGameRoomBaseInfo = selfObj:GetSNGGameRoomBaseInfo()
        if tSNGGameRoomBaseInfo ~= nil and tSNGGameRoomBaseInfo.iThinkingInterval ~= nil then
            return tSNGGameRoomBaseInfo.iThinkingInterval
        end
    end
    return 15
end

--预动作状态
function SetPreActionState(selfObj,aiActionState)
    if selfObj.miGameRoomInfo.vUserGameInfos == nil then
        return
    end
    for idx, value in pairs(selfObj.miGameRoomInfo.vUserGameInfos) do
        if value.ePreAction ~= nil and value.stUserInfo.uuid == selfObj:GetUuid() then
            value.ePreAction = aiActionState
        end
    end
end

function GetPreActionState(selfObj)
    if selfObj.miGameRoomInfo.vUserGameInfos == nil then
        return nil
    end
    for idx, value in pairs(selfObj.miGameRoomInfo.vUserGameInfos) do
        if value.ePreAction ~= nil and value.stUserInfo.uuid == selfObj:GetUuid() then
            return value.ePreAction
        end
    end

    return nil
end

function UpdatePreActionState(selfObj, aiState)
    if selfObj.miGameRoomInfo.vUserGameInfos == nil then
        return
    end
    for idx, value in pairs(selfObj.miGameRoomInfo.vUserGameInfos) do
        if value.ePreAction ~= nil and value.stUserInfo.uuid == selfObj:GetUuid() then
            value.ePreAction = aiState
        end
    end
end

--mtt
--设置MTT房间基本信息 gameroombaseinfo
function SetMTTGameRoomBaseInfo(selfObj, aiData)
    selfObj.miMttGameRoomBaseInfo = aiData
end

function GetMTTGameRoomBaseInfo(selfObj)
    return selfObj.miMttGameRoomBaseInfo
end
--获取迟注册结束点
function GetMttDelayTime(selfObj)
    
    local tMTTGameRoomBaseInfo = selfObj:GetMTTGameRoomBaseInfo() 
    if tMTTGameRoomBaseInfo ~= nil then
        return tMTTGameRoomBaseInfo.lDelayTime
    end

    return nil
end
--获取比赛开始时间点
function GetMttStartTime(selfObj)
    
    local tMTTGameRoomBaseInfo = selfObj:GetMTTGameRoomBaseInfo() 
    if tMTTGameRoomBaseInfo ~= nil then
        return tMTTGameRoomBaseInfo.lStartTime
    end

    return nil
end

--获取是否可重进
function GetIsAllowReentry(selfObj)

    local tMTTGameRoomBaseInfo = selfObj:GetMTTGameRoomBaseInfo() 
    if tMTTGameRoomBaseInfo ~= nil then
        if tMTTGameRoomBaseInfo.bReentry > 0 then
            return true
        else
            return false
        end
    end
    return false
end
--获取mtt剩余重进次数
function GetMttReentryTimes(selfObj)
    local tMTTGameRoomBaseInfo = selfObj:GetMTTGameRoomBaseInfo() 
    if tMTTGameRoomBaseInfo ~= nil then
        return tMTTGameRoomBaseInfo.iReentryableNum
    end
    return nil
end
--获取mtt延时报名等级
function GetMttDelayLevel(selfObj)
    local tMTTGameRoomBaseInfo = selfObj:GetMTTGameRoomBaseInfo() 
    if tMTTGameRoomBaseInfo ~= nil then
        return tMTTGameRoomBaseInfo.iDelayLevel
    end
    return nil
end

--MTT开始时间
function GetMttStartTime(selfObj)
    local tMTTGameRoomBaseInfo = selfObj:GetMTTGameRoomBaseInfo() 
    if tMTTGameRoomBaseInfo ~= nil then
        return tMTTGameRoomBaseInfo.lStartTime
    end
    return nil
end
--旁观
function GetIsStandBy(selfObj)
    local tMTTGameRoomBaseInfo = selfObj:GetMTTGameRoomBaseInfo() 
    if tMTTGameRoomBaseInfo ~= nil then
        if tMTTGameRoomBaseInfo.bInGame < 1 then
            return true
        end
    end
    return false
end
--没报过名 旁观
function GetIsBystander(selfObj)
    local tMTTGameRoomBaseInfo = selfObj:GetMTTGameRoomBaseInfo() 
    if tMTTGameRoomBaseInfo ~= nil then
        --没报过名 被淘汰字段为0 同时满足为旁观者
        if tMTTGameRoomBaseInfo.bInGame < 1 and tMTTGameRoomBaseInfo.iEliminated < 1 then
            return true
        end
    end
    return false
end
--报过名 但是被淘汰 旁观
function GetIsSignupNotInGame(selfObj)
    local tMTTGameRoomBaseInfo = selfObj:GetMTTGameRoomBaseInfo() 
    if tMTTGameRoomBaseInfo ~= nil then
        if tMTTGameRoomBaseInfo.bInGame < 1 and tMTTGameRoomBaseInfo.iEliminated >= 1 then
            return true
        end
    end
    return false
end

--目前还在参赛的玩家
function GetPlayingUserNums(selfObj)
    local tMTTGameRoomBaseInfo = selfObj:GetMTTGameRoomBaseInfo() 
    if tMTTGameRoomBaseInfo ~= nil then
        return tMTTGameRoomBaseInfo.iCurrentSigupNums
    end
    return 0
end

--实时赛况信息
function SetMTTRealtimeInfos(selfObj, aiData)
    selfObj.miMttGameRoomRealtimeInfo = aiData
end
function GetMTTRealtimeInfos(selfObj)
    return selfObj.miMttGameRoomRealtimeInfo
end

--下个涨盲时间点
function GetMttNextBlindTime(selfObj)
    local tMTTRealtimeInfos = selfObj:GetMTTRealtimeInfos() 
    if tMTTRealtimeInfos ~= nil then
        return tMTTRealtimeInfos.lNextBlindTime
    end
    return nil
end

--获取当前盲注结构
function GetCurrentBlindLevelInfos(selfObj)
    
    local tMTTRealtimeInfos = selfObj:GetMTTRealtimeInfos() 
    if tMTTRealtimeInfos ~= nil then
        return tMTTRealtimeInfos.stCurrentMTTBlindLevelInfo
    end

    return nil
end


--牌桌列表
function SetMTTTableInfos(selfObj, aiData)
    selfObj.miMttTableInfos = aiData
end
function GetMTTTableInfos(selfObj)
    return selfObj.miMttTableInfos
end

--奖励列表
function SetMTTBonusInfos(selfObj, aiData)
    selfObj.miMttBonusLevelInfos = aiData
end
function GetMTTBonusInfos(selfObj)
    return selfObj.miMttBonusLevelInfos
end

--获取自己所在牌桌号
function GetMTTSelfTableIndex(selfObj)
    local tMTTTableInfos = selfObj:GetMTTTableInfos()
    if tMTTTableInfos == nil then
        return -1
    end
    return tMTTTableInfos.iTableIndex
end

--盲注列表
function SetMTTBlindLevelInfos(selfObj, aiData)
    selfObj.miMttBlindLevelInfos = aiData
end
function GetMTTBlindLevelInfos(selfObj)
    return selfObj.miMttBlindLevelInfos
end

--获取当前盲注级别
function GetCurrentBlindLevel(selfObj)
    
    local tBlindLevelInfos = selfObj:GetMTTBlindLevelInfos()
    if tBlindLevelInfos == nil then
        return 0
    end

    return tBlindLevelInfos.iCurrentBlindLevel
end

--排名列表
function SetMTTUserInfos(selfObj, aiData)
    selfObj.miMttUserInfos = aiData
end
function GetMTTUserInfos(selfObj)
    return selfObj.miMttUserInfos
end

--获取自己当前的排名
function GetSelfCurrentUserinfo(selfObj)
    
    local tUserInfos = selfObj:GetMTTUserInfos()
    if tUserInfos == nil then
        return
    end

    return tUserInfos.stMTTUserInfos.stMTTUserInfo

end

--获取当前玩家的剩余人数
function GetCurrentRemainUsers(selfObj)
    local tUserInfos = selfObj:GetMTTUserInfos()
    if tUserInfos == nil then
        return
    end

    return tUserInfos.stMTTUserInfos.iMTTRemainUsers
end

--获取奖励圈
function GetMTTBonusLimit(selfObj)
    
    local tBonusInfos = selfObj:GetMTTBonusInfos()
    if tBonusInfos == nil then
        return
    end

    return tBonusInfos.stMTTBonusInfo.iBounsLimit
end

--需要转换牌局数据
function GetGetUserInfoGameRoomType(selfObj)
    local tGameRoomType = selfObj:GetGameRoomType()
    if tGameRoomType == TexasPokerCommon_pb.GAME_ROOM_NORMAL or tGameRoomType == TexasPokerCommon_pb.GAME_ROOM_NORMAL_INSURANCE then
        tGameRoomType = TexasPokerCommon_pb.GAME_ROOM_NORMAL
    elseif tGameRoomType == TexasPokerCommon_pb.GAME_ROOM_OMAHA_INSURANCE or tGameRoomType == TexasPokerCommon_pb.GAME_ROOM_OMAHA then
        tGameRoomType = TexasPokerCommon_pb.GAME_ROOM_OMAHA
    end
    return tGameRoomType
end

--设置修改延时属性数据
function UpdateDelayData(selfObj, aiDelayTotalTimes, ailActTime, aiDelayLong, aiDelayCost, aiDelaySingleTime)
    for idx, value in pairs(selfObj.miGameRoomInfo.vUserGameInfos) do
        if value.stUserInfo.uuid == selfObj:GetUuid() then
            value.iDelayTotalTimes = aiDelayTotalTimes;           --已经使用的次数
            value.lActTime = ailActTime;                   --用户做动作的时间
            value.iDelayLong = aiDelayLong;                 --延时的长度
            value.iDelayCost = aiDelayCost;                 --延时需要的金币
            value.iDelaySingleTime = aiDelaySingleTime;           --每次延时的时间

            return
        end
    end
end----------------------------

------------------------------------------------------------------------------------------
--6+比牌规则(正常，还是非正常。0,正常，1的非正常顺子大于3条）
function GetGameRoomShortDeckStraightBig(selfObj)
    local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
    if tGameRoomBaseInfo ~= nil and tGameRoomBaseInfo.bStraightBig then
        return tGameRoomBaseInfo.bStraightBig
    end
    return 0
end

--短牌是否两倍ante
function GetGameRoomShortDeckTwiceAnte(selfObj)
    local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
    if tGameRoomBaseInfo ~= nil and tGameRoomBaseInfo.bTwiceAnte then
        return tGameRoomBaseInfo.bTwiceAnte
    end
    return 0
end

--短牌是否可以带出
function GetGameRoomShortDeckUnloadable(selfObj)
    local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
    if tGameRoomBaseInfo ~= nil and tGameRoomBaseInfo.bUnloadable then
        return tGameRoomBaseInfo.bUnloadable
    end
    return 0
end

--短牌最小保留记分牌倍数(数值是100的倍数，使用需要除100)
function GetGameRoomShortDeckMinRemainRatio(selfObj)
    local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
    if tGameRoomBaseInfo ~= nil and tGameRoomBaseInfo.iMinRemainRatio then
        return tGameRoomBaseInfo.iMinRemainRatio
    end
    return 0
end

--短牌最小带出记分牌倍数(数值是100的倍数，使用需要除100))
function GetGameRoomShortDeckUnloadRatio(selfObj)
    local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
    if tGameRoomBaseInfo ~= nil and tGameRoomBaseInfo.iUnloadRatio then
        return tGameRoomBaseInfo.iUnloadRatio
    end
    return 0
end

-- 一手牌开始时，玩家身上的筹码
-- 1.用于判断玩家是否满足带出；
-- 2.能带出时，带出最大值
function GetBeginStacks( selfObj )
    local tBeginStacks = 0

    local tPos = selfObj:GetUserPosFromUuid(selfObj:GetUuid())--位置从0开始
    if tPos < 0 then
        return tBeginStacks
    end
    tPos = tPos + 1

    --更新现在的数据状态
    if selfObj.miGameRoomInfo ~= nil then
        if selfObj.miGameRoomInfo.vBeginStacks ~= nil then
            if selfObj.miGameRoomInfo.vBeginStacks[tPos] ~= nil then
                tBeginStacks = selfObj.miGameRoomInfo.vBeginStacks[tPos]
            end
        end
    end

    return tBeginStacks
end

-- 是否正在卸码，必须等一次卸码操作完成后，才能进行第二次卸码操作: 0 没有带出过
function GetUserbUnloadingStacks( selfObj )
    local tIsLoadingStacks = 0

    local tSelfUuid = selfObj:GetUuid()
    if selfObj.miGameRoomInfo ~= nil then
        if selfObj.miGameRoomInfo.vUserGameInfos ~= nil then
            for idx, value in pairs(selfObj.miGameRoomInfo.vUserGameInfos) do
                if value.stUserInfo ~= nil and value.stUserInfo.uuid == tSelfUuid then
                    if value.bUnloadingStacks ~= nil then
                        tIsLoadingStacks = value.bUnloadingStacks
                        My_Lua_log(" file=[player] fun=[GetUserbUnloadingStacks]; 01 tIsLoadingStacks="..tIsLoadingStacks)
                    else
                        My_Lua_log(" file=[player] fun=[GetUserbUnloadingStacks]; 02 tIsLoadingStacks="..tIsLoadingStacks)
                    end
                    break
                end
            end
        end
    end

    My_Lua_log(" file=[player] fun=[GetUserbUnloadingStacks]; 11 tIsLoadingStacks="..tIsLoadingStacks)
    if tIsLoadingStacks == 0 then
        return false
    else
        return true
    end
end



------------------------------------------------------------------------------------------
function ConversionNumToStr(selfObj, aiCoin)
    My_Lua_log(" file=[player] fun=[conversionnumtostr]; ")
    local tReturnStr = "0"
    if aiCoin > 999999999 then
        local tStr = tostring(aiCoin/1000000000.0)
        local tStrB = string.sub(tStr, 1, 4)
        local tbegin, tEnd = string.find(tStrB, '%.')
        if tbegin == nil then
            tReturnStr = tStrB.."B"
        else
            if tEnd == 4 then
                tStrB = string.sub(tStrB, 1, 3)
                tReturnStr = tStrB.."B"
            else
                tReturnStr = tStrB.."B"
            end
        end
    elseif aiCoin > 999999 then
        local tStr = tostring(aiCoin/1000000.0)
        local tStrM = string.sub(tStr, 1, 4)
        local tbegin, tEnd = string.find(tStrM, '%.')
        if tbegin == nil then
            tReturnStr = tStrM.."M"
        else
            if tEnd == 4 then
                tStrM = string.sub(tStrM, 1, 3)
                tReturnStr = tStrM.."M"
            else
                tReturnStr = tStrM.."M"
            end
        end
    elseif  aiCoin > 9999  then
        local tStr = tostring(aiCoin/1000.0)
        local tStrK = string.sub(tStr, 1, 4)
        local tbegin, tEnd = string.find(tStr, '%.')
        if tbegin == nil then
            tReturnStr = tStrK.."K"
        else
            if tEnd == 4 then
                tStrK = string.sub(tStr, 1, 3)
                tReturnStr = tStrK.."K"
            else
                tReturnStr = tStrK.."K"
            end
        end
    else 
        tReturnStr = tostring(aiCoin) 
    end
    return tReturnStr
end

----------------------------
--四舍五入函数
function RoundedNumber(selfObj, aiNumber)
    local tX, tY = math.modf(aiNumber)
    if tY - 0.5 >= 0.000001 then
        tX = tX + 1
    end
    return tX
end

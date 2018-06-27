--region *.lua
--Date
--此文件由[BabeLua]插件自动生成


--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

module(...,package.seeall)
local Local_GameRoomkBase = require "comm.gameroombase"

function Create(aiData)
    local selfObj = Local_GameRoomkBase.Create(aiData)
    local parents = {_M, Local_GameRoomkBase}
	setmetatable( selfObj ,{__index = function(t,k)
		return search(k,parents) end } )

    selfObj:Init(aiData)
    return selfObj
end

function Init(selfObj, aiData)
    
    selfObj.miGameRoomId = 0    

    --房间数据，暂时用下
    selfObj.miGameRoomInfo = nil

    --用户数据
    local Player = require("comm.playerpofc")
    selfObj.miPlayer = Player.Create()

    --用于存储查看玩家信息
    selfObj.miOtherUserBaseInfo = nil

    --账单信息
    selfObj.miGetBillInfoByRoom = nil
    --围观者信息数据
    selfObj.miGetStandbyInfos = nil
    --弹出什么战况窗口
    selfObj.miSituationPag='pofcrealtimesituationmainpag'

    --牌局屏蔽语音列表
    selfObj.miUserSoundOnOffList = {}

    --暂停时间差
    selfObj.miPauseDataList = {}

    --牌局俱乐部数据
    selfObj.miClubBaseInfoList = {}

    --道具表情数据列表
    selfObj.miUseItemList = {}

    --是否结束
    selfObj.miDelayMessageOverPag = false
    
end


-------------------------------------------------
------------------房间数据相关--------------------
-------------------------------------------------
--房间id
function SetGameRoomId(selfObj, aiGameRoomId)
    selfObj.miGameRoomId = aiGameRoomId
end

function GetGameRoomId(selfObj)
    return selfObj.miGameRoomId
end

--设置房间数据
function SetGameRoomInfo(selfObj, aiGameRoomInfo)
    selfObj.miGameRoomInfo = nil
    selfObj.miGameRoomInfo = aiGameRoomInfo

    selfObj.miPlayer:SetUserGameInfoList(selfObj.miGameRoomInfo.vOfcUserGameInfoNet)
end
function GetGameRoomInfo(selfObj)
    return selfObj.miGameRoomInfo
end

function SetGameRoomBaseInfo( selfObj, aiGameRoomBaseInfo )
    if selfObj.miGameRoomInfo ~= nil then
        if selfObj.miGameRoomInfo.stOfcGameRoomBaseInfo ~= nil then
            selfObj.miGameRoomInfo.stOfcGameRoomBaseInfo:MergeFrom(aiGameRoomBaseInfo) 
        end
    end
end

function GetGameRoomBaseInfo(selfObj)

    if selfObj.miGameRoomInfo ~= nil then
        if selfObj.miGameRoomInfo.stOfcGameRoomBaseInfo ~= nil then
            return selfObj.miGameRoomInfo.stOfcGameRoomBaseInfo
        end
    end
    return nil
end

--设置房间数据和指定uuid玩家的数据
--参数:房间信息大结构，指定玩家的uuid，指定玩家更新的玩家信息结构
function SetGameRoomInfoAndUserInfoByUuid(selfObj, aiGameRoomInfo, aiUuid, aiUserInfo)
    selfObj.miGameRoomInfo = nil
    selfObj.miGameRoomInfo = aiGameRoomInfo

    selfObj:UpdateUserInfoByUuid(aiUuid, aiUserInfo)
end


--大菠萝房间类型 普通局，血进血出 癞子等
function GetGameRoomType(selfObj)
    local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
    if tGameRoomBaseInfo then
        return tGameRoomBaseInfo.eOfcProgressiveMode
    end
    return nil
end

--获得是否联盟局
function GetIsLeagueID(selfObj)
    local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
    if tGameRoomBaseInfo then
        return (tGameRoomBaseInfo.lSyncedLeagueId>0)
    end
end

--获取联盟id
function GetLeagueID( selfObj )
    local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
    if tGameRoomBaseInfo then
        return tGameRoomBaseInfo.lSyncedLeagueId
    end
    return nil
end

--获得是否购买过联盟数据
function GetBuyinClubID(selfObj)
    return selfObj.miPlayer:GetBuyinClubID()
end

--牌局俱乐部数据
function SetClubBaseInfoTable(selfObj, ClubBaseInfoTable)
     -- body
    selfObj.miClubBaseInfoList = ClubBaseInfoTable
end 

--牌局俱乐部数据
function GetClubBaseInfoTable(selfObj)
    return selfObj.miClubBaseInfoList
end

--根据uuid获得在桌上的用户数据
function GetUserGameInfoNetFromUuid(selfObj, aiUuid)
    return nil
end

--获得房间名
function GetGameRoomName(selfObj)

    local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
    if tGameRoomBaseInfo then
        return tGameRoomBaseInfo.sRoomName
    end
    return ""
end

--获得GameHandId
function GetGameHandId(selfObj)
    if selfObj.miGameRoomInfo ~= nil then
        if selfObj.miGameRoomInfo.lGameHandId ~= nil then
            return selfObj.miGameRoomInfo.lGameHandId
        end
    end
    return 0
end

--获得房间创建类型 快速局还是俱乐部局
function GetCreateRoomType(selfObj)

    local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
    if tGameRoomBaseInfo then
        return tGameRoomBaseInfo.eCreateRoomType
    end
    return nil
end
--邀请码
function GetCryptCode(selfObj)
    
    return 11111
end
--是否房主
function GetIsCreateUser(selfObj)
    local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
    local tCreateUserUuid = tGameRoomBaseInfo.stCreateUserBaseInfo.uuid
    if tCreateUserUuid and tCreateUserUuid == selfObj:GetUuid() then
        return true
    end
    return false
end
--获取房间座位数
function GetMaxUserNum(selfObj)

    local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
    if tGameRoomBaseInfo then
        return tGameRoomBaseInfo.iRoomSeats
    end
    return 0
end
--牌局持续时间
function GetGameRoomDuration( selfObj )
    local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
    if tGameRoomBaseInfo then
        return tGameRoomBaseInfo.lRoomTimeLimit
    end
    return 0
end
--房间是否开始
function GetIsGameStart(selfObj)
    local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
    if tGameRoomBaseInfo ~= nil then
        return (tGameRoomBaseInfo.bStartedGame > 0)
    end
    return false
end
function SetGameStarted(selfObj, isStart)
    local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
    if tGameRoomBaseInfo ~= nil then
        tGameRoomBaseInfo.bStartedGame = 1
    end
end
function SetStartTime(selfObj, startTime)
    local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
    if tGameRoomBaseInfo ~= nil then
        tGameRoomBaseInfo.lStartTime = startTime
    end
end
--牌局开始时间
function GetGameRoomStartTime(selfObj)
    local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
    if tGameRoomBaseInfo ~= nil then
        return tGameRoomBaseInfo.lStartTime
    end
    return 0
end

function SetSituationPag(selfObj, aiSituationPag)
    --弹出什么战况窗口
    selfObj.miSituationPag = aiSituationPag
end

function GetSituationPag(selfObj, aiSituationPag)
    --弹出什么战况窗口
    return selfObj.miSituationPag
end

--房间是否暂停
function GetIsGamePause(selfObj)
    local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
    if tGameRoomBaseInfo then
        return (tGameRoomBaseInfo.bPausedGame>0)
    end
    return false
end

-- 房间是否已结束
function GetIsGameClose( selfObj )
    local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
    if tGameRoomBaseInfo and tGameRoomBaseInfo.bClosedGame ~= nil then
        return (tGameRoomBaseInfo.bClosedGame>0)
    end
    return false
end

--房间是否控制买家带入
function GetIsBuyinControl(selfObj)
    local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
    if tGameRoomBaseInfo then
        return (tGameRoomBaseInfo.bBuyinControl>0)
    end
    return false
end

--获取房间分值
function GetGameRoomPoint(selfObj)
    local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
    if tGameRoomBaseInfo then
        return tGameRoomBaseInfo.lPoint
    end
    return 0
end
--获取房间带入倍数
function GetGameRoomBuyinTimes(selfObj)
    local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
    if tGameRoomBaseInfo then
        return tGameRoomBaseInfo.lBuyInMultiple
    end
    return 1
end
--最低入局分档位倍数
function GetlMinimumToContinue( selfObj )
    if selfObj.miGameRoomInfo == nil then
        return false
    end
    local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
    if tGameRoomBaseInfo ~= nil and tGameRoomBaseInfo.lMinimumToContinue ~= nil then
        return tGameRoomBaseInfo.lMinimumToContinue
    end
    return 0
end
--最低入局
function GetlMinCoinToContinue( selfObj )
    return selfObj:GetGameRoomPoint()*selfObj:GetlMinimumToContinue()
end

--获取房间发牌类型
function GetGameRoomDealCardsType(selfObj)
    local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
    if tGameRoomBaseInfo then
        return tGameRoomBaseInfo.eOfcDealCardsType
    end
    return nil
end

--获取房间游戏模式 (普通，血战，血进血出)
function GetGameModeType(selfObj)
    local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
    if tGameRoomBaseInfo then
        return tGameRoomBaseInfo.eOfcProgressiveMode
    end
    return nil
end

--获取房间 是否癞子
function GetGameIsJoker(selfObj)
    local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
    if tGameRoomBaseInfo then
        return (tGameRoomBaseInfo.bEnableJoker > 0)
    end
    return false
end

--是否开启IP限制
function GetIsIPLimit(selfObj)
    if selfObj.miGameRoomInfo == nil then
        return false
    end
    local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
    if tGameRoomBaseInfo ~= nil and tGameRoomBaseInfo.bIpLimit ~= nil then
        return (tGameRoomBaseInfo.bIpLimit>0)
    end
    return false
end

--是否开启GPS限制
function GetIsGPSLimit(selfObj)
    if selfObj.miGameRoomInfo == nil then
        return false
    end
    local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
    if tGameRoomBaseInfo ~= nil and tGameRoomBaseInfo.bGpsLimit ~= nil then
        return (tGameRoomBaseInfo.bGpsLimit>0)
    end
    return false
end

--获取房间状态(第几轮)
function GetGameRoomState(selfObj)
    if selfObj.miGameRoomInfo == nil then
        return nil
    end
    
    return selfObj.miGameRoomInfo.eOfcRoomGameState
end

--获取暂停时间
function GetGamePauseTime( selfObj )
    local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
    if tGameRoomBaseInfo then
        return tGameRoomBaseInfo.lPauseBeginTimeStamp
    end
end

--获取房间摆牌时长
function GetGamePlacingInterval( selfObj )
    local tGameRoomBaseInfo = selfObj:GetGameRoomBaseInfo()
    if tGameRoomBaseInfo then
        return tGameRoomBaseInfo.iPlacingTimeUpperLimit
    end
end

--获得时间修正值(秒)
function GetTimeDifference(selfObj)
    
    return 1111111
end

function SetGetBillInfoByRoom(selfObj, aiGetBillInfoByRoom)
    --账单信息
    selfObj.miGetBillInfoByRoom = aiGetBillInfoByRoom
end

function GetGetBillInfoByRoom(selfObj)
    --账单信息
    return selfObj.miGetBillInfoByRoom
end

-- 获取账单（战绩）中的所有玩家
function GetPlayersBillInfoOfByRoom( selfObj )
    if selfObj.miGetBillInfoByRoom ~= nil then
        if selfObj.miGetBillInfoByRoom.stOfcBillBaseInfoNet ~= nil then
            if selfObj.miGetBillInfoByRoom.stOfcBillBaseInfoNet.stOfcBillInfoNet ~= nil then
                if selfObj.miGetBillInfoByRoom.stOfcBillBaseInfoNet.stOfcBillInfoNet.vUserOfcBillInfoNet ~= nil then
                    return selfObj.miGetBillInfoByRoom.stOfcBillBaseInfoNet.stOfcBillInfoNet.vUserOfcBillInfoNet
                end
            end
        end
    end

    return nil
end

-- 旁观者玩家
function SetGetStandbyInfos(selfObj, aiGetStandbyInfos)
    --围观者信息数据
    selfObj.miGetStandbyInfos = aiGetStandbyInfos
end
-- 获取旁观者玩家
function GetGetStandbyInfos( selfObj )
    return selfObj.miGetStandbyInfos
end

-- 是否可以站起
function GetRoomCanKickOtherStand( selfObj, uuid )
    -- 不是坐下状态返回false
    if selfObj:GetStateStandby(uuid) == false then
        return false
    end

    if selfObj:GetIsGameStart() == false then
        return true
    end
    if selfObj:GetIsGameStart() == true and (selfObj:GetGameHandId() and selfObj:GetGameHandId() == 0) then
        return true
    end

    return false
end

-- 其他人玩家信息
function SetOtherUserBaseInfo(selfObj, aiOtherUserBaseInfo)
    selfObj.miOtherUserBaseInfo = aiOtherUserBaseInfo
end

-- 获取其他人玩家信息
function GetOtherUserBaseInfo(selfObj)
    return selfObj.miOtherUserBaseInfo
end
function GetOtherUserBaseInfoUuid(selfObj)
    return selfObj.miOtherUserBaseInfo.uuid
end

--道具表情数据列表
--selfObj.miUseItemList = {}
function ClearEmptyUseItem(selfObj)
    selfObj.miUseItemList = {}
end

function AddUseItemList(selfObj, aiData)
--    --道具表情数据列表
--    local tData = {}
--    tData.lFromUuid = tPushMsg.lFromUuid
--    tData.lToUuid = tPushMsg.lToUuid
--    tData.sExtra = tPushMsg.sExtra
--    tData.lMsgID = tPushMsg.lMsgID
    local Max_Num = 100
    if #selfObj.miUseItemList >= Max_Num then
        table.remove(selfObj.miUseItemList, 1)
    end
    table.insert(selfObj.miUseItemList, aiData)  
end
    
-- 获取表情数据
function GetUseItemData(selfObj)
    if #selfObj.miUseItemList < 1 then
        return nil
    end
    
    local tData = selfObj.miUseItemList[1]
    table.remove(selfObj.miUseItemList, 1)
    return tData
end

--本地存储暂停时间，每次进入游戏和获取房间数据都要设置
--添加暂停时间
function AddPauseDataList(selfObj, aiGameRoomBaseInfo)
    if aiGameRoomBaseInfo == nil then
        return
    end

    local tGamePause = aiGameRoomBaseInfo.bPausedGame
    local tIsExit = false
    if tGamePause > 0 then
        if #selfObj.miPauseDataList > 0 then
            if selfObj.miPauseDataList[#selfObj.miPauseDataList].miPauseBeginTime == aiGameRoomBaseInfo.lPauseBeginTimeStamp then
                tIsExit = true
            end
        end
        if tIsExit == false then
            local tData = {}
            tData.miPauseBeginTime = aiGameRoomBaseInfo.lPauseBeginTimeStamp
            tData.miPauseTimeTemp = nil
            table.insert(selfObj.miPauseDataList, tData)
        end
    end
end


--获得暂停所有时间差
function GetPauseAllTimeTemp(selfObj, aiBeginTime)
    --暂停时间差
    local tAllTimeTemp = 0
    local tTempList = {}
    for key, value in pairs(selfObj.miPauseDataList) do
        if aiBeginTime < value.miPauseBeginTime then
            if value.miPauseTimeTemp ~= nil then
                tAllTimeTemp = tAllTimeTemp + value.miPauseTimeTemp
            else
                local tPauseBeginTime = value.miPauseBeginTime
                local tNowTime = os.time()
                local tNewTime = tNowTime + selfObj:GetTimeDifference()
                local tInt64PauseTime = int64.new_signed(tostring(tPauseBeginTime))
                local tPauseTime = int64.tonumberint(tInt64PauseTime/1000)
                local tTempTime = tNewTime - tPauseTime
                tAllTimeTemp = tAllTimeTemp + tTempTime
            end
            table.insert(tTempList, value)
        end
    end
    selfObj.miPauseDataList = tTempList
    return tAllTimeTemp
end


function EmptyPauseDataList(selfObj)
    selfObj.miPauseDataList = {}
end


-------------------------------------------------
--------------房间玩家数据列表相关-----------------
-------------------------------------------------
function UpdateUserInfoByPos(selfObj, aiPos, aiUserInfo)
    selfObj.miPlayer:UpdateUserInfoByPos(aiPos, aiUserInfo)
end

function UpdateUserInfoByUuid(selfObj, uuid, aiUserInfo)
    selfObj.miPlayer:UpdateUserInfoByUuid(uuid, aiUserInfo)
end

-- 暂停恢复时更新强制买入时间
function UpdateUserForcedBuyInEnterTime( selfObj, uuid, aiForcedBuyInEnterTime )
    selfObj.miPlayer:UpdateUserForcedBuyInEnterTime(uuid, aiForcedBuyInEnterTime)
end

-- 暂停恢复时更新操作时间
function UpdateUserActionTime( selfObj, uuid, aiActionTime )
    selfObj.miPlayer:UpdateUserActionTime(uuid, aiActionTime)
end

function UpdateUserBaseInfoByUuid( selfObj, uuid, aiUserBaseInfo )
    selfObj.miPlayer:UpdateUserBaseInfoByUuid(uuid, aiUserBaseInfo)
end

function GetUserUuidByPos(selfObj, aiPos)
    return selfObj.miPlayer:GetUserUuidByPos(aiPos)
end

function GetUserPosByUuid(selfObj, uuid)
    return selfObj.miPlayer:GetUserPosByUuid(uuid)
end

function GetStateStandby(selfObj, uuid)
    return selfObj.miPlayer:GetStateStandby(uuid)
end

function GetUserGameInfoByUuid(selfObj, uuid)
    return selfObj.miPlayer:GetUserGameInfoByUuid(uuid)
end

function GetUserGameInfoNetFromUuid(selfObj, uuid)
    return selfObj.miPlayer:GetUserGameInfoNetFromUuid(uuid)
end

function GetUserHeadUrlByUuid(selfObj, uuid)
    return selfObj.miPlayer:GetUserHeadUrlByUuid(uuid)
end

function GetRemainStackByUuid(selfObj, uuid)
    return selfObj.miPlayer:GetRemainStackByUuid(uuid)
end

function GetNameByUuid(selfObj, uuid)
    return selfObj.miPlayer:GetNameByUuid(uuid)
end

function GetGenderByUuid(selfObj, uuid)
    return selfObj.miPlayer:GetGenderByUuid(uuid)
end

function GetUserGameStateByUuid(selfObj, uuid)
    return selfObj.miPlayer:GetUserGameStateByUuid(uuid)
end

function GetBuyinTime(selfObj, uuid)
    return selfObj.miPlayer:GetBuyinTime(uuid)
end

function GetUserPlacingCardsByUuid(selfObj, uuid)
    return selfObj.miPlayer:GetUserPlacingCardsByUuid(uuid)
end

function GetUserBettingIdByUuid(selfObj, uuid)
    return selfObj.miPlayer:GetUserBettingIdByUuid(uuid)
end

function GetIsFantasyState(selfObj, uuid)
    return selfObj.miPlayer:GetIsFantasyState(uuid)
end

function GetIsNextFantasyState(selfObj, uuid)
    return selfObj.miPlayer:GetIsNextFantasyState(uuid)
end

function GetFantasyTimes(selfObj, uuid)
    return selfObj.miPlayer:GetFantasyTimes(uuid)
end

function GetAllUsedCards(selfObj)
    return selfObj.miPlayer:GetAllUsedCards()
end

-- 是否是等待买入状态
function GetIsWaitingBuyinConfirmation( selfObj, uuid )
    return selfObj.miPlayer:GetIsWaitingBuyinConfirmation(uuid)
end

--获取房间是否坐满
function GetIsGameRoomFullSeat(selfObj)
    return selfObj.miPlayer:GetIsGameRoomFullSeat()
end

--更新本地玩家的状态
function UpdateUserStateByUuid(selfObj, aiUuid, aiNewUserState)
    selfObj.miPlayer:UpdateUserStateByUuid(aiUuid, aiNewUserState)
end

--设置修改延时属性数据
function UpdateSelfDelayData( selfObj, aiDealyData )
    selfObj.miPlayer:UpdateSelfDelayData(aiDealyData)
end

--获取是否dealer位
function GetUserIsDeal(selfObj, aiUuid)
    return selfObj.miPlayer:GetUserIsDeal(aiUuid)
end

--获得好友数据
function GetFriendUserData(selfObj, uuid, aiRoomType, aiDataType)
    
    return nil
end

--获取玩家操作时间点
function GetUserActionTime(selfObj, aiUuid)
    return selfObj.miPlayer:GetUserActionTime(aiUuid)
end

--获取玩家延时的长度
function GetUserDelayTime(selfObj, aiUuid)
    return selfObj.miPlayer:GetUserDelayTime(aiUuid)
end

--获取玩家当前点击延时道具的价格
function GetUserDelayPrice(selfObj, aiUuid)
    return selfObj.miPlayer:GetUserDelayPrice(aiUuid)
end

-- 获取当前玩家是否处于的强制买入（分数小于最低入局分）
function GetUserbInForcedBuyIn( selfObj, aiUuid )
    return selfObj.miPlayer:GetUserbInForcedBuyIn(aiUuid)
end

-- 获取玩家强制买入倒计时
function GetUserlForcedBuyInEnterTime( selfObj, aiUuid )
    return selfObj.miPlayer:GetUserlForcedBuyInEnterTime(aiUuid)
end

--获得延自己钻石数
function GetDiamond(selfObj)

    return 99999
end

--获取是否托管
function GetUserIsDelegateByUuid(selfObj, aiUuid)
    return selfObj.miPlayer:GetUserIsDelegateByUuid(aiUuid)
end

--获取是否离座
function GetUserIsLeaveDeskByUuid(selfObj, aiUuid)
    return selfObj.miPlayer:GetUserIsLeaveDeskByUuid(aiUuid)
end

--在桌所有玩家离座的人数
function GetLeaveTableUserNums(selfObj)
    return selfObj.miPlayer:GetLeaveTableUserNums()
end

--获取指定玩家的牌数据
function GetUserRowCardsByUuid(selfObj, aiUuid)
    return selfObj.miPlayer:GetUserRowCardsByUuid(aiUuid)
end

--获取牌桌上玩家是否都是范特西状态
function GetIsAllUserIsFantasy(selfObj)
    return selfObj.miPlayer:GetIsAllUserIsFantasy()
end

--获取玩家最终的得分  每道大小比分，每道牌型比分，全胜分
function GetUserResultScore(selfObj, aiUuid)
    return selfObj.miPlayer:GetUserResultScore(aiUuid)
end

-- 是否满足弹出记牌器条件
function GetUserShowPokerMarker( selfObj )
    if selfObj:GetStateStandby() and selfObj:GetRemainStackByUuid() > 0 and selfObj:GetIsFantasyState() == false and selfObj:GetGameHandId() > 0 then
        return true
    end

    return false
end
-------------------------------------------------
-------------房间内屏蔽语音玩家列表---------------
-------------------------------------------------
--保存房间所有静音玩家列表
function SetAllUserSoundOnOff(selfObj)
    
    My_Lua_log(" file=[gameroom] fun=[SetAllUserSoundOnOff]; ")
end
--添加屏蔽音效玩家到列表
function SetInsertUserSoundOnOffList(selfObj,uuid)
    if uuid == nil then
        return 
    end
    table.insert(selfObj.miUserSoundOnOffList,uuid)

    My_Lua_log(" file=[gameroom] #miUserSoundOnOffList Insert ="..#selfObj.miUserSoundOnOffList)
end
--从列表移除屏蔽音效玩家
function SetRemoveUserSoundOnOffList(selfObj,uuid)
    
    if uuid == nil then
        return 
    end
    if selfObj.miUserSoundOnOffList == nil or #selfObj.miUserSoundOnOffList == 0 then
        return
    end
    for i=1,#selfObj.miUserSoundOnOffList do
        if uuid == selfObj.miUserSoundOnOffList[i] then
            table.remove(selfObj.miUserSoundOnOffList,i)
        end
    end

    My_Lua_log(" file=[gameroom] #miUserSoundOnOffList Remove = "..#selfObj.miUserSoundOnOffList)
end

--判断玩家是否被静音
function GetIsSoundOffByUuid(selfObj,uuid)
    if selfObj.miUserSoundOnOffList == nil then
        return false
    end 

    for idx, value in pairs(selfObj.miUserSoundOnOffList) do
        if uuid == value then
            return true
        end
    end
    return false
end
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
    --gameroomId
    selfObj.miGameRoomId = 0
    
    --用户数据
    Player = require("comm.player")
    selfObj.miPlayer = Player.Create()


    selfObj.miBuywayPag='buypag'


    --账单信息
    selfObj.miGetBillInfoByRoom = nil
    --围观者信息数据
    selfObj.miGetStandbyInfos = nil
    --实时战况上次打开GameHandId
    selfObj.miOldGameHandId = -1

    --弹出什么战况窗口
    selfObj.miSituationPag='realtimesituationmainpag'

    --静音开关
    selfObj.miIsOpenSound = true

    --是站起围观，还是退出
    selfObj.miIsExit = false

    --是否坐下买入(区别于坐下输完补充买入)
    selfObj.miIsSitDownBuy = false

    --是否请求打开其它玩家消息界面
    selfObj.miIsOpenOtherInfoPag = false
    selfObj.miOtherUserBaseInfo = nil


    --暂停时间差
    selfObj.miPauseDataList = {}

    --系统消息
    selfObj.miPushSystemMsgList = {}

     ------------------测试
    selfObj.miTextLogTextList = {}

    --sng
    --是否已经淘汰
    selfObj.miSngDead = false

    --放弃效果数据
    selfObj.miDelayFoldData = nil

    --是否已经点击坐下
    selfObj.miButtonSitTime = 0

    --allin胜率数据
    selfObj.miWinOddsDataList = {}

    --保险开关
    selfObj.miInsuranceOffonSetting = 0

    --踢人列表
    selfObj.miKickOutIDList = {}

    --道具表情数据列表
    selfObj.miUseItemList = {}

    --牌局俱乐部数据
    selfObj.miClubBaseInfoList = {}

    --获取所有静音玩家列表 uuid
    selfObj.miUserSoundOnOffList = {}

    --mtt roomid
    selfObj.miMTTGameRoomId = 0
    --mtt 结束账单
    selfObj.miMTTGameBillInfo = nil
    --mtt自动重进开关
    selfObj.miMttSetting = false
    --mtt allin动画是否结束 防止allin没结束 弹出重进弹窗
    selfObj.miMttIsAllinOver = true
    --mtt allin动画是否结束 防止allin没结束 弹出淘汰弹窗
    selfObj.miMttIsAllinOverForRank = true
    selfObj.miMttOverRank = nil
    --mtt allin动画是否结束 防止allin没结束 弹出牌桌失效
    selfObj.miMttIsAllinOverForNoDesk = true
    --mtt 是否切桌
    selfObj.miIsMoveTable = false
    selfObj.miMoveTableTipsText = nil
    --mtt 玩家当前所打或者围观的牌桌(人在哪围观或打就那个桌)
    selfObj.miCurTableIndex = 0
    --mtt 玩家所打的牌桌
    selfObj.miSelfRealTableIndex = 0

    --是否结束（allin情况下有可能，先收到结束的push，动画还没播放完成）
    selfObj.miDelayMessageOverPag = false

    --mtt站起列队
    selfObj.miMttStandUpList = {}
    --mtt allin动画是否结束 防止allin没结束 就切走了
    selfObj.miMttIsAllinOverForChangeDesk = true

    --MTT消息列队延期处理
--    local tData={}
--    tData.miMessageType= --消息类型
--    tData.miMessageData= --消息数据
    selfObj.miMttDelayDispatch = {}

    --老的坐下站起状态
    selfObj.miOldSitDownState = -1
end

function SetOldSitDownState(selfObj, aiSitDownState)
    selfObj.miOldSitDownState = aiSitDownState
end

function GetOldSitDownState(selfObj)
    return selfObj.miOldSitDownState
end

function SetUuid(selfObj, aiUuid)
    
end


function SetGameRoomId(selfObj, aiGameRoomId)
    selfObj.miGameRoomId = aiGameRoomId
end

function GetGameRoomId(selfObj)
    return selfObj.miGameRoomId
end
--设置房间数据
function SetGameRoomInfo(selfObj, aiGameRoomInfo)
    selfObj.miPlayer:SetGameRoomInfo(aiGameRoomInfo)
end
function GetGameRoomInfo(selfObj)
    return selfObj.miPlayer:GetGameRoomInfo()
end

 --是否坐下买入(区别于坐下输完补充买入)
function SetIsSitDownBuy(selfObj, aiIsSitDownBuy)
    selfObj.miIsSitDownBuy = aiIsSitDownBuy
end

function GetIsSitDownBuy(selfObj)
    return selfObj.miIsSitDownBuy
end

--是否请求打开其它玩家消息界面
function SetIsOpenOtherInfoPag(selfObj, aiIsOpenOtherInfoPag)
    selfObj.miIsOpenOtherInfoPag = aiIsOpenOtherInfoPag
end

function GetIsOpenOtherInfoPag(selfObj)
    return selfObj.miIsOpenOtherInfoPag
end

function SetOtherUserBaseInfo(selfObj, aiOtherUserBaseInfo)
    selfObj.miOtherUserBaseInfo = aiOtherUserBaseInfo
end

function GetOtherUserBaseInfo(selfObj)
    return selfObj.miOtherUserBaseInfo
end
function GetOtherUserBaseInfoUuid(selfObj)
    return selfObj.miOtherUserBaseInfo.uuid
end

function SetIsExit(selfObj, aiIsExit)
    selfObj.miIsExit = aiIsExit
end

function GetIsExit(selfObj, aiIsExit)
    return selfObj.miIsExit
end

function SetDelayFoldData(selfObj, aiDelayFoldData)
    selfObj.miDelayFoldData = aiDelayFoldData
end

function GetDelayFoldData(selfObj)
    return selfObj.miDelayFoldData
end

function SetButtonSitTime(selfObj, aiButtonSitTime)
    selfObj.miButtonSitTime = aiButtonSitTime
end

function GetButtonSitTime(selfObj)
    return selfObj.miButtonSitTime
end

function EmptyWinOddsDataList(selfObj)
    selfObj.miWinOddsDataList = {}
end

--获得allin数据
function GetWinOddsforUuid(selfObj, aiUuid)
    local tMaxOdds = 0
    for key, value in pairs(selfObj.miWinOddsDataList) do
        if value > tMaxOdds then
            tMaxOdds = value
        end
    end
    --allin胜率数据
    local tOdds = selfObj.miWinOddsDataList[aiUuid]
    if tOdds == nil then
        return 0
    end
    return tOdds, (tMaxOdds==tOdds)
end

function SetBuywayPag(selfObj, aiBuywayPag)
    selfObj.miBuywayPag = aiBuywayPag
end

function GetBuywayPag(selfObj)
    return selfObj.miBuywayPag
end

function SetIsSitDownBuy(selfObj, aiIsSitDownBuy)
    selfObj.miIsSitDownBuy = aiIsSitDownBuy
end

--是否是买入等待申请时间
function GetBuyinTime(selfObj)
    return selfObj.miPlayer:GetBuyinTime()
end

--获得房间类型
function GetGameRoomType(selfObj)
    return selfObj.miPlayer:GetGameRoomType()
end

--添加暂停时间
function AddPauseDataList(selfObj, aiGameRoomBaseInfo)
    My_Lua_log(" file=[gameroom] fun=[addpausedatalist]; ")
    if aiGameRoomBaseInfo == nil then
        return
    end

    local tGamePause = aiGameRoomBaseInfo.bGamePause
    local tIsExit = false
    if tGamePause > 0 then
        if #selfObj.miPauseDataList > 0 then
            if selfObj.miPauseDataList[#selfObj.miPauseDataList].miPauseBeginTime == aiGameRoomBaseInfo.lGamePauseTime then
                tIsExit = true
            end
        end
        if tIsExit == false then
            local tData = {}
            tData.miPauseBeginTime = aiGameRoomBaseInfo.lGamePauseTime
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
                local tNewTime = tNowTime + selfObj.miPlayer:GetTimeDifference()
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

--根据uuid获得在桌上的用户数据
function GetUserGameInfoNetFromUuid(selfObj, aiUuid)
    return selfObj.miPlayer:GetUserGameInfoNetFromUuid(aiUuid)
end

function GetIsWaitingBuyinConfirmation(selfObj)
    return selfObj.miPlayer:GetIsWaitingBuyinConfirmation()
end

function UpdateGameRoomInfoUserGameInfoNet(selfObj, aiPos, aiData)
    selfObj.miPlayer:UpdateGameRoomInfoUserGameInfoNet(aiPos, aiData)
end

function GetUserRemainStacks(selfObj)
    return selfObj.miPlayer:GetUserRemainStacks()
end

function SetSituationPag(selfObj, aiSituationPag)
    --弹出什么战况窗口
    selfObj.miSituationPag = aiSituationPag
end

function GetSituationPag(selfObj)
    --弹出什么战况窗口
    return selfObj.miSituationPag
end

--房主暂停功能
function GetIsGamePause(selfObj)
    return selfObj.miPlayer:GetIsGamePause()
end

--房主暂停功能开始时间
function GetGamePauseTime(selfObj)
    return selfObj.miPlayer:GetGamePauseTime()
end

--获得时间修正值(秒)
function GetTimeDifference(selfObj)
    return selfObj.miPlayer:GetTimeDifference()
end


function SetGetBillInfoByRoom(selfObj, aiGetBillInfoByRoom)
    --账单信息
    selfObj.miGetBillInfoByRoom = aiGetBillInfoByRoom
end

function GetGetBillInfoByRoom(selfObj)
    --账单信息
    return selfObj.miGetBillInfoByRoom
end

function SetGetStandbyInfos(selfObj, aiGetStandbyInfos)
    --围观者信息数据
    selfObj.miGetStandbyInfos = aiGetStandbyInfos
end

function GetGetStandbyInfos(selfObj)
    --围观者信息数据
    return selfObj.miGetStandbyInfos
end

function SetOldGameHandId(selfObj, aiOldGameHandId)
    --实时战况上次打开GameHandId
    selfObj.miOldGameHandId = aiOldGameHandId
end

function GetOldGameHandId(selfObj)
    --实时战况上次打开GameHandId
    return selfObj.miOldGameHandId
end


--根据uuid获得在桌上的位置
function GetUserPosFromUuid(selfObj, aiUuid)
    return selfObj.miPlayer:GetUserPosFromUuid(aiUuid)
end

function GetSNGUserIsDeadState(selfObj)
    return selfObj.miPlayer:GetSNGUserIsDeadState()
end

--是否已经淘汰
function SetSNGIsSngDead(selfObj, aiSngDead)
    selfObj.miSngDead = aiSngDead
end
function GetSNGIsSngDead(selfObj)
    return selfObj.miSngDead
end

function GetGameRoomUserMaxNums(selfObj)
    return selfObj.miPlayer:GetGameRoomUserMaxNums()
end

--奖金池分配
function GetWinLadderDistribution(selfObj)
    return selfObj.miPlayer:GetWinLadderDistribution()
end

--房间名字
function GetGameRoomName(selfObj)
    return selfObj.miPlayer:GetGameRoomName()
end

--牌局是否开始
function GetIsStarted(selfObj)
    return selfObj.miPlayer:GetIsStarted()
end

function SetStarted(selfObj)
    selfObj.miPlayer:SetStarted()
end

function SetStartTime(selfObj, aiStartTime)
    selfObj.miPlayer:SetStartTime(aiStartTime)
end

--牌局开始时间
function GetGameRoomStartTime(selfObj)
    return selfObj.miPlayer:GetGameRoomStartTime()
end

--牌局创建时间
function GetGameRoomCreateTime(selfObj)
    return selfObj.miPlayer:GetGameRoomCreateTime()
end

--涨盲时间
function GetSNGBlindInterval(selfObj)
    return selfObj.miPlayer:GetSNGBlindInterval()
end

--是否全部人allin
function GetIsAllAllinState(selfObj)
    return selfObj.miPlayer:GetIsAllAllinState()
end

function SetAllAllinState(selfObj, aiAllAllin)
    selfObj.miPlayer:SetAllAllinState(aiAllAllin)
end

--获得玩家是否坐下
function GetStateStandby(selfObj, aiUuid)
    if aiUuid == nil then
        aiUuid = selfObj:GetUuid()
    end
    return selfObj.miPlayer:GetStateStandby(aiUuid)
end

--获得玩家是否在桌上
function GetIsInCurDesk(selfObj, aiUuid)
    if aiUuid == nil then
        aiUuid = selfObj:GetUuid()
    end
    return selfObj.miPlayer:GetIsInCurDesk(aiUuid)
end

--SNG玩家是否旁观者
function GetSNGUserIsStandby(selfObj)
    return selfObj.miPlayer:GetSNGUserIsStandby()
end

--获得SNG需要等待人数
function GetSNGRemainingNum(selfObj)
    return selfObj.miPlayer:GetSNGRemainingNum()
end

--准备时间
function GetSNGPrepareTime(selfObj)
    return selfObj.miPlayer:GetSNGPrepareTime()
end

--获得玩家是否等待
function GetIsUserWaitState(selfObj)
    return selfObj.miPlayer:GetIsUserWaitState()
end

--获得玩家是否Allin
function GetIsUserAllinState(selfObj)
    return selfObj.miPlayer:GetIsUserAllinState()
end

--获得实时的排名
function GetSNGRanking(selfObj, aiUuid)
    return selfObj.miPlayer:GetSNGRanking(aiUuid)
end

--获得房间小盲注
function GetSmallBlinds(selfObj)
    return selfObj.miPlayer:GetSmallBlinds()
end

--获得房间大盲注
function GetBigBlinds(selfObj)
    return selfObj.miPlayer:GetBigBlinds()
end

--获得房间创建状态
function GetCreateRoomType(selfObj)
    return selfObj.miPlayer:GetCreateRoomType()
end

--获得邀请码
function GetCryptCode(selfObj)
    return selfObj.miPlayer:GetCryptCode()
end

--获得俱乐部名称
function GetClubName(selfObj)
    return selfObj.miPlayer:GetClubName()
end

--获得俱乐部id
function GetClubId(selfObj)
    return selfObj.miPlayer:GetClubId()
end

--获得主池数量
function GetCurrentPots(selfObj, aiGameRoomInfo)
    return selfObj.miPlayer:GetCurrentPots(aiGameRoomInfo)
end

function GetCurrentPotsEx(selfObj)
    return selfObj.miPlayer:GetCurrentPotsEx()
end

--获得当前状态下下筹码数
function GetCurAllBetStack(selfObj, aiGameRoomInfo)
    return selfObj.miPlayer:GetCurAllBetStack(aiGameRoomInfo)
end

function GetCurAllBetStackEx(selfObj, aiGameRoomInfo)
    return selfObj.miPlayer:GetCurAllBetStackEx()
end

--获得所有手牌数据
function GetAllUserCurrentHands(selfObj)
    return selfObj.miPlayer:GetAllUserCurrentHands()
end

function GetAllUserCurrentHandsEx(selfObj, aiUserGameInfos)
    return selfObj.miPlayer:GetAllUserCurrentHandsEx(aiUserGameInfos)
end

--获得现在牌桌上公共牌
function GetPublicCurrentCards(selfObj)
    return selfObj.miPlayer:GetPublicCurrentCards()
end

--四舍五入函数
function RoundedNumber(selfObj, aiNumber)
    return selfObj.miPlayer:RoundedNumber(aiNumber)
end

--没有放弃的玩家个数
function SelfNoFoldUserNum(selfObj)
    return selfObj.miPlayer:SelfNoFoldUserNum()
end

--没有放弃的玩家个数
function NoFoldUserNum(selfObj, aiUserGameInfos)
    return selfObj.miPlayer:NoFoldUserNum(aiUserGameInfos)
end

--获得用户牌型
function GetMaxPokerType(selfObj, uuid)
    return selfObj.miPlayer:GetMaxPokerType(uuid)
end

--获得用户牌型
function GetMaxPokerTypeEx(selfObj, aiHandCards, aiPublicCards)
    return selfObj.miPlayer:GetMaxPokerTypeEx(aiHandCards, aiPublicCards)
end

--获得房间状态
function GetGameState(selfObj)
    return selfObj.miPlayer:GetGameState()
end

--盲注等级
function GetSNGCurrentLevel(selfObj)
    return selfObj.miPlayer:GetSNGCurrentLevel()
end

--最小最大买入手数数据和是否有高级设置
function GetBuyinRatioData(selfObj)
    return selfObj.miPlayer:GetBuyinRatioData()
end

--房间是否控制买家带入
function GetIsBuyinControl(selfObj)
    return selfObj.miPlayer:GetIsBuyinControl()
end

--获得最大买入数
function GetMaxBuy(selfObj, aiMaxBuy)
    return selfObj.miPlayer:GetMaxBuy(aiMaxBuy)
end

--获得财富（德扑币）是字符串
function GetCoin(selfObj)
    return selfObj.miPlayer:GetCoin()
end

--获得是否有钻石
function GetIsHaveDiamond(selfObj)
    return selfObj.miPlayer:GetIsHaveDiamond()
end

--获得延时需要的钻石
function GetDelayCost(selfObj)
    return selfObj.miPlayer:GetDelayCost()
end

--获得延自己钻石数
function GetDiamond(selfObj)
    return selfObj.miPlayer:GetDiamond()
end

--获得延长时间
function GetDelaySingleTime(selfObj)
    return selfObj.miPlayer:GetDelaySingleTime()
end

function GetBettingID(selfObj)
    return selfObj.miPlayer:GetBettingID()
end

--牌局持续时间
function GetGameRoomDuration(selfObj)
    return selfObj.miPlayer:GetGameRoomDuration()
end

--ante
function GetAnte(selfObj)
    return selfObj.miPlayer:GetAnte()
end

--自己是不是房主
function GetIsCreateUser(selfObj)
    return selfObj.miPlayer:GetIsCreateUser()
end

--获得自己url
function GetSelfUrl(selfObj)
    return selfObj.miPlayer:GetSelfUrl()
end

--获得自己性别
function GetSelfGender(selfObj)
    return selfObj.miPlayer:GetSelfGender()
end

--获得好友数据
function GetFriendUserData(selfObj, uuid,aiRoomType,aiDataType)
    return selfObj.miPlayer:GetFriendUserData(uuid,aiRoomType,aiDataType)
end

--获得GameHandId
function GetGameHandId(selfObj)
    return selfObj.miPlayer:GetGameHandId()
end

--最大下注
function GetMaxBet(selfObj)
    return selfObj.miPlayer:GetMaxBet()
end

--滑竿需要的有效加注额
function GetSlideEffectiveRaise(selfObj)
    return selfObj.miPlayer:GetSlideEffectiveRaise()
end

--有效加注额
function GetEffectiveRaise(selfObj)
    return selfObj.miPlayer:GetEffectiveRaise()
end

--是否可以自由操作(true:可以自由操作)
function GetIsFreeRaise(selfObj)
    return selfObj.miPlayer:GetIsFreeRaise()
end

--获得是否有玩家有效操作过
function EffectiveOperation(selfObj)
    return selfObj.miPlayer:EffectiveOperation()
end

--获得是否有玩家有效操作过
function EffectiveOperationFormUuid(selfObj, aiUuid)
    return selfObj.miPlayer:EffectiveOperationFormUuid(aiUuid)
end

function ConversionNumToStr(selfObj, aiCoin)
    return selfObj.miPlayer:ConversionNumToStr(aiCoin)
end


function GetUserGameInfoNetFromPagPosID(selfObj, aiPos)
    return selfObj.miPlayer:GetUserGameInfoNetFromPagPosID(aiPos)
end

--获得用户牌型
function GetMaxPokerFromUserCurrentCardsType(selfObj, aiUserCurrentCards)
    return selfObj.miPlayer:GetMaxPokerFromUserCurrentCardsType(aiUserCurrentCards)
end


--根据uuid获得手上的牌
function GetUserCurrentHandsFromUuid(selfObj, aiUuid)
    return selfObj.miPlayer:GetUserCurrentHandsFromUuid(aiUuid)
end


--是否保险局
function IsInsuranceRoom(selfObj)
    return selfObj.miPlayer:IsInsuranceRoom()
end


--获得房间保险玩家的基本信息
function GetGameRoomInsuranceInfos(selfObj)
    return selfObj.miPlayer:GetGameRoomInsuranceInfos()
end

function GetInsuranceStatus(selfObj)
    return selfObj.miPlayer:GetInsuranceStatus()
end

--获得用户保险数据
function GetInsuranceUserInfo(selfObj, aiUuid)
    return selfObj.miPlayer:GetInsuranceUserInfo(aiUuid)
end

--获得用户保险操作状态
function GetInsuranceBetStatus(selfObj, aiUuid)
    return selfObj.miPlayer:GetInsuranceBetStatus(aiUuid)
end

--每个用户的保险的池子信息
function GetInsurancePotInfos(selfObj, aiUuid)
    return selfObj.miPlayer:GetInsurancePotInfos(aiUuid)
end

--获得购买所有底池  保本需要的数
function GetInsurancePotInfosNoLosses(selfObj, aiUuid)
    return selfObj.miPlayer:GetInsurancePotInfosNoLosses(aiUuid)
end

--获得购买所有底池 需要的数
function GetInsurancePotInfosAllMax(selfObj, aiUuid)
    return selfObj.miPlayer:GetInsurancePotInfosAllMax(aiUuid)
end

--获得购买底池筹码数
function GetInsurancePotInfosBetStacks(selfObj, aiUuid)
    return selfObj.miPlayer:GetInsurancePotInfosBetStacks(aiUuid)
end

--获得延时需要的钻石
function GetInsuranceDelayCost(selfObj)
    return selfObj.miPlayer:GetInsuranceDelayCost()
end

--获得延长时间
function GetInsuranceDelaySingleTime(selfObj)
    return selfObj.miPlayer:GetInsuranceDelaySingleTime()
end

--保险购买延时修改
function UpdateInsuranceUserInfoDelayLong(selfObj, aiUuid, aiInsuranceActDuration, aiInsuranceDelayCost, aiInsuranceDelayLong)
    return selfObj.miPlayer:UpdateInsuranceUserInfoDelayLong( aiUuid, aiInsuranceActDuration, aiInsuranceDelayCost, aiInsuranceDelayLong)
end

function GetInsuranceStartTime(selfObj, aiUuid)
    return selfObj.miPlayer:GetInsuranceStartTime( aiUuid )
end

function GetInsuranceActDuration(selfObj, aiUuid)
    return selfObj.miPlayer:GetInsuranceActDuration( aiUuid )
end

--更新用户保险数据
function UpdateInsuranceUserInfo(selfObj, aiUuid, aiInsuranceUserInfo)
    return selfObj.miPlayer:UpdateInsuranceUserInfo( aiUuid, aiInsuranceUserInfo )
end

--用户设置购买保险开关
function GetDefaultInsurance(selfObj)
    return (selfObj.miInsuranceOffonSetting>0)
end

function SetDefaultInsurance(selfObj, aiDefaultInsurance)
    selfObj.miInsuranceOffonSetting=aiDefaultInsurance
end


function GetPotInfos(selfObj)
    return selfObj.miPlayer:GetPotInfos()
end

--获得保险是否碎了
function GetIsTotalGetStacks(selfObj, aiUuid)
    return selfObj.miPlayer:GetIsTotalGetStacks(aiUuid)
end

function GetNotifyUuids(selfObj)
    return selfObj.miPlayer:GetNotifyUuids()
end

function GetNotifyPotUuids(selfObj)
    return selfObj.miPlayer:GetNotifyPotUuids()
end

function SetBuyinControlRatio(selfObj, aiMin, aiMax)
    selfObj.miPlayer:SetBuyinControlRatio(aiMin, aiMax)
end

--获得是否托管状态
function SelfIsDelegate(selfObj)
    return selfObj.miPlayer:SelfIsDelegate()
end

--获得是否留座离桌状态
function SelfIsTemporarilyLeave(selfObj)
    return selfObj.miPlayer:SelfIsTemporarilyLeave()
end

--获得非留座离桌状态人数个数
function GetNotTemporarilyLeaveNums(selfObj)
    return selfObj.miPlayer:GetNotTemporarilyLeaveNums()
end

--踢人列表
function SetKickOutIDList(selfObj, kickIdList)
    selfObj.miKickOutIDList = kickIdList
end

function IsInKickOutList(selfObj, vKickUserID)
    My_Lua_log(" file=[gameroom] fun=[SetKickOutIDList]; vKickUserID=" .. vKickUserID)
    if selfObj.miKickOutIDList == nil then
        return false
    end

    for i=1,#selfObj.miKickOutIDList do
        if selfObj.miKickOutIDList[i] == vKickUserID then
            return true
        end
    end
    return false  
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
    table.insert(selfObj.miUseItemList, tData)  
end

function GetUseItemData(selfObj)
    if #selfObj.miUseItemList < 1 then
        return nil
    end
    
    local tData = selfObj.miUseItemList[1]
    table.remove(selfObj.miUseItemList, 1)
    return tData
end

--是否开启IP限制
function GetIsIPLimit(selfObj)
    return selfObj.miPlayer:GetIsIPLimit()
end

--是否开启GPS限制
function GetIsGPSLimit(selfObj)
    return selfObj.miPlayer:GetIsGPSLimit()
end

--当前牌局人数
function GetCurUserNums(selfObj)
    return selfObj.miPlayer:GetCurUserNums()
end

--获取牌局最大人数
function GetGameRoomUserMaxNums(selfObj)
    return selfObj.miPlayer:GetGameRoomUserMaxNums()
end

--获得是否联盟局
function GetIsLeagueID(selfObj)
    return selfObj.miPlayer:GetIsLeagueID()
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

--思考时长
function SetThinkingInterval(selfObj,aiInterval)

    selfObj.miPlayer:SetThinkingInterval(aiInterval)
end
function GetThinkingInterval(selfObj)
    return selfObj.miPlayer:GetThinkingInterval()
end


--房间是否设置straddle
function SetIsStraddle(selfObj, aiStraddle)
    selfObj.miPlayer:SetIsStraddle(aiStraddle)
end

function GetIsSetStraddle(selfObj)
    return selfObj.miPlayer:GetIsSetStraddle()
end

--通过uuid判断是否straddle位
function GetIsStraddleByUuid(selfObj,uuid)
    return selfObj.miPlayer:GetIsStraddleByUuid(uuid)
end

--获取现在是否真正的straddle
function GetIsRealStraddle(selfObj)
    return selfObj.miPlayer:GetIsRealStraddle()
end

--保存房间所有静音玩家列表
function SetAllUserSoundOnOff(selfObj)
    
    My_Lua_log(" file=[gameroom] fun=[SetAllUserSoundOnOff]; #tUserUuidList111="..#selfObj.miUserSoundOnOffList)


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

function SetPreActionState(selfObj,aiActionState)
    
    return selfObj.miPlayer:SetPreActionState(aiActionState)
end

function GetPreActionState(selfObj)
    
    return selfObj.miPlayer:GetPreActionState(aiActionState)
end

function UpdatePreActionState(selfObj, aiState)
    selfObj.miPlayer:UpdatePreActionState(aiState)
end

--mtt
function SetMTTGameRoomId(selfObj, aiMTTGameRoomId)
    selfObj.miMTTGameRoomId = aiMTTGameRoomId
end

function GetMTTGameRoomId(selfObj)
    return selfObj.miMTTGameRoomId
end

function GetMttStartTime(selfObj)
    return selfObj.miPlayer:GetMttStartTime()
end

--设置MTT房间基本信息 gameroombaseinfo
function SetMTTGameRoomBaseInfo(selfObj, aiData)
    selfObj.miPlayer:SetMTTGameRoomBaseInfo(aiData)
end

function GetMTTGameRoomBaseInfo(selfObj)
    return selfObj.miPlayer:GetMTTGameRoomBaseInfo()
end
--获取迟注册结束点
function GetMttDelayTime(selfObj)
    return selfObj.miPlayer:GetMttDelayTime()
end
--获取mtt延时报名等级
function GetMttDelayLevel(selfObj)
    return selfObj.miPlayer:GetMttDelayLevel()
end

--获取比赛开始时间点
function GetMttStartTime(selfObj)
    return selfObj.miPlayer:GetMttStartTime()
end

--获取是否可重进
function GetIsAllowReentry(selfObj)
    return selfObj.miPlayer:GetIsAllowReentry()
end
----获取mtt剩余重进次数
function GetMttReentryTimes(selfObj)
    return selfObj.miPlayer:GetMttReentryTimes()
end

--获取是否旁观者
function GetIsStandBy(selfObj)
    return selfObj.miPlayer:GetIsStandBy()
end
--获取是否旁观者 没报过名
function GetIsBystander(selfObj)
    return selfObj.miPlayer:GetIsBystander()
end
--报过名 但是被淘汰 旁观
function GetIsSignupNotInGame(selfObj)
    return selfObj.miPlayer:GetIsSignupNotInGame()
end
--目前还在参赛的玩家
function GetPlayingUserNums(selfObj)
    return selfObj.miPlayer:GetPlayingUserNums()
end

--实时赛况信息
function SetMTTRealtimeInfos(selfObj, aiData)
    selfObj.miPlayer:SetMTTRealtimeInfos(aiData)
end
function GetMTTRealtimeInfos(selfObj)
    return selfObj.miPlayer:GetMTTRealtimeInfos()
end

function GetMttNextBlindTime(selfObj)
    return selfObj.miPlayer:GetMttNextBlindTime()
end

--获取当前盲注结构
function GetCurrentBlindLevelInfos(selfObj)
    return selfObj.miPlayer:GetCurrentBlindLevelInfos()
end

--牌桌列表
function SetMTTTableInfos(selfObj, aiData)
    selfObj.miPlayer:SetMTTTableInfos(aiData)
end
function GetMTTTableInfos(selfObj)
    return selfObj.miPlayer:GetMTTTableInfos()
end

--奖励列表
function SetMTTBonusInfos(selfObj, aiData)
    selfObj.miPlayer:SetMTTBonusInfos(aiData)
end
function GetMTTBonusInfos(selfObj)
    return selfObj.miPlayer:GetMTTBonusInfos()
end

--盲注列表
function SetMTTBlindLevelInfos(selfObj, aiData)
    selfObj.miPlayer:SetMTTBlindLevelInfos(aiData)
end
function GetMTTBlindLevelInfos(selfObj)
    return selfObj.miPlayer:GetMTTBlindLevelInfos()
end

function GetCurrentBlindLevel(selfObj)
    return selfObj.miPlayer:GetCurrentBlindLevel()
end

--玩家排名列表
function SetMTTUserInfos(selfObj, aiData)
    selfObj.miPlayer:SetMTTUserInfos(aiData)
end
function GetMTTUserInfos(selfObj)
    return selfObj.miPlayer:GetMTTUserInfos()
end

function GetSelfCurrentUserinfo(selfObj)
    return selfObj.miPlayer:GetSelfCurrentUserinfo()
end

function GetCurrentRemainUsers(selfObj)
    return selfObj.miPlayer:GetCurrentRemainUsers()
end

function GetMTTBonusLimit(selfObj)
    return selfObj.miPlayer:GetMTTBonusLimit()
end

--mtt结束账单
function SetMTTGameBillInfo(selfObj,aiBillInfo)
    selfObj.miMTTGameBillInfo = aiBillInfo
end

function GetMTTGameBillInfo(selfObj)
    return selfObj.miMTTGameBillInfo
end

--mtt是否自动重进
function SetMTTSetting(selfObj,aiSetting)
    selfObj.miMttSetting = aiSetting
end

function GetMTTSetting(selfObj)
    return selfObj.miMttSetting
end

--当前牌桌号
--function GetMTTSelfTableIndex(selfObj)
--    return selfObj.miPlayer:GetMTTSelfTableIndex()
--end

--玩家当前所在的牌桌
function SetMTTCurTableIndex(selfObj,aiTableIndex)
    selfObj.miCurTableIndex = aiTableIndex
end

function GetMTTCurTableIndex(selfObj)
    return selfObj.miCurTableIndex
end

--玩家当前所打牌的牌桌
function SetMTTSelfTableIndex(selfObj,aiSelfTableIndex)
    selfObj.miSelfRealTableIndex = aiSelfTableIndex
end

function GetMTTSelfTableIndex(selfObj)
    return selfObj.miSelfRealTableIndex
end

--mtt allin动画是否结束 重进窗口
function SetMTTIsAllinOver(selfObj,aiIsAllinOver)
    selfObj.miMttIsAllinOver = aiIsAllinOver
end

function GetMTTIsAllinOver(selfObj)
    return selfObj.miMttIsAllinOver
end


--mtt allin动画是否结束 淘汰名词窗口
function SetMTTIsAllinOverForRank(selfObj,aiIsAllinOver,aiOverRank)
    selfObj.miMttIsAllinOverForRank = aiIsAllinOver
    selfObj.miMttOverRank = aiOverRank
end

function GetMTTIsAllinOverForRank(selfObj)
    return selfObj.miMttIsAllinOverForRank,selfObj.miMttOverRank
end

--mtt 是否切桌
function SetMTTIsMoveTable(selfObj,aiIsMoveTable,aiTipsText)
    selfObj.miIsMoveTable = aiIsMoveTable
    selfObj.miMoveTableTipsText = aiTipsText
end

function GetMTTIsMoveTable(selfObj)
    return selfObj.miIsMoveTable,selfObj.miMoveTableTipsText
end

--需要转换牌局数据
function GetGetUserInfoGameRoomType(selfObj)
    return selfObj.miPlayer:GetGetUserInfoGameRoomType()
end

--mtt站起列队
function AddMTTStandupList(selfObj,aiUserGameInfoNet)
    
    table.insert(selfObj.miMttStandUpList,aiUserGameInfoNet)
end
function EmptyMTTStandupList(selfObj)
   selfObj.miMttStandUpList = {}
end
function GetMTTStandupList(selfObj)
    return selfObj.miMttStandUpList
end

--mtt allin动画是否结束 防止自己切桌走
function SetMTTIsAllinOverForChangeDesk(selfObj,aiIsAllinOver)
    selfObj.miMttIsAllinOverForChangeDesk = aiIsAllinOver
end

function GetMTTIsAllinOverForChangeDesk(selfObj)
    return selfObj.miMttIsAllinOverForChangeDesk
end

--mtt allin动画是否结束 防止牌桌失效先弹出
function SetMTTIsAllinOverForNoDesk(selfObj,aiIsAllinOver)
    selfObj.miMttIsAllinOverForNoDesk = aiIsAllinOver
end

function GetMTTIsAllinOverForNoDesk(selfObj)
    return selfObj.miMttIsAllinOverForNoDesk
end

--endregion

--MTT消息列队延期处理
function AddMttDelayDispatch(selfObj, aiData)
    table.insert(selfObj.miMttDelayDispatch, aiData)
end

function EmptyMttDelayDispatch(selfObj)
    selfObj.miMttDelayDispatch = {}
end

function GetMttDelayDispatch(selfObj, aiData)
    return selfObj.miMttDelayDispatch
end

--设置修改延时属性数据
function UpdateDelayData(selfObj, aiDelayTotalTimes, ailActTime, aiDelayLong, aiDelayCost, aiDelaySingleTime)
    selfObj.miPlayer:UpdateDelayData(aiDelayTotalTimes, ailActTime, aiDelayLong, aiDelayCost, aiDelaySingleTime)
end

-------------------------------------------------------------------短牌
--短牌比牌规则(正常，还是非正常。0,正常，1的非正常3条大于顺子）
function GetGameRoomShortDeckStraightBig(selfObj)
    return selfObj.miPlayer:GetGameRoomShortDeckStraightBig()
end

--短牌是否两倍ante
function GetGameRoomShortDeckTwiceAnte(selfObj)
    return selfObj.miPlayer:GetGameRoomShortDeckTwiceAnte()
end

--短牌是否可以带出
function GetGameRoomShortDeckUnloadable(selfObj)
    return selfObj.miPlayer:GetGameRoomShortDeckUnloadable()
end

--短牌最小保留记分牌倍数(数值是100的倍数，使用需要除100)
function GetGameRoomShortDeckMinRemainRatio(selfObj)
    return selfObj.miPlayer:GetGameRoomShortDeckMinRemainRatio()
end

--短牌最小带出记分牌倍数(数值是100的倍数，使用需要除100)
function GetGameRoomShortDeckUnloadRatio(selfObj)
    return selfObj.miPlayer:GetGameRoomShortDeckUnloadRatio()
end

---短牌特殊处理

--滑竿需要的有效加注额
function GetShortDeckSlideEffectiveRaise(selfObj)
    return selfObj.miPlayer:GetShortDeckSlideEffectiveRaise()
end

--是否可以自由操作(true:可以自由操作)
function GetShortDeckIsFreeRaise(selfObj)
    return selfObj.miPlayer:GetShortDeckIsFreeRaise()
end

--最大下注
function GetShortDeckMaxBet(selfObj)
    return selfObj.miPlayer:GetShortDeckMaxBet()
end

-- 一手牌开始时，玩家身上的筹码
function GetBeginStacks( selfObj )
    return selfObj.miPlayer:GetBeginStacks()
end

-- 是否正在卸码，必须等一次卸码操作完成后，才能进行第二次卸码操作
function GetUserbUnloadingStacks( selfObj )
    return selfObj.miPlayer:GetUserbUnloadingStacks()
end

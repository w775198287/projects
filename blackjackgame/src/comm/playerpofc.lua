module(...,package.seeall)

function Create()
    local selfObj ={}
    setmetatable( selfObj, { __index = _M } )

    selfObj.miUserGameInfoList = nil

    return selfObj
end

function SetUserGameInfoList(selfObj, aiUserGameInfos)
    selfObj.miUserGameInfoList = nil
    selfObj.miUserGameInfoList = aiUserGameInfos

    for idx, value in pairs(selfObj.miUserGameInfoList) do
        if value.stUserInfo ~= nil and value.stUserInfo.uuid == 203025 then
            My_Lua_log(" file=[playerotherpag] fun=[OnUpdate]; lPlacingEnterTime="..tostring(value.lPlacingEnterTime))         
        end
    end
end

function GetUserGameInfoList(selfObj)
    return selfObj.miUserGameInfoList
end

function GetSelfUuid(selfObj)
    return cc.CClientPlatform:sharedClientPlatform():GetUuid()
end

--指定位置更新玩家数据
function UpdateUserInfoByPos(selfObj, aiPos, aiUserInfo)

    if selfObj.miUserGameInfoList == nil or aiUserInfo == nil then
        return
    end
    local tPos = aiPos + 1
    local tUserGameInfo = selfObj.miUserGameInfoList[tPos]
    if tUserGameInfo == nil then
        return
    end

    selfObj.miUserGameInfoList[tPos] = aiUserInfo
end

--指定uuid更新玩家数据
function UpdateUserInfoByUuid(selfObj, aiUuid, aiUserInfo)

    if selfObj.miUserGameInfoList == nil or aiUuid == nil or aiUserInfo == nil then
        return
    end

    local tPos = 0
    for idx, value in pairs(selfObj.miUserGameInfoList) do
        if value.stUserInfo ~= nil and value.stUserInfo.uuid ~= nil then
            tPos = tPos + 1
            if value.stUserInfo.uuid == aiUuid then            
                selfObj.miUserGameInfoList[tPos] = aiUserInfo
                break
            end
        end        
    end
end

-- 暂停恢复时更新强制买入时间
function UpdateUserForcedBuyInEnterTime( selfObj, aiUuid, aiForcedBuyInEnterTime )
    if selfObj.miUserGameInfoList == nil or aiUuid == nil or aiForcedBuyInEnterTime == nil then
        return
    end

    for idx, value in pairs(selfObj.miUserGameInfoList) do
        if value.stUserInfo ~= nil and value.stUserInfo.uuid ~= nil then
            if value.stUserInfo.uuid == aiUuid then
                value.lForcedBuyInEnterTime = aiForcedBuyInEnterTime
                break
            end
        end        
    end
end

-- 暂停恢复时更新操作时间
function UpdateUserActionTime( selfObj, aiUuid, aiActionTime )
    if selfObj.miUserGameInfoList == nil or aiUuid == nil or aiActionTime == nil then
        return
    end

    for idx, value in pairs(selfObj.miUserGameInfoList) do
        if value.stUserInfo ~= nil and value.stUserInfo.uuid ~= nil then
            if value.stUserInfo.uuid == aiUuid then
                value.lPlacingEnterTime = aiActionTime
                break
            end
        end        
    end
end

-- 指定uuid更新玩家基础数据
function UpdateUserBaseInfoByUuid( selfObj, uuid, aiUserBaseInfo )
    if selfObj.miUserGameInfoList == nil or uuid == nil or aiUserBaseInfo == nil then
        return
    end 

    for idx, value in pairs(selfObj.miUserGameInfoList) do
        if value.stUserInfo ~= nil and value.stUserInfo.uuid == uuid then
            value.stUserInfo:Clear()
            value.stUserInfo:MergeFrom(aiUserBaseInfo)
            break
        end
    end
end

--更新自己延时道具相关数据
--[[
local aiDelayData = {}
aiDelayData.aiDelayTotalTimes = tRsp.iDelayTotalTimes
aiDelayData.aiActTime = tRsp.lActTime
aiDelayData.aiDelayLong = tRsp.iDelayLong
aiDelayData.aiDelayCost = tRsp.iDelayCost
aiDelayData.aiDelaySingleTime = tRsp.iDelaySingleTime
]]--
function UpdateSelfDelayData( selfObj, aiDelayData )
    if selfObj.miUserGameInfoList == nil then
        return
    end
    if aiDelayData == nil then
        return
    end

    for idx, value in pairs(selfObj.miUserGameInfoList) do
        if value.stUserInfo ~= nil and value.stUserInfo.uuid == selfObj:GetSelfUuid() then
            value.iDelayTotalTimes = aiDelayData.aiDelayTotalTimes           --已经使用的次数
            value.lPlacingEnterTime = aiDelayData.aiActTime                   --用户做动作的时间
            value.iDelayDuration = aiDelayData.aiDelayLong                 --延时的长度
            value.iDelayCost = aiDelayData.aiDelayCost                 --延时需要的金币
            value.iDelayTimeUnit = aiDelayData.aiDelaySingleTime           --每次延时的时间
            return
        end
    end
end

-------------------------------------------------------------------
------------------------------Get方法------------------------------
-------------------------------------------------------------------
--通过uuid获取玩家数据 不传参默认自己
function GetUserGameInfoByUuid(selfObj, uuid)
    if selfObj.miUserGameInfoList == nil then
        return nil
    end
    if uuid == nil then
        uuid = selfObj:GetSelfUuid()
    end
    for idx, value in pairs(selfObj.miUserGameInfoList) do
        if value.stUserInfo ~= nil and value.stUserInfo.uuid == uuid then
            return value
        end
    end    

    return nil
end

function GetUserGameInfoNetFromUuid(selfObj, uuid)
    return selfObj:GetUserGameInfoByUuid(uuid)
end

--根据位置获取uuid(aiPos从0开始)
function GetUserUuidByPos(selfObj, aiPos)

    if selfObj.miUserGameInfoList == nil then
        return 0
    end

    if aiPos == nil then
        return 0
    end

    local tPos = aiPos + 1
    if selfObj.miUserGameInfoList ~= nil then
        local tUserGameInfo = selfObj.miUserGameInfoList[tPos]
        if tUserGameInfo and tUserGameInfo.stUserInfo ~= nil then
            return tUserGameInfo.stUserInfo.uuid
        end
    end
    return 0
end

--根据uuid获取pos(从0开始) 不传参默认自己
function GetUserPosByUuid(selfObj, uuid)
    if selfObj.miUserGameInfoList == nil then
        return -1
    end
    if uuid == nil then
        uuid = selfObj:GetSelfUuid()
    end

    local tPos = 0
    for idx, value in pairs(selfObj.miUserGameInfoList) do
        if value.stUserInfo ~= nil and value.stUserInfo.uuid == uuid then
            return tPos
        end
        tPos = tPos + 1
    end

    return -1
end

--获得玩家是否坐下 不传参默认自己
function GetStateStandby(selfObj, uuid)
    if selfObj.miUserGameInfoList == nil then
        return false
    end
    if uuid == nil then
        uuid = selfObj:GetSelfUuid()
    end
    for idx, value in pairs(selfObj.miUserGameInfoList) do
        if value.stUserInfo ~= nil and value.stUserInfo.uuid == uuid then
            return true
        end
    end
    return false
end

--通过uuid获取玩家头像url 不传参默认自己
function GetUserHeadUrlByUuid(selfObj, uuid)
    if selfObj.miUserGameInfoList == nil then
        return ""
    end

    if uuid == nil then
        uuid = selfObj:GetSelfUuid()
    end
    for idx, value in pairs(selfObj.miUserGameInfoList) do
        if value.stUserInfo ~= nil and value.stUserInfo.uuid == uuid then
            return (value.stUserInfo.strCover or value.stUserInfo.strSmallCover or "")
        end
    end
    return ""
end


--获取剩余筹码 by uuid
function GetRemainStackByUuid(selfObj, uuid)
    if selfObj.miUserGameInfoList == nil then
        return 0
    end

    if uuid == nil then
        uuid = selfObj:GetSelfUuid()
    end

    for idx, value in pairs(selfObj.miUserGameInfoList) do
        if value.stUserInfo ~= nil and value.stUserInfo.uuid == uuid then
            return value.lRemainStacks
        end
    end

    return 0
end

--获取昵称 by uuid
function GetNameByUuid(selfObj, uuid)
    if selfObj.miUserGameInfoList == nil then
        return ""
    end

    if uuid == nil then
        uuid = selfObj:GetSelfUuid()
    end

    for idx, value in pairs(selfObj.miUserGameInfoList) do
        if value.stUserInfo ~= nil and value.stUserInfo.uuid == uuid then
            return value.stUserInfo.strNick
        end
    end

    return ""
end

--获取性别(默认是男的) by uuid
function GetGenderByUuid(selfObj, uuid)
    if selfObj.miUserGameInfoList == nil then
        return 1
    end

    if uuid == nil then
        uuid = selfObj:GetSelfUuid()
    end

    for idx, value in pairs(selfObj.miUserGameInfoList) do
        if value.stUserInfo ~= nil and value.stUserInfo.uuid == uuid then
            return value.stUserInfo.iGender
        end
    end

    return 1
end

--获取用户游戏状态(不传值默认是自己) by uuid
function GetUserGameStateByUuid(selfObj, uuid)
    if selfObj.miUserGameInfoList == nil then
        return nil
    end

    if uuid == nil then
        uuid = selfObj:GetSelfUuid()
    end

    for idx, value in pairs(selfObj.miUserGameInfoList) do
        if value.stUserInfo ~= nil and value.stUserInfo.uuid == uuid and value.eOfcUserGameState then
            return value.eOfcUserGameState
        end
    end

    return nil
end

--获取用户的待摆牌(不传值默认是自己) by uuid
function GetUserPlacingCardsByUuid(selfObj, uuid)
    if selfObj.miUserGameInfoList == nil then
        return nil
    end

    if uuid == nil then
        uuid = selfObj:GetSelfUuid()
    end

    for idx, value in pairs(selfObj.miUserGameInfoList) do
        if value.stUserInfo ~= nil and value.stUserInfo.uuid == uuid then

            return value.vInPlacingCards
        end
    end

    return nil
end

--获取用户的bettingId(不传值默认是自己) by uuid
function GetUserBettingIdByUuid(selfObj, uuid)
    if selfObj.miUserGameInfoList == nil then
        return nil
    end

    if uuid == nil then
        uuid = selfObj:GetSelfUuid()
    end

    for idx, value in pairs(selfObj.miUserGameInfoList) do
        if value.stUserInfo ~= nil and value.stUserInfo.uuid == uuid then

            return value.lBettingId
        end
    end

    return nil
end

--获取是否范特西
function GetIsFantasyState(selfObj, uuid)
    if selfObj.miUserGameInfoList == nil then
        return false
    end

    if uuid == nil then
        uuid = selfObj:GetSelfUuid()
    end

    for idx, value in pairs(selfObj.miUserGameInfoList) do
        if value.stUserInfo ~= nil and value.stUserInfo.uuid == uuid then
            if value.bCurrentInFantasy then
                return (value.bCurrentInFantasy > 0)
            end            
        end
    end

    return false
end

--获取下手是否范特西
function GetIsNextFantasyState(selfObj, uuid)
    if selfObj.miUserGameInfoList == nil then
        return false
    end

    if uuid == nil then
        uuid = selfObj:GetSelfUuid()
    end

    for idx, value in pairs(selfObj.miUserGameInfoList) do
        if value.stUserInfo ~= nil and value.stUserInfo.uuid == uuid then
            if value.bNextEnterFantasy then
                return (value.bNextEnterFantasy > 0)
            end            
        end
    end

    return false
end

--获取范特西连续次数
function GetFantasyTimes(selfObj, uuid)
    if selfObj.miUserGameInfoList == nil then
        return 0
    end

    if uuid == nil then
        uuid = selfObj:GetSelfUuid()
    end

    for idx, value in pairs(selfObj.miUserGameInfoList) do
        if value.stUserInfo ~= nil and value.stUserInfo.uuid == uuid then
            if value.lTimesRemainInFantasy then
                return value.lTimesRemainInFantasy
            end            
        end
    end

    return 0
end

--更新本地玩家的状态
function UpdateUserStateByUuid(selfObj, aiUuid, aiNewUserState)
    if selfObj.miUserGameInfoList == nil then
        return
    end

    for idx, value in pairs(selfObj.miUserGameInfoList) do
        if value.stUserInfo ~= nil and value.stUserInfo.uuid == aiUuid and value.eOfcUserGameState then
            value.eOfcUserGameState = aiNewUserState
            break
        end
    end

end

--获取是否dealer位
function GetUserIsDeal(selfObj, uuid)
    if selfObj.miUserGameInfoList == nil then
        return false
    end

    if uuid == nil then
        uuid = selfObj:GetSelfUuid()
    end

    for idx, value in pairs(selfObj.miUserGameInfoList) do
        if value.stUserInfo ~= nil and value.stUserInfo.uuid == uuid then
            if value.bGameRoleDealer then
                return (value.bGameRoleDealer > 0)
            end            
        end
    end

    return false
end

--获取玩家操作时间点
function GetUserActionTime(selfObj, uuid)
    if selfObj.miUserGameInfoList == nil then
        return nil
    end

    if uuid == nil then
        uuid = selfObj:GetSelfUuid()
    end

    for idx, value in pairs(selfObj.miUserGameInfoList) do
        if value.stUserInfo ~= nil and value.stUserInfo.uuid == uuid then
            return value.lPlacingEnterTime            
        end
    end

    return nil
end

--获取玩家延时的长度
function GetUserDelayTime(selfObj, uuid)
    if selfObj.miUserGameInfoList == nil then
        return 0
    end

    if uuid == nil then
        uuid = selfObj:GetSelfUuid()
    end

    for idx, value in pairs(selfObj.miUserGameInfoList) do
        if value.stUserInfo ~= nil and value.stUserInfo.uuid == uuid then
            return value.iDelayDuration            
        end
    end

    return 0
end

--获取玩家当前点击延时道具的价格
function GetUserDelayPrice(selfObj, uuid)
    if selfObj.miUserGameInfoList == nil then
        return 0
    end

    if uuid == nil then
        uuid = selfObj:GetSelfUuid()
    end

    for idx, value in pairs(selfObj.miUserGameInfoList) do
        if value.stUserInfo ~= nil and value.stUserInfo.uuid == uuid then
            return value.iDelayCost            
        end
    end

    return 0
end

-- 获取当前玩家是否处于的强制买入（分数不够最低入局分）
function GetUserbInForcedBuyIn( selfObj, uuid )
    if selfObj.miUserGameInfoList == nil then
        return false
    end

    if uuid == nil then
        uuid = selfObj:GetSelfUuid()
    end

    for idx, value in pairs(selfObj.miUserGameInfoList) do
        if value.stUserInfo ~= nil and value.stUserInfo.uuid == uuid then
            if value.bInForcedBuyIn then
                return (value.bInForcedBuyIn > 0)    
            end  
        end
    end

    return false
end

-- 获取玩家强制买入倒计时
function GetUserlForcedBuyInEnterTime( selfObj, uuid )
    if selfObj.miUserGameInfoList == nil then
        return 0
    end

    if uuid == nil then
        uuid = selfObj:GetSelfUuid()
    end

    for idx, value in pairs(selfObj.miUserGameInfoList) do
        if value.stUserInfo ~= nil and value.stUserInfo.uuid == uuid then
            return value.lForcedBuyInEnterTime            
        end
    end

    return 0
end

--获取是否托管
function GetUserIsDelegateByUuid(selfObj, uuid)
    if selfObj.miUserGameInfoList == nil then
        return false
    end

    if uuid == nil then
        uuid = selfObj:GetSelfUuid()
    end

    for idx, value in pairs(selfObj.miUserGameInfoList) do
        if value.stUserInfo ~= nil and value.stUserInfo.uuid == uuid then
            return (value.bInDelegate > 0)            
        end
    end

    return false
end

--获取是否离座
function GetUserIsLeaveDeskByUuid(selfObj, uuid)
    if selfObj.miUserGameInfoList == nil then
        return false
    end

    if uuid == nil then
        uuid = selfObj:GetSelfUuid()
    end

    for idx, value in pairs(selfObj.miUserGameInfoList) do
        if value.stUserInfo ~= nil and value.stUserInfo.uuid == uuid then
            return (value.bLeaveTable > 0)            
        end
    end

    return false
end

--在桌所有玩家离座的人数
function GetLeaveTableUserNums(selfObj)
    if selfObj.miUserGameInfoList == nil then
        return 0
    end

    local tNum = 0
    for idx, value in pairs(selfObj.miUserGameInfoList) do
        if value and value.bLeaveTable then
            if value.bLeaveTable > 0 then
                tNum = tNum + 1
            end
        end
    end

    return tNum
end

--获取指定玩家的牌数据
function GetUserRowCardsByUuid(selfObj, uuid)
    if selfObj.miUserGameInfoList == nil then
        return nil
    end

    if uuid == nil then
        uuid = selfObj:GetSelfUuid()
    end

    for idx, value in pairs(selfObj.miUserGameInfoList) do
        if value.stUserInfo ~= nil and value.stUserInfo.uuid == uuid then
            return value.vOfcRowCardInfo        
        end 
    end

    return nil
end

--获取牌桌上玩家是否都是范特西状态
function GetIsAllUserIsFantasy(selfObj)
    if selfObj.miUserGameInfoList == nil then
        return false
    end

    for idx, value in pairs(selfObj.miUserGameInfoList) do
        if value.stUserInfo ~= nil and value.stUserInfo.uuid > 0 then
            if value.bCurrentInFantasy and value.bCurrentInFantasy < 1 then
                return false
            end   
        end
    end

    return true
end

--获取玩家最终的得分  每道大小比分，每道牌型比分，全胜分
function GetUserResultScore(selfObj, uuid)
    if selfObj.miUserGameInfoList == nil then
        return 0
    end

    if uuid == nil then
        uuid = selfObj:GetSelfUuid()
    end

    local tResultSocre = 0
    for idx, value in pairs(selfObj.miUserGameInfoList) do
        if value.stUserInfo ~= nil and value.stUserInfo.uuid == uuid then
            
            --累加每道的大小比分和牌型比分
            if value.stOfcRowScoreInfo ~= nil then                
                local tRowScoreData = value.stOfcRowScoreInfo
                for key, val in pairs(tRowScoreData) do
                    if val.eOfcRowType and val.eOfcRowType == TexasPokerOFC_pb.OFC_ROW_TYPE_TOP then
                        tResultSocre = tResultSocre + val.lRowScores
                        tResultSocre = tResultSocre + val.lRowSuiteScores
                    elseif val.eOfcRowType and val.eOfcRowType == TexasPokerOFC_pb.OFC_ROW_TYPE_MIDDLE then
                        tResultSocre = tResultSocre + val.lRowScores
                        tResultSocre = tResultSocre + val.lRowSuiteScores
                    elseif val.eOfcRowType and val.eOfcRowType == TexasPokerOFC_pb.OFC_ROW_TYPE_BOTTOM then
                        tResultSocre = tResultSocre + val.lRowScores
                        tResultSocre = tResultSocre + val.lRowSuiteScores
                    end
                end
             end
            --加上全胜分
            if value.iScoreInVictory ~= nil then
                tResultSocre = tResultSocre + value.iScoreInVictory
            end
        end
    end

    return tResultSocre
end

------------------------------------------------------------------
--------------------------牌局周边数据获取--------------------------
------------------------------------------------------------------

--获取所有已经出现的牌  用于记牌器
function GetAllUsedCards(selfObj)

    local tAllUsedCards = {}
    if selfObj.miUserGameInfoList == nil then
        return nil
    end

    for i=1,#selfObj.miUserGameInfoList do

        local tUserInfo =  selfObj.miUserGameInfoList[i]
        if tUserInfo then

            --摆好的牌
            local tCardInfos = tUserInfo.vOfcRowCardInfo
            if tCardInfos then
                for k=1,#tCardInfos do
                    local tCards = tCardInfos[k].vRowCards
                    if tCards then
                        for j=1,#tCards do
                            table.insert(tAllUsedCards,tCards[j])
                        end
                    end
                end
            end

            --待摆的牌
            local tPlayingCards = tUserInfo.vInPlacingCards
            if tPlayingCards then
                for i=1,#tPlayingCards do
                    table.insert(tAllUsedCards,tPlayingCards[i])
                end
            end
        end
    end
    
    return tAllUsedCards
end

--是否是买入等待
function GetIsWaitingBuyinConfirmation(selfObj,uuid)
    if selfObj.miUserGameInfoList == nil then
        return false
    end
    if uuid == nil then
        uuid = selfObj:GetSelfUuid()
    end
    for idx, value in pairs(selfObj.miUserGameInfoList) do
        if value.stUserInfo ~= nil and value.stUserInfo.uuid == uuid then
            if value.bWaitingBuyinConfirmation then
                return (value.bWaitingBuyinConfirmation > 0)
            end            
        end
    end
    return false
end

--是否是买入等待申请时间
function GetBuyinTime(selfObj, uuid)
    if selfObj.miUserGameInfoList == nil then
        return 0
    end
    if uuid == nil then
        uuid = selfObj:GetSelfUuid()
    end
    for idx, value in pairs(selfObj.miUserGameInfoList) do
        if value.stUserInfo ~= nil and value.stUserInfo.uuid == uuid then
            return value.lBuyinTime
        end
    end
    return 0
end

--通过玩家数据，获取房间是否坐满
function GetIsGameRoomFullSeat(selfObj)
    if selfObj.miUserGameInfoList == nil then
        return false
    end
    for idx, value in pairs(selfObj.miUserGameInfoList) do
        if value.stUserInfo ~= nil and value.stUserInfo.uuid <= 0 then
            return false
        end
    end

    return true
end

--获得是否购买过联盟数据
function GetBuyinClubID(selfObj, uuid)

    if selfObj.miUserGameInfoList == nil then
        return 0
    end
    if uuid == nil then
        uuid = selfObj:GetSelfUuid()
    end
    for idx, value in pairs(selfObj.miUserGameInfoList) do
        if value.stUserInfo ~= nil and value.stUserInfo.uuid == uuid then
            if value.lBuyinClubId ~= nil then
                return value.lBuyinClubId
            end
        end
    end
    return 0
end

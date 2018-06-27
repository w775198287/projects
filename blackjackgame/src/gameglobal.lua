--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

module(...,package.seeall)

local Local_GIsCreate = false
local Local_GameGlobalObj = {}

function Instance()
    if Local_GIsCreate == true then
        return Local_GameGlobalObj
    end
    setmetatable( Local_GameGlobalObj, { __index = _M } )
    Local_GameGlobalObj:Init()
    Local_GIsCreate = true
    return Local_GameGlobalObj
end

function Init(selfObj)
    --游戏类型(用来表示是小游戏 ，还是牌局)
    selfObj.miGameType = GAME_TYPE_ENUM.GAME_TYPE_TEXAS

    --现在roomid
    selfObj.miCurGameRoomId = 0

    --牌局id对应俱乐部名字
    selfObj.miClubNameList = {} 
    --当前俱乐部id
    selfObj.miCurClubId = 0

    --系统消息
    selfObj.miPushSystemMsgList = {}

    --是否开启游戏了
    selfObj.miIsOpenGmaeState = false
    --是否游戏结束了
    selfObj.miIsOverGmaeState = false

    --是否切后台
    selfObj.miIsEnterBackground = false
    --停止接收不相关协议
    selfObj.miIsStopSendPake = false

    --本地存玩家基础信息
    selfObj.miOtherUserBaseInfoList = {}

    --游戏语言 1-简体中文  2-英文  3-繁体中文
    selfObj.miCurLanguage = 1

    --个人设置
    selfObj.miSelfGlobalSetting = {}
    --自定义快捷加注结构
    --普通局
    selfObj.miExpressRaiseList = {}
    --奥马哈局
    selfObj.miOmahaExpressRaiseList = {}
    --短牌
    selfObj.miShortDeckExpressRaiseList = {}

    --房间弹幕开关列表 roomid为key
    selfObj.miBulletOnOffList = {}
end

-------------------------------------------
--手机适配函数
function GetIsi4Platform(selfObj)
    local tFrameSize = cc.Director:getInstance():getOpenGLView():getFrameSize()
    local app = cc.Application:getInstance()
    local target = app:getTargetPlatform()
    if target == cc.PLATFORM_OS_IPAD then
        return true
    elseif target == cc.PLATFORM_OS_IPHONE then
        if tFrameSize.width == RealResolutionSizeList.iphone4.width and tFrameSize.height == RealResolutionSizeList.iphone4.height then
            return true
        end
    end
    return false
end

function GetIsIphoneXPlatform(selfObj)
    local tFrameSize = cc.Director:getInstance():getOpenGLView():getFrameSize()
    local app = cc.Application:getInstance()
    local target = app:getTargetPlatform()
    if target == cc.PLATFORM_OS_IPHONE then
        if tFrameSize.width == RealResolutionSizeList.iphonex.width and tFrameSize.height == RealResolutionSizeList.iphonex.height then
            return true
        end
    end
    return false
end

function GetPhonePlatform(selfObj)
    local tFrameSize = cc.Director:getInstance():getOpenGLView():getFrameSize()

    local app = cc.Application:getInstance() 
    local target = app:getTargetPlatform()
    if target == cc.PLATFORM_OS_IPAD then
        return DESIGNSIZE_PHONE_NAME.IPAD
    elseif target == cc.PLATFORM_OS_IPHONE then
        if tFrameSize.width == RealResolutionSizeList.iphone4.width and tFrameSize.height == RealResolutionSizeList.iphone4.height then
            return DESIGNSIZE_PHONE_NAME.IPHONE_4
        end

    elseif target == cc.PLATFORM_OS_ANDROID then
        if tFrameSize.width == RealResolutionSizeList.sumsang_s8.HIGH.width and tFrameSize.height == RealResolutionSizeList.sumsang_s8.HIGH.height then
            return DESIGNSIZE_PHONE_NAME.SUMSUNG_S8
        end
        if tFrameSize.width == RealResolutionSizeList.sumsang_s8.MIDDLE.width and tFrameSize.height == RealResolutionSizeList.sumsang_s8.MIDDLE.height then
            return DESIGNSIZE_PHONE_NAME.SUMSUNG_S8
        end
        if tFrameSize.width == RealResolutionSizeList.sumsang_s8.LOW.width and tFrameSize.height == RealResolutionSizeList.sumsang_s8.LOW.height then
            return DESIGNSIZE_PHONE_NAME.SUMSUNG_S8
        end

        local tRatio = math.abs(tFrameSize.width/tFrameSize.height - 0.5)
        if tRatio >= 0 and tRatio <= ANDROID_ASPECT_RATIO_ERROR_RANGE then
            return DESIGNSIZE_PHONE_NAME.SUMSUNG_S8
        end

    end
    return DESIGNSIZE_PHONE_NAME.IPHONE_6S
end

function IsDesignSizeByHeight(selfObj)
--    local tFrameSize = cc.Director:getInstance():getOpenGLView():getFrameSize()
--    local tPlatform = selfObj:GetPhonePlatform()
--    local designSize = DesignResolutionSizeList[tPlatform]

--    local app = cc.Application:getInstance()
--    local target = app:getTargetPlatform()
--    if target == cc.PLATFORM_OS_ANDROID then
--        if tFrameSize.width == RealResolutionSizeList.sumsang_s8.HIGH.width and tFrameSize.height == RealResolutionSizeList.sumsang_s8.HIGH.height then
--            return false
--        end
--        if tFrameSize.width == RealResolutionSizeList.sumsang_s8.MIDDLE.width and tFrameSize.height == RealResolutionSizeList.sumsang_s8.MIDDLE.height then
--            return false
--        end
--        if tFrameSize.width == RealResolutionSizeList.sumsang_s8.LOW.width and tFrameSize.height == RealResolutionSizeList.sumsang_s8.LOW.height then
--            return false
--        end
--    end
--    if selfObj:GetPhonePlatform() == DESIGNSIZE_PHONE_NAME.SUMSUNG_S8 then
--        return false
--    end
--    return true

    --local tPlatform = selfObj:GetPhonePlatform()
    --local designSize = DesignResolutionSizeList[tPlatform]
    local tFrameSize = cc.Director:getInstance():getOpenGLView():getFrameSize()
    if tFrameSize.width / tFrameSize.height <= 0.5 then
        return false
    end
    return true
end
--获取不同手机上下间距
function GetPhoneSpaceData(selfObj)
    
    local tPlatform = G_Fy.GamegLobal:GetPhonePlatform()
    local tSpaceData = PHONE_TOP_BOTTOM_SPACE_LIST[tPlatform]
    if tPlatform == DESIGNSIZE_PHONE_NAME.IPHONE_6S then
        local tFrameSize = cc.Director:getInstance():getOpenGLView():getFrameSize()
        if tFrameSize.width / tFrameSize.height <= 0.5 then
            tSpaceData = PHONE_TOP_BOTTOM_SPACE_LIST["iphonex"]
        end
    end

    return tSpaceData
end
--获取不同设计分辨率
function GetPhoneDesignSize(selfObj)
    
    local tPlatform = G_Fy.GamegLobal:GetPhonePlatform()
    local designSize = DesignResolutionSizeList[tPlatform]
    
    return designSize
end

--根据不同方向的约束和百分比获取距离四条边的位置
--aiDirection 方向
--aiPercent 百分比
--aiIsConstraint 是否约束,也就是是否减去不可操作区域距离
function GetPhoneSizePosByDirection(selfObj, aiDirection, aiPercent, aiIsConstraint)
    
    if aiDirection == nil or aiPercent == nil then
        return
    end

    local tSpaceData = G_Fy.GamegLobal:GetPhoneSpaceData()
    local tVisibleSize = cc.Director:getInstance():getOpenGLView():getVisibleSize()

    local tSpace = 0
    local tLength = 0  --去除留边后的长度
    local tResultDistance = 0

    
    if aiDirection == PHONE_DIRECTION_CONSTRAINT.UP or aiDirection == PHONE_DIRECTION_CONSTRAINT.DOWN then
        
        if aiIsConstraint and aiIsConstraint == true then
            tLength = tVisibleSize.height - tSpaceData.top_space - tSpaceData.bottom_space
        else
            tLength = tVisibleSize.height
        end
        
    elseif aiDirection == PHONE_DIRECTION_CONSTRAINT.LEFT or aiDirection == PHONE_DIRECTION_CONSTRAINT.RIGHT then        
        tLength = tVisibleSize.width
    end

    if aiIsConstraint and aiIsConstraint == true then
        if aiDirection == PHONE_DIRECTION_CONSTRAINT.UP then
            tSpace = tSpaceData.top_space
        elseif aiDirection == PHONE_DIRECTION_CONSTRAINT.DOWN then
            tSpace = tSpaceData.bottom_space
        end
    else
        tSpace = 0
    end

    tResultDistance = math.ceil(tLength * aiPercent) + tSpace

    return tResultDistance
end



-------------------------------------------

function SetGameType(selfObj, aiGameType)
    selfObj.miGameType = aiGameType
end

function GetGameType(selfObj)
    return selfObj.miGameType
end

--自己uuid
function GetSelfUuid(selfObj)
    return cc.CClientPlatform:sharedClientPlatform():GetUuid()
end

--设置现在房间ID
function SetCurGameRoomId(selfObj, aiGameRoomId)
    --现在roomid
    selfObj.miCurGameRoomId = aiGameRoomId
end
--获得现在房间ID
function GetCurGameRoomId(selfObj)
    return selfObj.miCurGameRoomId
end
--清空现在房间ID
function EmptyCurGameRoomId(selfObj)
    selfObj.miCurGameRoomId = 0
end

--设置俱乐部名列表
function SetClubNameList(selfObj, aiGameRoomId, aiClubName)
    selfObj.miClubNameList[aiGameRoomId] = aiClubName
end
--通过房间id获取俱乐部名称
function GetClubNameByGameRoomId(selfObj, aiGameRoomId)
    if selfObj.miClubNameList[aiGameRoomId] == nil then
        return ""
    end

    return selfObj.miClubNameList[aiGameRoomId]
end

--设置当前俱乐部id
function SetCurClubId(selfObj, aiClubId)
    selfObj.miCurClubId = aiClubId
end

function GetCurClubId(selfObj)
    return selfObj.miCurClubId
end

--设置俱乐部相关信息,设置当前俱乐部id,俱乐部名列表,当前房间id
function SetGlobalCurData(selfObj, aiGameRoomId)
    
    local tChatDataMap = cc.CClientPlatform:sharedClientPlatform():GetChatData()
    if tChatDataMap == nil then
        return
    end
    local tClubName = tChatDataMap['clubName']
    local tClubId = tChatDataMap['clubId']

    My_Lua_log(" file=[gameglobal] fun=[SetGlobalCurData]; aiGameRoomId="..tostring(aiGameRoomId).."tClubName="..tostring(tClubName).." tClubId="..tostring(tClubId))

    --设置当前房间id
    selfObj:SetCurGameRoomId(aiGameRoomId)
    --设置当前俱乐部id
    selfObj:SetCurClubId(tClubId)
    --设置俱乐部名列表
    selfObj:SetClubNameList(aiGameRoomId, tClubName)
    --设置牌局弹幕开关
    local tOnOff = cc.CClientPlatform:sharedClientPlatform():GetCommentOnOff(tClubId, aiGameRoomId)
    selfObj:SetBulletOnOffByGameRoomId(aiGameRoomId, tOnOff)
end

--主动清理lua内存
function LuaPurgeCachedData(selfObj)
    --主动清空下lua内存
    local tBegin = collectgarbage("count")
    cc.Director:getInstance():purgeCachedData()
    collectgarbage("collect")
    local tEnd = collectgarbage("count")
    My_Lua_log(" file=[protocolcenter] fun=[onroomgamestateshowcardresetui]; tBegin=[" .. tBegin .."]tEnd=[".. tEnd .."]")
end

function EmptyCocosCachedData(selfObj)
    cc.Director:getInstance():purgeCachedData()
    cc.SpriteFrameCache:getInstance():removeSpriteFrames()
    cc.Director:getInstance():getTextureCache():removeAllTextures()
end

function AddPushSystemMsgList(selfObj, aiPushSystemMsgData)
    table.insert(selfObj.miPushSystemMsgList, aiPushSystemMsgData)
end

function RemovePushSystemMsgList(selfObj, aiIndex)
    if #selfObj.miPushSystemMsgList < aiIndex then
        return
    end
    table.remove(selfObj.miPushSystemMsgList, aiIndex)
end

function EmptyPushSystemMsgList(selfObj)
    selfObj.miPushSystemMsgList = {}
end

--清空语音列队
function EmptyCancelQueue(selfObj)
    cc.CClientPlatform:sharedClientPlatform():CancelQueue()
end

function SetEnableVoice(selfObj, aiBool)
    cc.CClientPlatform:sharedClientPlatform():SetEnableVoice(aiBool)
end

--是否开启游戏了
function SetIsOpenGmaeState(selfObj, aiIsOpenGmaeState)
    --现在roomid
    selfObj.miIsOpenGmaeState = aiIsOpenGmaeState
end
--是否开启游戏了
function GetIsOpenGmaeState(selfObj)
    return selfObj.miIsOpenGmaeState
end

--是否游戏结束了
function SetIsOverGmaeState(selfObj, aiIsOverGmaeState)
    --现在roomid
    selfObj.miIsOverGmaeState = aiIsOverGmaeState
end
--是否游戏结束了
function GetIsOverGmaeState(selfObj)
    return selfObj.miIsOverGmaeState
end

--是否切后台
function SetIsEnterBackground(selfObj, aiIsEnterBackground)
    --现在roomid
    selfObj.miIsEnterBackground = aiIsEnterBackground
end
--是否切后台
function GetIsEnterBackground(selfObj)
    return selfObj.miIsEnterBackground
end

--停止接收不相关协议
function SetIsStopSendPake(selfObj, aiIsStopSendPake)
    --现在roomid
    selfObj.miIsStopSendPake = aiIsStopSendPake
end
--停止接收不相关协议
function GetIsStopSendPake(selfObj)
    return selfObj.miIsStopSendPake
end

--获得财富（德扑币）是字符串
function GetCoin(selfObj)
    local tChatDataMap = cc.CClientPlatform:sharedClientPlatform():GetChatData()
    return tChatDataMap['Popularity']
end

--获取自己钻石数
function GetDiamond(selfObj)
    local tChatDataMap = cc.CClientPlatform:sharedClientPlatform():GetChatData()
    return tChatDataMap['lCoin']
end

--本地存玩家基础信息
function AddOrUpdateUserBaseInfo(selfObj,uuid,aiUserBaseInfo)
    
    selfObj.miOtherUserBaseInfoList[uuid] = aiUserBaseInfo
end

function GetUserBaseInfoByUuidAndKey(selfObj,uuid,aiKey)
    
    local tUserBaseInfo = selfObj.miOtherUserBaseInfoList[uuid]
    if tUserBaseInfo ~= nil then
        for key, value in pairs(tUserBaseInfo) do
            if key == aiKey then
                return value
            end
        end
    end         
    return nil
end

function EmptyUserBaseInfoList(selfObj)
    selfObj.miOtherUserBaseInfoList = {}
end

--通过uuid获取其基础数据 如果本地没有拉取一次，然后存本地
function GetUserBaseInfoByUuid(selfObj,uuid)

    local tList = selfObj.miOtherUserBaseInfoList[uuid]
    if tList == nil then    
        tList = cc.CClientPlatform:sharedClientPlatform():GetUserBaseInfoData(uuid)
        selfObj:AddOrUpdateUserBaseInfo(uuid,tList)
    end

    return tList
end

function SetCurrentLanguage(selfObj, aiLanguage)
    selfObj.miCurLanguage = aiLanguage
end

--获取当前语言
function GetCurrentLanguage(selfObj)
    return selfObj.miCurLanguage
end

--获取头像纹理
function GetHeadImageTexture(selfObj, uuid, url, gender, width, height)

    local tTexture2DObj = cc.CClientPlatform:sharedClientPlatform():GetHeadTexture(uuid, url, gender, width, height)
    return tTexture2DObj
end

--重置并获取头像纹理
function GetResetHeadImageTexture(selfObj, uuid, url, gender, width, height)
    
    cc.TextureCache:getInstance():removeTextureForKey(url)

    local tTexture2DObj = cc.CClientPlatform:sharedClientPlatform():GetHeadTexture(uuid, url, gender, width, height)
    return tTexture2DObj
end

--个人设置
function InitSelfGlobalSetting(selfObj)
    local tList = cc.CClientPlatform:sharedClientPlatform():GetGameGlobalSetting()
    selfObj.miSelfGlobalSetting = tList

    for key, var in pairs(selfObj.miSelfGlobalSetting) do
        My_Lua_log(" file=[gameglobal] fun=[InitSelfGlobalSetting]; key="..tostring(key))
        My_Lua_log(" file=[gameglobal] fun=[InitSelfGlobalSetting]; var="..tostring(var))
    end

    --初始化本地的自定义加注
    selfObj.miExpressRaiseList = {}
    for key, value in pairs(selfObj.miSelfGlobalSetting['ExpressRaiseList']) do
        local tPotData = value
        local tData = {}
        tData.bFixedRatio = tonumber(tPotData['FixedRatio'])
        tData.iOptionIndex = tonumber(tPotData['OptionIndex'])
        tData.iRatioUp = tonumber(tPotData['RatioUp'])
        tData.iRatioDown = tonumber(tPotData['RatioDown'])
        tData.iCustomized = tonumber(tPotData['Customized'])

        My_Lua_log(" file=[gameglobal] fun=[InitSelfGlobalSetting];tFixedRatio="..tPotData['FixedRatio'])
        My_Lua_log(" file=[gameglobal] fun=[InitSelfGlobalSetting];tOptionIndex="..tPotData['OptionIndex'])        
        My_Lua_log(" file=[gameglobal] fun=[InitSelfGlobalSetting];tRatioUp="..tPotData['RatioUp'])
        My_Lua_log(" file=[gameglobal] fun=[InitSelfGlobalSetting];tRatioDown="..tPotData['RatioDown'])
        My_Lua_log(" file=[gameglobal] fun=[InitSelfGlobalSetting];tCustomized="..tPotData['Customized'])

        selfObj.miExpressRaiseList[tData.iOptionIndex + 1] = tData
    end

    selfObj.miOmahaExpressRaiseList = {}
    for key, value in pairs(selfObj.miSelfGlobalSetting['OmahaExpressRaiseList']) do
        local tPotData = value
        local tData = {}
        tData.bFixedRatio = tonumber(tPotData['FixedRatio'])
        tData.iOptionIndex = tonumber(tPotData['OptionIndex'])
        tData.iRatioUp = tonumber(tPotData['RatioUp'])
        tData.iRatioDown = tonumber(tPotData['RatioDown'])
        tData.iCustomized = tonumber(tPotData['Customized'])

        My_Lua_log(" file=[gameglobal] fun=[InitSelfGlobalSetting];omaha tFixedRatio="..tPotData['FixedRatio'])
        My_Lua_log(" file=[gameglobal] fun=[InitSelfGlobalSetting];omaha tOptionIndex="..tPotData['OptionIndex'])        
        My_Lua_log(" file=[gameglobal] fun=[InitSelfGlobalSetting];omaha tRatioUp="..tPotData['RatioUp'])
        My_Lua_log(" file=[gameglobal] fun=[InitSelfGlobalSetting];omaha tRatioDown="..tPotData['RatioDown'])
        My_Lua_log(" file=[gameglobal] fun=[InitSelfGlobalSetting];omaha tCustomized="..tPotData['Customized'])

        selfObj.miOmahaExpressRaiseList[tData.iOptionIndex + 1] = tData
    end

    selfObj.miShortDeckExpressRaiseList = {}
    if selfObj.miSelfGlobalSetting['ShortDeckExpressRaiseList'] ~= nil then
        for key, value in pairs(selfObj.miSelfGlobalSetting['ShortDeckExpressRaiseList']) do
            local tPotData = value
            local tData = {}
            tData.bFixedRatio = tonumber(tPotData['FixedRatio'])
            tData.iOptionIndex = tonumber(tPotData['OptionIndex'])
            tData.iRatioUp = tonumber(tPotData['RatioUp'])
            tData.iRatioDown = tonumber(tPotData['RatioDown'])
            tData.iCustomized = tonumber(tPotData['Customized'])

            My_Lua_log(" file=[gameglobal] fun=[InitSelfGlobalSetting];ShortDeck tFixedRatio="..tPotData['FixedRatio'])
            My_Lua_log(" file=[gameglobal] fun=[InitSelfGlobalSetting];ShortDeck tOptionIndex="..tPotData['OptionIndex'])
            My_Lua_log(" file=[gameglobal] fun=[InitSelfGlobalSetting];ShortDeck tRatioUp="..tPotData['RatioUp'])
            My_Lua_log(" file=[gameglobal] fun=[InitSelfGlobalSetting];ShortDeck tRatioDown="..tPotData['RatioDown'])
            My_Lua_log(" file=[gameglobal] fun=[InitSelfGlobalSetting];ShortDeck tCustomized="..tPotData['Customized'])

            selfObj.miShortDeckExpressRaiseList[tData.iOptionIndex + 1] = tData
        end
    end
end
--初始化下牌局静音
function InitGameMute(selfObj)
    if selfObj.miSelfGlobalSetting == nil then
        return
    end
    if selfObj.miSelfGlobalSetting['EnableGamingMute'] == nil then
        return
    end

    --初始化下牌局静音
    local tGameMute = tonumber(selfObj.miSelfGlobalSetting['EnableGamingMute'])
    if tGameMute == 1 then
        cc.SimpleAudioEngine:getInstance():setEffectsVolume(0)
    else
        cc.SimpleAudioEngine:getInstance():setEffectsVolume(1)
    end
end
--获取主题样式
function GetThemeSetting(selfObj)
    if selfObj.miSelfGlobalSetting == nil then
        return 0
    end
    local tGameTheme = selfObj.miSelfGlobalSetting['TableTheme']
    return tonumber(tGameTheme)
end
function SetThemeSetting(selfObj, aiGameTheme)
    if selfObj.miSelfGlobalSetting == nil then
        return
    end
    if aiGameTheme == nil then
        return
    end
    selfObj.miSelfGlobalSetting['TableTheme'] = aiGameTheme
end

--获取四色牌
function GetFourColorSetting(selfObj)
    if selfObj.miSelfGlobalSetting == nil then
        return 0
    end
    local tPokerType = selfObj.miSelfGlobalSetting['PokerType']
    return tonumber(tPokerType)
end
function SetFourColorSetting(selfObj, aiPokerType)
    if selfObj.miSelfGlobalSetting == nil then
        return
    end
    if aiPokerType == nil then
        return
    end
    selfObj.miSelfGlobalSetting['PokerType'] = aiPokerType
end
--获取牌 正常还是四色
function GetPokerTypePath(selfObj)
    
    local tPokerFace = selfObj:GetThemeDefineConfigByArgs("STR_TEXT_POKER_FACE")
    local tPokerFaceFourColor = selfObj:GetThemeDefineConfigByArgs("STR_TEXT_POKER_FACE_FOURCOLOR")
    
    if selfObj.miSelfGlobalSetting == nil then
        return tPokerFace
    end
    local tPokerStyle = tonumber(selfObj.miSelfGlobalSetting['PokerType'])
    if tPokerStyle == nil then
        return tPokerFace
    end    
    if tPokerStyle == 0 then
        return tPokerFace
    elseif tPokerStyle == 1 then
        return tPokerFaceFourColor
    end    

    return tPokerFace
end
--获取是否牌局静音
function GetGameMuteSetting(selfObj)
    if selfObj.miSelfGlobalSetting == nil then
        return
    end
    local tGameMute = selfObj.miSelfGlobalSetting['EnableGamingMute']

    return tonumber(tGameMute)
end
function SetGameMuteSetting(selfObj, aiGameMute)
    if selfObj.miSelfGlobalSetting == nil then
        return
    end
    if aiGameMute == nil then
        return
    end
    selfObj.miSelfGlobalSetting['EnableGamingMute'] = aiGameMute
    if aiGameMute == 1 then
        cc.SimpleAudioEngine:getInstance():setEffectsVolume(0)
    else
        cc.SimpleAudioEngine:getInstance():setEffectsVolume(1)
    end
end

--获取是否聊天静音
function GetChattingMuteSetting(selfObj)
    if selfObj.miSelfGlobalSetting == nil then
        return
    end
    local tChattingMute = selfObj.miSelfGlobalSetting['EnableChattingMute']
    return tonumber(tChattingMute)
end
function SetChattingMuteSetting(selfObj, aiChattingMute)
    if selfObj.miSelfGlobalSetting == nil then
        return
    end
    if aiChattingMute == nil then
        return
    end
    selfObj.miSelfGlobalSetting['EnableChattingMute'] = aiChattingMute
end

--获取是否拉杆确认
function GetRaiseAssistantSetting(selfObj)
    if selfObj.miSelfGlobalSetting == nil then
        return
    end
    local tRaiseAssistant = selfObj.miSelfGlobalSetting['EnableRaiseAssistant']

    return tonumber(tRaiseAssistant)
end
function SetRaiseAssistantSetting(selfObj, aiRaiseAssistant)
    if selfObj.miSelfGlobalSetting == nil then
        return
    end
    if aiRaiseAssistant == nil then
        return
    end
    selfObj.miSelfGlobalSetting['EnableRaiseAssistant'] = aiRaiseAssistant
end
--获取自定义加注数据（）
function GetExpressRaiseList(selfObj,aiGameRoomType)
    if selfObj.miSelfGlobalSetting == nil then
        return
    end
    
    My_Lua_log(" file=[gameglobal] fun=[GetExpressRaiseList];selfObj.miExpressRaiseList="..#selfObj.miExpressRaiseList)
    My_Lua_log(" file=[gameglobal] fun=[GetExpressRaiseList];selfObj.miOmahaExpressRaiseList="..#selfObj.miOmahaExpressRaiseList)    


    if aiGameRoomType == TexasPokerCommon_pb.GAME_ROOM_OMAHA or aiGameRoomType == TexasPokerCommon_pb.GAME_ROOM_OMAHA_INSURANCE then
        return selfObj.miOmahaExpressRaiseList
    elseif TexasPokerCommon_pb.GAME_ROOM_SHORT_DECK == aiGameRoomType or TexasPokerCommon_pb.GAME_ROOM_SHORT_DECK_INSURANCE ==  aiGameRoomType  then
        return selfObj.miShortDeckExpressRaiseList
    else
        return selfObj.miExpressRaiseList
    end    
end

--通过本地数据设置
function SetExpressRaiseList(selfObj, aiExpressRaiseList)
    if selfObj.miSelfGlobalSetting == nil then
        return
    end
    if aiExpressRaiseList == nil then
        My_Lua_log(" file=[gameglobal] fun=[SetExpressRaiseList]; invalid data")
        return
    end
    selfObj.miExpressRaiseList = {}
    for i = 1,5 do
        local aiRaiseData = aiExpressRaiseList[i]
        if aiRaiseData ~= nil then
            
            local tData = {}
            tData.bFixedRatio = tonumber(aiRaiseData.bFixedRatio)
            tData.iOptionIndex = tonumber(aiRaiseData.iOptionIndex)
            tData.iRatioUp = tonumber(aiRaiseData.iRatioUp)
            tData.iRatioDown = tonumber(aiRaiseData.iRatioDown)
            tData.iCustomized = tonumber(aiRaiseData.iCustomized)

            selfObj.miExpressRaiseList[tData.iOptionIndex + 1] = tData
        else
            My_Lua_log(" file=[gameglobal] fun=[SetExpressRaiseList]; i="..i.." nil data")
        end
    end
end

--获得主题风格
function GetTheme(selfObj)
    if selfObj.miSelfGlobalSetting == nil then
        return 2
    end
    local tGameTheme = selfObj.miSelfGlobalSetting['TableTheme']
    return tonumber(tGameTheme)
end

--获得根据主题 系统语言对应的配置
function GetThemeDefineConfig(selfObj, aiData)
    local tConfigStr = nil
    if #aiData < 1 then
        return tConfigStr
    end
    local tTheme = selfObj:GetTheme()
    local tFile = "theme"
    local tThemeFile = ""
    local tLanguageFile = ""
    if THEMESTYLE.THEMESTYLE_GREEN == tTheme then
        --静谧黑
        tThemeFile = ".green"
    elseif THEMESTYLE.THEMESTYLE_BLUE == tTheme then
        --王祖蓝
        tThemeFile = ".blue"
    elseif THEMESTYLE.THEMESTYLE_GRINDBLACK == tTheme then
        --磨砂黑
        tThemeFile = ".grindblack"
    else
        --经典蓝
        tThemeFile = ".originalimage"
    end
    local tCurLanguage = selfObj:GetCurrentLanguage()
    if tCurLanguage == LANGUAGE_TYPE.G_LANGUAGE_ENGLISH then
        --英文
        tLanguageFile = ".englanguagedefine"
    elseif tCurLanguage == LANGUAGE_TYPE.G_LANGUAGE_CHINESE_CNS then
        --繁体中文
        tLanguageFile = ".cnslanguagedefine"
    elseif tCurLanguage == LANGUAGE_TYPE.G_LANGUAGE_JAPANESE then
        --日文
        tLanguageFile = ".jplanguagedefine"
    else
        --简体中文
        tLanguageFile = ".cnlanguagedefine"
    end

    local tTageFile = require(tFile..tThemeFile..tLanguageFile)
    if tTageFile ~= nil then
        for i = 1, #aiData do
            if tTageFile == nil then
                break
            end 
            tConfigStr = tTageFile[aiData[i]]
            tTageFile = tConfigStr            
        end
    end
    if tConfigStr == nil then
        tTageFile = require(tFile..".originalimage"..tLanguageFile)
        for i = 1, #aiData do
            if tTageFile == nil then
                break
            end 
            tConfigStr = tTageFile[aiData[i]]
            tTageFile = tConfigStr
        end
    end
    return tConfigStr
end

--获得根据主题 系统语言对应的配置  如果是table里面的table，参数依序传值
function GetThemeDefineConfigByArgs(selfObj, aiNameOne, aiNameTwo, aiNameThree)
    local aiData = {}
    if aiNameOne == nil then
        return
    else
        table.insert(aiData,aiNameOne)
        if aiNameTwo ~= nil then
            table.insert(aiData,aiNameTwo)
            if aiNameThree ~= nil then
                table.insert(aiData,aiNameThree)
            end
        end
    end    

--    for key, var in pairs(aiData) do
--        My_Lua_log(" file=[gameglobal] fun=[GetThemeDefineConfigByArgs]; key="..key)
--        My_Lua_log(" file=[gameglobal] fun=[GetThemeDefineConfigByArgs]; var="..var)
--    end    

    return selfObj:GetThemeDefineConfig(aiData)
end

--设置弹幕开关
function SetBulletOnOffByGameRoomId(selfObj, aiGameRoomId, aiOnOff)
    
    selfObj.miBulletOnOffList[aiGameRoomId] = aiOnOff
end

function GetBulletOnOffByGameRoomId(selfObj, aiGameRoomId)
    
    if selfObj.miBulletOnOffList[aiGameRoomId] == nil then
        return 0
    end
    return selfObj.miBulletOnOffList[aiGameRoomId]
end

--获得服务器费
function GetServiceCurrency(selfObj, aiBuy, aiSmallBlinds)
    local tServiceCurrency = 20

--    if aiSmallBlinds == 1 or aiSmallBlinds == 2 or aiSmallBlinds == 5 or aiSmallBlinds == 10 or aiSmallBlinds == 20 then
--        tServiceCurrency = (aiBuy * 10 )/100
--    elseif aiSmallBlinds == 25 or aiSmallBlinds == 50 or aiSmallBlinds == 100 or aiSmallBlinds == 200 or aiSmallBlinds == 300 or aiSmallBlinds == 500 then
--        tServiceCurrency = (aiBuy * 10 )/100
--    elseif aiSmallBlinds == 2500 or aiSmallBlinds == 5000 then
--        tServiceCurrency = (aiBuy * 5 )/100
--    else
--        tServiceCurrency = (aiBuy * 10 )/100
--    end

    local tDynamicConfig = cc.CClientPlatform:sharedClientPlatform():GetDynamicConfig(aiSmallBlinds)
    local tServiceCurrency = tDynamicConfig['ServiceFee'] * aiBuy / 100

    return tServiceCurrency
end

--大于1000的货币要转成1k 最后一个参数保留小数点后几位 默认2位
function CoinToStr(selfObj, aiCoin,aiFormatNum)
    local tFormatString = selfObj:GetThemeDefineConfigByArgs("STR_TEXT_FORMAT_K")
    if aiFormatNum == 0 then
        tFormatString = selfObj:GetThemeDefineConfigByArgs("STR_TEXT_FORMAT_K0")
    elseif aiFormatNum == 1 then
        tFormatString = selfObj:GetThemeDefineConfigByArgs("STR_TEXT_FORMAT_K1")
    end

    local tTemp = aiCoin/1000
    local x, y = math.modf(tTemp)
    if x > 0 then
       return string.format(tFormatString, tTemp)
    end
    return aiCoin
end

function int64CoinToStr(selfObj, aiCoin)
    local tTemp = aiCoin/1000
    local tTemp1 = aiCoin%1000
    if int64.tonumberint(tTemp) > 0 then
       local tFloatText = selfObj:GetThemeDefineConfigByArgs("STR_TEXT_FORMAT_FLOAT")
       local tKText = selfObj:GetThemeDefineConfigByArgs("STR_TEXT_FORMAT_K")
       local tfloat = string.format(tFloatText,  int64.tonumberint(tTemp), int64.tonumberint(tTemp1))
       return string.format(tKText,  tonumber(tfloat))
    end
    return int64.tonumberint(tTemp1)
end


--百分比 取小数点后几位 是否四舍五入  直接返回百分比
function GetDecimalValue(selfObj,aiPercent,aiNum,aiIsHalfAdjust)
    
    local tPowNum = math.pow(10,aiNum)

	aiPercent = aiPercent * 100
	local x, y = math.modf(aiPercent)
	if x >= 100 then

		x = 100
	else
		--如果保留到整数
		if aiNum == 0 then
			if aiIsHalAdjust == true then
				x = math.ceil(aiPercent)
				return x.."%"
			else
				return x.."%"
			end
			
		end
		if aiIsHalAdjust == true then
			x = math.ceil(aiPercent*tPowNum)
		else
			x = math.floor(aiPercent*tPowNum)
		end

		x = x / tPowNum
	end

	return x.."%"
end

--向下取整，保留n为小数
function GetPreciseDecimal(selfObj,aiValue,aiNum)
    
    if aiNum == nil or aiNum == 0 then
        return aiValue
    end

    local tResult = aiValue
    local tString = ""
    if aiValue > 999999999 then
        local tStr = tostring(aiValue/1000000000.0)
        local tStrB = string.sub(tStr, 1, 4)
        local tbegin, tEnd = string.find(tStrB, '%.')
        if tbegin == nil then
            tResult = tStrB
        else
            if tEnd == 4 then
                tStrB = string.sub(tStrB, 1, 3)
                tResult = tStrB
            else
                tResult = tStrB
            end            
        end
        tString = "B"
    elseif aiValue > 999999 then
        local tStr = tostring(aiValue/1000000.0)
        local tStrM = string.sub(tStr, 1, 4)
        local tbegin, tEnd = string.find(tStrM, '%.')
        if tbegin == nil then
            tResult = tStrM
        else
            if tEnd == 4 then
                tStrM = string.sub(tStrM, 1, 3)
                tResult = tStrM
            else
                tResult = tStrM
            end            
        end
        tString = "M"
    elseif  aiValue > 9999  then
        local tStr = tostring(aiValue/1000.0)
        local tStrK = string.sub(tStr, 1, 4)
        local tbegin, tEnd = string.find(tStrK, '%.', 1)
        if tbegin == nil then
            tResult = tStrK
        else
            if tEnd == 4 then
                tStrK = string.sub(tStr, 1, 3)
                tResult = tStrK
            else
                tResult = tStrK
            end            
        end
        tString = "K"
    else 
        tResult = aiValue
    end

    local x, y = math.modf(tResult)
    if y == 0 then
    	return x..tString
    end

	local tPowNum = math.pow(10,aiNum)
    local x, y = math.modf(tResult * tPowNum)
    
    if y == 0 then
        x = x / tPowNum
        return x..tString
    else
        x = x / tPowNum 

        local a, b = math.modf(x)
        if b == 0 then
        	return a..tString
        end   
    end

    return x..tString
end

--endregion

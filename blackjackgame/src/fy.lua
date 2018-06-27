
module(...,package.seeall)

function Create()
    local selfObj = {}
    setmetatable(selfObj, {__index = _M})
    return selfObj
end

function Init(selfObj)
    My_Lua_log(" file=[fy] fun=[Init]; ")
        --牌局所有数据结构
    GameDeskMgr = require("comm.gamedeskmgr")
    selfObj.miGameDeskMgr = GameDeskMgr.Create()

    --全局变量
    local GamegLobalObj = require("gameglobal")
    selfObj.GamegLobal = GamegLobalObj.Instance()

    --全局变量
    local TimemgrObj = require("comm.timemgr")
    selfObj.TimemgrLobal = TimemgrObj.Instance()

    --注册协议回调
    -- require("proto.TexasPokerCmd_pb")
    -- require("proto.TexasPokerCommon_pb")

    --游戏类型(用来表示是小游戏 ，还是牌局)
    --selfObj.miGameType = GAME_TYPE_ENUM.GAME_TYPE_TEXAS    

    --道具播放管理器
    local PlayAnimateMgrObj = require("comm.playanimationmgr")
    selfObj.miPlayAnimateMgr = PlayAnimateMgrObj.Create()

    
    --小游戏加载界面次数
    selfObj.miLoadTimes = 0

    --UI数据
    EventMgr = require("comm.eventmgr")
    selfObj.miEventMgr = EventMgr.Create(nil)
    selfObj.miEventMgr:AddListen( SYSTEM_MSG_TYPE_ENUM.SYSTEM_MSG_TYPE_ENUM_SCENE_EXIST_COCOS2DX, OnExistCocos2dx, 5, selfObj)

    local MiniGamegLobalObj = require("minigame.minigameglobal")
    selfObj.MiniGamegLobal = MiniGamegLobalObj.Instance()

    --协议接受处理中心
    -- NetMgr = require("net.protocolcenter")
    -- selfObj.miNetMgr = NetMgr.Instance()

        --小游戏Token
    selfObj.miMiniGameToken =""
end

function GetFyEvent(selfObj)
    return selfObj.miEventMgr
end

function OnExistCocos2dx(selfObj, aiEvent)
    cc.CClientPlatform:sharedClientPlatform():StopGame(aiEvent.miData.miType,aiEvent.miData.miRoomName)
    -- 小游戏清空：防止苹果在小游戏内被顶号的情况下，再次登录不会显示大厅
    if 1 == selfObj.miGameDeskMgr:GetCurGameRoomId() then
        selfObj:OnSetClearGameLuaHandler()
    end
end

function GetGameDeskMgr(selfObj)
    return selfObj.miGameDeskMgr
end

function GetGameDesk(selfObj, aiGameRoomId)
    return selfObj.miGameDeskMgr:GetGameDesk(aiGameRoomId)
end

--发送给所有牌局的消息通知
function SendEventToAllGameDesk(selfObj, aiEvent)
    selfObj.miGameDeskMgr:SendEventToAllGameDesk(aiEvent)
end


--发送给指定牌局的消息通知
function SendEventToAppointGameDesk(selfObj, aiGameRoomId, aiEvent)
    selfObj.miGameDeskMgr:SendEventToAppointGameDesk(aiGameRoomId, aiEvent)
end

--移除指定牌局
function RemoveGameDesk(selfObj, aiGameRoomId)
    selfObj.miGameDeskMgr:RemoveGameDesk(aiGameRoomId)
end

--初始化C++绑定接口
function InitCBinding(selfObj)
    My_Lua_log(" file=[fy] fun=[InitCBinding]; ")
    local function OnRequestPacket( buff )
        selfObj:RequestPacket( buff )
    end

    local function OnHttpRequestPacket( aiCmd, buff )
        selfObj:HttpRequestPacket( aiCmd, buff )
    end

    local function OnStartGame(aiGameType, aiLanguage, aiMttGameRoomId, aiGameRoomId, aiClubName, aiClubId)
        selfObj:SetPokerGame(aiGameType, aiLanguage, aiMttGameRoomId, aiGameRoomId, aiClubName, aiClubId)
    end

    local function OnStopGame()
        --selfObj:StopGame()
        selfObj.miNetMgr:StopGame()
    end

    local function OnUpdateHeadImg(aiUuid)
        selfObj:OnUpdateHeadImg(aiUuid)
    end

    --开始小游戏
    local function OnStartMiniGame(uuid, aiMiniTypelist, sToken)
        selfObj:StartMiniGame(uuid, aiMiniTypelist, sToken)
    end

    --断网
    local function OnNoConnect()
        selfObj:NoConnect()
    end

    --刷新备注
    local function OnUpdateRemarksStr(uuid)
        selfObj:UpdateRemarksStr(uuid)
    end

    --cc.CClientPlatform:sharedClientPlatform():SetLuaHandler(OnRequestPacket, OnStartGame, OnStopGame, OnUpdateHeadImg, OnNoConnect, OnStartMiniGame, OnHttpRequestPacket, OnUpdateRemarksStr)

    -- cc.CClientPlatform:sharedClientPlatform():SetBingluahandler("Requestluahandler", OnRequestPacket)
    -- cc.CClientPlatform:sharedClientPlatform():SetBingluahandler("StartGamehandler", OnStartGame)
    -- cc.CClientPlatform:sharedClientPlatform():SetBingluahandler("StopGamehandler", OnStopGame)
    -- cc.CClientPlatform:sharedClientPlatform():SetBingluahandler("UpdateHeadImghandler", OnUpdateHeadImg)
    -- cc.CClientPlatform:sharedClientPlatform():SetBingluahandler("NoConnecthandler", OnNoConnect)
    -- cc.CClientPlatform:sharedClientPlatform():SetBingluahandler("StartMiniGamehandler", OnStartMiniGame)
    -- cc.CClientPlatform:sharedClientPlatform():SetBingluahandler("HttpRequestluahandler", OnHttpRequestPacket)
    -- cc.CClientPlatform:sharedClientPlatform():SetBingluahandler("UpdateRemarksStrhandler", OnUpdateRemarksStr)

    --商城切换到游戏
    local function OnShopToGame()
        selfObj:ShopToGame()
    end

    --cc.CClientPlatform:sharedClientPlatform():SetShopToGameLuaHandler(OnShopToGame)
    -- cc.CClientPlatform:sharedClientPlatform():SetBingluahandler("ShopToGamehandler", OnShopToGame)

    --刷新用户数据
    local function OnUpdateUserBaseInfoData(uuid)
        selfObj:UpdateUserBaseInfoData(uuid)
    end
    --cc.CClientPlatform:sharedClientPlatform():SetUpdateUserBaseInfoDataLuaHandler(OnUpdateUserBaseInfoData)
    -- cc.CClientPlatform:sharedClientPlatform():SetBingluahandler("UpdateUserBaseInfoDataLuahandler", OnUpdateUserBaseInfoData)

    local function OnKickOutPush(aiType)    --账户被强制踢下线
        selfObj:OnKickOutPush(aiType)
        --selfObj.miNetMgr:OnKickOutPush()
    end
    --cc.CClientPlatform:sharedClientPlatform():SetKickOutPushLuaHandler(OnKickOutPush)
    -- cc.CClientPlatform:sharedClientPlatform():SetBingluahandler("KickOutPushLuaHandler", OnKickOutPush)

    --开始播放其它人语音
    local function OnAudioPlayerDidStartPlaying( uuid, name, timer, aiGameRoomId )
        selfObj:OnAudioPlayerDidStartPlaying( uuid, name, timer, aiGameRoomId )
    end

    local function OnAudioPlayerCancelOperation( uuid, aiGameRoomId )   --播放其它人语音取消
        selfObj:OnAudioPlayerCancelOperation( uuid, aiGameRoomId )
    end

    local function OnAudioPlayerDidFinishPlaying( uuid, aiGameRoomId )    --播放其它人语音完成
        selfObj:OnAudioPlayerDidFinishPlaying( uuid, aiGameRoomId )
    end

    local function OnApplicationDidEnterBackground()    --
        selfObj:OnApplicationDidEnterBackground()
    end

    local function OnApplicationWillEnterForeground()    --
        selfObj:OnApplicationWillEnterForeground()
    end

    local function OnSetSingnalValue(str)    --信号
        selfObj:OnSetSingnalValue(str)
    end

    local function OnUpdatekVersion(str)    --更新版本
        selfObj:OnUpdatekVersion(str)
    end
    --cc.CClientPlatform:sharedClientPlatform():SetUpdatekVersionLuaHandler(OnUpdatekVersion)
    -- cc.CClientPlatform:sharedClientPlatform():SetBingluahandler("UpdatekVersionLuaHandler", OnUpdatekVersion)

    local function OnGetVersionLuaHandler()    --获得当前版本
        return GPackageVersion
    end

    local function OnGetIsSitDownLuaHandler()    --是否坐下
        return selfObj:OnGetIsSitDownLuaHandler()
    end
    --cc.CClientPlatform:sharedClientPlatform():SetGetIsSitDownLuaHandler(OnGetIsSitDownLuaHandler)
    -- cc.CClientPlatform:sharedClientPlatform():SetBingluahandler("GetIsSitDownLuaHandler", OnGetIsSitDownLuaHandler)

    local function OnGetCurGameRoomIdLuaHandler()    --现在展示房间gameroomid
        return selfObj:OnGetCurGameRoomIdLuaHandler()
    end
    local function OnGetCurClubIdLuaHandler()    --现在房间clubid
        return selfObj:OnGetCurClubIdLuaHandler()
    end
    --cc.CClientPlatform:sharedClientPlatform():SetGetCurGameRoomIdLuaHandler(OnGetCurGameRoomIdLuaHandler, OnGetCurClubIdLuaHandler)
    -- cc.CClientPlatform:sharedClientPlatform():SetBingluahandler("GetCurGameRoomIdLuaHandler", OnGetCurGameRoomIdLuaHandler)
    -- cc.CClientPlatform:sharedClientPlatform():SetBingluahandler("GetCurClubIdLuaHandler", OnGetCurClubIdLuaHandler)

    --设置sng请求买入通知
    local function OnSetSngControlBuyinMsgLuaHandler(aiNum)
        selfObj:OnSetSngControlBuyinMsgLuaHandler(aiNum)
    end
    --cc.CClientPlatform:sharedClientPlatform():SetSngControlBuyinMsgLuaHandler(OnSetSngControlBuyinMsgLuaHandler)
    -- cc.CClientPlatform:sharedClientPlatform():SetBingluahandler("SngControlBuyinMsgLuaHandler", OnSetSngControlBuyinMsgLuaHandler)

    --退出清空数据请求买入通知
    local function OnSetClearGameLuaHandler()
        selfObj:OnSetClearGameLuaHandler()
    end
    --cc.CClientPlatform:sharedClientPlatform():SetClearGameLuaHandler(OnSetClearGameLuaHandler)
    -- cc.CClientPlatform:sharedClientPlatform():SetBingluahandler("ClearGameLuaHandler", OnSetClearGameLuaHandler)

    local function OnSetIsUpdatekVersionProceedLuaHandler()
        selfObj:OnSetIsUpdatekVersionProceedLuaHandler()
    end
    --cc.CClientPlatform:sharedClientPlatform():SetIsUpdatekVersionProceedLuaHandler(OnSetIsUpdatekVersionProceedLuaHandler)
    -- cc.CClientPlatform:sharedClientPlatform():SetBingluahandler("IsUpdatekVersionProceedLuaHandler", OnSetIsUpdatekVersionProceedLuaHandler)

    local function OnSetMiniGameSendFailedHandler(aiCmdId)
        selfObj:OnSetMiniGameSendFailedHandler(aiCmdId)
    end
    --cc.CClientPlatform:sharedClientPlatform():SetMiniGameSendFailedHandler(OnSetMiniGameSendFailedHandler)
    -- cc.CClientPlatform:sharedClientPlatform():SetBingluahandler("MiniGameSendFailedHandler", OnSetMiniGameSendFailedHandler)
    local function OnSetUpdateFriendUserDataHandler(aiUuid)
        selfObj:OnSetUpdateFriendUserDataHandler(aiUuid)
    end
    --cc.CClientPlatform:sharedClientPlatform():SetUpdateFriendUserDataHandler(OnSetUpdateFriendUserDataHandler)
    -- cc.CClientPlatform:sharedClientPlatform():SetBingluahandler("UpdateFriendUserDataHandler", OnSetUpdateFriendUserDataHandler)

    --cc.CClientPlatform:sharedClientPlatform():SetGetVersionLuaHandler(OnGetVersionLuaHandler)
    -- cc.CClientPlatform:sharedClientPlatform():SetBingluahandler("GetVersionLuaHandler", OnGetVersionLuaHandler)

    --cc.CClientPlatform:sharedClientPlatform():SetSingnalValueLuaHandler(OnSetSingnalValue)
    -- cc.CClientPlatform:sharedClientPlatform():SetBingluahandler("SingnalValueLuahandler", OnSetSingnalValue)

    --cc.CClientPlatform:sharedClientPlatform():SetApplicationDidEnterBackgroundHandler(OnApplicationDidEnterBackground)
    -- cc.CClientPlatform:sharedClientPlatform():SetBingluahandler("DidEnterBackgroundHandler", OnApplicationDidEnterBackground)

    --cc.CClientPlatform:sharedClientPlatform():SetApplicationWillEnterForegroundHandler(OnApplicationWillEnterForeground)
    -- cc.CClientPlatform:sharedClientPlatform():SetBingluahandler("WillEnterForegroundHandler", OnApplicationWillEnterForeground)

    --cc.CClientPlatform:sharedClientPlatform():SetAudioLuaHandler(OnAudioPlayerDidStartPlaying, OnAudioPlayerCancelOperation, OnAudioPlayerDidFinishPlaying)
    -- cc.CClientPlatform:sharedClientPlatform():SetBingluahandler("AudioPlayerDidStartPlayinghandler", OnAudioPlayerDidStartPlaying)
    -- cc.CClientPlatform:sharedClientPlatform():SetBingluahandler("AudioPlayerCancelOperationhandler", OnAudioPlayerCancelOperation)
    -- cc.CClientPlatform:sharedClientPlatform():SetBingluahandler("AudioPlayerDidFinishPlayinghandler", OnAudioPlayerDidFinishPlaying)
    local function OnSetNotifyCharge(str)    --充电通知
        selfObj:OnSetNotifyCharge(str)
    end
    --cc.CClientPlatform:sharedClientPlatform():SetNotifyLuaHandler(OnSetNotifyCharge)
    -- cc.CClientPlatform:sharedClientPlatform():SetBingluahandler("NotifyLuaHandler", OnSetNotifyCharge)

    local function OnSetNotifyCommentOnOff(aiGameRoomId,aiOnOff)    --弹幕开关通知
        selfObj:OnSetNotifyCommentOnOff(aiGameRoomId,aiOnOff)
    end
    --cc.CClientPlatform:sharedClientPlatform():SetCommentOnOffLuaHandler(OnSetNotifyCommentOnOff)
    -- cc.CClientPlatform:sharedClientPlatform():SetBingluahandler("CommentOnOffLuahandler", OnSetNotifyCommentOnOff)

    local function OnGetFaceData(aiFaceType)    --获得表情数据
        return selfObj:OnGetFaceData(aiFaceType)
    end
    -- cc.CClientPlatform:sharedClientPlatform():SetBingluahandler("GetFaceDataLuaHandler", OnGetFaceData)

    local function OnPlayFace(aiFaceId)    --播放表情
        return selfObj:OnPlayFace(aiFaceId)
    end
    -- cc.CClientPlatform:sharedClientPlatform():SetBingluahandler("PlayFaceLuaHandler", OnPlayFace)

    --初始化小游戏加载次数
    selfObj.miLoadTimes = 0
end

function OnPlayFace(selfObj, aiFaceId)
    --自己播放表情
    local aiEvent = {}
    aiEvent.type = PUBLIC_MSG_TYPE_ENUM.PUBLIC_MSG_TYPE_ENUM_SELF_FREE_FACE_MSG
    aiEvent.miData = {}
    aiEvent.miData.sMsg = aiFaceId
    selfObj:SendEventToAllGameDesk(aiEvent)
end

--获得表情数据
function OnGetFaceData(selfObj, aiFaceType)
My_Lua_log(" file=[fy] fun=[OnGetFaceData]; aiFaceType="..aiFaceType)
    local LOCAL_GAMEFACE_OBJ = require "configdata.gamefacedata"
    local LOCAL_GAMEMAGICFACE_OBJ = require "configdata.gamemagicfacedata"
    local tMagicFace = nil
    if aiFaceType == 1 then
        local tGameFaceObj = LOCAL_GAMEFACE_OBJ.Create()
        tMagicFace = tGameFaceObj:GetData()
    elseif aiFaceType == 2 then
        local tCurLanguage = G_Fy.GamegLobal:GetCurrentLanguage()
        local tGameMagicFaceObj = LOCAL_GAMEMAGICFACE_OBJ.Create()
        tMagicFace = tGameMagicFaceObj:GetDataByLanguage(tCurLanguage)
    else
        return ""
    end
My_Lua_log(" file=[fy] fun=[OnGetFaceData]; 111111aiFaceType="..aiFaceType)
--return 7, ";"

    return (tMagicFace[1].id .. ";"..tMagicFace[1].icon),(tMagicFace[2].id .. ";"..tMagicFace[2].icon),(tMagicFace[3].id .. ";"..tMagicFace[3].icon),(tMagicFace[4].id .. ";"..tMagicFace[4].icon),(tMagicFace[5].id .. ";"..tMagicFace[5].icon),(tMagicFace[6].id .. ";"..tMagicFace[6].icon),(tMagicFace[7].id .. ";"..tMagicFace[7].icon),(tMagicFace[8].id .. ";"..tMagicFace[8].icon),(tMagicFace[9].id .. ";"..tMagicFace[9].icon),(tMagicFace[10].id .. ";"..tMagicFace[10].icon),(tMagicFace[11].id .. ";"..tMagicFace[11].icon),(tMagicFace[12].id .. ";"..tMagicFace[12].icon)
end

--获取系统时间
function GetLocationMilliTime(selfObj)

    -- local tCurTime = cc.CClientPlatform:sharedClientPlatform():GetLocationMilliTime()
    local tCurTime = os.time()
    return tCurTime
end

--开始
function Start(selfObj)
    My_Lua_log(" file=[fy] fun=[start]; ")
    selfObj:InitCBinding()

    local tIsSuitHeight = selfObj.GamegLobal:IsDesignSizeByHeight()
    local tFrameSize = cc.Director:getInstance():getOpenGLView():getFrameSize()
    local tPlatform = selfObj.GamegLobal:GetPhonePlatform()
    local designSize = DesignResolutionSizeList[tPlatform]
    
    if tIsSuitHeight == true then
        local tWidth = tFrameSize.height / designSize.height * designSize.width;
        cc.Director:getInstance():getOpenGLView():setDesignResolutionSize( tWidth, designSize.height, cc.ResolutionPolicy.FIXED_HEIGHT)
    else
        --三星S8适配宽度
        local tHeight = tFrameSize.width / designSize.width * designSize.height;
        cc.Director:getInstance():getOpenGLView():setDesignResolutionSize( designSize.width, tHeight, cc.ResolutionPolicy.FIXED_WIDTH)
    end

    local GameMain = require("hallscene.game")
    local sceneGame =GameMain.Instance():GetScene()
    cc.Director:getInstance():replaceScene(sceneGame)

    selfObj:StartMiniGame(14, 14, nil)

end

--—运行
function Run(selfObj, aiDelTime)
    
    local app = cc.Application:getInstance()
    local target = app:getTargetPlatform()
    if target == cc.PLATFORM_OS_ANDROID then
        --selfObj.miNetMgr:LoadStartGame()
		cc.CClientPlatform:sharedClientPlatform():ExecuteSpecialHandling()
    end
    -- selfObj.miNetMgr:Update(aiDelTime)
    selfObj.TimemgrLobal:Update(aiDelTime)
    selfObj.miEventMgr:Update(aiDelTime)
    selfObj.miGameDeskMgr:Update(aiDelTime)
    selfObj.miPlayAnimateMgr:Update(aiDelTime)
    -- selfObj.miPofcFy:Update(aiDelTime)
end

function OnApplicationDidEnterBackground(selfObj)

    local aiEvent = {}
    aiEvent.type = SYSTEM_MSG_TYPE_ENUM.SYSTEM_MSG_TYPE_ENUM_NOTIFY_APPLICATIONDIDENTERBACKGROUND_MSG
    aiEvent.miData = {}
    selfObj.miEventMgr:Dispatch(aiEvent)


    if selfObj.GamegLobal:GetIsOpenGmaeState() == false then
        return
    end
    My_Lua_log(" file=[fy] fun=[OnApplicationDidEnterBackground];")

    --小游戏切后台
    local tGameType = selfObj.GamegLobal:GetGameType()
    if tGameType == GAME_TYPE_ENUM.GAME_TYPE_MINI then
        
        local aiEventPag = {}
        aiEventPag.type = SYSTEM_MSG_TYPE_ENUM.SYSTEM_MSG_TYPE_ENUM_NOTIFY_APPLICATIONDIDENTERBACKGROUND_MSG
        aiEventPag.miData = {}
        selfObj:SendEventToAllGameDesk(aiEventPag)
    end

    selfObj:GetGameDeskMgr():SendAllDelayFoldData()

    --显示过渡界面
    local aiEventPag = {}
    aiEventPag.type = PUBLIC_MSG_TYPE_ENUM.PUBLIC_MSG_TYPE_ENUM_TRANSITION_VISIBLE_MSG
    aiEventPag.miData = {}
    aiEventPag.miData.miVisible = false
    selfObj:SendEventToAllGameDesk(aiEventPag)

    selfObj.GamegLobal:SetIsEnterBackground(true)
    cc.CClientPlatform:sharedClientPlatform():CancelQueue()

    selfObj.miNetMgr:RemoveAllPackage()
end

---信号
function OnSetSingnalValue(selfObj, str)
    if selfObj.GamegLobal:GetIsOpenGmaeState() == false then
        return
    end
    local aiEvent = {}
    aiEvent.type = PUBLIC_MSG_TYPE_ENUM.PUBLIC_MSG_TYPE_ENUM_UPDATE_SINGNAL_VALUE_MSG
    aiEvent.miData = {}
    aiEvent.miData.miValue = str
    selfObj:SendEventToAllGameDesk(aiEvent)
end


function OnApplicationWillEnterForeground(selfObj)

    local aiEvent = {}
    aiEvent.type = SYSTEM_MSG_TYPE_ENUM.SYSTEM_MSG_TYPE_ENUM_NOTIFY_APPLICATIONDIDENTERFOREGROUND_MSG
    aiEvent.miData = {}
    selfObj.miEventMgr:Dispatch(aiEvent)

    if selfObj.GamegLobal:GetIsOpenGmaeState() == false then
        return
    end

    --小游戏切前台
    local tGameType = selfObj.GamegLobal:GetGameType()
    if tGameType == GAME_TYPE_ENUM.GAME_TYPE_MINI then
        
        local aiEventPag = {}
        aiEventPag.type = SYSTEM_MSG_TYPE_ENUM.SYSTEM_MSG_TYPE_ENUM_NOTIFY_APPLICATIONDIDENTERFOREGROUND_MSG
        aiEventPag.miData = {}
        selfObj:SendEventToAllGameDesk(aiEventPag)
    end

    --放弃效果数据
    selfObj.miGameDeskMgr:SetDelayFoldData()

    selfObj.miGameDeskMgr:EmptyWinOddsDataList()

    selfObj.GamegLobal:SetIsEnterBackground(false)
    --停止接收不相关协议
    selfObj.GamegLobal:SetIsStopSendPake(true)

    My_Lua_log(" file=[fy] fun=[OnApplicationWillEnterForeground];")

    --selfObj.miNetMgr:RemoveAllPackage()

    --停止语音部分
--    selfObj:OnAudioPlayerDidFinishPlaying()
--    cc.CClientPlatform:sharedClientPlatform():CancelQueue()

    --发送重新获取房间数据
    selfObj.miGameDeskMgr:GetAllGameRoomInfo()


    --这里清空需要在优化处理
    --cc.Director:getInstance():getActionManager():removeAllActions()
--cc.CClientPlatform:sharedClientPlatform():StopNodeAndChildrenAllAction()
    
    --清空事件列表
    selfObj.miGameDeskMgr:ClearAllGameRoomState()
    selfObj.miGameDeskMgr:ClearAllGameRoomStateChangeList()

    --lodingpag 锁住界面
    local aiLoadEventPag = {}
    aiLoadEventPag.type = PUBLIC_MSG_TYPE_ENUM.PUBLIC_MSG_TYPE_ENUM_SHOW_LOADING_PAG
    aiLoadEventPag.miPagName = "lodingpag"
    aiLoadEventPag.miData = {}
    aiLoadEventPag.miData.miIsShow = true
    selfObj:SendEventToAllGameDesk(aiLoadEventPag)

    --重置所有人UI
    local aiResetEventPag = {}
    aiResetEventPag.type = PUBLIC_MSG_TYPE_ENUM.PUBLIC_MSG_TYPE_ENUM_PLAYER_RESET_UI_MSG
    aiResetEventPag.miData = {}
    selfObj:SendEventToAllGameDesk(aiResetEventPag)

    --获取所有请求买入
    --selfObj:SendGetAllBuyinControlsPacket(cc.CClientPlatform:sharedClientPlatform():GetUuid())
    --获取是否有买入消息  android 和 ios区别对待
    local app = cc.Application:getInstance()
    local target = app:getTargetPlatform()
    if target == cc.PLATFORM_OS_ANDROID then
        local aiEventPag = {}
        aiEventPag.type = PUBLIC_MSG_TYPE_ENUM.PUBLIC_MSG_TYPE_ENUM_SNG_ALL_BUYIN_CONTROLS_INVITE_MSG
        aiEventPag.miData = {}
        selfObj:SendEventToAllGameDesk(aiEventPag)
    else
        require("proto.TexasPoker_pb")
        local tPacke = TexasPoker_pb.CSGetAllBuyinControls()
        tPacke.uuid = cc.CClientPlatform:sharedClientPlatform():GetUuid()
        tPacke.lGameRoomID = selfObj.miGameDeskMgr:GetCurGameRoomId()
        local tBuff = tPacke:SerializeToString()
        cc.CClientPlatform:sharedClientPlatform():SendHttpPacket(TexasPokerCmd_pb.Cmd_CSGetAllBuyinControls, tBuff, #tBuff)
    end
    

    --清空系统消息和俱乐部推送列表数据
    selfObj.GamegLobal:EmptyPushSystemMsgList()
    --系统通知界面
    local aiSystemEvent = {}
    aiSystemEvent.type = PUBLIC_MSG_TYPE_ENUM.PUBLIC_MSG_TYPE_ENUM_START_SYSTEM_NOTIFY_PAG_MSG
    aiSystemEvent.miData = {}
    selfObj:SendEventToAllGameDesk(aiSystemEvent)

    --显示过渡界面
    local aiTranEventPag = {}
    aiTranEventPag.type = PUBLIC_MSG_TYPE_ENUM.PUBLIC_MSG_TYPE_ENUM_TRANSITION_VISIBLE_MSG
    aiTranEventPag.miData = {}
    aiTranEventPag.miData.miVisible = false
    selfObj:SendEventToAllGameDesk(aiTranEventPag)

    --停止所有牌桌语音
    local aiAudioEvent = {}
    aiAudioEvent.type = PUBLIC_MSG_TYPE_ENUM.PUBLIC_MSG_TYPE_ENUM_PLAYER_PLAY_AUDIO_FINISH_MSG
    aiAudioEvent.miData = {}
    selfObj:SendEventToAllGameDesk(aiAudioEvent)

    selfObj.miGameDeskMgr:NotifyClubBuyinMsg()    

    --是小游戏就更新德扑币
    if 1 == selfObj.miGameDeskMgr:GetCurGameRoomId() then
        require("proto.TexasPokerHttpUser_pb")
        local tPacke = TexasPokerHttpUser_pb.CSGetUserInfoV4()
        tPacke.uuid = cc.CClientPlatform:sharedClientPlatform():GetUuid()
        tPacke.lGetUuid = cc.CClientPlatform:sharedClientPlatform():GetUuid()
        tPacke.lGameRoomID  = selfObj.miGameDeskMgr:GetCurGameRoomId()
        tPacke.lClubID = 0
        tPacke.bRemark = 1
        tPacke.eGameRoomType = 1
        tPacke.sTimeZoneId = cc.CClientPlatform:sharedClientPlatform():GetTimeZoneId()
        local tBuff = tPacke:SerializeToString()
        cc.CClientPlatform:sharedClientPlatform():SendHttpPacket(TexasPokerCmd_pb.Cmd_CSGetUserInfoV4, tBuff, #tBuff)
    end
    
    --清空所有弹幕数据
    local aiBulletEvent = {}
    aiBulletEvent.type = PUBLIC_MSG_TYPE_ENUM.PUBLIC_MSG_TYPE_ENUM_NOTIFY_CLEAR_BULLET_DATA_MSG
    aiBulletEvent.miData = {}
    selfObj:SendEventToAllGameDesk(aiBulletEvent)

    --清空道具列表
    selfObj.miPlayAnimateMgr:OnInitItemList()
end

--断网
function NoConnect(selfObj)
    My_Lua_log(" file=[fy] fun=[NoConnect];")
    --or selfObj.miIsEnterBackground == true then
    selfObj.miGameType = selfObj.GamegLobal:GetGameType()
    if selfObj.miGameType == GAME_TYPE_ENUM.GAME_TYPE_MINI then
        return
    else
        if selfObj.GamegLobal:GetIsOpenGmaeState() == false or selfObj.GamegLobal:GetIsEnterBackground() == true then
            return
        end
    end

    local aiEvent = {}
    aiEvent.type = PUBLIC_MSG_TYPE_ENUM.PUBLIC_MSG_TYPE_ENUM_UPDATE_SINGNAL_VALUE_MSG
    aiEvent.miData = {}
    aiEvent.miData.miValue = "0"
    --selfObj.EventMgr.Instance():Dispatch(aiEvent)
    selfObj:SendEventToAllGameDesk(aiEvent)

    if selfObj.miIsOverGmaeState == false then
        local aiEventPag = {}
        aiEventPag.type = PUBLIC_MSG_TYPE_ENUM.PUBLIC_MSG_TYPE_ENUM_SHOW_LOADING_PAG
        aiEventPag.miPagName = "lodingpag"
        aiEventPag.miData = {}
        aiEventPag.miData.miIsShow = true
        --selfObj.EventMgr.Instance():Dispatch(aiEventPag)
        selfObj:SendEventToAllGameDesk(aiEventPag)
    else
        selfObj:ColseLoadingPag()
    end
end


--刷新备注
function UpdateRemarksStr(selfObj, aiUuid)
    My_Lua_log(" file=[fy] fun=[UpdateRemarksStr]; aiUuid=["..aiUuid.."]")
    local aiEvent = {}
    aiEvent.type = PUBLIC_MSG_TYPE_ENUM.PUBLIC_MSG_TYPE_ENUM_UPDATE_REMARKS_STR_MSG
    aiEvent.miData = {}
    aiEvent.miData.uuid = aiUuid
    --selfObj.EventMgr.Instance():Dispatch(aiEvent)
    selfObj:SendEventToAllGameDesk(aiEvent)
end

--商城切换到游戏
function ShopToGame(selfObj)
    My_Lua_log(" file=[fy] fun=[ShopToGame];")
    
    local lCurCoin = selfObj.GamegLobal:GetCoin()
    local aiEvent = {}
    aiEvent.type = PUBLIC_MSG_TYPE_ENUM.PUBLIC_MSG_TYPE_ENUM_NOTIFY_REFRESH_COIN
    aiEvent.miData = {}
    aiEvent.miData.lCurCoin = lCurCoin
    selfObj:GetFyEvent():NextDispatch(aiEvent)
end

--刷新用户数据
function UpdateUserBaseInfoData(selfObj, uuid)
    My_Lua_log(" file=[fy] fun=[UpdateUserBaseInfoData];")
    
    local aiEventPag = {}
    aiEventPag.type = PUBLIC_MSG_TYPE_ENUM.PUBLIC_MSG_TYPE_ENUM_NOTYFY_UPDATE_LOCALUSERINFOLIST_MSG
    aiEventPag.miData = {}
    aiEventPag.miData.miUuid = uuid
    selfObj:SendEventToAllGameDesk(aiEventPag)
end

--关闭loadingpag
function ColseLoadingPag(selfObj)
    local aiEventPag = {}
    aiEventPag.type = PUBLIC_MSG_TYPE_ENUM.PUBLIC_MSG_TYPE_ENUM_SHOW_LOADING_PAG
    aiEventPag.miPagName = "lodingpag"
    aiEventPag.miData = {}
    aiEventPag.miData.miIsShow = false
    --selfObj.EventMgr.Instance():Dispatch(aiEventPag)
    selfObj:SendEventToAllGameDesk(aiEventPag)
end

--设置牌局类型
function SetPokerGame(selfObj, aiGameType, aiLanguage, aiMttGameRoomId, aiGameRoomId, aiClubName, aiClubId)
    
    selfObj.miNetMgr:RemoveAllPackage()
    --保持亮屏
    cc.Device:setKeepScreenOn(true)

    My_Lua_log(" file=[fy] fun=[SetPokerGame];aiLanguage=" .. aiLanguage .." aiMttGameRoomId="..aiMttGameRoomId.." aiGameRoomId="..aiGameRoomId)    

    selfObj.GamegLobal:SetCurGameRoomId(aiGameRoomId)
    selfObj.GamegLobal:SetGameType(aiGameType)
    My_Lua_log(" file=[fy] fun=[SetPokerGame]; selfObj.miGameType=" .. aiGameType)    

    My_Lua_log(" file=[fy] fun=[SetPokerGame]; aiClubId=" ..tostring(aiClubId).." aiClubName="..tostring(aiClubName))    

    --是否开启游戏了
    selfObj.GamegLobal:SetIsOpenGmaeState(true)
    --是否游戏结束了
    selfObj.GamegLobal:SetIsOverGmaeState(false)
    --开始接受协议
    selfObj.GamegLobal:SetIsStopSendPake(false)

    --语言切换改变logo图片
    local GameMain = require("hallscene.game")
    GameMain.Instance():SetTransitionLanguage(aiLanguage)

    --设置本地的个人设置
    selfObj.GamegLobal:InitSelfGlobalSetting()
    selfObj.GamegLobal:InitGameMute()

    --清空本地缓存用户数据
    selfObj.GamegLobal:EmptyUserBaseInfoList()

    --公告消息清空
    selfObj.GamegLobal:EmptyPushSystemMsgList()

    --设置语言
    selfObj.GamegLobal:SetCurrentLanguage(aiLanguage)

    --通知APP改变当前gameroomid
    cc.CClientPlatform:sharedClientPlatform():ChangeGameRoomId(aiGameRoomId, aiClubId)

    --设置当前房间id,俱乐部名列表,当前俱乐部id,牌局内弹幕开关
    selfObj.GamegLobal:SetGlobalCurData(aiGameRoomId)
end

--小游戏进入mtt
function SetPokerTypeFromMiniGame(selfObj, aiGameType)
    selfObj.GamegLobal:SetGameType(aiGameType)
    --是否开启游戏了
    selfObj.GamegLobal:SetIsOpenGmaeState(true)
    --是否游戏结束了
    selfObj.GamegLobal:SetIsOverGmaeState(false)
end

--是否坐下
function OnGetIsSitDownLuaHandler(selfObj)
    return selfObj:GetGameDeskMgr():OnGetIsSitDown()
end

--现在房间gameroomid
function OnGetCurGameRoomIdLuaHandler(selfObj)
    return selfObj:GetGameDeskMgr():GetCurGameRoomId()
end

--现在房间clubid
function OnGetCurClubIdLuaHandler(selfObj)
    return selfObj.GamegLobal:GetCurClubId()
end

function StartGame(selfObj)
    My_Lua_log(" file=[fy] fun=[startgame]; ")
end

function OnKickOutPush(selfObj, aiType)
    local tCurGameroomId = selfObj.GamegLobal:GetCurGameRoomId()
    My_Lua_log(" file=[fy] fun=[OnKickOutPush]; tCurGameroomId="..tCurGameroomId)
    selfObj.miNetMgr:StopGame(tCurGameroomId)

    local aiEvent = {}
    aiEvent.type = SYSTEM_MSG_TYPE_ENUM.SYSTEM_MSG_TYPE_ENUM_SCENE_EXIST_COCOS2DX
    aiEvent.miData = {}
    aiEvent.miData.miType = aiType
    aiEvent.miData.miRoomName = ""
    selfObj:GetFyEvent():NextDispatch(aiEvent)

    --cc.CClientPlatform:sharedClientPlatform():StopGame(0, "")
end

function StopGame(selfObj)
    My_Lua_log(" file=[fy] fun=[stopgame]; ")
end

--清空数据
function OnSetClearGameLuaHandler(selfObj)
    My_Lua_log(" file=[fy] fun=[OnSetClearGameLuaHandler]; ")
    --selfObj.miNetMgr:StopGame()
    selfObj:GetGameDeskMgr():RemoveALLGameDesk()
    --是否开启游戏了
    selfObj.GamegLobal:SetIsOpenGmaeState(false)
    --是否游戏结束了
    selfObj.GamegLobal:SetIsOverGmaeState(true)

    selfObj.GamegLobal:SetIsEnterBackground(false)
end

function OnUpdatekVersion(selfObj, str)    --更新版本
    zsy.cUtils.savefile(str,"tempupdatefile.lua")
    package.preload["tempupdatefile"] = nil
    package.loaded["tempupdatefile"] = nil
    local updateManager = require("game.update.updatemanager_new")
    local tRetuen = updateManager:Compare(function ( ... ) end, function ( ... ) end)
end

function OnSetIsUpdatekVersionProceedLuaHandler()
    local updateManager = require("game.update.updatemanager_new")
    return updateManager.IsUpdateProceed
end

--小游戏开始
function StartMiniGame(selfObj, uuid, aiMiniTypeId, sToken)
--    --游戏类型(用来表示是小游戏 ，还是牌局)
    selfObj.miMiniGameUuid = uuid
    selfObj.miMiniGameToken = sToken

    -- selfObj.miGameType = selfObj.GamegLobal:GetGameType()
    selfObj.miGameType = GAME_TYPE_ENUM.GAME_TYPE_MINI
My_Lua_log(" file=[fy] fun=[StartMiniGame]; gameroomid exist; gameroomid=" .. selfObj.miGameType)
    if selfObj.miGameType == GAME_TYPE_ENUM.GAME_TYPE_MINI then
        selfObj.miGameType = GAME_TYPE_ENUM.GAME_TYPE_MINI
        ----------------------------------------------------
        local tGameDeskMgr = selfObj:GetGameDeskMgr()
        local tGameDesk = tGameDeskMgr:GetGameDesk(1)
        if tGameDesk ~= nil then
            My_Lua_log(" file=[protocolcenter] fun=[entergameroomrsp]; gameroomid exist222; gameroomid=")
        end

        local aiData={}
        aiData.aiGameMiniType = 1
        aiData.aiMiniTypeId = aiMiniTypeId
        tGameDesk = tGameDeskMgr:CreateGameDesk(GAME_TYPE_ENUM.GAME_TYPE_MINI, aiData)

        selfObj.miIsLoadStartGame = false
        selfObj.miIsOpenSound = true
        ----------------------------------------------------
    elseif selfObj.miGameType == GAME_TYPE_ENUM.GAME_TYPE_ALLINODDS then
        selfObj.miGameType = GAME_TYPE_ENUM.GAME_TYPE_ALLINODDS
        ----------------------------------------------------
        local tGameDeskMgr = selfObj:GetGameDeskMgr()
        local tGameDesk = tGameDeskMgr:GetGameDesk(1)
        if tGameDesk ~= nil then
            My_Lua_log(" file=[protocolcenter] fun=[entergameroomrsp]; gameroomid exist; gameroomid=")
        end

        local aiData={}
        aiData.aiGameMiniType = 1
        tGameDesk = tGameDeskMgr:CreateGameDesk(GAME_TYPE_ENUM.GAME_TYPE_ALLINODDS, aiData)

        selfObj.miIsLoadStartGame = false
        selfObj.miIsOpenSound = true
        ----------------------------------------------------
    end

end

function RequestPacket(selfObj, buff)
    
    selfObj.miNetMgr:RequestPacket(buff)

--    --or selfObj.miIsEnterBackground == true
--    if selfObj.miIsOpenGmaeState == false or selfObj.miIsEnterBackground == true then
--        return
--    end

--    My_Lua_log(" file=[fy] fun=[requestpacket]; bufflen=[".. string.len(buff) .. "]")
--    require("proto.TexasPokerCommon_pb")
--    local msg = TexasPokerCommon_pb.Package()
--    msg:ParseFromString(buff)

--    if msg.uuid ~= nil and msg.eCmd ~= nil then
--        selfObj.miPlayer.uuid = msg.uuid
--        My_Lua_log(" file=[fy] fun=[requestpacket]; uuid=[" .. msg.uuid .."] Cmd=[" .. msg.eCmd .. "]")
--        selfObj:ProtoCallFun(msg)
--    else
--        My_Lua_log(" file=[fy] fun=[requestpacket]; error packet parse error")
--    end

--    --防止没有接受到重连后，重新获取房间信息协议。loading界面不消失BUG
--    --if selfObj.miIsOverGmaeState == true then
--    --    selfObj:ColseLoadingPag()
--    --end
--    --if msg.eCmd ~= TexasPokerCmd_pb.Cmd_SCReconnectRsp and msg.eCmd ~= TexasPokerCmd_pb.Cmd_SCReconnectOpenTestRsp then
--        selfObj:ColseLoadingPag()
--    --end
end

function HttpRequestPacket(selfObj, aiCmd, buff)
      --selfObj.miNetMgr:HttpRequestPacket(aiCmd, buff)


--    if selfObj.miIsOpenGmaeState == false then
--        return
--    end

--    My_Lua_log(" file=[fy] fun=[httprequestpacket]; aiCmd=[".. aiCmd .. "]")
--    if aiCmd ~= nil then
--        selfObj:HttpProtoCallFun(aiCmd, buff)
--    else
--        My_Lua_log(" file=[fy] fun=[httprequestpacket]; error packet parse error")
--    end

end

function HttpProtoCallFun(selfObj, aiCmd, buff)
    --selfObj.miNetMgr:HttpProtoCallFun(aiCmd, buff)

--    My_Lua_log(" file=[fy] fun=[httpprotocallfun]; miGameType=[" .. selfObj.miGameType .. "]")
--    local tCallFun = selfObj.miHttpProtoPacketCallFun[aiCmd]

--    if tCallFun ~= nil then
--        tCallFun(selfObj, buff)
--    else
--        My_Lua_log(" file=[fy] fun=[httpprotocallfun]; eCmd=[" .. aiCmd.. "]")
--    end
end

--需要更新玩家头像图标
function OnUpdateHeadImg(selfObj, aiUuid)
    My_Lua_log(" file=[fy] fun=[OnUpdateHeadImg]; aiUuid=["..aiUuid.."]")
    local aiEvent = {}
    aiEvent.type = PUBLIC_MSG_TYPE_ENUM.PUBLIC_MSG_TYPE_ENUM_UPDATE_HEAD_IMG_MSG
    aiEvent.miData = {}
    aiEvent.miData.uuid = aiUuid
    --selfObj.EventMgr.Instance():Dispatch(aiEvent)
    selfObj:SendEventToAllGameDesk(aiEvent)
end

--开始播放其他人有效
function OnAudioPlayerDidStartPlaying( selfObj, uuid, name, timer, aiGameRoomId )
    My_Lua_log(" file=[fy] fun=[onaudioplayerdidstartplaying]; ")
    --是离开
    local tGameRoomId = aiGameRoomId
    local tGameDesk = selfObj:GetGameDesk(tGameRoomId)
    if tGameDesk == nil then
        My_Lua_log(" file=[protocolcenter] fun=[OnAudioPlayerDidStartPlaying]; error no exist, lGameRoomId=" .. tGameRoomId)
        return
    end

    local tGameRoom = tGameDesk:GetGameRoom()
    local tEventMgr = tGameDesk:GetEventMgr()

    local tGameMute = G_Fy.GamegLobal:GetChattingMuteSetting()
    if tGameMute == 1 then
        return
    end

    local tUserGameInfoNet = tGameRoom:GetUserGameInfoNetFromUuid(uuid)
    if tUserGameInfoNet then
        --在位置上玩家语音
        local aiEvent = {}
        aiEvent.type = PUBLIC_MSG_TYPE_ENUM.PUBLIC_MSG_TYPE_ENUM_PLAYER_PLAY_AUDIO_MSG
        aiEvent.miData = {}
        aiEvent.miData.uuid = uuid
        aiEvent.miData.name = name
        aiEvent.miData.timer = timer
        --selfObj.EventMgr.Instance():Dispatch(aiEvent)
        tEventMgr:Dispatch(aiEvent)
    else
        --围观玩家语音
        local aiEvent = {}
        aiEvent.type = PUBLIC_MSG_TYPE_ENUM.PUBLIC_MSG_TYPE_ENUM_STAND_PLAYER_PLAY_AUDIO_MSG
        aiEvent.miData = {}
        aiEvent.miData.uuid = uuid
        aiEvent.miData.name = name
        aiEvent.miData.timer = timer
        --selfObj.EventMgr.Instance():Dispatch(aiEvent)
        tEventMgr:Dispatch(aiEvent)
    end
end

--取消播放其他人有效
function OnAudioPlayerCancelOperation( selfObj, uuid, aiGameRoomId )
    My_Lua_log(" file=[fy] fun=[onaudioplayercanceloperation]; ")

    local tGameRoomId = aiGameRoomId
    local tGameDesk = selfObj:GetGameDesk(tGameRoomId)
    if tGameDesk == nil then
    My_Lua_log(" file=[protocolcenter] fun=[OnAudioPlayerCancelOperation]; error no exist, lGameRoomId=" .. tGameRoomId)
    return
    end

    local tGameRoom = tGameDesk:GetGameRoom()
    local tEventMgr = tGameDesk:GetEventMgr()

    local aiEvent = {}
    aiEvent.type = PUBLIC_MSG_TYPE_ENUM.PUBLIC_MSG_TYPE_ENUM_PLAYER_PLAY_AUDIO_FINISH_MSG
    aiEvent.miData = {}
    --selfObj.EventMgr.Instance():Dispatch(aiEvent)
    tEventMgr:Dispatch(aiEvent)
end

--完成播放其他人有效
function OnAudioPlayerDidFinishPlaying( selfObj, uuid, aiGameRoomId)
    My_Lua_log(" file=[fy] fun=[onaudioplayerdidfinishplaying]; ")

    local tGameRoomId = aiGameRoomId
    local tGameDesk = selfObj:GetGameDesk(tGameRoomId)
    if tGameDesk == nil then
        My_Lua_log(" file=[protocolcenter] fun=[OnAudioPlayerCancelOperation]; error no exist, lGameRoomId=" .. tostring(tGameRoomId))
        return
    end

    local tGameRoom = tGameDesk:GetGameRoom()
    local tEventMgr = tGameDesk:GetEventMgr()

    local aiEvent = {}
    aiEvent.type = PUBLIC_MSG_TYPE_ENUM.PUBLIC_MSG_TYPE_ENUM_PLAYER_PLAY_AUDIO_FINISH_MSG
    aiEvent.miData = {}
    --selfObj.EventMgr.Instance():Dispatch(aiEvent)
    tEventMgr:Dispatch(aiEvent)
end

--设置sng请求买入通知
function OnSetSngControlBuyinMsgLuaHandler(selfObj, aiNum)
    My_Lua_log(" file=[fy] fun=[onsetsngcontrolbuyinmsgluahandler]; ")
    if selfObj.GamegLobal:GetIsOpenGmaeState() == false or selfObj.GamegLobal:GetIsEnterBackground() == true then
        return
    end
    My_Lua_log(" file=[fy] fun=[onsetsngcontrolbuyinmsgluahandler]; aiNum="..aiNum)
    --刷新数据
    local aiEventPag = {}
    aiEventPag.type = PUBLIC_MSG_TYPE_ENUM.PUBLIC_MSG_TYPE_ENUM_SNG_ALL_BUYIN_CONTROLS_INVITE_MSG
    aiEventPag.miData = {}
    selfObj:SendEventToAllGameDesk(aiEventPag)
end

--充电通知
function OnSetNotifyCharge(selfObj, aiIsCharge)
    My_Lua_log(" file=[fy] fun=[OnSetNotifyCharge]; ")
    
    local aiEventPag = {}
    aiEventPag.type = PUBLIC_MSG_TYPE_ENUM.PUBLIC_MSG_TYPE_ENUM_NOTIFY_PHONE_CHARGE_MSG
    aiEventPag.miData = {}
    aiEventPag.miData.miIsCharge = aiIsCharge
    selfObj:SendEventToAllGameDesk(aiEventPag)
end

--弹幕开关通知
function OnSetNotifyCommentOnOff(selfObj, aiGameRoomId, aiOnOff)
    My_Lua_log(" file=[fy] fun=[OnSetNotifyCommentOnOff]; [aiOnOff="..tostring(aiOnOff).."][aiGameRoomId="..aiGameRoomId.."]")
    
    --更新下本地数据
    selfObj.GamegLobal:SetBulletOnOffByGameRoomId(aiGameRoomId, aiOnOff)

    local aiEventPag = {}
    aiEventPag.type = PUBLIC_MSG_TYPE_ENUM.PUBLIC_MSG_TYPE_ENUM_NOTIFY_BULLET_ON_OFF_MSG
    aiEventPag.miData = {}
    aiEventPag.miData.miOnOff = aiOnOff
    selfObj:SendEventToAppointGameDesk(aiGameRoomId,aiEventPag)
end

function OnSetMiniGameSendFailedHandler(selfObj, aiCmdId)
    My_Lua_log(" file=[fy] fun=[onsetsngcontrolbuyinmsgluahandler]; id = "..aiCmdId)

    local aiEvent = {}       
    aiEvent.type = PUBLIC_MSG_TYPE_ENUM.PUBLIC_MSG_TYPE_ENUM_NOTIFY_HTTP_FAILED_MSG
    aiEvent.miData = {}
    aiEvent.miData.miCmdId = aiCmdId
    selfObj:GetFyEvent():Dispatch(aiEvent)

    -- if aiCmdId == 9000 or 
    --     aiCmdId == 9001 or
    --     aiCmdId == 9002 or
    --     aiCmdId == 9003 then
    --     My_Lua_log("file=[fy] fun=[onsetsngcontrolbuyinmsgluahandler] error=[网络错误]")
    --     --弹出 网络错误 提示
    --     local aiEventPag = {}       
    --     aiEventPag.type = MSG_TYPE_ENUM.MSG_TYPE_ENUM_POPUP_PAG
    --     aiEventPag.miPagName = "errorpag"
    --     aiEventPag.miData = {}
    --     aiEventPag.miData.miErrCode = tonumber(9005)
    --     --selfObj.EventMgr.Instance():Dispatch(aiEventPag)
    --     selfObj:SendEventToAllGameDesk(aiEventPag)

    --     local aiMiniGameEventPag = {}
    --     aiMiniGameEventPag.type = MSG_TYPE_ENUM.MSG_TYPE_ENUM_MINIGAME_SEND_FAIL
    --     aiMiniGameEventPag.miData = {}
    --     --selfObj.EventMgr.Instance():Dispatch(aiMiniGameEventPag)
    --     selfObj:SendEventToAllGameDesk(aiMiniGameEventPag)

    -- elseif aiCmdId == 9005 or aiCmdId == 9006 then
        
    --     --尝试10次loading 依然失败则退出
    --     if selfObj.miLoadTimes <= 10 then
    --         My_Lua_log("尝试10次loading 依然失败则退出  "..selfObj.miLoadTimes)
    --         --隐藏加载界面
    --         local aiEventPag = {}
    --         aiEventPag.type = PUBLIC_MSG_TYPE_ENUM.PUBLIC_MSG_TYPE_ENUM_SHOW_LOADING_PAG
    --         aiEventPag.miPagName = "lodingpag"
    --         aiEventPag.miData = {}
    --         aiEventPag.miData.miIsShow = true
    --         --selfObj.EventMgr.Instance():Dispatch(aiEventPag)
    --         selfObj:SendEventToAllGameDesk(aiEventPag)

    --         --发送协议  初始化小游戏
    --         local aiEvent = {}
    --         aiEvent.type = MSG_TYPE_ENUM.MSG_TYPE_ENUM_MINIGAME_SEND_INIT
    --         aiEvent.miData = {}
    --         selfObj:SendEventToAllGameDesk(aiEvent)
        
    --         selfObj.miLoadTimes = selfObj.miLoadTimes + 1
    --     else
    --         function StopFunc()
    --             --切换到IOS界面
    --             if selfObj.miGameType == GAME_TYPE_ENUM.GAME_TYPE_MINI then
    --                 selfObj.miNetMgr:StopGame(1)
    --             end

    --             local aiEvent = {}
    --             aiEvent.type = SYSTEM_MSG_TYPE_ENUM.SYSTEM_MSG_TYPE_ENUM_SCENE_EXIST_COCOS2DX
    --             aiEvent.miData = {}
    --             aiEvent.miData.miType = 0
    --             aiEvent.miData.miRoomName = ""
    --             selfObj:GetFyEvent():NextDispatch(aiEvent)
    --         end
    --     end 
    -- end
end

--通知刷新牌手卡
function OnSetUpdateFriendUserDataHandler(selfObj, aiUuid)
My_Lua_log(" file=[fy] fun=[OnSetUpdateFriendUserDataHandler]; ")
--[[
    local aiEventPag = {}
    aiEventPag.type = MSG_TYPE_ENUM.MSG_TYPE_ENUM_NOTYFY_UPDATE_INFOPAG_MSG
    aiEventPag.miData = {}
    aiEventPag.miData.uuid = aiUuid
    --selfObj.EventMgr.Instance():NextDispatch(aiEventPag)
    selfObj:SendEventToAllGameDesk(aiEventPag)
--]]
My_Lua_log(" file=[fy] fun=[OnSetUpdateFriendUserDataHandler]; aiUuid="..aiUuid)
    local aiEventPag = {}
    aiEventPag.type = PUBLIC_MSG_TYPE_ENUM.PUBLIC_MSG_TYPE_ENUM_NOTYFY_UPDATE_LOCALUSERINFOLIST_MSG
    aiEventPag.miData = {}
    aiEventPag.miData.miUuid = aiUuid
    selfObj:SendEventToAllGameDesk(aiEventPag)

end




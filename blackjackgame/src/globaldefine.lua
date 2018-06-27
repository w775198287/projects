
--安卓宽高比误差范围
ANDROID_ASPECT_RATIO_ERROR_RANGE = 0.03

--设计分辨率列表
DesignResolutionSizeList={
    iphone6s = {
        width = 1242,
        height = 2208,
    },
    iphone4 = {
        width = 1472,
        height = 2208,
    },
    ipad = {
        width = 1688,
        height = 2208,
    },
    sumsang_s8 = {
        width = 1242,
        height = 2553,
    },
}

--不同手机下上下间隔距离
PHONE_TOP_BOTTOM_SPACE_LIST = {
    iphone6s = {
        top_space = 0,
        bottom_space = 0,
    },
    iphone4 = {
        top_space = 0,
        bottom_space = 0,
    },
    ipad = {
        top_space = 0,
        bottom_space = 0,
    },
    iphonex = {
        top_space = 132,
        bottom_space = 102,
    },
    sumsang_s8 = {
        top_space = 0,
        bottom_space = 0,
    },
}
--手机方向约束
PHONE_DIRECTION_CONSTRAINT = {
    UP = 1,
    LEFT = 2,
    RIGHT = 3,
    DOWN = 4,
 }

--几种设计分辨率名称
DESIGNSIZE_PHONE_NAME = {
IPAD = "ipad",
IPHONE_4 = "iphone4",
IPHONE_6S = "iphone6s",
SUMSUNG_S8 = "sumsang_s8",
}

--手机真实分辨率列表
RealResolutionSizeList = {
    --iphoen4s 5 5c 5s
    iphone4 = {
        width = 640,
        height = 960,
    },
    iphonex = {
        width = 1125,
        height = 2436,
    },
    
    --三星三种可以切换的分辨率
    sumsang_s8 = {
        LOW = {width = 720, height = 1480},
        MIDDLE = {width = 1080, height = 2220},
        HIGH = {width = 1440, height = 2960},
    },
}

--系统语言版本
G_GCurrentLanguage = 1
LANGUAGE_TYPE={
  G_LANGUAGE_CHINESE_CN = 1, --简体中文
  G_LANGUAGE_ENGLISH = 2, --英文
  G_LANGUAGE_CHINESE_CNS = 3, --繁体中文
  G_LANGUAGE_JAPANESE = 4, --日文
}
--主题风格
THEMESTYLE={
  THEMESTYLE_ORIGINALIMAGE = 1, --经典蓝
  THEMESTYLE_GRINDBLACK = 2, --磨砂黑
  THEMESTYLE_BLUE = 3, --王祖蓝
  THEMESTYLE_GREEN = 4, --绿色
}

--安卓缩放比例
G_Android_Scale_Ratio = 2
local app = cc.Application:getInstance()
local target = app:getTargetPlatform() 
--android
if target == 3 then
    G_Android_Scale_Ratio = 2
else
    G_Android_Scale_Ratio = 2 --1
end

--游戏类型
GAME_TYPE_ENUM ={
    GAME_TYPE_TEXAS = 1,--德州扑克
	GAME_TYPE_MINI = 10, --小游戏局牌局游戏
    GAME_TYPE_ALLINODDS = 20, --allin胜率计算器
    GAME_TYPE_POFC = 30, --大菠萝
}
--头像图片的偏移
HEAD_IMAGE_OFF = 8

--手牌张数
GAME_HEAD_NUM = 2
GAME_OMAHA_HEAD_NUM = 4

--分享类型
SNG_SHARE_TYPE=1
BRAND_SHARE_TYPE=2

--自定义快捷加注
RAISE_OPTION_NIL = -1
RAISE_OPTION_ALLIN = -999

MSG_TYPE_ENUM = {

    MSG_TYPE_ENUM_SCENE_POPUP_PAG = 50001,
    MSG_TYPE_ENUM_SCENE_CLOSE_PAG = 50002,
    MSG_TYPE_ENUM_POPUP_PAG = 50003,
    MSG_TYPE_ENUM_CLOSE_PAG = 50004,
}

--系统通知消息
SYSTEM_MSG_TYPE_ENUM = {
    SYSTEM_MSG_TYPE_ENUM_NOTIFY_ADD_DESK_MSG= 1,
    SYSTEM_MSG_TYPE_ENUM_NOTIFY_DEL_DESK_MSG= 2,
    SYSTEM_MSG_TYPE_ENUM_NOTIFY_OPEN_DESK_MSG= 3,
    SYSTEM_MSG_TYPE_ENUM_NOTIFY_DESK_SCALE_MSG = 4,--缩放

    SYSTEM_MSG_TYPE_ENUM_SCENE_POPUP_FRAMEWORK_PAG = 5, --进入牌桌
    --MSG_TYPE_ENUM_SCENE_POPUP_EXIST_PAG = 6, --退出牌桌
    SYSTEM_MSG_TYPE_ENUM_SCENE_EXIST_COCOS2DX = 7, --退出cocos2dx
    SYSTEM_MSG_TYPE_ENUM_SCENE_POPUP_FRAMEWORK_ZORDER_MSG = 8, --改变FRAMEWORK ZOrder


    SYSTEM_MSG_TYPE_ENUM_NOTIFY_APPLICATIONDIDENTERBACKGROUND_MSG = 9, --切后台
    SYSTEM_MSG_TYPE_ENUM_NOTIFY_APPLICATIONDIDENTERFOREGROUND_MSG = 10, --切前台

    SYSTEM_MSG_TYPE_ENUM_PROTO_DISTRIBUTE = 11, --分发协议
    -- GAME_TYPE_TEXAS = 100000,--德州扑克
    -- GAME_TYPE_MINI = 200000, --小游戏局牌局游戏
    -- GAME_TYPE_ALLINODDS = 300000, --allin胜率计算器
}


--公共事件（2000索引开头）
PUBLIC_MSG_TYPE_ENUM = {
    PUBLIC_MSG_TYPE_ENUM_SELF_FREE_FACE_MSG = 2001, --自己免费表情
    PUBLIC_MSG_TYPE_ENUM_TRANSITION_VISIBLE_MSG = 2002, --显示隐藏过渡图片
    PUBLIC_MSG_TYPE_ENUM_UPDATE_SINGNAL_VALUE_MSG = 2003, --刷新信号
    PUBLIC_MSG_TYPE_ENUM_SHOW_LOADING_PAG = 2004, --显示隐藏loading界面
    PUBLIC_MSG_TYPE_ENUM_PLAYER_RESET_UI_MSG = 2005, --重置UI
    PUBLIC_MSG_TYPE_ENUM_SNG_ALL_BUYIN_CONTROLS_INVITE_MSG = 2006, --通知sng控制买入界面刷新
    PUBLIC_MSG_TYPE_ENUM_START_SYSTEM_NOTIFY_PAG_MSG = 2007, --启动系统通知UI
    PUBLIC_MSG_TYPE_ENUM_PLAYER_PLAY_AUDIO_FINISH_MSG = 2008, --播放完成语音
    PUBLIC_MSG_TYPE_ENUM_NOTIFY_CLEAR_BULLET_DATA_MSG = 2009, --通知清空弹幕数据
    PUBLIC_MSG_TYPE_ENUM_UPDATE_REMARKS_STR_MSG = 2010, --获取备注
    PUBLIC_MSG_TYPE_ENUM_NOTIFY_REFRESH_COIN = 2011,  --刷新金币（目前主要用于小游戏商城返回小游戏金币刷新）
    PUBLIC_MSG_TYPE_ENUM_NOTYFY_UPDATE_LOCALUSERINFOLIST_MSG = 2012, --更新本地用户基础数据
    PUBLIC_MSG_TYPE_ENUM_UPDATE_HEAD_IMG_MSG = 2013, --通知刷新头像
    PUBLIC_MSG_TYPE_ENUM_PLAYER_PLAY_AUDIO_MSG = 2014, --桌上玩家语音
    PUBLIC_MSG_TYPE_ENUM_STAND_PLAYER_PLAY_AUDIO_MSG = 2015, --旁观玩家语音
    PUBLIC_MSG_TYPE_ENUM_NOTIFY_PHONE_CHARGE_MSG = 2016, --通知手机是否充电
    PUBLIC_MSG_TYPE_ENUM_NOTIFY_BULLET_ON_OFF_MSG = 2017, --通知弹幕层开关
    PUBLIC_MSG_TYPE_ENUM_NOTIFY_HTTP_FAILED_MSG = 2018, --通知小游戏http链接失败
    PUBLIC_MSG_TYPE_ENUM_NOTIFY_OPEN_BUY_PAG_MSG = 2019, --通知打开买入界面
}

-- require "texaspoker.texadefine"
-- require "pofcpoker.pofcglobaldefine"
-- --通知消息（100000索引开头）
-- MSG_TYPE_ENUM ={
--     MSG_TYPE_ENUM_SCENE_POPUP_PAG = 100001, --弹出场景界面
--     MSG_TYPE_ENUM_SCENE_CLOSE_PAG = 100002, --关闭场景界面
-- 	MSG_TYPE_ENUM_POPUP_PAG = 100003, --弹出界面
--     MSG_TYPE_ENUM_CLOSE_PAG = 100004, --关闭界面
--     MSG_TYPE_ENUM_CLOSE_EXIT_ALL_PAG = 100005, --关闭退出所有UI
--     MSG_TYPE_ENUM_POPUP_ERROR_PAG = 100006, --弹出错误界面
--     --MSG_TYPE_ENUM_SHOW_LOADING_PAG = 100007, --显示隐藏loading界面

--     -- MSG_TYPE_ENUM_SCENE_POPUP_FRAMEWORK_PAG = 100008, --进入牌桌
--     -- MSG_TYPE_ENUM_SCENE_POPUP_EXIST_PAG = 100009, --退出牌桌
--     -- MSG_TYPE_ENUM_SCENE_EXIST_COCOS2DX = 100010, --退出cocos2dx
--     -- MSG_TYPE_ENUM_SCENE_POPUP_FRAMEWORK_ZORDER_MSG = 100011, --改变FRAMEWORK ZOrder

--     MSG_TYPE_ENUM_ENTER_GAME_ROOM = 100012, --进入游戏房间
--     MSG_TYPE_ENUM_SIT_DOWN = 100013, --坐下
--     MSG_TYPE_ENUM_BUY_BUY_IN = 100014, --买入
--     MSG_TYPE_ENUM_SELFOBJ_BUY_BUY_IN = 100015, --自己买入
--     MSG_TYPE_ENUM_UPDAT_USER_STATE = 100016, --刷新位置用户上状态
--     --MSG_TYPE_ENUM_UPDAT_POS_FLY_EFFECT = 100017, --坐位飞行效果
--     MSG_TYPE_ENUM_CHANGE_SELF_ACTOR_STATE_IMAGE = 100018, --自己操作状态
--     MSG_TYPE_ENUM_SYSTEM_GAME_ROOM_MSG = 100019, --自己操作状态
--     MSG_TYPE_ENUM_UPDATE_POOL = 100020, --更新底池界面
--     MSG_TYPE_ENUM_CHANGE_SOUND_STATE = 100021, --更新语音声音开关
--     MSG_TYPE_ENUM_CHANGE_CONTINUE = 100022, --购买延时控件显示
--     MSG_TYPE_ENUM_SHOW_CARD_RSP_MSG = 100023, --亮牌协议通知
--     MSG_TYPE_ENUM_FREE_FACE_MSG = 100024, --免费表情
--     --MSG_TYPE_ENUM_SELF_FREE_FACE_MSG = 100025, --自己免费表情
--     MSG_TYPE_ENUM_SELF_ITEM_FACE_MSG = 100026, --道具表情
--     MSG_TYPE_ENUM_ROOM_GAME_STATE_SHOWCARD_RESET_UI_MSG = 100027, --showcar状态重置UI
--     --MSG_TYPE_ENUM_STAND_PLAYER_PLAY_AUDIO_MSG = 100028, --旁观玩家语音
--     --MSG_TYPE_ENUM_PLAYER_PLAY_AUDIO_MSG = 100029, --桌上玩家语音
--     --MSG_TYPE_ENUM_PLAYER_PLAY_AUDIO_FINISH_MSG = 100030, --播放完成语音

--     --MSG_TYPE_ENUM_PLAYER_RESET_UI_MSG = 100031, --重置UI

--     MSG_TYPE_ENUM_VISIBLE_FACE_BUTTON_MSG = 100032, --刷新表情ui显示

--     MSG_TYPE_ENUM_UPDATE_WAIT_PAG_PAUSE_PAG_MSG = 100033, --刷新暂停等待买入界面

--     MSG_TYPE_ENUM_ROOM_GAME_STATE_GAMESTART = 100034, --房间状态改变（开始）
--     MSG_TYPE_ENUM_FLOP_POKER_FLY = 100035,  --FLOP翻牌动画
--     MSG_TYPE_ENUM_TURN_POKER_FLY = 100036,  --TURN翻牌动画
--     MSG_TYPE_ENUM_RIVER_POKER_FLY = 100037,  --RIVER翻牌动画
--     MSG_TYPE_ENUM_PLAGER_PAG_CHIP_FLY = 100038,  --玩家家筹码飞行动画
--     MSG_TYPE_ENUM_RECYCLE_CHIP_FLY = 100039,  --收筹码
--     MSG_TYPE_ENUM_ALLOCATION_CHIP_FLY = 100040,  --收筹码
--     MSG_TYPE_ENUM_CLEAR_AUTOMATIC_TYPE = 100041,  --房间状态改变需要清除默认操作
--     MSG_TYPE_ENUM_RECYCLE_ANTE_CHIP_FLY = 100042,  --收ante动画


--     MSG_TYPE_ENUM_SHOW_HIDE_PART_PAG = 100043, --自己操作时需要隐藏显示界
--     MSG_TYPE_ENUM_UPDATE_BILL_USER_BASE_INFO_PAG = 100044, --自己操作时需要隐藏显示界

--     MSG_TYPE_ENUM_UPDATE_FRIEND_FACE_ITEM_PAG = 100045, --收费表情道具刷新
--     MSG_TYPE_ENUM_UPDATE_OTHERINFO_DATA_MSG = 100046, --刷新别人信息界面的备注

--     --MSG_TYPE_ENUM_UPDATE_SINGNAL_VALUE_MSG = 100047, --刷新信号



--     MSG_TYPE_ENUM_UPDATE_BUYIN_CONTROL_ENABLE_MSG = 100048, --房主开启买入控制模式
--     MSG_TYPE_ENUM_UPDATE_BUYIN_CONTROL_DISABLE_MSG = 100049, --房主关闭买入控制模式

--     MSG_TYPE_ENUM_ALL_BUYIN_CONTROLS_INVITE_MSG = 100050, --所有买入请求列表
--     MSG_TYPE_ENUM_BUYIN_CONTROLS_INVITE_MSG = 100051, --买入请求
--     MSG_TYPE_ENUM_CLOSE_BUYIN_CONTROLS_INVITE_MSG = 100052, --关闭相关房间买入请求
--     MSG_TYPE_ENUM_REMOVE_ALL_BUYIN_CONTROLS_INVITE_MSG = 100053, --移除买入请求列表


--     MSG_TYPE_ENUM_VISIBLE_WAITTING_PAG_MSG = 100054, --显示隐藏等待界面

--     MSG_TYPE_ENUM_PAUSE_UPDATE_PAG_MSG = 100055, --暂停UI更新事件

--     MSG_TYPE_ENUM_UPDATE_LAST_POKER_HANDRESULT_MSG = 100056, --刷新上局回顾数据

--     MSG_TYPE_ENUM_ALL_ALLIN_MSG = 100057, --全部allin

--     MSG_TYPE_ENUM_SHOW_CARD_RESETUI_MSG = 100058, --显示牌阶段清空

--     MSG_TYPE_ENUM_STAND_UP_MSG = 100059, --自己站起

--     MSG_TYPE_ENUM_UPDATE_REALTIMESITUATIONMAIN_DATA_PAG = 100060, --刷新实时战况数据

--     MSG_TYPE_ENUM_COLLECTION_SUCCESS_PAG = 100061, --收藏成功

--     MSG_TYPE_ENUM_UPDATE_BUYIN_CONTROL_STATE_PAG = 100062, --刷新带入上限调整

--     --MSG_TYPE_ENUM_START_SYSTEM_NOTIFY_PAG_MSG = 100063, --启动系统通知UI
--     MSG_TYPE_ENUM_ADD_SYSTEM_MSG_PAG = 100064, --添加新系统通知

--     MSG_TYPE_ENUM_SET_MAINMENU_ZORDER_MSG = 100065, --改变mainmenupag ZOrder

--     MSG_TYPE_ENUM_DELAY_ITEM_UPDATE_MSG = 100066, --延时道具刷新
--     --MSG_TYPE_ENUM_UPDATE_HEAD_IMG_MSG = 100067, --通知刷新头像

--     MSG_TYPE_ENUM_BLINDRAISE_MSG = 100068, --升盲提示

--     MSG_TYPE_ENUM_UPDATE_SIGNUPNODE_MSG = 100069, --刷新等待人数UpdateSignupnode

--     MSG_TYPE_ENUM_UPDATE_UPDATE_CURRENT_TIME_RANKING_MSG = 100070, --刷新实时排名

--     MSG_TYPE_ENUM_RECONNECT_EMPTY_DATA_MSG = 100071, --重连时候需要清空数据

--     --MSG_TYPE_ENUM_SNG_ALL_BUYIN_CONTROLS_INVITE_MSG = 100072, --通知sng控制买入界面刷新

--     MSG_LOG_MSG = 100073,

--     MSG_TYPE_ENUM_INSURANCE_DELAY_ITEM_UPDATE_MSG = 100074, --保险购买延时成功
--     MSG_TYPE_ENUM_INSURANCE_OFF_ON_UPDATE_MSG = 100075, --用户设置购买保险权限
--     MSG_TYPE_ENUM_INSURANCE_BUYIN_TIPS_MSG = 100076,  --开始购买保险提示

--     MSG_TYPE_ENUM_INSURANCE_UPDATE_BUYIN_DATA_MSG = 100077,  --保险购买窗口打开情况下刷新保险购买数据

--     MSG_TYPE_ENUM_INSURANCE_CLOSE_PAG = 100078, --买保险操作时需要关闭界面

--     MSG_TYPE_ENUM_INSURANCE_NOTIFY_BUYINNUM_PAG = 100079, --通知购买保险按钮，买入变化
--     MSG_TYPE_ENUM_INSURANCE_NOTIFY_NOLOSS_MAXBUY_VALUE_CHANGE_PAG = 100080, --通知保本按钮，满池按钮 数值变化
--     MSG_TYPE_ENUM_INSURANCE_NOTIFY_NOLOSS_MAXBUY_STATE_PAG = 100081, --通知保本按钮，满池按钮 显示，隐藏，文本改变

--     --MSG_TYPE_ENUM_UPDATE_REMARKS_STR_MSG = 100082, --获取备注

--     MSG_TYPE_ENUM_DELAY_OPEN_IME_MSG = 100083, --延时打开输入法
--     MSG_TYPE_ENUM_NOTIFY_CLOSE_INPUT_MSG = 100084, --通知个人信息界面，输入界面关闭
    
--     MSG_TYPE_ENUM_GET_INPUT_LOCAL_TEXT_MSG = 100085, --输入界面关闭时，给个人信息界面发送临时数据

--     MSG_TYPE_ENUM_UPDATE_POKER_HANDRESULT_BY_HAND_MSG = 100086, --刷新全局回顾信息

--     MSG_TYPE_ENUM_REMOVE_COLLECTION_SUCCESS_PAG = 100087, --取消收藏

--     MSG_TYPE_ENUM_UPDATE_SHOW_CARD_DATA = 100088, --刷新看牌数据

--     MSG_TYPE_ENUM_UPDATE_HANDRESULT_FROMBACKROUND_MSG = 100089, --从后台切回来后刷新数据

--     --MSG_TYPE_ENUM_TRANSITION_VISIBLE_MSG = 100090, --显示隐藏过渡图片

--     MSG_TYPE_ENUM_CLOSE_ALL_HIDDEN_PAG_MSG = 100091, --关闭之前隐藏的弹窗

--     MSG_TYPE_ENUM_NOTYFY_MICROPHONE_CHANGEIMAGE_MSG = 100092, --通知录音改变图片显示状态
--     MSG_TYPE_ENUM_NOTYFY_MICROPHONE_UPDATETIMETEXT_MSG = 100093, --通知录音改变时间text显示

--     MSG_TYPE_ENUM_NOTYFY_CLUB_BUYIN_MSG = 100094, --通知刷新俱乐部买入

--     MSG_TYPE_ENUM_NOTYFY_UPDATE_INFOPAG_MSG = 100095, --通知刷新个人信息卡

--     MSG_TYPE_ENUM_NOTYFY_PLAY_OTHER_AUDIO_MSG = 100096, --播放其他玩家check,fold音效

--     MSG_TYPE_ENUM_NOTYFY_STRADDLETEXT_VISIBLE_MSG = 100097, --更新straddle文本是否显示

--     MSG_TYPE_ENUM_NOTYFY_SHOPBUTTON_ABLE_MSG = 100098, --更新商城按钮可点击

--     MSG_TYPE_ENUM_NOTYFY_SHOW_VOICESTATE_MSG = 100099, --更新个人头像显示静音状态

--     MSG_TYPE_ENUM_NOTYFY_TURNLOOKBUTTON_VISIBLE_MSG = 100100, --更新是否显示翻翻看按钮
--     MSG_TYPE_ENUM_NOTYFY_UPDATE_TURNLOOKBUTTON_TITLE_MSG = 100101, --更新翻翻看按钮文字
--     MSG_TYPE_ENUM_NOTYFY_TURNLOOKCARDNODE_VISIBLE_MSG = 100102, --更新是否显示翻翻看牌
--     MSG_TYPE_ENUM_NOTYFY_TURNLOOKCARDNODE_INITDATA_MSG = 100103, --翻翻看
--     MSG_TYPE_ENUM_NOTYFY_TURNLOOKCARD_UPDATE_MSG = 100104, --刷新翻翻看牌
--     MSG_TYPE_ENUM_NOTYFY_TURNLOOKCARD_HIDE_MSG = 100105, --隐藏翻翻看牌

--     MSG_TYPE_ENUM_NOTYFY_UPDATE_PREACTION_MSG = 100106, --预动作刷新

--     MSG_TYPE_ENUM_NOTYFY_CHANGE_FOUR_COLOR_MSG = 100107, --替换四色牌

--     --MSG_TYPE_ENUM_NOTYFY_UPDATE_LOCALUSERINFOLIST_MSG = 100108, --更新本地用户基础数据

--     MSG_TYPE_ENUM_NOTYFY_UPDATE_POKER_TEXT_INFO_MSG = 100109, --更新文字牌谱

--     MSG_TYPE_ENUM_NOTYFY_SETTING_GAMEMUTE_OFF_ON_MSG = 100110, --刷新牌局静音开关
--     MSG_TYPE_ENUM_NOTYFY_SETTING_CHATMUTE_OFF_ON_MSG = 100111, --刷新聊天静音开关
--     MSG_TYPE_ENUM_NOTYFY_SETTING_RAISEASSISTANT_OFF_ON_MSG = 100112, --刷新拉杆确认开关
--     MSG_TYPE_ENUM_NOTYFY_SETTING_FOURCOLOR_CARD_OFF_ON_MSG = 100113, --刷新四色牌开关
--     MSG_TYPE_ENUM_NOTYFY_SETTING_RAISESHORTCUTS_MSG = 100114, --刷新自定义加注按钮
--     MSG_TYPE_ENUM_NOTIFY_SETTING_GAMETHEME_MSG = 100115, --刷新桌面主题

--     MSG_TYPE_ENUM_NOTYFY_UPDATE_PLAYER_ALLOW_BUYIN_MSG = 100116, --刷新允许买入后的筹码

--     --MSG_TYPE_ENUM_NOTIFY_PHONE_CHARGE_MSG = 100117, --通知手机是否充电
--     --mtt
--     MSG_TYPE_ENUM_NOTYFY_MTT_START_MSG = 100118, --mtt比赛开始

--     MSG_TYPE_ENUM_NOTYFY_MTT_DESK_DATA_MSG = 100119, --更新mtt桌面数据

--     MSG_TYPE_ENUM_NOTYFY_MTT_READY_START_MSG = 100120, --mtt比赛即将开始push

--     MSG_TYPE_ENUM_NOTIFY_MTT_UPDATE_USERINFOS_RANK_MSG = 100121, --通知刷新mtt玩家列表

--     MSG_TYPE_ENUM_NOTIFY_MTT_UPDATE_DESK_POS_MSG = 100122, --切桌通知刷新位置

--     MSG_TYPE_ENUM_NOTIFY_MTT_BLIND_UP_MSG = 100123, --通知盲注上升

--     MSG_TYPE_ENUM_NOTIFY_MTT_AUTO_REENTRY_MSG = 100124, --通知刷新自动重进
--     MSG_TYPE_ENUM_NOTIFY_MTT_UPDATE_REALTIME_MATCH_MSG = 100125, --通知刷新实时战绩 赛况
--     MSG_TYPE_ENUM_NOTIFY_MTT_UPDATE_REALTIME_DESK_MSG = 100126, --通知刷新实时战绩 牌桌
--     MSG_TYPE_ENUM_NOTIFY_MTT_UPDATE_REALTIME_BONUS_MSG = 100127, --通知刷新实时战绩 奖励
--     MSG_TYPE_ENUM_NOTIFY_MTT_UPDATE_REALTIME_BLIND_MSG = 100128, --通知刷新实时战绩 盲注

--     MSG_TYPE_ENUM_NOTIFY_MTT_UPDATE_BULLET_BUTTON_MSG = 100129, --MTT不同牌桌间切换，--刷新弹幕表情按钮

--     MSG_TYPE_ENUM_START_SYSTEM_BULLET_SCREEN_PAG_MSG = 100130, --启动弹幕
--     MSG_TYPE_ENUM_ADD_BULLET_DATA_MSG = 100131, --更新弹幕数据
--     --MSG_TYPE_ENUM_NOTIFY_BULLET_ON_OFF_MSG = 100132, --通知弹幕层开关
--     --MSG_TYPE_ENUM_NOTIFY_CLEAR_BULLET_DATA_MSG = 100133, --通知清空弹幕数据

--     MSG_TYPE_ENUM_NOTIFY_CLUB_ROLE_CHANGE_MSG = 100134, --通知俱乐部身份升降

--     MSG_TYPE_ENUM_NOTIFY_CLOSE_COMMENT_MSG = 100135, --通知关闭弹幕窗口


--     --MSG_TYPE_ENUM_NOTIFY_APPLICATIONDIDENTERBACKGROUND_MSG = 100136, --切后台
--     --MSG_TYPE_ENUM_NOTIFY_APPLICATIONDIDENTERFOREGROUND_MSG = 100137, --切前台

--     --MSG_TYPE_ENUM_NOTIFY_REFRESH_COIN = 100138,  --刷新金币（目前主要用于小游戏商城返回小游戏金币刷新）
--     MSG_TYPE_ENUM_MINIGAME_SEND_FAIL = 100139, --小游戏http发送失败
--     MSG_TYPE_ENUM_MINIGAME_SEND_INIT = 100140,  --小游戏断线10s请求
--     MSG_TYPE_ENUM_MINIGAME_TIMEOUT = 100141,  --小游戏连接超时
--     MSG_TYPE_ENUM_MINIGAME_TCP_DISCONNECT = 100142,   --小游戏tcp断开
--     MSG_TYPE_ENUM_MINIGAME_TCP_CONNECTAGAIN = 100143,     --小游戏tcp重连
--     MSG_TYPE_ENUM_SCENE_POPUP_MINIGAME_PAG = 100144, --小游戏id





--     --MSG_TYPE_ENUM_PROTO_DISTRIBUTE = 100145, --分发协议
--   }


--扑克类型
CT_SINGLE=1									--单牌类型
CT_ONE_LONG=2									--对子类型
CT_TWO_LONG=3									--两对类型
CT_THREE_TIAO=4								--三条类型
CT_SHUN_ZI=5									--顺子类型
CT_TONG_HUA=6									--同花类型
CT_HU_LU=7									--葫芦类型
CT_TIE_ZHI=8									--铁支类型
CT_TONG_HUA_SHUN=9							--同花顺型
CT_KING_TONG_HUA_SHUN=10						--皇家同花顺


GAME_NUMBER_FONT_NAME = "font/Gotham-Book.otf"

SOUND_FILE_KEY={
   SOUND_FILE_KEY_CARD_TURNING = "audio/card_turning.wav", --  翻牌
   SOUND_FILE_KEY_CHIPS_TO_POT = "audio/chips_to_table.wav", --手上筹码飞到桌面 （赢后获得筹码）
   SOUND_FILE_KEY_CHIPS_TO_TABLE = "audio/chips_to_pot.wav", --  桌面筹码飞到池子
   SOUND_FILE_KEY_PCHECK = "audio/pcheck.wav", --  看牌
   SOUND_FILE_KEY_PFOLD = "audio/pfold.wav", --  放弃
   SOUND_FILE_KEY_PTURN = "audio/pturn.wav", --  本人操作
   SOUND_FILE_KEY_SLIDER_TOP = "audio/slider_top.wav", --自由加注到100%
   SOUND_FILE_KEY_SLIDER = "audio/slider.wav", --   自由加注推杆改变
   SOUND_FILE_KEY_TIMEOUT = "audio/timeout.wav", --  剩下最后7秒操作时间
}

POFC_SOUND_FILE_KEY={
    POFC_SOUND_FILE_KEY_CARD_BROKEN = "audio/pofcpoker/bust.mp3", --爆牌
    POFC_SOUND_FILE_KEY_FANTASY = "audio/pofcpoker/fantasy.mp3", --范特西
    POFC_SOUND_FILE_KEY_FLIP_CARD = "audio/pofcpoker/card_turning.wav", --翻牌
    POFC_SOUND_FILE_KEY_DEAL_CARD= "audio/pofcpoker/pul.wav", --发牌
    POFC_SOUND_FILE_KEY_TIMEOUT = "audio/timeout.wav", --  剩下最后7秒操作时间
}

LOCAL_STARTED_WAITTING_TYPE = 1 --等待开始
LOCAL_CONTROL_ENABLE_WAITTING_TYPE = 2 --等待买入控制


function search (k, plist)
    for i=1, table.getn(plist) do
       local v = plist[i][k]    -- try 'i'-th superclass
		if v then 
			return v 
		end
    end
end

  ----------------------------



function roundOff(num, n)
    if n > 0 then
        local scale = math.pow(10, n-1)
        return math.floor(num/scale + 0.5) * scale
    elseif  n < 0 then
        local scale = math.pow(10, n)
        return math.floor(num/scale + 0.5) * scale
    elseif  n == 0 then
        return num
    end
end

  ----------------------------
function Global_ConversionNumToStr(aiCoin)
    --My_Lua_log(" file=[globaldefine] fun=[conversionnumtostr]; ")
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
        local tbegin, tEnd = string.find(tStrK, '%.', 1)
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
function Global_RoundedNumber(aiNumber)
    local tX, tY = math.modf(aiNumber)
    if tY - 0.5 >= 0.000001 then
        tX = tX + 1
    end
    return tX
end


------
--格式化7位数以上函数
function Global_ConversionNumToStrEx(aiCoin)
    --My_Lua_log(" file=[globaldefine] fun=[Global_ConversionNumToStrEx]; ")
    local tReturnStr = "0"
    if aiCoin > 999999999 then
        local tModX = math.mod(aiCoin, 1000000000)
        local tStr = tostring(aiCoin/1000000000.0)
        if tModX == 0 then
            tReturnStr = tStr.."B"
        else            
            local X, Y = math.modf(tonumber(tStr))
            Y = math.floor(Y * 1000)
            tReturnStr = X + tonumber(roundOff(Y, 2))/1000
            tReturnStr = tReturnStr.."B"
        end
    elseif aiCoin > 999999 then
        local tModX = math.mod(aiCoin, 1000000)
        local tStr = tostring(aiCoin/1000000.0)
        if tModX == 0 then
            tReturnStr = tStr.."M"
        else            
            local X, Y = math.modf(tonumber(tStr))
            Y = math.floor(Y * 1000)
            tReturnStr = X + tonumber(roundOff(Y, 2))/1000
            tReturnStr = tReturnStr.."M"
        end
    else
        tReturnStr = tostring(aiCoin)
    end
    return tReturnStr
end

--通知消息
CARD_COLOR_ENUM ={
    SQUARE = 1,--方块
    CLUB = 2,--梅花
    RED = 3,--红桃
    BLACK = 4, --黑桃
    NONE = 5, --未知颜色
}

--通过牌获得（数字，大小，花色）
function GetCardInfo(aiCard)
    if aiCard < 0 and aiCard > 51 then
        return nil
    end

    local tCardInfo={}
    tCardInfo.miCard = aiCard
    tCardInfo.miCardId = 0
    tCardInfo.miCardColor = CARD_COLOR_ENUM.NONE

    tCardInfo.miCardId = math.mod(aiCard, 13)
    if tCardInfo.miCardId == 0 then
        tCardInfo.miCardId = 14
    else
        tCardInfo.miCardId = tCardInfo.miCardId + 1
    end

    tCardInfo.miCardColor = math.floor(aiCard/13)
    if tCardInfo.miCardColor == 0 then
        tCardInfo.miCardColor = CARD_COLOR_ENUM.BLACK
    elseif tCardInfo.miCardColor == 1 then
        tCardInfo.miCardColor = CARD_COLOR_ENUM.RED
    elseif tCardInfo.miCardColor == 2 then
        tCardInfo.miCardColor = CARD_COLOR_ENUM.CLUB
    elseif tCardInfo.miCardColor == 3 then
        tCardInfo.miCardColor = CARD_COLOR_ENUM.SQUARE
    end
    return tCardInfo
end

function SortCard(aiCardInfoList)
    function cardsort(a,b)
        if a.miCardId == b.miCardId then
            if a.miCardColor > b.miCardColor then
                return true
            end
            return false
        end

        return a.miCardId > b.miCardId
    end
    table.sort(aiCardInfoList, cardsort)
end
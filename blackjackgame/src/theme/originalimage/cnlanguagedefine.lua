--G_LANGUAGE_CHINESE_CN --简体中文

module(...,package.seeall)

USER_STATE_IMAGE = {
  USER_STATE_IMAGE_FOLD = "game/game_layer/common/ic_action_gray.png",--弃牌
  USER_STATE_IMAGE_CHECK = "game/game_layer/common/ic_action_green.png",--看牌
  USER_STATE_IMAGE_CALL = "game/game_layer/common/ic_action_blue.png",--跟注
  USER_STATE_IMAGE_RAISE = "game/game_layer/common/ic_action_red.png",--加注
  USER_STATE_IMAGE_ALLIN = "game/game_layer/common/ic_action_red.png",--allin
  USER_STATE_IMAGE_YANSHI = "game/game_layer/common/ic_action_yellow.png",--延时
  USER_STATE_IMAGE_WAITSTATE = "game/game_layer/common/ic_action_yellow.png",--等待
  USER_STATE_IMAGE_ALLIN_ODDS_HIGH = "game/game_layer/common/ic_action_red.png",--allin胜率高
  USER_STATE_IMAGE_ALLIN_ODDS_LOW = "game/game_layer/common/ic_action_gray.png",--allin胜率低
  USER_STATE_IMAGE_STRADDLE = "game/game_layer/common/ic_action_red.png",--straddle

  POKER_BACK_ICON = "game/game_layer/ingame_poker/normal/poker_back_1.png", --牌背景

  SEX_WOMEN_ICON = "game/game_layer/common/ic_female-i6p.png", --添加好友性别女
  SEX_MAN_ICON = "game/game_layer/common/ic_male-i6p.png", --添加好友性别男ic_male-i6p
  GOLD_ICON = "game/game_layer/common/ic_coin-i6p.png", --添加好友表情德扑币图标
  GOLD_DISABLE_ICON = "game/game_layer/common/ic_coin-i6p.png", --添加好友表情德扑币变灰图标
  DIAMOND_ICON = "game/game_layer/common/ic_da_icon-i6p.png", --添加好友表情钻石图标
  DIAMOND_DISABLE_ICON = "game/game_layer/common/ic_da_icon-i6p.png", --添加好友表情钻石变灰图标
  DIAMOND_FLY_CHOUMA_ICON = "game/game_layer/common/ic_chouma-i6p.png", --飞行中筹码图标ic_chouma-i6p.png


  POKER_SELECTED_ICON = "game/game_layer/ingame_poker/normal/poker_card_selected.png", --牌被选择高亮

  MICROPHONE_CANCER_ICON = "game/game_layer/common/record_cancel_tips.png", --语音按上滑取消发送
  MICROPHONE_PRESSED_ICON = "game/game_layer/common/record_tipsbg.png", --语音按下发送
  MICROPHONE_PRESSED_VOICE_ICON = "game/game_layer/common/microphone/record_voice_%d.png", --语音大小状态图片
 

  INSURANCE_TIME_PROGRESS_ICON = "game/game_layer/common/insurance/insurance_daojishi.png", --保险倒计时底图
  TIME_PROGRESS_ICON = "game/game_layer/common/ic_time_progress_new-i6p.png", --倒计时底图
  TIME_OTHER_USER_PROGRESS_ICON = "game/game_layer/common/ic_progress-i6p.png", --其它玩家倒计时底图

  RADIO_PARTICLE_PLIST = "game/Particle/radioparticle.plist", --倒计时粒子特效
  RADIO_PARTICLE_HEAD_PLIST = "game/Particle/radioparticlehead.plist", --倒计时粒子特效


  BIG_BLINDS_ICON = "game/game_layer/common/ic_b_chouma-i6p.png", --大盲筹码图标
  SMALL_BLINDS_ICON = "game/game_layer/common/ic_s_chouma-i6p.png", --小盲筹码图标
  DEFAULT_BLINDS_ICON = "game/game_layer/common/ic_chouma-i6p.png", --默认筹码图标
  SHORTDEAL_ICON = "game/game_layer/common/ic_shortdeal_image.png", --短牌deal筹码图标


  CHECK_BLANK_ICON = "game/game_layer/common/blank.png", --取消以后按此操作执行
  CHECK_SELECTED_ICON = "game/game_layer/common/selected.png", --确定以后按此操作执行
  CHECK_DISABLED_ICON = "game/game_layer/common/common_check_disable.png", --不可点击状态

  CHECK_SINGNAL_GOOD_ICON = "game/game_layer/common/ic_singal_3-i6p.png",--信号最强
  CHECK_SELECTED_GENERAL_ICON = "game/game_layer/common/ic_singal_2-i6p.png",--信号一般
  CHECK_SELECTED_POOR_ICON = "game/game_layer/common/ic_singal_1-i6p.png",--信号最弱
  CHECK_SELECTED_NO_SIGNAL_ICON = "game/game_layer/common/ic_singal_0-i6p.png",--无信号


  BUYIN_INVITE_FIRST_BACK_ICON = "game/game_layer/common/message1_bg@3x.png",--买入请求第一个界面底图


  --调整买入手数
  ADVANCED_SETTINGS_SLIDER_HANDLE_DISABLE_ICON = "game/game_layer/common/ic_sliderhandle_disable-i6p.png",
  ADVANCED_SETTINGS_SLIDER_HANDLE_ICON = "game/game_layer/common/ic_sliderhandle-i6p.png",
  ADVANCED_SETTINGS_INTERVA_ICON = "game/game_layer/common/sliderProgress-i6p.png",
  ADVANCED_SETTINGS_INTERVA_DISABLE_ICON = "game/game_layer/common/sliderProgress_disable-i6p.png",
  ADVANCED_SETTINGS_PAUSE_NORMAL_ICON = "game/game_layer/common/pause.png",

  --弱提示标志图
  WEAK_TIPS_CONFORM_ICON = "game/game_layer/common/ic_weaktips_confirm.png",
  WEAK_TIPS_WRONG_ICON = "game/game_layer/common/ic_weaktips_wrong.png",
  WEAK_TIPS_WARNING_ICON = "game/game_layer/common/ic_weaktips_warning.png",


    SEX_WOMEN_ICON_NEW = "game/game_layer/common/remark/male.png", --添加好友性别女 新版
    SEX_MAN_ICON_NEW = "game/game_layer/common/remark/female.png", --添加好友性别男ic_male-i6p 新版
    REMARK_VOICE_NORMAL_ICON = "game/game_layer/common/remark/voice.png", --个人信息中的播语音小图标 normal
    REMARK_VOICE_DISABLED_ICON = "game/game_layer/common/remark/voice_disable.png", --个人信息中的播语音小图标 disabled
    REMARK_VOICE_PRESSED_ICON = "game/game_layer/common/remark/voice_pressed.png", --个人信息中的播语音小图标 pressed
    REMARK_ADDFRIEND_NORMAL_ICON = "game/game_layer/common/remark/add.png", --个人信息中的添加好友小图标 normal
    REMARK_ADDFRIEND_DISABLED_ICON = "game/game_layer/common/remark/add_disable.png", --个人信息中的添加好友小图标 disabled
    REMARK_ADDFRIEND_PRESSED_ICON = "game/game_layer/common/remark/add_pressed.png", --个人信息中的添加好友小图标 pressed
    REMARK_EDIT_NORMAL_ICON = "game/game_layer/common/remark/edit.png", --个人信息中添加标记图标  normal
    REMARK_EDIT_PRESSED_ICON = "game/game_layer/common/remark/edit_pressed.png", --个人信息中添加标记图标  pressed
    REMARK_KICKOUT_NORMAL_ICON = "game/game_layer/common/remark/kick.png", --踢人小图标 normal
    REMARK_KICKOUT_DISABLED_ICON = "game/game_layer/common/remark/kick_disable.png", --踢人小图标 disabled
    REMARK_KICKOUT_PRESSED_ICON = "game/game_layer/common/remark/kick_pressed.png", --踢人小图标 pressed
    INFO_VOICE_NORMAL_ICON = "game/game_layer/common/remark/play_voice_normal.png", --屏蔽语音小图标 没屏蔽
    INFO_VOICE_MUTE_ICON = "game/game_layer/common/remark/play_voice_disabled.png", --屏蔽语音小图标 屏蔽    
}

USER_STATE_TEXT = {
    USER_STATE_TEXT_CHECK = "看牌",
    USER_STATE_TEXT_FOLD = "弃牌",
    USER_STATE_TEXT_CALL = "跟注",
    USER_STATE_TEXT_RAISE = "加注",
    USER_STATE_TEXT_ALLIN = "ALLIN",
    USER_STATE_TEXT_YANSHI = "延时",
    USER_STATE_TEXT_WAIT = "等待",
    USER_STATE_TEXT_STRADDLE = "Straddle",
}

MAINSCENE_BG_IMAGE = "game/game_layer/common/desktop_background_4.png" --桌面主题背景
--MAINSCENE_BG_TEXT_COLOR = cc.c3b(31,45,80) --桌面主题背景 文字颜色
MAINSCENE_BG_TEXT_COLOR = cc.c3b(255,255,255)
MAINSCENE_BG_TEXT_OPACITY = 0.4 * 255

POKER_CT_NAME={}
POKER_CT_NAME[CT_SINGLE]=[[高牌]]
POKER_CT_NAME[CT_ONE_LONG]=[[一对]]
POKER_CT_NAME[CT_TWO_LONG]=[[两对]]
POKER_CT_NAME[CT_THREE_TIAO]=[[三条]]
POKER_CT_NAME[CT_SHUN_ZI]=[[顺子]]
POKER_CT_NAME[CT_TONG_HUA]=[[同花]]
POKER_CT_NAME[CT_HU_LU]=[[葫芦]]
POKER_CT_NAME[CT_TIE_ZHI]=[[四条]]
POKER_CT_NAME[CT_TONG_HUA_SHUN]=[[同花顺]]
POKER_CT_NAME[CT_KING_TONG_HUA_SHUN]=[[皇家
同花顺]]


--operation
STR_OPERATION_TEXT_MENU = "菜单"
STR_OPERATION_TEXT_SHARE_GAME = "牌局分享"
STR_OPERATION_TEXT_STAND_UP = "站起围观"
STR_OPERATION_TEXT_OPTIONS = "牌局设置"
STR_OPERATION_TEXT_POKER_HANDS_HINTS = "牌型提示"
STR_OPERATION_TEXT_CHANGE_CARD_COLOUR = "切换四色牌"
STR_OPERATION_TEXT_CHANGE_CARD_COLOUR_CLASSIC = "切换经典牌"
STR_OPERATION_TEXT_TEMPORARILYLEAVE = "留座离桌"
STR_OPERATION_TEXT_HELPER = "托管牌局"
STR_OPERATION_TEXT_INSURANCE_HINTS = "保险说明"
STR_OPERATION_TEXT_BUY_IN = "补充记分牌"
STR_OPERATION_TEXT_CASH_OUT = "带出记分牌"
STR_OPERATION_TEXT_GO_TO_SHOP = "游戏商城"
STR_OPERATION_TEXT_EXIT_GAME = "退出牌局"

--sng
STR_OPERATION_TEXT_REWARD_RULES = "规则奖励"
STR_OPERATION_TEXT_LEAVE_GAME = "离开比赛"

--mtt
STR_OPERATION_TEXT_MTT_SIGNUP = "报名比赛"
STR_OPERATION_TEXT_MTT_LEAVE_GAME = "离开比赛"


--文字文本
STR_TEXT_DEFAULT = ""
STR_TEXT_WAIT = "等待"
STR_TEXT_FREE = "免费"
STR_TEXT_NOT_ENOUGH = "不足"
STR_TEXT_ADD_FRIEND_HINT = "Dear偶像，加个好友一起愉快滴玩耍呗！"
STR_TEXT_VOICE_CANCEL = "松开确定取消"
STR_TEXT_VOICE_SEND = "上滑取消发送"
STR_TEXT_ROOM_NAME = "* %s *"
STR_TEXT_ROOM_BLINDS_STR = "盲注"
STR_TEXT_ROOM_BLINDS = " %d/%d"
STR_TEXT_ROOM_ANTE_BLINDS = " %d/%d (%d)"
STR_TEXT_ROOM_SHORTDUCK_ANTE = "前注: "
STR_TEXT_ROOM_SHORTDUCK_STRAIGHT = "  顺子>三条"
STR_TEXT_ROOM_SHORTDUCK_THREE = "  三条>顺子"
STR_TEXT_ROOM_SHORTDUCK_ANTE_TWO = "庄位2倍前注"
STR_TEXT_ROOM_SHORTDUCK_HOLD_MIN = "最小保留记分牌数: "
STR_TEXT_ROOM_INVITE = "邀请码: "
STR_TEXT_ROOM_CONTROLINTO = "带入确认"
STR_TEXT_ROOM_INSURANCE = "保险"
STR_TEXT_AUDIO_TIME = "%d'"
STR_TEXT_FORMAT_FLOAT = "%d.%d"
STR_TEXT_FORMAT_K = "%.2fK"
STR_TEXT_FORMAT_K1 = "%.1fK"
STR_TEXT_FORMAT_K0 = "%dK"
STR_TEXT_FORMAT_D = "%02d"
STR_TEXT_CONTINUE_TIME = "+%d"
STR_TEXT_ALL_POOL = "底池:"
STR_TEXT_POKER_FACE = "game/game_layer/ingame_poker/normal/poker_%d.png"
STR_TEXT_SURPLUS_TIME = "%d"
STR_TEXT_WIN_CHIP_NUM = "+"
STR_TEXT_RAISE_MAX_CHIP = "allin"
STR_TEXT_RAISE_MAX_POT_CHIP = "底池"
STR_TEXT_POKER_FACE_FOURCOLOR = "game/game_layer/ingame_poker/fourcolor/poker_%d.png"

STR_TEXT_WAITTING_1 = [[绿色德州,竞技体育
等待房主开局]]
STR_TEXT_WAITTING_2 = [[德扑，朋友间的乐趣
等待房主开局]]
STR_TEXT_WAITTING_3 = [[严禁赌博,违者封号
等待房主开局]]
STR_TEXT_WAITTING_4 = [[请选择座位坐下]]

STR_TEXT_WAITTING_5 = [[ ..]]
STR_TEXT_WAITTING_6 = [[. .]]
STR_TEXT_WAITTING_7 = [[.. ]]

STR_TEXT_GO_TO_SHOP_COIN_TEXT = "德扑币不足，请购买"
STR_TEXT_GO_TO_SHOP_COIN_BUTTON_TEXT = "购买德扑币"
STR_TEXT_GO_TO_SHOP_DIAMOND_TEXT = "钻石不足，请购买"
STR_TEXT_GO_TO_SHOP_DIAMOND_BUTTON_TEXT = "购买钻石"


LODING_ANIMATE_IMAGE = "loading/loading_000%d@2x.png"
WIN_ANIMATE_IMAGE = "game/game_layer/common/you_win/anim_youwin%d-i6p.png"

STR_TEXT_TIME_TIPS_5 = "牌局将在5分钟后结束"
STR_TEXT_TIME_TIPS_1 = "牌局将在1分钟后结束"

STR_TEXT_REVIEW_POKER_TYPE_TEXT = "弃牌"
STR_TEXT_REVIEW_COLLECTION_NUM_TEXT = "%d/%d"

STR_TEXT_CONTROL_ENABLE_TIPS = "房主已打开带入申请"
STR_TEXT_CONTROL_DISABLE_TIPS = "房主已关闭带入申请"
STR_TEXT_CONTROL_DENY_TIPS = [[您的请求买入
被房主拒绝]]

STR_TEXT_CONTROL_DENY = "拒绝%ds"

STR_TEXT_CONTROL_ENABLE_WAITTING = [[请求房主带入同意中
请等待%ds...]]

STR_TEXT_PAUSE_TIPS_TEXT = "牌局暂停中"
STR_TEXT_PAUSE_WAITTING = [[请等待%s...]]

STR_TEXT_SIT_DOWN_OTHER_USER_BUYIN_WAITTING = "请求中%ds"

STAND_PLAYER_PLAY_SOUND_IMAGE = "game/game_layer/common/sound_others_%d@2x.png"

STR_TEXT_ADD_FRIEND_SEND_TIPS = "发送成功"
STR_TEXT_COLLECTION_TIPS = "已收藏"
STR_TEXT_COLLECTION_FAULT_TIPS = "收藏失败"
STR_TEXT_REMOVE_COLLECTION_TIPS = "取消收藏"
STR_TEXT_REMOVE_COLLECTION_FAULT_TIPS = "取消收藏失败"

STR_TEXT_REMARK_TIPS = "输入字数超出限制"

STR_TEXT_STANDBY_NUM_TEXT = "%d人"
---sng
STR_TEXT_SNG_RULESDETAILS_RANK_TEXT = "当前："

STR_TEXT_SNG_ROOM_BLINDS = "人局  "
STR_TEXT_SNG_ROOM_BLINDS_END = "盲注 "
STR_TEXT_SNG_RULESDETAILS_ROOM_BLIND_INTERVAL = "%d人桌  涨盲时间: %d分钟"
STR_TEXT_SNG_MIDWAY_LEAVE_TIPS = [[离开后，可重回比赛，是否继续离开]]
STR_TEXT_SNG_LEAVE_TIPS = [[是否继续离开]]

STR_TEXT_SNG_GAME_ROOM_USER_MAX_NUMS = "%d人桌"
STR_TEXT_SNG_RANK_TEXT = {}
STR_TEXT_SNG_RANK_TEXT[1] = "第1名"
STR_TEXT_SNG_RANK_TEXT[2] = "第2名"
STR_TEXT_SNG_RANK_TEXT[3] = "第3名"
STR_TEXT_SNG_RANK_TEXT[4] = "第4名"
STR_TEXT_SNG_RANK_TEXT[5] = "第5名"
STR_TEXT_SNG_RANK_TEXT[6] = "第6名"
STR_TEXT_SNG_RANK_TEXT[7] = "第7名"
STR_TEXT_SNG_RANK_TEXT[8] = "第8名"
STR_TEXT_SNG_RANK_TEXT[9] = "第9名"
STR_TEXT_SNG_RANK_AWARD_TEXT = "奖金: %d"
STR_TEXT_SNG_ELIMINATE_TEXT = "没关系，下次再战"
STR_TEXT_SNG_ELIMINATE_TIPS_TEXT = "您已经被淘汰！"
STR_TEXT_SNG_RANK_AWARD_TIPS_TEXT = "恭喜您，获得%s!"
STR_TEXT_SNG_SIGNUP_BEGIN_TEXT = "报名成功！还差 "
STR_TEXT_SNG_SIGNUP_END_TEXT = " 人开始比赛"

STR_TEXT_SNG_RICHTEXT_RANKING_BEGIN_TEXT = "当前：第 "
STR_TEXT_SNG_RICHTEXT_RANKING_MIDDLE_TEXT={}
STR_TEXT_SNG_RICHTEXT_RANKING_MIDDLE_TEXT[1] = "1"
STR_TEXT_SNG_RICHTEXT_RANKING_MIDDLE_TEXT[2] = "2"
STR_TEXT_SNG_RICHTEXT_RANKING_MIDDLE_TEXT[3] = "3"
STR_TEXT_SNG_RICHTEXT_RANKING_MIDDLE_TEXT[4] = "4"
STR_TEXT_SNG_RICHTEXT_RANKING_MIDDLE_TEXT[5] = "5"
STR_TEXT_SNG_RICHTEXT_RANKING_MIDDLE_TEXT[6] = "6"
STR_TEXT_SNG_RICHTEXT_RANKING_MIDDLE_TEXT[7] = "7"
STR_TEXT_SNG_RICHTEXT_RANKING_MIDDLE_TEXT[8] = "8"
STR_TEXT_SNG_RICHTEXT_RANKING_MIDDLE_TEXT[9] = "9"
STR_TEXT_SNG_RICHTEXT_RANKING_END_TEXT = " 名"

STR_TEXT_SNG_UP_BLIND_TIP_TIPS_BEGIN_TEXT = "下一手将升盲至   "
STR_TEXT_SNG_UP_BLIND_TIP_TIPS_END_TEXT = "%d/%d"

STR_TEXT_SNG_SIGNUP_STARTED_TEXT = "正式开始比赛"
STR_TEXT_SNG_SIGNUP_PREPARE_BEGIN_TEXT = "比赛将在 "
STR_TEXT_SNG_SIGNUP_PREPARE_END_TEXT = " 秒后开始"
--结束获奖排位图标
SNG_AWARD_FINISH_BILL_RANKING_ICON = "game/game_layer/common/sng/sng_%dcup_big_hd.png"
--SNG排名
SNG_RANKING_ICON = "game/game_layer/common/ic_sngrank_image.png"
SNG_RANKING_TEXT = "第%d名"
--SNG托管状态
SNG_DELEGATE_ICON = "game/game_layer/common/ic_delegate_image.png"
SNG_DELEGATE_TEXT = "托管中"

--
SNG_BILL_RANKING_ICON = "game/game_layer/common/sng/sng_%dcup_icon.png"
--sng控制买入提示
SNG_STR_TEXT_CONTROL_AGREE_TIPS = [[%s
房主通过了您的报名请求]]

SNG_STR_TEXT_CONTROL_DENY_TIPS = [[%s
房主拒绝了您的报名请求]]

SNG_STR_TEXT_HAND_NUM = "第%d手"
INSURANCE_STR_TEXT_BREAKEVEN_TEXT = "保本"
INSURANCE_STR_TEXT_ALL_BREAKEVEN_TEXT = "全部保本"
INSURANCE_STR_TEXT_FULLPOOL_TEXT = "满池"
INSURANCE_STR_TEXT_ALL_FULLPOOL_TEXT = "全部满池"

INSURANCE_STR_TEXT_BET_FOLD_ICON = "game/game_layer/common/ic_insurance_bubao.png"
INSURANCE_STR_TEXT_BET_STACKS_ICON = "game/game_layer/common/ic_insurance_toubao_peifu.png"
INSURANCE_STR_TEXT_GET_STACKS_ICON = "game/game_layer/common/ic_insurance_toubao_peifu.png"
INSURANCE_STR_TEXT_GET_GOU_MAI_ICON = "game/game_layer/common/ic_insurance_goumai.png"

INSURANCE_STR_TEXT_BET_STACKS_TEXT = "投保"
INSURANCE_STR_TEXT_BET_FOLD_TEXT = "不保"
INSURANCE_STR_TEXT_GET_STACKS_TEXT = "赔付"
INSURANCE_STR_TEXT_GET_GOU_MAI_TEXT = "购买中 %ds"

INSURANCE_STR_TEXT_TIPS_BUYIN_ICON = "game/game_layer/cn/insurance/insurance_buyin_tips_anims/insurance_buyin_tips_%d.png"

INSURANCE_STR_TEXT_BUYIN_OK_TEXT = "购买保险"
INSURANCE_STR_TEXT_BUYIN_OK_ENABLED_TEXT = "请选择分池"
INSURANCE_STR_TEXT_MAIN_POT = "主池"
INSURANCE_STR_TEXT_SPLIT_POT = "分池"

INSURANCE_STR_TEXT_POT_MAIN_TEXT="主"

INSURANCE_STR_TEXT_TIPS_NO_BUYIN_TEXT="补牌>14或补牌=0，不能购买保险"
INSURANCE_STR_TEXT_TIPS_NO_BUYIN_TEXT_SHORTDUCK="补牌>13或补牌=0，不能购买保险"
INSURANCE_STR_TEXT_TIPS_AUTO_BUYIN_TEXT="系统自动背保险，支出 %d 积分"
INSURANCE_STR_TEXT_TIPS_NO_BUYIN_POOL_TEXT="底池小于32，不能购买保险"

REVIEW_STR_TEXT_INSURANCE_STACKS_TEXT = "保险池： "

REVIEW_STR_TEXT_INSURANCE_NO_SEL_POT_TEXT = "点击选择"
REVIEW_STR_TEXT_INSURANCE_SEL_POT_TEXT = "已选择"

INSURANCE_STR_ODDS_TEXT = "0"
INSURANCE_STR_FULLPOLL_TEXT = "满池"
INSURANCE_STR_MAXPOLL_TEXT = "最大"
INSURANCE_STR_OVEROUTS_TIPS_TEXT = "最少选择%d张outs"
INSURANCE_STR_CHOOSE_OUTS_FULL_TIPS_TEXT = "选择outs数已达上限"

--保险碎了图标
INSURANCE_SUI_ICON = "game/game_layer/cn/insurance/insurance_anmi.png"

--水印
NORMAL_GAME_TYPE_LOG_ICON = "game/game_layer/common/gamelogo/game.png"
SNG_GAME_TYPE_LOG_ICON = "game/game_layer/common/gamelogo/sng.png"
SIX_GAME_TYPE_LOG_ICON = "game/game_layer/common/gamelogo/6game.png"
OMAHA_GAME_TYPE_LOG_ICON = "game/game_layer/common/gamelogo/omaha.png"
MTT_GAME_TYPE_LOG_ICON = "game/game_layer/common/gamelogo/mtt_gamelogo.png"
SHORT_DECK_TYPE_LOG_ICON =  "game/game_layer/common/gamelogo/shortduck.png"

--过渡界面水印
LOADING_GAME_LOGO_ICON = "game/game_layer/common/transition/transition_logo.png"

KICK_GAME_ROOM_TEXT = "被房主请出牌局"
KICK_GAME_ROOM_OTHER_ROOM_TEXT = "您被房主请出牌局"

END_GAME_ROOM_FORWARD_TEXT = "房主提前结束牌局"

--IP限制文本
IP_LIMIT_TEXT = "IP"
GPS_LIMIT_TEXT = "GPS"
IP_AND_GPS_LIMIT_TEXT = "GPS IP"

--straddle设置文本
STRADDLE_OPEN_TEXT = "  Straddle"

--强制站起
FORCE_STANDUP_TEXT = "您被房主强制站起"
FORCE_STANDUP_OTHERROOM_TEXT = "您被%s房主强制站起"
FORCE_STANDUP_OTHERS_TEXT = "被房主强制站起"
FORCE_OPEN_STANDUP_WEAKTIP_TEXT = [[ 房主开启了强制
Straddle功能]]
FORCE_CLOSE_STANDUP_WEAKTIP_TEXT = [[ 房主关闭了强制
Straddle功能]]

--思考时间
THINKING_INTERVAL_TEXT = "房主将思考时间改为%d秒, 下一手生效."

--show ID
OTHERINFO_SHOW_ID_TEXT = "ID:"

--MTT
MTT_DESK_NUM_TEXT={}
MTT_DESK_NUM_TEXT[1] = ""
MTT_DESK_NUM_TEXT[2] = " 号桌"
MTT_DESK_STAKE_TEXT = "%d/%d"
MTT_AWARD_RANK_TEXT = "前%d名"
MTT_AWARD_RANK_POS_TEXT = "第%d名"
MTT_AWARD_BONUS_TEXT = "奖励: "
MTT_AWARD_RANK_STR_TEXT = "第%s名"
MTT_BLIND_TIME_TEXT = "%d分钟"
MTT_BLIND_STRUCT_TEXT = "%d/%d/(%d)"
MTT_BLIND_STRUCT_NOANTE_TEXT = "%d/%d"
MTT_MAINSCENE_BLIND_TEXT = "当前盲注:"
MTT_MAINSCENE_DESK_TIME_TEXT01 = "00:%d"
MTT_MAINSCENE_DESK_TIME_TEXT02 = "00:0%d"
MTT_MAINSCENE_DESK_TIME_TEXT03 = "00:00"
MTT_REVIEW_DESKNUM_TEXT = "第%d桌"
MTT_MATCH_DATA_NO_BLINDTIME_TEXT = "--:--:--"
MTT_MATCH_DATA_NO_DATA_TEXT = "--"
MTT_MATCH_DATA_NO_BLINDSTRUCT_TEXT = "--/--/(--)"
MTT_MATCH_DATA_NO_USEDTIME_TEXT = "00:00:00"

MTT_RANK_TEXT={}
MTT_RANK_TEXT[1] = "冠军"
MTT_RANK_TEXT[2] = "亚军"
MTT_RANK_TEXT[3] = "季军"
MTT_OTHER_RANK_TEXT = "第%d名"

MTT_WATCH_DESK_FINISH_TEXT = "当前牌桌已失效"
MTT_WATCH_FINISH_TEXT = "比赛已结束"

MTT_DESK_STATE_REENTRY_TEXT = "允许重进中"
MTT_DESK_STATE_DELAY_TEXT = "延迟报名中"

MTT_REENTRY_FEE_POPULARITY_TEXT = "是否以%d德扑币或对应赛事门票进行重进"
MTT_REENTRY_FEE_TICKET_TEXT = "是否以赛事门票进行重进"
MTT_REENTRY_GET_STACKS_TEXT = "获得%d记分牌"

MTT_SIGNUP_REQUIREMENT_COIN_TEXT = "%d德扑币或赛事门票"
MTT_SIGNUP_REQUIREMENT_TICKET_TEXT = "赛事门票"

MTT_START_PUSH_TEXT = "已经可以入座，祝您好运!"
MTT_START_FULL_TABLE_PUSH_TEXT = "牌局已就绪，请开始游戏!"
MTT_START_CANCEL_PUSH_TEXT = "已经取消，将退还给您报名条件。"
MTT_START_PUSH_ENTER = "进入比赛"
MTT_START_PUSH_BACK = "回到牌局"

MTT_SYSTEM_PUSH_GIVECARD_SAMETIME_TEXT = "比赛同步发牌中，请等待其他牌桌结束当前手牌"
MTT_SYSTEM_PUSH_CHANGE_DESK_TEXT = "您已被移动到新的牌桌"
MTT_SYSTEM_PUSH_CHANGE_DESK_TEXT02 = "您旁观的牌桌已失效，您已被返回原先牌桌"
MTT_DELAY_REGISTER_FINISH_DESK_TEXT = "比赛迟注册阶段已经结束"
MTT_SYSTEM_PUSH_BLIND_UP_DESK_TEXT = "下一手牌涨盲至："

MTT_SYSTEM_PUSH_NORMAL_TEXT = "现在前往比赛，您会从当前牌局站起，确认要前往比赛吗？"
MTT_SYSTEM_PUSH_FULL_TABLE_TEXT = "您现在离开牌桌将会从当前牌局站起，确认要前往吗？"
MTT_SYSTEM_PUSH_SNG_OR_MTT_TEXT = "现在前往比赛，您当前的比赛会托管，确认要前往比赛吗？"

MTT_INTRODUCE_PAG_DELAY_TEXT = "%d级别内可延时报名"
MTT_INTRODUCE_PAG_REENTRY_TEXT = "%d级别内可重进，上限%d次"

MTT_INTRODUCE_PAG_SIGNUP_STR = "报名费:"
MTT_INTRODUCE_PAG_STACKS_STR = "初始记分牌:"
MTT_INTRODUCE_PAG_DELAY_STR = "延时报名:"
MTT_INTRODUCE_PAG_REENTRY_STR = "重进:"
MTT_INTRODUCE_PAG_COIN_TEXT = "%d德扑币"

--文字牌谱
STR_POKERTEXTINFO_STATE_PREFLOP_TEXT = "Preflop"
STR_POKERTEXTINFO_STATE_FLOP_TEXT = "Flop"
STR_POKERTEXTINFO_STATE_TURN_TEXT = "Turn"
STR_POKERTEXTINFO_STATE_RIVER_TEXT = "River"
STR_POKERTEXTINFO_HIDENAME_TEXT = "匿名"
STR_POKERTEXTINFO_INSURANCE_TEXT = "保险池:"
STR_POKERTEXTINFO_PROCESS_TEXT = "详细过程"
STR_POKERTEXTINFO_HANDRESULT_TEXT = "牌谱"
STR_POKERTEXTINFO_SHOWDOWN_TEXT = "Showdown"

POKERTEXTINFO_FOLD_ICON = "game/game_layer/common/pokertextinfo/fold_icon.png"
POKERTEXTINFO_CALL_ICON = "game/game_layer/common/pokertextinfo/call_icon.png"
POKERTEXTINFO_RAISE_ICON = "game/game_layer/common/pokertextinfo/raise_icon.png"
POKERTEXTINFO_POKER_FACE_ICON = "game/game_layer/common/pokertextinfo/poker_%d.png"
POKERTEXTINFO_POKER_BACK_FACE_ICON = "game/game_layer/common/pokertextinfo/poker_en.png"

INSURANCE_HELP_URL = "http://upyun.pokermate.net/web/cn/insurance_instruction.html"
INSURANCE_OMAHA_HELP_URL = "http://upyun.pokermate.net/web/cn/omaha_insurance_instruction.html"

--个人设置界面
STR_SETTING_SELFTITLE_TEXT = "个人设置"
STR_SETTING_ADVANCETITLE_TEXT = "房主功能"

STR_SETTING_SELF_RAISESTR_TEXT = "自定义快捷加注"
STR_SETTING_SELF_CARDSTR_TEXT = "桌面风格"
STR_SETTING_SELF_MUTE_TEXT = "牌局静音"
STR_SETTING_SELF_TALK_MUTE_TEXT = "聊天静音"
STR_SETTING_SELF_INSURANCE_STR_TEXT = "保险提示"
STR_SETTING_SELF_INSURANCE_TIPSSTR_TEXT = "(只对本桌有效)"
STR_SETTING_SELF_RAISE_STR_TEXT = "拉杆确认"
STR_SETTING_SELF_RAISE_TIPS_TEXT = [[点击快速加注按钮

可自定义加注底池比例]]

SETTING_SELF_RAISEPOT_ALLIN_STR = "Allin"
SETTING_SELF_RAISEPOT_1XPOT_STR = "1x"
SETTING_SELF_RAISEPOT_1PT5XPOT_STR = "1.5x"
SETTING_SELF_RAISEPOT_NIL_STR = "无"

SETTING_SELF_TABLECOLOR01_STR = "经典蓝"
SETTING_SELF_TABLECOLOR02_STR = "磨砂黑"
SETTING_SELF_TABLECOLOR03_STR = "宝石蓝"
SETTING_SELF_TABLECOLOR04_STR = "青葱绿"

SETTING_SELF_RAISEPOT_SELECTED_ICON = "game/game_layer/common/setting/poticon_pressed.png"
SETTING_SELF_RAISEPOT_NORMAL_ICON = "game/game_layer/common/setting/poticon_normal.png"

--弹幕
BULLET_BACKIMAGE_TYPE_NORMAL_IMAGE = "game/game_layer/common/bulletscreen/ic_normal_bgimage.png"
BULLET_BACKIMAGE_TYPE_MIDDLE_IMAGE = "game/game_layer/common/bulletscreen/ic_middle_bgimage.png"
BULLET_BACKIMAGE_TYPE_JUNIOR_IMAGE = "game/game_layer/common/bulletscreen/ic_high_bgimage.png"

BULLETSCREEN_BUTTON_NORMAL_IMAGE = "game/game_layer/common/bulletscreen/ic_danmu_btn.png"
BULLETSCREEN_BUTTON_PRESSED_IMAGE = "game/game_layer/common/bulletscreen/ic_danmu_btn_pressed.png"
BULLETSCREEN_BUTTON_DISABLED_IMAGE = "game/game_layer/common/bulletscreen/ic_danmu_btn_pressed.png"

--留座离桌
PLAYER_TEMPORARILYLEAVE_TEXT = "留座中"
PLAYER_TEMPORARILYLEAVE_TIME_TEXT = "%ds"
PLAYER_TEMPORARILYLEAVE_TIPS_TEXT = "您将在本手结束后进入留座离桌状态。"

--错误
ERROR_TEXT_TYPE_ENUM={
[1] = "用户不存在。",
[2] = "群聊不存在。",
[3] = "此手机号码已经注册过账号。",
[4] = "验证码不正确，请重新输入。",
[5] = "账号或密码错误，请重新填写。",
[6] = "对方没有邀请您为好友。",
[7] = "你们不是好友。",
[8] = "群聊人数超出上限。",
[9] = "已到达您VIP等级创建上限。",
[10] = "未知服务器错误。",
[11] = "牌局不存在。",
[12] = "牌局人数已满。",
[13] = "德扑币不足，请购买德扑币",
[14] = "你们不是好友。",
[15] = "已经分享足够次数。",
[16] = "已经获得过奖励。",
[17] = "战绩不存在。",
[18] = "收藏的牌谱不存在。",
[19] = "收藏数据不完整。",
[20] = "您购买的道具错误。",
[21] = "您没有足够的钻石，请先购买钻石。",
[22] = "您无此权限。",
[23] = "您无此权限，只能群主移除。",
[24] = "您无此权限，只能群主进行群组设置。",
[25] = "您无此权限，只能群主邀请。",
[26] = "该用户不在群聊中。",
[27] = "账户在其它设备登录。",
[28] = "未知错误。",
[29] = "已经有人坐下了。",
[30] = "您不能购买低于当前等级的VIP卡。",
[31] = "没有权限开始牌局。",
[32] = "你们已成为好友。",
[33] = "活动已经结束。",
[34] = "俱乐部已达人数上限，无法允许加入",
[35] = "俱乐部不存在。",
[36] = "您没有相关权限。",
[37] = "该用户不在俱乐部中。",
[38] = "您只能创建一个快速牌局。",
[39] = "快速牌局不存在。",
[40] = "快速牌局已开始。",
[41] = "牌局中已没有其他玩家。",
[42] = "该用户不在快速牌局中。",
[43] = "购买失败。",
[44] = "",
[45] = "购买失败。",
[46] = "手中筹码达到上限",
[47] = "福利已经领取",
[48] = "已到达俱乐部人数上限。",
[49] = "权限不足，只有管理员可操作",
[50] = "昵称已存在，请更换",
[51] = "昵称是否已经被占用",
[52] = "牌局不是高级房",
[53] = "不是房主",
[54] = "不存在牌局结果",
[55] = "不存在上一个牌局结果",
[56] = "不存在这个牌谱",
[57] = "已申请，请等待房主批准",
[58] = "用户不在游戏房间内",
[59] = "用户没有申请买入",
[60] = "用户没有处理买入的权限",
[61] = "您有未结束的牌局",
[62] = "错误的暂停命令",
[63] = "牌局还没有开始",
[64] = "不是牌局主，无法对牌局进行设置",
[65] = "用户已经在俱乐部中",
[66] = "收藏牌谱到上限",
[600] = "牌局已解散",
[71] = [[turn购买保险后，
开关不能关闭]],
[72] = [[您在allin状态下
不能站起或退出]],
[73] = [["登陆信息过期，
请重新登陆"]],
[74] = [[您已被房主请出牌局，
不能再次加入]],
[75] = [[ 由于您与牌局内某玩家距离过近
或没有开启定位权限, 为保证牌局
公平, 您不能参与本牌局。]],
[76] = [[ 由于您与牌局内某玩家距离过近
或没有开启定位权限, 为保证牌局
公平, 您不能参与本牌局。]],
[77] = [[ 由于您与牌局内某玩家距离过近
或没有开启定位权限, 为保证牌局
公平, 您不能参与本牌局。]],
[78] = [[ 由于您与牌局内某玩家距离过近
或没有开启定位权限, 为保证牌局
公平, 您不能参与本牌局。]],
[79] = "您已处于站起状态",
[80] = [[ 由于您与牌局内某玩家距离过近
或没有开启定位权限, 为保证牌局
公平, 您不能参与本牌局。]],
[81] = [[联盟中俱乐部数量
已达上限]],
[82] = [[您没有权限管理联盟]],
[83] = [[创建联盟超过上限]],
[84] = [[参与的联盟数超过上限]],
[85] = [[没有权限创建联盟]],
[86] = [[联盟不存在]],
[87] = [[没有权限获取联盟数据]],
[88] = [[已在其他俱乐部申请，
不允许在此俱乐部再次申请]],
[89] = [[该联盟已开启免打扰模式]],
[90] = [[该俱乐部已在联盟中]],
[91] = [[该俱乐部已经不在联盟中]],
[92] = [[加入联盟申请已发送]],
[93] = [[此联盟名称已被抢占]],
[94] = [[管理员数量已满]],
[95] = [[俱乐部加入的联盟数量超过上限]],
[96] = [[用户已开启免打扰]],
[97] = [[不能删除俱乐部，因为俱乐部
还有没有删除的联盟]],
[98] = [[不在联盟白名单中]],
[99] = [[门票类型不存在]],
[100] = [[门票数量不足]],
[101] = [[兑换码已过期]],
[102] = [[兑换码已经被使用]],
[103] = [[兑换码不存在]],
[104] = [[已经报过名]],
[105] = [[人数超过比赛限制，无法报名]],
[106] = [[不在延迟报名阶段内，无法报名]],
[107] = [[无门票或等值德扑币，无法报名]],
[108] = [[比赛已经开始，无法取消报名]],
[109] = [[不在延迟报名阶段内，无法重进]],
[110] = [[已超过用户重进次数，无法重进]],
[111] = [[无门票或等值德扑币，无法重进]],
[112] = [[已被淘汰，无法进入牌桌]],
[113] = [[已被合桌，无法进入牌桌]],
[114] = [[比赛已经结束，无法进入牌桌]],
[115] = [[无特殊门票，无法报名]],
[116] = [[比赛已经取消，无法报名]],
[117] = [[无特殊门票，无法重进]],
[118] = [[输入的内容中含有敏感词，请重试]],
[119] = [[牌桌失效，切换牌桌]],
[125] = [[本手已带出过记分牌]],
[126] = [[记分牌不足]],
[127] = [[记分牌不足]],

[9001] = "非法用户",
[9002] = "余额不足",
[9003] = "非法命令",
[9004] = "超时",
[9005] = "您的网络状态不好",

[9006] = "非法用户",
[9007] = "余额不足",
[9008] = "非法命令",
[9009] = "超时",
[9010] = "内部异常",

[9012] = "余额不足",
[9013] = "非法命令",
[9014] = "内部异常",
[9015] = "非法用户",
[9016] = "无效下注",
[9017] = "房间已满",
[9018] = "余额不足",
[9019] = "您很久未操作，请重新进入游戏",
}


SNG_RANK_TEXT={}
SNG_RANK_TEXT[1]="冠军"
SNG_RANK_TEXT[2]="亚军"
SNG_RANK_TEXT[3]="季军"


COCOSTUDIO_UI_BUYINCONTROLINVITECHILDNODE = "texaspoker.uilua.chinese.buyincontrolinvitechildnode"
COCOSTUDIO_UI_BUYINCONTROLINVITETIPSNODE = "texaspoker.uilua.chinese.buyincontrolinvitetipsnode"
COCOSTUDIO_UI_BUYNODE = "texaspoker.uilua.chinese.buynode"
COCOSTUDIO_UI_CHECKPROMPTNODE = "texaspoker.uilua.chinese.checkpromptnode"
COCOSTUDIO_UI_CASHOUTNODE = "texaspoker.uilua.chinese.cashoutnode"
COCOSTUDIO_UI_ERRORNODE = "texaspoker.uilua.chinese.errornode"
COCOSTUDIO_UI_FACELAYERCHILDLODE = "texaspoker.uilua.chinese.facelayerchildlode"
COCOSTUDIO_UI_FACELAYERNODE = "texaspoker.uilua.chinese.facelayernode"
COCOSTUDIO_UI_GOTOSHOPNODE = "texaspoker.uilua.chinese.gotoshopnode"
COCOSTUDIO_UI_LODINGNODE = "texaspoker.uilua.chinese.lodingnode"
COCOSTUDIO_UI_MAINFRAMEWORK = "uilua.hallscene.mainframework"
COCOSTUDIO_UI_MAINMENUNODE = "texaspoker.uilua.chinese.mainmenunode"
COCOSTUDIO_UI_MAINMENUNODE_I4 = "texaspoker.uilua.chinese.mainmenunode_i4"
COCOSTUDIO_UI_MAINMENUNODE_IPAD = "texaspoker.uilua.chinese.mainmenunode_ipad"
COCOSTUDIO_UI_MAINMENUNODE_S8 = "texaspoker.uilua.chinese.mainmenunode_s8"
COCOSTUDIO_UI_MAINSCENE = "texaspoker.uilua.chinese.mainscene"
COCOSTUDIO_UI_MAINSCENE_I4 = "texaspoker.uilua.chinese.mainscene_i4"
COCOSTUDIO_UI_MAINSCENE_IPAD = "texaspoker.uilua.chinese.mainscene_ipad"
COCOSTUDIO_UI_MAINSCENE_S8 = "texaspoker.uilua.chinese.mainscene_s8"
COCOSTUDIO_UI_MAINSCENE_MTTNODE = "texaspoker.uilua.chinese.mainscene_mttnode"
COCOSTUDIO_UI_MAINSCENE_MTTNODE_I4 = "texaspoker.uilua.chinese.mainscene_mttnode_i4"
COCOSTUDIO_UI_MAINSCENE_MTTNODE_IPAD = "texaspoker.uilua.chinese.mainscene_mttnode_ipad"
COCOSTUDIO_UI_MAINSCENE_NORMALNODE = "texaspoker.uilua.chinese.mainscene_normalnode"
COCOSTUDIO_UI_MAINSCENE_NORMALNODE_I4 = "texaspoker.uilua.chinese.mainscene_normalnode_i4"
COCOSTUDIO_UI_MAINSCENE_NORMALNODE_IPAD = "texaspoker.uilua.chinese.mainscene_normalnode_ipad"
COCOSTUDIO_UI_MAINSCENE_NORMALNODE_S8 = "texaspoker.uilua.chinese.mainscene_normalnode_s8"
COCOSTUDIO_UI_MAINSCENE_SNGNODE = "texaspoker.uilua.chinese.mainscene_sngnode"
COCOSTUDIO_UI_MAINSCENE_POOLNODE = "texaspoker.uilua.chinese.mainscene_poolnode"
COCOSTUDIO_UI_MAINSCENE_CARDNODE = "texaspoker.uilua.chinese.mainscene_cardnode"
COCOSTUDIO_UI_MAINSCENE_CARDNODE_I4 = "texaspoker.uilua.chinese.mainscene_cardnode_i4"
COCOSTUDIO_UI_MAINSCENE_CARDNODE_IPAD = "texaspoker.uilua.chinese.mainscene_cardnode_ipad"
COCOSTUDIO_UI_MAINSCENE_CARDNODE_S8 = "texaspoker.uilua.chinese.mainscene_cardnode_s8"
COCOSTUDIO_UI_MAINSCENE_INSURANCEBUYINTIPS_NODE = "texaspoker.uilua.chinese.mainscene_insurancebuyintipsnode"
COCOSTUDIO_UI_MATCHSTATISTICSMAINNODE = "texaspoker.uilua.chinese.matchstatisticsmainnode"
COCOSTUDIO_UI_MATCHSTATISTICSMAINNODE_S8 = "texaspoker.uilua.chinese.matchstatisticsmainnode_s8"
COCOSTUDIO_UI_MATCHSTATISTICSNODE = "texaspoker.uilua.chinese.matchstatisticsnode"
COCOSTUDIO_UI_MATCHUSERSETTLEMENTDATANODE = "texaspoker.uilua.chinese.matchusersettlementdatanode"

COCOSTUDIO_UI_OPERATIONNCHILDRENNODE = "texaspoker.uilua.chinese.operationnchildrennode"
COCOSTUDIO_UI_OPERATIONNCHILDRENMENUNODE = "texaspoker.uilua.chinese.operationnchildrenmenunode"
COCOSTUDIO_UI_OPERATIONNODE = "texaspoker.uilua.chinese.operationnode"
COCOSTUDIO_UI_OTHERINFOFACENODE = "texaspoker.uilua.chinese.otherinfofacenode"
COCOSTUDIO_UI_OTHERINFONODE = "texaspoker.uilua.chinese.otherinfonode"
COCOSTUDIO_UI_PAUSENODE = "texaspoker.uilua.chinese.pausenode"
COCOSTUDIO_UI_PLAGERNODE = "texaspoker.uilua.chinese.plagernode"
COCOSTUDIO_UI_PLAGERNODE_I4 = "texaspoker.uilua.chinese.plagernode_i4"
COCOSTUDIO_UI_PLAGERNODE_OTHER = "texaspoker.uilua.chinese.plagernode_other"
COCOSTUDIO_UI_PLAGERNODE_SELF = "texaspoker.uilua.chinese.plagernode_self"
COCOSTUDIO_UI_PLAGERNODE_SITDOWN = "texaspoker.uilua.chinese.plagernode_sitdown"
COCOSTUDIO_UI_PLAGERNODE_VACANCY = "texaspoker.uilua.chinese.plagernode_vacancy"
COCOSTUDIO_UI_PROMPTNODE = "texaspoker.uilua.chinese.promptnode"
COCOSTUDIO_UI_REALTIMESITUATIONMAINNODE = "texaspoker.uilua.chinese.realtimesituationmainnode"
COCOSTUDIO_UI_REALTIMESITUATIONMAINNODE_S8 = "texaspoker.uilua.chinese.realtimesituationmainnode_s8"
COCOSTUDIO_UI_REALTIMESITUATIONNODE = "texaspoker.uilua.chinese.realtimesituationnode"
COCOSTUDIO_UI_REALTIMESITUATIONOTHERNODE = "texaspoker.uilua.chinese.realtimesituationothernode"  
COCOSTUDIO_UI_REALTIMESITUATIONOTHERHEADIMAGENODE = "texaspoker.uilua.chinese.realtimesituationheadimagenode"
COCOSTUDIO_UI_REVIEWCHILDNODE = "texaspoker.uilua.chinese.reviewchildnode"
COCOSTUDIO_UI_REVIEWMAINNODE = "texaspoker.uilua.chinese.reviewmainnode"
COCOSTUDIO_UI_REVIEWMAINNODE_S8 = "texaspoker.uilua.chinese.reviewmainnode_s8"
COCOSTUDIO_UI_SITDOWNBUYNODE = "texaspoker.uilua.chinese.sitdownbuynode"
COCOSTUDIO_UI_SITDOWNBUYNODE_SHORT = "texaspoker.uilua.chinese.sitdownbuynode_short"
COCOSTUDIO_UI_SYSTEMNOTIFYNODE = "texaspoker.uilua.chinese.systemnotifynode"
COCOSTUDIO_UI_TIMETIPSNODE = "texaspoker.uilua.chinese.timetipsnode"
COCOSTUDIO_UI_USERSETTLEMENTDATANODE = "texaspoker.uilua.chinese.usersettlementdatanode"
COCOSTUDIO_UI_WAITNODE = "texaspoker.uilua.chinese.waitnode"
COCOSTUDIO_UI_WATCHNODE = "texaspoker.uilua.chinese.watchnode"
COCOSTUDIO_UI_WEAKTIPSNODE = "texaspoker.uilua.chinese.weaktipsnode"
COCOSTUDIO_UI_SIGNALTIMENODE = "texaspoker.uilua.chinese.signaltimenode"
COCOSTUDIO_UI_SIGNALTIMENODE_I4 = "texaspoker.uilua.chinese.signaltimenode_i4"
COCOSTUDIO_UI_SIGNALTIMENODE_IPAD = "texaspoker.uilua.chinese.signaltimenode_ipad"
COCOSTUDIO_UI_SIGNALTIMENODE_IPHONEX = "texaspoker.uilua.chinese.signaltimenode_iphonex"

COCOSTUDIO_UI_SNGAWARDFINISHNODE = "texaspoker.uilua.chinese.sng.sngawardfinishnode"
COCOSTUDIO_UI_SNGELIMINATEFINISHNODE = "texaspoker.uilua.chinese.sng.sngeliminatefinishnode"
COCOSTUDIO_UI_SNGELIMINATENODE = "texaspoker.uilua.chinese.sng.sngeliminatenode"
COCOSTUDIO_UI_SNGFINISHCHILDNODE = "texaspoker.uilua.chinese.sng.sngfinishchildnode"
COCOSTUDIO_UI_SNGLEAVENODE = "texaspoker.uilua.chinese.sng.sngleavenode"
COCOSTUDIO_UI_SNGMAINMENUNODE = "texaspoker.uilua.chinese.sng.sngmainmenunode"
COCOSTUDIO_UI_SNGMAINMENUNODE_I4 = "texaspoker.uilua.chinese.sng.sngmainmenunode_i4"
COCOSTUDIO_UI_SNGMAINMENUNODE_IPAD = "texaspoker.uilua.chinese.sng.sngmainmenunode_ipad"
COCOSTUDIO_UI_SNGMAINMENUNODE_S8 = "texaspoker.uilua.chinese.sng.sngmainmenunode_s8"
COCOSTUDIO_UI_SNGREALTIMESITUATIONMAINNODE = "texaspoker.uilua.chinese.sng.sngrealtimesituationmainnode"
COCOSTUDIO_UI_SNGREALTIMESITUATIONMAINNODE_S8 = "texaspoker.uilua.chinese.sng.sngrealtimesituationmainnode_s8"
COCOSTUDIO_UI_SNGREALTIMESITUATIONNODE = "texaspoker.uilua.chinese.sng.sngrealtimesituationnode"
COCOSTUDIO_UI_SNGRULESDETAILSCHILDNODE = "texaspoker.uilua.chinese.sng.sngrulesdetailschildnode"
COCOSTUDIO_UI_SNGRULESDETAILSNODE = "texaspoker.uilua.chinese.sng.sngrulesdetailsnode"
COCOSTUDIO_UI_SNGUSERSETTLEMENTDATANODE = "texaspoker.uilua.chinese.sng.sngusersettlementdatanode"
COCOSTUDIO_UI_SNGCONTROLBUYINMSGNODE = "texaspoker.uilua.chinese.sng.sngcontrolbuyinmsgnode"

-- -- 新保险
-- COCOSTUDIO_UI_INSURANCEINFOMAINNODE = "texaspoker.uilua.chinese.insurance.insuranceinfomainnode"
-- COCOSTUDIO_UI_INSURANCEINFOMAINCHILDNODE = "texaspoker.uilua.chinese.insurance.insuranceinfomainchildnode"
-- COCOSTUDIO_UI_INSURANCEINFOCHILDNODE = "texaspoker.uilua.chinese.insurance.insuranceinfochildnode"
-- COCOSTUDIO_UI_INSURANCEBUYINNODE = "texaspoker.uilua.chinese.insurance.insurancebuyinnode"
-- COCOSTUDIO_UI_INSURANCEBUYINOPERATENODE = "texaspoker.uilua.chinese.insurance.insurancebuyinoperatenode"
-- COCOSTUDIO_UI_INSURANCEBUYINCARD = "texaspoker.uilua.chinese.insurance.insurancecardnode"
-- COCOSTUDIO_UI_INSURANCEBUYINTIPS = "texaspoker.uilua.chinese.insurance.insurancebuyintipsnode"
-- COCOSTUDIO_UI_INSURANCEBUYINTIPSCHILDNODE = "texaspoker.uilua.chinese.insurance.insurancebuyintipschildnode"

-- 旧保险
COCOSTUDIO_UI_INSURANCEINFOMAINNODE = "texaspoker.uilua.chinese.insuranceold.insuranceinfomainnode"
COCOSTUDIO_UI_INSURANCEINFOMAINCHILDNODE = "texaspoker.uilua.chinese.insuranceold.insuranceinfomainchildnode"
COCOSTUDIO_UI_INSURANCEINFOCHILDNODE = "texaspoker.uilua.chinese.insuranceold.insuranceinfochildnode"
COCOSTUDIO_UI_INSURANCEBUYINNODE = "texaspoker.uilua.chinese.insuranceold.insurancebuyinnode"
COCOSTUDIO_UI_INSURANCEBUYINOPERATENODE = "texaspoker.uilua.chinese.insuranceold.insurancebuyinoperatenode"
COCOSTUDIO_UI_INSURANCEBUYINCARD = "texaspoker.uilua.chinese.insuranceold.insurancecardnode"
COCOSTUDIO_UI_INSURANCEBUYINTIPS = "texaspoker.uilua.chinese.insuranceold.insurancebuyintipsnode"
COCOSTUDIO_UI_INSURANCEBUYINTIPSCHILDNODE = "texaspoker.uilua.chinese.insuranceold.insurancebuyintipschildnode"
COCOSTUDIO_UI_INSURANCEBUYINCHILDNODE = "texaspoker.uilua.chinese.insuranceold.insurancebuyinchildnode"


COCOSTUDIO_UI_INSURANCEUSERSETTLEMENTDATANODE = "texaspoker.uilua.chinese.insuranceusersettlementdatanode"
COCOSTUDIO_UI_INSURANCEMATCHUSERSETTLEMENTDATANODE = "texaspoker.uilua.chinese.insurancematchusersettlementdatanode"


COCOSTUDIO_UI_COMMONINPUTNODE = "texaspoker.uilua.chinese.commoninputnode"
COCOSTUDIO_UI_OTHERINFONODE_NEW = "texaspoker.uilua.chinese.otherinfonode_new"

COCOSTUDIO_UI_OMAHA_PLAGERNODE_OTHER = "texaspoker.uilua.chinese.plagernode_other_omaha"
COCOSTUDIO_UI_OMAHA_PLAGERNODE_SELF = "texaspoker.uilua.chinese.plagernode_self_omaha"

COCOSTUDIO_UI_KICKOUTTIPSNODE = "texaspoker.uilua.chinese.kickouttipsnode"
COCOSTUDIO_UI_DISMISSTIPSNODE = "texaspoker.uilua.chinese.dismisstipsnode" 

COCOSTUDIO_UI_FACEBUTTONNODE = "texaspoker.uilua.chinese.facebuttonnode" 
COCOSTUDIO_UI_MICROIMAGENODE = "texaspoker.uilua.chinese.microimagenode" 
COCOSTUDIO_UI_MICROPHONENODE = "texaspoker.uilua.chinese.microphonenode" 
COCOSTUDIO_UI_NOTEBUTTONNODE = "texaspoker.uilua.chinese.notebuttonnode" 
COCOSTUDIO_UI_OPERATEBUTTONNODE = "texaspoker.uilua.chinese.operatebuttonnode" 
COCOSTUDIO_UI_REVIEWBUTTONNODE = "texaspoker.uilua.chinese.reviewbuttonnode" 
COCOSTUDIO_UI_SNG_SNGUPBLINDNODE = "texaspoker.uilua.chinese.sng.sngupblindnode" 

COCOSTUDIO_UI_BUYUNIONNODE = "texaspoker.uilua.chinese.buyunionnode"
COCOSTUDIO_UI_SITDOWNBUYUNIONNODE = "texaspoker.uilua.chinese.sitdownbuyunionnode"
COCOSTUDIO_UI_SITDOWNBUYUNIONNODE_SHORT = "texaspoker.uilua.chinese.sitdownbuyunionnode_short"
COCOSTUDIO_UI_BUYUNIONCHILDNODE = "texaspoker.uilua.chinese.buyinchildnode"

COCOSTUDIO_UI_OTHERINFONODE_SELF = "texaspoker.uilua.chinese.otherinfonode_self"

COCOSTUDIO_UI_TURNLOOKBUTTONNODE = "texaspoker.uilua.chinese.turnlookbuttonnode"
COCOSTUDIO_UI_TURNLOOKNODE = "texaspoker.uilua.chinese.turnlooknode"
COCOSTUDIO_UI_TURNLOOKNODE_I4 = "texaspoker.uilua.chinese.turnlooknode_i4"
COCOSTUDIO_UI_TURNLOOKNODE_IPAD = "texaspoker.uilua.chinese.turnlooknode_ipad"
COCOSTUDIO_UI_TURNLOOKNODE_S8 = "texaspoker.uilua.chinese.turnlooknode_s8"

COCOSTUDIO_UI_TRANSITIONNODE = "texaspoker.uilua.chinese.transitionnode"
COCOSTUDIO_UI_TRANSITIONNODE_i4 = "texaspoker.uilua.chinese.transitionnode_i4"
COCOSTUDIO_UI_TRANSITIONNODE_ipad = "texaspoker.uilua.chinese.transitionnode_ipad"
COCOSTUDIO_UI_TRANSITIONNODE_S8 = "texaspoker.uilua.chinese.transitionnode_s8"

--mtt
COCOSTUDIO_UI_MTT_EXITTIPSNODE = "texaspoker.uilua.chinese.mtt.mttexittipsnode"
COCOSTUDIO_UI_MTT_AWARDFINISHNODE = "texaspoker.uilua.chinese.mtt.mttawardfinishnode"
COCOSTUDIO_UI_MTT_NOAWARDFINISHNODE = "texaspoker.uilua.chinese.mtt.mttnoawardfinishnode"
COCOSTUDIO_UI_MTT_GOBACKNODE = "texaspoker.uilua.chinese.mtt.mttgobacknode"
COCOSTUDIO_UI_MTT_REALTIMESITUATIONMAINNODE = "texaspoker.uilua.chinese.mtt.mttrealtimesituationmainnode"
COCOSTUDIO_UI_MTT_REALTIMESITUATIONMAINNODE_S8 = "texaspoker.uilua.chinese.mtt.mttrealtimesituationmainnode_s8"
COCOSTUDIO_UI_MTT_REALTIMESITUATIONTITLENODE = "texaspoker.uilua.chinese.mtt.mttrealtimesituationtitlenode"
COCOSTUDIO_UI_MTT_REALTIMESITUATIONRANKNODE = "texaspoker.uilua.chinese.mtt.mttrealtimesituationranknode"
COCOSTUDIO_UI_MTT_REALTIMESITUATIONRANKCHILDNODE = "texaspoker.uilua.chinese.mtt.mttrealtimesituationrankchildnode"
COCOSTUDIO_UI_MTT_REALTIMESITUATIONPANELNODE = "texaspoker.uilua.chinese.mtt.mttrealtimesituationpanelnode"
COCOSTUDIO_UI_MTT_REALTIMESITUATIONMATCHDATANODE = "texaspoker.uilua.chinese.mtt.mttrealtimesituationmatchdatanode"
COCOSTUDIO_UI_MTT_REALTIMESITUATIONDESKNODE = "texaspoker.uilua.chinese.mtt.mttrealtimesituationdesknode"
COCOSTUDIO_UI_MTT_REALTIMESITUATIONDESKCHILDNODE= "texaspoker.uilua.chinese.mtt.mttrealtimesituationdeskchildnode"
COCOSTUDIO_UI_MTT_REALTIMESITUATIONAWARDNODE= "texaspoker.uilua.chinese.mtt.mttrealtimesituationawardnode"
COCOSTUDIO_UI_MTT_REALTIMESITUATIONAWARDNEXTNODE= "texaspoker.uilua.chinese.mtt.mttrealtimesituationawardnextnode"
COCOSTUDIO_UI_MTT_REALTIMESITUATIONAWARDCHILDNODE= "texaspoker.uilua.chinese.mtt.mttrealtimesituationawardchildnode"
COCOSTUDIO_UI_MTT_REALTIMESITUATIONBLINDNODE= "texaspoker.uilua.chinese.mtt.mttrealtimesituationblindnode"
COCOSTUDIO_UI_MTT_REALTIMESITUATIONBLINDCHILDNODE= "texaspoker.uilua.chinese.mtt.mttrealtimesituationblindchildnode"
COCOSTUDIO_UI_MTT_REALTIMESITUATIONINTRONODE= "texaspoker.uilua.chinese.mtt.mttrealtimesituationintronode"

COCOSTUDIO_UI_MTT_REENTRYTIPSNODE = "texaspoker.uilua.chinese.mtt.mttreentrytipsnode"
COCOSTUDIO_UI_MTT_SIGNUPNODE = "texaspoker.uilua.chinese.mtt.mttsignupnode"
COCOSTUDIO_UI_MTT_STARTPUSHNODE = "texaspoker.uilua.chinese.mtt.mttstartpushnode"
COCOSTUDIO_UI_MTT_STARTPUSHCHILDNODE = "texaspoker.uilua.chinese.mtt.mttstartpushchildnode"
COCOSTUDIO_UI_MTT_WATCHDESKFINISHNODE = "texaspoker.uilua.chinese.mtt.mttwatchdeskfinishnode"
COCOSTUDIO_UI_MTT_WATCHFINISHNODE = "texaspoker.uilua.chinese.mtt.mttwatchfinishnode"

--牌谱
COCOSTUDIO_UI_POKERTEXTINFO_NODE = "texaspoker.uilua.chinese.pokertextinfonode"
COCOSTUDIO_UI_POKERTEXTINFO_NODE_S8 = "texaspoker.uilua.chinese.pokertextinfonode_s8"
COCOSTUDIO_UI_POKERTEXTINFO_NODE_SHORT = "texaspoker.uilua.chinese.pokertextinfonode_short"
COCOSTUDIO_UI_POKERTEXTINFO_NODE_SHORT_S8 = "texaspoker.uilua.chinese.pokertextinfonode_short_s8"
COCOSTUDIO_UI_POKERTEXTINFO_SHOWDOWN_NODE = "texaspoker.uilua.chinese.pokertextinfoshowdownnode"
COCOSTUDIO_UI_POKERTEXTINFO_SHOWDOWN_NODE_SHORT = "texaspoker.uilua.chinese.pokertextinfoshowdownnode_short"
COCOSTUDIO_UI_POKERTEXTINFO_SHOWDOWN_TITLE_NODE = "texaspoker.uilua.chinese.pokertextinfoshowdowntitlenode"
COCOSTUDIO_UI_POKERTEXTINFO_SHOWDOWN_TITLE_NODE_SHORT = "texaspoker.uilua.chinese.pokertextinfoshowdowntitlenode_short"
COCOSTUDIO_UI_POKERTEXTINFO_SHOWDOWN_CHILD_NODE = "texaspoker.uilua.chinese.pokertextinfoshowdownchildnode"
COCOSTUDIO_UI_POKERTEXTINFO_SHOWDOWN_CHILD_NODE_SHORT = "texaspoker.uilua.chinese.pokertextinfoshowdownchildnode_short"
COCOSTUDIO_UI_POKERTEXTINFO_INSURANCE_NODE = "texaspoker.uilua.chinese.pokertextinfoinsurancenode"
COCOSTUDIO_UI_POKERTEXTINFO_STATE_NODE = "texaspoker.uilua.chinese.pokertextinfostatenode"
COCOSTUDIO_UI_POKERTEXTINFO_STATE_CHILD_NODE = "texaspoker.uilua.chinese.pokertextinfostatechildnode"
COCOSTUDIO_UI_POKERTEXTINF_BUTTON_NODE = "texaspoker.uilua.chinese.pokertextinfobuttonnode"

--个人设置
COCOSTUDIO_UI_SETTING_NODE = "texaspoker.uilua.chinese.settingnode"
COCOSTUDIO_UI_SETTING_SELF_NODE = "texaspoker.uilua.chinese.settingselfnode"
COCOSTUDIO_UI_SETTING_SELF_POT_CHILD_NODE = "texaspoker.uilua.chinese.settingselfraisepotchildnode"
COCOSTUDIO_UI_SETTING_ADVANCE_NODE = "texaspoker.uilua.chinese.settingadvancenode"

--弹幕
COCOSTUDIO_UI_BULLETSCREEN_BUTTON_NODE = "texaspoker.uilua.chinese.bulletbuttonnode"
COCOSTUDIO_UI_BULLETSCREEN_NODE = "texaspoker.uilua.chinese.bulletscreennode"
COCOSTUDIO_UI_BULLETSCREEN_CHILD_NODE = "texaspoker.uilua.chinese.bulletscreenchildnode"
COCOSTUDIO_UI_BULLETSCREEN_CHILD_TEXT_NODE = "texaspoker.uilua.chinese.bulletscreentextnode"

--UI文本内容------------------------------------------------------
    STR_ADVANCEDSETTINGS_OPTIONSTR = "房主功能"
    STR_ADVANCEDSETTINGS_BUYINSTR = "设置玩家可以补充记分牌的倍数"
    STR_ADVANCEDSETTINGS_BUYINCTRLSTR = "控制玩家带入"
    STR_ADVANCEDSETTINGS_PAUSESTR = "牌局暂停"
    STR_ADVANCEDSETTINGS_DISMISSSTR = "解散牌局"
    STR_ADVANCEDSETTINGS_NOSAVETEXT = "保存"
    STR_ADVANCEDSETTINGS_SAVEDTEXT = "已保存"
    STR_ADVANCEDSETTINGS_SETTIMETEXT = "设置玩家思考时长(下一手生效)"
    STR_ADVANCEDSETTINGS_STRADDLE_TEXT = "强制盲注"
    STR_ADVANCEDSETTINGS_PUSHTEXT = "消息推送"

    STR_BUYNODE_BUYINSTR = "补充记分牌"
    STR_BUYNODE_BUYTIPSSTR = "在下一手开始时，将为你补充所购记分牌"
    STR_BUYNODE_BUYSTR = "带入记分牌"
    STR_BUYNODE_COINSSTR = "财富额："
    STR_BUYNODE_FEESTR = "记录费："
    STR_BUYNODE_BUYBUTTON_STR  = "确定买入"
    STR_BUYNODE_NOTIFYTIPS_STR = "通知所属俱乐部"

    STR_CASHOUT_TITLE = "带出记分牌"
    STR_CASHOUT_CONTENT01 = "本手结束时，将为您带出对应的记分牌"
    STR_CASHOUT_CONTENT02 = "带出记分牌"
    STR_CASHOUT_CONTENT03 = "牌局开始后，将为您带出对应的记分牌"
    STR_CASHOUT_CONFIRM = "确认带出"
    STR_CASHOUT_TIPS_ALREADY = "本手已带出过记分牌！"
    
    STR_CASHOUT_SUCCESS = "成功带出%d记分牌！"
    STR_CASHOUT_NOT_ENOUGH = "记分牌不足！"
    STR_CASHOUT_FAIL = "记分牌不足！"

    STR_CHECKPROMPTNODE_TIPSSTR = "提示"
    STR_CHECKPROMPTNODE_TIPSSTR01 = "当前您可以选择看牌,"
    STR_CHECKPROMPTNODE_TIPSSTR02 = "您确定要弃牌?"
    STR_CHECKPROMPTNODE_HIDETIPSSTR = "不再提示"
    STR_CHECKPROMPTNODE_CHECKBUTTON_STR = "看牌"
    STR_CHECKPROMPTNODE_FOLDBUTTON_STR = "弃牌"

    STR_COMMONINPUTNODE_NEW_TAGSTR = "打法标记"
    STR_COMMONINPUTNODE_NEW_CANCELTEXT = "取消"
    STR_COMMONINPUTNODE_NEW_SAVETEXT = "保存"
    STR_COMMONINPUTNODE_PLACEHODER_REMARK_TEXT = "请编辑玩家备注"
    STR_COMMONINPUTNODE_PLACEHODER_TAG_TEXT = "请编辑打法标记"
    STR_COMMONINPUTNODE_NEW_REMARKSTR = "备注名"

    STR_ERRORNODE_TIPSSTR = "温馨提示"
    STR_ERRORNODE_CANCELSTR = "取消"
    STR_ERRORNODE_CANCELSTR_NEW = "知道了"

    STR_FACEPAG_INFOTEXT  = "默认"
    STR_FACEPAG_INFOTEXT1 = "魔法表情 (20"
    STR_FACEPAG_INFOTEXT2 = "/次)"

    STR_GOTOSHOPNODE_TIPSSTR = "温馨提示"
    STR_GOTOSHOPNODE_CANCELTEXT = "取消"
    STR_GOTOSHOPNODE_OKTEXT = "购买德州币"

    STR_INSURANCEMATCHUSERSETTLEMENTDATANODE_NAMETEXT = "保险池"
    STR_INSURANCEUSERSETTLEMENTDATANODE_NAMETEXT = "保险池"

    STR_KICKOUTTIPSNODE_TIPSTEXT01 = "玩家被踢出后无法再加入"
    STR_KICKOUTTIPSNODE_TIPSTEXT02 = "建议先暂停牌局沟通"
    STR_KICKOUTTIPSNODE_PAUSETBUTTON = "暂停牌局"
    STR_KICKOUTTIPSNODE_KICKBUTTON = "确定踢出"

    STR_MAINSCENE_STARTSTATETEXT = "等待下一手"

    STR_MATCHSTATISTICSNODE_NICKNAMESTR = "昵称"
    STR_MATCHSTATISTICSNODE_BUYINSTR = "带入"
    STR_MATCHSTATISTICSNODE_WONSTR = "积分"
    STR_MATCHSTATISTICSNODE_RESULTSTR = "个人战绩"
    STR_MATCHSTATISTICSNODE_TITLESTR = "牌局统计"
    STR_MATCHSTATISTICSNODE_TOTALHANDSTR = "本局总手数"
    STR_MATCHSTATISTICSNODE_MAXPOTSTR = "本局最大底池"
    STR_MATCHSTATISTICSNODE_TOTALBUYSTR = "本局总带入"
    STR_MATCHSTATISTICSNODE_MVP = "MVP"
    STR_MATCHSTATISTICSNODE_BOSS = "土豪"
    STR_MATCHSTATISTICSNODE_FISH = "大鱼"

    STR_OTHERINFONODE_NEW_REMARKTEXT = "备注标记"
    STR_OTHERINFONODE_NEW_NILTEXT = "备注名和打法标记"
    STR_OTHERINFONODE_NEW_VOICETEXT = "语音回放"
    STR_OTHERINFONODE_NEW_ADDTEXT = "添加好友"
    STR_OTHERINFONODE_NEW_KICKTEXT = "踢出牌局"
    STR_OTHERINFONODE_NEW_STANDUPTEXT = "强制站起"
    STR_OTHERINFONODE_NEW_MATCHSTR = "牌局数"
    STR_OTHERINFONODE_NEW_HANDSTR = "总手数"
    STR_OTHERINFONODE_NEW_POOLSTR = "入池率"
    STR_OTHERINFONODE_NEW_WINSTR = "翻前加注率"
    STR_OTHERINFONODE_PROFITSTR = "盈亏"
    STR_OTHERINFONODE_ALLINWINSTR = "Allin胜率"
    STR_OTHERINFONODE_SNGMATCHSTR = "参赛数"
    STR_OTHERINFONODE_SNGCHAMPIONSTR = "冠军数"
    STR_OTHERINFONODE_SNGSECONDSTR = "亚军数"
    STR_OTHERINFONODE_SNGTHIRDSTR = "季军数"
    STR_OTHERINFONODE_MTTCHAMPIONSTR = "冠军数"
    STR_OTHERINFONODE_MTTFIRSTTHREESTR = "前3数"
    STR_OTHERINFONODE_MTTBONUSSTR = "奖励圈数"
    STR_OTHERINFONODE_NICKNAMESTR = "昵称:"

    STR_OTHERINFOSELFNODE_TIPSSTR = "30日普通局数据"
    STR_OTHERINFOSELFNODE_SNGTIPSSTR = ""

    STR_REALTIMESITUATIONNODE_NICKNAMESTR = "昵称"
    STR_REALTIMESITUATIONNODE_BUYINSTR = "带入"
    STR_REALTIMESITUATIONNODE_RESULTSTR = "积分"

    STR_REALTIMESITUATIONOTHERNODE_WATCHSTR = "看客"

    STR_REVIEWMAINNODE_REVIEWSTR = "全局回顾"

    STR_SITDOWNBUYNODE_BLINDSTR = "小盲/大盲"
    STR_SITDOWNBUYNODE_BUYINSTR = "带入记分牌"
    STR_SITDOWNBUYNODEE_COINSSTR = "财富额:"
    STR_SITDOWNBUYNODE_FEESTR = "记录费:"
    STR_SITDOWNBUYNODE_BUYBUTTON = "加入牌局"
    STR_SITDOWNBUYNODE_NOTIFYTIPS_STR = "通知所属俱乐部"

    STR_SITDOWNBUYNODE_BLINDSTR_SHORT = "前注"

    STR_INSURANCEBUYINCHILDNODE_PAYSTR = "支付"
    STR_INSURANCEBUYINCHILDNODE_CLAIMSTR = "赔付"
    STR_INSURANCEBUYINCHILDNODE_OUTSTR = "补牌"
    STR_INSURANCEBUYINCHILDNODE_ODDSTR = "赔率"

    STR_INSURANCEBUYINNODE_PASSSTR = "放弃"

    STR_INSURANCEBUYINOPERATENODE_STATETEXT = "保本"
    STR_INSURANCEBUYINOPERATENODE_INPUTTEXT = "投保额"
    STR_INSURANCEBUYINOPERATENODE_RAISEENDENDTEXT = "最大值"
    STR_INSURANCEBUYINOPERATENODE_STATEIMAGETEXT = "-保本"
    STR_INSURANCEBUYINOPERATENODE_RAISEENDIMAGEBUTTON = "最大值"
    STR_INSURANCEBUYINOPERATENODE_CHARGETEXT = "赔付额"
    STR_INSURANCEBUYINOPERATENODE_ODDSTEXT = "赔率"
    STR_INSURANCEBUYINOPERATENODE_COMCARDSTR = "公共牌"
    STR_INSURANCEBUYINOPERATENODE_HANDSCARDSTR = "手牌"
    STR_INSURANCEBUYINOPERATENODE_PLAYERCARDSTR = "对方手牌"
    STR_INSURANCEBUYINOPERATENODE_OUTSSTR = "OUTS"
    STR_INSURANCEBUYINOPERATENODE_SPLITOUTSSTR = "分池 OUTS"
    STR_INSURANCEBUYINOPERATENODE_PREMIUMONSSTR = "背保险投保额"
    STR_INSURANCEBUYINOPERATENODE_ODDSONSSTR = "背保险赔率"
    STR_INSURANCEBUYINOPERATENODE_SELECTALLSTR = "全选"

    STR_SNGAWARDFINISHNODE_TITLE_ELIMINATE = "遗憾出局"
    STR_SNGAWARDFINISHNODE_SHARESTR = "牌技这么牛，赶快炫耀一下吧！"
    STR_SNGAWARDFINISHNODE_PLACESTR = "名次"
    STR_SNGAWARDFINISHNODE_NICKNAMESTR = "昵称"
    STR_SNGAWARDFINISHNODE_REWARDSTR = "奖励"
    STR_SNGAWARDFINISHNODE_SHOWOFFBUTTON_STR = "炫耀一下"

    STR_SNGELIMINATEFINISHNODE_TITLESTR = "比赛已结束"
    STR_SNGELIMINATEFINISHNODE_PLACESTR = "名次"
    STR_SNGELIMINATEFINISHNODE_NICKNAMESTR = "昵称"
    STR_SNGELIMINATEFINISHNODE_REWARDSTR = "奖励"
    STR_SNGELIMINATEFINISHNODE_RANKSTR01 = "第"
    STR_SNGELIMINATEFINISHNODE_RANKSTR02 = "名"
    STR_SNGELIMINATEFINISHNODE_RANKAWARDSTR = "奖金:"

    STR_SNGELIMINATENODE_STAYBUTTON_STR = "留下旁观"
    STR_SNGELIMINATENODE_EXITBUTTON_STR = "退出牌局"
    STR_SNGELIMINATENODE_RANKSTR01 = "第"
    STR_SNGELIMINATENODE_RANKSTR02 = "名"

    STR_SNGLEAVENODE_CANCELTEXT = "取消"
    STR_SNGLEAVENODE_OKTEXT = "继续离开"
    STR_SNGCONTROLBUYINMSG_STR = "新牌局消息"

    STR_SNGMAINSCENE_STARTSTATETEXT = "等待下一手"

    STR_SNGREALTIMESITUATIONNODE_PLACESTR = "排名"
    STR_SNGREALTIMESITUATIONNODE_NICKNAMESTR = "昵称"
    STR_SNGREALTIMESITUATIONNODE_RESULTSTR = "记分牌"

    STR_SNGRULESDETAILSNODE_LEVELSTR = "级别"
    STR_SNGRULESDETAILSNODE_BLINDSTR = "盲注"

    STR_INSURANCEINFOMAINCHILDNODE_TITLESTR = "保险说明"
    STR_INSURANCEINFOMAINCHILDNODE_OMAHA_TITLESTR = "保险说明"
    STR_INSURANCEINFOMAINCHILDNODE_INTROSTR01 = "概述"
    STR_INSURANCEINFOMAINCHILDNODE_INTROSTR02 = "操作"
    STR_INSURANCEINFOMAINCHILDNODE_INTROSTR03 = "赔率"
    STR_INSURANCEINFOMAINCHILDNODE_BODYSTR01 = [[1 . 当牌局中玩家全部All in之后，由当前牌型最大的玩

家，获得购买的机会并弹出保险购买操作提示。

2 . 保险超过14个补牌不激活。

3 . 当保险涉及的底池中超过3个玩家的时候，保险不激活

（2人或者3人时可以买保险）。

4 . 造成玩家平分的补牌不会计入购买保险的补牌数量，如

果河牌存在平分补牌 ，那么玩家购买保险的总额不会超过他

向底池内投入的总额。

5 . 存在多个底池时，可以选择一个或多个参与的底池购买

保险。

6 . 牌桌内“实时战绩”和“上局回顾“中均有保险数据显

示，且战绩中会增加保险数据显示。

7 . 翻牌三张不可购买保险，转牌保险投保额不得

超过0.25*底池，河牌保险投保额不得超过0.5*底池。

8. 如果购买了转牌的保险，那么系统会强制玩家购买

河牌的少量保险，背回转牌的保险投入。

]]
    STR_INSURANCEINFOMAINCHILDNODE_BODYSTR02 = [[1 . 保本：保险赔付额=玩家投入金额。

2 . 点击底池按钮可以展开滑动条，选择需要购买的保险金

额。

3 . 确定好保险金额后，点击购买按钮，即成功购买保险。

4 . 存在多个底池时，每个底池均可以分别操作购买。

5 . 玩家也可以点击全部保本来快速购买所有保险。

6 . 购买保险消耗的德扑币从底池中扣除，如果买中，系统

会根据赔率，直接赔付到玩家手中；如果没中，则系统收走

购买保险消耗的德扑币。

    ]]
    STR_INSURANCEINFOMAINCHILDNODE_OMAHA_BODYSTR01 = [[1 . 奥马哈保险只会在牌桌人数小于等于6人时激活。

2 .	当牌局中玩家全部All in之后，由当前牌型最大的玩家获

得购买的机会，并弹出保险购买操作提示。

3 .	保险超过14补牌不激活。

4 .	当保险涉及的底池中超过3个玩家的时候，保险不激活。

（2人或者3人时可以买保险。）

5 .	造成玩家平分的补牌不会计入购买保险的补牌数量，如果

河牌存在平分补牌 ，那么玩家购买保险的总额不会超过他向

底池内投入的总额。

6 .	存在多个底池时，可以选择一个或多个参与的底池购买保险。

7 .	牌桌内“实时战绩”和“上局回顾“中均有保险数据显示，且

战绩中会增加保险数据显示

8 .	翻牌三张不可购买保险，Turn牌保险投保额不得超过

0.25*底池，River保险投保额不得超过0.5*底池。

9 .	如果购买了Turn牌的保险，那么系统会强制玩家购买

River牌的少量保险，背回Turn牌的保险投入。

]]

STR_INSURANCEINFOMAINCHILDNODE_OMAHA_BODYSTR02 = [[1 . 保本：保险赔付额=玩家投入金额。

2 . 点击底池按钮可以展开滑动条，选择需要购买的保险金

额。

3 . 确定好保险金额后，点击购买按钮，即成功购买保险。

4 . 存在多个底池时，每个底池均可以分别操作购买。

5 . 玩家也可以点击全部保本来快速购买所有保险。

6 . 购买保险消耗的德扑币从底池中扣除，如果买中，系统

会根据赔率，直接赔付到玩家手中；如果没中，则系统收走

购买保险消耗的德扑币。

    ]]

    STR_MICROPHONEPAG_SEND_TIPSTEXT = "手指上滑 取消发送"
    STR_MICROPHONEPAG_CANCEL_TIPSTEXT = "松开手指 取消发送"
    STR_MICROPHONEPAG_SENDED_TIPSTEXT = "已发送"

    STR_DISMISSTIPSPAG_TIPSTEXT = "确定提前结束牌局"
    STR_CANCELBUTTON_STR = "取消"
    STR_OKBUTTON_STR = "确定"
    STR_FORCESTAND_TIPSTEXT = "玩家将被强制站起，是否确认"

    STR_FANFANKAN_TITLE_TEXT = "凡有所相，皆是虚妄"
    STR_TURNLOOK_TITLE_FLOP_TEXT = "打赏看翻牌"
    STR_TURNLOOK_TITLE_TURN_TEXT = "打赏看转牌"
    STR_TURNLOOK_TITLE_RIVER_TEXT = "打赏看河牌"
    STR_TURNLOOK_TIPS_TEXT = "仅供娱乐"
    STR_TURNLOOK_NOENOUGHCOIN_WEAKTIPS_TEXT = "德扑币不足，无法看牌"
    STR_TURNLOOK_NOTRIGHTTIME_WEAKTIPS_TEXT = "不是看牌时间"

    STR_SNG_UPBLIND_TITLE_TEXT = "升盲倒计时"

    --mtt 死文本简繁英
    STR_MTT_REENTRY_TIPS = "不再提示此类消息"
    STR_MTT_SHAREIT_BUTTON_TITLE = "炫耀一下"
    STR_MTT_EXIT_BUTTON_TITLE = "退出比赛"
    STR_MTT_CHANGETABLE_BUTTON_TITLE = "切换牌桌"
    STR_MTT_FINISH_NOAWARD_TITLE = "您已经被淘汰，请下次再战"
    STR_MTT_EXITTIPS_TITLE = [[退出比赛，系统将替您托管牌局 

您可随时返回牌局]]
    STR_MTT_SIGNUP_SIGN_TEXT = "报名:"
    STR_MTT_SIGNUP_TICKET_TEXT = "条件:"

    STR_MTT_REALTIMES_MATCH_SCORE_TEXT = "记分牌平均值"
    STR_MTT_REALTIMES_MATCH_NEXTTIME_TEXT = "下一级别时长"
    STR_MTT_REALTIMES_MATCH_BLINDTIME_TEXT = "涨盲剩余时间"
    STR_MTT_REALTIMES_MATCH_CURBLIND_TEXT = "当前盲注"
    STR_MTT_REALTIMES_MATCH_NEXTLEVEL_TEXT = "下一级别"
    STR_MTT_REALTIMES_MATCH_PLAYERNUM_TEXT = "玩家人数"
    STR_MTT_REALTIMES_MATCH_USEDTIME_TEXT = "比赛已用时"

    STR_MTT_REALTIMES_REENTRY_TEXT = "自动重进"
    STR_MTT_REALTIMES_UPDATE_TEXT = "刷新"
    STR_MTT_REALTIMES_PAGE_TITLE_TEXT01 = "赛况"
    STR_MTT_REALTIMES_PAGE_TITLE_TEXT02 = "牌桌"
    STR_MTT_REALTIMES_PAGE_TITLE_TEXT03 = "奖励"
    STR_MTT_REALTIMES_PAGE_TITLE_TEXT04 = "盲注"
    STR_MTT_REALTIMES_PAGE_TITLE_TEXT05 = "概况"
    STR_MTT_REALTIMES_RANK_TITLE_TEXT = "实时排名"
    STR_MTT_REALTIMES_RANK_TITLE_DESK_TEXT = "牌桌"
    STR_MTT_REALTIMES_RANK_TITLE_SCORE_TEXT = "积分"
    STR_MTT_REALTIMES_RANK_TITLE_BLIND_TEXT = "大盲数"
    STR_MTT_REALTIMES_DESK_TITLE_DESKNUM_TEXT = "桌号"
    STR_MTT_REALTIMES_DESK_TITLE_PLAYERNUM_TEXT = "人数"
    STR_MTT_REALTIMES_DESK_TITLE_STACK_TEXT = "记分牌"
    STR_MTT_REALTIMES_AWARD_TITLE_PRIZEPOOL_TEXT = "总奖池:"
    STR_MTT_REALTIMES_AWARD_TITLE_ITM_TEXT = "奖励圈:"
    STR_MTT_REALTIMES_AWARD_TITLE_NEXTPRIZE_TEXT = "下一个奖励:"
    STR_MTT_REALTIMES_BLIND_TITLE_LEVEL_TEXT = "级别"
    STR_MTT_REALTIMES_BLIND_TITLE_BLIND_TEXT = "盲注"
    STR_MTT_REALTIMES_BLIND_TITLE_ANTE_TEXT = "前注"
    STR_MTT_REALTIMES_BLIND_TITLE_BLINDTIME_TEXT = "涨盲时间"

    STR_MTT_MAINSCENE_START_TIPS_TEXT = "距比赛开始"
    STR_MTT_GOBACK_BUTTON_TITLE_TEXT = "返回牌局"

    MAINSCENE_START_BUTTON_TEXT = "开始"
    MAINSCENE_SHARE_BUTTON_TEXT = "分享"

    --UI设置控件---------
    IMAGE_MATCHSTATISTICSNODE_OMAHALOGOIMAGE = "game/game_layer/cn/matchstatistics/omahagame_logo.png"
    IMAGE_MATCHSTATISTICSNODE_INSURANCEIMAGE = "game/game_layer/common/insurance/insurance_baoxianju.png"
    IMAGE_MATCHSTATISTICSNODE_SHORTDUCKLOGOIMAGE = "game/game_layer/cn/matchstatistics/shortduck_logo.png"

    IMAGE_SNGMAINMENUNODE_RULESDETAILSIMAGE = "game/game_layer/common/sng/sng_time.png"

--    IMAGE_INSURANCEINFOMAINCHILDNODE_TIPSIMAGE = "game/game_layer/common/insurance/insurance_info_odds.png"
--    IMAGE_INSURANCEINFOMAINCHILDNODE_OMAHA_TIPSIMAGE = "game/game_layer/common/insurance/omaha_insurance_info_odds.png"


    --根据主题不同，替换按钮图
    PLAYER_SELF_OPERATE_FREE_RAISE_BUTTON_ICON = "game/game_layer/common/ic_operate_blue_big.png"
    PLAYER_SELF_OPERATE_FREE_RAISE_BUTTON_SELECTED_ICON = "game/game_layer/common/ic_operate_blue_big_press.png"
    PLAYER_SELF_OPERATE_POT_AND_BLIND_BUTTON_ICON = "game/game_layer/common/ic_operate_blue_small.png"
    PLAYER_SELF_OPERATE_POT_AND_BLIND_BUTTON_PRESSED_ICON = "game/game_layer/common/ic_operate_blue_small_press.png"

    STR_PLAYER_SELF_FREERAISE_BUTTON_TITLE_TEXT = "自由加注"
    STR_PLAYER_SELF_ENSURE_BUTTON_TITLE_TEXT = "确认"
    STR_PLAYER_SELF_CHECK_BUTTON_TITLE_TEXT = "看牌"
    STR_PLAYER_SELF_CALL_BUTTON_TITLE_TEXT = "跟注"
    STR_PLAYER_SELF_FOLD_BUTTON_TITLE_TEXT = "弃牌"
    STR_PLAYER_SELF_ALLIN_BUTTON_TITLE_TEXT = "Allin"
    STR_PLAYER_SELF_BLIND_BUTTON_TITLE_TEXT = "大盲"
    STR_PLAYER_SELF_ANTE_BUTTON_TITLE_TEXT = "前注"
    STR_PLAYER_SELF_POT_BUTTON_TITLE_TEXT = "底池"
    STR_PLAYER_SELF_AUTO_CHECK_CHECKBOX_TITLE_TEXT = "自动看牌"
    STR_PLAYER_SELF_AUTO_CALL_CHECKBOX_TITLE_TEXT = "自动跟注"
    STR_PLAYER_SELF_AUTO_QUIT_CHECKBOX_TITLE_TEXT = "看牌/弃牌"

    STR_PLAYER_EMPTY_TITLE_TEXT = "空位"
    STR_PLAYER_OPEN_TITLE_TEXT = "坐下"

    STR_PLAYER_CANCEL_DELEGATE_TEXT = "返回牌局"
    STR_PLAYER_SITDOWN_BACK_TEXT = "回到座位"

    --公用底层按钮 有2种
    COMMON_BACKIMAGE_BUTTON_NORMAL_IMAGE = "game/game_layer/common/btn_blank-i6p.png"
    COMMON_BACKIMAGE_BUTTON_MASK_IMAGE = "game/game_layer/common/dark.png"
    STR_SHORT_POKER_TYPE_PATH = "game/game_layer/common/prompt/ic_prompt_image%d.png"
    
    --牌型提示牌型文字
    STR_PROMPT_RULES_TEXT_LIST = {}
    STR_PROMPT_RULES_TEXT_LIST[1] = "皇家同花顺"
    STR_PROMPT_RULES_TEXT_LIST[2] = "同花顺"
    STR_PROMPT_RULES_TEXT_LIST[3] = "四条"
    STR_PROMPT_RULES_TEXT_LIST[4] = "葫芦"
    STR_PROMPT_RULES_TEXT_LIST[5] = "同花"
    STR_PROMPT_RULES_TEXT_LIST[6] = "顺子"
    STR_PROMPT_RULES_TEXT_LIST[7] = "三条"
    STR_PROMPT_RULES_TEXT_LIST[8] = "两对"
    STR_PROMPT_RULES_TEXT_LIST[9] = "一对"
    STR_PROMPT_RULES_TEXT_LIST[10] = "高牌"


    STR_OTHERINFO_GPS_POS_TEXT = "距离 "
    STR_OTHERINFO_GPS_NO_POS_TEXT = "未开启定位"

--G_LANGUAGE_CHINESE_CNS = 3 --繁体中文

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


  --MICROPHONE_CANCER_ICON = "game/game_layer/common/pic_mic_cancer-i6p_fanti.png", --语音按下发送
  --MICROPHONE_PRESSED_ICON = "game/game_layer/common/pic_mic_pressed-i6p_fanti.png", --语音按上滑取消发送
  MICROPHONE_CANCER_ICON = "game/game_layer/common/record_cancel_tips.png", --语音按上滑取消发送
  MICROPHONE_PRESSED_ICON = "game/game_layer/common/record_tipsbg.png", --语音按下发送
  MICROPHONE_PRESSED_VOICE_ICON = "game/game_layer/common/microphone/record_voice_%d.png", --语音大小状态图片

 
  ROUND_DICHI_ICON = "game/game_layer/pic_round_dichi-i6p.png",--胜率进度条
  
  ROUND_RUCHI_ICON = "game/game_layer/pic_round_ruchi-i6p.png",--入池率进度条

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
    USER_STATE_TEXT_FOLD = "棄牌",
    USER_STATE_TEXT_CALL = "跟注",
    USER_STATE_TEXT_RAISE = "加注",
    USER_STATE_TEXT_ALLIN = "ALLIN",
    USER_STATE_TEXT_YANSHI = "延時",
    USER_STATE_TEXT_WAIT = "等待",
    USER_STATE_TEXT_STRADDLE = "Straddle",
}


MAINSCENE_BG_IMAGE = "game/game_layer/common/desktop_background_4.png" --桌面主题背景

--MAINSCENE_BG_TEXT_COLOR = cc.c3b(31,45,80) --桌面主题背景 文字颜色
MAINSCENE_BG_TEXT_COLOR = cc.c3b(255,255,255)
MAINSCENE_BG_TEXT_OPACITY = 0.4 * 255

POKER_CT_NAME={}
POKER_CT_NAME[CT_SINGLE]=[[高牌]]
POKER_CT_NAME[CT_ONE_LONG]=[[壹對]]
POKER_CT_NAME[CT_TWO_LONG]=[[兩對]]
POKER_CT_NAME[CT_THREE_TIAO]=[[三條]]
POKER_CT_NAME[CT_SHUN_ZI]=[[順子]]
POKER_CT_NAME[CT_TONG_HUA]=[[同花]]
POKER_CT_NAME[CT_HU_LU]=[[葫蘆]]
POKER_CT_NAME[CT_TIE_ZHI]=[[四條]]
POKER_CT_NAME[CT_TONG_HUA_SHUN]=[[同花順]]
POKER_CT_NAME[CT_KING_TONG_HUA_SHUN]=[[皇家
同花順]]


--operation
STR_OPERATION_TEXT_MENU = "菜單"
STR_OPERATION_TEXT_SHARE_GAME = "牌局分享"
STR_OPERATION_TEXT_STAND_UP = "站起圍觀"
STR_OPERATION_TEXT_OPTIONS = "牌局設置"
STR_OPERATION_TEXT_POKER_HANDS_HINTS = "牌型提示"
STR_OPERATION_TEXT_CHANGE_CARD_COLOUR = "切換四色牌"
STR_OPERATION_TEXT_CHANGE_CARD_COLOUR_CLASSIC = "切換經典牌"
STR_OPERATION_TEXT_TEMPORARILYLEAVE = "留座離桌"
STR_OPERATION_TEXT_HELPER = "託管牌局"
STR_OPERATION_TEXT_INSURANCE_HINTS = "保險說明"
STR_OPERATION_TEXT_BUY_IN = "補充記分牌"
STR_OPERATION_TEXT_CASH_OUT = "帶出記分牌"
STR_OPERATION_TEXT_GO_TO_SHOP = "遊戲商城"
STR_OPERATION_TEXT_EXIT_GAME = "退出牌局"

STR_OPERATION_TEXT_REWARD_RULES = "規則獎勵"
STR_OPERATION_TEXT_LEAVE_GAME = "離開比賽"

--mtt
STR_OPERATION_TEXT_MTT_SIGNUP = "報名比賽"
STR_OPERATION_TEXT_MTT_LEAVE_GAME = "離開比賽"

--STR_TEXT_POKER_LOTTERYBACKGROUND = "minigame/pokermachine/game/game_layer/common/desktop_background_i6.png"

--文字文本
STR_TEXT_DEFAULT = ""
STR_TEXT_WAIT = "等待"
STR_TEXT_FREE = "免費"
STR_TEXT_NOT_ENOUGH = "不足"
STR_TEXT_ADD_FRIEND_HINT = "Dear偶像，加個好友壹起愉快滴玩耍唄！"
STR_TEXT_VOICE_CANCEL = "松開確定取消"
STR_TEXT_VOICE_SEND = "上滑取消發送"
STR_TEXT_ROOM_NAME = "* %s *"
STR_TEXT_ROOM_BLINDS_STR = "盲注"
STR_TEXT_ROOM_BLINDS = " %d/%d"
STR_TEXT_ROOM_ANTE_BLINDS = " %d/%d (%d)"
STR_TEXT_ROOM_SHORTDUCK_ANTE = "前注: "
STR_TEXT_ROOM_SHORTDUCK_STRAIGHT = "  順子>三條"
STR_TEXT_ROOM_SHORTDUCK_THREE = "  三條>順子"
STR_TEXT_ROOM_SHORTDUCK_ANTE_TWO = "莊位2倍前注"
STR_TEXT_ROOM_SHORTDUCK_HOLD_MIN = "最小保留記分牌數: "
STR_TEXT_ROOM_INVITE = "邀請碼: "
STR_TEXT_ROOM_CONTROLINTO = "帶入確認"
STR_TEXT_ROOM_INSURANCE = "保險"
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

STR_TEXT_WAITTING_1 = [[綠色德州,競技體育
等待房主開局]]
STR_TEXT_WAITTING_2 = [[德撲，朋友間的樂趣
等待房主開局]]
STR_TEXT_WAITTING_3 = [[嚴禁賭博,違者封號
等待房主開局]]
STR_TEXT_WAITTING_4 = [[請選擇座位坐下]]

STR_TEXT_WAITTING_5 = [[ ..]]
STR_TEXT_WAITTING_6 = [[. .]]
STR_TEXT_WAITTING_7 = [[.. ]]

STR_TEXT_GO_TO_SHOP_COIN_TEXT = "德撲幣不足，請購買"
STR_TEXT_GO_TO_SHOP_COIN_BUTTON_TEXT = "購買德撲幣"
STR_TEXT_GO_TO_SHOP_DIAMOND_TEXT = "鑽石不足，請購買"
STR_TEXT_GO_TO_SHOP_DIAMOND_BUTTON_TEXT = "購買鑽石"


LODING_ANIMATE_IMAGE = "loading/loading_000%d@2x.png"
WIN_ANIMATE_IMAGE = "game/game_layer/common/you_win/anim_youwin%d-i6p.png"

STR_TEXT_TIME_TIPS_5 = "牌局將在5分鍾後結束"
STR_TEXT_TIME_TIPS_1 = "牌局將在1分鍾後結束"

STR_TEXT_REVIEW_POKER_TYPE_TEXT = "棄牌"
STR_TEXT_REVIEW_COLLECTION_NUM_TEXT = "%d/%d"

STR_TEXT_CONTROL_ENABLE_TIPS = "房主已打開帶入申請"
STR_TEXT_CONTROL_DISABLE_TIPS = "房主已關閉帶入申請"
STR_TEXT_CONTROL_DENY_TIPS = [[您的請求買入
被房主拒絕]]

STR_TEXT_CONTROL_DENY = "拒絕%ds"

STR_TEXT_CONTROL_ENABLE_WAITTING = [[請求房主帶入同意中
請等待%ds...]]

STR_TEXT_PAUSE_TIPS_TEXT = "牌局暂停中"
STR_TEXT_PAUSE_WAITTING = [[請等待%s...]]

STR_TEXT_SIT_DOWN_OTHER_USER_BUYIN_WAITTING = "請求中%ds"

STAND_PLAYER_PLAY_SOUND_IMAGE = "game/game_layer/common/sound_others_%d@2x.png"

STR_TEXT_ADD_FRIEND_SEND_TIPS = "發送成功"
STR_TEXT_COLLECTION_TIPS = "已收藏"
STR_TEXT_COLLECTION_FAULT_TIPS = "收藏失敗"
STR_TEXT_REMOVE_COLLECTION_TIPS = "取消收藏"
STR_TEXT_REMOVE_COLLECTION_FAULT_TIPS = "取消收藏失敗"

STR_TEXT_REMARK_TIPS = "輸入字數超出限制"

STR_TEXT_STANDBY_NUM_TEXT = "%d人"
---sng
STR_TEXT_SNG_RULESDETAILS_RANK_TEXT = "當前："

STR_TEXT_SNG_ROOM_BLINDS = "人局  "
STR_TEXT_SNG_ROOM_BLINDS_END = "盲注 "
STR_TEXT_SNG_RULESDETAILS_ROOM_BLIND_INTERVAL = "%d人桌 漲盲時間: %d分鍾"
STR_TEXT_SNG_MIDWAY_LEAVE_TIPS = [[離開後，可重回比賽，是否繼續離開]]
STR_TEXT_SNG_LEAVE_TIPS = [[是否繼續離開]]

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
STR_TEXT_SNG_RANK_AWARD_TEXT = "獎金: %d"
STR_TEXT_SNG_ELIMINATE_TEXT = "沒關系，下次再戰"
STR_TEXT_SNG_ELIMINATE_TIPS_TEXT = "您已經被淘汰！"
STR_TEXT_SNG_RANK_AWARD_TIPS_TEXT = "恭喜您，獲得%s!"
STR_TEXT_SNG_SIGNUP_BEGIN_TEXT = "報名成功！還差 "
STR_TEXT_SNG_SIGNUP_END_TEXT = " 人開始比賽"

STR_TEXT_SNG_RICHTEXT_RANKING_BEGIN_TEXT = "當前：第 "
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

STR_TEXT_SNG_UP_BLIND_TIP_TIPS_BEGIN_TEXT = "下壹手將升盲至   "
STR_TEXT_SNG_UP_BLIND_TIP_TIPS_END_TEXT = "%d/%d"

STR_TEXT_SNG_SIGNUP_STARTED_TEXT = "正式開始比賽"
STR_TEXT_SNG_SIGNUP_PREPARE_BEGIN_TEXT = "比賽將在 "
STR_TEXT_SNG_SIGNUP_PREPARE_END_TEXT = " 秒後開始"
--结束获奖排位图标
SNG_AWARD_FINISH_BILL_RANKING_ICON = "game/game_layer/common/sng/sng_%dcup_big_hd.png"
--SNG排名
SNG_RANKING_ICON = "game/game_layer/common/ic_sngrank_image.png"
SNG_RANKING_TEXT = "第%d名"
--SNG托管状态
SNG_DELEGATE_ICON = "game/game_layer/common/ic_delegate_image.png"
SNG_DELEGATE_TEXT = "託管中"
--
SNG_BILL_RANKING_ICON = "game/game_layer/common/sng/sng_%dcup_icon.png"
--sng控制买入提示
SNG_STR_TEXT_CONTROL_AGREE_TIPS = [[%s
房主通過了您的報名請求]]

SNG_STR_TEXT_CONTROL_DENY_TIPS = [[%s
房主拒絕了您的報名請求]]

SNG_STR_TEXT_HAND_NUM = "第%d手"
INSURANCE_STR_TEXT_BREAKEVEN_TEXT = "保本"
INSURANCE_STR_TEXT_ALL_BREAKEVEN_TEXT = "全部保本"
INSURANCE_STR_TEXT_FULLPOOL_TEXT = "滿池"
INSURANCE_STR_TEXT_ALL_FULLPOOL_TEXT = "全部滿池"

INSURANCE_STR_TEXT_BET_FOLD_ICON = "game/game_layer/common/ic_insurance_bubao.png"
INSURANCE_STR_TEXT_BET_STACKS_ICON = "game/game_layer/common/ic_insurance_toubao_peifu.png"
INSURANCE_STR_TEXT_GET_STACKS_ICON = "game/game_layer/common/ic_insurance_toubao_peifu.png"
INSURANCE_STR_TEXT_GET_GOU_MAI_ICON = "game/game_layer/common/ic_insurance_goumai.png"

INSURANCE_STR_TEXT_BET_STACKS_TEXT = "投保"
INSURANCE_STR_TEXT_BET_FOLD_TEXT = "不保"
INSURANCE_STR_TEXT_GET_STACKS_TEXT = "賠付"
INSURANCE_STR_TEXT_GET_GOU_MAI_TEXT = "購買中 %ds"

INSURANCE_STR_TEXT_TIPS_BUYIN_ICON = "game/game_layer/cns/insurance/insurance_buyin_tips_anims/insurance_buyin_tips_fanti_%d.png"

INSURANCE_STR_TEXT_BUYIN_OK_TEXT = "購買保險"
INSURANCE_STR_TEXT_BUYIN_OK_ENABLED_TEXT = "請選擇分池"
INSURANCE_STR_TEXT_MAIN_POT = "主池"
INSURANCE_STR_TEXT_SPLIT_POT = "分池"

INSURANCE_STR_TEXT_POT_MAIN_TEXT="主"

INSURANCE_STR_TEXT_TIPS_NO_BUYIN_TEXT="outs>14或outs=0，不能購買保險"
INSURANCE_STR_TEXT_TIPS_NO_BUYIN_TEXT_SHORTDUCK="outs>13或outs=0，不能購買保險"
INSURANCE_STR_TEXT_TIPS_AUTO_BUYIN_TEXT="系統自動背保險，支出 %d 積分"
INSURANCE_STR_TEXT_TIPS_NO_BUYIN_POOL_TEXT="底池小於32，不能購買保險"

REVIEW_STR_TEXT_INSURANCE_STACKS_TEXT = "保險池： "

REVIEW_STR_TEXT_INSURANCE_NO_SEL_POT_TEXT = "點擊選擇"
REVIEW_STR_TEXT_INSURANCE_SEL_POT_TEXT = "已選擇"

INSURANCE_STR_ODDS_TEXT = "0"
INSURANCE_STR_FULLPOLL_TEXT = "滿池"
INSURANCE_STR_MAXPOLL_TEXT = "最大"
INSURANCE_STR_OVEROUTS_TIPS_TEXT = "最少選擇%d張outs"
INSURANCE_STR_CHOOSE_OUTS_FULL_TIPS_TEXT = "選擇outs數已達上限"

--保险碎了图标
INSURANCE_SUI_ICON = "game/game_layer/cn/insurance/insurance_anmi.png"

--水印
NORMAL_GAME_TYPE_LOG_ICON = "game/game_layer/common/gamelogo/game_fanti.png"
SNG_GAME_TYPE_LOG_ICON = "game/game_layer/common/gamelogo/sng_fanti.png"
SIX_GAME_TYPE_LOG_ICON = "game/game_layer/common/gamelogo/6game_fanti.png"
OMAHA_GAME_TYPE_LOG_ICON = "game/game_layer/common/gamelogo/omaha_fanti.png"
MTT_GAME_TYPE_LOG_ICON = "game/game_layer/common/gamelogo/mtt_gamelogo_fanti.png"
SHORT_DECK_TYPE_LOG_ICON =  "game/game_layer/common/gamelogo/shortduck_fanti.png"

--过渡界面水印
LOADING_GAME_LOGO_ICON = "game/game_layer/common/transition/transition_logo_fanti.png"

KICK_GAME_ROOM_TEXT = "被房主請出牌局"
KICK_GAME_ROOM_OTHER_ROOM_TEXT = "您被房主請出牌局"

END_GAME_ROOM_FORWARD_TEXT = "房主提前結束牌局"

--IP限制文本
IP_LIMIT_TEXT = "IP"
GPS_LIMIT_TEXT = "GPS"
IP_AND_GPS_LIMIT_TEXT = "GPS IP"

--straddle设置文本
STRADDLE_OPEN_TEXT = "  Straddle"

--强制站起
FORCE_STANDUP_TEXT = "您被房主強制站起"
FORCE_STANDUP_OTHERROOM_TEXT = "您被%s房主強制站起"
FORCE_STANDUP_OTHERS_TEXT = "被房主強制站起"

FORCE_OPEN_STANDUP_WEAKTIP_TEXT = [[ 房主開啟了強制
Straddle功能]]
FORCE_CLOSE_STANDUP_WEAKTIP_TEXT = [[ 房主關閉了強制
Straddle功能]]

--思考时间
THINKING_INTERVAL_TEXT = "房主將思考時間改為%d秒, 下一手生效"

--show ID
OTHERINFO_SHOW_ID_TEXT = "ID:"

--MTT
MTT_DESK_NUM_TEXT={}
MTT_DESK_NUM_TEXT[1] = ""
MTT_DESK_NUM_TEXT[2] = " 號桌"
MTT_DESK_STAKE_TEXT = "%d/%d"
MTT_AWARD_RANK_TEXT = "前%d名"
MTT_AWARD_RANK_POS_TEXT = "第%d名"
MTT_AWARD_BONUS_TEXT = "獎勵: "
MTT_AWARD_RANK_STR_TEXT = "第%s名"
MTT_BLIND_TIME_TEXT = "%d分鐘"
MTT_BLIND_STRUCT_TEXT = "%d/%d/(%d)"
MTT_BLIND_STRUCT_NOANTE_TEXT = "%d/%d"
MTT_MAINSCENE_BLIND_TEXT = "當前盲注:"
MTT_MAINSCENE_DESK_TIME_TEXT01 = "00:%d"
MTT_MAINSCENE_DESK_TIME_TEXT02 = "00:0%d"
MTT_MAINSCENE_DESK_TIME_TEXT03 = "00:00"
MTT_REVIEW_DESKNUM_TEXT = "第%d桌"
MTT_MATCH_DATA_NO_BLINDTIME_TEXT = "--:--:--"
MTT_MATCH_DATA_NO_DATA_TEXT = "--"
MTT_MATCH_DATA_NO_BLINDSTRUCT_TEXT = "--/--/(--)"
MTT_MATCH_DATA_NO_USEDTIME_TEXT = "00:00:00"

MTT_RANK_TEXT={}
MTT_RANK_TEXT[1] = "冠軍"
MTT_RANK_TEXT[2] = "亞軍"
MTT_RANK_TEXT[3] = "季軍"
MTT_OTHER_RANK_TEXT = "第%d名"

MTT_WATCH_DESK_FINISH_TEXT = "當前牌桌已失效"
MTT_WATCH_FINISH_TEXT = "比賽已結束"

MTT_DESK_STATE_REENTRY_TEXT = "允許重進中"
MTT_DESK_STATE_DELAY_TEXT = "延遲報名中"

MTT_REENTRY_FEE_POPULARITY_TEXT = "是否以%d德撲幣或對應賽事門票進行重進"
MTT_REENTRY_FEE_TICKET_TEXT = "是否以賽事門票進行重進"
MTT_REENTRY_GET_STACKS_TEXT = "獲得%d記分牌"

MTT_SIGNUP_REQUIREMENT_COIN_TEXT = "%d德撲幣或賽事門票"
MTT_SIGNUP_REQUIREMENT_TICKET_TEXT = "賽事門票"

MTT_START_PUSH_TEXT = "已經可以入座，祝您好運!"
MTT_START_FULL_TABLE_PUSH_TEXT = "牌局已就緒，請開始遊戲!"
MTT_START_CANCEL_PUSH_TEXT = "已經取消，將退還給您報名條件。"
MTT_START_PUSH_ENTER = "進入比賽"
MTT_START_PUSH_BACK = "回到牌局"

MTT_SYSTEM_PUSH_GIVECARD_SAMETIME_TEXT = "比賽同步發牌中，請等待其他牌桌結束當前手牌"
MTT_SYSTEM_PUSH_CHANGE_DESK_TEXT = "您已被移動到新的牌桌"
MTT_SYSTEM_PUSH_CHANGE_DESK_TEXT02 = "您旁觀的牌桌已失效，您已被返回原先牌桌"
MTT_DELAY_REGISTER_FINISH_DESK_TEXT = "比賽遲註冊階段已經結束"
MTT_SYSTEM_PUSH_BLIND_UP_DESK_TEXT = "下一手牌盲注將至："

MTT_SYSTEM_PUSH_NORMAL_TEXT = "現在前往比賽，您會從當前牌局站起，確認要前往比賽嗎？"
MTT_SYSTEM_PUSH_FULL_TABLE_TEXT = "您現在離開牌桌將會從當前牌局站起，確認要前往嗎？"
MTT_SYSTEM_PUSH_SNG_OR_MTT_TEXT = "現在前往比賽，您當前的比賽會託管，確認要前往比賽嗎？"

MTT_INTRODUCE_PAG_DELAY_TEXT = "%d級別內可延時報名"
MTT_INTRODUCE_PAG_REENTRY_TEXT = "%d級別內可重進，上限%d次"

MTT_INTRODUCE_PAG_SIGNUP_STR = "報名費:"
MTT_INTRODUCE_PAG_STACKS_STR = "初始記分牌:"
MTT_INTRODUCE_PAG_DELAY_STR = "延時報名:"
MTT_INTRODUCE_PAG_REENTRY_STR = "重進:"
MTT_INTRODUCE_PAG_COIN_TEXT = "%d德撲幣"

--文字牌谱
STR_POKERTEXTINFO_STATE_PREFLOP_TEXT = "Preflop"
STR_POKERTEXTINFO_STATE_FLOP_TEXT = "Flop"
STR_POKERTEXTINFO_STATE_TURN_TEXT = "Turn"
STR_POKERTEXTINFO_STATE_RIVER_TEXT = "River"
STR_POKERTEXTINFO_HIDENAME_TEXT = "匿名"
STR_POKERTEXTINFO_INSURANCE_TEXT = "保險池:"
STR_POKERTEXTINFO_PROCESS_TEXT = "詳細過程"
STR_POKERTEXTINFO_HANDRESULT_TEXT = "牌譜"
STR_POKERTEXTINFO_SHOWDOWN_TEXT = "Showdown"

POKERTEXTINFO_FOLD_ICON = "game/game_layer/common/pokertextinfo/fold_icon.png"
POKERTEXTINFO_CALL_ICON = "game/game_layer/common/pokertextinfo/call_icon.png"
POKERTEXTINFO_RAISE_ICON = "game/game_layer/common/pokertextinfo/raise_icon.png"
POKERTEXTINFO_POKER_FACE_ICON = "game/game_layer/common/pokertextinfo/poker_%d.png"
POKERTEXTINFO_POKER_BACK_FACE_ICON = "game/game_layer/common/pokertextinfo/poker_en.png"

INSURANCE_HELP_URL = "http://upyun.pokermate.net/web/tw/insurance_instruction.html"
INSURANCE_OMAHA_HELP_URL = "http://upyun.pokermate.net/web/tw/omaha_insurance_instruction.html"

--個人設置介面
STR_SETTING_SELFTITLE_TEXT = "個人設置"
STR_SETTING_ADVANCETITLE_TEXT = "房主功能"

STR_SETTING_SELF_RAISESTR_TEXT = "自定義快捷加註"
STR_SETTING_SELF_CARDSTR_TEXT = "桌面風格"
STR_SETTING_SELF_MUTE_TEXT = "牌局靜音"
STR_SETTING_SELF_TALK_MUTE_TEXT = "聊天靜音"
STR_SETTING_SELF_INSURANCE_STR_TEXT = "保險提示"
STR_SETTING_SELF_INSURANCE_TIPSSTR_TEXT = "(只對本桌有效)"
STR_SETTING_SELF_RAISE_STR_TEXT = "拉杆確認"
STR_SETTING_SELF_RAISE_TIPS_TEXT = [[點擊快速加註按鈕

可自訂加註底池比例]]

SETTING_SELF_RAISEPOT_ALLIN_STR = "Allin"
SETTING_SELF_RAISEPOT_1XPOT_STR = "1x"
SETTING_SELF_RAISEPOT_1PT5XPOT_STR = "1.5x"
SETTING_SELF_RAISEPOT_NIL_STR = "無"

SETTING_SELF_TABLECOLOR01_STR = "經典藍"
SETTING_SELF_TABLECOLOR02_STR = "磨砂黑"
SETTING_SELF_TABLECOLOR03_STR = "寶石藍"
SETTING_SELF_TABLECOLOR04_STR = "青蔥綠" 

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
PLAYER_TEMPORARILYLEAVE_TIPS_TEXT = "您將在本手結束後進入留座離桌狀態。"

--错误
ERROR_TEXT_TYPE_ENUM={
[1] = "用户不存在。",
[2] = "群聊不存在。",
[3] = "此手機號碼已經注冊過賬號。",
[4] = "驗證碼不正確，請重新輸入。",
[5] = "賬號或密碼錯誤，請重新填寫。",
[6] = "對方沒有邀請您爲好友。",
[7] = "妳們不是好友。",
[8] = "群聊人數超出上限。",
[9] = "已到達您VIP等級創建上限。",
[10] = "未知服務器錯誤。",
[11] = "牌局不存在。",
[12] = "牌局人數已滿。",
[13] = "德撲幣不足，請購買德撲幣",
[14] = "妳們不是好友。",
[15] = "已經分享足夠次數。",
[16] = "已經獲得過獎勵。",
[17] = "戰績不存在。",
[18] = "收藏的牌譜不存在。",
[19] = "收藏數據不完整。",
[20] = "您購買的道具錯誤。",
[21] = "您沒有足夠的鑽石，請先購買鑽石。",
[22] = "您無此權限。",
[23] = "您無此權限，只能群主移除。",
[24] = "您無此權限，只能群主進行群組設置。",
[25] = "您無此權限，只能群主邀請。",
[26] = "該用戶不在群聊中。",
[27] = "賬戶在其它設備登錄。",
[28] = "未知錯誤。",
[29] = "已經有人坐下了。",
[30] = "您不能購買低於當前等級的VIP卡。",
[31] = "沒有權限開始牌局。",
[32] = "妳們已成爲好友。",
[33] = "活動已經結束。",
[34] = "俱樂部已達人數上限，無法允許加入",
[35] = "俱樂部不存在。",
[36] = "您沒有相關權限。",
[37] = "該用戶不在俱樂部中。",
[38] = "您只能創建壹個快速牌局。",
[39] = "快速牌局不存在。",
[40] = "快速牌局已開始。",
[41] = "牌局中已沒有其他玩家。",
[42] = "該用戶不在快速牌局中。",
[43] = "購買失敗。",
[44] = "",
[45] = "購買失敗。",
[46] = "手中籌碼達到上限",
[47] = "福利已經領取",
[48] = "已到達俱樂部人數上限。",
[49] = "權限不足，只有管理員可操作",
[50] = "昵稱已存在，請更換",
[51] = "昵稱是否已經被佔用",
[52] = "牌局不是高級房",
[53] = "不是房主",
[54] = "不存在牌局結果",
[55] = "不存在上壹個牌局結果",
[56] = "不存在這個牌譜",
[57] = "已申請，請等待房主批准",
[58] = "用戶不在遊戲房間內",
[59] = "用戶沒有申請買入",
[60] = "用戶沒有處理買入的權限",
[61] = "您有未結束的牌局",
[62] = "錯誤的暫停命令",
[63] = "牌局還沒有開始",
[64] = "不是牌局主，無法對牌局進行設置",
[65] = "用戶已經在俱樂部中",
[66] = "收藏牌譜到上限",
[600] = "牌局已解散",
[71] = [[turn購買保險後，
開關不能關閉]],
[72] = [[您在allin狀態下
不能站起或退出]],
[73] = [["登陸信息過期，
請重新登陸"]],
[74] = [[您已被房主請出牌局，
不能再次加入]],
[75] = [[ 由於您與牌局內某玩家距離過近
或沒有開啟定位許可權, 為保證牌局
公平, 您不能參與本牌局。]],
[76] = [[ 由於您與牌局內某玩家距離過近
或沒有開啟定位許可權, 為保證牌局
公平, 您不能參與本牌局。]],
[77] = [[ 由於您與牌局內某玩家距離過近
或沒有開啟定位許可權, 為保證牌局
公平, 您不能參與本牌局。]],
[78] = [[ 由於您與牌局內某玩家距離過近
或沒有開啟定位許可權, 為保證牌局
公平, 您不能參與本牌局。]],
[79] = "您已處於站起狀態",
[80] = [[ 由於您與牌局內某玩家距離過近
或沒有開啟定位許可權, 為保證牌局
公平, 您不能參與本牌局。]],
[81] = [[聯盟中俱樂部數量
已達上限]],
[82] = [[您沒有許可權管理聯盟]],
[83] = [[創建聯盟超過上限]],
[84] = [[參與的聯盟數超過上限]],
[85] = [[沒有許可權創建聯盟]],
[86] = [[聯盟不存在]],
[87] = [[沒有許可權獲取聯盟資料]],
[88] = [[已在其他俱樂部申請，
不允許在此俱樂部再次申請]],
[89] = [[該聯盟已開啟免打擾模式]],
[90] = [[該俱樂部已在聯盟中]],
[91] = [[該俱樂部已經不在聯盟中]],
[92] = [[加入聯盟申請已發送]],
[93] = [[此聯盟名稱已被搶佔]],
[94] = [[管理員數量已滿]],
[95] = [[俱樂部加入的聯盟數量超過上限]],
[96] = [[用戶已開啟免打擾]],
[97] = [[不能刪除俱樂部，因為俱樂部
還有沒有刪除的聯盟]],
[98] = [[不在聯盟白名單中]],
[99] = [[門票類型不存在]],
[100] = [[門票數量不足]],
[101] = [[兌換碼已過期]],
[102] = [[兌換碼已經被使用]],
[103] = [[兌換碼不存在]],
[104] = [[已經報過名]],
[105] = [[人數超過比賽限制，無法報名]],
[106] = [[不在延遲報名階段內，無法報名]],
[107] = [[無門票或等值德撲幣，無法報名]],
[108] = [[比賽已經開始，無法取消報名]],
[109] = [[不在延遲報名階段內，無法重進]],
[110] = [[已超過用戶重進次數，無法重進]],
[111] = [[無門票或等值德撲幣，無法重進]],
[112] = [[已被淘汰，無法進入牌桌]],
[113] = [[已被合桌，無法進入牌桌]],
[114] = [[比賽已經結束，無法進入牌桌]],
[115] = [[無特殊門票，無法報名]],
[116] = [[比賽已經取消，無法報名]],
[117] = [[無特殊門票，無法重進]],
[118] = [[輸入的內容中含有敏感詞，請重試]],
[119] = [[牌桌失效，切換牌桌]],
[125] = [[本手已帶出過記分牌]],
[126] = [[記分牌不足]],
[127] = [[記分牌不足]],

[9001] = [[非法用户]],
[9002] = [[餘額不足]],
[9003] = [[非法命令]],
[9004] = [[超時]],
[9005] = [[您的網絡狀態不好]],

[9006] = "非法用户",
[9007] = "餘額不足",
[9008] = "非法命令",
[9009] = "超時",
[9010] = "內部異常",

[9012] = "餘額不足",
[9013] = "非法命令",
[9014] = "內部異常",
[9015] = "非法用户",
[9016] = "無效下注",
[9017] = "房間已滿",
[9018] = "余額不足",
[9019] = "您很久未操作，請重新進入遊戲",
}

SNG_RANK_TEXT={}
SNG_RANK_TEXT[1]="冠軍"
SNG_RANK_TEXT[2]="亞軍"
SNG_RANK_TEXT[3]="季軍"


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

--旧保险
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
    STR_ADVANCEDSETTINGS_BUYINSTR = "設置玩家可以補充記分牌的倍數"
    STR_ADVANCEDSETTINGS_BUYINCTRLSTR = "控制玩家帶入"
    STR_ADVANCEDSETTINGS_PAUSESTR = "牌局暫停"
    STR_ADVANCEDSETTINGS_DISMISSSTR = "解散牌局"
    STR_ADVANCEDSETTINGS_NOSAVETEXT = "保存"
    STR_ADVANCEDSETTINGS_SAVEDTEXT = "已保存"
    STR_ADVANCEDSETTINGS_SETTIMETEXT = "設置玩家思考時長(下一手生效)"
    STR_ADVANCEDSETTINGS_STRADDLE_TEXT = "強制盲注"
    STR_ADVANCEDSETTINGS_PUSHTEXT = "消息推送"

    STR_BUYNODE_BUYINSTR = "補充記分牌"
    STR_BUYNODE_BUYTIPSSTR = "在下壹手開始時，將爲妳補充所購記分牌"
    STR_BUYNODE_BUYSTR = "帶入記分牌"
    STR_BUYNODE_COINSSTR = "財富額:"
    STR_BUYNODE_FEESTR = "記錄費:"
    STR_BUYNODE_BUYBUTTON_STR  = "確定買入"
    STR_BUYNODE_NOTIFYTIPS_STR = "通知所屬俱樂部"
    
    STR_CASHOUT_TITLE = "帶出記分牌"
    STR_CASHOUT_CONTENT01 = "本手結束時，將為您帶出對應的記分牌"
    STR_CASHOUT_CONTENT02 = "帶出記分牌"
    STR_CASHOUT_CONTENT03 = "牌局開始後，將為您帶出對應的記分牌"
    STR_CASHOUT_CONFIRM = "確認帶出"
    STR_CASHOUT_TIPS_ALREADY = "本手已帶出過記分牌！"

    STR_CASHOUT_SUCCESS = "成功帶出%d記分牌！"
    STR_CASHOUT_NOT_ENOUGH = "記分牌不足"
    STR_CASHOUT_FAIL = "記分牌不足"

    STR_CHECKPROMPTNODE_TIPSSTR = "提示"
    STR_CHECKPROMPTNODE_TIPSSTR01 = "當前您可以選擇看牌,"
    STR_CHECKPROMPTNODE_TIPSSTR02 = "您確定要棄牌?"
    STR_CHECKPROMPTNODE_HIDETIPSSTR = "不再提示"
    STR_CHECKPROMPTNODE_CHECKBUTTON_STR = "看牌"
    STR_CHECKPROMPTNODE_FOLDBUTTON_STR = "棄牌"

    STR_COMMONINPUTNODE_NEW_TAGSTR = "打法標記"
    STR_COMMONINPUTNODE_NEW_CANCELTEXT = "取消"
    STR_COMMONINPUTNODE_NEW_SAVETEXT = "保存"
    STR_COMMONINPUTNODE_PLACEHODER_REMARK_TEXT = "請編輯玩家備註"
    STR_COMMONINPUTNODE_PLACEHODER_TAG_TEXT = "請編輯打法標記"
    STR_COMMONINPUTNODE_NEW_REMARKSTR = "備註名"

    STR_ERRORNODE_TIPSSTR = "温馨提示"
    STR_ERRORNODE_CANCELSTR = "取消"
    STR_ERRORNODE_CANCELSTR_NEW = "知道了"

    STR_FACEPAG_INFOTEXT  = "默認"
    STR_FACEPAG_INFOTEXT1 = "魔法表情 (20"
    STR_FACEPAG_INFOTEXT2 = "/次)"

    STR_GOTOSHOPNODE_TIPSSTR = "温馨提示"
    STR_GOTOSHOPNODE_CANCELTEXT = "取消"
    STR_GOTOSHOPNODE_OKTEXT = "購買德州幣"

    STR_INSURANCEMATCHUSERSETTLEMENTDATANODE_NAMETEXT = "保險池"
    STR_INSURANCEUSERSETTLEMENTDATANODE_NAMETEXT = "保險池"

    STR_KICKOUTTIPSNODE_TIPSTEXT01 = "玩家被踢出後無法再加入"
    STR_KICKOUTTIPSNODE_TIPSTEXT02 = "建議先暫停牌局溝通"
    STR_KICKOUTTIPSNODE_PAUSETBUTTON = "暫停牌局"
    STR_KICKOUTTIPSNODE_KICKBUTTON = "確定踢出"

    STR_MAINSCENE_STARTSTATETEXT = "等待下壹手"

    STR_MATCHSTATISTICSNODE_NICKNAMESTR = "昵稱"
    STR_MATCHSTATISTICSNODE_BUYINSTR = "帶入"
    STR_MATCHSTATISTICSNODE_WONSTR = "積分"
    STR_MATCHSTATISTICSNODE_RESULTSTR = "個人戰績"
    STR_MATCHSTATISTICSNODE_TITLESTR = "牌局統計"
    STR_MATCHSTATISTICSNODE_TOTALHANDSTR = "本局總手數"
    STR_MATCHSTATISTICSNODE_MAXPOTSTR = "本局最大Pot"
    STR_MATCHSTATISTICSNODE_TOTALBUYSTR = "本局總帶入"
    STR_MATCHSTATISTICSNODE_MVP = "MVP"
    STR_MATCHSTATISTICSNODE_BOSS = "土豪"
    STR_MATCHSTATISTICSNODE_FISH = "大魚"

    STR_OTHERINFONODE_NEW_REMARKTEXT = "備註標記"
    STR_OTHERINFONODE_NEW_NILTEXT = "備註名和打法標記"
    STR_OTHERINFONODE_NEW_VOICETEXT = "語音重播"
    STR_OTHERINFONODE_NEW_ADDTEXT = "添加好友"
    STR_OTHERINFONODE_NEW_KICKTEXT = "踢出牌局"
    STR_OTHERINFONODE_NEW_STANDUPTEXT = "強制站起"
    STR_OTHERINFONODE_NEW_MATCHSTR = "牌局數"
    STR_OTHERINFONODE_NEW_HANDSTR = "總手數"
    STR_OTHERINFONODE_NEW_POOLSTR = "入池率"
    STR_OTHERINFONODE_NEW_WINSTR = "翻前加注率"
    STR_OTHERINFONODE_PROFITSTR = "盈虧"
    STR_OTHERINFONODE_ALLINWINSTR = "Allin勝率"
    STR_OTHERINFONODE_SNGMATCHSTR = "參賽數"
    STR_OTHERINFONODE_SNGCHAMPIONSTR = "冠軍數"
    STR_OTHERINFONODE_SNGSECONDSTR = "亞軍數"
    STR_OTHERINFONODE_SNGTHIRDSTR = "季軍數"
    STR_OTHERINFONODE_MTTCHAMPIONSTR = "冠軍數"
    STR_OTHERINFONODE_MTTFIRSTTHREESTR = "前3數"
    STR_OTHERINFONODE_MTTBONUSSTR = "奖励圈數"
    STR_OTHERINFONODE_NICKNAMESTR = "昵稱:"

    STR_OTHERINFOSELFNODE_TIPSSTR = "30日普通局數據"
    STR_OTHERINFOSELFNODE_SNGTIPSSTR = ""

    STR_REALTIMESITUATIONNODE_NICKNAMESTR = "昵稱"
    STR_REALTIMESITUATIONNODE_BUYINSTR = "帶入"
    STR_REALTIMESITUATIONNODE_RESULTSTR = "積分"

    STR_REALTIMESITUATIONOTHERNODE_WATCHSTR = "看客"

    STR_REVIEWMAINNODE_REVIEWSTR = "全域回顧"

    STR_SITDOWNBUYNODE_BLINDSTR = "小盲/大盲"
    STR_SITDOWNBUYNODE_BUYINSTR = "帶入記分牌"
    STR_SITDOWNBUYNODEE_COINSSTR = "財富額:"
    STR_SITDOWNBUYNODE_FEESTR = "記錄費:"
    STR_SITDOWNBUYNODE_BUYBUTTON = "加入牌局"
    STR_SITDOWNBUYNODE_NOTIFYTIPS_STR = "通知所屬俱樂部"
    STR_SITDOWNBUYNODE_BLINDSTR_SHORT = "前注"

    STR_INSURANCEBUYINCHILDNODE_PAYSTR = "支付"
    STR_INSURANCEBUYINCHILDNODE_CLAIMSTR = "賠付"
    STR_INSURANCEBUYINCHILDNODE_OUTSTR = "Outs"
    STR_INSURANCEBUYINCHILDNODE_ODDSTR = "賠率"

    STR_INSURANCEBUYINNODE_PASSSTR = "放棄"

    STR_INSURANCEBUYINOPERATENODE_STATETEXT = "保本"
    STR_INSURANCEBUYINOPERATENODE_INPUTTEXT = "投保額"
    STR_INSURANCEBUYINOPERATENODE_RAISEENDENDTEXT = "最大值"
    STR_INSURANCEBUYINOPERATENODE_STATEIMAGETEXT = "-保本"
    STR_INSURANCEBUYINOPERATENODE_RAISEENDIMAGEBUTTON = "最大值"
    STR_INSURANCEBUYINOPERATENODE_CHARGETEXT = "賠付額"
    STR_INSURANCEBUYINOPERATENODE_ODDSTEXT = "賠率"
    STR_INSURANCEBUYINOPERATENODE_COMCARDSTR = "公共牌"
    STR_INSURANCEBUYINOPERATENODE_HANDSCARDSTR = "手牌"
    STR_INSURANCEBUYINOPERATENODE_PLAYERCARDSTR = "對方手牌"
    STR_INSURANCEBUYINOPERATENODE_OUTSSTR = "OUTS"
    STR_INSURANCEBUYINOPERATENODE_SPLITOUTSSTR = "分池 OUTS"
    STR_INSURANCEBUYINOPERATENODE_PREMIUMONSSTR = "背保險投保額"
    STR_INSURANCEBUYINOPERATENODE_ODDSONSSTR = "背保險賠率"
    STR_INSURANCEBUYINOPERATENODE_SELECTALLSTR = "全選"

    STR_SNGAWARDFINISHNODE_TITLE_ELIMINATE = "遺憾出局"
    STR_SNGAWARDFINISHNODE_SHARESTR = "牌技這麽牛，趕快炫耀壹下吧！"
    STR_SNGAWARDFINISHNODE_PLACESTR = "名次"
    STR_SNGAWARDFINISHNODE_NICKNAMESTR = "昵稱"
    STR_SNGAWARDFINISHNODE_REWARDSTR = "獎勵"
    STR_SNGAWARDFINISHNODE_SHOWOFFBUTTON_STR = "炫耀壹下"

    STR_SNGELIMINATEFINISHNODE_TITLESTR = "比賽已結束"
    STR_SNGELIMINATEFINISHNODE_PLACESTR = "名次"
    STR_SNGELIMINATEFINISHNODE_NICKNAMESTR = "昵稱"
    STR_SNGELIMINATEFINISHNODE_REWARDSTR = "獎勵"
    STR_SNGELIMINATEFINISHNODE_RANKSTR01 = "第"
    STR_SNGELIMINATEFINISHNODE_RANKSTR02 = "名"
    STR_SNGELIMINATEFINISHNODE_RANKAWARDSTR = "獎金:"

    STR_SNGELIMINATENODE_STAYBUTTON_STR = "留下旁觀"
    STR_SNGELIMINATENODE_EXITBUTTON_STR = "退出牌局"
    STR_SNGELIMINATENODE_RANKSTR01 = "第"
    STR_SNGELIMINATENODE_RANKSTR02 = "名"

    STR_SNGLEAVENODE_CANCELTEXT = "取消"
    STR_SNGLEAVENODE_OKTEXT = "繼續離開"
    STR_SNGCONTROLBUYINMSG_STR = "新牌局消息"

    STR_SNGMAINSCENE_STARTSTATETEXT = "等待下壹手"

    STR_SNGREALTIMESITUATIONNODE_PLACESTR = "排名"
    STR_SNGREALTIMESITUATIONNODE_NICKNAMESTR = "昵稱"
    STR_SNGREALTIMESITUATIONNODE_RESULTSTR = "記分牌"

    STR_SNGRULESDETAILSNODE_LEVELSTR = "級別"
    STR_SNGRULESDETAILSNODE_BLINDSTR = "盲注"

    STR_INSURANCEINFOMAINCHILDNODE_TITLESTR = "保險說明"
    STR_INSURANCEINFOMAINCHILDNODE_OMAHA_TITLESTR = "保險說明"
    STR_INSURANCEINFOMAINCHILDNODE_INTROSTR01 = "概述"
    STR_INSURANCEINFOMAINCHILDNODE_INTROSTR02 = "操作"
    STR_INSURANCEINFOMAINCHILDNODE_INTROSTR03 = "賠率"
    STR_INSURANCEINFOMAINCHILDNODE_BODYSTR01 = [[1 . 當牌局中玩家全部All in之後，由當前牌型最大的玩

家，獲得購買的機會並彈出保險購買操作提示。

2 . 保險超過14個 Outs（補牌）不啟動。

3 . 當保險涉及的底池中超過3個玩家的時候，保險不啟動

（2人或者3人時可以買保險）。

4 . 造成玩家平分的Outs不會計入購買保險的Outs數量，如

果河牌存在平分Outs ，那麼玩家購買保險的總額不會超過他

向底池內投入的總額。

5 . 存在多個底池時，可以選擇一個或多個參與的底池購買

保險。

6 . 牌桌內“即時戰績”和“上局回顧“中均有保險資料顯

示，且戰績中會增加保險資料顯示。

7 . 翻牌（Flop）三張不可購買保險，轉牌保險投保額不得

超過0.25*底池，河牌保險投保額不得超過0.5*底池。

8. 如果購買了轉牌的保險，那麼系統會強制玩家購買

河牌的少量保險，背回轉牌的保險投入。

]]
    STR_INSURANCEINFOMAINCHILDNODE_BODYSTR02 = [[1 . 保本：保險賠付額=玩家投入金額。

2 . 點擊底池按鈕可以展開滑動條，選擇需要購買的保險金

額。

3 . 確定好保險金額後，點擊購買按鈕，即成功購買保險。

4 . 存在多個底池時，每個底池均可以分別操作購買。

5 . 玩家也可以點擊全部保本來快速購買所有保險。

6 . 購買保險消耗的德撲幣從底池中扣除，如果買中，系統

會根據賠率，直接賠付到玩家手中；如果沒中，則系統收走

購買保險消耗的德撲幣。

    ]]

STR_INSURANCEINFOMAINCHILDNODE_OMAHA_BODYSTR01 = [[1 . 奧馬哈保險只會在牌桌人數小於等於6人時激活。

2 .	當牌局中玩家全部All in之後，由當前牌型最大的玩家獲

得購買的機會，並彈出保險購買操作提示。

3 .	保險超過14 Outs 不啟動。

4 .	當保險涉及的底池中超過3個玩家的時候，保險不啟動。

（2人或者3人時可以買保險。）

5 .	造成玩家平分的Outs不會計入購買保險的Outs數量，如果

河牌存在平分Outs ，那麼玩家購買保險的總額不會超過他向

底池內投入的總額。

6 .	存在多個底池時，可以選擇一個或多個參與的底池購買保險。

7 .	牌桌內“即時戰績”和“上局回顧“中均有保險資料顯示，且

戰績中會增加保險資料顯示

8 .	Flop三張不可購買保險，Turn牌保險投保額不得超過

0.25*底池，River保險投保額不得超過0.5*底池。

9 .	如果購買了Turn牌的保險，那麼系統會強制玩家購買

River牌的少量保險，背回Turn牌的保險投入。

]]

STR_INSURANCEINFOMAINCHILDNODE_OMAHA_BODYSTR02 = [[1 . 保本：保險賠付額=玩家投入金額。

2 . 點擊底池按鈕可以展開滑動條，選擇需要購買的保險金

額。

3 . 確定好保險金額後，點擊購買按鈕，即成功購買保險。

4 . 存在多個底池時，每個底池均可以分別操作購買。

5 . 玩家也可以點擊全部保本來快速購買所有保險。

6 . 購買保險消耗的德撲幣從底池中扣除，如果買中，系統

會根據賠率，直接賠付到玩家手中；如果沒中，則系統收走

購買保險消耗的德撲幣。

    ]]

    STR_MICROPHONEPAG_SEND_TIPSTEXT = "手指上滑 取消發送"
    STR_MICROPHONEPAG_CANCEL_TIPSTEXT = "鬆開手指 取消發送"
    STR_MICROPHONEPAG_SENDED_TIPSTEXT = "已發送"

    STR_DISMISSTIPSPAG_TIPSTEXT = "確定提前結束牌局"
    STR_CANCELBUTTON_STR = "取消"
    STR_OKBUTTON_STR = "確定"
    STR_FORCESTAND_TIPSTEXT = "玩家將被強制站起，是否確認"

    STR_FANFANKAN_TITLE_TEXT = "凡有所相，皆是虛妄"
    STR_TURNLOOK_TITLE_FLOP_TEXT = "打賞看翻牌"
    STR_TURNLOOK_TITLE_TURN_TEXT = "打賞看轉牌"
    STR_TURNLOOK_TITLE_RIVER_TEXT = "打赏看河牌"
    STR_TURNLOOK_TIPS_TEXT = "僅供娛樂"
    STR_TURNLOOK_NOENOUGHCOIN_WEAKTIPS_TEXT = "德扑币不足，无法看牌"    
    STR_TURNLOOK_NOTRIGHTTIME_WEAKTIPS_TEXT = "不是看牌时间"

    STR_SNG_UPBLIND_TITLE_TEXT = "升盲倒計時"

    --mtt 死文本简繁英
    STR_MTT_REENTRY_TIPS = "不再提示此類消息"
    STR_MTT_SHAREIT_BUTTON_TITLE = "炫耀一下"
    STR_MTT_EXIT_BUTTON_TITLE = "退出比賽"
    STR_MTT_CHANGETABLE_BUTTON_TITLE = "切換牌桌"
    STR_MTT_FINISH_NOAWARD_TITLE = "您已經被淘汰，請下次再戰"
    STR_MTT_EXITTIPS_TITLE = [[退出比賽，系統將替您託管牌局 

您可隨時返回牌局]]
    STR_MTT_SIGNUP_SIGN_TEXT = "報名:"
    STR_MTT_SIGNUP_TICKET_TEXT = "條件:"


    STR_MTT_REALTIMES_MATCH_SCORE_TEXT = "記分牌平均值"
    STR_MTT_REALTIMES_MATCH_NEXTTIME_TEXT = "下一級別時長"
    STR_MTT_REALTIMES_MATCH_BLINDTIME_TEXT = "漲盲剩餘時間"
    STR_MTT_REALTIMES_MATCH_CURBLIND_TEXT = "當前盲注"
    STR_MTT_REALTIMES_MATCH_NEXTLEVEL_TEXT = "下一級別"
    STR_MTT_REALTIMES_MATCH_PLAYERNUM_TEXT = "玩家人數"
    STR_MTT_REALTIMES_MATCH_USEDTIME_TEXT = "比賽已用時"
    STR_MTT_REALTIMES_REENTRY_TEXT = "自動重進"
    STR_MTT_REALTIMES_UPDATE_TEXT = "刷新"
    STR_MTT_REALTIMES_PAGE_TITLE_TEXT01 = "賽況"
    STR_MTT_REALTIMES_PAGE_TITLE_TEXT02 = "牌桌"
    STR_MTT_REALTIMES_PAGE_TITLE_TEXT03 = "獎勵"
    STR_MTT_REALTIMES_PAGE_TITLE_TEXT04 = "盲注"
    STR_MTT_REALTIMES_PAGE_TITLE_TEXT05 = "概況"
    STR_MTT_REALTIMES_RANK_TITLE_TEXT = "即時排名"
    STR_MTT_REALTIMES_RANK_TITLE_DESK_TEXT = "牌桌"
    STR_MTT_REALTIMES_RANK_TITLE_SCORE_TEXT = "積分"
    STR_MTT_REALTIMES_DESK_TITLE_DESKNUM_TEXT = "桌號"
    STR_MTT_REALTIMES_RANK_TITLE_BLIND_TEXT = "大盲數"
    STR_MTT_REALTIMES_DESK_TITLE_PLAYERNUM_TEXT = "人數"
    STR_MTT_REALTIMES_DESK_TITLE_STACK_TEXT = "記分牌"
    STR_MTT_REALTIMES_AWARD_TITLE_PRIZEPOOL_TEXT = "總獎池:"
    STR_MTT_REALTIMES_AWARD_TITLE_ITM_TEXT = "獎勵圈:"
    STR_MTT_REALTIMES_AWARD_TITLE_NEXTPRIZE_TEXT = "下一個獎勵:"
    STR_MTT_REALTIMES_BLIND_TITLE_LEVEL_TEXT = "級別"
    STR_MTT_REALTIMES_BLIND_TITLE_BLIND_TEXT = "盲注"
    STR_MTT_REALTIMES_BLIND_TITLE_ANTE_TEXT = "前注"
    STR_MTT_REALTIMES_BLIND_TITLE_BLINDTIME_TEXT = "漲盲時間"

    STR_MTT_MAINSCENE_START_TIPS_TEXT = "距比賽開始"
    STR_MTT_GOBACK_BUTTON_TITLE_TEXT = "返回牌局"

    MAINSCENE_START_BUTTON_TEXT = "開始"
    MAINSCENE_SHARE_BUTTON_TEXT = "分享"

    STR_PLAYER_CANCEL_DELEGATE_TEXT = "返回牌局"
    STR_PLAYER_SITDOWN_BACK_TEXT = "回到座位"

    --UI设置控件---------
    IMAGE_MATCHSTATISTICSNODE_OMAHALOGOIMAGE = "game/game_layer/cns/matchstatistics/omahagame_logo_fanti.png"
    IMAGE_MATCHSTATISTICSNODE_INSURANCEIMAGE = "game/game_layer/cns/insurance/insurance_baoxianju_fanti.png"
    IMAGE_MATCHSTATISTICSNODE_SHORTDUCKLOGOIMAGE = "game/game_layer/cn/matchstatistics/shortduck_logo.png"
    
    IMAGE_SNGMAINMENUNODE_RULESDETAILSIMAGE = "game/game_layer/common/sng/sng_time_fanti.png"
    
--    IMAGE_INSURANCEINFOMAINCHILDNODE_TIPSIMAGE = "game/game_layer/common/insurance/insurance_info_odds_fanti.png"
--    IMAGE_INSURANCEINFOMAINCHILDNODE_OMAHA_TIPSIMAGE = "game/game_layer/common/insurance/omaha_insurance_info_odds_fanti.png"


    --根据主题不同，替换按钮图
    PLAYER_SELF_OPERATE_FREE_RAISE_BUTTON_ICON = "game/game_layer/common/ic_operate_blue_big.png"
    PLAYER_SELF_OPERATE_FREE_RAISE_BUTTON_SELECTED_ICON = "game/game_layer/common/ic_operate_blue_big_press.png"
    PLAYER_SELF_OPERATE_POT_AND_BLIND_BUTTON_ICON = "game/game_layer/common/ic_operate_blue_small.png"
    PLAYER_SELF_OPERATE_POT_AND_BLIND_BUTTON_PRESSED_ICON = "game/game_layer/common/ic_operate_blue_small_press.png"

    STR_PLAYER_SELF_FREERAISE_BUTTON_TITLE_TEXT = "自由加注"
    STR_PLAYER_SELF_ENSURE_BUTTON_TITLE_TEXT = "確認"
    STR_PLAYER_SELF_CHECK_BUTTON_TITLE_TEXT = "看牌"
    STR_PLAYER_SELF_CALL_BUTTON_TITLE_TEXT = "跟注"
    STR_PLAYER_SELF_FOLD_BUTTON_TITLE_TEXT = "棄牌"
    STR_PLAYER_SELF_ALLIN_BUTTON_TITLE_TEXT = "Allin"
    STR_PLAYER_SELF_BLIND_BUTTON_TITLE_TEXT = "大盲"
    STR_PLAYER_SELF_ANTE_BUTTON_TITLE_TEXT = "前注"
    STR_PLAYER_SELF_POT_BUTTON_TITLE_TEXT = "底池"
    STR_PLAYER_SELF_AUTO_CHECK_CHECKBOX_TITLE_TEXT = "自動看牌"
    STR_PLAYER_SELF_AUTO_CALL_CHECKBOX_TITLE_TEXT = "自動跟注"
    STR_PLAYER_SELF_AUTO_QUIT_CHECKBOX_TITLE_TEXT = "看牌/棄牌"

    STR_PLAYER_EMPTY_TITLE_TEXT = "空位"
    STR_PLAYER_OPEN_TITLE_TEXT = "坐下"

    --公用底层按钮 有2种
    COMMON_BACKIMAGE_BUTTON_NORMAL_IMAGE = "game/game_layer/common/btn_blank-i6p.png"
    COMMON_BACKIMAGE_BUTTON_MASK_IMAGE = "game/game_layer/common/dark.png"
    STR_SHORT_POKER_TYPE_PATH = "game/game_layer/common/prompt/ic_prompt_image%d.png"
    
    --牌型提示牌型文字
    STR_PROMPT_RULES_TEXT_LIST = {}
    STR_PROMPT_RULES_TEXT_LIST[1] = "皇家同花順"
    STR_PROMPT_RULES_TEXT_LIST[2] = "同花順"
    STR_PROMPT_RULES_TEXT_LIST[3] = "四條"
    STR_PROMPT_RULES_TEXT_LIST[4] = "葫蘆"
    STR_PROMPT_RULES_TEXT_LIST[5] = "同花"
    STR_PROMPT_RULES_TEXT_LIST[6] = "順子"
    STR_PROMPT_RULES_TEXT_LIST[7] = "三條"
    STR_PROMPT_RULES_TEXT_LIST[8] = "兩對"
    STR_PROMPT_RULES_TEXT_LIST[9] = "一對"
    STR_PROMPT_RULES_TEXT_LIST[10] = "高牌"

    STR_OTHERINFO_GPS_POS_TEXT = "距離 "
    STR_OTHERINFO_GPS_NO_POS_TEXT = "未開啟定位"
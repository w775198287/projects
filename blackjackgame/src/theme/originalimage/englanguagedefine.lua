
--G_LANGUAGE_ENGLISH = 2 --英文

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


  --MICROPHONE_CANCER_ICON = "game/game_layer/common/english_pic_mic_cancer-i6p.png", --语音按下发送
  --MICROPHONE_PRESSED_ICON = "game/game_layer/common/english_pic_mic_pressed-i6p.png", --语音按上滑取消发送
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
        USER_STATE_TEXT_CHECK = "Check",
        USER_STATE_TEXT_FOLD = "Fold",
        USER_STATE_TEXT_CALL = "Call",
        USER_STATE_TEXT_RAISE = "Raise",
        USER_STATE_TEXT_ALLIN = "ALLIN",
        USER_STATE_TEXT_YANSHI = [[Extend 
Time]],
        USER_STATE_TEXT_WAIT = "Waiting",
        USER_STATE_TEXT_STRADDLE = "Straddle",
    }

    MAINSCENE_BG_IMAGE = "game/game_layer/common/desktop_background_4.png" --桌面主题背景

    --MAINSCENE_BG_TEXT_COLOR = cc.c3b(31,45,80) --桌面主题背景 文字颜色
    MAINSCENE_BG_TEXT_COLOR = cc.c3b(255,255,255)
    MAINSCENE_BG_TEXT_OPACITY = 0.4 * 255

    POKER_CT_NAME={}
    POKER_CT_NAME[CT_SINGLE]=[[High card]]
    POKER_CT_NAME[CT_ONE_LONG]=[[A pair]]
    POKER_CT_NAME[CT_TWO_LONG]=[[Two pairs]]
    POKER_CT_NAME[CT_THREE_TIAO]=[[Three of
a kind]]
    POKER_CT_NAME[CT_SHUN_ZI]=[[Straight]]
    POKER_CT_NAME[CT_TONG_HUA]=[[Flush]]
    POKER_CT_NAME[CT_HU_LU]=[[Full House]]
    POKER_CT_NAME[CT_TIE_ZHI]=[[Four of
a kind]]
    POKER_CT_NAME[CT_TONG_HUA_SHUN]=[[Straight
Flush]]
    POKER_CT_NAME[CT_KING_TONG_HUA_SHUN]=[[Royal
Flush]]

    --operation
    STR_OPERATION_TEXT_MENU = "Menu"
    STR_OPERATION_TEXT_SHARE_GAME = "Share"
    STR_OPERATION_TEXT_STAND_UP = "Stand up & Watch"
    STR_OPERATION_TEXT_OPTIONS = "Options"
    STR_OPERATION_TEXT_POKER_HANDS_HINTS = "Poker hand ranks"
    STR_OPERATION_TEXT_CHANGE_CARD_COLOUR = "4 Colour cards"
    STR_OPERATION_TEXT_CHANGE_CARD_COLOUR_CLASSIC = "Classic cards"
    STR_OPERATION_TEXT_TEMPORARILYLEAVE = "Sit Out"
    STR_OPERATION_TEXT_HELPER = "Auto Check/Fold"
    STR_OPERATION_TEXT_INSURANCE_HINTS = "Insurance"
    STR_OPERATION_TEXT_BUY_IN = "Buyin"
    STR_OPERATION_TEXT_CASH_OUT = "Cash out chips"
    STR_OPERATION_TEXT_GO_TO_SHOP = "Store"
    STR_OPERATION_TEXT_EXIT_GAME = "Exit game"

    STR_OPERATION_TEXT_REWARD_RULES = "Reward rules"
    STR_OPERATION_TEXT_LEAVE_GAME = "Leave game"

    --mtt
    STR_OPERATION_TEXT_MTT_SIGNUP = "Register"
    STR_OPERATION_TEXT_MTT_LEAVE_GAME = "Exit"

    --文字文本
    STR_TEXT_DEFAULT = ""
    STR_TEXT_WAIT = "Waiting"
    STR_TEXT_FREE = "Free"
    STR_TEXT_NOT_ENOUGH = "No enough"
    STR_TEXT_ADD_FRIEND_HINT = "Just sent you a friend request."
    STR_TEXT_VOICE_CANCEL = "Release to cancel "
    STR_TEXT_VOICE_SEND = "Slide up to cancel"
    STR_TEXT_ROOM_NAME = "* %s *"
    STR_TEXT_ROOM_BLINDS_STR = "Blinds"
    STR_TEXT_ROOM_BLINDS = " %d/%d"
    STR_TEXT_ROOM_ANTE_BLINDS = " %d/%d (%d)"
    STR_TEXT_ROOM_SHORTDUCK_ANTE = "ANTE: "
    STR_TEXT_ROOM_SHORTDUCK_STRAIGHT = "  Straight > 3 of a kind"
    STR_TEXT_ROOM_SHORTDUCK_THREE = "  3 of a kind > Straight"
    STR_TEXT_ROOM_SHORTDUCK_ANTE_TWO = "ANTE 2x for Dealer"
    STR_TEXT_ROOM_SHORTDUCK_HOLD_MIN = "Min. holding chips: "
    STR_TEXT_ROOM_INVITE = "Invite code: "
    STR_TEXT_ROOM_CONTROLINTO = "Buy-in Conf."
    STR_TEXT_ROOM_INSURANCE = "Ins."
    STR_TEXT_AUDIO_TIME = "%d'"
    STR_TEXT_FORMAT_FLOAT = "%d.%d"
    STR_TEXT_FORMAT_K = "%.2fK"
    STR_TEXT_FORMAT_K1 = "%.1fK"
    STR_TEXT_FORMAT_K0 = "%dK"
    STR_TEXT_FORMAT_D = "%02d"
    STR_TEXT_CONTINUE_TIME = "+%d"
    STR_TEXT_ALL_POOL = "Pot: "
    STR_TEXT_POKER_FACE = "game/game_layer/ingame_poker/normal/poker_%d.png"
    STR_TEXT_SURPLUS_TIME = "%d"
    STR_TEXT_WIN_CHIP_NUM = "+"
    STR_TEXT_RAISE_MAX_CHIP = "allin"
    STR_TEXT_RAISE_MAX_POT_CHIP = "pot"
    STR_TEXT_POKER_FACE_FOURCOLOR = "game/game_layer/ingame_poker/fourcolor/poker_%d.png"

    STR_TEXT_WAITTING_1 = [[Wait to start]]
    STR_TEXT_WAITTING_2 = [[PokerMaster, Fun between friends!
    Wait to start]]
    STR_TEXT_WAITTING_3 = [[Wait to start]]
    STR_TEXT_WAITTING_4 = [[Choose your seat]]

    STR_TEXT_WAITTING_5 = [[ ..]]
    STR_TEXT_WAITTING_6 = [[. .]]
    STR_TEXT_WAITTING_7 = [[.. ]]

    STR_TEXT_GO_TO_SHOP_COIN_TEXT = [[No enough Coins, purchase more Coins
    please go to Store]]
    STR_TEXT_GO_TO_SHOP_COIN_BUTTON_TEXT = "Purchase"
    STR_TEXT_GO_TO_SHOP_DIAMOND_TEXT = [[No enough Gems, purchase more Gems
    please go to Store]]
    STR_TEXT_GO_TO_SHOP_DIAMOND_BUTTON_TEXT = "Purchase"


    LODING_ANIMATE_IMAGE = "loading/loading_000%d@2x.png"
    WIN_ANIMATE_IMAGE = "game/game_layer/common/you_win/anim_youwin%d-i6p.png"

    STR_TEXT_TIME_TIPS_5 = "This game will end in 5mins"
    STR_TEXT_TIME_TIPS_1 = "This game will end in 1min"

    STR_TEXT_REVIEW_POKER_TYPE_TEXT = "Fold"
    STR_TEXT_REVIEW_COLLECTION_NUM_TEXT = "%d/%d"

    STR_TEXT_CONTROL_ENABLE_TIPS = "Buyin confirmation on "
    STR_TEXT_CONTROL_DISABLE_TIPS = "Buyin confirmation off"
    STR_TEXT_CONTROL_DENY_TIPS = [[Your buyin request
been rejected]]

    STR_TEXT_CONTROL_DENY = "Reject %ds"

    STR_TEXT_CONTROL_ENABLE_WAITTING = [[Buyin request sent
waiting %ds...]]
    
    STR_TEXT_PAUSE_TIPS_TEXT = "Pause"
    STR_TEXT_PAUSE_WAITTING = [[Waiting %s...]]

    STR_TEXT_SIT_DOWN_OTHER_USER_BUYIN_WAITTING = [[Buyin confirm
%ds]]


    STAND_PLAYER_PLAY_SOUND_IMAGE = "game/game_layer/common/sound_others_%d@2x.png"

    STR_TEXT_ADD_FRIEND_SEND_TIPS = "Sent"
    STR_TEXT_COLLECTION_TIPS = "Saved"
    STR_TEXT_COLLECTION_FAULT_TIPS = "Save failed"
    STR_TEXT_REMOVE_COLLECTION_TIPS = [[Cancel collection]]
    STR_TEXT_REMOVE_COLLECTION_FAULT_TIPS = [[Cancel collection failed]]

    STR_TEXT_REMARK_TIPS = [[Please enter under 
the limit.]]
    STR_TEXT_STANDBY_NUM_TEXT = "%d people"
    ---sng
    STR_TEXT_SNG_RULESDETAILS_RANK_TEXT = ""

    STR_TEXT_SNG_ROOM_BLINDS = " Players "
    STR_TEXT_SNG_ROOM_BLINDS_END = "Blinds "
    STR_TEXT_SNG_RULESDETAILS_ROOM_BLIND_INTERVAL = "%d players  raise blinds: %d mins"
    STR_TEXT_SNG_MIDWAY_LEAVE_TIPS = [[You can back to the game after
you left, wanna leave?]]
    STR_TEXT_SNG_LEAVE_TIPS = [[Wanna leave?]]

    STR_TEXT_SNG_GAME_ROOM_USER_MAX_NUMS = "%d players"
    STR_TEXT_SNG_RANK_TEXT = {}
    STR_TEXT_SNG_RANK_TEXT[1]="1st Place"
    STR_TEXT_SNG_RANK_TEXT[2]="2nd Place"
    STR_TEXT_SNG_RANK_TEXT[3]="3rd Place"
    STR_TEXT_SNG_RANK_TEXT[4]="4th Place"
    STR_TEXT_SNG_RANK_TEXT[5]="5th Place"
    STR_TEXT_SNG_RANK_TEXT[6]="6th Place"
    STR_TEXT_SNG_RANK_TEXT[7]="7th Place"
    STR_TEXT_SNG_RANK_TEXT[8]="8th Place"
    STR_TEXT_SNG_RANK_TEXT[9]="9th Place"

    STR_TEXT_SNG_RANK_AWARD_TEXT = "Bonus: %d"
    STR_TEXT_SNG_ELIMINATE_TEXT = "Good Luck!"
    STR_TEXT_SNG_ELIMINATE_TIPS_TEXT = "Sorry,you're out..."
    STR_TEXT_SNG_RANK_AWARD_TIPS_TEXT = "Congrats! Get the %s"
    STR_TEXT_SNG_SIGNUP_BEGIN_TEXT = "Wait for "
    STR_TEXT_SNG_SIGNUP_END_TEXT = " more players to start"

    STR_TEXT_SNG_RICHTEXT_RANKING_BEGIN_TEXT = ""
    STR_TEXT_SNG_RICHTEXT_RANKING_MIDDLE_TEXT = {}
    STR_TEXT_SNG_RICHTEXT_RANKING_MIDDLE_TEXT[1] = "1st"
    STR_TEXT_SNG_RICHTEXT_RANKING_MIDDLE_TEXT[2] = "2nd"
    STR_TEXT_SNG_RICHTEXT_RANKING_MIDDLE_TEXT[3] = "3rd"
    STR_TEXT_SNG_RICHTEXT_RANKING_MIDDLE_TEXT[4] = "4th"
    STR_TEXT_SNG_RICHTEXT_RANKING_MIDDLE_TEXT[5] = "5th"
    STR_TEXT_SNG_RICHTEXT_RANKING_MIDDLE_TEXT[6] = "6th"
    STR_TEXT_SNG_RICHTEXT_RANKING_MIDDLE_TEXT[7] = "7th"
    STR_TEXT_SNG_RICHTEXT_RANKING_MIDDLE_TEXT[8] = "8th"
    STR_TEXT_SNG_RICHTEXT_RANKING_MIDDLE_TEXT[9] = "9th"
    STR_TEXT_SNG_RICHTEXT_RANKING_END_TEXT = " Place"

    STR_TEXT_SNG_UP_BLIND_TIP_TIPS_BEGIN_TEXT = "Next blinds   "
    STR_TEXT_SNG_UP_BLIND_TIP_TIPS_END_TEXT = "%d/%d"

    STR_TEXT_SNG_SIGNUP_STARTED_TEXT = "Game started"
    STR_TEXT_SNG_SIGNUP_PREPARE_BEGIN_TEXT = "Game will start in "
    STR_TEXT_SNG_SIGNUP_PREPARE_END_TEXT = " sec"
    --结束获奖排位图标
    SNG_AWARD_FINISH_BILL_RANKING_ICON = "game/game_layer/common/sng/sng_%dcup_big_hd.png"
    --SNG排名
    SNG_RANKING_ICON = "game/game_layer/common/ic_sngrank_image.png"
    SNG_RANKING_TEXT = "No.%d"
    --SNG托管状态
    SNG_DELEGATE_ICON = "game/game_layer/common/ic_delegate_image.png"
    SNG_DELEGATE_TEXT = "Auto Fold"
    --
    SNG_BILL_RANKING_ICON = "game/game_layer/common/sng/sng_%dcup_icon.png"
    --sng控制买入提示
    SNG_STR_TEXT_CONTROL_AGREE_TIPS = [[%s
Your request was 
accpepted.]]

    SNG_STR_TEXT_CONTROL_DENY_TIPS = [[%s
Your request was 
denied.]]

    SNG_STR_TEXT_HAND_NUM = "No.%d Hand"
    INSURANCE_STR_TEXT_BREAKEVEN_TEXT = "Secure"
    INSURANCE_STR_TEXT_ALL_BREAKEVEN_TEXT = "All secure"
    INSURANCE_STR_TEXT_FULLPOOL_TEXT = "Max."
    INSURANCE_STR_TEXT_ALL_FULLPOOL_TEXT = "All Max."

    INSURANCE_STR_TEXT_BET_FOLD_ICON = "game/game_layer/common/ic_insurance_bubao.png"
    INSURANCE_STR_TEXT_BET_STACKS_ICON = "game/game_layer/common/ic_insurance_toubao_peifu.png"
    INSURANCE_STR_TEXT_GET_STACKS_ICON = "game/game_layer/common/ic_insurance_toubao_peifu.png"
    INSURANCE_STR_TEXT_GET_GOU_MAI_ICON = "game/game_layer/common/ic_insurance_goumai.png"

    INSURANCE_STR_TEXT_BET_STACKS_TEXT = "Insure "
    INSURANCE_STR_TEXT_BET_FOLD_TEXT = "Passed"
    INSURANCE_STR_TEXT_GET_STACKS_TEXT = "Claimed "
    INSURANCE_STR_TEXT_GET_GOU_MAI_TEXT = "Buying %ds"

    INSURANCE_STR_TEXT_TIPS_BUYIN_ICON = "game/game_layer/eng/insurance/english_insurance_buyin_tips_anims/insurance_buyin_tips_%d.png"

    INSURANCE_STR_TEXT_BUYIN_OK_TEXT = "Buy"
    INSURANCE_STR_TEXT_BUYIN_OK_ENABLED_TEXT = "Select Pots"
    INSURANCE_STR_TEXT_MAIN_POT = "Main Pot"
    INSURANCE_STR_TEXT_SPLIT_POT = "Split Pot"

    INSURANCE_STR_TEXT_POT_MAIN_TEXT ="M"
    INSURANCE_STR_TEXT_TIPS_NO_BUYIN_TEXT="outs>14 or outs=0，Can’t purchase insurance"
    INSURANCE_STR_TEXT_TIPS_NO_BUYIN_TEXT_SHORTDUCK="outs>13 or outs=0，Can’t purchase insurance"
    INSURANCE_STR_TEXT_TIPS_AUTO_BUYIN_TEXT="Mandatory purchase of insurance fee %d Coins"
    INSURANCE_STR_TEXT_TIPS_NO_BUYIN_POOL_TEXT="Insurance is sold for pot more the 32 Coins."

    REVIEW_STR_TEXT_INSURANCE_STACKS_TEXT = "Sum assured： "

    INSURANCE_STR_ODDS_TEXT = "0"
    INSURANCE_STR_FULLPOLL_TEXT = "Full Pool"
    INSURANCE_STR_MAXPOLL_TEXT = "MAX"
    INSURANCE_STR_OVEROUTS_TIPS_TEXT = "Please choose at least %d cards"
    INSURANCE_STR_CHOOSE_OUTS_FULL_TIPS_TEXT = "Please choose no more than 14 cards"

    REVIEW_STR_TEXT_INSURANCE_NO_SEL_POT_TEXT = "Tap select"
    REVIEW_STR_TEXT_INSURANCE_SEL_POT_TEXT = "Selected"

    --保险碎了图标
    INSURANCE_SUI_ICON = "game/game_layer/eng/insurance/english_insurance_anmi.png"

    --水印
    NORMAL_GAME_TYPE_LOG_ICON = "game/game_layer/common/gamelogo/english_game.png"
    SNG_GAME_TYPE_LOG_ICON = "game/game_layer/common/gamelogo/english_sng.png"
    SIX_GAME_TYPE_LOG_ICON = "game/game_layer/common/gamelogo/english_6game.png"
    OMAHA_GAME_TYPE_LOG_ICON = "game/game_layer/common/gamelogo/english_omaha.png"
    MTT_GAME_TYPE_LOG_ICON = "game/game_layer/common/gamelogo/mtt_gamelogo_eng.png"
    SHORT_DECK_TYPE_LOG_ICON =  "game/game_layer/common/gamelogo/english_shortduck.png"

    --过渡界面水印
    LOADING_GAME_LOGO_ICON = "game/game_layer/common/transition/transition_logo_e.png"

    KICK_GAME_ROOM_TEXT = " has been removed from the game."
    KICK_GAME_ROOM_OTHER_ROOM_TEXT = "You have been removed from the game "

    END_GAME_ROOM_FORWARD_TEXT = "Host dismiss the table "

    --IP限制文本
    IP_LIMIT_TEXT = "IP"
    GPS_LIMIT_TEXT = "GPS"
    IP_AND_GPS_LIMIT_TEXT = "GPS IP"

    --straddle设置文本
    STRADDLE_OPEN_TEXT = "  Straddle"

    --强制站起
    FORCE_STANDUP_TEXT = "You been force to stand up by game host."
    FORCE_STANDUP_OTHERROOM_TEXT = "You been force to stand up by game host %s."
    FORCE_STANDUP_OTHERS_TEXT = " been force to stand up by game host."

    FORCE_OPEN_STANDUP_WEAKTIP_TEXT = "Host turn on Straddle."

    FORCE_CLOSE_STANDUP_WEAKTIP_TEXT = "Host turn off Straddle."

    --思考时间
    THINKING_INTERVAL_TEXT = [[Thinking time changed to %ss by host,
            effecting on next hand.]]

    --show ID
    OTHERINFO_SHOW_ID_TEXT = "ID:"

    --MTT
    MTT_DESK_NUM_TEXT={}
    MTT_DESK_NUM_TEXT[1] = "Table "
    MTT_DESK_NUM_TEXT[2] = ""
    MTT_DESK_STAKE_TEXT = "%d/%d"
    MTT_AWARD_RANK_TEXT = "Top %d"
    MTT_AWARD_RANK_POS_TEXT = "%d Place"
    MTT_AWARD_RANK_STR_TEXT = "%s Place"
    MTT_AWARD_BONUS_TEXT = "Prize: "
    MTT_BLIND_TIME_TEXT = "%d mins"
    MTT_BLIND_STRUCT_TEXT = "%d/%d/(%d)"
    MTT_BLIND_STRUCT_NOANTE_TEXT = "%d/%d"
    MTT_MAINSCENE_BLIND_TEXT = "Blinds:"
    MTT_MAINSCENE_DESK_TIME_TEXT01 = "00:%d"
    MTT_MAINSCENE_DESK_TIME_TEXT02 = "00:0%d"
    MTT_MAINSCENE_DESK_TIME_TEXT03 = "00:00"
    MTT_REVIEW_DESKNUM_TEXT = "Table %d"
    MTT_MATCH_DATA_NO_BLINDTIME_TEXT = "--:--:--"
    MTT_MATCH_DATA_NO_DATA_TEXT = "--"
    MTT_MATCH_DATA_NO_BLINDSTRUCT_TEXT = "--/--/(--)"
    MTT_MATCH_DATA_NO_USEDTIME_TEXT = "00:00:00"

    MTT_RANK_TEXT={}
    MTT_RANK_TEXT[1] = "Champion"
    MTT_RANK_TEXT[2] = "2nd Place"
    MTT_RANK_TEXT[3] = "3rd Place"

    MTT_OTHER_RANK_TEXT = "%d Place"

    MTT_WATCH_DESK_FINISH_TEXT = "The table has been closed."
    MTT_WATCH_FINISH_TEXT = "Tournament has ended"

    MTT_DESK_STATE_REENTRY_TEXT = "Reentering"
    MTT_DESK_STATE_DELAY_TEXT = "Late Reg."

    MTT_REENTRY_FEE_POPULARITY_TEXT = "Reenter using %d coins or an equivalent ticket "
    MTT_REENTRY_FEE_TICKET_TEXT = "Reenter with corresponding ticket?"
    MTT_REENTRY_GET_STACKS_TEXT = "for %d chips"

    MTT_SIGNUP_REQUIREMENT_COIN_TEXT = "%d coins or equivalent ticket"
    MTT_SIGNUP_REQUIREMENT_TICKET_TEXT = "Equivalent ticket"

    MTT_START_PUSH_TEXT = "is being seated. Good luck!"
    MTT_START_FULL_TABLE_PUSH_TEXT = "Table is fully seated, please start game!"
    MTT_START_CANCEL_PUSH_TEXT = "is cancelled, your registration will be refunded."
    MTT_START_PUSH_ENTER = "Enter"
    MTT_START_PUSH_BACK = "Enter"

    MTT_SYSTEM_PUSH_GIVECARD_SAMETIME_TEXT = "Hand for hand in progress."
    MTT_SYSTEM_PUSH_CHANGE_DESK_TEXT = "You have been moved to a new table."
    MTT_SYSTEM_PUSH_CHANGE_DESK_TEXT02 = "Observed table invalid, you have been returned to your table"
    MTT_DELAY_REGISTER_FINISH_DESK_TEXT = "The reentry period have ended."
    MTT_SYSTEM_PUSH_BLIND_UP_DESK_TEXT = "Blinds increasing to : "

    MTT_SYSTEM_PUSH_NORMAL_TEXT = "You will leave the game if you join the tournament now, join now?"
    MTT_SYSTEM_PUSH_FULL_TABLE_TEXT = "You will leave the game if you join the table, join now?"
    MTT_SYSTEM_PUSH_SNG_OR_MTT_TEXT = "You will sit out if you join the tournament now, join now?"

    MTT_INTRODUCE_PAG_DELAY_TEXT = "To level %d."
    MTT_INTRODUCE_PAG_REENTRY_TEXT = "To level %d,max %d times."

    MTT_INTRODUCE_PAG_SIGNUP_STR = "Cap:"
    MTT_INTRODUCE_PAG_STACKS_STR = "Starting Stack:"
    MTT_INTRODUCE_PAG_DELAY_STR = "Late Reg:"
    MTT_INTRODUCE_PAG_REENTRY_STR = "Reentry:"
    MTT_INTRODUCE_PAG_COIN_TEXT = "%d Coins"

    --文字牌谱
    STR_POKERTEXTINFO_STATE_PREFLOP_TEXT = "Preflop"
    STR_POKERTEXTINFO_STATE_FLOP_TEXT = "Flop"
    STR_POKERTEXTINFO_STATE_TURN_TEXT = "Turn"
    STR_POKERTEXTINFO_STATE_RIVER_TEXT = "River"
    STR_POKERTEXTINFO_HIDENAME_TEXT = "Anonymous"
    STR_POKERTEXTINFO_INSURANCE_TEXT = "Insurance:"
    STR_POKERTEXTINFO_PROCESS_TEXT = "Hand process"
    STR_POKERTEXTINFO_HANDRESULT_TEXT = "Hand result"
    STR_POKERTEXTINFO_SHOWDOWN_TEXT = "Showdown"

    POKERTEXTINFO_FOLD_ICON = "game/game_layer/common/pokertextinfo/fold_icon.png"
    POKERTEXTINFO_CALL_ICON = "game/game_layer/common/pokertextinfo/call_icon.png"
    POKERTEXTINFO_RAISE_ICON = "game/game_layer/common/pokertextinfo/raise_icon.png"
    POKERTEXTINFO_POKER_FACE_ICON = "game/game_layer/common/pokertextinfo/poker_%d.png"
    POKERTEXTINFO_POKER_BACK_FACE_ICON = "game/game_layer/common/pokertextinfo/poker_en.png"

    INSURANCE_HELP_URL = "http://upyun.pokermate.net/web/en/insurance_instruction.html"
    INSURANCE_OMAHA_HELP_URL = "http://upyun.pokermate.net/web/en/omaha_insurance_instruction.html"

    --個人設置介面
    STR_SETTING_SELFTITLE_TEXT = "Personal Options"
    STR_SETTING_ADVANCETITLE_TEXT = "Host Options"

    STR_SETTING_SELF_RAISESTR_TEXT = "Default Raise"
    STR_SETTING_SELF_CARDSTR_TEXT = "Table Colour"
    STR_SETTING_SELF_MUTE_TEXT = "Game Sound"
    STR_SETTING_SELF_TALK_MUTE_TEXT = "Chatting Sound"
    STR_SETTING_SELF_INSURANCE_STR_TEXT = "Hide Insurance"
    STR_SETTING_SELF_INSURANCE_TIPSSTR_TEXT = "(For this table only)"
    STR_SETTING_SELF_RAISE_STR_TEXT = "Slider + Confirm"
    STR_SETTING_SELF_RAISE_TIPS_TEXT = [[Set Default Raise Customize your own raise amount]]

    SETTING_SELF_RAISEPOT_ALLIN_STR = "Allin"
    SETTING_SELF_RAISEPOT_1XPOT_STR = "1x"
    SETTING_SELF_RAISEPOT_1PT5XPOT_STR = "1.5x"
    SETTING_SELF_RAISEPOT_NIL_STR = "N/A"

    SETTING_SELF_TABLECOLOR01_STR = ""
    SETTING_SELF_TABLECOLOR02_STR = ""
    SETTING_SELF_TABLECOLOR03_STR = ""
    SETTING_SELF_TABLECOLOR04_STR = "" 

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
    PLAYER_TEMPORARILYLEAVE_TEXT = " Sitting Out"
    PLAYER_TEMPORARILYLEAVE_TIME_TEXT = "%ds"
    PLAYER_TEMPORARILYLEAVE_TIPS_TEXT = "Sit out after this hand."

    --错误
    ERROR_TEXT_TYPE_ENUM={}
    ERROR_TEXT_TYPE_ENUM[1]=[[User doesn’t exist。]]
    ERROR_TEXT_TYPE_ENUM[2] = [[Chat doesn’t exist。]]
    ERROR_TEXT_TYPE_ENUM[3] = [[This phone number
already been registered。]]
    ERROR_TEXT_TYPE_ENUM[4] = [[Verify code error,
retry please。]]
    ERROR_TEXT_TYPE_ENUM[5] = [[Account ID or password wrong,
retry please。]]
    ERROR_TEXT_TYPE_ENUM[6] = [[You are not friends yet。]]
    ERROR_TEXT_TYPE_ENUM[7] = [[You are not friends yet。]]
    ERROR_TEXT_TYPE_ENUM[8] = [[Reached the members limit。]]
    ERROR_TEXT_TYPE_ENUM[9] = [[Reached your VIP limit。]]
    ERROR_TEXT_TYPE_ENUM[10] = [[Unknown server error。]]
    ERROR_TEXT_TYPE_ENUM[11] = [[Game doesn’t exist。]]
    ERROR_TEXT_TYPE_ENUM[12] = [[Game is full。]]
    ERROR_TEXT_TYPE_ENUM[13] = [[No enough Coins, purchase more
Coins please go to Store]]
    ERROR_TEXT_TYPE_ENUM[14] = [[You are not friends yet。]]
    ERROR_TEXT_TYPE_ENUM[15] = [[Reached your share limit。]]
    ERROR_TEXT_TYPE_ENUM[16] = [[Rewarded。]]
    ERROR_TEXT_TYPE_ENUM[17] = [[Record doesn’t exist。]]
    ERROR_TEXT_TYPE_ENUM[18] = [[Collection doesn’t exist。]]
    ERROR_TEXT_TYPE_ENUM[19] = [[Data uncompleted。]]
    ERROR_TEXT_TYPE_ENUM[20] = [[Purchase error。]]
    ERROR_TEXT_TYPE_ENUM[21] = [[No enough Gems, purchase more
Coins please go to Store。]]
    ERROR_TEXT_TYPE_ENUM[22] = [[Insufficient permissions。]]
    ERROR_TEXT_TYPE_ENUM[23] = [[Only group leader allowed
to remove。]]
    ERROR_TEXT_TYPE_ENUM[24] = [[Only group leader allowed
to setting group options。]]
    ERROR_TEXT_TYPE_ENUM[25] = [[Only group leader allowed
to invite。]]
    ERROR_TEXT_TYPE_ENUM[26] = [[Users does’t exist。]]
    ERROR_TEXT_TYPE_ENUM[27] = [[Your account just login
on another device。]]
    ERROR_TEXT_TYPE_ENUM[28] = [[Unknown error。]]
    ERROR_TEXT_TYPE_ENUM[29] = [[Seat already taken。]]
    ERROR_TEXT_TYPE_ENUM[30] = [[You can not purchase
lower level VIP card。]]
    ERROR_TEXT_TYPE_ENUM[31] = [[You can not start the game。]]
    ERROR_TEXT_TYPE_ENUM[32] = [[Friend request confirmed。]]
    ERROR_TEXT_TYPE_ENUM[33] = [[Event expired。]]
    ERROR_TEXT_TYPE_ENUM[34] = [[Reached Club members limit。]]
    ERROR_TEXT_TYPE_ENUM[35] = [[Club doesn’t exist。]]
    ERROR_TEXT_TYPE_ENUM[36] = [[Insufficient permissions。]]
    ERROR_TEXT_TYPE_ENUM[37] = [[User doesn’t exist。]]
    ERROR_TEXT_TYPE_ENUM[38] = [[You only can start
one quick game。]]
    ERROR_TEXT_TYPE_ENUM[39] = [[Game doesn’t exist。]]
    ERROR_TEXT_TYPE_ENUM[40] = [[Game already started。]]
    ERROR_TEXT_TYPE_ENUM[41] = [[No enough players。]]
    ERROR_TEXT_TYPE_ENUM[42] = [[User doesn’t exist。]]
    ERROR_TEXT_TYPE_ENUM[43] = [[Purchase fail。]]
    ERROR_TEXT_TYPE_ENUM[44] = [[]]
    ERROR_TEXT_TYPE_ENUM[45] = [[Purchase fail。]]
    ERROR_TEXT_TYPE_ENUM[46] = [[Reached max. chips limit。]]
    ERROR_TEXT_TYPE_ENUM[47] = [[Rewarded。]]
    ERROR_TEXT_TYPE_ENUM[48] = [[Reached Club members limit。]]
    ERROR_TEXT_TYPE_ENUM[49] = [[Insufficient permissions。]]
    ERROR_TEXT_TYPE_ENUM[50] = [[Nickname already exist
please change one。]]
    ERROR_TEXT_TYPE_ENUM[51] = [[Nickname already exist?]]
    ERROR_TEXT_TYPE_ENUM[52] = [[It’s not advance game。]]
    ERROR_TEXT_TYPE_ENUM[53] = [[Fail]]
    ERROR_TEXT_TYPE_ENUM[54] = [[Record doesn’t exist。]]
    ERROR_TEXT_TYPE_ENUM[55] = [[Record doesn’t exist。]]
    ERROR_TEXT_TYPE_ENUM[56] = [[Collection doesn’t exist。]]
    ERROR_TEXT_TYPE_ENUM[57] = [[Request sent, please wait
for confirmation。]]
    ERROR_TEXT_TYPE_ENUM[58] = [[User doesn’t exist。]]
    ERROR_TEXT_TYPE_ENUM[59] = [[Did not request to buy-in.]]
    ERROR_TEXT_TYPE_ENUM[60] = [[Insufficient permissions。]]
    ERROR_TEXT_TYPE_ENUM[61] = [[You still in a unfinished game。]]
    ERROR_TEXT_TYPE_ENUM[62] = [[Pause error。]]
    ERROR_TEXT_TYPE_ENUM[63] = [[The game not start yet。]]
    ERROR_TEXT_TYPE_ENUM[64] = [[Only creator allowed
to setting options。]]
    ERROR_TEXT_TYPE_ENUM[65] = [[User already exist。]]
    ERROR_TEXT_TYPE_ENUM[66] = [[Reached your collection limit。]]
    ERROR_TEXT_TYPE_ENUM[71] = [[Can't hide insurance
after purchased.]]
    ERROR_TEXT_TYPE_ENUM[72] = [[Can't exit game
when All-In.]]
ERROR_TEXT_TYPE_ENUM[73] = [[Session Expired.
Please log in again.]]
ERROR_TEXT_TYPE_ENUM[74] = [[You have been removed from this game,
you can't rejoin it anymore.]]
ERROR_TEXT_TYPE_ENUM[75] = [[ You are in same location as other 
player in game or you didn’t allow 
app access your location service. 
For ensure fairness you can’t 
join this table.]]
ERROR_TEXT_TYPE_ENUM[76] = [[ You are in same location as other 
player in game or you didn’t allow 
app access your location service. 
For ensure fairness you can’t 
join this table.]]
ERROR_TEXT_TYPE_ENUM[77] = [[ You are in same location as other 
player in game or you didn’t allow 
app access your location service. 
For ensure fairness you can’t 
join this table.]]
ERROR_TEXT_TYPE_ENUM[78] = [[ You are in same location as other 
player in game or you didn’t allow 
app access your location service. 
For ensure fairness you can’t 
join this table.]]
ERROR_TEXT_TYPE_ENUM[79] = [[ Please select your seat first. ]]
ERROR_TEXT_TYPE_ENUM[80] = [[ TYou are in same location as other 
player in game or you didn’t allow 
app access your location service. 
For ensure fairness you can’t 
join this table.]]
ERROR_TEXT_TYPE_ENUM[81] = [[Already reached the Alliance 
capacity.]]
ERROR_TEXT_TYPE_ENUM[82] = [[You don’t have authorisation to 
manage Alliance.]]
ERROR_TEXT_TYPE_ENUM[83] = [[Already reached the create 
Alliances limit.]]
ERROR_TEXT_TYPE_ENUM[84] = [[Already reached the join 
alliances limit.]]
ERROR_TEXT_TYPE_ENUM[85] = [[You don’t have authorisation 
to create Alliance.]]
ERROR_TEXT_TYPE_ENUM[86] = [[The Alliance does’t exist.]]
ERROR_TEXT_TYPE_ENUM[87] = [[You don’t have authorisation 
to see the Alliance details.]]
ERROR_TEXT_TYPE_ENUM[88] = [[You already sent request in 
another Club, you are not allow to 
request here again.]]
ERROR_TEXT_TYPE_ENUM[89] = [[The Alliance is on No disturb 
mode.]]
ERROR_TEXT_TYPE_ENUM[90] = [[Your Club already joined the 
Alliance.]]
ERROR_TEXT_TYPE_ENUM[91] = [[Your Club already quit the 
Alliance.]]
ERROR_TEXT_TYPE_ENUM[92] = [[Alliance join request sent.]]
ERROR_TEXT_TYPE_ENUM[93] = [[This Alliance name already 
existed.]]
ERROR_TEXT_TYPE_ENUM[94] = [[Host amount already reach 
the capacity limit.]]
ERROR_TEXT_TYPE_ENUM[95] = [[You already reached the 
Alliance upper capacity.]]
ERROR_TEXT_TYPE_ENUM[96] = [[This user not allow others 
add friends.]]
ERROR_TEXT_TYPE_ENUM[97] = [[Please quit or disband the 
Alliances before you 
disband this Club.]]
ERROR_TEXT_TYPE_ENUM[98] = [[Club Alliance function still 
under testing. Will available 
in next version.]]
ERROR_TEXT_TYPE_ENUM[99] = [[Ticket Type Error.]]
ERROR_TEXT_TYPE_ENUM[100] = [[Insufficient Ticket.]]
ERROR_TEXT_TYPE_ENUM[101] = [[Sorry, your code have expired.]]
ERROR_TEXT_TYPE_ENUM[102] = [[Sorry, the provided code 
have been used.]]
ERROR_TEXT_TYPE_ENUM[103] = [[Sorry, the provided code 
does not exist.]]
ERROR_TEXT_TYPE_ENUM[104] = [[Sorry, you have already 
registered this tournament.]]
ERROR_TEXT_TYPE_ENUM[105] = [[Sorry, the tournament 
capacity have been reached, 
registration failed.]]
ERROR_TEXT_TYPE_ENUM[106] = [[Sorry, registration closed.]]
ERROR_TEXT_TYPE_ENUM[107] = [[Sorry, insufficient registration 
requirements, registration failed.]]
ERROR_TEXT_TYPE_ENUM[108] = [[Sorry, you can not unregister 
at this time.]]
ERROR_TEXT_TYPE_ENUM[109] = [[Sorry, you can not reenter 
at this time.]]
ERROR_TEXT_TYPE_ENUM[110] = [[Sorry, reentry cap reached, 
reentry failed.]]
ERROR_TEXT_TYPE_ENUM[111] = [[Sorry, insufficient reentry 
requirements, reentry failed.]]
ERROR_TEXT_TYPE_ENUM[112] = [[Sorry, you were eliminated 
from the tournament.]]
ERROR_TEXT_TYPE_ENUM[113] = [[Sorry, the table have 
been closed.]]
ERROR_TEXT_TYPE_ENUM[114] = [[Sorry, the tournament have 
been closed.]]
ERROR_TEXT_TYPE_ENUM[115] = [[Sorry, ticket type mismatch, 
registration failed.]]
ERROR_TEXT_TYPE_ENUM[116] = [[Sorry, tournament cancelled, 
registration failed.]]
ERROR_TEXT_TYPE_ENUM[117] = [[Sorry, ticket type mismatch, 
reentry failed.]]
ERROR_TEXT_TYPE_ENUM[118] = [[Please enter standard characters.]]
ERROR_TEXT_TYPE_ENUM[119] = [[Sorry, the table have 
been closed.]]
ERROR_TEXT_TYPE_ENUM[125] = [[You already cash out in this hand.]]
ERROR_TEXT_TYPE_ENUM[126] = [[Not enough Chips.]]
ERROR_TEXT_TYPE_ENUM[127] = [[带出失败.]]

ERROR_TEXT_TYPE_ENUM[9001] = [[User doesn’t exist。]]
ERROR_TEXT_TYPE_ENUM[9002] = [[No enough Coins.]]
ERROR_TEXT_TYPE_ENUM[9003] = [[Unknown error.]]
ERROR_TEXT_TYPE_ENUM[9004] = [[Bad Network Connection]]
ERROR_TEXT_TYPE_ENUM[9005] = [[Bad network connection detected]]

ERROR_TEXT_TYPE_ENUM[9006] = [[User doesn’t exist.]]
ERROR_TEXT_TYPE_ENUM[9007] = [[No enough Coins.]]
ERROR_TEXT_TYPE_ENUM[9008] = [[Unknown error.]]
ERROR_TEXT_TYPE_ENUM[9009] = [[Bad Network Connection.]]
ERROR_TEXT_TYPE_ENUM[9010] = [[Inner Exception.]]

ERROR_TEXT_TYPE_ENUM[9012] = [[No enough Coins.]]
ERROR_TEXT_TYPE_ENUM[9013] = [[Unknown error.]]
ERROR_TEXT_TYPE_ENUM[9014] = [[Inner Exception.]]
ERROR_TEXT_TYPE_ENUM[9015] = [[User doesn’t exist.]]
ERROR_TEXT_TYPE_ENUM[9016] = [[Invalid Bet.]]
ERROR_TEXT_TYPE_ENUM[9017] = [[Room is full.]]
ERROR_TEXT_TYPE_ENUM[9018] = [[No enough Coins.]]
ERROR_TEXT_TYPE_ENUM[9019] = [[Connection Disconnect.]]

ERROR_TEXT_TYPE_ENUM[600] = [[Game dismissed。]]


    SNG_RANK_TEXT={}
    SNG_RANK_TEXT[1]="1st"
    SNG_RANK_TEXT[2]="2nd"
    SNG_RANK_TEXT[3]="3rd"
    SNG_RANK_TEXT[4]="4th"
    SNG_RANK_TEXT[5]="5th"
    SNG_RANK_TEXT[6]="6th"
    SNG_RANK_TEXT[7]="7th"
    SNG_RANK_TEXT[8]="8th"
    SNG_RANK_TEXT[9]="9th"



    COCOSTUDIO_UI_BUYINCONTROLINVITECHILDNODE = "texaspoker.uilua.english.englishbuyincontrolinvitechildnode"
    COCOSTUDIO_UI_BUYINCONTROLINVITETIPSNODE = "texaspoker.uilua.english.englishbuyincontrolinvitetipsnode"
    COCOSTUDIO_UI_BUYNODE = "texaspoker.uilua.english.englishbuynode"
    COCOSTUDIO_UI_CHECKPROMPTNODE = "texaspoker.uilua.english.englishcheckpromptnode"
    COCOSTUDIO_UI_CASHOUTNODE = "texaspoker.uilua.english.englishcashoutnode"
    COCOSTUDIO_UI_ERRORNODE = "texaspoker.uilua.english.englisherrornode"
    COCOSTUDIO_UI_FACELAYERCHILDLODE = "texaspoker.uilua.english.englishfacelayerchildlode"
    COCOSTUDIO_UI_FACELAYERNODE = "texaspoker.uilua.english.englishfacelayernode"
    COCOSTUDIO_UI_GOTOSHOPNODE = "texaspoker.uilua.english.englishgotoshopnode"
    COCOSTUDIO_UI_LODINGNODE = "texaspoker.uilua.english.englishlodingnode"
    COCOSTUDIO_UI_MAINFRAMEWORK = "uilua.hallscene.mainframework"
    COCOSTUDIO_UI_MAINMENUNODE = "texaspoker.uilua.english.englishmainmenunode"
    COCOSTUDIO_UI_MAINMENUNODE_I4 = "texaspoker.uilua.english.englishmainmenunode_i4"
    COCOSTUDIO_UI_MAINMENUNODE_IPAD = "texaspoker.uilua.english.englishmainmenunode_ipad"
    COCOSTUDIO_UI_MAINMENUNODE_S8 = "texaspoker.uilua.english.englishmainmenunode_s8"
    COCOSTUDIO_UI_MAINSCENE = "texaspoker.uilua.english.englishmainscene"
    COCOSTUDIO_UI_MAINSCENE_I4 = "texaspoker.uilua.english.englishmainscene_i4"
    COCOSTUDIO_UI_MAINSCENE_IPAD = "texaspoker.uilua.english.englishmainscene_ipad"
    COCOSTUDIO_UI_MAINSCENE_S8 = "texaspoker.uilua.english.englishmainscene_s8"
    COCOSTUDIO_UI_MAINSCENE_MTTNODE = "texaspoker.uilua.english.englishmainscene_mttnode"
    COCOSTUDIO_UI_MAINSCENE_MTTNODE_I4 = "texaspoker.uilua.english.englishmainscene_mttnode_i4"
    COCOSTUDIO_UI_MAINSCENE_MTTNODE_IPAD = "texaspoker.uilua.english.englishmainscene_mttnode_ipad"
    COCOSTUDIO_UI_MAINSCENE_NORMALNODE = "texaspoker.uilua.english.englishmainscene_normalnode"
    COCOSTUDIO_UI_MAINSCENE_NORMALNODE_I4 = "texaspoker.uilua.english.englishmainscene_normalnode_i4"
    COCOSTUDIO_UI_MAINSCENE_NORMALNODE_IPAD = "texaspoker.uilua.english.englishmainscene_normalnode_ipad"
    COCOSTUDIO_UI_MAINSCENE_NORMALNODE_S8 = "texaspoker.uilua.english.englishmainscene_normalnode_s8"
    COCOSTUDIO_UI_MAINSCENE_SNGNODE = "texaspoker.uilua.english.englishmainscene_sngnode"
    COCOSTUDIO_UI_MAINSCENE_POOLNODE = "texaspoker.uilua.english.englishmainscene_poolnode"
    COCOSTUDIO_UI_MAINSCENE_CARDNODE = "texaspoker.uilua.english.englishmainscene_cardnode"
    COCOSTUDIO_UI_MAINSCENE_CARDNODE_I4 = "texaspoker.uilua.english.englishmainscene_cardnode_i4"
    COCOSTUDIO_UI_MAINSCENE_CARDNODE_IPAD = "texaspoker.uilua.english.englishmainscene_cardnode_ipad"
    COCOSTUDIO_UI_MAINSCENE_CARDNODE_S8 = "texaspoker.uilua.english.englishmainscene_cardnode_s8"
    COCOSTUDIO_UI_MAINSCENE_INSURANCEBUYINTIPS_NODE = "texaspoker.uilua.english.englishmainscene_insurancebuyintipsnode"
    COCOSTUDIO_UI_MATCHSTATISTICSMAINNODE = "texaspoker.uilua.english.englishmatchstatisticsmainnode"
    COCOSTUDIO_UI_MATCHSTATISTICSMAINNODE_S8 = "texaspoker.uilua.english.englishmatchstatisticsmainnode_s8"
    COCOSTUDIO_UI_MATCHSTATISTICSNODE = "texaspoker.uilua.english.englishmatchstatisticsnode"
    COCOSTUDIO_UI_MATCHUSERSETTLEMENTDATANODE = "texaspoker.uilua.english.englishmatchusersettlementdatanode"

    COCOSTUDIO_UI_OPERATIONNCHILDRENNODE = "texaspoker.uilua.english.englishoperationnchildrennode"
    COCOSTUDIO_UI_OPERATIONNCHILDRENMENUNODE = "texaspoker.uilua.english.englishoperationnchildrenmenunode"
    COCOSTUDIO_UI_OPERATIONNODE = "texaspoker.uilua.english.englishoperationnode"
    COCOSTUDIO_UI_OTHERINFOFACENODE = "texaspoker.uilua.english.englishotherinfofacenode"
    COCOSTUDIO_UI_OTHERINFONODE = "texaspoker.uilua.english.englishotherinfonode"
    COCOSTUDIO_UI_PAUSENODE = "texaspoker.uilua.english.englishpausenode"
    COCOSTUDIO_UI_PLAGERNODE = "texaspoker.uilua.english.englishplagernode"
    COCOSTUDIO_UI_PLAGERNODE_I4 = "texaspoker.uilua.english.englishplagernode_i4"
    COCOSTUDIO_UI_PLAGERNODE_OTHER = "texaspoker.uilua.english.englishplagernode_other"
    COCOSTUDIO_UI_PLAGERNODE_SELF = "texaspoker.uilua.english.englishplagernode_self"
    COCOSTUDIO_UI_PLAGERNODE_SITDOWN = "texaspoker.uilua.english.englishplagernode_sitdown"
    COCOSTUDIO_UI_PLAGERNODE_VACANCY = "texaspoker.uilua.english.englishplagernode_vacancy"
    COCOSTUDIO_UI_PROMPTNODE = "texaspoker.uilua.english.englishpromptnode"
    COCOSTUDIO_UI_REALTIMESITUATIONMAINNODE = "texaspoker.uilua.english.englishrealtimesituationmainnode"
    COCOSTUDIO_UI_REALTIMESITUATIONMAINNODE_S8 = "texaspoker.uilua.english.englishrealtimesituationmainnode_s8"
    COCOSTUDIO_UI_REALTIMESITUATIONNODE = "texaspoker.uilua.english.englishrealtimesituationnode"
    COCOSTUDIO_UI_REALTIMESITUATIONOTHERNODE = "texaspoker.uilua.english.englishrealtimesituationothernode"  
    COCOSTUDIO_UI_REALTIMESITUATIONOTHERHEADIMAGENODE = "texaspoker.uilua.english.englishrealtimesituationheadimagenode"
    COCOSTUDIO_UI_REVIEWCHILDNODE = "texaspoker.uilua.english.englishreviewchildnode"
    COCOSTUDIO_UI_REVIEWMAINNODE = "texaspoker.uilua.english.englishreviewmainnode"  
    COCOSTUDIO_UI_REVIEWMAINNODE_S8 = "texaspoker.uilua.english.englishreviewmainnode_s8"
    COCOSTUDIO_UI_SIGNALTIMENODE = "texaspoker.uilua.english.englishsignaltimenode"
    COCOSTUDIO_UI_SITDOWNBUYNODE = "texaspoker.uilua.english.englishsitdownbuynode"
    COCOSTUDIO_UI_SITDOWNBUYNODE_SHORT = "texaspoker.uilua.english.englishsitdownbuynode_short"
    COCOSTUDIO_UI_SYSTEMNOTIFYNODE = "texaspoker.uilua.english.englishsystemnotifynode"
    COCOSTUDIO_UI_TIMETIPSNODE = "texaspoker.uilua.english.englishtimetipsnode"
    COCOSTUDIO_UI_USERSETTLEMENTDATANODE = "texaspoker.uilua.english.englishusersettlementdatanode"
    COCOSTUDIO_UI_WAITNODE = "texaspoker.uilua.english.englishwaitnode"
    COCOSTUDIO_UI_WATCHNODE = "texaspoker.uilua.english.englishwatchnode"
    COCOSTUDIO_UI_WEAKTIPSNODE = "texaspoker.uilua.english.englishweaktipsnode"
    COCOSTUDIO_UI_SIGNALTIMENODE = "texaspoker.uilua.english.englishsignaltimenode"
    COCOSTUDIO_UI_SIGNALTIMENODE_I4 = "texaspoker.uilua.english.englishsignaltimenode_i4"
    COCOSTUDIO_UI_SIGNALTIMENODE_IPAD = "texaspoker.uilua.english.englishsignaltimenode_ipad"
    COCOSTUDIO_UI_SIGNALTIMENODE_IPHONEX = "texaspoker.uilua.english.englishsignaltimenode_iphonex"

    COCOSTUDIO_UI_SNGAWARDFINISHNODE = "texaspoker.uilua.english.sng.englishsngawardfinishnode"
    COCOSTUDIO_UI_SNGELIMINATEFINISHNODE = "texaspoker.uilua.english.sng.englishsngeliminatefinishnode"
    COCOSTUDIO_UI_SNGELIMINATENODE = "texaspoker.uilua.english.sng.englishsngeliminatenode"
    COCOSTUDIO_UI_SNGFINISHCHILDNODE = "texaspoker.uilua.english.sng.englishsngfinishchildnode"
    COCOSTUDIO_UI_SNGLEAVENODE = "texaspoker.uilua.english.sng.englishsngleavenode"
    COCOSTUDIO_UI_SNGMAINMENUNODE = "texaspoker.uilua.english.sng.englishsngmainmenunode"
    COCOSTUDIO_UI_SNGMAINMENUNODE_I4 = "texaspoker.uilua.english.sng.englishsngmainmenunode_i4"
    COCOSTUDIO_UI_SNGMAINMENUNODE_IPAD = "texaspoker.uilua.english.sng.englishsngmainmenunode_ipad"
    COCOSTUDIO_UI_SNGMAINMENUNODE_S8 = "texaspoker.uilua.english.sng.englishsngmainmenunode_s8"
    COCOSTUDIO_UI_SNGREALTIMESITUATIONMAINNODE = "texaspoker.uilua.english.sng.englishsngrealtimesituationmainnode"
    COCOSTUDIO_UI_SNGREALTIMESITUATIONMAINNODE_S8 = "texaspoker.uilua.english.sng.englishsngrealtimesituationmainnode_s8"
    COCOSTUDIO_UI_SNGREALTIMESITUATIONNODE = "texaspoker.uilua.english.sng.englishsngrealtimesituationnode"
    COCOSTUDIO_UI_SNGRULESDETAILSCHILDNODE = "texaspoker.uilua.english.sng.englishsngrulesdetailschildnode"
    COCOSTUDIO_UI_SNGRULESDETAILSNODE = "texaspoker.uilua.english.sng.englishsngrulesdetailsnode"
    COCOSTUDIO_UI_SNGUSERSETTLEMENTDATANODE = "texaspoker.uilua.english.sng.englishsngusersettlementdatanode"
    COCOSTUDIO_UI_SNGCONTROLBUYINMSGNODE = "texaspoker.uilua.english.sng.englishsngcontrolbuyinmsgnode"

    -- -- -- 新保险
    -- COCOSTUDIO_UI_INSURANCEINFOMAINNODE = "texaspoker.uilua.english.insurance.englishinsuranceinfomainnode"
    -- COCOSTUDIO_UI_INSURANCEINFOMAINCHILDNODE = "texaspoker.uilua.english.insurance.englishinsuranceinfomainchildnode"
    -- COCOSTUDIO_UI_INSURANCEINFOCHILDNODE = "texaspoker.uilua.english.insurance.englishinsuranceinfochildnode"
    -- COCOSTUDIO_UI_INSURANCEBUYINNODE = "texaspoker.uilua.english.insurance.englishinsurancebuyinnode"
    -- COCOSTUDIO_UI_INSURANCEBUYINOPERATENODE = "texaspoker.uilua.english.insurance.englishinsurancebuyinoperatenode"
    -- COCOSTUDIO_UI_INSURANCEBUYINCARD = "texaspoker.uilua.english.insurance.englishinsurancecardnode"
    -- COCOSTUDIO_UI_INSURANCEBUYINTIPS = "texaspoker.uilua.english.insurance.englishinsurancebuyintipsnode"
    -- COCOSTUDIO_UI_INSURANCEBUYINTIPSCHILDNODE = "texaspoker.uilua.english.insurance.englishinsurancebuyintipschildnode"
    
    --旧保险
    COCOSTUDIO_UI_INSURANCEINFOMAINNODE = "texaspoker.uilua.english.insuranceold.englishinsuranceinfomainnode"
    COCOSTUDIO_UI_INSURANCEINFOMAINCHILDNODE = "texaspoker.uilua.english.insuranceold.englishinsuranceinfomainchildnode"
    COCOSTUDIO_UI_INSURANCEINFOCHILDNODE = "texaspoker.uilua.english.insuranceold.englishinsuranceinfochildnode"
    COCOSTUDIO_UI_INSURANCEBUYINNODE = "texaspoker.uilua.english.insuranceold.englishinsurancebuyinnode"
    COCOSTUDIO_UI_INSURANCEBUYINOPERATENODE = "texaspoker.uilua.english.insuranceold.englishinsurancebuyinoperatenode"
    COCOSTUDIO_UI_INSURANCEBUYINCARD = "texaspoker.uilua.english.insuranceold.englishinsurancecardnode"
    COCOSTUDIO_UI_INSURANCEBUYINTIPS = "texaspoker.uilua.english.insuranceold.englishinsurancebuyintipsnode"
    COCOSTUDIO_UI_INSURANCEBUYINTIPSCHILDNODE = "texaspoker.uilua.english.insuranceold.englishinsurancebuyintipschildnode"
    COCOSTUDIO_UI_INSURANCEBUYINCHILDNODE = "texaspoker.uilua.english.insuranceold.englishinsurancebuyinchildnode"


    COCOSTUDIO_UI_INSURANCEUSERSETTLEMENTDATANODE = "texaspoker.uilua.english.englishinsuranceusersettlementdatanode"
    COCOSTUDIO_UI_INSURANCEMATCHUSERSETTLEMENTDATANODE = "texaspoker.uilua.english.englishinsurancematchusersettlementdatanode"

    COCOSTUDIO_UI_COMMONINPUTNODE = "texaspoker.uilua.english.englishcommoninputnode"
    COCOSTUDIO_UI_OTHERINFONODE_NEW = "texaspoker.uilua.english.englishotherinfonode_new"

    COCOSTUDIO_UI_OMAHA_PLAGERNODE_OTHER = "texaspoker.uilua.english.englishplagernode_other_omaha"
    COCOSTUDIO_UI_OMAHA_PLAGERNODE_SELF = "texaspoker.uilua.english.englishplagernode_self_omaha"

    COCOSTUDIO_UI_KICKOUTTIPSNODE = "texaspoker.uilua.english.englishkickouttipsnode"
    COCOSTUDIO_UI_DISMISSTIPSNODE = "texaspoker.uilua.english.englishdismisstipsnode" 

    COCOSTUDIO_UI_FACEBUTTONNODE = "texaspoker.uilua.english.englishfacebuttonnode" 
    COCOSTUDIO_UI_MICROIMAGENODE = "texaspoker.uilua.english.englishmicroimagenode" 
    COCOSTUDIO_UI_MICROPHONENODE = "texaspoker.uilua.english.englishmicrophonenode" 
    COCOSTUDIO_UI_NOTEBUTTONNODE = "texaspoker.uilua.english.englishnotebuttonnode" 
    COCOSTUDIO_UI_OPERATEBUTTONNODE = "texaspoker.uilua.english.englishoperatebuttonnode" 
    COCOSTUDIO_UI_REVIEWBUTTONNODE = "texaspoker.uilua.english.englishreviewbuttonnode" 
    COCOSTUDIO_UI_SNG_SNGUPBLINDNODE = "texaspoker.uilua.english.sng.englishsngupblindnode" 

    COCOSTUDIO_UI_BUYUNIONNODE = "texaspoker.uilua.english.englishbuyunionnode"
    COCOSTUDIO_UI_SITDOWNBUYUNIONNODE = "texaspoker.uilua.english.englishsitdownbuyunionnode"
    COCOSTUDIO_UI_SITDOWNBUYUNIONNODE_SHORT = "texaspoker.uilua.english.englishsitdownbuyunionnode_short"
    COCOSTUDIO_UI_BUYUNIONCHILDNODE = "texaspoker.uilua.english.englishbuyinchildnode"

    COCOSTUDIO_UI_OTHERINFONODE_SELF = "texaspoker.uilua.english.englishotherinfonode_self"

    COCOSTUDIO_UI_TURNLOOKBUTTONNODE = "texaspoker.uilua.english.englishturnlookbuttonnode"
    COCOSTUDIO_UI_TURNLOOKNODE = "texaspoker.uilua.english.englishturnlooknode"
    COCOSTUDIO_UI_TURNLOOKNODE_I4 = "texaspoker.uilua.english.englishturnlooknode_i4"
    COCOSTUDIO_UI_TURNLOOKNODE_IPAD = "texaspoker.uilua.english.englishturnlooknode_ipad"
    COCOSTUDIO_UI_TURNLOOKNODE_S8 = "texaspoker.uilua.english.englishturnlooknode_s8"

    COCOSTUDIO_UI_TRANSITIONNODE = "texaspoker.uilua.english.englishtransitionnode"
    COCOSTUDIO_UI_TRANSITIONNODE_i4 = "texaspoker.uilua.english.englishtransitionnode_i4"
    COCOSTUDIO_UI_TRANSITIONNODE_ipad = "texaspoker.uilua.english.englishtransitionnode_ipad"
    COCOSTUDIO_UI_TRANSITIONNODE_S8 = "texaspoker.uilua.english.englishtransitionnode_s8"

    --mtt
    COCOSTUDIO_UI_MTT_EXITTIPSNODE = "texaspoker.uilua.english.mtt.englishmttexittipsnode"
    COCOSTUDIO_UI_MTT_AWARDFINISHNODE = "texaspoker.uilua.english.mtt.englishmttawardfinishnode"
    COCOSTUDIO_UI_MTT_NOAWARDFINISHNODE = "texaspoker.uilua.english.mtt.englishmttnoawardfinishnode"
    COCOSTUDIO_UI_MTT_GOBACKNODE = "texaspoker.uilua.english.mtt.englishmttgobacknode"
    COCOSTUDIO_UI_MTT_REALTIMESITUATIONMAINNODE = "texaspoker.uilua.english.mtt.englishmttrealtimesituationmainnode"
    COCOSTUDIO_UI_MTT_REALTIMESITUATIONMAINNODE_S8 = "texaspoker.uilua.english.mtt.englishmttrealtimesituationmainnode_s8"
    COCOSTUDIO_UI_MTT_REALTIMESITUATIONTITLENODE = "texaspoker.uilua.english.mtt.englishmttrealtimesituationtitlenode"
    COCOSTUDIO_UI_MTT_REALTIMESITUATIONRANKNODE = "texaspoker.uilua.english.mtt.englishmttrealtimesituationranknode"
    COCOSTUDIO_UI_MTT_REALTIMESITUATIONRANKCHILDNODE = "texaspoker.uilua.english.mtt.englishmttrealtimesituationrankchildnode"
    COCOSTUDIO_UI_MTT_REALTIMESITUATIONPANELNODE = "texaspoker.uilua.english.mtt.englishmttrealtimesituationpanelnode"
    COCOSTUDIO_UI_MTT_REALTIMESITUATIONMATCHDATANODE = "texaspoker.uilua.english.mtt.englishmttrealtimesituationmatchdatanode"
    COCOSTUDIO_UI_MTT_REALTIMESITUATIONDESKNODE = "texaspoker.uilua.english.mtt.englishmttrealtimesituationdesknode"
    COCOSTUDIO_UI_MTT_REALTIMESITUATIONDESKCHILDNODE= "texaspoker.uilua.english.mtt.englishmttrealtimesituationdeskchildnode"
    COCOSTUDIO_UI_MTT_REALTIMESITUATIONAWARDNODE= "texaspoker.uilua.english.mtt.englishmttrealtimesituationawardnode"
    COCOSTUDIO_UI_MTT_REALTIMESITUATIONAWARDNEXTNODE= "texaspoker.uilua.english.mtt.englishmttrealtimesituationawardnextnode"
    COCOSTUDIO_UI_MTT_REALTIMESITUATIONAWARDCHILDNODE= "texaspoker.uilua.english.mtt.englishmttrealtimesituationawardchildnode"
    COCOSTUDIO_UI_MTT_REALTIMESITUATIONBLINDNODE= "texaspoker.uilua.english.mtt.englishmttrealtimesituationblindnode"
    COCOSTUDIO_UI_MTT_REALTIMESITUATIONBLINDCHILDNODE= "texaspoker.uilua.english.mtt.englishmttrealtimesituationblindchildnode"
    COCOSTUDIO_UI_MTT_REENTRYTIPSNODE = "texaspoker.uilua.english.mtt.englishmttreentrytipsnode"
    COCOSTUDIO_UI_MTT_SIGNUPNODE = "texaspoker.uilua.english.mtt.englishmttsignupnode"
    COCOSTUDIO_UI_MTT_STARTPUSHNODE = "texaspoker.uilua.english.mtt.englishmttstartpushnode"
    COCOSTUDIO_UI_MTT_STARTPUSHCHILDNODE = "texaspoker.uilua.english.mtt.englishmttstartpushchildnode"
    COCOSTUDIO_UI_MTT_WATCHDESKFINISHNODE = "texaspoker.uilua.english.mtt.englishmttwatchdeskfinishnode"
    COCOSTUDIO_UI_MTT_WATCHFINISHNODE = "texaspoker.uilua.english.mtt.englishmttwatchfinishnode"
    COCOSTUDIO_UI_MTT_REALTIMESITUATIONINTRONODE= "texaspoker.uilua.english.mtt.englishmttrealtimesituationintronode"

    COCOSTUDIO_UI_POKERTEXTINFO_NODE = "texaspoker.uilua.english.englishpokertextinfonode"
    COCOSTUDIO_UI_POKERTEXTINFO_NODE_S8 = "texaspoker.uilua.english.englishpokertextinfonode_s8"
    COCOSTUDIO_UI_POKERTEXTINFO_NODE_SHORT = "texaspoker.uilua.english.englishpokertextinfonode_short"
    COCOSTUDIO_UI_POKERTEXTINFO_NODE_SHORT_S8 = "texaspoker.uilua.english.englishpokertextinfonode_short_s8"
    COCOSTUDIO_UI_POKERTEXTINFO_SHOWDOWN_NODE = "texaspoker.uilua.english.englishpokertextinfoshowdownnode"
    COCOSTUDIO_UI_POKERTEXTINFO_SHOWDOWN_NODE_SHORT = "texaspoker.uilua.english.englishpokertextinfoshowdownnode_short"
    COCOSTUDIO_UI_POKERTEXTINFO_SHOWDOWN_TITLE_NODE = "texaspoker.uilua.english.englishpokertextinfoshowdowntitlenode"
    COCOSTUDIO_UI_POKERTEXTINFO_SHOWDOWN_TITLE_NODE_SHORT = "texaspoker.uilua.english.englishpokertextinfoshowdowntitlenode_short"
    COCOSTUDIO_UI_POKERTEXTINFO_SHOWDOWN_CHILD_NODE = "texaspoker.uilua.english.englishpokertextinfoshowdownchildnode"
    COCOSTUDIO_UI_POKERTEXTINFO_SHOWDOWN_CHILD_NODE_SHORT = "texaspoker.uilua.english.englishpokertextinfoshowdownchildnode_short"
    COCOSTUDIO_UI_POKERTEXTINFO_INSURANCE_NODE = "texaspoker.uilua.english.englishpokertextinfoinsurancenode"
    COCOSTUDIO_UI_POKERTEXTINFO_STATE_NODE = "texaspoker.uilua.english.englishpokertextinfostatenode"
    COCOSTUDIO_UI_POKERTEXTINFO_STATE_CHILD_NODE = "texaspoker.uilua.english.englishpokertextinfostatechildnode"
    COCOSTUDIO_UI_POKERTEXTINF_BUTTON_NODE = "texaspoker.uilua.english.englishpokertextinfobuttonnode"

    --个人设置
    COCOSTUDIO_UI_SETTING_NODE = "texaspoker.uilua.english.englishsettingnode"
    COCOSTUDIO_UI_SETTING_SELF_NODE = "texaspoker.uilua.english.englishsettingselfnode"
    COCOSTUDIO_UI_SETTING_SELF_POT_CHILD_NODE = "texaspoker.uilua.english.englishsettingselfraisepotchildnode"
    COCOSTUDIO_UI_SETTING_ADVANCE_NODE = "texaspoker.uilua.english.englishsettingadvancenode"

    --弹幕
    COCOSTUDIO_UI_BULLETSCREEN_BUTTON_NODE = "texaspoker.uilua.english.englishbulletbuttonnode"
    COCOSTUDIO_UI_BULLETSCREEN_NODE = "texaspoker.uilua.english.englishbulletscreennode"
    COCOSTUDIO_UI_BULLETSCREEN_CHILD_NODE = "texaspoker.uilua.english.englishbulletscreenchildnode"
    COCOSTUDIO_UI_BULLETSCREEN_CHILD_TEXT_NODE = "texaspoker.uilua.english.englishbulletscreentextnode"

    --UI文本内容------------------------------------------------------

    STR_ADVANCEDSETTINGS_OPTIONSTR = "Host Options"
    STR_ADVANCEDSETTINGS_BUYINSTR = "Buy-in multiple limit"
    STR_ADVANCEDSETTINGS_BUYINCTRLSTR = "Require buy-in confirmation"
    STR_ADVANCEDSETTINGS_PAUSESTR = "Pause"
    STR_ADVANCEDSETTINGS_DISMISSSTR = "Dismiss"
    STR_ADVANCEDSETTINGS_NOSAVETEXT = "Save"
    STR_ADVANCEDSETTINGS_SAVEDTEXT = "Saved"
    STR_ADVANCEDSETTINGS_SETTIMETEXT = "Thinking time (effecting on next hand)"
    STR_ADVANCEDSETTINGS_STRADDLE_TEXT = "Straddle"
    STR_ADVANCEDSETTINGS_PUSHTEXT = "Notify"

    STR_BUYNODE_BUYINSTR = "Buyin"
    STR_BUYNODE_BUYTIPSSTR = "Will refill your Buyin on next hand"
    STR_BUYNODE_BUYSTR = "Buyin"
    STR_BUYNODE_COINSSTR = "Total coins："
    STR_BUYNODE_FEESTR = "Fee："
    STR_BUYNODE_BUYBUTTON_STR  = "Confirm"
    STR_BUYNODE_NOTIFYTIPS_STR = "Select Club to request your buy-in"
    
    STR_CASHOUT_TITLE = "Cash out chips"
    STR_CASHOUT_CONTENT01 = "Chips will withdrawal after this hand"
    STR_CASHOUT_CONTENT02 = "Cash out chips"
    STR_CASHOUT_CONTENT03 = "Chips will withdrawal after game started."
    STR_CASHOUT_CONFIRM = "Confirm cash out chips"
    STR_CASHOUT_TIPS_ALREADY = "You already cash out in this hand."

    STR_CASHOUT_SUCCESS = "Chips withdrawn %d"
    STR_CASHOUT_NOT_ENOUGH = "Not enough Chips"
    STR_CASHOUT_FAIL = "Not enough Chips"

    STR_CHECKPROMPTNODE_TIPSSTR = "Tips"
    STR_CHECKPROMPTNODE_TIPSSTR01 = "Checking is free."
    STR_CHECKPROMPTNODE_TIPSSTR02 = ""
    STR_CHECKPROMPTNODE_HIDETIPSSTR = "Hide tips"
    STR_CHECKPROMPTNODE_CHECKBUTTON_STR = "Check"
    STR_CHECKPROMPTNODE_FOLDBUTTON_STR = "Fold"

    STR_COMMONINPUTNODE_NEW_TAGSTR = "Tag"
    STR_COMMONINPUTNODE_NEW_CANCELTEXT = "Cancel"
    STR_COMMONINPUTNODE_NEW_SAVETEXT = "Save"
    STR_COMMONINPUTNODE_PLACEHODER_REMARK_TEXT = "Enter alias"
    STR_COMMONINPUTNODE_PLACEHODER_TAG_TEXT = "Enter tag"
    STR_COMMONINPUTNODE_NEW_REMARKSTR = "Alias"

    STR_ERRORNODE_TIPSSTR = "Notice"
    STR_ERRORNODE_CANCELSTR = "Cancel"
    STR_ERRORNODE_CANCELSTR_NEW = "Got it"

    STR_FACEPAG_INFOTEXT  = "Emoji"
    STR_FACEPAG_INFOTEXT1 = "Stickers 20"
    STR_FACEPAG_INFOTEXT2 = "/"

    STR_GOTOSHOPNODE_TIPSSTR = "Notice"
    STR_GOTOSHOPNODE_CANCELTEXT = "Cancel"
    STR_GOTOSHOPNODE_OKTEXT = "Purchase"

    STR_INSURANCEMATCHUSERSETTLEMENTDATANODE_NAMETEXT = "Sum assured"
    STR_INSURANCEUSERSETTLEMENTDATANODE_NAMETEXT = "Sum assured"

    STR_KICKOUTTIPSNODE_TIPSTEXT01 = "The player will be kick out"
    STR_KICKOUTTIPSNODE_TIPSTEXT02 = "  & ban from this game"
    STR_KICKOUTTIPSNODE_PAUSETBUTTON = "Pause"
    STR_KICKOUTTIPSNODE_KICKBUTTON = "Kick out"

    STR_MAINSCENE_STARTSTATETEXT = "wait for next"

    STR_MATCHSTATISTICSNODE_NICKNAMESTR = "Nickname"
    STR_MATCHSTATISTICSNODE_BUYINSTR = "Buyin"
    STR_MATCHSTATISTICSNODE_WONSTR = "Won"
    STR_MATCHSTATISTICSNODE_RESULTSTR = "Personal results"
    STR_MATCHSTATISTICSNODE_TITLESTR = "Results"
    STR_MATCHSTATISTICSNODE_TOTALHANDSTR = "Total hands"
    STR_MATCHSTATISTICSNODE_MAXPOTSTR = "Max. Pot"
    STR_MATCHSTATISTICSNODE_TOTALBUYSTR = "Total Buyin"
    STR_MATCHSTATISTICSNODE_MVP = "MVP"
    STR_MATCHSTATISTICSNODE_BOSS = "Tuhao"
    STR_MATCHSTATISTICSNODE_FISH = "Whale"

    STR_OTHERINFONODE_NEW_REMARKTEXT = "Tag"
    STR_OTHERINFONODE_NEW_NILTEXT = "No Tag"
    STR_OTHERINFONODE_NEW_VOICETEXT = "Voice replay"
    STR_OTHERINFONODE_NEW_ADDTEXT = "Add friend"
    STR_OTHERINFONODE_NEW_KICKTEXT = "Kick out"
    STR_OTHERINFONODE_NEW_STANDUPTEXT = "Stand up"
    STR_OTHERINFONODE_NEW_MATCHSTR = "Games"
    STR_OTHERINFONODE_NEW_HANDSTR = "Total hands"
    STR_OTHERINFONODE_NEW_POOLSTR = "VPIP"
    STR_OTHERINFONODE_NEW_WINSTR = "PFR"
    STR_OTHERINFONODE_PROFITSTR = "Balance"
    STR_OTHERINFONODE_ALLINWINSTR = "All-in win rate"
    STR_OTHERINFONODE_SNGMATCHSTR = "Tournaments"
    STR_OTHERINFONODE_SNGCHAMPIONSTR = "1st Place"
    STR_OTHERINFONODE_SNGSECONDSTR = "2nd Place"
    STR_OTHERINFONODE_SNGTHIRDSTR = "3rd Place"
    STR_OTHERINFONODE_MTTCHAMPIONSTR = "1st Place"
    STR_OTHERINFONODE_MTTFIRSTTHREESTR = "Top 3"
    STR_OTHERINFONODE_MTTBONUSSTR = "Cashes"
    STR_OTHERINFONODE_NICKNAMESTR = "Name:"

    STR_OTHERINFOSELFNODE_TIPSSTR = "Last 30 days"
    STR_OTHERINFOSELFNODE_SNGTIPSSTR = ""

    STR_REALTIMESITUATIONNODE_NICKNAMESTR = "Nickname"
    STR_REALTIMESITUATIONNODE_BUYINSTR = "Buyin"
    STR_REALTIMESITUATIONNODE_RESULTSTR = "Results"

    STR_REALTIMESITUATIONOTHERNODE_WATCHSTR = "Spectators"

    STR_REVIEWMAINNODE_REVIEWSTR = "Review all hand"

    STR_SITDOWNBUYNODE_BLINDSTR = "Small Blind/ Big Blind"
    STR_SITDOWNBUYNODE_BUYINSTR = "Buyin"
    STR_SITDOWNBUYNODEE_COINSSTR = "Total coins:"
    STR_SITDOWNBUYNODE_FEESTR = "Fee:"
    STR_SITDOWNBUYNODE_BUYBUTTON = "Join Game"
    STR_SITDOWNBUYNODE_NOTIFYTIPS_STR = "Select Club to request your buy-in"
    STR_SITDOWNBUYNODE_BLINDSTR_SHORT = "ANTE"

    STR_INSURANCEBUYINCHILDNODE_PAYSTR = "Pay"
    STR_INSURANCEBUYINCHILDNODE_CLAIMSTR = "Claim"
    STR_INSURANCEBUYINCHILDNODE_OUTSTR = "Outs"
    STR_INSURANCEBUYINCHILDNODE_ODDSTR = "Odds"

    STR_INSURANCEBUYINNODE_PASSSTR = "Pass"

    STR_INSURANCEBUYINOPERATENODE_STATETEXT = "Secure"
    STR_INSURANCEBUYINOPERATENODE_INPUTTEXT = "Insure"
    STR_INSURANCEBUYINOPERATENODE_RAISEENDENDTEXT = "Max"
    STR_INSURANCEBUYINOPERATENODE_STATEIMAGETEXT = "-Secure"
    STR_INSURANCEBUYINOPERATENODE_RAISEENDIMAGEBUTTON = "Max"
    STR_INSURANCEBUYINOPERATENODE_CHARGETEXT = "Claim"
    STR_INSURANCEBUYINOPERATENODE_ODDSTEXT = "Odds"
    STR_INSURANCEBUYINOPERATENODE_COMCARDSTR = "Community Cards"
    STR_INSURANCEBUYINOPERATENODE_HANDSCARDSTR = "Hands cards"
    STR_INSURANCEBUYINOPERATENODE_PLAYERCARDSTR = "Player cards"
    STR_INSURANCEBUYINOPERATENODE_OUTSSTR = "Outs"
    STR_INSURANCEBUYINOPERATENODE_SPLITOUTSSTR = "Split-pot Outs"
    STR_INSURANCEBUYINOPERATENODE_PREMIUMONSSTR = "Insurance Coverage Premium"
    STR_INSURANCEBUYINOPERATENODE_ODDSONSSTR = "Odds on Insurance Coverage"
    STR_INSURANCEBUYINOPERATENODE_SELECTALLSTR = "Select all"

    STR_SNGAWARDFINISHNODE_TITLE_ELIMINATE = "Sorry to be out"
    STR_SNGAWARDFINISHNODE_SHARESTR = "Awesome record! let’s share it！"
    STR_SNGAWARDFINISHNODE_PLACESTR = "Place"
    STR_SNGAWARDFINISHNODE_NICKNAMESTR = "Nickname"
    STR_SNGAWARDFINISHNODE_REWARDSTR = "Reward"
    STR_SNGAWARDFINISHNODE_SHOWOFFBUTTON_STR = "Show off"

    STR_SNGELIMINATEFINISHNODE_TITLESTR = "Tournament ended"
    STR_SNGELIMINATEFINISHNODE_PLACESTR = "Place"
    STR_SNGELIMINATEFINISHNODE_NICKNAMESTR = "Nickname"
    STR_SNGELIMINATEFINISHNODE_REWARDSTR = "Reward"
    STR_SNGELIMINATEFINISHNODE_RANKSTR01 = "No."
    STR_SNGELIMINATEFINISHNODE_RANKSTR02 = ""
    STR_SNGELIMINATEFINISHNODE_RANKAWARDSTR = "Bonus:"

    STR_SNGELIMINATENODE_STAYBUTTON_STR = "Stay & watch"
    STR_SNGELIMINATENODE_EXITBUTTON_STR = "Exit game"
    STR_SNGELIMINATENODE_RANKSTR01 = "No."
    STR_SNGELIMINATENODE_RANKSTR02 = ""

    STR_SNGLEAVENODE_CANCELTEXT = "Cancel"
    STR_SNGLEAVENODE_OKTEXT = "Leave"
    STR_SNGCONTROLBUYINMSG_STR = "new messages"

    STR_SNGMAINSCENE_STARTSTATETEXT = "wait for next"

    STR_SNGREALTIMESITUATIONNODE_PLACESTR = "Place"
    STR_SNGREALTIMESITUATIONNODE_NICKNAMESTR = "Nickname"
    STR_SNGREALTIMESITUATIONNODE_RESULTSTR = "Results"

    STR_SNGRULESDETAILSNODE_LEVELSTR = "Level"
    STR_SNGRULESDETAILSNODE_BLINDSTR = "Blinds"

    STR_INSURANCEINFOMAINCHILDNODE_TITLESTR = "Insurance"
    STR_INSURANCEINFOMAINCHILDNODE_OMAHA_TITLESTR = "Insurance"
    STR_INSURANCEINFOMAINCHILDNODE_INTROSTR01 = "Introduction:"
    STR_INSURANCEINFOMAINCHILDNODE_INTROSTR02 = "Operations:"
    STR_INSURANCEINFOMAINCHILDNODE_INTROSTR03 = "Odds"
    STR_INSURANCEINFOMAINCHILDNODE_BODYSTR01  = [[1. At the time all active players are all-in, the player with the leading hand could choose to purchase insurance (wherever applicable) by following tips provided.
2. Insurance is only sold for all-in situations with 14 outs or less.
3. Insurance is only sold for all-in situations with 3 players in the pot or less.
4. Insurance for split-pot situations would not be sold. For cases where split-pot situations are possible, the total insurance purchase of one player could not exceed the player's total investment in the pot.
5. Insurance could be sold for each separate pot, when multiple pots exist in the hand.
6. Insurance statistics would be displayed in the live results display section, hand history section and your personal stats section.
7. Insurance is not sold for the flop, and at maximum 25% pot for the turn. On the river the insurance could not exceed 50% pot.
8. After purchased insurance for the turn, on the river will have a mandatory purchase of insurance.

]]
    STR_INSURANCEINFOMAINCHILDNODE_BODYSTR02 = [[1. Secure: Claimed amount = player Invested amount.
2. Clicking the split-pot button would expand the slider, thus allowing the user to select the proper insurance amount.
3. Clicking the purchase button would confirm your insurance purchase for the selected amount.
4. You could repeat the above operations for each pot, when multiple pots exist in the hand.
5. The player could choose to fast purchase insurance by purchasing full cover insurance for all applicable pots.
6. The insurance cost would be deducted from the pot. If the insured card hits, the insurance payout would be credited to the user's stack.

]]

    STR_INSURANCEINFOMAINCHILDNODE_OMAHA_BODYSTR01  = [[1. In Omaha games, insurance mode only available for 2 - 6 players table. 
2. At the time all active players are all-in, the player with the leading hand could choose to purchase insurance (wherever applicable) by following tips provided.
3. Insurance is only sold for all-in situations with 14 outs or less.
4. Insurance is only sold for all-in situations with 3 players in the pot or less.
5. Insurance for split-pot situations would not be sold. For cases where split-pot situations are possible, the total insurance purchase of one player could not exceed the player's total investment in the pot.
6. Insurance could be sold for each separate pot, when multiple pots exist in the hand.
7. Insurance statistics would be displayed in the live results display section, hand history section and your personal stats section.
8. Insurance is not sold for the flop, and at maximum 25% pot for the turn. On the river the insurance could not exceed 50% pot.
9. After purchased insurance for the turn, on the river will have a mandatory purchase of insurance.

]]
    STR_INSURANCEINFOMAINCHILDNODE_OMAHA_BODYSTR02 = [[1. Return investment: Insurance returns = Invested amount.
2. Clicking the split-pot button would expand the slider, thus allowing the user to select the proper insurance amount.
3. Clicking the purchase button would confirm your insurance purchase for the selected amount.
4. You could repeat the above operations for each pot, when multiple pots exist in the hand.
5. The player could choose to fast purchase insurance by purchasing return investment insurance for all applicable pots.
6. The insurance cost would be deducted from the pot. If the insured card hits, the insurance payout would be credited to the user's stack.

]]

    STR_MICROPHONEPAG_SEND_TIPSTEXT = "slide up to unsend"
    STR_MICROPHONEPAG_CANCEL_TIPSTEXT = "slide up to unsend"
    STR_MICROPHONEPAG_SENDED_TIPSTEXT = "Sent"

    STR_DISMISSTIPSPAG_TIPSTEXT = "Comfirm to dismiss the table?"
    STR_CANCELBUTTON_STR = "Cancel"
    STR_OKBUTTON_STR = "Confirm"
    STR_FORCESTAND_TIPSTEXT = [[ The player will force to stand up 
     from this table.]]

    STR_FANFANKAN_TITLE_TEXT = "Hand has been set, nothing can change"
    STR_TURNLOOK_TITLE_FLOP_TEXT = "Tips to see Flop"
    STR_TURNLOOK_TITLE_TURN_TEXT = "Tips to see Turn"
    STR_TURNLOOK_TITLE_RIVER_TEXT = "Tips to see River"
    STR_TURNLOOK_TIPS_TEXT = "Just for fun"
    STR_TURNLOOK_NOENOUGHCOIN_WEAKTIPS_TEXT = "No enough coins"
    STR_TURNLOOK_NOTRIGHTTIME_WEAKTIPS_TEXT = "It's not tips time"

    STR_SNG_UPBLIND_TITLE_TEXT = "Raise Blinds in"

    --mtt 死文本简繁英
    STR_MTT_REENTRY_TIPS = "Do not show again."
    STR_MTT_SHAREIT_BUTTON_TITLE = "Share it!"
    STR_MTT_EXIT_BUTTON_TITLE = "Exit"
    STR_MTT_CHANGETABLE_BUTTON_TITLE = "Change Table"
    STR_MTT_FINISH_NOAWARD_TITLE = [[You have been eliminated from
     the tournament.]]
    STR_MTT_EXITTIPS_TITLE = [[You will sit out upon exiting the tournament.
    You may return anytime.]]

    STR_MTT_SIGNUP_SIGN_TEXT = "Join:"
    STR_MTT_SIGNUP_TICKET_TEXT = "Req.:"

    STR_MTT_REALTIMES_MATCH_SCORE_TEXT = "Avg. Stack"
    STR_MTT_REALTIMES_MATCH_NEXTTIME_TEXT = "Next Level Length"
    STR_MTT_REALTIMES_MATCH_BLINDTIME_TEXT = "Time Left in Level"
    STR_MTT_REALTIMES_MATCH_CURBLIND_TEXT = "Blinds"
    STR_MTT_REALTIMES_MATCH_NEXTLEVEL_TEXT = "Next Level"
    STR_MTT_REALTIMES_MATCH_PLAYERNUM_TEXT = "Players"
    STR_MTT_REALTIMES_MATCH_USEDTIME_TEXT = "Elapsed"
    STR_MTT_REALTIMES_REENTRY_TEXT = "Auto reenter"
    STR_MTT_REALTIMES_UPDATE_TEXT = "Refresh"
    STR_MTT_REALTIMES_PAGE_TITLE_TEXT01 = "Live"
    STR_MTT_REALTIMES_PAGE_TITLE_TEXT02 = "Tables"
    STR_MTT_REALTIMES_PAGE_TITLE_TEXT03 = "Prize"
    STR_MTT_REALTIMES_PAGE_TITLE_TEXT04 = "Blinds"
    STR_MTT_REALTIMES_PAGE_TITLE_TEXT05 = "Info"
    STR_MTT_REALTIMES_RANK_TITLE_TEXT = "Pos."
    STR_MTT_REALTIMES_RANK_TITLE_DESK_TEXT = "Tables"
    STR_MTT_REALTIMES_RANK_TITLE_SCORE_TEXT = "Stacks"
    STR_MTT_REALTIMES_RANK_TITLE_BLIND_TEXT = "BB"
    STR_MTT_REALTIMES_DESK_TITLE_DESKNUM_TEXT = "Tables"
    STR_MTT_REALTIMES_DESK_TITLE_PLAYERNUM_TEXT = "Players"
    STR_MTT_REALTIMES_DESK_TITLE_STACK_TEXT = "Stacks"
    STR_MTT_REALTIMES_AWARD_TITLE_PRIZEPOOL_TEXT = "Prize Pool:"
    STR_MTT_REALTIMES_AWARD_TITLE_ITM_TEXT = "ITM:"
    STR_MTT_REALTIMES_AWARD_TITLE_NEXTPRIZE_TEXT = "Next Prize:"
    STR_MTT_REALTIMES_BLIND_TITLE_LEVEL_TEXT = "Level"
    STR_MTT_REALTIMES_BLIND_TITLE_BLIND_TEXT = "Blinds"
    STR_MTT_REALTIMES_BLIND_TITLE_ANTE_TEXT = "Ante"
    STR_MTT_REALTIMES_BLIND_TITLE_BLINDTIME_TEXT = "Times"

    STR_MTT_MAINSCENE_START_TIPS_TEXT = "Start in"
    STR_MTT_GOBACK_BUTTON_TITLE_TEXT = "Back"

    MAINSCENE_START_BUTTON_TEXT = "Start"
    MAINSCENE_SHARE_BUTTON_TEXT = "Share"    

    --UI设置控件---------
    IMAGE_MATCHSTATISTICSNODE_OMAHALOGOIMAGE = "game/game_layer/eng/matchstatistics/english_omahagame_logo.png"
    IMAGE_MATCHSTATISTICSNODE_INSURANCEIMAGE = "game/game_layer/eng/insurance/english_baoxianju.png"
    IMAGE_MATCHSTATISTICSNODE_SHORTDUCKLOGOIMAGE = "game/game_layer/eng/matchstatistics/english_shortduck_logo.png"

    IMAGE_SNGMAINMENUNODE_RULESDETAILSIMAGE = "game/game_layer/common/sng/english_sng_time.png"

--    IMAGE_INSURANCEINFOMAINCHILDNODE_TIPSIMAGE = "game/game_layer/common/insurance/english_insurance_info_odds.png"
--    IMAGE_INSURANCEINFOMAINCHILDNODE_OMAHA_TIPSIMAGE = "game/game_layer/common/insurance/english_omaha_insurance_info_odds.png"


    --根据主题不同，替换按钮图
    PLAYER_SELF_OPERATE_FREE_RAISE_BUTTON_ICON = "game/game_layer/common/ic_operate_blue_big.png"
    PLAYER_SELF_OPERATE_FREE_RAISE_BUTTON_SELECTED_ICON = "game/game_layer/common/ic_operate_blue_big_press.png"
    PLAYER_SELF_OPERATE_POT_AND_BLIND_BUTTON_ICON = "game/game_layer/common/ic_operate_blue_small.png"
    PLAYER_SELF_OPERATE_POT_AND_BLIND_BUTTON_PRESSED_ICON = "game/game_layer/common/ic_operate_blue_small_press.png"

    STR_PLAYER_SELF_FREERAISE_BUTTON_TITLE_TEXT = "slide to riase"
    STR_PLAYER_SELF_ENSURE_BUTTON_TITLE_TEXT = "Confirm"
    STR_PLAYER_SELF_CHECK_BUTTON_TITLE_TEXT = "Check"
    STR_PLAYER_SELF_CALL_BUTTON_TITLE_TEXT = "Call"
    STR_PLAYER_SELF_FOLD_BUTTON_TITLE_TEXT = "Fold"
    STR_PLAYER_SELF_ALLIN_BUTTON_TITLE_TEXT = "Allin"
    STR_PLAYER_SELF_BLIND_BUTTON_TITLE_TEXT = "BigBlind"
    STR_PLAYER_SELF_ANTE_BUTTON_TITLE_TEXT = "Ante"
    STR_PLAYER_SELF_POT_BUTTON_TITLE_TEXT = "Pot"
    STR_PLAYER_SELF_AUTO_CHECK_CHECKBOX_TITLE_TEXT = "Auto Check"
    STR_PLAYER_SELF_AUTO_CALL_CHECKBOX_TITLE_TEXT = "Auto Call"
    STR_PLAYER_SELF_AUTO_QUIT_CHECKBOX_TITLE_TEXT = "Check/Fold"

    STR_PLAYER_EMPTY_TITLE_TEXT = "Empty"
    STR_PLAYER_OPEN_TITLE_TEXT = "Open"

    STR_PLAYER_CANCEL_DELEGATE_TEXT = "Return"
    STR_PLAYER_SITDOWN_BACK_TEXT = "Return"

    --公用底层按钮 有2种
    COMMON_BACKIMAGE_BUTTON_NORMAL_IMAGE = "game/game_layer/common/btn_blank-i6p.png"
    COMMON_BACKIMAGE_BUTTON_MASK_IMAGE = "game/game_layer/common/dark.png"
    STR_SHORT_POKER_TYPE_PATH = "game/game_layer/common/prompt/ic_prompt_image%d.png"
    
    --牌型提示牌型文字
    STR_PROMPT_RULES_TEXT_LIST = {}
    STR_PROMPT_RULES_TEXT_LIST[1] = "Royal Flush"
    STR_PROMPT_RULES_TEXT_LIST[2] = "Straight Flush"
    STR_PROMPT_RULES_TEXT_LIST[3] = "Four of a kind"
    STR_PROMPT_RULES_TEXT_LIST[4] = "Full House"
    STR_PROMPT_RULES_TEXT_LIST[5] = "Flush"
    STR_PROMPT_RULES_TEXT_LIST[6] = "Straight"
    STR_PROMPT_RULES_TEXT_LIST[7] = "Three of a kind"
    STR_PROMPT_RULES_TEXT_LIST[8] = "Two pairs"
    STR_PROMPT_RULES_TEXT_LIST[9] = "A pair"
    STR_PROMPT_RULES_TEXT_LIST[10] = "High card"

    STR_OTHERINFO_GPS_POS_TEXT = "Distance "
    STR_OTHERINFO_GPS_NO_POS_TEXT = "Location Service Inactive"
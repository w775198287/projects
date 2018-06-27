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

  CHECK_SINGNAL_GOOD_ICON = "game/game_layer/common/signal/ic_singal_3-i6p.png",--信号最强
  CHECK_SELECTED_GENERAL_ICON = "game/game_layer/common/signal/ic_singal_2-i6p.png",--信号一般
  CHECK_SELECTED_POOR_ICON = "game/game_layer/common/signal/ic_singal_1-i6p.png",--信号最弱
  CHECK_SELECTED_NO_SIGNAL_ICON = "game/game_layer/common/signal/ic_singal_0-i6p.png",--无信号


  BUYIN_INVITE_FIRST_BACK_ICON = "game/game_layer/common/message1_bg@3x.png",--买入请求第一个界面底图


  --调整买入手数
  ADVANCED_SETTINGS_SLIDER_HANDLE_DISABLE_ICON = "game/game_layer/common/ic_sliderhandle_disable-i6p.png",
  ADVANCED_SETTINGS_SLIDER_HANDLE_ICON = "game/game_layer/common/ic_sliderhandle-i6p.png",
  ADVANCED_SETTINGS_INTERVA_ICON = "game/game_layer/common/sliderProgress-i6p.png",
  ADVANCED_SETTINGS_INTERVA_DISABLE_ICON = "game/game_layer/common/sliderProgress_disable-i6p.png",

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
    USER_STATE_TEXT_CHECK = "チェック",
    USER_STATE_TEXT_FOLD = "フォルド",
    USER_STATE_TEXT_CALL = "コール",
    USER_STATE_TEXT_RAISE = "レイズ",
    USER_STATE_TEXT_ALLIN = "All In",
    USER_STATE_TEXT_YANSHI = "タイム延長",
    USER_STATE_TEXT_WAIT = "しばらくお待ちを…",
    USER_STATE_TEXT_STRADDLE = "ストラドル",
}

MAINSCENE_BG_IMAGE = "game/game_layer/common/desktop_background_4.png" --桌面主题背景
--MAINSCENE_BG_TEXT_COLOR = cc.c3b(31,45,80) --桌面主题背景 文字颜色
MAINSCENE_BG_TEXT_COLOR = cc.c3b(255,255,255)
MAINSCENE_BG_TEXT_OPACITY = 0.4 * 255

POKER_CT_NAME={}
POKER_CT_NAME[CT_SINGLE]=[[ハイカード]]
POKER_CT_NAME[CT_ONE_LONG]=[[ワンペア]]
POKER_CT_NAME[CT_TWO_LONG]=[[ツーペア]]
POKER_CT_NAME[CT_THREE_TIAO]=[[3カード]]
POKER_CT_NAME[CT_SHUN_ZI]=[[ストレート]]
POKER_CT_NAME[CT_TONG_HUA]=[[フラッシュ]]
POKER_CT_NAME[CT_HU_LU]=[[フルハウス]]
POKER_CT_NAME[CT_TIE_ZHI]=[[4カード]]
POKER_CT_NAME[CT_TONG_HUA_SHUN]=[[ストレートフラッシュ]]
POKER_CT_NAME[CT_KING_TONG_HUA_SHUN]=[[ロイヤル
フラッシュ]]


--operation
STR_OPERATION_TEXT_MENU = "メニュー"
STR_OPERATION_TEXT_SHARE_GAME = "シェア"
STR_OPERATION_TEXT_STAND_UP = "席を立って観戦する"
STR_OPERATION_TEXT_OPTIONS = "ゲーム設定"
STR_OPERATION_TEXT_POKER_HANDS_HINTS = "ハンドランク提示"
STR_OPERATION_TEXT_CHANGE_CARD_COLOUR = "4色カードに切り替え"
STR_OPERATION_TEXT_CHANGE_CARD_COLOUR_CLASSIC = "クラシックカードに切り替え"
STR_OPERATION_TEXT_TEMPORARILYLEAVE = "シットアウト"
STR_OPERATION_TEXT_HELPER = "自動チェック/フォルド"
STR_OPERATION_TEXT_INSURANCE_HINTS = "保険について"
STR_OPERATION_TEXT_BUY_IN = "バイイン"
STR_OPERATION_TEXT_CASH_OUT = "キャッシュアウト"
STR_OPERATION_TEXT_GO_TO_SHOP = "ストア"
STR_OPERATION_TEXT_EXIT_GAME = "ゲームから退出"

--sng
STR_OPERATION_TEXT_REWARD_RULES = "リワードルール"
STR_OPERATION_TEXT_LEAVE_GAME = "ゲームから退出"

--mtt
STR_OPERATION_TEXT_MTT_SIGNUP = "レジスト"
STR_OPERATION_TEXT_MTT_LEAVE_GAME = "退出する"


--文字文本
STR_TEXT_DEFAULT = ""
STR_TEXT_WAIT = "しばらくお待ちを…"
STR_TEXT_FREE = "無料"
STR_TEXT_NOT_ENOUGH = "不足"
STR_TEXT_ADD_FRIEND_HINT = "友達リクエストが届きました。"
STR_TEXT_VOICE_CANCEL = "離してキャンセルする"
STR_TEXT_VOICE_SEND = "上へスライドして発送をキャンセルする"
STR_TEXT_ROOM_NAME = "* %s *"
STR_TEXT_ROOM_BLINDS_STR = "ブランド"
STR_TEXT_ROOM_BLINDS = " %d/%d"
STR_TEXT_ROOM_ANTE_BLINDS = " %d/%d (%d)"
STR_TEXT_ROOM_SHORTDUCK_ANTE = "ANTE: "
STR_TEXT_ROOM_SHORTDUCK_STRAIGHT = "  ストレート>3カード"
STR_TEXT_ROOM_SHORTDUCK_THREE = "  3カード>ストレート"
STR_TEXT_ROOM_SHORTDUCK_ANTE_TWO = "ディーラーボタン2xアンティ"
STR_TEXT_ROOM_SHORTDUCK_HOLD_MIN = "最小保留チップ: "
STR_TEXT_ROOM_INVITE = "招待コード： "
STR_TEXT_ROOM_CONTROLINTO = "バイイン確認"
STR_TEXT_ROOM_INSURANCE = "保険"
STR_TEXT_AUDIO_TIME = "%d'"
STR_TEXT_FORMAT_FLOAT = "%d.%d"
STR_TEXT_FORMAT_K = "%.2fK"
STR_TEXT_FORMAT_K1 = "%.1fK"
STR_TEXT_FORMAT_K0 = "%dK"
STR_TEXT_FORMAT_D = "%02d"
STR_TEXT_CONTINUE_TIME = "+%d"
STR_TEXT_ALL_POOL = "ポット："
STR_TEXT_POKER_FACE = "game/game_layer/ingame_poker/normal/poker_%d.png"
STR_TEXT_SURPLUS_TIME = "%d"
STR_TEXT_WIN_CHIP_NUM = "+"
STR_TEXT_RAISE_MAX_CHIP = "All In"
STR_TEXT_RAISE_MAX_POT_CHIP = "ポット"
STR_TEXT_POKER_FACE_FOURCOLOR = "game/game_layer/ingame_poker/fourcolor/poker_%d.png"

STR_TEXT_WAITTING_1 = [[スタート中]]
STR_TEXT_WAITTING_2 = [[ポーカーマスター。
仲間と楽しく遊ぼう！スタート中]]
STR_TEXT_WAITTING_3 = [[スタート中]]
STR_TEXT_WAITTING_4 = [[シートを選択して着席してください]]

STR_TEXT_WAITTING_5 = [[ ..]]
STR_TEXT_WAITTING_6 = [[. .]]
STR_TEXT_WAITTING_7 = [[.. ]]

STR_TEXT_GO_TO_SHOP_COIN_TEXT = "コインが不足しています。ストアで購入してください。"
STR_TEXT_GO_TO_SHOP_COIN_BUTTON_TEXT = "コイン購入"
STR_TEXT_GO_TO_SHOP_DIAMOND_TEXT = "ダイヤが不足しています。ストアで購入してください。"
STR_TEXT_GO_TO_SHOP_DIAMOND_BUTTON_TEXT = "ダイヤ購入"


LODING_ANIMATE_IMAGE = "loading/loading_000%d@2x.png"
WIN_ANIMATE_IMAGE = "game/game_layer/common/you_win/anim_youwin%d-i6p.png"

STR_TEXT_TIME_TIPS_5 = "このゲームはあと5分で終了します"
STR_TEXT_TIME_TIPS_1 = "このゲームはあと1分で終了します"

STR_TEXT_REVIEW_POKER_TYPE_TEXT = "フォルド"
STR_TEXT_REVIEW_COLLECTION_NUM_TEXT = "%d/%d"

STR_TEXT_CONTROL_ENABLE_TIPS = "管理者はバイイン申請をオンにしています"
STR_TEXT_CONTROL_DISABLE_TIPS = "管理者はバイイン申請をオフにしています"
STR_TEXT_CONTROL_DENY_TIPS = [[あなたのバイイン申請は
管理者に拒否されました]]

STR_TEXT_CONTROL_DENY = "%dsを拒否する"

STR_TEXT_CONTROL_ENABLE_WAITTING = [[バイイン申請審査待ち中。
しばらく待ってください。%ds...s...]]

STR_TEXT_PAUSE_TIPS_TEXT = "一時中止"
STR_TEXT_PAUSE_WAITTING = [[待ってください%s…]]

STR_TEXT_SIT_DOWN_OTHER_USER_BUYIN_WAITTING = "確認中%d"

STAND_PLAYER_PLAY_SOUND_IMAGE = "game/game_layer/common/sound_others_%d@2x.png"

STR_TEXT_ADD_FRIEND_SEND_TIPS = "发発送完了"
STR_TEXT_COLLECTION_TIPS = "保存しました"
STR_TEXT_COLLECTION_FAULT_TIPS = "保存失敗"
STR_TEXT_REMOVE_COLLECTION_TIPS = "保存取り消し"
STR_TEXT_REMOVE_COLLECTION_FAULT_TIPS = "保存取り消し失敗"

STR_TEXT_REMARK_TIPS = "入力した文字が多すぎます。"

STR_TEXT_STANDBY_NUM_TEXT = "%d人"
---sng
STR_TEXT_SNG_RULESDETAILS_RANK_TEXT = "現在："

STR_TEXT_SNG_ROOM_BLINDS = "人  "
STR_TEXT_SNG_ROOM_BLINDS_END = "ブラインド"
STR_TEXT_SNG_RULESDETAILS_ROOM_BLIND_INTERVAL = "%d人卓　レベルタイム：%d分"
STR_TEXT_SNG_MIDWAY_LEAVE_TIPS = [[退出してもトーナメントに戻れます。本当に退出しますか？]]
STR_TEXT_SNG_LEAVE_TIPS = [[本当に退出しますか？]]

STR_TEXT_SNG_GAME_ROOM_USER_MAX_NUMS = "%d人卓"
STR_TEXT_SNG_RANK_TEXT = {}
STR_TEXT_SNG_RANK_TEXT[1] = "1位"
STR_TEXT_SNG_RANK_TEXT[2] = "2位"
STR_TEXT_SNG_RANK_TEXT[3] = "3位"
STR_TEXT_SNG_RANK_TEXT[4] = "4位"
STR_TEXT_SNG_RANK_TEXT[5] = "5位"
STR_TEXT_SNG_RANK_TEXT[6] = "6位"
STR_TEXT_SNG_RANK_TEXT[7] = "7位"
STR_TEXT_SNG_RANK_TEXT[8] = "8位"
STR_TEXT_SNG_RANK_TEXT[9] = "9位"
STR_TEXT_SNG_RANK_AWARD_TEXT = "ボーナス：%d"
STR_TEXT_SNG_ELIMINATE_TEXT = "グッドラック！"
STR_TEXT_SNG_ELIMINATE_TIPS_TEXT = "残念ながら終了しました"
STR_TEXT_SNG_RANK_AWARD_TIPS_TEXT = [[おめでとうございます！
%sを獲得しました！]]
STR_TEXT_SNG_SIGNUP_BEGIN_TEXT = "あと "
STR_TEXT_SNG_SIGNUP_END_TEXT = " でスタートします"

STR_TEXT_SNG_RICHTEXT_RANKING_BEGIN_TEXT = "現在： "
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
STR_TEXT_SNG_RICHTEXT_RANKING_END_TEXT = " 位"

STR_TEXT_SNG_UP_BLIND_TIP_TIPS_BEGIN_TEXT = "次のブラインド   "
STR_TEXT_SNG_UP_BLIND_TIP_TIPS_END_TEXT = "%d/%d"

STR_TEXT_SNG_SIGNUP_STARTED_TEXT = "ゲームスタート"
STR_TEXT_SNG_SIGNUP_PREPARE_BEGIN_TEXT = "トーナメントは "
STR_TEXT_SNG_SIGNUP_PREPARE_END_TEXT = " 秒後スタートします"
--结束获奖排位图标
SNG_AWARD_FINISH_BILL_RANKING_ICON = "game/game_layer/common/sng/sng_%dcup_big_hd.png"
--SNG排名
SNG_RANKING_ICON = "game/game_layer/common/ic_sngrank_image.png"
SNG_RANKING_TEXT = "%d位"
--SNG托管状态
SNG_DELEGATE_ICON = "game/game_layer/common/ic_delegate_image.png"
SNG_DELEGATE_TEXT = "シットアウト中"

--
SNG_BILL_RANKING_ICON = "game/game_layer/common/sng/sng_%dcup_icon.png"
--sng控制买入提示
SNG_STR_TEXT_CONTROL_AGREE_TIPS = [[%s
管理員はあなたのレジスト申請に同意しました]]

SNG_STR_TEXT_CONTROL_DENY_TIPS = [[%s
管理員はあなたのレジスト申請を拒否しました]]

SNG_STR_TEXT_HAND_NUM = "%dバンド目"
INSURANCE_STR_TEXT_BREAKEVEN_TEXT = "元金保障"
INSURANCE_STR_TEXT_ALL_BREAKEVEN_TEXT = "全部元金保障"
INSURANCE_STR_TEXT_FULLPOOL_TEXT = "MAX"
INSURANCE_STR_TEXT_ALL_FULLPOOL_TEXT = "全部フルポット"

INSURANCE_STR_TEXT_BET_FOLD_ICON = "game/game_layer/common/ic_insurance_bubao.png"
INSURANCE_STR_TEXT_BET_STACKS_ICON = "game/game_layer/common/ic_insurance_toubao_peifu.png"
INSURANCE_STR_TEXT_GET_STACKS_ICON = "game/game_layer/common/ic_insurance_toubao_peifu.png"
INSURANCE_STR_TEXT_GET_GOU_MAI_ICON = "game/game_layer/common/ic_insurance_goumai.png"

INSURANCE_STR_TEXT_BET_STACKS_TEXT = "掛ける"
INSURANCE_STR_TEXT_BET_FOLD_TEXT = "放棄"
INSURANCE_STR_TEXT_GET_STACKS_TEXT = "払い戻し"
INSURANCE_STR_TEXT_GET_GOU_MAI_TEXT = "%dsを掛けている"

INSURANCE_STR_TEXT_TIPS_BUYIN_ICON = "game/game_layer/eng/insurance/english_insurance_buyin_tips_anims/insurance_buyin_tips_%d.png"

INSURANCE_STR_TEXT_BUYIN_OK_TEXT = "保険を掛ける"
INSURANCE_STR_TEXT_BUYIN_OK_ENABLED_TEXT = "ポットを選択してください"
INSURANCE_STR_TEXT_MAIN_POT = "メインポット"
INSURANCE_STR_TEXT_SPLIT_POT = "スプリットポット"

INSURANCE_STR_TEXT_POT_MAIN_TEXT="M"

INSURANCE_STR_TEXT_TIPS_NO_BUYIN_TEXT="outs>14 or outs=0，Can’t purchase insurance"
INSURANCE_STR_TEXT_TIPS_NO_BUYIN_TEXT_SHORTDUCK="outs>13 or outs=0，Can’t purchase insurance"
INSURANCE_STR_TEXT_TIPS_AUTO_BUYIN_TEXT="システムが自動的に保険をかけます。掛け金は%dコインです。"
INSURANCE_STR_TEXT_TIPS_NO_BUYIN_POOL_TEXT="Insurance is sold for pot more the 32 Coins."

REVIEW_STR_TEXT_INSURANCE_STACKS_TEXT = "保険ポット："

REVIEW_STR_TEXT_INSURANCE_NO_SEL_POT_TEXT = "タップして選択"
REVIEW_STR_TEXT_INSURANCE_SEL_POT_TEXT = "選択済"

INSURANCE_STR_ODDS_TEXT = "0"
INSURANCE_STR_FULLPOLL_TEXT = "フルポット"
INSURANCE_STR_MAXPOLL_TEXT = "MAX"
INSURANCE_STR_OVEROUTS_TIPS_TEXT = "最低%d枚のアウツを選択しなければなりません"
INSURANCE_STR_CHOOSE_OUTS_FULL_TIPS_TEXT = [[選択できるアウツの
枚数は最大14枚まで]]

--保险碎了图标
INSURANCE_SUI_ICON = "game/game_layer/eng/insurance/english_insurance_anmi.png"

--水印
NORMAL_GAME_TYPE_LOG_ICON = "game/game_layer/common/gamelogo/english_game.png"
SNG_GAME_TYPE_LOG_ICON = "game/game_layer/common/gamelogo/english_sng.png"
SIX_GAME_TYPE_LOG_ICON = "game/game_layer/common/gamelogo/english_6game.png"
OMAHA_GAME_TYPE_LOG_ICON = "game/game_layer/common/gamelogo/omaha_jp.png"
MTT_GAME_TYPE_LOG_ICON = "game/game_layer/common/gamelogo/mtt_gamelogo_eng.png"
SHORT_DECK_TYPE_LOG_ICON =  "game/game_layer/common/gamelogo/shortduck_jp.png"

--过渡界面水印
LOADING_GAME_LOGO_ICON = "game/game_layer/common/transition/transition_logo.png"

KICK_GAME_ROOM_TEXT = "は管理員にゲームから追い出されました"
KICK_GAME_ROOM_OTHER_ROOM_TEXT = "あなたは管理員にゲームから追い出されました"

END_GAME_ROOM_FORWARD_TEXT = "管理員がゲームの終了時間を繰り上げました。"

--IP限制文本
IP_LIMIT_TEXT = "IP"
GPS_LIMIT_TEXT = "GPS"
IP_AND_GPS_LIMIT_TEXT = "GPS IP"

--straddle设置文本
STRADDLE_OPEN_TEXT = "  ストラドル"

--强制站起
FORCE_STANDUP_TEXT = "あなたは管理員に強制にシットアウトされました"
FORCE_STANDUP_OTHERROOM_TEXT = "あなたは管理員%sに強制にシットアウトされました"
FORCE_STANDUP_OTHERS_TEXT = "は管理員に強制にシットアウトされました"
FORCE_OPEN_STANDUP_WEAKTIP_TEXT = [[ 管理員は強制
ストラドルをオンに設定しました]]
FORCE_CLOSE_STANDUP_WEAKTIP_TEXT = [[ 管理員は強制
ストラドルをオフに設定しました]]

--思考时间
THINKING_INTERVAL_TEXT = "管理者はタイムバンクを%d秒に変更して、次のハンドから有効です。"

--show ID
OTHERINFO_SHOW_ID_TEXT = "ID:"

--MTT
MTT_DESK_NUM_TEXT={}
MTT_DESK_NUM_TEXT[1] = "テーブル "
MTT_DESK_NUM_TEXT[2] = ""
MTT_DESK_STAKE_TEXT = "%d/%d"
MTT_AWARD_RANK_TEXT = "トップ%d位"
MTT_AWARD_RANK_POS_TEXT = "%d位"
MTT_AWARD_BONUS_TEXT = "プライズ: "
MTT_AWARD_RANK_STR_TEXT = "%s位"
MTT_BLIND_TIME_TEXT = "%d分"
MTT_BLIND_STRUCT_TEXT = "%d/%d/(%d)"
MTT_BLIND_STRUCT_NOANTE_TEXT = "%d/%d"
MTT_MAINSCENE_BLIND_TEXT = "ブランド:"
MTT_MAINSCENE_DESK_TIME_TEXT01 = "00:%d"
MTT_MAINSCENE_DESK_TIME_TEXT02 = "00:0%d"
MTT_MAINSCENE_DESK_TIME_TEXT03 = "00:00"
MTT_REVIEW_DESKNUM_TEXT = "テーブル%d"
MTT_MATCH_DATA_NO_BLINDTIME_TEXT = "--:--:--"
MTT_MATCH_DATA_NO_DATA_TEXT = "--"
MTT_MATCH_DATA_NO_BLINDSTRUCT_TEXT = "--/--/(--)"
MTT_MATCH_DATA_NO_USEDTIME_TEXT = "00:00:00"

MTT_RANK_TEXT={}
MTT_RANK_TEXT[1] = "優勝"
MTT_RANK_TEXT[2] = "2位"
MTT_RANK_TEXT[3] = "3位"
MTT_OTHER_RANK_TEXT = "%d位"

MTT_WATCH_DESK_FINISH_TEXT = [[このテーブルは終了しました]]
MTT_WATCH_FINISH_TEXT = "トーナメント終了"

MTT_DESK_STATE_REENTRY_TEXT = "リエントリー受付中"
MTT_DESK_STATE_DELAY_TEXT = "レートレジスト受付中"

MTT_REENTRY_FEE_POPULARITY_TEXT = "%dコインまたは相応のチケットでリエントリーします"
MTT_REENTRY_FEE_TICKET_TEXT = "チケットでリエントリーしますか？"
MTT_REENTRY_GET_STACKS_TEXT = "%dチップ獲得"

MTT_SIGNUP_REQUIREMENT_COIN_TEXT = "%dコインまたは相応のチケット"
MTT_SIGNUP_REQUIREMENT_TICKET_TEXT = "トーナメントチケット"

MTT_START_PUSH_TEXT = "着席しました。頑張ってください！"
MTT_START_FULL_TABLE_PUSH_TEXT = "テーブルは準備完了です。スタートしてください。"
MTT_START_CANCEL_PUSH_TEXT = "はキャンセルされました。あなたのレジストは払い戻されます。。"
MTT_START_PUSH_ENTER = "入る"
MTT_START_PUSH_BACK = "ゲームへ戻る"

MTT_SYSTEM_PUSH_GIVECARD_SAMETIME_TEXT = "ハンド・フォー・ハンド実施中。全てのテーブルで現在のハンドが終わるのを待ってください。"
MTT_SYSTEM_PUSH_CHANGE_DESK_TEXT = "あなたは新しいテーブルへ移動されました"
MTT_SYSTEM_PUSH_CHANGE_DESK_TEXT02 = "観戦しているテーブルは無効です。元のテーブルに戻されました。"
MTT_DELAY_REGISTER_FINISH_DESK_TEXT = "リエントリーは締め切りました。"
MTT_SYSTEM_PUSH_BLIND_UP_DESK_TEXT = "次のハンドでブラインドがあがります："

MTT_SYSTEM_PUSH_NORMAL_TEXT = "トーナメントには参加すると現在のゲームから退出します。本当に参加しますか？"
MTT_SYSTEM_PUSH_FULL_TABLE_TEXT = "テーブルには参加すると現在のゲームから退出します。本当に参加しますか？"
MTT_SYSTEM_PUSH_SNG_OR_MTT_TEXT = "トーナメントには参加すると現在のゲームからシットアウトされます。本当に参加しますか？"

MTT_INTRODUCE_PAG_DELAY_TEXT = "%dレベルが終わるまで可能"
MTT_INTRODUCE_PAG_REENTRY_TEXT = "%dレベルが終わるまで、%d回まで可能"

MTT_INTRODUCE_PAG_SIGNUP_STR = "バイイン:"
MTT_INTRODUCE_PAG_STACKS_STR = "スタートチップ:"
MTT_INTRODUCE_PAG_DELAY_STR = "レートレジスト:"
MTT_INTRODUCE_PAG_REENTRY_STR = "リエントリー:"
MTT_INTRODUCE_PAG_COIN_TEXT = "%dコイン"

--文字牌谱
STR_POKERTEXTINFO_STATE_PREFLOP_TEXT = "プリフロップ"
STR_POKERTEXTINFO_STATE_FLOP_TEXT = "フロップ"
STR_POKERTEXTINFO_STATE_TURN_TEXT = "ターン"
STR_POKERTEXTINFO_STATE_RIVER_TEXT = "リバー"
STR_POKERTEXTINFO_HIDENAME_TEXT = "匿名"
STR_POKERTEXTINFO_INSURANCE_TEXT = "保険ポット:"
STR_POKERTEXTINFO_PROCESS_TEXT = "ハンド詳細履歴"
STR_POKERTEXTINFO_HANDRESULT_TEXT = "ハンド履歴"
STR_POKERTEXTINFO_SHOWDOWN_TEXT = "ショーダウン"

POKERTEXTINFO_FOLD_ICON = "game/game_layer/common/pokertextinfo/fold_icon.png"
POKERTEXTINFO_CALL_ICON = "game/game_layer/common/pokertextinfo/call_icon.png"
POKERTEXTINFO_RAISE_ICON = "game/game_layer/common/pokertextinfo/raise_icon.png"
POKERTEXTINFO_POKER_FACE_ICON = "game/game_layer/common/pokertextinfo/poker_%d.png"
POKERTEXTINFO_POKER_BACK_FACE_ICON = "game/game_layer/common/pokertextinfo/poker_en.png"

INSURANCE_HELP_URL = "http://upyun.pokermate.net/web/cn/insurance_instruction.html"
INSURANCE_OMAHA_HELP_URL = "http://upyun.pokermate.net/web/cn/omaha_insurance_instruction.html"

--个人设置界面
STR_SETTING_SELFTITLE_TEXT = "個人設定"
STR_SETTING_ADVANCETITLE_TEXT = "管理員機能"

STR_SETTING_SELF_RAISESTR_TEXT = "レイズのショートカットをカスタマイズする"
STR_SETTING_SELF_CARDSTR_TEXT = "テーブル色"
STR_SETTING_SELF_MUTE_TEXT = "ゲーム音効"
STR_SETTING_SELF_TALK_MUTE_TEXT = "チャットミュート"
STR_SETTING_SELF_INSURANCE_STR_TEXT = "保険提示を隠す"
STR_SETTING_SELF_INSURANCE_TIPSSTR_TEXT = "(このテーブルのみ有効)"
STR_SETTING_SELF_RAISE_STR_TEXT = "スライド確認"
STR_SETTING_SELF_RAISE_TIPS_TEXT = [[レイズのショットカットをタップして

既定のレイズ額をカスタマイズできます]]

SETTING_SELF_RAISEPOT_ALLIN_STR = "All In"
SETTING_SELF_RAISEPOT_1XPOT_STR = "1x"
SETTING_SELF_RAISEPOT_1PT5XPOT_STR = "1.5x"
SETTING_SELF_RAISEPOT_NIL_STR = "なし"

SETTING_SELF_TABLECOLOR01_STR = "ブルー"
SETTING_SELF_TABLECOLOR02_STR = "ブラック"
SETTING_SELF_TABLECOLOR03_STR = "ダークブルー"
SETTING_SELF_TABLECOLOR04_STR = "グリーン"

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
PLAYER_TEMPORARILYLEAVE_TEXT = "シットアウト中"
PLAYER_TEMPORARILYLEAVE_TIME_TEXT = "%ds"
PLAYER_TEMPORARILYLEAVE_TIPS_TEXT = "このハンドが終わったらシットアウトします。"

--错误
ERROR_TEXT_TYPE_ENUM={
[1] = "ユーザーが存在しません。",
[2] = "グループチャットは存在しません。",
[3] = "この携帯番号は登録済みです。",
[4] = "検証コードは正しくありません。再度入力してください。",
[5] = "IDまたはパスワードは正しくありません。再度入力してください。",
[6] = "相手はあなたを友達に招待していません。",
[7] = "あなたたちは友達になっていません。",
[8] = "クループチャットの収容人数を超えました。",
[9] = "あなたのVIPレベルでの創設上限を超過しました。",
[10] = "未知のサーバーエラー。",
[11] = "ゲームは存在しません。",
[12] = "このゲームは満席になりました。",
[13] = [[コインが不足しています。
ストアで購入してください。]],
[14] = "あなたたちは友達になっていません。",
[15] = "シェアの回数上限に達しました。",
[16] = "リワード獲得済み。",
[17] = "戦績が見つかりませんでした。",
[18] = "保存したハンド履歴が見つかりませんでした。",
[19] = "保存データは完全ではありません。",
[20] = "購入エラー。",
[21] = "ダイヤが不足しています。ストアで購入してください。",
[22] = "您この操作をする権限がありません。",
[23] = "グループオーナーのみメンバーを削除できます。",
[24] = "グループオーナーのみグループの設定を編集できます。",
[25] = "グループオーナーのみ招待できます。",
[26] = "このユーザーは存在しません。",
[27] = "あなたのアカウントは他のデバイスでログインしています。",
[28] = "未知のエラー。",
[29] = "この席は使用中です。",
[30] = "現在のVIPカードより低いレベルのものを購入できません。",
[31] = "ゲーム開設する権限がありません。",
[32] = "あなたたちは既に友達になっています。",
[33] = "イベントは終了しました。",
[34] = "クラブの収容人数上限に達しましたため、参加を許可できません。",
[35] = "クラブが見つかりませんでした。",
[36] = "この操作をする権限はありません。",
[37] = "このユーザーはクラブに存在しません。",
[38] = "一度に一つしかクイックゲームを開設できません。",
[39] = "クイックゲームが見つかりませんでした。",
[40] = "クイックゲームは既にスタートしました。",
[41] = "このゲームに十分なプレイヤーがいません。",
[42] = "このユーザーはこのクイックゲームにいません。",
[43] = "購入失敗",
[44] = "",
[45] = "購入失敗",
[46] = "現在のチップ量は既にバイインの上限を超えています",
[47] = "リワード獲得済み",
[48] = "クラブの収容人数上限に達しました。",
[49] = "権限がありません。管理員のみこの操作ができます。",
[50] = "このハンドルネームは既に使用されているため、変更してください。",
[51] = "ハンドルネームがすでに使用されていますか？",
[52] = "これは高級ゲームではありません",
[53] = "ゲームオーナーではありません",
[54] = "ゲーム結果が存在しません",
[55] = "前回のゲーム結果が存在しません",
[56] = "このハンド履歴が存在しません",
[57] = "申請を送りました。承認を待ってください。",
[58] = "このユーザはゲームにいません。",
[59] = "このユーザーはバイイン申請していません。",
[60] = "バイインを処理する権限を持っていません。",
[61] = "進行中のゲームがあります。",
[62] = "一時中止命令エラー",
[63] = "ゲームはスタート待ちです",
[64] = "ゲーム管理員ではないため、ゲームに対しての設定はできません。",
[65] = "このユーザは既にクラブに存在しています。",
[66] = "ハンド履歴の保存上限に達しました。",
[600] = "ゲームが解散されました。",
[71] = [[ターンで保険を掛けた後
にはオフにできません。]],
[72] = [[オールインしているためシットアウ
トしたりゲームから退出できません。]],
[73] = [["セッションタイムアウト。
ログインし直してください。"]],
[74] = [[ゲームオーナーに追い出された
ため、ゲームに戻れません。]],
[75] = [[ あなたはゲームにいる他のプレイヤーとの距離
が近すぎるか、GPSをオンにしていません。ゲームの
公平性を保つため、このゲームに参加できません。]],
[76] = [[ あなたはゲームにいる他のプレイヤーとの距離
が近すぎるか、GPSをオンにしていません。ゲームの
公平性を保つため、このゲームに参加できません。]],
[77] = [[ あなたはゲームにいる他のプレイヤーとの距離
が近すぎるか、GPSをオンにしていません。ゲームの
公平性を保つため、このゲームに参加できません。]],
[78] = [[ あなたはゲームにいる他のプレイヤーとの距離
が近すぎるか、GPSをオンにしていません。ゲームの
公平性を保つため、このゲームに参加できません。]],
[79] = "シートに着席してください。",
[80] = [[ あなたはゲームにいる他のプレイヤーとの距離
が近すぎるか、GPSをオンにしていません。ゲームの
公平性を保つため、このゲームに参加できません。]],
[81] = [[連盟に加盟しているクラ
ブの数量は収容上限に達しました、]],
[82] = [[連盟を管理する権限がありません。]],
[83] = [[創設できる連盟の数量の上限を超えました。]],
[84] = [[参加できる連盟の数量の上限を超えました。]],
[85] = [[連盟を創設する権限がありません。]],
[86] = [[この連盟は存在しません。]],
[87] = [[連盟のデータにアクセスする権限がありません。]],
[88] = [[他のクラブで申請しているため、この
クラブで再度申請することはできません。]],
[89] = [[この連盟はDNDモードをオンに設定しています。]],
[90] = [[このクラブは既に連盟に加盟しています]],
[91] = [[このクラブは既に連盟から退出しました]],
[92] = [[連盟加盟申請を発送しました。]],
[93] = [[この連盟名は既に使用されています]],
[94] = [[管理員人数の上限に達しました。]],
[95] = [[このクラブは加盟できる連盟数量の上限を超えました。]],
[96] = [[このユーザーは友達申請を受け付けていません。]],
[97] = [[クラブを解散する前に、参加中の
連盟から退出するか解散してください。]],
[98] = [[連盟機能は調整中のため、現在使用できません。]],
[99] = [[チケットタイプエラー]],
[100] = [[チケットが不足しています。]],
[101] = [[すみませんが、引き換えコードの有効期限が切れました。]],
[102] = [[すみませんが、この引き換えコードは使用済です。]],
[103] = [[すみませんが、この引き換えコードは存在しません。]],
[104] = [[すみませんが、あなたは既にこのトーナメントにレジスト済です。]],
[105] = [[すみませんが、参加人数が上限を超過したため、レジストできません。]],
[106] = [[すみませんが、このトーナメントのレジストが締め切りました。]],
[107] = [[すみませんが、条件に満たしてないため、レジストできません。]],
[108] = [[すみませんが、現在レジストはキャンセルできなくなりました。]],
[109] = [[すみませんが、現在リエントリーができなくなりました。]],
[110] = [[すみませんが、リエントリー回数制限に超えたため、リエントリーできません。]],
[111] = [[すみませんが、条件に満たしてないため、リエントリーできません。]],
[112] = [[すみませんが、あなたは既に本トーナメントから淘汰されました。]],
[113] = [[すみませんが、このテーブルは既に終了しました。]],
[114] = [[すみませんが、このトーナメントは既に終了しました。]],
[115] = [[すみませんが、チケットのタイプが違うため、レジストできません。]],
[116] = [[すみませんが、このトーナメントはキャンセルされたため、レジストできません。]],
[117] = [[すみませんが、チケットのタイプが違うため、リエントリーできません。]],
[118] = [[すみませんが、入力に禁じられた内容があるため、編集して再度試してください。]],
[119] = [[すみませんが、このテーブルは既に終了しました。]],
[125] = [[You already cash out in this hand.]],
[126] = [[チップ不足.]],
[127] = [[チップ不足.]],

[9001] = "ユーザーは存在しません",
[9002] = "コインが不足しています",
[9003] = "未知のエラー",
[9004] = "ネットワーク接続エラー",
[9005] = "ネットワーク接続電波が弱すぎます",

[9006] = "ユーザーが存在しません。",
[9007] = "コインが不足しています",
[9008] = "未知のエラー",
[9009] = "ネットワーク接続エラー",
[9010] = "内部エラー",

[9012] = "コインが不足しています",
[9013] = "未知のエラー",
[9014] = "内部エラー",
[9015] = "ユーザーが存在しません。",
[9016] = "無効なベット",
[9017] = "満席",
[9018] = "コインが不足しています",
[9019] = "長い時間に操作がないため、アプリを再起動してください",
}


SNG_RANK_TEXT={}
SNG_RANK_TEXT[1]="優勝"
SNG_RANK_TEXT[2]="2位"
SNG_RANK_TEXT[3]="3位"

COCOSTUDIO_UI_BUYINCONTROLINVITECHILDNODE = "texaspoker.uilua.japanese.buyincontrolinvitechildnode"
COCOSTUDIO_UI_BUYINCONTROLINVITETIPSNODE = "texaspoker.uilua.japanese.buyincontrolinvitetipsnode"
COCOSTUDIO_UI_BUYNODE = "texaspoker.uilua.japanese.buynode"
COCOSTUDIO_UI_CHECKPROMPTNODE = "texaspoker.uilua.japanese.checkpromptnode"
COCOSTUDIO_UI_CASHOUTNODE = "texaspoker.uilua.japanese.cashoutnode"
COCOSTUDIO_UI_ERRORNODE = "texaspoker.uilua.japanese.errornode"
COCOSTUDIO_UI_FACELAYERCHILDLODE = "texaspoker.uilua.japanese.facelayerchildlode"
COCOSTUDIO_UI_FACELAYERNODE = "texaspoker.uilua.japanese.facelayernode"
COCOSTUDIO_UI_GOTOSHOPNODE = "texaspoker.uilua.japanese.gotoshopnode"
COCOSTUDIO_UI_LODINGNODE = "texaspoker.uilua.japanese.lodingnode"
COCOSTUDIO_UI_MAINFRAMEWORK = "uilua.hallscene.mainframework"
COCOSTUDIO_UI_MAINMENUNODE = "texaspoker.uilua.japanese.mainmenunode"
COCOSTUDIO_UI_MAINMENUNODE_I4 = "texaspoker.uilua.japanese.mainmenunode_i4"
COCOSTUDIO_UI_MAINMENUNODE_IPAD = "texaspoker.uilua.japanese.mainmenunode_ipad"
COCOSTUDIO_UI_MAINMENUNODE_S8 = "texaspoker.uilua.japanese.mainmenunode_s8"
COCOSTUDIO_UI_MAINSCENE = "texaspoker.uilua.japanese.mainscene"
COCOSTUDIO_UI_MAINSCENE_I4 = "texaspoker.uilua.japanese.mainscene_i4"
COCOSTUDIO_UI_MAINSCENE_IPAD = "texaspoker.uilua.japanese.mainscene_ipad"
COCOSTUDIO_UI_MAINSCENE_S8 = "texaspoker.uilua.japanese.mainscene_s8"
COCOSTUDIO_UI_MAINSCENE_MTTNODE = "texaspoker.uilua.japanese.mainscene_mttnode"
COCOSTUDIO_UI_MAINSCENE_MTTNODE_I4 = "texaspoker.uilua.japanese.mainscene_mttnode_i4"
COCOSTUDIO_UI_MAINSCENE_MTTNODE_IPAD = "texaspoker.uilua.japanese.mainscene_mttnode_ipad"
COCOSTUDIO_UI_MAINSCENE_NORMALNODE = "texaspoker.uilua.japanese.mainscene_normalnode"
COCOSTUDIO_UI_MAINSCENE_NORMALNODE_I4 = "texaspoker.uilua.japanese.mainscene_normalnode_i4"
COCOSTUDIO_UI_MAINSCENE_NORMALNODE_IPAD = "texaspoker.uilua.japanese.mainscene_normalnode_ipad"
COCOSTUDIO_UI_MAINSCENE_NORMALNODE_S8 = "texaspoker.uilua.japanese.mainscene_normalnode_s8"
COCOSTUDIO_UI_MAINSCENE_SNGNODE = "texaspoker.uilua.japanese.mainscene_sngnode"
COCOSTUDIO_UI_MAINSCENE_POOLNODE = "texaspoker.uilua.japanese.mainscene_poolnode"
COCOSTUDIO_UI_MAINSCENE_CARDNODE = "texaspoker.uilua.japanese.mainscene_cardnode"
COCOSTUDIO_UI_MAINSCENE_CARDNODE_I4 = "texaspoker.uilua.japanese.mainscene_cardnode_i4"
COCOSTUDIO_UI_MAINSCENE_CARDNODE_IPAD = "texaspoker.uilua.japanese.mainscene_cardnode_ipad"
COCOSTUDIO_UI_MAINSCENE_CARDNODE_S8 = "texaspoker.uilua.japanese.mainscene_cardnode_s8"
COCOSTUDIO_UI_MAINSCENE_INSURANCEBUYINTIPS_NODE = "texaspoker.uilua.japanese.mainscene_insurancebuyintipsnode"
COCOSTUDIO_UI_MATCHSTATISTICSMAINNODE = "texaspoker.uilua.japanese.matchstatisticsmainnode"
COCOSTUDIO_UI_MATCHSTATISTICSMAINNODE_S8 = "texaspoker.uilua.japanese.matchstatisticsmainnode_s8"
COCOSTUDIO_UI_MATCHSTATISTICSNODE = "texaspoker.uilua.japanese.matchstatisticsnode"
COCOSTUDIO_UI_MATCHUSERSETTLEMENTDATANODE = "texaspoker.uilua.japanese.matchusersettlementdatanode"
COCOSTUDIO_UI_OPERATIONNCHILDRENNODE = "texaspoker.uilua.japanese.operationnchildrennode"
COCOSTUDIO_UI_OPERATIONNCHILDRENMENUNODE = "texaspoker.uilua.japanese.operationnchildrenmenunode"
COCOSTUDIO_UI_OPERATIONNODE = "texaspoker.uilua.japanese.operationnode"
COCOSTUDIO_UI_OTHERINFOFACENODE = "texaspoker.uilua.japanese.otherinfofacenode"
COCOSTUDIO_UI_OTHERINFONODE = "texaspoker.uilua.japanese.otherinfonode"
COCOSTUDIO_UI_PAUSENODE = "texaspoker.uilua.japanese.pausenode"
COCOSTUDIO_UI_PLAGERNODE = "texaspoker.uilua.japanese.plagernode"
COCOSTUDIO_UI_PLAGERNODE_I4 = "texaspoker.uilua.japanese.plagernode_i4"
COCOSTUDIO_UI_PLAGERNODE_OTHER = "texaspoker.uilua.japanese.plagernode_other"
COCOSTUDIO_UI_PLAGERNODE_SELF = "texaspoker.uilua.japanese.plagernode_self"
COCOSTUDIO_UI_PLAGERNODE_SITDOWN = "texaspoker.uilua.japanese.plagernode_sitdown"
COCOSTUDIO_UI_PLAGERNODE_VACANCY = "texaspoker.uilua.japanese.plagernode_vacancy"
COCOSTUDIO_UI_PROMPTNODE = "texaspoker.uilua.japanese.promptnode"
COCOSTUDIO_UI_REALTIMESITUATIONMAINNODE = "texaspoker.uilua.japanese.realtimesituationmainnode"
COCOSTUDIO_UI_REALTIMESITUATIONMAINNODE_S8 = "texaspoker.uilua.japanese.realtimesituationmainnode_s8"
COCOSTUDIO_UI_REALTIMESITUATIONNODE = "texaspoker.uilua.japanese.realtimesituationnode"
COCOSTUDIO_UI_REALTIMESITUATIONOTHERNODE = "texaspoker.uilua.japanese.realtimesituationothernode"  
COCOSTUDIO_UI_REALTIMESITUATIONOTHERHEADIMAGENODE = "texaspoker.uilua.japanese.realtimesituationheadimagenode"
COCOSTUDIO_UI_REVIEWCHILDNODE = "texaspoker.uilua.japanese.reviewchildnode"
COCOSTUDIO_UI_REVIEWMAINNODE = "texaspoker.uilua.japanese.reviewmainnode"
COCOSTUDIO_UI_REVIEWMAINNODE_S8 = "texaspoker.uilua.japanese.reviewmainnode_s8"
COCOSTUDIO_UI_SITDOWNBUYNODE = "texaspoker.uilua.japanese.sitdownbuynode"
COCOSTUDIO_UI_SITDOWNBUYNODE_SHORT = "texaspoker.uilua.japanese.sitdownbuynode_short"
COCOSTUDIO_UI_SYSTEMNOTIFYNODE = "texaspoker.uilua.japanese.systemnotifynode"
COCOSTUDIO_UI_TIMETIPSNODE = "texaspoker.uilua.japanese.timetipsnode"
COCOSTUDIO_UI_USERSETTLEMENTDATANODE = "texaspoker.uilua.japanese.usersettlementdatanode"
COCOSTUDIO_UI_WAITNODE = "texaspoker.uilua.japanese.waitnode"
COCOSTUDIO_UI_WATCHNODE = "texaspoker.uilua.japanese.watchnode"
COCOSTUDIO_UI_WEAKTIPSNODE = "texaspoker.uilua.japanese.weaktipsnode"
COCOSTUDIO_UI_SIGNALTIMENODE = "texaspoker.uilua.japanese.signaltimenode"
COCOSTUDIO_UI_SIGNALTIMENODE_I4 = "texaspoker.uilua.japanese.signaltimenode_i4"
COCOSTUDIO_UI_SIGNALTIMENODE_IPAD = "texaspoker.uilua.japanese.signaltimenode_ipad"
COCOSTUDIO_UI_SIGNALTIMENODE_IPHONEX = "texaspoker.uilua.japanese.signaltimenode_iphonex"

COCOSTUDIO_UI_SNGAWARDFINISHNODE = "texaspoker.uilua.japanese.sng.sngawardfinishnode"
COCOSTUDIO_UI_SNGELIMINATEFINISHNODE = "texaspoker.uilua.japanese.sng.sngeliminatefinishnode"
COCOSTUDIO_UI_SNGELIMINATENODE = "texaspoker.uilua.japanese.sng.sngeliminatenode"
COCOSTUDIO_UI_SNGFINISHCHILDNODE = "texaspoker.uilua.japanese.sng.sngfinishchildnode"
COCOSTUDIO_UI_SNGLEAVENODE = "texaspoker.uilua.japanese.sng.sngleavenode"
COCOSTUDIO_UI_SNGMAINMENUNODE = "texaspoker.uilua.japanese.sng.sngmainmenunode"
COCOSTUDIO_UI_SNGMAINMENUNODE_I4 = "texaspoker.uilua.japanese.sng.sngmainmenunode_i4"
COCOSTUDIO_UI_SNGMAINMENUNODE_IPAD = "texaspoker.uilua.japanese.sng.sngmainmenunode_ipad"
COCOSTUDIO_UI_SNGMAINMENUNODE_S8 = "texaspoker.uilua.japanese.sng.sngmainmenunode_s8"
COCOSTUDIO_UI_SNGREALTIMESITUATIONMAINNODE = "texaspoker.uilua.japanese.sng.sngrealtimesituationmainnode"
COCOSTUDIO_UI_SNGREALTIMESITUATIONMAINNODE_S8 = "texaspoker.uilua.japanese.sng.sngrealtimesituationmainnode_s8"
COCOSTUDIO_UI_SNGREALTIMESITUATIONNODE = "texaspoker.uilua.japanese.sng.sngrealtimesituationnode"
COCOSTUDIO_UI_SNGRULESDETAILSCHILDNODE = "texaspoker.uilua.japanese.sng.sngrulesdetailschildnode"
COCOSTUDIO_UI_SNGRULESDETAILSNODE = "texaspoker.uilua.japanese.sng.sngrulesdetailsnode"
COCOSTUDIO_UI_SNGUSERSETTLEMENTDATANODE = "texaspoker.uilua.japanese.sng.sngusersettlementdatanode"
COCOSTUDIO_UI_SNGCONTROLBUYINMSGNODE = "texaspoker.uilua.japanese.sng.sngcontrolbuyinmsgnode"

-- -- -- 新保险
-- COCOSTUDIO_UI_INSURANCEINFOMAINNODE = "texaspoker.uilua.japanese.insurance.insuranceinfomainnode"
-- COCOSTUDIO_UI_INSURANCEINFOMAINCHILDNODE = "texaspoker.uilua.japanese.insurance.insuranceinfomainchildnode"
-- COCOSTUDIO_UI_INSURANCEINFOCHILDNODE = "texaspoker.uilua.japanese.insurance.insuranceinfochildnode"
-- COCOSTUDIO_UI_INSURANCEBUYINNODE = "texaspoker.uilua.japanese.insurance.insurancebuyinnode"
-- COCOSTUDIO_UI_INSURANCEBUYINOPERATENODE = "texaspoker.uilua.japanese.insurance.insurancebuyinoperatenode"
-- COCOSTUDIO_UI_INSURANCEBUYINCARD = "texaspoker.uilua.japanese.insurance.insurancecardnode"
-- COCOSTUDIO_UI_INSURANCEBUYINTIPS = "texaspoker.uilua.japanese.insurance.insurancebuyintipsnode"
-- COCOSTUDIO_UI_INSURANCEBUYINTIPSCHILDNODE = "texaspoker.uilua.japanese.insurance.insurancebuyintipschildnode"

--旧保险
COCOSTUDIO_UI_INSURANCEINFOMAINNODE = "texaspoker.uilua.japanese.insuranceold.insuranceinfomainnode"
COCOSTUDIO_UI_INSURANCEINFOMAINCHILDNODE = "texaspoker.uilua.japanese.insuranceold.insuranceinfomainchildnode"
COCOSTUDIO_UI_INSURANCEINFOCHILDNODE = "texaspoker.uilua.japanese.insuranceold.insuranceinfochildnode"
COCOSTUDIO_UI_INSURANCEBUYINNODE = "texaspoker.uilua.japanese.insuranceold.insurancebuyinnode"
COCOSTUDIO_UI_INSURANCEBUYINOPERATENODE = "texaspoker.uilua.japanese.insuranceold.insurancebuyinoperatenode"
COCOSTUDIO_UI_INSURANCEBUYINCARD = "texaspoker.uilua.japanese.insuranceold.insurancecardnode"
COCOSTUDIO_UI_INSURANCEBUYINTIPS = "texaspoker.uilua.japanese.insuranceold.insurancebuyintipsnode"
COCOSTUDIO_UI_INSURANCEBUYINTIPSCHILDNODE = "texaspoker.uilua.japanese.insuranceold.insurancebuyintipschildnode"
COCOSTUDIO_UI_INSURANCEBUYINCHILDNODE = "texaspoker.uilua.japanese.insuranceold.insurancebuyinchildnode"

COCOSTUDIO_UI_INSURANCEUSERSETTLEMENTDATANODE = "texaspoker.uilua.japanese.insuranceusersettlementdatanode"
COCOSTUDIO_UI_INSURANCEMATCHUSERSETTLEMENTDATANODE = "texaspoker.uilua.japanese.insurancematchusersettlementdatanode"


COCOSTUDIO_UI_COMMONINPUTNODE = "texaspoker.uilua.japanese.commoninputnode"
COCOSTUDIO_UI_OTHERINFONODE_NEW = "texaspoker.uilua.japanese.otherinfonode_new"

COCOSTUDIO_UI_OMAHA_PLAGERNODE_OTHER = "texaspoker.uilua.japanese.plagernode_other_omaha"
COCOSTUDIO_UI_OMAHA_PLAGERNODE_SELF = "texaspoker.uilua.japanese.plagernode_self_omaha"

COCOSTUDIO_UI_KICKOUTTIPSNODE = "texaspoker.uilua.japanese.kickouttipsnode"
COCOSTUDIO_UI_DISMISSTIPSNODE = "texaspoker.uilua.japanese.dismisstipsnode" 

COCOSTUDIO_UI_FACEBUTTONNODE = "texaspoker.uilua.japanese.facebuttonnode" 
COCOSTUDIO_UI_MICROIMAGENODE = "texaspoker.uilua.japanese.microimagenode" 
COCOSTUDIO_UI_MICROPHONENODE = "texaspoker.uilua.japanese.microphonenode" 
COCOSTUDIO_UI_NOTEBUTTONNODE = "texaspoker.uilua.japanese.notebuttonnode" 
COCOSTUDIO_UI_OPERATEBUTTONNODE = "texaspoker.uilua.japanese.operatebuttonnode" 
COCOSTUDIO_UI_REVIEWBUTTONNODE = "texaspoker.uilua.japanese.reviewbuttonnode" 
COCOSTUDIO_UI_SNG_SNGUPBLINDNODE = "texaspoker.uilua.japanese.sng.sngupblindnode" 

COCOSTUDIO_UI_BUYUNIONNODE = "texaspoker.uilua.japanese.buyunionnode"
COCOSTUDIO_UI_SITDOWNBUYUNIONNODE = "texaspoker.uilua.japanese.sitdownbuyunionnode"
COCOSTUDIO_UI_SITDOWNBUYUNIONNODE_SHORT = "texaspoker.uilua.japanese.sitdownbuyunionnode_short"
COCOSTUDIO_UI_BUYUNIONCHILDNODE = "texaspoker.uilua.japanese.buyinchildnode"

COCOSTUDIO_UI_OTHERINFONODE_SELF = "texaspoker.uilua.japanese.otherinfonode_self"

COCOSTUDIO_UI_TURNLOOKBUTTONNODE = "texaspoker.uilua.japanese.turnlookbuttonnode"
COCOSTUDIO_UI_TURNLOOKNODE = "texaspoker.uilua.japanese.turnlooknode"
COCOSTUDIO_UI_TURNLOOKNODE_I4 = "texaspoker.uilua.japanese.turnlooknode_i4"
COCOSTUDIO_UI_TURNLOOKNODE_IPAD = "texaspoker.uilua.japanese.turnlooknode_ipad"
COCOSTUDIO_UI_TURNLOOKNODE_S8 = "texaspoker.uilua.japanese.turnlooknode_s8"

COCOSTUDIO_UI_TRANSITIONNODE = "texaspoker.uilua.japanese.transitionnode"
COCOSTUDIO_UI_TRANSITIONNODE_i4 = "texaspoker.uilua.japanese.transitionnode_i4"
COCOSTUDIO_UI_TRANSITIONNODE_ipad = "texaspoker.uilua.japanese.transitionnode_ipad"
COCOSTUDIO_UI_TRANSITIONNODE_S8 = "texaspoker.uilua.japanese.transitionnode_s8"
--mtt
COCOSTUDIO_UI_MTT_EXITTIPSNODE = "texaspoker.uilua.japanese.mtt.mttexittipsnode"
COCOSTUDIO_UI_MTT_AWARDFINISHNODE = "texaspoker.uilua.japanese.mtt.mttawardfinishnode"
COCOSTUDIO_UI_MTT_NOAWARDFINISHNODE = "texaspoker.uilua.japanese.mtt.mttnoawardfinishnode"
COCOSTUDIO_UI_MTT_GOBACKNODE = "texaspoker.uilua.japanese.mtt.mttgobacknode"
COCOSTUDIO_UI_MTT_REALTIMESITUATIONMAINNODE = "texaspoker.uilua.japanese.mtt.mttrealtimesituationmainnode"
COCOSTUDIO_UI_MTT_REALTIMESITUATIONMAINNODE_S8 = "texaspoker.uilua.japanese.mtt.mttrealtimesituationmainnode_s8"
COCOSTUDIO_UI_MTT_REALTIMESITUATIONTITLENODE = "texaspoker.uilua.japanese.mtt.mttrealtimesituationtitlenode"
COCOSTUDIO_UI_MTT_REALTIMESITUATIONRANKNODE = "texaspoker.uilua.japanese.mtt.mttrealtimesituationranknode"
COCOSTUDIO_UI_MTT_REALTIMESITUATIONRANKCHILDNODE = "texaspoker.uilua.japanese.mtt.mttrealtimesituationrankchildnode"
COCOSTUDIO_UI_MTT_REALTIMESITUATIONPANELNODE = "texaspoker.uilua.japanese.mtt.mttrealtimesituationpanelnode"
COCOSTUDIO_UI_MTT_REALTIMESITUATIONMATCHDATANODE = "texaspoker.uilua.japanese.mtt.mttrealtimesituationmatchdatanode"
COCOSTUDIO_UI_MTT_REALTIMESITUATIONDESKNODE = "texaspoker.uilua.japanese.mtt.mttrealtimesituationdesknode"
COCOSTUDIO_UI_MTT_REALTIMESITUATIONDESKCHILDNODE= "texaspoker.uilua.japanese.mtt.mttrealtimesituationdeskchildnode"
COCOSTUDIO_UI_MTT_REALTIMESITUATIONAWARDNODE= "texaspoker.uilua.japanese.mtt.mttrealtimesituationawardnode"
COCOSTUDIO_UI_MTT_REALTIMESITUATIONAWARDNEXTNODE= "texaspoker.uilua.japanese.mtt.mttrealtimesituationawardnextnode"
COCOSTUDIO_UI_MTT_REALTIMESITUATIONAWARDCHILDNODE= "texaspoker.uilua.japanese.mtt.mttrealtimesituationawardchildnode"
COCOSTUDIO_UI_MTT_REALTIMESITUATIONBLINDNODE= "texaspoker.uilua.japanese.mtt.mttrealtimesituationblindnode"
COCOSTUDIO_UI_MTT_REALTIMESITUATIONBLINDCHILDNODE= "texaspoker.uilua.japanese.mtt.mttrealtimesituationblindchildnode"
COCOSTUDIO_UI_MTT_REALTIMESITUATIONINTRONODE= "texaspoker.uilua.japanese.mtt.mttrealtimesituationintronode"

COCOSTUDIO_UI_MTT_REENTRYTIPSNODE = "texaspoker.uilua.japanese.mtt.mttreentrytipsnode"
COCOSTUDIO_UI_MTT_SIGNUPNODE = "texaspoker.uilua.japanese.mtt.mttsignupnode"
COCOSTUDIO_UI_MTT_STARTPUSHNODE = "texaspoker.uilua.japanese.mtt.mttstartpushnode"
COCOSTUDIO_UI_MTT_STARTPUSHCHILDNODE = "texaspoker.uilua.japanese.mtt.mttstartpushchildnode"
COCOSTUDIO_UI_MTT_WATCHDESKFINISHNODE = "texaspoker.uilua.japanese.mtt.mttwatchdeskfinishnode"
COCOSTUDIO_UI_MTT_WATCHFINISHNODE = "texaspoker.uilua.japanese.mtt.mttwatchfinishnode"

--牌谱
COCOSTUDIO_UI_POKERTEXTINFO_NODE = "texaspoker.uilua.japanese.pokertextinfonode"
COCOSTUDIO_UI_POKERTEXTINFO_NODE_S8 = "texaspoker.uilua.japanese.pokertextinfonode_s8"
COCOSTUDIO_UI_POKERTEXTINFO_NODE_SHORT = "texaspoker.uilua.japanese.pokertextinfonode_short"
COCOSTUDIO_UI_POKERTEXTINFO_NODE_SHORT_S8 = "texaspoker.uilua.japanese.pokertextinfonode_short_s8"
COCOSTUDIO_UI_POKERTEXTINFO_SHOWDOWN_NODE = "texaspoker.uilua.japanese.pokertextinfoshowdownnode"
COCOSTUDIO_UI_POKERTEXTINFO_SHOWDOWN_NODE_SHORT = "texaspoker.uilua.japanese.pokertextinfoshowdownnode_short"
COCOSTUDIO_UI_POKERTEXTINFO_SHOWDOWN_TITLE_NODE = "texaspoker.uilua.japanese.pokertextinfoshowdowntitlenode"
COCOSTUDIO_UI_POKERTEXTINFO_SHOWDOWN_TITLE_NODE_SHORT = "texaspoker.uilua.japanese.pokertextinfoshowdowntitlenode_short"
COCOSTUDIO_UI_POKERTEXTINFO_SHOWDOWN_CHILD_NODE = "texaspoker.uilua.japanese.pokertextinfoshowdownchildnode"
COCOSTUDIO_UI_POKERTEXTINFO_SHOWDOWN_CHILD_NODE_SHORT = "texaspoker.uilua.japanese.pokertextinfoshowdownchildnode_short"
COCOSTUDIO_UI_POKERTEXTINFO_INSURANCE_NODE = "texaspoker.uilua.japanese.pokertextinfoinsurancenode"
COCOSTUDIO_UI_POKERTEXTINFO_STATE_NODE = "texaspoker.uilua.japanese.pokertextinfostatenode"
COCOSTUDIO_UI_POKERTEXTINFO_STATE_CHILD_NODE = "texaspoker.uilua.japanese.pokertextinfostatechildnode"
COCOSTUDIO_UI_POKERTEXTINF_BUTTON_NODE = "texaspoker.uilua.japanese.pokertextinfobuttonnode"

--个人设置
COCOSTUDIO_UI_SETTING_NODE = "texaspoker.uilua.japanese.settingnode"
COCOSTUDIO_UI_SETTING_SELF_NODE = "texaspoker.uilua.japanese.settingselfnode"
COCOSTUDIO_UI_SETTING_SELF_POT_CHILD_NODE = "texaspoker.uilua.japanese.settingselfraisepotchildnode"
COCOSTUDIO_UI_SETTING_ADVANCE_NODE = "texaspoker.uilua.japanese.settingadvancenode"

--弹幕
COCOSTUDIO_UI_BULLETSCREEN_BUTTON_NODE = "texaspoker.uilua.japanese.bulletbuttonnode"
COCOSTUDIO_UI_BULLETSCREEN_NODE = "texaspoker.uilua.japanese.bulletscreennode"
COCOSTUDIO_UI_BULLETSCREEN_CHILD_NODE = "texaspoker.uilua.japanese.bulletscreenchildnode"
COCOSTUDIO_UI_BULLETSCREEN_CHILD_TEXT_NODE = "texaspoker.uilua.japanese.bulletscreentextnode"

--UI文本内容------------------------------------------------------
    STR_ADVANCEDSETTINGS_OPTIONSTR = "管理員機能"
    STR_ADVANCEDSETTINGS_BUYINSTR = "リバイの倍数設定"
    STR_ADVANCEDSETTINGS_BUYINCTRLSTR = "バイイン確認を要求"
    STR_ADVANCEDSETTINGS_PAUSESTR = "ゲーム一時中止"
    STR_ADVANCEDSETTINGS_DISMISSSTR = "ゲーム解散"
    STR_ADVANCEDSETTINGS_NOSAVETEXT = "保存"
    STR_ADVANCEDSETTINGS_SAVEDTEXT = "保存済"
    STR_ADVANCEDSETTINGS_SETTIMETEXT = "タイムバンク(次のハンドから有効)"
    STR_ADVANCEDSETTINGS_STRADDLE_TEXT = "ストラドル"
    STR_ADVANCEDSETTINGS_PUSHTEXT = "通知"

    STR_BUYNODE_BUYINSTR = "リバイ"
    STR_BUYNODE_BUYTIPSSTR = "次のハンドが始まったらリバイのチップを追加します"
    STR_BUYNODE_BUYSTR = "バイイン"
    STR_BUYNODE_COINSSTR = "合計残高："
    STR_BUYNODE_FEESTR = "手数料："
    STR_BUYNODE_BUYBUTTON_STR  = "バイイン確認"
    STR_BUYNODE_NOTIFYTIPS_STR = "バイイン申請のクラブを選択してください"
    
    STR_CASHOUT_TITLE = "キャッシュアウト"
    STR_CASHOUT_CONTENT01 = "このハンドが終わってからキャッシュアウトが行われます。"
    STR_CASHOUT_CONTENT02 = "キャッシュアウト"
    STR_CASHOUT_CONTENT03 = "ゲームが始まってからキャッシュアウトが行われます"
    STR_CASHOUT_CONFIRM = "キャッシュアウト確認"
    STR_CASHOUT_TIPS_ALREADY = "You already cash out in this hand."

    STR_CASHOUT_SUCCESS = "キャッシュアウト成功%d"
    STR_CASHOUT_NOT_ENOUGH = "チップ不足"
    STR_CASHOUT_FAIL = "チップ不足"

    STR_CHECKPROMPTNODE_TIPSSTR = "ヒント"
    STR_CHECKPROMPTNODE_TIPSSTR01 = "チェックは無料です。"
    STR_CHECKPROMPTNODE_TIPSSTR02 = "本当にフォルドしますか？"
    STR_CHECKPROMPTNODE_HIDETIPSSTR = "ヒントを隠す"
    STR_CHECKPROMPTNODE_CHECKBUTTON_STR = "チェック"
    STR_CHECKPROMPTNODE_FOLDBUTTON_STR = "フォルド"

    STR_COMMONINPUTNODE_NEW_TAGSTR = "タグ"
    STR_COMMONINPUTNODE_NEW_CANCELTEXT = "取り消し"
    STR_COMMONINPUTNODE_NEW_SAVETEXT = "保存"
    STR_COMMONINPUTNODE_PLACEHODER_REMARK_TEXT = "別名を編集してください"
    STR_COMMONINPUTNODE_PLACEHODER_TAG_TEXT = "タグを編集してください"
    STR_COMMONINPUTNODE_NEW_REMARKSTR = "別名"

    STR_ERRORNODE_TIPSSTR = "ヒント"
    STR_ERRORNODE_CANCELSTR = "取り消し"
    STR_ERRORNODE_CANCELSTR_NEW = "わかった"

    STR_FACEPAG_INFOTEXT  = "絵文字"
    STR_FACEPAG_INFOTEXT1 = "ステッカー (20"
    STR_FACEPAG_INFOTEXT2 = "/回)"

    STR_GOTOSHOPNODE_TIPSSTR = "ヒント"
    STR_GOTOSHOPNODE_CANCELTEXT = "取り消し"
    STR_GOTOSHOPNODE_OKTEXT = "コイン購入"

    STR_INSURANCEMATCHUSERSETTLEMENTDATANODE_NAMETEXT = "保険ポット"
    STR_INSURANCEUSERSETTLEMENTDATANODE_NAMETEXT = "保険ポット"

    STR_KICKOUTTIPSNODE_TIPSTEXT01 = "プレイヤーが追い出されたら戻ってこれません"
    STR_KICKOUTTIPSNODE_TIPSTEXT02 = "このゲームから出入り禁止にします"
    STR_KICKOUTTIPSNODE_PAUSETBUTTON = "一時中止"
    STR_KICKOUTTIPSNODE_KICKBUTTON = "追い出し確定"

    STR_MAINSCENE_STARTSTATETEXT = "次のハンドまで待つ"

    STR_MATCHSTATISTICSNODE_NICKNAMESTR = "ハンドルネーム"
    STR_MATCHSTATISTICSNODE_BUYINSTR = "バイイン"
    STR_MATCHSTATISTICSNODE_WONSTR = "勝ち"
    STR_MATCHSTATISTICSNODE_RESULTSTR = "個人戦績"
    STR_MATCHSTATISTICSNODE_TITLESTR = "ゲーム統計"
    STR_MATCHSTATISTICSNODE_TOTALHANDSTR = "合計ハンド数"
    STR_MATCHSTATISTICSNODE_MAXPOTSTR = "MAXポット"
    STR_MATCHSTATISTICSNODE_TOTALBUYSTR = "合計バイイン"
    STR_MATCHSTATISTICSNODE_MVP = "MVP"
    STR_MATCHSTATISTICSNODE_BOSS = "Tuhao"
    STR_MATCHSTATISTICSNODE_FISH = "Whale"

    STR_OTHERINFONODE_NEW_REMARKTEXT = "タグ"
    STR_OTHERINFONODE_NEW_NILTEXT = "別名とタグ"
    STR_OTHERINFONODE_NEW_VOICETEXT = "音声再生"
    STR_OTHERINFONODE_NEW_ADDTEXT = "友達に追加"
    STR_OTHERINFONODE_NEW_KICKTEXT = "追い出す"
    STR_OTHERINFONODE_NEW_STANDUPTEXT = [[  強制に席を
    立たせる]]
    STR_OTHERINFONODE_NEW_MATCHSTR = "ゲーム数"
    STR_OTHERINFONODE_NEW_HANDSTR = "合計ハンド数"
    STR_OTHERINFONODE_NEW_POOLSTR = "VPIP"
    STR_OTHERINFONODE_NEW_WINSTR = "PFR"
    STR_OTHERINFONODE_PROFITSTR = "損益"
    STR_OTHERINFONODE_ALLINWINSTR = "All In勝率"
    STR_OTHERINFONODE_SNGMATCHSTR = "トーナメント参加回数"
    STR_OTHERINFONODE_SNGCHAMPIONSTR = "優勝回数"
    STR_OTHERINFONODE_SNGSECONDSTR = "2位回数"
    STR_OTHERINFONODE_SNGTHIRDSTR = "2位回数"
    STR_OTHERINFONODE_MTTCHAMPIONSTR = "優勝回数"
    STR_OTHERINFONODE_MTTFIRSTTHREESTR = "トップ3位回数"
    STR_OTHERINFONODE_MTTBONUSSTR = "ITM回数"
    STR_OTHERINFONODE_NICKNAMESTR = "ハンドルネーム:"

    STR_OTHERINFOSELFNODE_TIPSSTR = "最近30日"
    STR_OTHERINFOSELFNODE_SNGTIPSSTR = ""

    STR_REALTIMESITUATIONNODE_NICKNAMESTR = "プレイヤー"
    STR_REALTIMESITUATIONNODE_BUYINSTR = "バイイン"
    STR_REALTIMESITUATIONNODE_RESULTSTR = "結果"

    STR_REALTIMESITUATIONOTHERNODE_WATCHSTR = "観戦者"

    STR_REVIEWMAINNODE_REVIEWSTR = "全部レビュー"

    STR_SITDOWNBUYNODE_BLINDSTR = "SB/BB"
    STR_SITDOWNBUYNODE_BUYINSTR = "バイイン"
    STR_SITDOWNBUYNODEE_COINSSTR = "合計コイン:"
    STR_SITDOWNBUYNODE_FEESTR = "手数料:"
    STR_SITDOWNBUYNODE_BUYBUTTON = "ゲーム参加"
    STR_SITDOWNBUYNODE_NOTIFYTIPS_STR = "クラブにバイインを申請する"
    STR_SITDOWNBUYNODE_BLINDSTR_SHORT = "ANTE"

    STR_INSURANCEBUYINCHILDNODE_PAYSTR = "支払う"
    STR_INSURANCEBUYINCHILDNODE_CLAIMSTR = "払い戻し"
    STR_INSURANCEBUYINCHILDNODE_OUTSTR = "アウツ"
    STR_INSURANCEBUYINCHILDNODE_ODDSTR = "倍率"

    STR_INSURANCEBUYINNODE_PASSSTR = "掛けない"

    STR_INSURANCEBUYINOPERATENODE_STATETEXT = "元金保障"
    STR_INSURANCEBUYINOPERATENODE_INPUTTEXT = "掛け金"
    STR_INSURANCEBUYINOPERATENODE_RAISEENDENDTEXT = "MAX"
    STR_INSURANCEBUYINOPERATENODE_STATEIMAGETEXT = "-元金保障保本"
    STR_INSURANCEBUYINOPERATENODE_RAISEENDIMAGEBUTTON = "MAX"
    STR_INSURANCEBUYINOPERATENODE_CHARGETEXT = "払い戻し"
    STR_INSURANCEBUYINOPERATENODE_ODDSTEXT = "倍率"
    STR_INSURANCEBUYINOPERATENODE_COMCARDSTR = "コミュニティーカード"
    STR_INSURANCEBUYINOPERATENODE_HANDSCARDSTR = "ハンド"
    STR_INSURANCEBUYINOPERATENODE_PLAYERCARDSTR = "相手のハンド"
    STR_INSURANCEBUYINOPERATENODE_OUTSSTR = "アウツ"
    STR_INSURANCEBUYINOPERATENODE_SPLITOUTSSTR = "スプリットポット"
    STR_INSURANCEBUYINOPERATENODE_PREMIUMONSSTR = "掛け金に対しての新しい掛け金"
    STR_INSURANCEBUYINOPERATENODE_ODDSONSSTR = "掛け金に対しての倍率"
    STR_INSURANCEBUYINOPERATENODE_SELECTALLSTR = "全部"

    STR_SNGAWARDFINISHNODE_TITLE_ELIMINATE = "残念ながら終了しました"
    STR_SNGAWARDFINISHNODE_SHARESTR = "素晴らしい記録です！みんなとシェアしましょう！"
    STR_SNGAWARDFINISHNODE_PLACESTR = "順位"
    STR_SNGAWARDFINISHNODE_NICKNAMESTR = "ハンドルネーム"
    STR_SNGAWARDFINISHNODE_REWARDSTR = "プライズ"
    STR_SNGAWARDFINISHNODE_SHOWOFFBUTTON_STR = "ドヤ顔を見せよう"

    STR_SNGELIMINATEFINISHNODE_TITLESTR = "トーナメント終了"
    STR_SNGELIMINATEFINISHNODE_PLACESTR = "順位"
    STR_SNGELIMINATEFINISHNODE_NICKNAMESTR = "ハンドルネーム"
    STR_SNGELIMINATEFINISHNODE_REWARDSTR = "プライズ"
    STR_SNGELIMINATEFINISHNODE_RANKSTR01 = ""
    STR_SNGELIMINATEFINISHNODE_RANKSTR02 = "位"
    STR_SNGELIMINATEFINISHNODE_RANKAWARDSTR = "ボーナス:"

    STR_SNGELIMINATENODE_STAYBUTTON_STR = "観戦する"
    STR_SNGELIMINATENODE_EXITBUTTON_STR = "退出"
    STR_SNGELIMINATENODE_RANKSTR01 = ""
    STR_SNGELIMINATENODE_RANKSTR02 = "位"

    STR_SNGLEAVENODE_CANCELTEXT = "取り消し"
    STR_SNGLEAVENODE_OKTEXT = "退出する"
    STR_SNGCONTROLBUYINMSG_STR = "新規ゲーム通知"

    STR_SNGMAINSCENE_STARTSTATETEXT = "次のハンドをお待ちください"

    STR_SNGREALTIMESITUATIONNODE_PLACESTR = "順位"
    STR_SNGREALTIMESITUATIONNODE_NICKNAMESTR = "ハンドルネーム"
    STR_SNGREALTIMESITUATIONNODE_RESULTSTR = "チップ"

    STR_SNGRULESDETAILSNODE_LEVELSTR = "レベル"
    STR_SNGRULESDETAILSNODE_BLINDSTR = "更新"

    STR_INSURANCEINFOMAINCHILDNODE_TITLESTR = "保険について"
    STR_INSURANCEINFOMAINCHILDNODE_OMAHA_TITLESTR = "保険について"
    STR_INSURANCEINFOMAINCHILDNODE_INTROSTR01 = "紹介："
    STR_INSURANCEINFOMAINCHILDNODE_INTROSTR02 = "操作："
    STR_INSURANCEINFOMAINCHILDNODE_INTROSTR03 = "倍率："

    STR_MICROPHONEPAG_SEND_TIPSTEXT = "上へスライドして発送をキャンセルする"
    STR_MICROPHONEPAG_CANCEL_TIPSTEXT = "離してして発送をキャンセルする"
    STR_MICROPHONEPAG_SENDED_TIPSTEXT = "発送しました"

    STR_DISMISSTIPSPAG_TIPSTEXT = "本当にゲームの終了を現在に繰り上げますか？"
    STR_CANCELBUTTON_STR = "取り消し"
    STR_OKBUTTON_STR = "確認"
    STR_FORCESTAND_TIPSTEXT = "このプレイヤーは強制的にシットアウトされます。確認しますか？"

    STR_FANFANKAN_TITLE_TEXT = [[結果はご参考まで]]
    STR_TURNLOOK_TITLE_FLOP_TEXT = [[ラビットハ
    ンティング]]
    STR_TURNLOOK_TITLE_TURN_TEXT = [[チップを
    あげてタ
    ーンを見る]]
    STR_TURNLOOK_TITLE_RIVER_TEXT = [[チップを
    あげてリ
    バーを見る]]
    STR_TURNLOOK_TIPS_TEXT = "ご参考まで"
    STR_TURNLOOK_NOENOUGHCOIN_WEAKTIPS_TEXT = "コインが不足しています"
    STR_TURNLOOK_NOTRIGHTTIME_WEAKTIPS_TEXT = "今カードを見れません"

    STR_SNG_UPBLIND_TITLE_TEXT = "次のブラインドに上がるまであと"

    --mtt 死文本简繁英
    STR_MTT_REENTRY_TIPS = "次回から読まない"
    STR_MTT_SHAREIT_BUTTON_TITLE = "シェアする"
    STR_MTT_EXIT_BUTTON_TITLE = "退出する"
    STR_MTT_CHANGETABLE_BUTTON_TITLE = "テーブル切り替え"
    STR_MTT_FINISH_NOAWARD_TITLE = [[あなたはトーナメントを終
    了しました。次回頑張りましょう。]]
    STR_MTT_EXITTIPS_TITLE = [[トーナメントから退出したら自動的
    にシットアウトされ、いつでもゲームに戻れます。]]
    STR_MTT_SIGNUP_SIGN_TEXT = "参加:"
    STR_MTT_SIGNUP_TICKET_TEXT = "条件:"

    STR_MTT_REALTIMES_MATCH_SCORE_TEXT = "平均チップ"
    STR_MTT_REALTIMES_MATCH_NEXTTIME_TEXT = "次のレベルタイム"
    STR_MTT_REALTIMES_MATCH_BLINDTIME_TEXT = "次のブラインドまであと"
    STR_MTT_REALTIMES_MATCH_CURBLIND_TEXT = "ブラインド"
    STR_MTT_REALTIMES_MATCH_NEXTLEVEL_TEXT = "次のブラインドレベル"
    STR_MTT_REALTIMES_MATCH_PLAYERNUM_TEXT = "人数"
    STR_MTT_REALTIMES_MATCH_USEDTIME_TEXT = "時間経過"

    STR_MTT_REALTIMES_REENTRY_TEXT = "自動リエントリー"
    STR_MTT_REALTIMES_UPDATE_TEXT = "更新"
    STR_MTT_REALTIMES_PAGE_TITLE_TEXT01 = "実況"
    STR_MTT_REALTIMES_PAGE_TITLE_TEXT02 = "テーブル"
    STR_MTT_REALTIMES_PAGE_TITLE_TEXT03 = "プライズ"
    STR_MTT_REALTIMES_PAGE_TITLE_TEXT04 = "ブラインド"
    STR_MTT_REALTIMES_PAGE_TITLE_TEXT05 = "状況"
    STR_MTT_REALTIMES_RANK_TITLE_TEXT = "順位"
    STR_MTT_REALTIMES_RANK_TITLE_DESK_TEXT = "テーブル"
    STR_MTT_REALTIMES_RANK_TITLE_SCORE_TEXT = "チップ"
    STR_MTT_REALTIMES_RANK_TITLE_BLIND_TEXT = "BB"
    STR_MTT_REALTIMES_DESK_TITLE_DESKNUM_TEXT = "テーブル"
    STR_MTT_REALTIMES_DESK_TITLE_PLAYERNUM_TEXT = "人数"
    STR_MTT_REALTIMES_DESK_TITLE_STACK_TEXT = "チップ"
    STR_MTT_REALTIMES_AWARD_TITLE_PRIZEPOOL_TEXT = "プライズプール:"
    STR_MTT_REALTIMES_AWARD_TITLE_ITM_TEXT = "ITM:"
    STR_MTT_REALTIMES_AWARD_TITLE_NEXTPRIZE_TEXT = "次のプライズ:"
    STR_MTT_REALTIMES_BLIND_TITLE_LEVEL_TEXT = "レベル"
    STR_MTT_REALTIMES_BLIND_TITLE_BLIND_TEXT = "ブラインド"
    STR_MTT_REALTIMES_BLIND_TITLE_ANTE_TEXT = "アンティ"
    STR_MTT_REALTIMES_BLIND_TITLE_BLINDTIME_TEXT = "レベルタイム"

    STR_MTT_MAINSCENE_START_TIPS_TEXT = "スタートまであと"
    STR_MTT_GOBACK_BUTTON_TITLE_TEXT = "ゲームに戻る"

    MAINSCENE_START_BUTTON_TEXT = "スタート"
    MAINSCENE_SHARE_BUTTON_TEXT = "シェア"


    --UI设置控件---------
    IMAGE_MATCHSTATISTICSNODE_OMAHALOGOIMAGE = "game/game_layer/jp/matchstatistics/jp_omaha_logo.png"
    IMAGE_MATCHSTATISTICSNODE_INSURANCEIMAGE = "game/game_layer/jp/insurance/insurance_baoxianju_jp.png"
    IMAGE_MATCHSTATISTICSNODE_SHORTDUCKLOGOIMAGE = "game/game_layer/jp/matchstatistics/jp_shortduck_logo.png"

    -- IMAGE_INSURANCEINFOMAINCHILDNODE_TIPSIMAGE = "game/game_layer/common/insurance/insurance_info_odds.png"
    -- IMAGE_INSURANCEINFOMAINCHILDNODE_OMAHA_TIPSIMAGE = "game/game_layer/common/insurance/omaha_insurance_info_odds.png"


    --根据主题不同，替换按钮图
    PLAYER_SELF_OPERATE_FREE_RAISE_BUTTON_ICON = "game/game_layer/common/ic_operate_blue_big.png"
    PLAYER_SELF_OPERATE_FREE_RAISE_BUTTON_SELECTED_ICON = "game/game_layer/common/ic_operate_blue_big_press.png"
    PLAYER_SELF_OPERATE_POT_AND_BLIND_BUTTON_ICON = "game/game_layer/common/ic_operate_blue_small.png"
    PLAYER_SELF_OPERATE_POT_AND_BLIND_BUTTON_PRESSED_ICON = "game/game_layer/common/ic_operate_blue_small_press.png"

    STR_PLAYER_SELF_FREERAISE_BUTTON_TITLE_TEXT = "スライドしてレイズ"
    STR_PLAYER_SELF_ENSURE_BUTTON_TITLE_TEXT = "確認"
    STR_PLAYER_SELF_CHECK_BUTTON_TITLE_TEXT = "チェック"
    STR_PLAYER_SELF_CALL_BUTTON_TITLE_TEXT = "コール"
    STR_PLAYER_SELF_FOLD_BUTTON_TITLE_TEXT = "フォルド"
    STR_PLAYER_SELF_ALLIN_BUTTON_TITLE_TEXT = "All In"
    STR_PLAYER_SELF_BLIND_BUTTON_TITLE_TEXT = "BB"
    STR_PLAYER_SELF_ANTE_BUTTON_TITLE_TEXT = "Ante"
    STR_PLAYER_SELF_POT_BUTTON_TITLE_TEXT = "ポット"
    STR_PLAYER_SELF_AUTO_CHECK_CHECKBOX_TITLE_TEXT = "自動チェック"
    STR_PLAYER_SELF_AUTO_CALL_CHECKBOX_TITLE_TEXT = "自動コール"
    STR_PLAYER_SELF_AUTO_QUIT_CHECKBOX_TITLE_TEXT = "チェック/フォルド"

    STR_PLAYER_EMPTY_TITLE_TEXT = "空席"
    STR_PLAYER_OPEN_TITLE_TEXT = "座る"

    STR_PLAYER_CANCEL_DELEGATE_TEXT = "戻る"
    STR_PLAYER_SITDOWN_BACK_TEXT = "戻る"

    --公用底层按钮 有2种
    COMMON_BACKIMAGE_BUTTON_NORMAL_IMAGE = "game/game_layer/common/btn_blank-i6p.png"
    COMMON_BACKIMAGE_BUTTON_MASK_IMAGE = "game/game_layer/common/dark.png"
    STR_SHORT_POKER_TYPE_PATH = "game/game_layer/common/prompt/ic_prompt_image%d.png"
    
    --牌型提示牌型文字
    STR_PROMPT_RULES_TEXT_LIST = {}
    STR_PROMPT_RULES_TEXT_LIST[1] = "ロイヤルフラッシュ"
    STR_PROMPT_RULES_TEXT_LIST[2] = "ストレートフラッシュ"
    STR_PROMPT_RULES_TEXT_LIST[3] = "4カード"
    STR_PROMPT_RULES_TEXT_LIST[4] = "フルハウス"
    STR_PROMPT_RULES_TEXT_LIST[5] = "フラッシュ"
    STR_PROMPT_RULES_TEXT_LIST[6] = "ストレート"
    STR_PROMPT_RULES_TEXT_LIST[7] = "3カード"
    STR_PROMPT_RULES_TEXT_LIST[8] = "ツーペア"
    STR_PROMPT_RULES_TEXT_LIST[9] = "ワンペア"
    STR_PROMPT_RULES_TEXT_LIST[10] = "ハイカード"

    STR_OTHERINFO_GPS_POS_TEXT = "Distance "
    STR_OTHERINFO_GPS_NO_POS_TEXT = "Location Service Inactive"
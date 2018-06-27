module(...,package.seeall)

--通知消息
MSG_MINI_CARIBBEAN_ENUM = {
    MSG_TYPE_ENUM_MINIGAME_CARIBBEAN_CSINI = 1401,  --加勒比海盗游戏 开始
    MSG_TYPE_ENUM_MINIGAME_CARIBBEAN_CSREFRESHPOOL = 1402,  --加勒比海盗游戏 刷新奖池Pool
    MSG_TYPE_ENUM_MINIGAME_CARIBBEAN_CSSTART = 1403,  --加勒比海盗游戏 下注后deal
    MSG_TYPE_ENUM_MINIGAME_CARIBBEAN_CSCHECK = 1404,  --加勒比海盗游戏 二次下注
}

-- 文本
MINI_NOTICE_STR={}
MINI_NOTICE_STR[1] = [[Congrats! ]]
MINI_NOTICE_STR[2] = [[ won ]]
MINI_NOTICE_STR[3] = [[ Coins with ]]
MINI_NOTICE_STR[4] = [[.]]

STR_TEXT_GO_TO_SHOP_COIN_CARIBBEAN_TEXT = [[No enough Coins %d, purchase more
Coins please go to Store]]
STR_GOTOSHOPNODE_TIPSSTR = "Notice"
STR_GOTOSHOPNODE_CANCELTEXT = "Cancel"
STR_TEXT_GO_TO_SHOP_COIN_TEXT = [[No enough Coins, purchase more Coins
please go to Store]]
STR_GOTOSHOPNODE_OKTEXT = "Purchase"
STR_TEXT_GO_TO_SHOP_COIN_BUTTON_TEXT = "Purchase"

--UI
STR_CARIBBEAN_BET = "BET"
STR_CARIBBEAN_REBET = "REBET"
STR_CARIBBEAN_DEAL = "DEAL"
STR_CARIBBEAN_FOLD = "FOLD"
STR_CARIBBEAN_RAISE = "RAISE"

POKER_MINI_CT_NAME={}
POKER_MINI_CT_NAME[CT_SINGLE]=[[High card]]
POKER_MINI_CT_NAME[CT_ONE_LONG]=[[A pair]]
POKER_MINI_CT_NAME[CT_TWO_LONG]=[[Two pairs]]
POKER_MINI_CT_NAME[CT_THREE_TIAO]=[[Three of a kind]]
POKER_MINI_CT_NAME[CT_SHUN_ZI]=[[Straight]]
POKER_MINI_CT_NAME[CT_TONG_HUA]=[[Flush]]
POKER_MINI_CT_NAME[CT_HU_LU]=[[Full House]]
POKER_MINI_CT_NAME[CT_TIE_ZHI]=[[Four of a kind]]
POKER_MINI_CT_NAME[CT_TONG_HUA_SHUN]=[[Straight Flush]]
POKER_MINI_CT_NAME[CT_KING_TONG_HUA_SHUN]=[[Straight Flush]]


CARIBBEAN_BG_PNG_ANTE = "minigame/caribbean/eng/ante.png"
CARIBBEAN_BG_PNG_BET = "minigame/caribbean/eng/bet.png"
CARIBBEAN_LIST_PNG = "minigame/caribbean/eng/list.png"
CARIBBEAN_HELP_INFO_PNG = "minigame/caribbean/eng/info_pic.png"
CARIBBEAN_POKER_TYPE_PNG = "minigame/caribbean/eng/type_%d.png"
CARIBBEAN_JACKPOT_ANI_PNG = "minigame/caribbean/eng/jackpot/scrollviewAni_%d.png"
CARIBBEAN_BTN_JACKPOT_ANI_PNG = "minigame/caribbean/eng/jackpot/jackpotAni_%d.png"

BTN_CHIP_SLIDER_PRESSED_PNG = "minigame/caribbean/eng/rasie_ctr.png"
BTN_JACKPOT_NORMAL_PNG = "minigame/caribbean/eng/jackpot/jackpotdis.png"
BTN_JACKPOT_PRESSED_PNG = "minigame/caribbean/eng/jackpot/selected.png"

COCOSTUDIO_UI_SYSTEMNOTIFYNODE = "texasgame.uilua.english.englishsystemnotifynode"
USER_STATE_IMAGE = {
  POKER_BACK_ICON = "game/game_layer/ingame_poker/normal/poker_back_1.png", --牌背景
  POKER_SELECTED_ICON = "game/game_layer/ingame_poker/normal/poker_card_selected.png", --牌被选择高亮
}
STR_TEXT_POKER_FACECARD = "game/game_layer/ingame_poker/normal/poker_%d.png"
COCOSTUDIO_UI_LODINGNODE = "texasgame.uilua.english.englishlodingnode"
LODING_ANIMATE_IMAGE = "loading/loading_000%d@2x.png"
COCOSTUDIO_UI_GOTOSHOPNODE = "texasgame.uilua.english.englishgotoshopnode"

COCOSTUDIO_UI_MINIGAME_CARIBBEANSCENE = "minigame.caribbean.uilua.english.englishcaribbeanscene"
COCOSTUDIO_UI_MINIGAME_CARIBBEANSCENE_I4 = "minigame.caribbean.uilua.english.englishcaribbeanscene_i4"
COCOSTUDIO_UI_MINIGAME_CARIBBEANSCENE_IPAD = "minigame.caribbean.uilua.english.englishcaribbeanscene_ipad"
COCOSTUDIO_UI_MINIGAME_CARIBBEANSCENE_S8 = "minigame.caribbean.uilua.english.englishcaribbeanscene_s8"
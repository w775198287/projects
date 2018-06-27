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
MINI_NOTICE_STR[1] = [[恭喜]]
MINI_NOTICE_STR[2] = [[在加勒比撲克中，擊中]]
MINI_NOTICE_STR[3] = [[喜獲]]
MINI_NOTICE_STR[4] = [[大獎]]

STR_TEXT_GO_TO_SHOP_COIN_CARIBBEAN_TEXT = "德撲幣不足%d，請購買"
STR_GOTOSHOPNODE_TIPSSTR = "温馨提示"
STR_GOTOSHOPNODE_CANCELTEXT = "取消"
STR_TEXT_GO_TO_SHOP_COIN_TEXT = "德撲幣不足，請購買"
STR_GOTOSHOPNODE_OKTEXT = "購買德州幣"
STR_TEXT_GO_TO_SHOP_COIN_BUTTON_TEXT = "購買德撲幣"

--UI
STR_CARIBBEAN_BET = "下註"
STR_CARIBBEAN_REBET = "重購"
STR_CARIBBEAN_DEAL = "發牌"
STR_CARIBBEAN_FOLD = "棄牌"
STR_CARIBBEAN_RAISE = "加註"

POKER_MINI_CT_NAME={}
POKER_MINI_CT_NAME[CT_SINGLE]=[[高牌]]
POKER_MINI_CT_NAME[CT_ONE_LONG]=[[壹對]]
POKER_MINI_CT_NAME[CT_TWO_LONG]=[[兩對]]
POKER_MINI_CT_NAME[CT_THREE_TIAO]=[[三條]]
POKER_MINI_CT_NAME[CT_SHUN_ZI]=[[順子]]
POKER_MINI_CT_NAME[CT_TONG_HUA]=[[同花]]
POKER_MINI_CT_NAME[CT_HU_LU]=[[葫蘆]]
POKER_MINI_CT_NAME[CT_TIE_ZHI]=[[四條]]
POKER_MINI_CT_NAME[CT_TONG_HUA_SHUN]=[[同花順]]
POKER_MINI_CT_NAME[CT_KING_TONG_HUA_SHUN]=[[皇家同花順]]


CARIBBEAN_BG_PNG_ANTE = "minigame/caribbean/cns/ante.png"
CARIBBEAN_BG_PNG_BET = "minigame/caribbean/cns/bet.png"
CARIBBEAN_LIST_PNG = "minigame/caribbean/cns/list.png"
CARIBBEAN_HELP_INFO_PNG = "minigame/caribbean/cns/info_pic.png"
CARIBBEAN_POKER_TYPE_PNG = "minigame/caribbean/cns/type_%d.png"
CARIBBEAN_JACKPOT_ANI_PNG = "minigame/caribbean/cns/jackpot/scrollviewAni_%d.png"
CARIBBEAN_BTN_JACKPOT_ANI_PNG = "minigame/caribbean/cns/jackpot/jackpotAni_%d.png"

BTN_CHIP_SLIDER_PRESSED_PNG = "minigame/caribbean/cns/rasie_ctr.png"
BTN_JACKPOT_NORMAL_PNG = "minigame/caribbean/cns/jackpot/jackpotdis.png"
BTN_JACKPOT_PRESSED_PNG = "minigame/caribbean/cns/jackpot/selected.png"

COCOSTUDIO_UI_SYSTEMNOTIFYNODE = "texaspoker.uilua.chinese.systemnotifynode"
USER_STATE_IMAGE = {
  POKER_BACK_ICON = "game/game_layer/ingame_poker/normal/poker_back_1.png", --牌背景
  POKER_SELECTED_ICON = "game/game_layer/ingame_poker/normal/poker_card_selected.png", --牌被选择高亮
}
STR_TEXT_POKER_FACECARD = "game/game_layer/ingame_poker/normal/poker_%d.png"
COCOSTUDIO_UI_LODINGNODE = "texaspoker.uilua.chinese.lodingnode"
LODING_ANIMATE_IMAGE = "loading/loading_000%d@2x.png"
COCOSTUDIO_UI_GOTOSHOPNODE = "texaspoker.uilua.chinese.gotoshopnode"

COCOSTUDIO_UI_MINIGAME_CARIBBEANSCENE = "minigame.caribbean.uilua.chinese.caribbeanscene"
COCOSTUDIO_UI_MINIGAME_CARIBBEANSCENE_I4 = "minigame.caribbean.uilua.chinese.caribbeanscene_i4"
COCOSTUDIO_UI_MINIGAME_CARIBBEANSCENE_IPAD = "minigame.caribbean.uilua.chinese.caribbeanscene_ipad"
COCOSTUDIO_UI_MINIGAME_CARIBBEANSCENE_S8 = "minigame.caribbean.uilua.chinese.caribbeanscene_s8"
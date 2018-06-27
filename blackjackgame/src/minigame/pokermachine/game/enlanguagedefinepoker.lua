module(...,package.seeall)

--通知消息
MSG_MINI_POJER_ENUM = {
    MSG_TYPE_ENUM_MINIGAME_CSMINIGAMESTART = 1391,   --游戏开始命令，请求五张牌
    MSG_TYPE_ENUM_MINIGAME_DOUBLEPOKER = 1392,   --比较牌  第一张牌
    MSG_TYPE_ENUM_MINIGAME_COMPAREPOKER = 1393, --输赢
    MSG_TYPE_ENUM_MINIGAME_CHANGEEPOKER = 1394, --请求换牌
    MSG_TYPE_ENUM_MINIGAME_INIT = 1397, --小游戏初始化
}

-- 文本
STR_TEXT_GO_TO_SHOP_COIN_CARIBBEAN_TEXT = [[No enough Coins %d, purchase more
Coins please go to Store]]
STR_GOTOSHOPNODE_TIPSSTR = "Notice"
STR_GOTOSHOPNODE_CANCELTEXT = "Cancel"
STR_TEXT_GO_TO_SHOP_COIN_TEXT = [[No enough Coins, purchase more Coins
please go to Store]]
STR_GOTOSHOPNODE_OKTEXT = "Purchase"
STR_TEXT_GO_TO_SHOP_COIN_BUTTON_TEXT = "Purchase"

--UI
COCOSTUDIO_UI_MINIGAMESCENE = "minigame.pokermachine.uilua.english.englishminigamescene"
COCOSTUDIO_UI_MINIGAMESCENE_I4 = "minigame.pokermachine.uilua.english.englishminigamescene_i4"
COCOSTUDIO_UI_MINIGAMESCENE_IPAD = "minigame.pokermachine.uilua.english.englishminigamescene_ipad"
COCOSTUDIO_UI_MINIGAMESCENE_S8 = "minigame.pokermachine.uilua.english.englishminigamescene_s8"

--小游戏
STR_TEXT_POKER_GRAY = "minigame/pokermachine/poker_gray_mask.png"
STR_TEXT_POKER_YOUWIN = "game/game_layer/you_win/anim_youwin1-i6p.png"
STR_TEXT_POKER_GOODLUCK = "minigame/pokermachine/award_goodluck@3x.png"

COCOSTUDIO_UI_SYSTEMNOTIFYNODE = "texasgame.uilua.english.englishsystemnotifynode"
USER_STATE_IMAGE = {
  POKER_BACK_ICON = "game/game_layer/ingame_poker/normal/poker_back_1.png", --牌背景
  POKER_SELECTED_ICON = "game/game_layer/ingame_poker/normal/poker_card_selected.png", --牌被选择高亮
}
STR_TEXT_POKER_FACECARD = "game/game_layer/ingame_poker/normal/poker_%d.png"
COCOSTUDIO_UI_LODINGNODE = "texasgame.uilua.english.englishlodingnode"
LODING_ANIMATE_IMAGE = "loading/loading_000%d@2x.png"
COCOSTUDIO_UI_GOTOSHOPNODE = "texasgame.uilua.english.englishgotoshopnode"


-- 小游戏
HTTP_MINIGAME_POKERMACHINE_URL = "https://sati2.pokermate.net:8446/minigame"
HTTP_MINIGAME_CARIBBEAN_URL = "https://sati2.pokermate.net:8448/caribbean"

--小游戏类型  扑克机 0  加勒比 1
MINIGAME_POKERMACHINE_TYPE = 0
MINIGAME_CARIBBEAN_TYPE = 1

--通知消息
MSG_MINI_PUBLIC_ENUM ={
    MSG_TYPE_ENUM_MINIGAME_EXIT = 1395, --退出游戏
    MSG_TYPE_ENUM_MINIGAME_RECONNECTED_MSG = 1400, --小游戏断网重连
    MSG_TYPE_ENUM_MINIGAME_REFRESH_COIN = 1501,  --小游戏刷新德扑币

    MSG_TYPE_ENUM_MINIGAME_POPUP_PAG = 50001,
    MSG_TYPE_ENUM_MINIGAME_CLOSE_PAG = 50002,
}

-- 文本

-- 游戏列表
MI_LLIST_CELL_NODE_DEFAULT = "minigame.minigamelist.game.minigamelistcell"

MI_GAME_LIST={}
local MiniGameData_1 = {
    cellgame = "minigamelist",
    celllanguagefile = {
        cnlanguagefile = "minigame.minigamelist.game.cnlanguagedefinemini",
        cnslanguagefile = "minigame.minigamelist.game.cnslanguagedefinemini",
        enlanguagefile = "minigame.minigamelist.game.enlanguagedefinemini",
        jblanguagefile = "minigame.minigamelist.game.jblanguagedefinemini",
    }
}
table.insert(MI_GAME_LIST, MiniGameData_1)

local MiniGameData_2 = {
    cellgame = "minigamemainscenepag",
    cellimg = "minigame/minigamelist/jack.png",
    cellnode = "minigame.minigamelist.game.minigamelistcellcustom",
    celllanguagefile = {
        cnlanguagefile = "minigame.pokermachine.game.cnlanguagedefinepoker",
        cnslanguagefile = "minigame.pokermachine.game.cnslanguagedefinepoker",
        enlanguagefile = "minigame.pokermachine.game.enlanguagedefinepoker",
        jblanguagefile = "minigame.pokermachine.game.jblanguagedefinepoker",
    }
}
table.insert(MI_GAME_LIST, MiniGameData_2)

local MiniGameData_3 = {
    cellgame = "caribbeangame",
    celllanguagefile = {
        cnlanguagefile = "minigame.caribbean.game.cnlanguagedefinecaribbean",
        cnslanguagefile = "minigame.caribbean.game.cnslanguagedefinecaribbean",
        enlanguagefile = "minigame.caribbean.game.enlanguagedefinecaribbean",
        jblanguagefile = "minigame.caribbean.game.jblanguagedefinecaribbean",
    }
}
table.insert(MI_GAME_LIST, MiniGameData_3)

local MiniGameData_4 = {
--     cellgame = "redblackwarpag",
--     cellimg = "minigame/minigamelist/redblackwar.png",
--     cellnode = "minigame.minigamelist.game.minigamelistcellcustom",
--     celllanguagefile = {
--         cnlanguagefile = "minigame.redblackwar.game.cnlanguagedefineredblackwar",
--         cnslanguagefile = "minigame.redblackwar.game.cnlanguagedefineredblackwar",
--         enlanguagefile = "minigame.redblackwar.game.cnlanguagedefineredblackwar",
--         jblanguagefile = "minigame.redblackwar.game.jblanguagedefineredblackwar",
--     }
}
table.insert(MI_GAME_LIST, MiniGameData_4)

local MiniGameData_5 = {
    cellgame = "nunugame",
    cellimg = "minigame/minigamelist/01.png",
    cellnode = "minigame.minigamelist.game.minigamelistcellcustom",
    celllanguagefile = {
        --cnlanguagefile = "minigame.redblackwar.cnlanguagedefineredblackwar",
        --cnslanguagefile = "minigame.redblackwar.cnslanguagedefineredblackwar",
        --enlanguagefile = "minigame.redblackwar.enlanguagedefineredblackwar"
    }
}
table.insert(MI_GAME_LIST, MiniGameData_5)

local MiniGameData_6 = {
    cellgame = "ttgame",
    cellimg = "minigame/minigamelist/02.png",
    cellnode = "minigame.minigamelist.game.minigamelistcellcustom",
    celllanguagefile = {
        --cnlanguagefile = "minigame.redblackwar.cnlanguagedefineredblackwar",
        --cnslanguagefile = "minigame.redblackwar.cnslanguagedefineredblackwar",
        --enlanguagefile = "minigame.redblackwar.enlanguagedefineredblackwar"
    }
}
table.insert(MI_GAME_LIST, MiniGameData_6)


local MiniGameData_5 = {
    cellgame = "winratecalculatepag",
}
-- table.insert(MI_GAME_LIST, MiniGameData_5)


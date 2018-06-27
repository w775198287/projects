-- @Author: zhangzg 
-- @Date: 2018-06-13 18:48:05 
-- @Last Modified by:   zhangzg 
-- @Last Modified time: 2018-06-13 18:48:05 

-- 存放公用的数据

GAME_SEAT_NUM = 3

-- 游戏状态以及对应状态的时间，单位s
GAME_STATE = {
    WAITING = 1,
    START = 2,
    ROUND = 3,
    GAMEEND = 4,
}

-- 游戏状态的时间，单位s
GAME_TIME_STATE= {
    10,
    3,
    4,
    3,
}



USER_STATE = {
    WAITING = 1,
    PLAYING = 2,
}

CARD_DATA = {
    0,1,2,3,4,5,6,7,8,9,10,11,12,
    13,14,15,16,17,18,19,20,21,22,23,24,25,
    26,27,28,29,30,31,32,33,34,35,36,37,38,
    39,40,41,42,43,44,45,46,47,48,49,50,51,
}

CARD_START_NUM = 2


USER_MAX = 3
USRE_ADD_TIME = 3
-- 最少开局人数
GAME_USER_NUM_MIN = 5
USER_CARD_MAX = 6


MSG_TYPE_ENUM_BLACK = {
    MSG_TYPE_ENUM_USER_SITDOWN = 70001,         --有人坐下
    MSG_TYPE_ENUM_START = 70101,    --开始发牌
    MSG_TYPE_ENUM_ROUND = 70102,    --开始发牌之后的每轮发牌

}
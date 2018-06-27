--牛牛用户数据
local NNConstant = class("NNConstant")

NNConstant.GAME_STATUS_FIRST_XIAZHU = 1
NNConstant.GAME_STATUS_FAPAI = 2
NNConstant.GAME_STATUS_SECOND_XIAZHU = 3
NNConstant.GAME_STATUS_KAIPAI = 4
NNConstant.GAME_STATUS_FREE = 5

NNConstant.POS_ZHUANG = 0
NNConstant.POS_TIAN = 1
NNConstant.POS_DI = 2
NNConstant.POS_XUAN = 3
NNConstant.POS_HUANG = 4

NNConstant.SEATID_SELF = -1

NNConstant.TABLE_EVENT_SIT_DOWN = 1--玩家坐下
NNConstant.TABLE_EVENT_STAND_UP = 2--玩家站起
NNConstant.TABLE_EVENT_KICK_OFF = 3--玩家被踢出

NNConstant.LOCALZORDER_COINS = 100--
NNConstant.LOCALZORDER_NIU_CNT = 26--牛值


NNConstant.MAX_ONCE_COIN_NUM = 20--天地玄黄每个区域每一次下注筹码同时显示最大个数
NNConstant.MAX_COIN_NUM = 100--天地玄黄每个区域每轮最多显示筹码的个数
NNConstant.COIN_POOL_CAPACITY = 200--筹码对象池的容量
NNConstant.CACHE_FLYCOIN_NUM = 100--播放下注筹码缓存
NNConstant.INTERVAL_FLYCOIN = 0.1--飞筹码间隔

NNConstant.LANGUAGE_ZH_SIMPLE = 1--简体中文
NNConstant.LANGUAGE_EN = 2--英文
NNConstant.LANGUAGE_ZH_HANT = 3--繁体中文

NNConstant.BET_ROUND_FIRST = 0--第一轮下注
NNConstant.BET_ROUND_SECOND = 1--第二轮下注

NNConstant.TOTAL_POKER_NUM = 25--总共需要多少张扑克牌



return NNConstant

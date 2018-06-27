--牛牛用户数据
local TTConstant = class("TTConstant")

TTConstant.GAME_STATUS_XIAZHU = 1
TTConstant.GAME_STATUS_KAIPAI = 2
TTConstant.GAME_STATUS_FREE = 3

TTConstant.POS_ZHUANG = 0
TTConstant.POS_ZHONG = 1
TTConstant.POS_FA = 2
TTConstant.POS_BAI = 3

TTConstant.SEATID_SELF = -1

TTConstant.TABLE_EVENT_SIT_DOWN = 1--玩家坐下
TTConstant.TABLE_EVENT_STAND_UP = 2--玩家站起
TTConstant.TABLE_EVENT_KICK_OFF = 3--玩家被踢出

TTConstant.LOCALZORDER_COINS = 100--
TTConstant.LOCALZORDER_NIU_CNT = 26--牛值


TTConstant.MAX_ONCE_COIN_NUM = 20--中发白每个区域每一次下注筹码同时显示最大个数
TTConstant.MAX_COIN_NUM = 200--中发白每个区域每轮最多显示筹码的个数
TTConstant.COIN_POOL_CAPACITY = 1--筹码对象池的容量
TTConstant.CACHE_FLYCOIN_NUM = 20--播放下注筹码缓存
TTConstant.INTERVAL_FLYCOIN = 0.1--飞筹码间隔

TTConstant.LANGUAGE_ZH_SIMPLE = 1--简体中文
TTConstant.LANGUAGE_EN = 2--英文
TTConstant.LANGUAGE_ZH_HANT = 3--繁体中文

TTConstant.BET_ROUND_FIRST = 0--第一轮下注

TTConstant.TOTAL_POKER_NUM = 25--总共需要多少张扑克牌



return TTConstant

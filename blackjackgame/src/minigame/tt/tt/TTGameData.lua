--牛牛用户数据
local TTGameData = class("TTGameData")
TTGameData.userInfo = {userId=0,coins=0,nick=""}
TTGameData.roomInfo = {}
TTGameData.roomInfo.roomId = 0--上庄最少金币数
TTGameData.roomInfo.applyBankerCoins = 0--上庄最少金币数
TTGameData.roomInfo.freeTime = 0--空闲时间
TTGameData.roomInfo.xiaZhuTime = 0--下注时间
TTGameData.roomInfo.kaiPaiTime = 0--开牌时间
TTGameData.roomInfo.chips = nil--筹码列表
TTGameData.roomInfo.playerMultiple = 0--下注倍数

TTGameData.avatar = ""
TTGameData.coins = 0
-- Set the volume of sound effects.
-- @param volume must be within the range of 0.0 as the minimum and 1.0 as the maximum.
TTGameData.isEffectsAudio = true
TTGameData.isBackgroundMusic = true
TTGameData.effectsVolume = 1.0
TTGameData.backgroundMusicVolume = 1.0
TTGameData.sex = "male"--男 male  女famale

TTGameData.imei = "" --设备号
TTGameData.model = "" --手机型号
TTGameData.channel = "" --渠道号
TTGameData.platform = "" --平台号
TTGameData.language = 1--1是中文简体   2个英文  3是中文繁体
TTGameData.isDebug = false --是否是调试模式
TTGameData.dpqToken = ""--德扑圈穿过来的token

---发布前检查
--"ws://106.14.20.177:**"--正式
--"ws://106.14.104.115:**"--仿真
TTGameData.httpServer = "http://ltg1117.dapai1.com:8009"--http短链接地址
TTGameData.server = ""--ws长连接地址，由服务器返回
TTGameData.httpLoginToken = ""
TTGameData.version = "1.1.17" --版本号

return TTGameData


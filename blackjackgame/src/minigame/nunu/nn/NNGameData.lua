--牛牛用户数据
local NNGameData = class("NNGameData")
NNGameData.userInfo = {userId=0,coins=0,nick=""}
NNGameData.roomInfo = {}
NNGameData.roomInfo.roomId = 0--上庄最少金币数
NNGameData.roomInfo.applyBankerCoins = 0--上庄最少金币数
NNGameData.roomInfo.freeTime = 0--空闲时间
NNGameData.roomInfo.firstXiaZhuTime = 0--第一轮下注时间
NNGameData.roomInfo.faPaiTime = 0--发牌时间
NNGameData.roomInfo.secondXiaZhuTime = 0--第二轮下注时间
NNGameData.roomInfo.kaiPaiTime = 0--开牌时间
NNGameData.roomInfo.chips = nil--筹码列表
NNGameData.roomInfo.playerMultiple = 0--下注倍数

NNGameData.avatar = ""
NNGameData.coins = 0
-- Set the volume of sound effects.
-- @param volume must be within the range of 0.0 as the minimum and 1.0 as the maximum.
NNGameData.isEffectsAudio = true
NNGameData.isBackgroundMusic = true
NNGameData.effectsVolume = 1.0
NNGameData.backgroundMusicVolume = 1.0
NNGameData.sex = "male"--男 male  女famale

NNGameData.imei = "" --设备号
NNGameData.model = "" --手机型号
NNGameData.channel = "" --渠道号
NNGameData.platform = "" --平台号
NNGameData.language = 1--1是中文简体   2个英文  3是中文繁体
NNGameData.isDebug = false --是否是调试模式
NNGameData.dpqToken = ""--德扑圈穿过来的token

---发布前检查
--"ws://106.14.20.177:8005"--正式
--"ws://106.14.104.115:8005"--仿真
NNGameData.httpServer = "http://ltg1117.dapai1.com:8006"--http短链接地址
NNGameData.server = ""--ws长连接地址，由服务器返回
NNGameData.httpLoginToken = ""
NNGameData.version = "1.1.17" --版本号

return NNGameData


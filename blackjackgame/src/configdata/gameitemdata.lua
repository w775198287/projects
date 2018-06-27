
--播放收费动画方式
OTHER_INFO_FACE_TYPE_ENUM = {
    OTHER_INFO_FACE_TYPE_ENUM_TARGET = 1, --直接到目标的
    OTHER_INFO_FACE_TYPE_ENUM_FLY_TARGET = 2, --飞到中间在到目标的
    OTHER_INFO_FACE_TYPE_ENUM_SELF_TARGET = 3, --自己位置播放
    OTHER_INFO_FACE_TYPE_ENUM_ROTATE_TARGET = 4, --旋转飞行图片到目标的
    OTHER_INFO_FACE_TYPE_ENUM_ROTATE_TARGET_SEVERAL_ACTION = 5, --旋转飞行图片到目标,并且再次动画
    OTHER_INFO_FACE_TYPE_ENUM_ROTATE_SEVERAL_ATSAMETIME_ACTION = 6, --发送者，目标，中途 三个动画同时播放
    OTHER_INFO_FACE_TYPE_ENUM_PLAY_FLY_TARGET = 7, --A播动画，播完后飞到目的地,飞的途中播动画，飞到目的地B再播动画
    OTHER_INFO_FACE_TYPE_ENUM_PLAY_DELAY_FLY_TARGET = 8, --A播动画，播完几帧后,C在A，B之间播动画，同时B播动画
    OTHER_INFO_FACE_TYPE_ENUM_PLAY_DELAY_FLY_TARGET_MOVE = 9, --A播动画，播完几帧后,B播动画 同时B移到A
}

--播放收费动画方式
CURRENCY_TYPE_ENUM = {
    CURRENCY_TYPE_ENUM_GOLD = 1, --德扑币
    CURRENCY_TYPE_ENUM_FLY_DIAMOND = 2, --钻石
}

module(...,package.seeall)

local Local_GIsCreate = false
local selfObj = {}

--收费头像道具动画

local SOUND_FILE={

   SOUND_FILE_GAMEITEM_GAN_VOICE = "audio/gan.mp3", --  格林机枪音效
   SOUND_FILE_GAMEITEM_SHAKE_VOICE = "audio/shake.mp3", --  鲨鱼音效 
}

function Create()
	if Local_GIsCreate == true then
		return selfObj
	end
	setmetatable(selfObj, {__index = _M})
	Local_GIsCreate = true

    selfObj.miDataList = {}

    selfObj:InitData()

	return selfObj
end

function InitData(selfObj)   

    
    --[[
    A播动画同时移到B 然后B播动画： 偷鸡、扔大便、干杯、亲嘴、扔炸弹、安慰
    A播完动画，然后再播另一个动画，同时移到B处，然后B播动画 ： 点赞、鲨鱼（新）
    A播动画 播几帧，C播动画，同时B也播动画： 机枪
    A播动画 播几帧,中间C播动画，C播几帧后，B也播动画，同时B移到A处：钓鱼

    需要调整角度(不同位置需要调角度，同时需要调整方向(左右))的动画有：偷鸡、点赞、安慰、机枪、鲨鱼（特殊：目标调整方向）、钓鱼
    ]]--

    selfObj.miDataList={}
    --机枪 新版
    --selfObj.miDataList[1]={}
    --selfObj.miDataList[1].id=1
    --selfObj.miDataList[1].idname="animateItem#item15"
    --selfObj.miDataList[1].currencytype=CURRENCY_TYPE_ENUM.CURRENCY_TYPE_ENUM_GOLD --货币类型
    --selfObj.miDataList[1].currencynum=40    --货币数量
    --selfObj.miDataList[1].icon="game/game_items/common/item1/item1.png"
    --selfObj.miDataList[1].disableicon="game/game_items/common/item1/item1_disable.png"
    --selfObj.miDataList[1].type=OTHER_INFO_FACE_TYPE_ENUM.OTHER_INFO_FACE_TYPE_ENUM_PLAY_DELAY_FLY_TARGET
    --selfObj.miDataList[1].isflyturnangle=true  --飞行节点是否调整角度
    --selfObj.miDataList[1].isflymove=false  --飞行节点是否需要移动到目标节点
    --selfObj.miDataList[1].itemvoice=SOUND_FILE.SOUND_FILE_GAMEITEM_GAN_VOICE

    --selfObj.miDataList[1].from="game/game_items/common/item1/item1.png"
    --selfObj.miDataList[1].fromtime=1.8
    --selfObj.miDataList[1].fromplist="game/game_items/common/item1/item1_anims_from.plist"
    --selfObj.miDataList[1].fromplistpng="game/game_items/common/item1/item1_anims_from.png"
    --selfObj.miDataList[1].fromplistimage="item1_from%d.png"
    --selfObj.miDataList[1].frompnum=18
    --selfObj.miDataList[1].fromanimstimer=0.1
    --selfObj.miDataList[1].fromactiontimes=1 --播放次数

    --selfObj.miDataList[1].fly="game/game_items/common/item1/item1_fly.png"
    --selfObj.miDataList[1].flytime=1.2
    --selfObj.miDataList[1].flydelaytime=0.6
    --selfObj.miDataList[1].flyplist="game/game_items/common/item1/item1_anims_fly.plist"
    --selfObj.miDataList[1].flyplistpng="game/game_items/common/item1/item1_anims_fly.png"
    --selfObj.miDataList[1].flyplistimage="item1_fly%d.png"
    --selfObj.miDataList[1].flypnum=12
    --selfObj.miDataList[1].flyanimstimer=0.1
    --selfObj.miDataList[1].flyactiontimes=1 --播放次数

    --selfObj.miDataList[1].to="game/game_items/common/item1/item1_to.png"
    --selfObj.miDataList[1].totime=1.2
    --selfObj.miDataList[1].todelaytime=0.6
    --selfObj.miDataList[1].toplist="game/game_items/common/item1/item1_anims_to.plist"
    --selfObj.miDataList[1].toplistpng="game/game_items/common/item1/item1_anims_to.png"
    --selfObj.miDataList[1].toplistimage="item1_to%d.png"
    --selfObj.miDataList[1].topnum=12
    --selfObj.miDataList[1].toanimstimer=0.1
    --selfObj.miDataList[1].toactiontimes=1 --播放次数

    --机枪 旧版
    selfObj.miDataList[1]={}
    selfObj.miDataList[1].id=1
    selfObj.miDataList[1].idname="animateItem#item15"
    selfObj.miDataList[1].currencytype=CURRENCY_TYPE_ENUM.CURRENCY_TYPE_ENUM_GOLD --货币类型
    selfObj.miDataList[1].currencynum=40    --货币数量
    selfObj.miDataList[1].icon="game/game_items/common/item1/item15.png"
    selfObj.miDataList[1].disableicon="game/game_items/common/item1/item15_disable.png"
    selfObj.miDataList[1].type=OTHER_INFO_FACE_TYPE_ENUM.OTHER_INFO_FACE_TYPE_ENUM_PLAY_DELAY_FLY_TARGET
    selfObj.miDataList[1].from="game/game_items/common/item1/item15.png"
    selfObj.miDataList[1].to="game/game_items/common/item1/item15_target.png"
    selfObj.miDataList[1].fly="game/game_items/common/item1/item15_fly.png"
    selfObj.miDataList[1].flytime=1.3
    selfObj.miDataList[1].itemvoice=SOUND_FILE.SOUND_FILE_GAMEITEM_GAN_VOICE
    selfObj.miDataList[1].isflyturnangle=true  --飞行节点是否调整角度

    selfObj.miDataList[1].fromplist="game/game_items/common/item1/item15_anims_from_i6p.plist"
    selfObj.miDataList[1].fromplistpng="game/game_items/common/item1/item15_anims_from_i6p.png"
    selfObj.miDataList[1].fromplistimage="item15_%d.png"
    selfObj.miDataList[1].frompnum=13
    selfObj.miDataList[1].fromanimstimer=0.1
    selfObj.miDataList[1].fromactiontimes=1 --播放次数

    selfObj.miDataList[1].toplist="game/game_items/common/item1/item15_anims_to_i6p.plist"
    selfObj.miDataList[1].toplistpng="game/game_items/common/item1/item15_anims_to_i6p.png"
    selfObj.miDataList[1].toplistimage="item15_bow_%d.png"
    selfObj.miDataList[1].topnum=13
    selfObj.miDataList[1].toanimstimer=0.1
    selfObj.miDataList[1].todelaytime=0
    selfObj.miDataList[1].toactiontimes=1 --播放次数

    selfObj.miDataList[1].flyplist="game/game_items/common/item1/item15_anims_fly_i6p.plist"
    selfObj.miDataList[1].flyplistpng="game/game_items/common/item1/item15_anims_fly_i6p.png"
    selfObj.miDataList[1].flyplistimage="item15_bowfly%d.png"
    selfObj.miDataList[1].flypnum=13
    selfObj.miDataList[1].flyanimstimer=0.1
    selfObj.miDataList[1].flydelaytime=0
    selfObj.miDataList[1].flyactiontimes=1 --播放次数

    --鲨鱼 新版
    --selfObj.miDataList[2]={}
    --selfObj.miDataList[2].id=2
    --selfObj.miDataList[2].idname="animateItem#item12"
    --selfObj.miDataList[2].currencytype=CURRENCY_TYPE_ENUM.CURRENCY_TYPE_ENUM_GOLD --货币类型
    --selfObj.miDataList[2].currencynum=40    --货币数量
    --selfObj.miDataList[2].icon="game/game_items/common/item2/item2.png"
    --selfObj.miDataList[2].disableicon="game/game_items/common/item2/item2_disable.png"
    --selfObj.miDataList[2].type=OTHER_INFO_FACE_TYPE_ENUM.OTHER_INFO_FACE_TYPE_ENUM_PLAY_FLY_TARGET

    --selfObj.miDataList[2].from="game/game_items/common/item2/item2.png"
    --selfObj.miDataList[2].fromtime=0.8
    --selfObj.miDataList[2].fromplist="game/game_items/common/item2/item2_anims_from.plist"
    --selfObj.miDataList[2].fromplistpng="game/game_items/common/item2/item2_anims_from.png"
    --selfObj.miDataList[2].fromplistimage="item2_from%d.png"
    --selfObj.miDataList[2].frompnum=8
    --selfObj.miDataList[2].fromanimstimer=0.1
    --selfObj.miDataList[2].fromactiontimes=1 --播放次数
    --selfObj.miDataList[2].fromisturn = true

    --selfObj.miDataList[2].fly="game/game_items/common/item2/item2_fly.png"
    --selfObj.miDataList[2].flytime=0.8
    --selfObj.miDataList[2].flyplist="game/game_items/common/item2/item2_anims_fly.plist"
    --selfObj.miDataList[2].flyplistpng="game/game_items/common/item2/item2_anims_fly.png"
    --selfObj.miDataList[2].flyplistimage="item2_fly%d.png"
    --selfObj.miDataList[2].flypnum=2
    --selfObj.miDataList[2].flyanimstimer=0.1
    --selfObj.miDataList[2].flyactiontimes=4 --播放次数
    --selfObj.miDataList[2].flyisturn = true

    --selfObj.miDataList[2].to="game/game_items/common/item2/item2_to.png"
    --selfObj.miDataList[2].totime=1
    --selfObj.miDataList[2].toplist="game/game_items/common/item2/item2_anims_to.plist"
    --selfObj.miDataList[2].toplistpng="game/game_items/common/item2/item2_anims_to.png"
    --selfObj.miDataList[2].toplistimage="item2_to%d.png"
    --selfObj.miDataList[2].topnum=10
    --selfObj.miDataList[2].toanimstimer=0.1
    --selfObj.miDataList[2].toactiontimes=1 --播放次数
    --selfObj.miDataList[2].toisturn = true

    --鲨鱼
    selfObj.miDataList[2]={}
    selfObj.miDataList[2].id=2
    selfObj.miDataList[2].idname="animateItem#item12"
    selfObj.miDataList[2].currencytype=CURRENCY_TYPE_ENUM.CURRENCY_TYPE_ENUM_GOLD --货币类型
    selfObj.miDataList[2].currencynum=40    --货币数量
    selfObj.miDataList[2].icon="game/game_items/common/item2/item12.png"
    selfObj.miDataList[2].disableicon="game/game_items/common/item2/item12_disable.png"
    selfObj.miDataList[2].type=OTHER_INFO_FACE_TYPE_ENUM.OTHER_INFO_FACE_TYPE_ENUM_ROTATE_TARGET_SEVERAL_ACTION
    selfObj.miDataList[2].from="game/game_items/common/item2/item12_fly.png"
    selfObj.miDataList[2].to="game/game_items/common/item2/item12_target.png"
    selfObj.miDataList[2].flytime=0.3
    selfObj.miDataList[2].itemvoice=SOUND_FILE.SOUND_FILE_GAMEITEM_SHAKE_VOICE

    selfObj.miDataList[2].fromplist="game/game_items/common/item2/item12_anims_from_i6p.plist"
    selfObj.miDataList[2].fromplistpng="game/game_items/common/item2/item12_anims_from_i6p.png"
    selfObj.miDataList[2].fromplistimage="item12_%d.png"
    selfObj.miDataList[2].frompnum=11
    selfObj.miDataList[2].fromanimstimer=0.1
    selfObj.miDataList[2].fromactiontimes=1 --播放次数

    selfObj.miDataList[2].toplist="game/game_items/common/item2/item12_anims_to_i6p.plist"
    selfObj.miDataList[2].toplistpng="game/game_items/common/item2/item12_anims_to_i6p.png"
    selfObj.miDataList[2].toplistimage="item12_fish_%d.png"
    selfObj.miDataList[2].topnum=11
    selfObj.miDataList[2].toanimstimer=0.1
    selfObj.miDataList[2].toactiontimes=1 --播放次数

    selfObj.miDataList[2].flyplist="game/game_items/common/item2/item12_anims_fly_i6p.plist"
    selfObj.miDataList[2].flyplistpng="game/game_items/common/item2/item12_anims_fly_i6p.png"
    selfObj.miDataList[2].flyplistimage="item12_fly_%d.png"
    selfObj.miDataList[2].flypnum=2
    selfObj.miDataList[2].flyanimstimer=0.1
    selfObj.miDataList[2].flyactiontimes=1 --播放次数

    selfObj.miDataList[2].killplist="game/game_items/common/item2/item12_anims_kill_i6p.plist"
    selfObj.miDataList[2].killplistpng="game/game_items/common/item2/item12_anims_kill_i6p.png"
    selfObj.miDataList[2].killplistimage="item12_kill_%d.png"
    selfObj.miDataList[2].killpnum=9
    selfObj.miDataList[2].killanimstimer=0.1

    --大便
    selfObj.miDataList[3]={}
    selfObj.miDataList[3].id=3
    selfObj.miDataList[3].idname="animateItem#item3"
    selfObj.miDataList[3].currencytype=CURRENCY_TYPE_ENUM.CURRENCY_TYPE_ENUM_GOLD --货币类型
    selfObj.miDataList[3].currencynum=10    --货币数量
    selfObj.miDataList[3].icon="game/game_items/common/item3/item3.png"
    selfObj.miDataList[3].disableicon="game/game_items/common/item3/item3_disable.png"
    selfObj.miDataList[3].type=OTHER_INFO_FACE_TYPE_ENUM.OTHER_INFO_FACE_TYPE_ENUM_FLY_TARGET

    selfObj.miDataList[3].from="game/game_items/common/item3/item3.png"
    selfObj.miDataList[3].fromtime=0.8
    selfObj.miDataList[3].fromplist="game/game_items/common/item3/item3_anims_fly.plist"
    selfObj.miDataList[3].fromplistpng="game/game_items/common/item3/item3_anims_fly.png"
    selfObj.miDataList[3].fromplistimage="item3_fly%d.png"
    selfObj.miDataList[3].frompnum=8
    selfObj.miDataList[3].fromanimstimer=0.1
    selfObj.miDataList[3].fromactiontimes=1 --播放次数

    selfObj.miDataList[3].to="game/game_items/common/item3/item3_to.png"
    selfObj.miDataList[3].totime=1
    selfObj.miDataList[3].toplist="game/game_items/common/item3/item3_anims_to.plist"
    selfObj.miDataList[3].toplistpng="game/game_items/common/item3/item3_anims_to.png"
    selfObj.miDataList[3].toplistimage="item3_play%d.png"
    selfObj.miDataList[3].topnum=10
    selfObj.miDataList[3].toanimstimer=0.1
    selfObj.miDataList[3].toactiontimes=1 --播放次数


    --干杯
    selfObj.miDataList[4]={}
    selfObj.miDataList[4].id=4
    selfObj.miDataList[4].idname="animateItem#item2"
    selfObj.miDataList[4].currencytype=CURRENCY_TYPE_ENUM.CURRENCY_TYPE_ENUM_GOLD --货币类型
    selfObj.miDataList[4].currencynum=10    --货币数量
    selfObj.miDataList[4].icon="game/game_items/common/item4/item4.png"
    selfObj.miDataList[4].disableicon="game/game_items/common/item4/item4_disable.png"
    selfObj.miDataList[4].type=OTHER_INFO_FACE_TYPE_ENUM.OTHER_INFO_FACE_TYPE_ENUM_FLY_TARGET

    selfObj.miDataList[4].from="game/game_items/common/item4/item4.png"
    selfObj.miDataList[4].fromtime=0.8
    selfObj.miDataList[4].fromplist="game/game_items/common/item4/item4_anims_fly.plist"
    selfObj.miDataList[4].fromplistpng="game/game_items/common/item4/item4_anims_fly.png"
    selfObj.miDataList[4].fromplistimage="item4_fly%d.png"
    selfObj.miDataList[4].frompnum=8
    selfObj.miDataList[4].fromanimstimer=0.1
    selfObj.miDataList[4].fromactiontimes=1 --播放次数
    selfObj.miDataList[4].fromisturn = true

    selfObj.miDataList[4].to="game/game_items/common/item4/item4_to.png"
    selfObj.miDataList[4].totime=1
    selfObj.miDataList[4].toplist="game/game_items/common/item4/item4_anims_to.plist"
    selfObj.miDataList[4].toplistpng="game/game_items/common/item4/item4_anims_to.png"
    selfObj.miDataList[4].toplistimage="item4_play%d.png"
    selfObj.miDataList[4].topnum=10
    selfObj.miDataList[4].toanimstimer=0.1
    selfObj.miDataList[4].toactiontimes=1 --播放次数


    --点赞 新版
    --selfObj.miDataList[5]={}
    --selfObj.miDataList[5].id=5
    --selfObj.miDataList[5].idname="animateItem#item4"
    --selfObj.miDataList[5].currencytype=CURRENCY_TYPE_ENUM.CURRENCY_TYPE_ENUM_GOLD --货币类型
    --selfObj.miDataList[5].currencynum=10    --货币数量
    --selfObj.miDataList[5].icon="game/game_items/common/item5/item5.png"
    --selfObj.miDataList[5].disableicon="game/game_items/common/item5/item5_disable.png"
    --selfObj.miDataList[5].type=OTHER_INFO_FACE_TYPE_ENUM.OTHER_INFO_FACE_TYPE_ENUM_PLAY_FLY_TARGET

    --selfObj.miDataList[5].from="game/game_items/common/item5/item5.png"
    --selfObj.miDataList[5].fromtime=1.1
    --selfObj.miDataList[5].fromplist="game/game_items/common/item5/item5_anims_from.plist"
    --selfObj.miDataList[5].fromplistpng="game/game_items/common/item5/item5_anims_from.png"
    --selfObj.miDataList[5].fromplistimage="item5_from%d.png"
    --selfObj.miDataList[5].frompnum=11
    --selfObj.miDataList[5].fromanimstimer=0.1
    --selfObj.miDataList[5].fromactiontimes=1 --播放次数
    --selfObj.miDataList[5].fromisturn = true

    --selfObj.miDataList[5].fly="game/game_items/common/item5/item5_fly.png"
    --selfObj.miDataList[5].flytime=0.8
    --selfObj.miDataList[5].flyplist="game/game_items/common/item5/item5_anims_fly.plist"
    --selfObj.miDataList[5].flyplistpng="game/game_items/common/item5/item5_anims_fly.png"
    --selfObj.miDataList[5].flyplistimage="item5_fly%d.png"
    --selfObj.miDataList[5].flypnum=8
    --selfObj.miDataList[5].flyanimstimer=0.1
    --selfObj.miDataList[5].flyactiontimes=1 --播放次数

    --selfObj.miDataList[5].to="game/game_items/common/item5/item5_to.png"
    --selfObj.miDataList[5].totime=1.2
    --selfObj.miDataList[5].toplist="game/game_items/common/item5/item5_anims_to.plist"
    --selfObj.miDataList[5].toplistpng="game/game_items/common/item5/item5_anims_to.png"
    --selfObj.miDataList[5].toplistimage="item5_to%d.png"
    --selfObj.miDataList[5].topnum=12
    --selfObj.miDataList[5].toanimstimer=0.1
    --selfObj.miDataList[5].toactiontimes=1 --播放次数
    --selfObj.miDataList[5].toisturn = true

    --点赞 旧版
    selfObj.miDataList[5]={}
    selfObj.miDataList[5].id=5
    selfObj.miDataList[5].idname="animateItem#item4"
    selfObj.miDataList[5].currencytype=CURRENCY_TYPE_ENUM.CURRENCY_TYPE_ENUM_GOLD --货币类型
    selfObj.miDataList[5].currencynum=10    --货币数量
    selfObj.miDataList[5].icon="game/game_items/common/item5/item4-i6p.png"
    selfObj.miDataList[5].disableicon="game/game_items/common/item5/item4_disable-i6p.png"
    selfObj.miDataList[5].type=OTHER_INFO_FACE_TYPE_ENUM.OTHER_INFO_FACE_TYPE_ENUM_TARGET
    selfObj.miDataList[5].fly="game/game_items/common/item5/item4_fly-i6p.png"
    selfObj.miDataList[5].flytime=0.5
    selfObj.miDataList[5].from="game/game_items/common/item5/item4_fly-i6p.png"
    selfObj.miDataList[5].fromplist="game/game_items/common/item5/item4_anims_i6p.plist"
    selfObj.miDataList[5].fromplistpng="game/game_items/common/item5/item4_anims_i6p-i6p.png"
    selfObj.miDataList[5].fromplistimage="item4_%d.png"
    selfObj.miDataList[5].frompnum=18
    selfObj.miDataList[5].fromanimstimer=0.1
    selfObj.miDataList[5].fromactiontimes=1 --播放次数

    --炸弹
    selfObj.miDataList[6]={}
    selfObj.miDataList[6].id=6
    selfObj.miDataList[6].idname="animateItem#item5"
    selfObj.miDataList[6].currencytype=CURRENCY_TYPE_ENUM.CURRENCY_TYPE_ENUM_GOLD --货币类型
    selfObj.miDataList[6].currencynum=10    --货币数量
    selfObj.miDataList[6].icon="game/game_items/common/item6/item6.png"
    selfObj.miDataList[6].disableicon="game/game_items/common/item6/item6_disable.png"
    selfObj.miDataList[6].type=OTHER_INFO_FACE_TYPE_ENUM.OTHER_INFO_FACE_TYPE_ENUM_FLY_TARGET

    selfObj.miDataList[6].from="game/game_items/common/item6/item6.png"
    selfObj.miDataList[6].fromtime=0.8
    selfObj.miDataList[6].fromplist="game/game_items/common/item6/item6_anims_fly.plist"
    selfObj.miDataList[6].fromplistpng="game/game_items/common/item6/item6_anims_fly.png"
    selfObj.miDataList[6].fromplistimage="item6_fly%d.png"
    selfObj.miDataList[6].frompnum=8
    selfObj.miDataList[6].fromanimstimer=0.1
    selfObj.miDataList[6].fromactiontimes=1 --播放次数

    selfObj.miDataList[6].to="game/game_items/common/item6/item6_to.png"
    selfObj.miDataList[6].totime=1
    selfObj.miDataList[6].toplist="game/game_items/common/item6/item6_anims_to.plist"
    selfObj.miDataList[6].toplistpng="game/game_items/common/item6/item6_anims_to.png"
    selfObj.miDataList[6].toplistimage="item6_play%d.png"
    selfObj.miDataList[6].topnum=10
    selfObj.miDataList[6].toanimstimer=0.1
    selfObj.miDataList[6].toactiontimes=1 --播放次数

    --偷鸡
    selfObj.miDataList[7]={}
    selfObj.miDataList[7].id=7
    selfObj.miDataList[7].idname="animateItem#item6"
    selfObj.miDataList[7].currencytype=CURRENCY_TYPE_ENUM.CURRENCY_TYPE_ENUM_GOLD --货币类型
    selfObj.miDataList[7].currencynum=10    --货币数量
    selfObj.miDataList[7].icon="game/game_items/common/item7/item7.png"
    selfObj.miDataList[7].disableicon="game/game_items/common/item7/item7_disable.png"
    selfObj.miDataList[7].type=OTHER_INFO_FACE_TYPE_ENUM.OTHER_INFO_FACE_TYPE_ENUM_FLY_TARGET

    selfObj.miDataList[7].from="game/game_items/common/item7/item7.png"
    selfObj.miDataList[7].fromtime=0.8
    selfObj.miDataList[7].fromplist="game/game_items/common/item7/item7_anims_fly.plist"
    selfObj.miDataList[7].fromplistpng="game/game_items/common/item7/item7_anims_fly.png"
    selfObj.miDataList[7].fromplistimage="item7_fly%d.png"
    selfObj.miDataList[7].frompnum=8
    selfObj.miDataList[7].fromanimstimer=0.1
    selfObj.miDataList[7].fromactiontimes=1 --播放次数
    selfObj.miDataList[7].fromisturn = true

    selfObj.miDataList[7].to="game/game_items/common/item7/item7_to.png"
    selfObj.miDataList[7].totime=1.7
    selfObj.miDataList[7].toplist="game/game_items/common/item7/item7_anims_to.plist"
    selfObj.miDataList[7].toplistpng="game/game_items/common/item7/item7_anims_to.png"
    selfObj.miDataList[7].toplistimage="item7_play%d.png"
    selfObj.miDataList[7].topnum=17
    selfObj.miDataList[7].toanimstimer=0.1
    selfObj.miDataList[7].toactiontimes=1 --播放次数

    --钓鱼
    selfObj.miDataList[8]={}
    selfObj.miDataList[8].id=8
    selfObj.miDataList[8].idname="animateItem#item10"
    selfObj.miDataList[8].currencytype=CURRENCY_TYPE_ENUM.CURRENCY_TYPE_ENUM_GOLD --货币类型
    selfObj.miDataList[8].currencynum=10    --货币数量
    selfObj.miDataList[8].icon="game/game_items/common/item8/item8.png"
    selfObj.miDataList[8].disableicon="game/game_items/common/item8/item8_disable.png"
    selfObj.miDataList[8].type=OTHER_INFO_FACE_TYPE_ENUM.OTHER_INFO_FACE_TYPE_ENUM_PLAY_DELAY_FLY_TARGET_MOVE

    selfObj.miDataList[8].from="game/game_items/common/item8/item8.png"
    selfObj.miDataList[8].fromtime=1.7
    selfObj.miDataList[8].fromplist="game/game_items/common/item8/item8_anims_from.plist"
    selfObj.miDataList[8].fromplistpng="game/game_items/common/item8/item8_anims_from.png"
    selfObj.miDataList[8].fromplistimage="item8_from%d.png"
    selfObj.miDataList[8].frompnum=17
    selfObj.miDataList[8].fromanimstimer=0.1
    selfObj.miDataList[8].fromactiontimes=1 --播放次数
    selfObj.miDataList[8].fromisturn = true

    selfObj.miDataList[8].lineflytime = 0.7 --鱼线伸展开时间
    selfObj.miDataList[8].linebacktime = 0.3 --鱼线回收时间
    selfObj.miDataList[8].linedelayflytime = 0.8 --鱼线显示前停顿时间
    selfObj.miDataList[8].linestopflytime = 0.4 --鱼线展开后停顿时间

    selfObj.miDataList[8].fly="game/game_items/common/item8/item8_fly.png"
    selfObj.miDataList[8].flytime=0.9
    selfObj.miDataList[8].flyplist="game/game_items/common/item8/item8_anims_fly.plist"
    selfObj.miDataList[8].flyplistpng="game/game_items/common/item8/item8_anims_fly.png"
    selfObj.miDataList[8].flyplistimage="item8_fly%d.png"
    selfObj.miDataList[8].flypnum=9
    selfObj.miDataList[8].flyanimstimer=0.1
    selfObj.miDataList[8].flyactiontimes=1 --播放次数

    selfObj.miDataList[8].to="game/game_items/common/item8/item8_to.png"
    selfObj.miDataList[8].totime=0.4
    selfObj.miDataList[8].toplist="game/game_items/common/item8/item8_anims_to.plist"
    selfObj.miDataList[8].toplistpng="game/game_items/common/item8/item8_anims_to.png"
    selfObj.miDataList[8].toplistimage="item8_to%d.png"
    selfObj.miDataList[8].topnum=4
    selfObj.miDataList[8].toanimstimer=0.1
    selfObj.miDataList[8].toactiontimes=1 --播放次数
    selfObj.miDataList[8].toisturn = true

    --红唇
    selfObj.miDataList[9]={}
    selfObj.miDataList[9].id=9
    selfObj.miDataList[9].idname="animateItem#item1"
    selfObj.miDataList[9].currencytype=CURRENCY_TYPE_ENUM.CURRENCY_TYPE_ENUM_GOLD --货币类型
    selfObj.miDataList[9].currencynum=10    --货币数量
    selfObj.miDataList[9].icon="game/game_items/common/item9/item9.png"
    selfObj.miDataList[9].disableicon="game/game_items/common/item9/item9_disable.png"
    selfObj.miDataList[9].type=OTHER_INFO_FACE_TYPE_ENUM.OTHER_INFO_FACE_TYPE_ENUM_FLY_TARGET

    selfObj.miDataList[9].from="game/game_items/common/item9/item9.png"
    selfObj.miDataList[9].fromtime=0.8
    selfObj.miDataList[9].fromplist="game/game_items/common/item9/item9_anims_fly.plist"
    selfObj.miDataList[9].fromplistpng="game/game_items/common/item9/item9_anims_fly.png"
    selfObj.miDataList[9].fromplistimage="item9_fly%d.png"
    selfObj.miDataList[9].frompnum=8
    selfObj.miDataList[9].fromanimstimer=0.1
    selfObj.miDataList[9].fromactiontimes=1 --播放次数

    selfObj.miDataList[9].to="game/game_items/common/item9/item9_to.png"
    selfObj.miDataList[9].totime=1.5
    selfObj.miDataList[9].toplist="game/game_items/common/item9/item9_anims_to.plist"
    selfObj.miDataList[9].toplistpng="game/game_items/common/item9/item9_anims_to.png"
    selfObj.miDataList[9].toplistimage="item9_play%d.png"
    selfObj.miDataList[9].topnum=15
    selfObj.miDataList[9].toanimstimer=0.1
    selfObj.miDataList[9].toactiontimes=1 --播放次数

    --安慰
    selfObj.miDataList[10]={}
    selfObj.miDataList[10].id=10
    selfObj.miDataList[10].idname="animateItem#item7"
    selfObj.miDataList[10].currencytype=CURRENCY_TYPE_ENUM.CURRENCY_TYPE_ENUM_GOLD --货币类型
    selfObj.miDataList[10].currencynum=10    --货币数量
    selfObj.miDataList[10].icon="game/game_items/common/item10/item10.png"
    selfObj.miDataList[10].disableicon="game/game_items/common/item10/item10_disable.png"
    selfObj.miDataList[10].type=OTHER_INFO_FACE_TYPE_ENUM.OTHER_INFO_FACE_TYPE_ENUM_FLY_TARGET

    selfObj.miDataList[10].from="game/game_items/common/item10/item10.png"
    selfObj.miDataList[10].fromtime=0.8
    selfObj.miDataList[10].fromplist="game/game_items/common/item10/item10_anims_fly.plist"
    selfObj.miDataList[10].fromplistpng="game/game_items/common/item10/item10_anims_fly.png"
    selfObj.miDataList[10].fromplistimage="item10_fly%d.png"
    selfObj.miDataList[10].frompnum=8
    selfObj.miDataList[10].fromanimstimer=0.1
    selfObj.miDataList[10].fromactiontimes=1 --播放次数
    selfObj.miDataList[10].fromisturn = true

    selfObj.miDataList[10].to="game/game_items/common/item10/item10_to.png"
    selfObj.miDataList[10].totime=1.8
    selfObj.miDataList[10].toplist="game/game_items/common/item10/item10_anims_to.plist"
    selfObj.miDataList[10].toplistpng="game/game_items/common/item10/item10_anims_to.png"
    selfObj.miDataList[10].toplistimage="item10_play%d.png"
    selfObj.miDataList[10].topnum=18
    selfObj.miDataList[10].toanimstimer=0.1
    selfObj.miDataList[10].toactiontimes=1 --播放次数
    selfObj.miDataList[10].toisturn = true

    --nice hand
    selfObj.miDataList[11]={}
    selfObj.miDataList[11].id=11
    selfObj.miDataList[11].idname="animateItem#item8"
    selfObj.miDataList[11].currencytype=CURRENCY_TYPE_ENUM.CURRENCY_TYPE_ENUM_GOLD --货币类型
    selfObj.miDataList[11].currencynum=10    --货币数量
    selfObj.miDataList[11].icon="game/game_items/common/item11/item11.png"
    selfObj.miDataList[11].disableicon="game/game_items/common/item11/item11_disable.png"
    selfObj.miDataList[11].type=OTHER_INFO_FACE_TYPE_ENUM.OTHER_INFO_FACE_TYPE_ENUM_PLAY_DELAY_FLY_TARGET
    selfObj.miDataList[11].isflyturnangle=false  --飞行节点是否调整角度
    selfObj.miDataList[11].isflymove=true  --飞行节点是否需要移动到目标节点

    selfObj.miDataList[11].from="game/game_items/common/item11/item11.png"
    selfObj.miDataList[11].fromtime=0.4
    selfObj.miDataList[11].fromplist="game/game_items/common/item11/item11_anims_from.plist"
    selfObj.miDataList[11].fromplistpng="game/game_items/common/item11/item11_anims_from.png"
    selfObj.miDataList[11].fromplistimage="item11_from%d.png"
    selfObj.miDataList[11].frompnum=4
    selfObj.miDataList[11].fromanimstimer=0.1
    selfObj.miDataList[11].fromactiontimes=6 --播放次数

    selfObj.miDataList[11].fly="game/game_items/common/item11/item11_fly.png"
    selfObj.miDataList[11].flytime=0.8
    selfObj.miDataList[11].flydelaytime=0
    selfObj.miDataList[11].flyplist="game/game_items/common/item11/item11_anims_fly.plist"
    selfObj.miDataList[11].flyplistpng="game/game_items/common/item11/item11_anims_fly.png"
    selfObj.miDataList[11].flyplistimage="item11_fly%d.png"
    selfObj.miDataList[11].flypnum=8
    selfObj.miDataList[11].flyanimstimer=0.1
    selfObj.miDataList[11].flyactiontimes=1 --播放次数

    selfObj.miDataList[11].to="game/game_items/common/item11/item11_to.png"
    selfObj.miDataList[11].totime=1.9
    selfObj.miDataList[11].todelaytime=0.8
    selfObj.miDataList[11].toplist="game/game_items/common/item11/item11_anims_to.plist"
    selfObj.miDataList[11].toplistpng="game/game_items/common/item11/item11_anims_to.png"
    selfObj.miDataList[11].toplistimage="item11_to%d.png"
    selfObj.miDataList[11].topnum=19
    selfObj.miDataList[11].toanimstimer=0.1
    selfObj.miDataList[11].toactiontimes=1 --播放次数

end

function GetData(selfObj)
    
    My_Lua_log(" file=[gameitemdata] fun=[GetData];")

    return selfObj.miDataList
end

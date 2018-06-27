
module(...,package.seeall)

local Local_GIsCreate = false
local selfObj = {}

--免费表情动画

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

    selfObj.miDataList={}
    selfObj.miDataList[1]={}
    selfObj.miDataList[1].id="animate#face1"
    selfObj.miDataList[1].icon="game/game_faces/common/face/face1/face1-i6p.png" --“gamelayer/game_faces/i5/face1/face1_hd.png”
    selfObj.miDataList[1].plist="game/game_faces/common/face/face1/face1_anims_i6p.plist"
    selfObj.miDataList[1].plistpng="game/game_faces/common/face/face1/face1_anims_i6p-i6p.png"
    selfObj.miDataList[1].plistimage="face1_%d.png"
    selfObj.miDataList[1].num=10
    selfObj.miDataList[1].timer=0.2
    selfObj.miDataList[1].animatesprite="freefacesprite"
    selfObj.miDataList[1].scale=1
    selfObj.miDataList[2]={}
    selfObj.miDataList[2].id="animate#face2"
    selfObj.miDataList[2].icon="game/game_faces/common/face/face2/face2-i6p.png"
    selfObj.miDataList[2].plist="game/game_faces/common/face/face2/face2_anims_i6p.plist"
    selfObj.miDataList[2].plistpng="game/game_faces/common/face/face2/face2_anims_i6p-i6p.png"
    selfObj.miDataList[2].plistimage="face2_%d.png"
    selfObj.miDataList[2].num=10
    selfObj.miDataList[2].timer=0.2
    selfObj.miDataList[2].animatesprite="freefacesprite"
    selfObj.miDataList[2].scale=1
    selfObj.miDataList[3]={}
    selfObj.miDataList[3].id="animate#face3"
    selfObj.miDataList[3].icon="game/game_faces/common/face/face3/face3-i6p.png"
    selfObj.miDataList[3].plist="game/game_faces/common/face/face3/face3_anims_i6p.plist"
    selfObj.miDataList[3].plistpng="game/game_faces/common/face/face3/face3_anims_i6p-i6p.png"
    selfObj.miDataList[3].plistimage="face3_%d.png"
    selfObj.miDataList[3].num=10
    selfObj.miDataList[3].timer=0.2
    selfObj.miDataList[3].animatesprite="freefacesprite"
    selfObj.miDataList[3].scale=1
    selfObj.miDataList[4]={}
    selfObj.miDataList[4].id="animate#face4"
    selfObj.miDataList[4].icon="game/game_faces/common/face/face4/face4-i6p.png"
    selfObj.miDataList[4].plist="game/game_faces/common/face/face4/face4_anims_i6p.plist"
    selfObj.miDataList[4].plistpng="game/game_faces/common/face/face4/face4_anims_i6p-i6p.png"
    selfObj.miDataList[4].plistimage="face4_%d.png"
    selfObj.miDataList[4].num=10
    selfObj.miDataList[4].timer=0.2
    selfObj.miDataList[4].animatesprite="freefacesprite"
    selfObj.miDataList[4].scale=1
    selfObj.miDataList[5]={}
    selfObj.miDataList[5].id="animate#face5"
    selfObj.miDataList[5].icon="game/game_faces/common/face/face5/face5-i6p.png"
    selfObj.miDataList[5].plist="game/game_faces/common/face/face5/face5_anims_i6p.plist"
    selfObj.miDataList[5].plistpng="game/game_faces/common/face/face5/face5_anims_i6p-i6p.png"
    selfObj.miDataList[5].plistimage="face5_%d.png"
    selfObj.miDataList[5].num=10
    selfObj.miDataList[5].timer=0.2
    selfObj.miDataList[5].animatesprite="freefacesprite"
    selfObj.miDataList[5].scale=1
    selfObj.miDataList[6]={}
    selfObj.miDataList[6].id="animate#face6"
    selfObj.miDataList[6].icon="game/game_faces/common/face/face6/face6-i6p.png"
    selfObj.miDataList[6].plist="game/game_faces/common/face/face6/face6_anims_i6p.plist"
    selfObj.miDataList[6].plistpng="game/game_faces/common/face/face6/face6_anims_i6p-i6p.png"
    selfObj.miDataList[6].plistimage="face6_%d.png"
    selfObj.miDataList[6].num=10
    selfObj.miDataList[6].timer=0.2
    selfObj.miDataList[6].animatesprite="freefacesprite"
    selfObj.miDataList[6].scale=1
    selfObj.miDataList[7]={}
    selfObj.miDataList[7].id="animate#face7"
    selfObj.miDataList[7].icon="game/game_faces/common/face/face7/face7-i6p.png"
    selfObj.miDataList[7].plist="game/game_faces/common/face/face7/face7_anims_i6p.plist"
    selfObj.miDataList[7].plistpng="game/game_faces/common/face/face7/face7_anims_i6p-i6p.png"
    selfObj.miDataList[7].plistimage="face7_%d.png"
    selfObj.miDataList[7].num=10
    selfObj.miDataList[7].timer=0.2
    selfObj.miDataList[7].animatesprite="freefacesprite"
    selfObj.miDataList[7].scale=1
    selfObj.miDataList[8]={}
    selfObj.miDataList[8].id="animate#face8"
    selfObj.miDataList[8].icon="game/game_faces/common/face/face8/face8-i6p.png"
    selfObj.miDataList[8].plist="game/game_faces/common/face/face8/face8_anims_i6p.plist"
    selfObj.miDataList[8].plistpng="game/game_faces/common/face/face8/face8_anims_i6p-i6p.png"
    selfObj.miDataList[8].plistimage="face8_%d.png"
    selfObj.miDataList[8].num=24
    selfObj.miDataList[8].timer=0.1
    selfObj.miDataList[8].animatesprite="freefacesprite"
    selfObj.miDataList[8].scale=1
    selfObj.miDataList[9]={}
    selfObj.miDataList[9].id="animate#face9"
    selfObj.miDataList[9].icon="game/game_faces/common/face/face9/face9-i6p.png"
    selfObj.miDataList[9].plist="game/game_faces/common/face/face9/face9_anims_i6p.plist"
    selfObj.miDataList[9].plistpng="game/game_faces/common/face/face9/face9_anims_i6p-i6p.png"
    selfObj.miDataList[9].plistimage="face9_%d.png"
    selfObj.miDataList[9].num=10
    selfObj.miDataList[9].timer=0.2
    selfObj.miDataList[9].animatesprite="freefacesprite"
    selfObj.miDataList[9].scale=1
    selfObj.miDataList[10]={}
    selfObj.miDataList[10].id="animate#face10"
    selfObj.miDataList[10].icon="game/game_faces/common/face/face10/face10-i6p.png"
    selfObj.miDataList[10].plist="game/game_faces/common/face/face10/face10_anims_i6p.plist"
    selfObj.miDataList[10].plistpng="game/game_faces/common/face/face10/face10_anims_i6p-i6p.png"
    selfObj.miDataList[10].plistimage="face10_%d.png"
    selfObj.miDataList[10].num=12
    selfObj.miDataList[10].timer=0.2
    selfObj.miDataList[10].animatesprite="freefacesprite"
    selfObj.miDataList[10].scale=1
    selfObj.miDataList[11]={}
    selfObj.miDataList[11].id="animate#face11"
    selfObj.miDataList[11].icon="game/game_faces/common/face/face11/face11-i6p.png"
    selfObj.miDataList[11].plist="game/game_faces/common/face/face11/face11_anims_i6p.plist"
    selfObj.miDataList[11].plistpng="game/game_faces/common/face/face11/face11_anims_i6p-i6p.png"
    selfObj.miDataList[11].plistimage="face11_%d.png"
    selfObj.miDataList[11].num=11
    selfObj.miDataList[11].timer=0.2
    selfObj.miDataList[11].animatesprite="freefacesprite"
    selfObj.miDataList[11].scale=1
    selfObj.miDataList[12]={}
    selfObj.miDataList[12].id="animate#face12"
    selfObj.miDataList[12].icon="game/game_faces/common/face/face12/face12-i6p.png"
    selfObj.miDataList[12].plist="game/game_faces/common/face/face12/face12_anims_i6p.plist"
    selfObj.miDataList[12].plistpng="game/game_faces/common/face/face12/face12_anims_i6p-i6p.png"
    selfObj.miDataList[12].plistimage="face12_%d.png"
    selfObj.miDataList[12].num=10
    selfObj.miDataList[12].timer=0.1
    selfObj.miDataList[12].animatesprite="freefacesprite"
    selfObj.miDataList[12].scale=1


end

function GetData(selfObj)
    
    My_Lua_log(" file=[gamefacedata] fun=[GetData];")

    return selfObj.miDataList
end


module(...,package.seeall)

local Local_GIsCreate = false
local selfObj = {}

--魔法表情动画

function Create()
	if Local_GIsCreate == true then
		return selfObj
	end
	setmetatable(selfObj, {__index = _M})
	Local_GIsCreate = true

    selfObj.miDataListCN = {}  --魔法表情，中文
    selfObj.miDataListENG = {}  --魔法表情，英文

    selfObj:InitData()

	return selfObj
end

function InitData(selfObj)   
    
    --中文
    selfObj.miDataListCN={}
    selfObj.miDataListCN[1]={}
    selfObj.miDataListCN[1].id="animate#magicface1"
    selfObj.miDataListCN[1].icon="game/game_faces/cn/magic_face/magic_face1/face01.png"
    selfObj.miDataListCN[1].plist="game/game_faces/cn/magic_face/magic_face1/face1_anim.plist"
    selfObj.miDataListCN[1].plistpng="game/game_faces/cn/magic_face/magic_face1/face1_anim.png"
    selfObj.miDataListCN[1].plistimage="face01_0%d.png"
    selfObj.miDataListCN[1].num=10
    selfObj.miDataListCN[1].timer=0.1
    selfObj.miDataListCN[1].repeatTimes=2
    selfObj.miDataListCN[1].animatesprite="magicfacesprite"
    selfObj.miDataListCN[1].scale=1.0

    selfObj.miDataListCN[2]={}
    selfObj.miDataListCN[2].id="animate#magicface2"
    selfObj.miDataListCN[2].icon="game/game_faces/cn/magic_face/magic_face2/face02.png"
    selfObj.miDataListCN[2].plist="game/game_faces/cn/magic_face/magic_face2/face2_anim.plist"
    selfObj.miDataListCN[2].plistpng="game/game_faces/cn/magic_face/magic_face2/face2_anim.png"
    selfObj.miDataListCN[2].plistimage="face02_0%d.png"
    selfObj.miDataListCN[2].num=10
    selfObj.miDataListCN[2].timer=0.1
    selfObj.miDataListCN[2].repeatTimes=2
    selfObj.miDataListCN[2].animatesprite="magicfacesprite"
    selfObj.miDataListCN[2].scale=1.0

    --selfObj.miDataListCN[3]={}
    --selfObj.miDataListCN[3].id="animate#magicface3"
    --selfObj.miDataListCN[3].icon="game/game_faces/cn/magic_face/magic_face3/face03.png"
    --selfObj.miDataListCN[3].plist="game/game_faces/cn/magic_face/magic_face3/face3_anim.plist"
    --selfObj.miDataListCN[3].plistpng="game/game_faces/cn/magic_face/magic_face3/face3_anim.png"
    --selfObj.miDataListCN[3].plistimage="face03_0%d.png"
    --selfObj.miDataListCN[3].num=15
    --selfObj.miDataListCN[3].timer=0.1
    --selfObj.miDataListCN[3].repeatTimes=1
    --selfObj.miDataListCN[3].animatesprite="magicfacesprite"
    --selfObj.miDataListCN[3].scale=1.0

    selfObj.miDataListCN[3]={}
    selfObj.miDataListCN[3].id="animate#magicface3"
    selfObj.miDataListCN[3].icon="game/game_faces/cn/magic_face/magic_face13/face13.png"
    selfObj.miDataListCN[3].plist="game/game_faces/cn/magic_face/magic_face13/face13_anim.plist"
    selfObj.miDataListCN[3].plistpng="game/game_faces/cn/magic_face/magic_face13/face13_anim.png"
    selfObj.miDataListCN[3].plistimage="face13_0%d.png"
    selfObj.miDataListCN[3].num=20
    selfObj.miDataListCN[3].timer=0.1
    selfObj.miDataListCN[3].repeatTimes=1
    selfObj.miDataListCN[3].animatesprite="magicfacesprite"
    selfObj.miDataListCN[3].scale=1.0

    selfObj.miDataListCN[4]={}
    selfObj.miDataListCN[4].id="animate#magicface4"
    selfObj.miDataListCN[4].icon="game/game_faces/cn/magic_face/magic_face4/face04.png"
    selfObj.miDataListCN[4].plist="game/game_faces/cn/magic_face/magic_face4/face4_anim.plist"
    selfObj.miDataListCN[4].plistpng="game/game_faces/cn/magic_face/magic_face4/face4_anim.png"
    selfObj.miDataListCN[4].plistimage="face04_0%d.png"
    selfObj.miDataListCN[4].num=10
    selfObj.miDataListCN[4].timer=0.1
    selfObj.miDataListCN[4].repeatTimes=2
    selfObj.miDataListCN[4].animatesprite="magicfacesprite"
    selfObj.miDataListCN[4].scale=1.0

    selfObj.miDataListCN[5]={}
    selfObj.miDataListCN[5].id="animate#magicface5"
    selfObj.miDataListCN[5].icon="game/game_faces/cn/magic_face/magic_face5/face05.png"
    selfObj.miDataListCN[5].plist="game/game_faces/cn/magic_face/magic_face5/face5_anim.plist"
    selfObj.miDataListCN[5].plistpng="game/game_faces/cn/magic_face/magic_face5/face5_anim.png"
    selfObj.miDataListCN[5].plistimage="face05_0%d.png"
    selfObj.miDataListCN[5].num=6
    selfObj.miDataListCN[5].timer=0.1
    selfObj.miDataListCN[5].repeatTimes=3
    selfObj.miDataListCN[5].animatesprite="magicfacesprite"
    selfObj.miDataListCN[5].scale=1.0

    selfObj.miDataListCN[6]={}
    selfObj.miDataListCN[6].id="animate#magicface6"
    selfObj.miDataListCN[6].icon="game/game_faces/cn/magic_face/magic_face6/face06.png"
    selfObj.miDataListCN[6].plist="game/game_faces/cn/magic_face/magic_face6/face6_anim.plist"
    selfObj.miDataListCN[6].plistpng="game/game_faces/cn/magic_face/magic_face6/face6_anim.png"
    selfObj.miDataListCN[6].plistimage="face06_0%d.png"
    selfObj.miDataListCN[6].num=12
    selfObj.miDataListCN[6].timer=0.1
    selfObj.miDataListCN[6].repeatTimes=2
    selfObj.miDataListCN[6].animatesprite="magicfacesprite"
    selfObj.miDataListCN[6].scale=1.0

    selfObj.miDataListCN[7]={}
    selfObj.miDataListCN[7].id="animate#magicface7"
    selfObj.miDataListCN[7].icon="game/game_faces/cn/magic_face/magic_face7/face07.png"
    selfObj.miDataListCN[7].plist="game/game_faces/cn/magic_face/magic_face7/face7_anim.plist"
    selfObj.miDataListCN[7].plistpng="game/game_faces/cn/magic_face/magic_face7/face7_anim.png"
    selfObj.miDataListCN[7].plistimage="face07_0%d.png"
    selfObj.miDataListCN[7].num=4
    selfObj.miDataListCN[7].timer=0.1
    selfObj.miDataListCN[7].repeatTimes=5
    selfObj.miDataListCN[7].animatesprite="magicfacesprite"
    selfObj.miDataListCN[7].scale=1.0

    selfObj.miDataListCN[8]={}
    selfObj.miDataListCN[8].id="animate#magicface8"
    selfObj.miDataListCN[8].icon="game/game_faces/cn/magic_face/magic_face8/face08.png"
    selfObj.miDataListCN[8].plist="game/game_faces/cn/magic_face/magic_face8/face8_anim.plist"
    selfObj.miDataListCN[8].plistpng="game/game_faces/cn/magic_face/magic_face8/face8_anim.png"
    selfObj.miDataListCN[8].plistimage="face08_0%d.png"
    selfObj.miDataListCN[8].num=10
    selfObj.miDataListCN[8].timer=0.1
    selfObj.miDataListCN[8].repeatTimes=2
    selfObj.miDataListCN[8].animatesprite="magicfacesprite"
    selfObj.miDataListCN[8].scale=1.0

    selfObj.miDataListCN[9]={}
    selfObj.miDataListCN[9].id="animate#magicface9"
    selfObj.miDataListCN[9].icon="game/game_faces/cn/magic_face/magic_face9/face09.png"
    selfObj.miDataListCN[9].plist="game/game_faces/cn/magic_face/magic_face9/face9_anim.plist"
    selfObj.miDataListCN[9].plistpng="game/game_faces/cn/magic_face/magic_face9/face9_anim.png"
    selfObj.miDataListCN[9].plistimage="face09_0%d.png"
    selfObj.miDataListCN[9].num=12
    selfObj.miDataListCN[9].timer=0.1
    selfObj.miDataListCN[9].repeatTimes=2
    selfObj.miDataListCN[9].animatesprite="magicfacesprite"
    selfObj.miDataListCN[9].scale=1.0

    selfObj.miDataListCN[10]={}
    selfObj.miDataListCN[10].id="animate#magicface10"
    selfObj.miDataListCN[10].icon="game/game_faces/cn/magic_face/magic_face10/face10.png"
    selfObj.miDataListCN[10].plist="game/game_faces/cn/magic_face/magic_face10/face10_anim.plist"
    selfObj.miDataListCN[10].plistpng="game/game_faces/cn/magic_face/magic_face10/face10_anim.png"
    selfObj.miDataListCN[10].plistimage="face10_0%d.png"
    selfObj.miDataListCN[10].num=12
    selfObj.miDataListCN[10].timer=0.1
    selfObj.miDataListCN[10].repeatTimes=2
    selfObj.miDataListCN[10].animatesprite="magicfacesprite"
    selfObj.miDataListCN[10].scale=1.0

    selfObj.miDataListCN[11]={}
    selfObj.miDataListCN[11].id="animate#magicface11"
    selfObj.miDataListCN[11].icon="game/game_faces/cn/magic_face/magic_face11/face11.png"
    selfObj.miDataListCN[11].plist="game/game_faces/cn/magic_face/magic_face11/face11_anim.plist"
    selfObj.miDataListCN[11].plistpng="game/game_faces/cn/magic_face/magic_face11/face11_anim.png"
    selfObj.miDataListCN[11].plistimage="face11_0%d.png"
    selfObj.miDataListCN[11].num=5
    selfObj.miDataListCN[11].timer=0.1
    selfObj.miDataListCN[11].repeatTimes=4
    selfObj.miDataListCN[11].animatesprite="magicfacesprite"
    selfObj.miDataListCN[11].scale=1.0

    selfObj.miDataListCN[12]={}
    selfObj.miDataListCN[12].id="animate#magicface12"
    selfObj.miDataListCN[12].icon="game/game_faces/cn/magic_face/magic_face12/face12.png"
    selfObj.miDataListCN[12].plist="game/game_faces/cn/magic_face/magic_face12/face12_anim.plist"
    selfObj.miDataListCN[12].plistpng="game/game_faces/cn/magic_face/magic_face12/face12_anim.png"
    selfObj.miDataListCN[12].plistimage="face12_0%d.png"
    selfObj.miDataListCN[12].num=11
    selfObj.miDataListCN[12].timer=0.1
    selfObj.miDataListCN[12].repeatTimes=2
    selfObj.miDataListCN[12].animatesprite="magicfacesprite"
    selfObj.miDataListCN[12].scale=1.0


    --英文
    selfObj.miDataListENG={}
    selfObj.miDataListENG[1]={}
    selfObj.miDataListENG[1].id="animate#magicface1"
    selfObj.miDataListENG[1].icon="game/game_faces/eng/magic_face/magic_face1/face01.png"
    selfObj.miDataListENG[1].plist="game/game_faces/eng/magic_face/magic_face1/face1_anim.plist"
    selfObj.miDataListENG[1].plistpng="game/game_faces/eng/magic_face/magic_face1/face1_anim.png"
    selfObj.miDataListENG[1].plistimage="face01_0%d.png"
    selfObj.miDataListENG[1].num=10
    selfObj.miDataListENG[1].timer=0.1
    selfObj.miDataListENG[1].repeatTimes=2
    selfObj.miDataListENG[1].animatesprite="magicfacesprite"
    selfObj.miDataListENG[1].scale=1.0

    selfObj.miDataListENG[2]={}
    selfObj.miDataListENG[2].id="animate#magicface2"
    selfObj.miDataListENG[2].icon="game/game_faces/eng/magic_face/magic_face2/face02.png"
    selfObj.miDataListENG[2].plist="game/game_faces/eng/magic_face/magic_face2/face2_anim.plist"
    selfObj.miDataListENG[2].plistpng="game/game_faces/eng/magic_face/magic_face2/face2_anim.png"
    selfObj.miDataListENG[2].plistimage="face02_0%d.png"
    selfObj.miDataListENG[2].num=10
    selfObj.miDataListENG[2].timer=0.1
    selfObj.miDataListENG[2].repeatTimes=2
    selfObj.miDataListENG[2].animatesprite="magicfacesprite"
    selfObj.miDataListENG[2].scale=1.0

    --selfObj.miDataListENG[3]={}
    --selfObj.miDataListENG[3].id="animate#magicface3"
    --selfObj.miDataListENG[3].icon="game/game_faces/eng/magic_face/magic_face3/face03.png"
    --selfObj.miDataListENG[3].plist="game/game_faces/eng/magic_face/magic_face3/face3_anim.plist"
    --selfObj.miDataListENG[3].plistpng="game/game_faces/eng/magic_face/magic_face3/face3_anim.png"
    --selfObj.miDataListENG[3].plistimage="face03_0%d.png"
    --selfObj.miDataListENG[3].num=15
    --selfObj.miDataListENG[3].timer=0.1
    --selfObj.miDataListENG[3].repeatTimes=1
    --selfObj.miDataListENG[3].animatesprite="magicfacesprite"
    --selfObj.miDataListENG[3].scale=1.0

    selfObj.miDataListENG[3]={}
    selfObj.miDataListENG[3].id="animate#magicface3"
    selfObj.miDataListENG[3].icon="game/game_faces/eng/magic_face/magic_face13/face13.png"
    selfObj.miDataListENG[3].plist="game/game_faces/eng/magic_face/magic_face13/face13_anim.plist"
    selfObj.miDataListENG[3].plistpng="game/game_faces/eng/magic_face/magic_face13/face13_anim.png"
    selfObj.miDataListENG[3].plistimage="face13_0%d.png"
    selfObj.miDataListENG[3].num=20
    selfObj.miDataListENG[3].timer=0.1
    selfObj.miDataListENG[3].repeatTimes=1
    selfObj.miDataListENG[3].animatesprite="magicfacesprite"
    selfObj.miDataListENG[3].scale=1.0

    selfObj.miDataListENG[4]={}
    selfObj.miDataListENG[4].id="animate#magicface4"
    selfObj.miDataListENG[4].icon="game/game_faces/eng/magic_face/magic_face4/face04.png"
    selfObj.miDataListENG[4].plist="game/game_faces/eng/magic_face/magic_face4/face4_anim.plist"
    selfObj.miDataListENG[4].plistpng="game/game_faces/eng/magic_face/magic_face4/face4_anim.png"
    selfObj.miDataListENG[4].plistimage="face04_0%d.png"
    selfObj.miDataListENG[4].num=10
    selfObj.miDataListENG[4].timer=0.1
    selfObj.miDataListENG[4].repeatTimes=2
    selfObj.miDataListENG[4].animatesprite="magicfacesprite"
    selfObj.miDataListENG[4].scale=1.0

    selfObj.miDataListENG[5]={}
    selfObj.miDataListENG[5].id="animate#magicface5"
    selfObj.miDataListENG[5].icon="game/game_faces/eng/magic_face/magic_face5/face05.png"
    selfObj.miDataListENG[5].plist="game/game_faces/eng/magic_face/magic_face5/face5_anim.plist"
    selfObj.miDataListENG[5].plistpng="game/game_faces/eng/magic_face/magic_face5/face5_anim.png"
    selfObj.miDataListENG[5].plistimage="face05_0%d.png"
    selfObj.miDataListENG[5].num=6
    selfObj.miDataListENG[5].timer=0.1
    selfObj.miDataListENG[5].repeatTimes=3
    selfObj.miDataListENG[5].animatesprite="magicfacesprite"
    selfObj.miDataListENG[5].scale=1.0

    selfObj.miDataListENG[6]={}
    selfObj.miDataListENG[6].id="animate#magicface6"
    selfObj.miDataListENG[6].icon="game/game_faces/eng/magic_face/magic_face6/face06.png"
    selfObj.miDataListENG[6].plist="game/game_faces/eng/magic_face/magic_face6/face6_anim.plist"
    selfObj.miDataListENG[6].plistpng="game/game_faces/eng/magic_face/magic_face6/face6_anim.png"
    selfObj.miDataListENG[6].plistimage="face06_0%d.png"
    selfObj.miDataListENG[6].num=12
    selfObj.miDataListENG[6].timer=0.1
    selfObj.miDataListENG[6].repeatTimes=2
    selfObj.miDataListENG[6].animatesprite="magicfacesprite"
    selfObj.miDataListENG[6].scale=1.0

    selfObj.miDataListENG[7]={}
    selfObj.miDataListENG[7].id="animate#magicface7"
    selfObj.miDataListENG[7].icon="game/game_faces/eng/magic_face/magic_face7/face07.png"
    selfObj.miDataListENG[7].plist="game/game_faces/eng/magic_face/magic_face7/face7_anim.plist"
    selfObj.miDataListENG[7].plistpng="game/game_faces/eng/magic_face/magic_face7/face7_anim.png"
    selfObj.miDataListENG[7].plistimage="face07_0%d.png"
    selfObj.miDataListENG[7].num=4
    selfObj.miDataListENG[7].timer=0.1
    selfObj.miDataListENG[7].repeatTimes=5
    selfObj.miDataListENG[7].animatesprite="magicfacesprite"
    selfObj.miDataListENG[7].scale=1.0

    selfObj.miDataListENG[8]={}
    selfObj.miDataListENG[8].id="animate#magicface8"
    selfObj.miDataListENG[8].icon="game/game_faces/eng/magic_face/magic_face8/face08.png"
    selfObj.miDataListENG[8].plist="game/game_faces/eng/magic_face/magic_face8/face8_anim.plist"
    selfObj.miDataListENG[8].plistpng="game/game_faces/eng/magic_face/magic_face8/face8_anim.png"
    selfObj.miDataListENG[8].plistimage="face08_0%d.png"
    selfObj.miDataListENG[8].num=10
    selfObj.miDataListENG[8].timer=0.1
    selfObj.miDataListENG[8].repeatTimes=2
    selfObj.miDataListENG[8].animatesprite="magicfacesprite"
    selfObj.miDataListENG[8].scale=1.0

    selfObj.miDataListENG[9]={}
    selfObj.miDataListENG[9].id="animate#magicface9"
    selfObj.miDataListENG[9].icon="game/game_faces/eng/magic_face/magic_face9/face09.png"
    selfObj.miDataListENG[9].plist="game/game_faces/eng/magic_face/magic_face9/face9_anim.plist"
    selfObj.miDataListENG[9].plistpng="game/game_faces/eng/magic_face/magic_face9/face9_anim.png"
    selfObj.miDataListENG[9].plistimage="face09_0%d.png"
    selfObj.miDataListENG[9].num=12
    selfObj.miDataListENG[9].timer=0.1
    selfObj.miDataListENG[9].repeatTimes=2
    selfObj.miDataListENG[9].animatesprite="magicfacesprite"
    selfObj.miDataListENG[9].scale=1.0

    selfObj.miDataListENG[10]={}
    selfObj.miDataListENG[10].id="animate#magicface10"
    selfObj.miDataListENG[10].icon="game/game_faces/eng/magic_face/magic_face10/face10.png"
    selfObj.miDataListENG[10].plist="game/game_faces/eng/magic_face/magic_face10/face10_anim.plist"
    selfObj.miDataListENG[10].plistpng="game/game_faces/eng/magic_face/magic_face10/face10_anim.png"
    selfObj.miDataListENG[10].plistimage="face10_0%d.png"
    selfObj.miDataListENG[10].num=12
    selfObj.miDataListENG[10].timer=0.1
    selfObj.miDataListENG[10].repeatTimes=2
    selfObj.miDataListENG[10].animatesprite="magicfacesprite"
    selfObj.miDataListENG[10].scale=1.0

    selfObj.miDataListENG[11]={}
    selfObj.miDataListENG[11].id="animate#magicface11"
    selfObj.miDataListENG[11].icon="game/game_faces/eng/magic_face/magic_face11/face11.png"
    selfObj.miDataListENG[11].plist="game/game_faces/eng/magic_face/magic_face11/face11_anim.plist"
    selfObj.miDataListENG[11].plistpng="game/game_faces/eng/magic_face/magic_face11/face11_anim.png"
    selfObj.miDataListENG[11].plistimage="face11_0%d.png"
    selfObj.miDataListENG[11].num=5
    selfObj.miDataListENG[11].timer=0.1
    selfObj.miDataListENG[11].repeatTimes=4
    selfObj.miDataListENG[11].animatesprite="magicfacesprite"
    selfObj.miDataListENG[11].scale=1.0

    selfObj.miDataListENG[12]={}
    selfObj.miDataListENG[12].id="animate#magicface12"
    selfObj.miDataListENG[12].icon="game/game_faces/eng/magic_face/magic_face12/face12.png"
    selfObj.miDataListENG[12].plist="game/game_faces/eng/magic_face/magic_face12/face12_anim.plist"
    selfObj.miDataListENG[12].plistpng="game/game_faces/eng/magic_face/magic_face12/face12_anim.png"
    selfObj.miDataListENG[12].plistimage="face12_0%d.png"
    selfObj.miDataListENG[12].num=11
    selfObj.miDataListENG[12].timer=0.1
    selfObj.miDataListENG[12].repeatTimes=2
    selfObj.miDataListENG[12].animatesprite="magicfacesprite"
    selfObj.miDataListENG[12].scale=1.0

end

--通过语言获取数据
function GetDataByLanguage(selfObj, aiLanguage)
    
    My_Lua_log(" file=[gamemagicfacedata] fun=[GetDataByLanguage];")

    if aiLanguage == nil then
        return nil
    end

    --目前规则是中午用带中文字的一套，其他语言用英文
    if aiLanguage == LANGUAGE_TYPE.G_LANGUAGE_CHINESE_CN then
        return selfObj.miDataListCN

    else
        return selfObj.miDataListENG
    end
end

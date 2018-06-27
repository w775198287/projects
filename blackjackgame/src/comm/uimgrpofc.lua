--------------------------------------------------------
--info:UIManger 窗口管理类
--author:Daneil
--date:2015-6-10
--------------------------------------------------------
module(...,package.seeall)
local Local_UiMgrBase = require "comm.uimgrbase"

function Create(aiData)
    local selfObj = Local_UiMgrBase.Create(aiData)
    local parents = {_M, Local_UiMgrBase}
    setmetatable( selfObj ,{__index = function(t,k)
        return search(k,parents) end } )

    selfObj:RegisteredUi()
    selfObj:RegisteredUiEx()
    return selfObj
end

--用于注册更新前UI
function RegisteredUi(selfObj)
    -- 满座提示
    local Gamefullpushpag = require("pofcpoker.game.gamefullpush.gamefullpushpag")
    selfObj.miUiRegList["gamefullpushpag"] = Gamefullpushpag.Create
    My_Lua_log("file=[uimgrpofc] fun=[gamefullpushpag]; name=[gamefullpushpag] registered")

    --通用ui
    local MainScenePag = require("pofcpoker.game.mainscene.pofcmainscenepag")
    selfObj.miUiRegList["pofcmainscenepag"] = MainScenePag.Create
    My_Lua_log("file=[uimgrpofc] fun=[registeredui]; name=[pofcmainscenepag] registered")

    local MainmenuPag = require("pofcpoker.game.mainmenu.pofcmainmenupag")
    selfObj.miUiRegList["pofcmainmenupag"] = MainmenuPag.Create
    My_Lua_log("file=[uimgrpofc] fun=[registeredui]; name=[pofcmainmenupag] registered")

    -- 别人信息
    local Pofcotherinfopag = require("pofcpoker.game.otherinfo.pofcotherinfopag")
    selfObj.miUiRegList["pofcotherinfopag"] = Pofcotherinfopag.Create
    My_Lua_log("file=[uimgrpofc] fun=[pofcotherinfopag]; name=[pofcotherinfopag] registered")

    -- 自己信息
    local Pofcotherinfoselfpag = require("pofcpoker.game.otherinfo.pofcotherinfoselfpag")
    selfObj.miUiRegList["pofcotherinfoselfpag"] = Pofcotherinfoselfpag.Create
    My_Lua_log("file=[uimgrpofc] fun=[pofcotherinfoselfpag]; name=[pofcotherinfoselfpag] registered")
    
    local PofccommonInputPag = require("pofcpoker.game.otherinfo.pofccommoninputpag")
    selfObj.miUiRegList["pofccommoninputpag"] = PofccommonInputPag.Create
    My_Lua_log("file=[uimgrpofc] fun=[registeredui]; name=[pofccommoninputpag] registered")

    -- operation
    local PofcOperationpag = require("pofcpoker.game.operation.pofcoperationpag")
    selfObj.miUiRegList["pofcoperationpag"] = PofcOperationpag.Create
    My_Lua_log("file=[uimgrpofc] fun=[pofcoperationpag]; name=[pofcoperationpag] registered")

    -- 牌局设置
    local PofcSettingpag = require("pofcpoker.game.setting.pofcsettingpag")
    selfObj.miUiRegList["pofcsettingpag"] = PofcSettingpag.Create
    My_Lua_log("file=[uimgrpofc] fun=[registeredui]; name=[pofcsettingpag] registered")

    -- 补充记分牌
    local PofcBuypag = require("pofcpoker.game.buyin.pofcbuypag")
    selfObj.miUiRegList["pofcbuypag"] = PofcBuypag.Create
    My_Lua_log("file=[uimgrpofc] fun=[registeredui]; name=[pofcbuypag] registered")

    -- 补充记分牌-联盟
    local PofcBuyuionpag = require("pofcpoker.game.buyin.pofcbuyunionpag")
    selfObj.miUiRegList["pofcbuyunionpag"] = PofcBuyuionpag.Create
    My_Lua_log("file=[uimgrpofc] fun=[registeredui]; name=[pofcbuyunionpag] registered")
    
    -- 触发补充记分牌
    local PofcPopbuypag = require("pofcpoker.game.buyin.pofcpopbuypag")
    selfObj.miUiRegList["pofcpopbuypag"] = PofcPopbuypag.Create
    My_Lua_log("file=[uimgrpofc] fun=[registeredui]; name=[pofcpopbuypag] registered")
    
    -- 触发补充记分牌-联盟
    local PofcPopbuyunionpag = require("pofcpoker.game.buyin.pofcpopbuyunionpag")
    selfObj.miUiRegList["pofcpopbuyunionpag"] = PofcPopbuyunionpag.Create
    My_Lua_log("file=[uimgrpofc] fun=[registeredui]; name=[pofcpopbuyunionpag] registered")

    -- 坐下买入
    local PofcSitdownbuypag = require("pofcpoker.game.buyin.pofcsitdownbuypag")
    selfObj.miUiRegList["pofcsitdownbuypag"] = PofcSitdownbuypag.Create
    My_Lua_log("file=[uimgrpofc] fun=[registeredui]; name=[pofcsitdownbuypag] registered")

    -- 坐下买入-联盟
    local PofcSitdownbuyunionpag = require("pofcpoker.game.buyin.pofcsitdownbuyunionpag")
    selfObj.miUiRegList["pofcsitdownbuyunionpag"] = PofcSitdownbuyunionpag.Create
    My_Lua_log("file=[uimgrpofc] fun=[registeredui]; name=[pofcsitdownbuyunionpag] registered")
    
    -- 买入控制通知消息
    local PofcControlbuyinmsgpag = require("pofcpoker.game.buyin.pofccontrolbuyinmsgpag")
    selfObj.miUiRegList["pofccontrolbuyinmsgpag"] = PofcControlbuyinmsgpag.Create
    My_Lua_log("file=[uimgrpofc] fun=[pofccontrolbuyinmsgpag]; name=[pofccontrolbuyinmsgpag] registered")

    -- gotoshop
    local PofcGotoshoppag = require("pofcpoker.game.buyin.pofcgotoshoppag")
    selfObj.miUiRegList["pofcgotoshoppag"] = PofcGotoshoppag.Create
    My_Lua_log("file=[uimgrpofc] fun=[registeredui]; name=[pofcgotoshoppag] registered")

    -- 记牌器
    local PofcPokerMarkerPag = require("pofcpoker.game.pokermarker.pofcpokermarkerpag")
    selfObj.miUiRegList["pofcpokermarkerpag"] = PofcPokerMarkerPag.Create
    My_Lua_log("file=[uimgrpofc] fun=[registeredui]; name=[pofcpokermarkerpag] registered")

    -- 实时战绩
    local PofcRealtimesituationmainpag = require("pofcpoker.game.realtimesituation.pofcrealtimesituationmainpag")
    selfObj.miUiRegList["pofcrealtimesituationmainpag"] = PofcRealtimesituationmainpag.Create
    My_Lua_log("file=[uimgrpofc] fun=[registeredui]; name=[pofcrealtimesituationmainpag] registered")

    -- 上局回顾
    local PofcReviewmainpag = require("pofcpoker.game.review.pofcreviewmainpag")
    selfObj.miUiRegList["pofcreviewmainpag"] = PofcReviewmainpag.Create
    My_Lua_log("file=[uimgrpofc] fun=[registeredui]; name=[pofcreviewmainpag] registered")

    -- 最终结算
    local PofcMatchstatisticsmainpag = require("pofcpoker.game.matchstatistic.pofcmatchstatisticsmainpag")
    selfObj.miUiRegList["pofcmatchstatisticsmainpag"] = PofcMatchstatisticsmainpag.Create
    My_Lua_log("file=[uimgrpofc] fun=[registeredui]; name=[pofcmatchstatisticsmainpag] registered")

    -- -- 牌型提示:old
    -- local PofcPromptpag = require("pofcpoker.game.prompt.pofcpromptpag")
    -- selfObj.miUiRegList["pofcpromptpag"] = PofcPromptpag.Create
    -- My_Lua_log("file=[uimgrpofc] fun=[registeredui]; name=[pofcpromptpag] registered")

    -- 牌型提示:new
    local PofcPromptpagNew = require("pofcpoker.game.prompt.pofcpromptpagnew")
    selfObj.miUiRegList["pofcpromptpagnew"] = PofcPromptpagNew.Create
    My_Lua_log("file=[uimgrpofc] fun=[registeredui]; name=[pofcpromptpagnew] registered")

    -- micro
    local PofcMicroimagepag = require("pofcpoker.game.microphone.pofcmicroimagepag")
    selfObj.miUiRegList["pofcmicroimagepag"] = PofcMicroimagepag.Create
    My_Lua_log("file=[uimgrpofc] fun=[pofcmicroimagepag]; name=[pofcmicroimagepag] registered")

    -- 弹幕框
    local BulletScreenpag = require("pofcpoker.game.bulletscreen.bulletscreenpag")
    selfObj.miUiRegList["bulletscreenpag"] = BulletScreenpag.Create
    My_Lua_log("file=[uimgrpofc] fun=[registeredui]; name=[bulletscreenpag] registered")
    
    -- tips
    -- 公共弹框提示--带按钮
    local Commontippag = require("pofcpoker.game.tips.commontippag")
    selfObj.miUiRegList["commontippag"] = Commontippag.Create
    My_Lua_log("file=[uimgrpofc] fun=[registeredui]; name=[commontippag] registered")
    
    local PofcWaitpag = require("pofcpoker.game.tips.pofcwaitpag")
    selfObj.miUiRegList["pofcwaitpag"] = PofcWaitpag.Create
    My_Lua_log("file=[uimgrpofc] fun=[pofcwaitpag]; name=[pofcwaitpag] registered")

    local Graytipspag = require("pofcpoker.game.tips.graytipspag")
    selfObj.miUiRegList["graytipspag"] = Graytipspag.Create
    My_Lua_log("file=[uimgrpofc] fun=[graytipspag]; name=[graytipspag] registered")

    local ErrorPag = require("pofcpoker.game.tips.errorpag")
    selfObj.miUiRegList["errorpag"] = ErrorPag.Create
    My_Lua_log("file=[uimgrpofc] fun=[registeredui]; name=[errorpag] registered")

    local PofcPausePag = require("pofcpoker.game.tips.pofcpausepag")
    selfObj.miUiRegList["pofcpausepag"] = PofcPausePag.Create
    My_Lua_log("file=[uimgrpofc] fun=[registeredui]; name=[pofcpausepag] registered")

    local PofcWeaktipspag = require("pofcpoker.game.tips.pofcweaktipspag")
    selfObj.miUiRegList["pofcweaktipspag"] = PofcWeaktipspag.Create
    My_Lua_log("file=[uimgrpofc] fun=[registeredui]; name=[pofcweaktipspag] registered")

    local LeavedeskPag = require("pofcpoker.game.tips.leavedeskpag")
    selfObj.miUiRegList["leavedeskpag"] = LeavedeskPag.Create
    My_Lua_log("file=[uimgrpofc] fun=[registeredui]; name=[leavedeskpag] registered")

    local WaitingotherPag = require("pofcpoker.game.tips.waitingotherpag")
    selfObj.miUiRegList["waitingotherpag"] = WaitingotherPag.Create
    My_Lua_log("file=[uimgrpofc] fun=[registeredui]; name=[waitingotherpag] registered")

    -------------- 德州相关 --------------
    -- 满局提示
    local MttstartpushPag = require("pofcpoker.game.gamefullpush.mttstartpushpag")
    selfObj.miUiRegList["mttstartpushpag"] = MttstartpushPag.Create
    My_Lua_log("file=[uimgrpofc] fun=[registeredui]; name=[mttstartpushpag] registered")
end

--用于注册更新后UI
function RegisteredUiEx(selfObj)
 
end

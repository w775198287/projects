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
     local MainScenePag = require("texaspoker.game.mainscene.mainscenepag")
    selfObj.miUiRegList["mainscenepag"] = MainScenePag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[mainscenepag] registered")

    local MainMenuPag = require("texaspoker.game.mainmenu.mainmenupag")
    selfObj.miUiRegList["mainmenupag"] = MainMenuPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[mainmenupag] registered")

    local OperationnPag = require("texaspoker.game.operation.operationnpag")
    selfObj.miUiRegList["operationnpag"] = OperationnPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[operationnpag] registered")

    local OperationnResetPag = require("texaspoker.game.operation.operationnresetpag")
    selfObj.miUiRegList["operationnresetpag"] = OperationnResetPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[operationnresetpag] registered")

    local PromptPag = require("texaspoker.game.prompt.promptpag")
    selfObj.miUiRegList["promptpag"] = PromptPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[promptpag] registered")

    local BuyPag = require("texaspoker.game.buyin.buypag")
    selfObj.miUiRegList["buypag"] = BuyPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[buypag] registered")

    local SitDownBuyPag = require("texaspoker.game.buyin.sitdownbuypag")
    selfObj.miUiRegList["sitdownbuypag"] = SitDownBuyPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[sitdownbuypag] registered")

    local SitDownBuyShortDuckPag = require("texaspoker.game.buyin.sitdownbuyshortduckpag")
    selfObj.miUiRegList["sitdownbuyshortduckpag"] = SitDownBuyShortDuckPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[sitdownbuyshortduckpag] registered")

    -- 带出记分牌
    local CashOutPag = require("texaspoker.game.cashout.cashoutpag")
    selfObj.miUiRegList["cashoutpag"] = CashOutPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[cashoutpag] registered")

    local RealtimesituationmainPag = require("texaspoker.game.realtimesituation.realtimesituationmainpag")
    selfObj.miUiRegList["realtimesituationmainpag"] = RealtimesituationmainPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[realtimesituationmainpag] registered")

    local MatchstatisticsmainPag = require("texaspoker.game.matchstatistic.matchstatisticsmainpag")
    selfObj.miUiRegList["matchstatisticsmainpag"] = MatchstatisticsmainPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[matchstatisticsmainpag] registered")

    local FacePag = require("texaspoker.game.face.facepag")
    selfObj.miUiRegList["facepag"] = FacePag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[facepag] registered")

    local OtherInfoPag = require("texaspoker.game.otherinfo.otherinfopag")
    selfObj.miUiRegList["otherinfopag"] = OtherInfoPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[otherinfopag] registered")

    local CommonInputPag = require("texaspoker.game.otherinfo.commoninputpag")
    selfObj.miUiRegList["commoninputpag"] = CommonInputPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[commoninputpag] registered")

    --等待
    local WaitPag = require("texaspoker.game.tips.waitpag")
    selfObj.miUiRegList["waitpag"] = WaitPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[waitpag] registered")

    --高级设置
    local AdvancedSettingsPag = require("texaspoker.game.setting.settingpag")
    selfObj.miUiRegList["settingpag"] = AdvancedSettingsPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[settingpag] registered")

    local CheckPromptPag = require("texaspoker.game.tips.checkpromptpag")
    selfObj.miUiRegList["checkpromptpag"] = CheckPromptPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[checkpromptpag] registered")

    local GoToShopPag = require("texaspoker.game.error.gotoshoppag")
    selfObj.miUiRegList["gotoshoppag"] = GoToShopPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[gotoshoppag] registered")

    local ErrorPag = require("texaspoker.game.error.errorpag")
    selfObj.miUiRegList["errorpag"] = ErrorPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[errorpag] registered")

    local TimeTipsPag = require("texaspoker.game.tips.timetipspag")
    selfObj.miUiRegList["timetipspag"] = TimeTipsPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[timetipspag] registered")

--    local ReviewMainpPag = require("texaspoker.game.pokertextinfo.reviewmainpag")
--    selfObj.miUiRegList["reviewmainpag"] = ReviewMainpPag.Create
--    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[reviewmainpag] registered")

    local WeakTipsPag = require("texaspoker.game.tips.weaktipspag")
    selfObj.miUiRegList["weaktipspag"] = WeakTipsPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[weaktipspag] registered")

    local BuyinControlInviteTipsPag = require("texaspoker.game.tips.buyincontrolinvitetipspag")
    selfObj.miUiRegList["buyincontrolinvitetipspag"] = BuyinControlInviteTipsPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[buyincontrolinvitetipspag] registered")

    local PausePag = require("texaspoker.game.tips.pausepag")
    selfObj.miUiRegList["pausepag"] = PausePag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[pausepag] registered")

    local KickOutTipsPag = require("texaspoker.game.tips.kickouttipspag")
    selfObj.miUiRegList["kickouttipspag"] = KickOutTipsPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[kickouttipspag] registered")

    --SNG
    local SNGMainScenePag = require("texaspoker.game.mainscene.sngmainscenepag")
    selfObj.miUiRegList["sngmainscenepag"] = SNGMainScenePag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[sngmainscenepag] registered")

    local SNGMainMenuPag = require("texaspoker.game.mainmenu.sngmainmenupag")
    selfObj.miUiRegList["sngmainmenupag"] = SNGMainMenuPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[sngmainmenupag] registered")

    local SNGOperationnPag = require("texaspoker.game.sng.sngoperationnpag")
    selfObj.miUiRegList["sngoperationnpag"] = SNGOperationnPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[sngoperationnpag] registered")

    local SNGRulesdetailsPag = require("texaspoker.game.sng.sngrulesdetailspag")
    selfObj.miUiRegList["sngrulesdetailspag"] = SNGRulesdetailsPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[sngrulesdetailspag] registered")

    local SNGLeavePag = require("texaspoker.game.sng.sngleavepag")
    selfObj.miUiRegList["sngleavepag"] = SNGLeavePag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[sngleavepag] registered")

    local SNGRealtimesituationMainPag = require("texaspoker.game.sng.sngrealtimesituation.sngrealtimesituationmainpag")
    selfObj.miUiRegList["sngrealtimesituationmainpag"] = SNGRealtimesituationMainPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[sngrealtimesituationmainpag] registered")

    local SngFinishPag = require("texaspoker.game.sng.sngfinishpag")
    selfObj.miUiRegList["sngfinishpag"] = SngFinishPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[sngfinishpag] registered")

    local SngEliminatePag = require("texaspoker.game.sng.sngeliminatepag")
    selfObj.miUiRegList["sngeliminatepag"] = SngEliminatePag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[sngeliminatepag] registered")

    local SngControlBuyinMsgPag = require("texaspoker.game.sng.sngcontrolbuyinmsgpag")
    selfObj.miUiRegList["sngcontrolbuyinmsgpag"] = SngControlBuyinMsgPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[sngcontrolbuyinmsgpag] registered")

    -------------------------------------------------------------------------------------------
    -- -- 新保险
    -- local InsuranceInfoMainPag = require("texaspoker.game.insurance.insuranceinfomainpag")
    -- selfObj.miUiRegList["insuranceinfomainpag"] = InsuranceInfoMainPag.Create
    -- My_Lua_log("file=[uimgr] fun=[registeredui]; name=[insuranceinfomainpag] registered")

    -- local InsuranceBuyinPag = require("texaspoker.game.insurance.insurancebuyinpag")
    -- selfObj.miUiRegList["insurancebuyinpag"] = InsuranceBuyinPag.Create
    -- My_Lua_log("file=[uimgr] fun=[registeredui]; name=[insurancebuyinpag] registered")

    -- local InsuranceBuyinTipsPag = require("texaspoker.game.insurance.insurancebuyintipspag")
    -- selfObj.miUiRegList["insurancebuyintipspag"] = InsuranceBuyinTipsPag.Create
    -- My_Lua_log("file=[uimgr] fun=[registeredui]; name=[insurancebuyintipspag] registered")
-------------------------------------------------------------------------------------------
    --旧保险（2512）
    local InsuranceInfoMainPag = require("texaspoker.game.insuranceold.insuranceinfomainpag")
    selfObj.miUiRegList["insuranceinfomainpag"] = InsuranceInfoMainPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[insuranceinfomainpag] registered")

    local InsuranceBuyinPag = require("texaspoker.game.insuranceold.insurancebuyinpag")
    selfObj.miUiRegList["insurancebuyinpag"] = InsuranceBuyinPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[insurancebuyinpag] registered")

    local InsuranceBuyinTipsPag = require("texaspoker.game.insuranceold.insurancebuyintipspag")
    selfObj.miUiRegList["insurancebuyintipspag"] = InsuranceBuyinTipsPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[insurancebuyintipspag] registered")
-------------------------------------------------------------------------------------------

    local DismissTipsPag = require("texaspoker.game.tips.dismisstipspag")
    selfObj.miUiRegList["dismisstipspag"] = DismissTipsPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[dismisstipspag] registered")

    local MicroImagePag = require("texaspoker.game.microphone.microimagepag")
    selfObj.miUiRegList["microimagepag"] = MicroImagePag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[microimagepag] registered")

    local BuyunionPag = require("texaspoker.game.buyin.buyunionpag")
    selfObj.miUiRegList["buyunionpag"] = BuyunionPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[buyunionpag] registered")

    local SitdownbuyunionPag = require("texaspoker.game.buyin.sitdownbuyunionpag")
    selfObj.miUiRegList["sitdownbuyunionpag"] = SitdownbuyunionPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[sitdownbuyunionpag] registered")

    local SitdownbuyunionShortduckPag = require("texaspoker.game.buyin.sitdownbuyunionshortduckpag")
    selfObj.miUiRegList["sitdownbuyunionshortduckpag"] = SitdownbuyunionShortduckPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[sitdownbuyunionshortduckpag] registered")

    local OtherinfoselfPag = require("texaspoker.game.otherinfo.otherinfoselfpag")
    selfObj.miUiRegList["otherinfoselfpag"] = OtherinfoselfPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[otherinfoselfpag] registered")

    local Pokertextinfopag = require("texaspoker.game.pokertextinfo.pokertextinfopag")
    selfObj.miUiRegList["pokertextinfopag"] = Pokertextinfopag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[pokertextinfopag] registered")

    local PokertextinfoShortduckpag = require("texaspoker.game.pokertextinfo.pokertextinfoshortduckpag")
    selfObj.miUiRegList["pokertextinfoshortduckpag"] = PokertextinfoShortduckpag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[pokertextinfoshortduckpag] registered")

    local BulletScreenpag = require("texaspoker.game.bulletscreen.bulletscreenpag")
    selfObj.miUiRegList["bulletscreenpag"] = BulletScreenpag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[bulletscreenpag] registered")

    --mtt
    local MttRealtimesituationmainPag = require("texaspoker.game.mtt.mttrealtimesituation.mttrealtimesituationmainpag")
    selfObj.miUiRegList["mttrealtimesituationmainpag"] = MttRealtimesituationmainPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[mttrealtimesituationmainpag] registered")

    local MttfinishPag = require("texaspoker.game.mtt.mttfinishpag")
    selfObj.miUiRegList["mttfinishpag"] = MttfinishPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[mttfinishpag] registered")

    local MttwatchdeskfinishPag = require("texaspoker.game.mtt.mttwatchdeskfinishpag")
    selfObj.miUiRegList["mttwatchdeskfinishpag"] = MttwatchdeskfinishPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[mttwatchdeskfinishpag] registered")

    local MttwatchfinishPag = require("texaspoker.game.mtt.mttwatchfinishpag")
    selfObj.miUiRegList["mttwatchfinishpag"] = MttwatchfinishPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[mttwatchfinishpag] registered")

    local MttgameoverPag = require("texaspoker.game.mtt.mttgameoverpag")
    selfObj.miUiRegList["mttgameoverpag"] = MttgameoverPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[mttgameoverpag] registered")

    local MttoperationPag = require("texaspoker.game.mtt.mttoperationpag")
    selfObj.miUiRegList["mttoperationpag"] = MttoperationPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[mttoperationpag] registered")

    local MttexittipsPag = require("texaspoker.game.mtt.mttexittipspag")
    selfObj.miUiRegList["mttexittipspag"] = MttexittipsPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[mttexittipspag] registered")

    local MttstartpushPag = require("texaspoker.game.mtt.mttstartpushpag")
    selfObj.miUiRegList["mttstartpushpag"] = MttstartpushPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[mttstartpushpag] registered")

    local MttsignupPag = require("texaspoker.game.mtt.mttsignuppag")
    selfObj.miUiRegList["mttsignuppag"] = MttsignupPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[mttsignuppag] registered")

    local MttreentrytipsPag = require("texaspoker.game.mtt.mttreentrytipspag")
    selfObj.miUiRegList["mttreentrytipspag"] = MttreentrytipsPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[mttreentrytipspag] registered")

    local MttgobackPag = require("texaspoker.game.mtt.mttgobackpag")
    selfObj.miUiRegList["mttgobackpag"] = MttgobackPag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[mttgobackpag] registered")

    local MttmainscenePag = require("texaspoker.game.mainscene.mttmainscenepag")
    selfObj.miUiRegList["mttmainscenepag"] = MttmainscenePag.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[mttmainscenepag] registered")

end

--用于注册更新后UI
function RegisteredUiEx(selfObj)
 
end




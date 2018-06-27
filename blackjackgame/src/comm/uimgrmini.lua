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
    --通用ui
    -- local MainScenePag = require("texaspoker.game.mainscene.mainscenepag")
    -- selfObj.miUiRegList["mainscenepag"] = MainScenePag.Create
    -- My_Lua_log("file=[uimgrmini] fun=[registeredui]; name=[mainscenepag] registered")

    -- local GoToShopPag = require("texaspoker.game.error.gotoshoppag")
    -- selfObj.miUiRegList["gotoshoppag"] = GoToShopPag.Create
    -- My_Lua_log("file=[uimgrmini] fun=[registeredui]; name=[gotoshoppag] registered")

    -- local ErrorPag = require("texaspoker.game.error.errorpag")
    -- selfObj.miUiRegList["errorpag"] = ErrorPag.Create
    -- My_Lua_log("file=[uimgrmini] fun=[registeredui]; name=[errorpag] registered")

    -- 满座提示：牌局推送
    -- local MttstartpushPag = require("texaspoker.game.mtt.mttstartpushpag")
    -- selfObj.miUiRegList["mttstartpushpag"] = MttstartpushPag.Create
    -- My_Lua_log("file=[uimgrmini] fun=[registeredui]; name=[mttstartpushpag] registered")

    --小游戏UI
    local MiniGameInfoPag = require("minigame.pokermachine.game.minigameinfopag")
    selfObj.miUiRegList["minigameinfopag"] = MiniGameInfoPag.Create
    My_Lua_log("file=[uimgrmini] fun=[registeredui]; name=[minigameinfopag] registered")
    
    local minigamelist = require("minigame.minigamelist.game.minigamelist")
    selfObj.miUiRegList["minigamelist"] = minigamelist.Create
    My_Lua_log("file=[uimgrmini] fun=[registeredui]; name=[minigamelist] registered")

    local minigamelistcell = require("minigame.minigamelist.game.minigamelistcell")
    selfObj.miUiRegList["minigamelistcell"] = minigamelistcell.Create
    My_Lua_log("file=[uimgrmini] fun=[registeredui]; name=[minigamelistcell] registered")

    local caribbeangame = require("minigame.caribbean.game.caribbeangame")
    selfObj.miUiRegList["caribbeangame"] = caribbeangame.Create
    My_Lua_log("file=[uimgrmini] fun=[registeredui]; name=[caribbeangame] registered")

    local MiniGameMainScenePag = require("minigame.pokermachine.game.minigamemainscenepag")
    selfObj.miUiRegList["minigamemainscenepag"] = MiniGameMainScenePag.Create
    My_Lua_log("file=[uimgrmini] fun=[registeredui]; name=[minigamemainscenepag] registered")


    local nunugame = require("minigame.nunu.nunugame")
    selfObj.miUiRegList["nunugame"] = nunugame.Create
    My_Lua_log("file=[uimgrmini] fun=[registeredui]; name=[nunugame] registered")

    local ttgame = require("minigame.tt.ttgame")
    selfObj.miUiRegList["ttgame"] = ttgame.Create
    My_Lua_log("file=[uimgrmini] fun=[registeredui]; name=[ttgame] registered")

    local blackgamemainpag = require("minigame.blackgame.game.blackgamemainpag")
    selfObj.miUiRegList["blackgamemainpag"] = blackgamemainpag.Create
    My_Lua_log("file=[uimgrmini] fun=[registeredui]; name=[blackgamemainpag] registered")

    local blackgamemainpagnew = require("minigame.blackgame.game.system.blackgamemianpagnew")
    selfObj.miUiRegList["blackgamemainpagnew"] = blackgamemainpagnew.Create
    My_Lua_log("file=[uimgrmini] fun=[registeredui]; name=[blackgamemainpagnew] registered")
end

--用于注册更新后UI
function RegisteredUiEx(selfObj)
 
end

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
     local Allinoddsgame = require("winratecalculate.winratecalculate.allinoddsgame")
    selfObj.miUiRegList["allinoddsgame"] = Allinoddsgame.Create
    My_Lua_log("file=[uimgr] fun=[registeredui]; name=[allinoddsgame] registered")

end

--用于注册更新后UI
function RegisteredUiEx(selfObj)
 
end

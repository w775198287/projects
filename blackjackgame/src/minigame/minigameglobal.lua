module(...,package.seeall)

local Local_GIsCreate = false
local Local_MiniGameGlobalObj = {}

function Instance()
    if Local_GIsCreate == true then
        return Local_MiniGameGlobalObj
    end
    setmetatable( Local_MiniGameGlobalObj, { __index = _M } )
    Local_MiniGameGlobalObj:Init()
    Local_GIsCreate = true
    
    require "minigame.miniglobaldefine"

    return Local_MiniGameGlobalObj
end

function Init(selfObj)

    --现在加载节点
    selfObj.curNodePag = 'minigamelist'
    
    G_Fy:GetFyEvent():AddListen( PUBLIC_MSG_TYPE_ENUM.PUBLIC_MSG_TYPE_ENUM_NOTIFY_REFRESH_COIN, RefreshCoin, 5, selfObj)
end

function setCurNodPag( selfObj, sNodePag )
    selfObj.curNodePag = sNodePag
end

-- 获取小游戏的语言包
function GetMiniDefineConfig( selfObj, aiData  )
    -- My_Lua_log(" file=[minigameglobal] fun=[GetMiniDefineConfig];")

    local tConfigStr = nil
    if #aiData < 1 then
        return tConfigStr
    end
    local tLanguageFile = ""
    if G_Fy.GamegLobal:GetCurrentLanguage() == LANGUAGE_TYPE.G_LANGUAGE_ENGLISH then
        --英文
        tLanguageFile = aiData.celllanguagefile.enlanguagefile
    elseif G_Fy.GamegLobal:GetCurrentLanguage() == LANGUAGE_TYPE.G_LANGUAGE_CHINESE_CNS then
        --繁体中文
        tLanguageFile = aiData.celllanguagefile.cnslanguagefile
    elseif G_Fy.GamegLobal:GetCurrentLanguage() == LANGUAGE_TYPE.G_LANGUAGE_JAPANESE then
        --日文
        tLanguageFile = aiData.celllanguagefile.jblanguagefile
    else
        --简体中文
        tLanguageFile = aiData.celllanguagefile.cnlanguagefile
    end
    -- My_Lua_log(" tLanguageFile = "..tLanguageFile)
    local tTageFile = require(tLanguageFile)
    if tTageFile ~= nil then
        for i = 1, #aiData do
            if tTageFile == nil then
                break
            end
            tConfigStr = tTageFile[aiData[i]]
            tTageFile = tConfigStr            
        end
    end
    -- My_Lua_log(" file=[minigameglobal] fun=[GetMiniDefineConfig]; 222.."..aiData[1])
    -- if tConfigStr == nil then
    --     tTageFile = require(tLanguageFile)
    --     for i = 1, #aiData do
    --         if tTageFile == nil then
    --             break
    --         end 
    --         tConfigStr = tTageFile[aiData[i]]
    --         tTageFile = tConfigStr
    --     end
    -- end
    return tConfigStr
end

-- GetMiniDefineConfigByArgs
function GetMiniConfig(selfObj, aiNameOne, aiNameTwo, aiNameThree)
    -- My_Lua_log(" file=[minigameglobal] fun=[GetMiniDefineConfigByArgs]; "..aiNameOne)

    local aiData = {}
    if aiNameOne == nil then
        return
    else
        table.insert(aiData,aiNameOne)
        if aiNameTwo ~= nil then
            table.insert(aiData,aiNameTwo)
            if aiNameThree ~= nil then
                table.insert(aiData,aiNameThree)
            end
        end
    end

    for i = 1, #MI_GAME_LIST do
        if selfObj.curNodePag == MI_GAME_LIST[i].cellgame then
            aiData.celllanguagefile = MI_GAME_LIST[i].celllanguagefile
            break
        end
    end

    for key, var in pairs(aiData) do
        -- My_Lua_log(" file=[minigameglobal] fun=[GetMiniDefineConfigByArgs]; key="..key)
        -- My_Lua_log("type(key) = "..type(var))
    --     if type(var) == "table" then
    --         for k, v in pairs(var) do
    --             My_Lua_log(" file=[minigameglobal] fun=[GetMiniDefineConfigByArgs]; k="..k)
    --             My_Lua_log(" file=[minigameglobal] fun=[GetMiniDefineConfigByArgs]; v="..v)
    --         end
    --     else
    --         My_Lua_log(" file=[minigameglobal] fun=[GetMiniDefineConfigByArgs]; var="..var)
    --     end
    end    

    return selfObj:GetMiniDefineConfig(aiData)
end

function RefreshCoin( selfObj, aiEvent )
    My_Lua_log(" file=[minigameglobal] fun=[RefreshCoin]; ")
    local aiAudioEvent = {}
    aiAudioEvent.type = MSG_MINI_PUBLIC_ENUM.MSG_TYPE_ENUM_MINIGAME_REFRESH_COIN
    aiAudioEvent.miData = {}
    aiAudioEvent.miData.lCurCoin = aiEvent.miData.lCurCoin
    G_Fy:SendEventToAllGameDesk(aiAudioEvent)
end

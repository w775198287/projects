--region *.lua
--Date
--此文件由[BabeLua]插件自动生成


--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

module(...,package.seeall)

function Create(aiData)
    local selfObj = {}
    setmetatable( selfObj, { __index = _M } )
    selfObj:Init(aiData)
    return selfObj
end

function Init(selfObj, aiData)
    selfObj.miUuid = 1
end

function SetUuid(selfObj, aiUuid)
    selfObj.miUuid = aiUuid
end

function GetUuid(selfObj)
    return selfObj.miUuid
end


function GetDelayFoldData(selfObj)
    return nil
end

--退出牌局需要做操作
function OnExit(selfObj)

end

---
-- guid工具
-- @module GuidUtils
module(...,package.seeall)

local Local_GIsCreate = false
local Local_GuidUtilsObj = {}

function Instance()
	if Local_GIsCreate == true then
		return Local_GuidUtilsObj
	end
	setmetatable( Local_GuidUtilsObj, { __index = _M } )
	Local_GuidUtilsObj.miClock = os.time()
    Local_GuidUtilsObj.miNum = 0
	Local_GIsCreate = true
	return Local_GuidUtilsObj
end

---
-- 获取一个Guid
-- @function [parent=#GuidUtils] getGuid
-- @param self
-- @return #string ret
function GetGuid( selfObj )
    local tClock = os.time()
    if tClock == selfObj.miClock then
        selfObj.miNum = selfObj.miNum + 1
    else
        selfObj.miNum = 0
    end
    selfObj.miClock = tClock
    local str = string.format("%f_%d", selfObj.miClock, selfObj.miNum)
    return str
end


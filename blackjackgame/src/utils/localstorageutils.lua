--region LocalStorageUtils.lua
--Author : zsy
--Date   : 2015/8/27
--此文件由[BabeLua]插件自动生成
---具体使用方式 K,value(table or object)
local LocalStorageUtils = {}

function LocalStorageUtils:init()
	if self._data == nil then
        local jsonStr = zsy.Storage.read()
        if string.len(jsonStr) == 0 then
            jsonStr = "{}"
        end
        self._data = json.decode(jsonStr) or {}
	end
end

function LocalStorageUtils:get(key)
    self:init()
    return self._data[key]
end

function LocalStorageUtils:set(key, value)
    self:init()
    self._data[key] = value
    local saveStr = json.encode(self._data)
    zsy.Storage.save(saveStr)
end

return LocalStorageUtils

--region TableUtils.lua
--Author : zsy
--Date   : 2015/8/27
--此文件由[BabeLua]插件自动生成
local TableUtils = {}

---
-- 遍历
-- @function [parent=#TableUtils] traversal
-- @param self
-- @param #table t
-- @param #int dep
-- @param #function func
function TableUtils:traversal(t, dep, func)
    if type(t) ~= "table" then
        return
    end
    dep = dep - 1
    for key, var in pairs(t) do
        if dep <= 0 then
            func(key, var)
        else
            TableUtils:traversal(var, dep, function(...)
                func(key, ...)
            end)
        end
    end
end

-- 反向索引使用的metatable
local reverseIndexMT = {
    __index = function(t, k)
        return t.__data[k]
    end,
    __newindex = function(t, k, v)
        t.getReverseIndex[t.__data[k]] = nil
        if v ~= nil then
            t.getReverseIndex[v] = k
        end
        t.__data[k] = v
    end
}


function TableUtils:makeReverseIndex(o)
    local reverse = {}
    local proxy = {
        __data = o,
        getReverseIndex = function() return reverse end
    }
    setmetatable(proxy, reverseIndexMT)
    for key, var in pairs(o) do
        reverse[var] = key
    end
    return proxy
end


function TableUtils:sortTableKeys(o)
    local newo = {}
    
    local keys = {}
    for k,v in pairs(o) do
        table.insert(keys, k)
    end
    table.sort(keys)
    
    local i = 0
    for k,v in function()
        i = i + 1
        return keys[i], o[keys[i]]
    end do
        if type(v) == "table" then
            newo[k] = TableUtils:sortTableKeys(v)
        else
            newo[k] = v
        end
    end
    
    return newo
end

function TableUtils:makeTableNoticeOnChange(o, onChange)
    local proxy = {__data = o, __type = "TableUtils:makeTableNoticeOnChange"}
    setmetatable(proxy, {
        __index = function(t, k)
            if o[k] and type(o[k]) == "table" then
               return self:makeTableNoticeOnChange(o[k], onChange)
            end
            return o[k]
        end,
        __newindex = function (t,k,v)
            if v and type(v) == "table" and v.__type == proxy.__type then
                if v.__data == o[k] then return end
                o[k] = v.__data
            else
                if o[k] == v then return end
                o[k] = v
            end
            onChange()
        end
    })
    return proxy
end


function TableUtils:pairsNoticeTable(o)
    local keys = {}
    for k,v in pairs(o.__data) do
--        k = tonumber(k)
        table.insert(keys, k)
    end
    table.sort(keys)
    
    local i = 0
    return function()
        i = i + 1
        return keys[i], o[keys[i]]
    end
end

function TableUtils:plusTable(source, add)
    for key, var in pairs(add) do
        local addv = tonumber(var, 10)
        if addv or addv ~= 0 then
            local sourcev = tonumber(source[key], 10)
            if sourcev then
                source[key] = sourcev + addv
            else
                source[key] = addv
            end
        end
    end
end

function TableUtils:ratioTable(source, ratio)
    local ret = {}
    for key, var in pairs(source) do
        local nv = tonumber(var, 10)
        if nv and nv ~= 0 then
            ret[key] = math.floor(nv * ratio)
        end
    end
    return ret
end

function TableUtils:compareTable(a, b, aNoFunc,bNoFunc,difValue)
    dep = dep or ""
    local ret = true
    for k, v in pairs(a) do
        if not b[k] then
            ret = false
            My_Lua_log("table B do not has key : %s, A[%s] = %s", dep..":"..k, dep..":"..k, tostring(v))
            if bNoFunc then bNoFunc(k,v) end
        elseif type(v) == "table" then
            if type(b[k]) == "table" then
                ret = TableUtils:compareTable(v, b[k], aNoFunc,bNoFunc,difValue) and ret
            else
                ret = false
                My_Lua_log("table has different value type, key = %s, A : %s, B : %s", dep..":"..k, tostring(v), tostring(b[k]))
                if difValue then difValue(k,va,vb) end
            end
        elseif v ~= b[k] then
            ret = false
            My_Lua_log("table has different value, key = %s, A : %s, B : %s", dep..":"..k, tostring(v), tostring(b[k]))
            if difValue then difValue(k,va,vb) end
        end
    end
    for k, v in pairs(b) do
        if not a[k] then
            ret = false
            My_Lua_log("table A do not has key : %s, B[%s] = %s", dep..":"..k, dep..":"..k, tostring(v))
            if aNoFunc then aNoFunc(k,v) end
            My_Lua_log("---");
        end
    end
    return ret
end

--深度遍历一个table
function TableUtils:ergodic(tbl,callBack)
    local param_type = type(tbl)
    if param_type == "table" then
        for k, v in pairs(tbl) do
            -- 如果value还是一个table，则递归打印其内容
            if (type(v) == "table") then
                TableUtils:ergodic (v)
            else 
                if callBack then callBack(v) end
            end
        end
    end
end


function TableUtils:deepcopy(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end


return TableUtils

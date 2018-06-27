
cc.FileUtils:getInstance():setPopupNotify(false)
G_WRITEABLE_PATH = cc.FileUtils:getInstance():getWritablePath()


function IsExistsFile(path)
    local file = io.open(path, "r")
    if file then
        io.close(file)
        return true
    end
    return false
end  

require "src.versionInfo.version.lua"
GPackageVersion = Version
local tAppPackageVersion = Version
print("tAppPackageVersion ============= " .. tAppPackageVersion)
local tUpdatePackageVersion = "0"
if IsExistsFile(G_WRITEABLE_PATH.."updatefile.lua") == true then
    dofile(G_WRITEABLE_PATH.."/src/versionInfo/version.lua");
    tUpdatePackageVersion = Version
    print("tUpdatePackageVersion ============= " .. tUpdatePackageVersion)
end

if tUpdatePackageVersion == nil then
    cc.FileUtils:getInstance():addSearchPath("src/")
    cc.FileUtils:getInstance():addSearchPath("res/")
    cc.FileUtils:getInstance():addSearchPath("res/nunu")
    cc.FileUtils:getInstance():addSearchPath("res/tt")
    cc.FileUtils:getInstance():addSearchPath("src/uilua/")
    cc.FileUtils:getInstance():addSearchPath("src/proto/")
    cc.FileUtils:getInstance():addSearchPath(G_WRITEABLE_PATH)

    cc.FileUtils:getInstance():removeDirectory(G_WRITEABLE_PATH.."src/")
    cc.FileUtils:getInstance():removeDirectory(G_WRITEABLE_PATH.."res/")
    cc.FileUtils:getInstance():removeFile(G_WRITEABLE_PATH.."updatefile.lua")
    print("tUpdatePackageVersion ============= 11111111111111111111")
else
    if tonumber(tUpdatePackageVersion) <= tonumber(tAppPackageVersion) then
        cc.FileUtils:getInstance():addSearchPath("src/")
        cc.FileUtils:getInstance():addSearchPath("res/")
        cc.FileUtils:getInstance():addSearchPath("res/nunu")
        cc.FileUtils:getInstance():addSearchPath("res/tt")
        cc.FileUtils:getInstance():addSearchPath("src/uilua/")
        cc.FileUtils:getInstance():addSearchPath("src/proto/")
        cc.FileUtils:getInstance():addSearchPath(G_WRITEABLE_PATH)

        cc.FileUtils:getInstance():removeDirectory(G_WRITEABLE_PATH.."src/")
        cc.FileUtils:getInstance():removeDirectory(G_WRITEABLE_PATH.."res/")
        cc.FileUtils:getInstance():removeFile(G_WRITEABLE_PATH.."updatefile.lua")

        print("tUpdatePackageVersion ============= 3333333333333333")
    else
        cc.FileUtils:getInstance():addSearchPath(G_WRITEABLE_PATH)
        cc.FileUtils:getInstance():addSearchPath(G_WRITEABLE_PATH.."/src/")
        cc.FileUtils:getInstance():addSearchPath(G_WRITEABLE_PATH.."/res/")
        cc.FileUtils:getInstance():addSearchPath(G_WRITEABLE_PATH.."/res/nunu")
        cc.FileUtils:getInstance():addSearchPath(G_WRITEABLE_PATH.."/res/tt")
        cc.FileUtils:getInstance():addSearchPath(G_WRITEABLE_PATH .. "/src/uilua/")
        cc.FileUtils:getInstance():addSearchPath(G_WRITEABLE_PATH.."/src/proto/")
        cc.FileUtils:getInstance():addSearchPath("src/")
        cc.FileUtils:getInstance():addSearchPath("res/")
        cc.FileUtils:getInstance():addSearchPath("res/nunu")
        cc.FileUtils:getInstance():addSearchPath("res/tt")
        cc.FileUtils:getInstance():addSearchPath("src/uilua/")
        cc.FileUtils:getInstance():addSearchPath("src/proto/")
        GPackageVersion = tUpdatePackageVersion
        print("tUpdatePackageVersion ============= 2222222222222222222")
    end
end

require "cocos.cocos2d.functions"
require "globaldefine"


require "cocos.init"

G_Fy = require("fy")
json = require "json"

My_Lua_log = function(...)
    --print(string.format(...))

    --安卓分段打印日志
    local app = cc.Application:getInstance()
    local target = app:getTargetPlatform()
    if target == cc.PLATFORM_OS_ANDROID then

        local tAllLog = string.format(...)
        local tAllLogLen = string.len(tAllLog)
        local tEachLong = 500    
        local tEndIndex = 0
        local tStartIndex = 0        
        local tLongCount = 0        
        while tAllLogLen - tEndIndex > 0 do
              
            if tAllLogLen - tEndIndex >= tEachLong then
                if tLongCount >= tEachLong then
                    print(string.sub(tAllLog, tStartIndex+1, tEndIndex ))
                    tLongCount = 0
                    tStartIndex = tEndIndex
                end
            else
                print(string.sub(tAllLog, tEndIndex, tAllLogLen ))
                break
            end
              tEndIndex = tEndIndex + 1
              tLongCount = tLongCount + 1
        end
    else
        print(string.format(...))
    end
end

function RevProtocol(aiStr)
    require("TexasPokerCommon_pb")
    local msg = TexasPokerCommon_pb.Package()
    msg:ParseFromString(aiStr) 
    local kkk = msg.uuid
    My_Lua_log("*************---------" .. msg.uuid)
end

local function main()
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)
	collectgarbage("collect")
	math.randomseed(os.time())

    G_Fy:Init()
    G_Fy:Start()
    local function OnRun( aiDelTime )
        G_Fy:Run(aiDelTime)
    end


    cc.Director:getInstance():getScheduler():scheduleScriptFunc(OnRun, 0, false)
end

--重构
--要把player提出来做成数组
--要把房间ID提出来做 做数组为多个房间做准备
--把房间状态提出来做成状态机类
--把事件通知提出来做在一个函数里，通过子类型来做
--把初始化提出来做初始化函数
--把表情系统提出来（收费道具的表情）
--把一些零时变量提出来做处理

--把断网在进入  和  切后台 最好做成切换场景
--数据就可以全部重新刷新

--BUG处理
--查看热更新内容，sng内容
--要把所有的数据抽象出来做成数组来处理多数据  不同牌局类型问题

function __G__TRACKBACK__(msg)

    My_Lua_log("----------------------------------------")
    My_Lua_log("LUA ERROR: " .. tostring(msg) .. "\n")
    My_Lua_log(debug.traceback())
    My_Lua_log("----------------------------------------")

--    local tProtoCmd = "proto cmd = 0\n"
--    if _G["proto_cmd"] > 0 then
--        tProtoCmd = "LUA ERROR: proto cmd = ".._G["proto_cmd"].."\n"
--        msg = msg..tProtoCmd
--    end
    cc.Director:getInstance():pause()
    local GameMain = require("hallscene.game")
    GameMain.Instance():CreateLuaErrorNode(tostring(msg) .."||".. tostring(debug.traceback()))
end

xpcall(main, __G__TRACKBACK__)

--------------------------------------------------------------
-- This file was automatically generated by Cocos Studio.
-- Do not make changes to this file.
-- All changes will be lost.
--------------------------------------------------------------

local luaExtend = require "LuaExtend"

-- using for layout to decrease count of local variables
local layout = nil
local localLuaFile = nil
local innerCSD = nil
local innerProject = nil
local localFrame = nil

local Result = {}
------------------------------------------------------------
-- function call description
-- create function caller should provide a function to 
-- get a callback function in creating scene process.
-- the returned callback function will be registered to 
-- the callback event of the control.
-- the function provider is as below :
-- Callback callBackProvider(luaFileName, node, callbackName)
-- parameter description:
-- luaFileName  : a string, lua file name
-- node         : a Node, event source
-- callbackName : a string, callback function name
-- the return value is a callback function
------------------------------------------------------------
function Result.create(callBackProvider)

local result={}
setmetatable(result, luaExtend)

--Create Scene
local Scene=cc.Node:create()
Scene:setName("Scene")

--Create pagedeskview
local pagedeskview = ccui.PageView:create()
pagedeskview:ignoreContentAdaptWithSize(false)
pagedeskview:setBackGroundColorOpacity(102)
pagedeskview:setLayoutComponentEnabled(true)
pagedeskview:setName("pagedeskview")
pagedeskview:setTag(154)
pagedeskview:setCascadeColorEnabled(true)
pagedeskview:setCascadeOpacityEnabled(true)
pagedeskview:setPosition(0.0000, 0.0000)
if callBackProvider~=nil then
      pagedeskview:addEventListener(callBackProvider("multideskscene.lua", pagedeskview, "OnPageDeskViewEvent"))
end
layout = ccui.LayoutComponent:bindLayoutComponent(pagedeskview)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(1242.0000, 2208.0000))
layout:setLeftMargin(0.0000)
layout:setRightMargin(0.0000)
layout:setTopMargin(0.0000)
layout:setBottomMargin(0.0000)
Scene:addChild(pagedeskview)

--Create listdeskhandcardview
local listdeskhandcardview = ccui.ListView:create()
listdeskhandcardview:setDirection(2)
listdeskhandcardview:setGravity(3)
listdeskhandcardview:ignoreContentAdaptWithSize(false)
listdeskhandcardview:setBackGroundImage("game/game_layer/common/multidesk/line.png",0)
listdeskhandcardview:setBackGroundImageCapInsets(cc.rect(0,0,0,0))
listdeskhandcardview:setBackGroundColorOpacity(102)
listdeskhandcardview:setBackGroundImageScale9Enabled(true)
listdeskhandcardview:setLayoutComponentEnabled(true)
listdeskhandcardview:setName("listdeskhandcardview")
listdeskhandcardview:setTag(211)
listdeskhandcardview:setCascadeColorEnabled(true)
listdeskhandcardview:setCascadeOpacityEnabled(true)
listdeskhandcardview:setPosition(1.3736, 2036.7750)
layout = ccui.LayoutComponent:bindLayoutComponent(listdeskhandcardview)
layout:setPositionPercentX(0.0011)
layout:setPositionPercentY(0.9225)
layout:setPercentWidth(1.0000)
layout:setPercentHeight(0.0770)
layout:setSize(cc.size(1242.0000, 170.0000))
layout:setLeftMargin(1.3736)
layout:setRightMargin(-1.3737)
layout:setTopMargin(1.2251)
layout:setBottomMargin(2036.7750)
Scene:addChild(listdeskhandcardview)

--Create Animation
result['animation'] = ccs.ActionTimeline:create()
  
result['animation']:setDuration(0)
result['animation']:setTimeSpeed(1.0000)
--Create Animation List

result['root'] = Scene
return result;
end

return Result


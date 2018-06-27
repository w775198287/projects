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

--Create Node


--Create bg
local bg = ccui.ImageView:create()
bg:ignoreContentAdaptWithSize(false)
bg:loadTexture("Default/ImageFile.png",0)
bg:setLayoutComponentEnabled(true)
bg:setName("bg")
bg:setTag(11)
bg:setCascadeColorEnabled(true)
bg:setCascadeOpacityEnabled(true)
bg:setPosition(0.0000, 0.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(bg)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(1180.0000, 446.0000))
layout:setLeftMargin(-590.0000)
layout:setRightMargin(-590.0000)
layout:setTopMargin(-223.0000)
layout:setBottomMargin(-223.0000)
local Node=bg
Node:setName("Node")

--Create itembg
local itembg = ccui.ImageView:create()
itembg:ignoreContentAdaptWithSize(false)
itembg:loadTexture("minigame/minigamelist/caribbean.png",0)
itembg:setTouchEnabled(true);
itembg:setLayoutComponentEnabled(true)
itembg:setName("itembg")
itembg:setTag(25)
itembg:setCascadeColorEnabled(true)
itembg:setCascadeOpacityEnabled(true)
itembg:setPosition(590.0000, 223.0000)
if callBackProvider~=nil then
      itembg:addTouchEventListener(callBackProvider("minigamelistcell.lua", itembg, "OnItemButton"))
end
layout = ccui.LayoutComponent:bindLayoutComponent(itembg)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.5000)
layout:setPercentWidthEnabled(true)
layout:setPercentHeightEnabled(true)
layout:setPercentWidth(1.0000)
layout:setPercentHeight(1.0000)
layout:setSize(cc.size(1180.0000, 446.0000))
layout:setHorizontalEdge(3)
layout:setVerticalEdge(3)
layout:setLeftMargin(0.0000)
layout:setRightMargin(0.0000)
layout:setTopMargin(0.0000)
layout:setBottomMargin(0.0000)
bg:addChild(itembg)

--Create Animation
result['animation'] = ccs.ActionTimeline:create()
  
result['animation']:setDuration(0)
result['animation']:setTimeSpeed(1.0000)
--Create Animation List

result['root'] = Node
return result;
end

return Result

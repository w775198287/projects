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
local Node=cc.Node:create()
Node:setName("Node")

--Create ScrollView
local ScrollView = ccui.ScrollView:create()
ScrollView:setBounceEnabled(true)
ScrollView:setInnerContainerSize(cc.size(1242,2928))
ScrollView:ignoreContentAdaptWithSize(false)
ScrollView:setClippingEnabled(true)
ScrollView:setBackGroundColorOpacity(102)
ScrollView:setLayoutComponentEnabled(true)
ScrollView:setName("ScrollView")
ScrollView:setTag(147)
ScrollView:setCascadeColorEnabled(true)
ScrollView:setCascadeOpacityEnabled(true)
ScrollView:setAnchorPoint(0.0000, 1.0000)
ScrollView:setPosition(0.0000, 0.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(ScrollView)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(1242.0000, 2208.0000))
layout:setLeftMargin(0.0000)
layout:setRightMargin(-1242.0000)
layout:setTopMargin(0.0000)
layout:setBottomMargin(-2208.0000)
Node:addChild(ScrollView)

--Create Image_2
local Image_2 = ccui.ImageView:create()
Image_2:ignoreContentAdaptWithSize(false)
Image_2:loadTexture("minigame/pokermachine/award/i6p/minigame_help@3x.jpg",0)
Image_2:setLayoutComponentEnabled(true)
Image_2:setName("Image_2")
Image_2:setTag(148)
Image_2:setCascadeColorEnabled(true)
Image_2:setCascadeOpacityEnabled(true)
Image_2:setAnchorPoint(0.0000, 1.0000)
Image_2:setPosition(0.6500, 2927.2680)
layout = ccui.LayoutComponent:bindLayoutComponent(Image_2)
layout:setPositionPercentX(0.0005)
layout:setPositionPercentY(0.9997)
layout:setPercentWidth(1.0000)
layout:setPercentHeight(1.3261)
layout:setSize(cc.size(1242.0000, 2928.0000))
layout:setLeftMargin(0.6500)
layout:setRightMargin(-0.6500)
layout:setTopMargin(0.7324)
layout:setBottomMargin(-0.7324)
ScrollView:addChild(Image_2)

--Create closebutton
local closebutton = ccui.Button:create()
closebutton:ignoreContentAdaptWithSize(false)
closebutton:loadTextureNormal("minigame/pokermachine/award/i6p/award_back@3x.png",0)
closebutton:loadTexturePressed("minigame/pokermachine/award/i6p/award_back_pressed@3x.png",0)
closebutton:loadTextureDisabled("minigame/pokermachine/Default/Button_Disable.png",0)
closebutton:setTitleFontSize(14)
closebutton:setTitleColor(cc.c3b(65, 65, 70))
closebutton:setScale9Enabled(true)
closebutton:setCapInsets(cc.rect(15,11,162,78))
closebutton:setLayoutComponentEnabled(true)
closebutton:setName("closebutton")
closebutton:setTag(149)
closebutton:setCascadeColorEnabled(true)
closebutton:setCascadeOpacityEnabled(true)
closebutton:setPosition(99.5222, -53.9108)
if callBackProvider~=nil then
      closebutton:addClickEventListener(callBackProvider("englishminigameinfonode.lua", closebutton, "OnCloseButton"))
end
layout = ccui.LayoutComponent:bindLayoutComponent(closebutton)
layout:setPositionPercentX(0.0000)
layout:setPositionPercentY(0.0000)
layout:setSize(cc.size(192.0000, 100.0000))
layout:setLeftMargin(3.5222)
layout:setRightMargin(-195.5222)
layout:setTopMargin(3.9108)
layout:setBottomMargin(-103.9108)
Node:addChild(closebutton)

--Create Animation
result['animation'] = ccs.ActionTimeline:create()
  
result['animation']:setDuration(0)
result['animation']:setTimeSpeed(1.0000)
--Create Animation List

result['root'] = Node
return result;
end

return Result


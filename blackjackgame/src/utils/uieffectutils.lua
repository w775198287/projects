--region uieffectutils.lua
--Author : zsy
--Date   : 2015/8/31
--此文件由[BabeLua]插件自动生成

local uieffectutils = {}


function uieffectutils.runPopOutLayerEffect(targetLayer, pCallback)
    local targetScale = targetLayer:getScale()
    targetLayer:setScale(0.01)
    -- local shackTime = 0.15
    local shackAction1 = cc.ScaleTo:create(0.1,targetScale,targetScale*1.26)
    local shackAction2 = cc.ScaleTo:create(0.08,targetScale*1.28,targetScale)
    local shackAction3 = cc.ScaleTo:create(0.08,targetScale,targetScale)
    local shackAction4 = cc.ScaleTo:create(0.08,targetScale*1.06,targetScale*1.05)
    local shackAction5 = cc.ScaleTo:create(0.06,targetScale,targetScale)
    
    local shackAction6 = nil
    if pCallback then
        shackAction6 = cc.CallFunc:create(pCallback)
    end
    local buttonEffect = nil
    if shackAction6 then
        buttonEffect = cc.Sequence:create(shackAction1,shackAction2,shackAction3,shackAction4, shackAction5,shackAction6)
    else
        buttonEffect = cc.Sequence:create(shackAction1,shackAction2,shackAction3,shackAction4,shackAction5)
    end

    targetLayer:runAction(buttonEffect)
end

function uieffectutils.runButtonEffect( targetButton )
    local targetScale = targetButton:getScale()
    local shackTime = 0.12
    local maxChangeRate = 0.1
    local shackAction1 = cc.ScaleTo:create(shackTime/2,targetScale-maxChangeRate,targetScale+maxChangeRate)
    local shackAction2 = cc.ScaleTo:create(shackTime,targetScale+maxChangeRate,targetScale-maxChangeRate)
    local shackAction3 = cc.ScaleTo:create(shackTime,targetScale-maxChangeRate*0.75,targetScale+maxChangeRate*0.75)
    local shackAction4 = cc.ScaleTo:create(shackTime,targetScale+maxChangeRate*0.5,targetScale-maxChangeRate*0.5)
    local shackAction5 = cc.ScaleTo:create(shackTime,targetScale-maxChangeRate*0.5,targetScale+maxChangeRate*0.5)
    local shackAction6 = cc.ScaleTo:create(shackTime,targetScale+maxChangeRate*0.25,targetScale-maxChangeRate*0.25)
    local shackAction7 = cc.ScaleTo:create(shackTime,targetScale,targetScale)
    local buttonEffect = cc.Sequence:create(shackAction1,shackAction2,shackAction3
        ,shackAction4,shackAction5,shackAction6,shackAction7,cc.DelayTime:create(3),cc.CallFunc:create(UIEffect.runButtonEffect))

    targetButton:runAction(buttonEffect)
end

function uieffectutils.runPopOutLayerEffect1(targetLayer, pCallback)
    local targetScale = targetLayer:getScale()
    targetLayer:setScale(0.01)
    -- local shackTime = 0.15
    local shackAction1 = cc.ScaleTo:create(0.15,targetScale*1.1)
    local shackAction2 = cc.ScaleTo:create(0.1,targetScale*0.9)
    local shackAction3 = cc.ScaleTo:create(0.1,targetScale)

    local callback = nil
    if pCallback then
        callback = cc.CallFunc:create(pCallback)
    end
    local buttonEffect = nil
    if callback then
        buttonEffect = cc.Sequence:create(shackAction1,shackAction2,shackAction3,callback)
    else
        buttonEffect = cc.Sequence:create(shackAction1,shackAction2,shackAction3)
    end

    targetLayer:runAction(buttonEffect)
end

function uieffectutils.runButtonEffect1(targetButton, pCallback)
    local targetScale = targetButton:getScale()
    targetButton:setScale(0.01)
    -- local shackTime = 0.15
    local shackAction1 = cc.ScaleTo:create(0.12,targetScale*1.1)
    local shackAction2 = cc.ScaleTo:create(0.1,targetScale*0.9)
    local shackAction3 = cc.ScaleTo:create(0.1,targetScale)

    local callback = nil
    if pCallback then
        callback = cc.CallFunc:create(pCallback)
    end
    local buttonEffect = nil
    if callback then
        buttonEffect = cc.Sequence:create(shackAction1,shackAction2,shackAction3,callback)
    else
        buttonEffect = cc.Sequence:create(shackAction1,shackAction2,shackAction3)
    end

    targetButton:runAction(buttonEffect)
end

function uieffectutils.runButtonEffect2( targetButton) 
    local shackTime = 0.12
    local maxChangeRate = 0.1
    local shackAction1 = cc.ScaleTo:create(shackTime/2,(1-maxChangeRate) * g_fMaxScaleRatio,(1+maxChangeRate) * g_fMaxScaleRatio)
    local shackAction2 = cc.ScaleTo:create(shackTime,(1+maxChangeRate) * g_fMaxScaleRatio,(1-maxChangeRate) * g_fMaxScaleRatio)
    local shackAction3 = cc.ScaleTo:create(shackTime,(1-maxChangeRate*0.75) * g_fMaxScaleRatio,(1+maxChangeRate*0.75) * g_fMaxScaleRatio)
    local shackAction4 = cc.ScaleTo:create(shackTime,(1+maxChangeRate*0.5) * g_fMaxScaleRatio,(1-maxChangeRate*0.5) * g_fMaxScaleRatio)
    local shackAction5 = cc.ScaleTo:create(shackTime,(1-maxChangeRate*0.5) * g_fMaxScaleRatio,(1+maxChangeRate*0.5) * g_fMaxScaleRatio)
    local shackAction6 = cc.ScaleTo:create(shackTime,(1+maxChangeRate*0.25) * g_fMaxScaleRatio,(1-maxChangeRate*0.25) * g_fMaxScaleRatio) 
    local shackAction7 = cc.ScaleTo:create(shackTime,g_fMaxScaleRatio,g_fMaxScaleRatio)
    local buttonEffect = cc.Sequence:create(shackAction1,shackAction2,shackAction3
        ,shackAction4,shackAction5,shackAction6,shackAction7,cc.DelayTime:create(3),cc.CallFunc:create(UIEffect.runButtonEffect2))

    targetButton:runAction(buttonEffect)
end

function uieffectutils.runButtonEffect3( targetButton )
    local shackTime = 0.12
    local maxChangeRate = 0.1
    local shackAction1 = cc.ScaleTo:create(shackTime/2,(1-maxChangeRate) * g_fMaxScaleRatio,(1+maxChangeRate) * g_fMaxScaleRatio)
    local shackAction2 = cc.ScaleTo:create(shackTime,(1+maxChangeRate) * g_fMaxScaleRatio,(1-maxChangeRate) * g_fMaxScaleRatio)
    local shackAction3 = cc.ScaleTo:create(shackTime,(1-maxChangeRate*0.75) * g_fMaxScaleRatio,(1+maxChangeRate*0.75) * g_fMaxScaleRatio)
    local shackAction4 = cc.ScaleTo:create(shackTime,(1+maxChangeRate*0.5) * g_fMaxScaleRatio,(1-maxChangeRate*0.5) * g_fMaxScaleRatio)
    local shackAction5 = cc.ScaleTo:create(shackTime,(1-maxChangeRate*0.5) * g_fMaxScaleRatio,(1+maxChangeRate*0.5) * g_fMaxScaleRatio)
    local shackAction6 = cc.ScaleTo:create(shackTime,(1+maxChangeRate*0.25) * g_fMaxScaleRatio,(1-maxChangeRate*0.25) * g_fMaxScaleRatio)
    local shackAction7 = cc.ScaleTo:create(shackTime,g_fMaxScaleRatio,g_fMaxScaleRatio)
    local buttonEffect = cc.Sequence:create(shackAction1,shackAction2,shackAction3
        ,shackAction4,shackAction5,shackAction6,shackAction7,cc.DelayTime:create(3),cc.CallFunc:create(UIEffect.runButtonEffect3))

    targetButton:runAction(buttonEffect)
end

function uieffectutils.runButtonEffect4( targetButton )
    local shackTime = 0.12
    local maxChangeRate = 0.1
    local shackAction1 = cc.ScaleTo:create(shackTime/2,(1-maxChangeRate),(1+maxChangeRate))
    local shackAction2 = cc.ScaleTo:create(shackTime,(1+maxChangeRate),(1-maxChangeRate))
    local shackAction3 = cc.ScaleTo:create(shackTime,(1-maxChangeRate*0.75),(1+maxChangeRate*0.75))
    local shackAction4 = cc.ScaleTo:create(shackTime,(1+maxChangeRate*0.5),(1-maxChangeRate*0.5))
    local shackAction5 = cc.ScaleTo:create(shackTime,(1-maxChangeRate*0.5),(1+maxChangeRate*0.5))
    local shackAction6 = cc.ScaleTo:create(shackTime,(1+maxChangeRate*0.25),(1-maxChangeRate*0.25))
    local shackAction7 = cc.ScaleTo:create(shackTime,1,1)
    local buttonEffect = cc.Sequence:create(shackAction1,shackAction2,shackAction3
        ,shackAction4,shackAction5,shackAction6,shackAction7)

    targetButton:runAction(buttonEffect)
end

function uieffectutils.addBackClickListener(  )
    print("UIEffect.addBackClickListener start")
    local scene = g_cc_director:getRunningScene()
    local function onKeyReleasedFunc(keyCode, event)
        print("onKeyReleasedFunc:",keyCode)
        if keyCode == cc.KeyCode.KEY_BACK then
            g_cc_director:endToLua()
        end
    end

    local listener = cc.EventListenerKeyboard:create()
    listener:registerScriptHandler(onKeyReleasedFunc,cc.Handler.EVENT_KEYBOARD_RELEASED )

    local eventDispatcher = scene:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener,scene)
end
return uieffectutils
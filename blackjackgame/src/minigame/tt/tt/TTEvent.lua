local TTUtils = import("..tt.TTUtils")
local TTEvent = class("TTEvent")

local EXPORTED_METHODS = {
    "addEventListener",
    "dispatchEvent",
    "removeEventListener",
    "removeEventListenersByTag",
    "removeEventListenersByEvent",
    "removeAllEventListeners",
    "hasEventListener",
    "dumpAllEventListeners",
}
function TTEvent:init_()
    self.target_ = nil
    self.listeners_ = {}
    self.nextListenerHandleIndex_ = 0
end
--lxf liuxiaofei add
function TTEvent:init()
    self.target_ = nil
    self.listeners_ = {}
    self.nextListenerHandleIndex_ = 0
end
--lxf liuxiaofei add
function TTEvent:bind(target)
    self:init_()
    cc.setmethods(target, self, EXPORTED_METHODS)
    self.target_ = target
end

function TTEvent:unbind(target)
    cc.unsetmethods(target, EXPORTED_METHODS)
    self:init_()
end

function TTEvent:on(pEventName, listener, tag)
    local eventName = tostring(pEventName)
    assert(type(eventName) == "string" and eventName ~= "",
        "TTEvent:addEventListener() - invalid eventName")
    eventName = string.upper(eventName)
    if self.listeners_[eventName] == nil then
        self.listeners_[eventName] = {}
    end

    self.nextListenerHandleIndex_ = self.nextListenerHandleIndex_ + 1
    local handle = tostring(self.nextListenerHandleIndex_)
    tag = tag or ""
    self.listeners_[eventName][handle] = {listener, tag}

        TTUtils:Log(string.format("%s [TTEvent] addEventListener() - event: %s, handle: %s, tag: \"%s\"",
                  tostring(self.target_), eventName, handle, tostring(tag) ))

    return self.target_, handle
end

TTEvent.addEventListener = TTEvent.on

function TTEvent:dispatchEvent(event)
    event.name = string.upper(tostring(event.name))
    local eventName = event.name
    TTUtils:Log(string.format("%s [TTEvent] dispatchEvent() - event %s", tostring(self.target_), eventName))

    if self.listeners_[eventName] == nil then return end
    event.target = self.target_
    event.stop_ = false
    event.stop = function(self)
        self.stop_ = true
    end

    for handle, listener in pairs(self.listeners_[eventName]) do
        TTUtils:Log(string.format("%s [TTEvent] dispatchEvent() - dispatching event %s to listener %s", tostring(self.target_), eventName, handle))
        -- listener[1] = listener
        -- listener[2] = tag
        event.tag = listener[2]
        listener[1](event)
        if event.stop_ then
            TTUtils:Log(string.format("%s [TTEvent] dispatchEvent() - break dispatching for event %s", tostring(self.target_), eventName))
            break
        end
    end
    TTUtils:Log("TTEvent:dispatchEvent diapatch end")
    return self.target_
end

function TTEvent:removeEventListener(handleToRemove)
    for eventName, listenersForEvent in pairs(self.listeners_) do
        for handle, _ in pairs(listenersForEvent) do
            if handle == handleToRemove then
                listenersForEvent[handle] = nil
                TTUtils:Log(string.format("%s [TTEvent] removeEventListener() - remove listener [%s] for event %s", tostring(self.target_), handle, eventName))
                return self.target_
            end
        end
    end

    return self.target_
end

function TTEvent:removeEventListenersByTag(tagToRemove)
    for eventName, listenersForEvent in pairs(self.listeners_) do
        for handle, listener in pairs(listenersForEvent) do
            -- listener[1] = listener
            -- listener[2] = tag
            if listener[2] == tagToRemove then
                listenersForEvent[handle] = nil
                TTUtils:Log(string.format("%s [TTEvent] removeEventListener() - remove listener [%s] for event %s", tostring(self.target_), handle, eventName))
            end
        end
    end

    return self.target_
end

function TTEvent:removeEventListenersByEvent(eventName)
    self.listeners_[string.upper(eventName)] = nil
    TTUtils:Log(string.format("%s [TTEvent] removeAllEventListenersForEvent() - remove all listeners for event %s", tostring(self.target_), eventName))
    return self.target_
end

function TTEvent:removeAllEventListeners()
    self.listeners_ = {}
    TTUtils:Log(string.format("%s [TTEvent] removeAllEventListeners() - remove all listeners", tostring(self.target_)))
    return self.target_
end

function TTEvent:hasEventListener(eventName)
    eventName = string.upper(tostring(eventName))
    local t = self.listeners_[eventName]
    for _, __ in pairs(t) do
        return true
    end
    return false
end

function TTEvent:dumpAllEventListeners()
    TTUtils:Log("---- TTEvent:dumpAllEventListeners() ----")
    for name, listeners in pairs(self.listeners_) do
        TTUtils:Log(string.format("-- event: %s", name))
        for handle, listener in pairs(listeners) do
            TTUtils:Log(string.format("--     listener: %s, handle: %s", tostring(listener[1]), tostring(handle)))
        end
    end
    return self.target_
end

return TTEvent

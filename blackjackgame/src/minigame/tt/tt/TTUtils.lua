local TTGameData = import("..tt.TTGameData")
local TTConstant = import("..tt.TTConstant")
local TTLanguage = import("..tt.TTLanguage")
local TTUtils = class("TTUtils")
local randomseed = tonumber(os.time())
function TTUtils:init(target)
	self.ttGame_ = target
end
function TTUtils:Log( s )
	if TTGameData.isDebug then
		print(s)
	end
end
-- 为ImageView设置plist图片
function TTUtils:setPlistTexture(image, textureName)
	if image then
		image:loadTexture(textureName, ccui.TextureResType.plistType)
	end
end

-- 为ImageView设置普通图片
function TTUtils:setLocalTexture(image, textureName)
	if image then
		image:loadTexture(textureName, ccui.TextureResType.localType)
	end
end


-- 为Text设置字符串
function TTUtils:setTextString(text, content, parent)
	if type(text) == "string" then
		text = self:findNodeByName(text, parent)
	end
	text:setString(content)
end


-- 根据名称检索node，不止children
function TTUtils:findNodeByName(name, parent)
    if not parent then
		return
	end

	if name == parent:getName() then
		return parent
	end

	local findNode
	local children = parent:getChildren()
	local childCount = parent:getChildrenCount()
	if childCount < 1 then
		return
	end
	for i=1, childCount do
		if "table" == type(children) then
			parent = children[i]
		elseif "userdata" == type(children) then
			parent = children:objectAtIndex(i - 1)
		end

		if parent then
			if name == parent:getName() then
				return parent
			end
		end
	end

	for i=1, childCount do
		if "table" == type(children) then
			parent = children[i]
		elseif "userdata" == type(children) then
			parent = children:objectAtIndex(i - 1)
		end

		if parent then
			findNode = self:findNodeByName(name, parent)
			if findNode then
				return findNode
			end
		end
	end

	return
end


-- 移除事件监听
function TTUtils:removeBackKeyEventListener(view)

	for i = #backKeyListeners ,1 ,-1 do
		local bkListener = backKeyListeners[i]
		if bkListener == view then
			table.remove(backKeyListeners,i)
		end
	end
	cc.Director:getInstance():getEventDispatcher():removeEventListenersForTarget(view)
end

-- 为view设置监听
function TTUtils:setOnViewClickedListener(view, listener, parent, effect, playSound,carom)
	if not carom then
		carom = 0.1
	end
	
	if type(view) == "string" then
		view = self:findNodeByName(view, parent)
	end
	if not view then
		return
	end
	effect = effect or "zoom"
	if playSound == nil then
		playSound = false

	end
	view:setTouchEnabled(true)
	view.lastClickTime = 0
	view.oriScale = view:getScale()
	local viewType = tolua.type(view)
	if string.find(viewType, "ccui%.") then --cocos ui
		view:addTouchEventListener(function(sender, eventType)
			if eventType == 0 then
				if effect == "trans" then
					view:setPositionY(view:getPositionY()-3)
				elseif effect == "zoom" then
					view:setScale(view.oriScale*0.95)
				elseif effect == "transinner" then
					for i,v in ipairs(view:getChildren()) do
						v:setPositionY(v:getPositionY()-3)
					end
				end
			elseif eventType == 2 then
				if effect == "trans" then
					view:setPositionY(view:getPositionY()+3)
				elseif effect == "zoom" then
					view:setScale(view.oriScale)
				elseif effect == "transinner" then
					for i,v in ipairs(view:getChildren()) do
						v:setPositionY(v:getPositionY()+3)
					end
				end
				if playSound then
					--audio.playSound("audio/button_click.mp3")
				end
				-- 屏蔽双连击
				if math.abs(os.clock() - view.lastClickTime) > carom then
					view.lastClickTime = os.clock()
					listener(view)
				end
			elseif eventType ~= 1 then
				if effect == "trans" then
					view:setPositionY(view:getPositionY()+3)
				elseif effect == "zoom" then
					view:setScale(view.oriScale)
				elseif effect == "transinner" then
					for i,v in ipairs(view:getChildren()) do
						v:setPositionY(v:getPositionY()+3)
					end
				end
	        end
		end)
	else -- quick ui 以cc.开头
		view:removeNodeEventListenersByEvent(cc.NODE_TOUCH_EVENT)
		view:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
			if event.name == "began" then
				if effect == "trans" then
					view:setPositionY(view:getPositionY()-3)
				elseif effect == "zoom" then
					view:setScale(view.oriScale*0.95)
				elseif effect == "transinner" then
					for i,v in ipairs(view:getChildren()) do
						v:setPositionY(v:getPositionY()-3)
					end
				end
			elseif event.name == "ended" then
				if effect == "trans" then
					view:setPositionY(view:getPositionY()+3)
				elseif effect == "zoom" then
					view:setScale(view.oriScale)
				elseif effect == "transinner" then
					for i,v in ipairs(view:getChildren()) do
						v:setPositionY(v:getPositionY()+3)
					end
				end
				if playSound then
					--audio.playSound("audio/button_click.mp3")
				end
				if math.abs(os.clock() - view.lastClickTime) > carom and cc.rectContainsPoint(view:getCascadeBoundingBox(), cc.p(event.x, event.y)) then
					view.lastClickTime = os.clock()
					listener(view)
				end
			elseif event.name == "cancelled" then
				if effect == "trans" then
					view:setPositionY(view:getPositionY()+3)
				elseif effect == "zoom" then
					view:setScale(view.oriScale)
				elseif effect == "transinner" then
					for i,v in ipairs(view:getChildren()) do
						v:setPositionY(v:getPositionY()+3)
					end
				end
	        end
	    	return true
	    end)
	end
end

-- 播放时间轴动画
function TTUtils:runTimelineAction(target, actionfile, loop, finishCallback)
	local action = cc.CSLoader:createTimeline(actionfile)
	if finishCallback then
		action:setLastFrameCallFunc(function()
			finishCallback()
		end)
	end
	target:runAction(action)
	action:gotoFrameAndPlay(0, loop or false)
end

-- 播放粒子效果
function TTUtils:runParticleEffect(parent, particlefile, x, y, blendSrc, blendDest)
	local particle = cc.ParticleSystemQuad:create("particle_star.plist")
	particle:setBlendFunc(blendSrc or gl.ONE, blendDest or gl.ONE_MINUS_SRC_ALPHA)
	particle:setPosition(x or parent:getContentSize().width/2, y or parent:getContentSize().height/2)
	parent:addChild(particle)
end



-- 截取序列数组
function TTUtils:interceptSequenceTable(tb,length)
	if #tb <= length then
		return tb
	end

	local newTable = {}
	for i = 1,length do
		table.insert(newTable,tb[i])
	end
	return newTable
end

function TTUtils:downloadImage(url, callback)
	local isValidImgUrl,imgType = self:isValidImgUrl(url)
	if isValidImgUrl==false then
		return
	end
	local cbParameter = nil
	local function f()
		callback(cbParameter)
	end
	---本地头像
	if url==TTGameData.avatar and self.myHeadImgUrlFullFileName then
		local texture2d = cc.Director:getInstance():getTextureCache():addImage(self.myHeadImgUrlFullFileName)
		if texture2d and callback then
	        cbParameter = {done=true, texture2d=texture2d, url=url} 
			TTUtils:xpcall(f)
			return
	    end
	end
	---网络头像
	local xhr = cc.XMLHttpRequest:new()
	xhr._urlFileName = os.time().."_"..tostring(self:random(1,99999999)).."_"..tostring(self:random(1,99999999))--不能重名
	xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
	xhr:open("GET", url)
	local function onDownloadImage()
	    TTUtils:Log("xhr.readyState is:", xhr.readyState, "xhr.status is: ", xhr.status)
	    if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
	        local fileData = xhr.response
	        local fullFileName = cc.FileUtils:getInstance():getWritablePath() .. xhr._urlFileName.."."..imgType
	        TTUtils:Log(fullFileName)
	        local file = io.open(fullFileName,"wb")
	        file:write(fileData)
	        file:close()
	        local texture2d = cc.Director:getInstance():getTextureCache():addImage(fullFileName)
	        if texture2d then
	            cbParameter = {done=true, texture2d=texture2d, url=url} 
				TTUtils:xpcall(f)
	        else
	         	cbParameter = {done=false} 
				TTUtils:xpcall(f)
	        end
	        os.remove (fullFileName)
	    else
	    	TTUtils:Log("下载图片失败")
	    	cbParameter = {done=false} 
			TTUtils:xpcall(f)
	    end
	end

	xhr.timeout = 3.0
	xhr:registerScriptHandler(onDownloadImage)
	xhr:send()
end
function TTUtils:downLoadSelfImage()
	local url = TTGameData.avatar
	local isValidImgUrl,imgType = self:isValidImgUrl(url)
	if isValidImgUrl==false then
		return
	end	
	local xhr = cc.XMLHttpRequest:new()
	xhr._urlFileName = "tt_game_image"
	xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
	xhr:open("GET", url)
	local function onDownloadImage()
	    TTUtils:Log("xhr.readyState is:", xhr.readyState, "xhr.status is: ", xhr.status)
	    if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
	        local fileData = xhr.response
	        local fullFileName = cc.FileUtils:getInstance():getWritablePath() .. xhr._urlFileName.."."..imgType
	        TTUtils:Log(fullFileName)
	        os.remove(fullFileName)
	        local file = io.open(fullFileName,"wb")
	        file:write(fileData)
	        file:close()
	        local texture2d = cc.Director:getInstance():getTextureCache():addImage(fullFileName)
	        TTUtils:Log(texture2d)
	        if texture2d then
	           self.myHeadImgUrlFullFileName = fullFileName
	        end
	    else
	    	TTUtils:Log("下载图片失败")
	    end
	end
	xhr:registerScriptHandler(onDownloadImage)
	xhr:send()
end
function TTUtils:isValidImgUrl(url)
	local imgType = ""
	if string.len(url)<5 then
		TTUtils:Log("图片地址错误1 "..url)
		return false,imgType
	else
		imgType = string.sub(url,-3,-1)
		if imgType~="png" and imgType~="jpg" then
			TTUtils:Log(imgType)
			TTUtils:Log("图片格式错误2 "..url)
			return false,imgType
		end		
	end
	return true,imgType
end

function TTUtils:showToast(content,dt)
	local winSize = cc.Director:getInstance():getWinSize()
	dt = dt or 1
	local toastNode = cc.CSLoader:createNode("ttToast.csb")
	local bg = self:findNodeByName("bg", toastNode)
	local text = self:findNodeByName("text", toastNode)
	text:setString(content)
	bg:setContentSize( cc.size(text:getContentSize().width+100, bg:getContentSize().height) )
	toastNode:setPosition(winSize.width/2, winSize.height*25/100)
	toastNode:runAction( cc.Sequence:create(cc.DelayTime:create(dt), cc.FadeOut:create(0.2), cc.RemoveSelf:create(true)) )
	if self.ttGame_ then
		self.ttGame_:addChild(toastNode)
	end
end


function TTUtils:grayUIBtn(node,status)
	local graySpName = "graySprite"
	local graySp = node:getChildByName(graySpName)
	if graySp then
		graySp:removeFromParent()
	end
	if status==false then
		return
	end
	--node:setGLProgramState(cc.GLProgramState:getOrCreateWithGLProgram(cc.GLProgramCache:getInstance():getGLProgram("ShaderPositionTextureColor_noMVP")))
	--置灰
	local vertDefaultSource = "\n"..
    "attribute vec4 a_position; \n" ..
    "attribute vec2 a_texCoord; \n" ..
    "attribute vec4 a_color; \n"..                                                    
    "#ifdef GL_ES  \n"..
    "varying lowp vec4 v_fragmentColor;\n"..
    "varying mediump vec2 v_texCoord;\n"..
    "#else                      \n" ..
    "varying vec4 v_fragmentColor; \n" ..
    "varying vec2 v_texCoord;  \n"..
    "#endif    \n"..
    "void main() \n"..
    "{\n" ..
    "gl_Position = CC_PMatrix * a_position; \n"..
    "v_fragmentColor = a_color;\n"..
    "v_texCoord = a_texCoord;\n"..
    "}"
     
    local pszFragSource = "#ifdef GL_ES \n" ..
    "precision mediump float; \n" ..
    "#endif \n" ..
    "varying vec4 v_fragmentColor; \n" ..
    "varying vec2 v_texCoord; \n" ..
    "void main(void) \n" ..
    "{ \n" ..
    "vec4 c = texture2D(CC_Texture0, v_texCoord); \n" ..
    "gl_FragColor.xyz = vec3(0.4*c.r + 0.4*c.g +0.4*c.b); \n"..
    "gl_FragColor.w = c.w; \n"..
    "}"
 
    local pProgram = cc.GLProgram:createWithByteArrays(vertDefaultSource,pszFragSource)     
    pProgram:bindAttribLocation(cc.ATTRIBUTE_NAME_POSITION,cc.VERTEX_ATTRIB_POSITION)
    pProgram:bindAttribLocation(cc.ATTRIBUTE_NAME_COLOR,cc.VERTEX_ATTRIB_COLOR)
    pProgram:bindAttribLocation(cc.ATTRIBUTE_NAME_TEX_COORD,cc.VERTEX_ATTRIB_FLAG_TEX_COORDS)
    pProgram:link()
    pProgram:updateUniforms()

    local spf = node:getVirtualRenderer():getSprite():getSpriteFrame()
    local sp = cc.Sprite:createWithSpriteFrame(spf)
    sp:setName(graySpName)
	sp:setPosition(node:getContentSize().width/2,node:getContentSize().height/2)
	node:addChild(sp)
    sp:setGLProgram(pProgram)				
end

function TTUtils:formtNumber( nNum, isSign)
	if type(nNum) ~= "number"then
        return ""
    end
    if nil==isSign then
    	isSign = true
    end
    if  nNum < 10000 and nNum > -10000 then
    	return tostring(nNum)
    end

    local sign = ""
    if isSign then
    	if nNum>0 then
			sign = "+"
		else
			sign = "-"
		end
    end	
	nNum = math.abs(nNum)
	if TTGameData.language==TTConstant.LANGUAGE_EN then
		return sign..string.format("%.2f", nNum/1000.0)..TTLanguage.a[13][TTGameData.language]
	elseif TTGameData.language==TTConstant.LANGUAGE_ZH_HANT then
		return sign..string.format("%.2f", nNum/10000.0)..TTLanguage.a[13][TTGameData.language]
	elseif TTGameData.language==TTConstant.LANGUAGE_ZH_SIMPLE then
		return sign..string.format("%.2f", nNum/10000.0)..TTLanguage.a[13][TTGameData.language]
	end
    return ""
end
function TTUtils:GetPhonePlatform()
    local tFrameSize = cc.Director:getInstance():getOpenGLView():getFrameSize()
    local target = cc.Application:getInstance():getTargetPlatform()
    if target == cc.PLATFORM_OS_IPAD then
        return "Ipad"
    -- elseif target == cc.PLATFORM_OS_IPHONE then
    --     if tFrameSize.width == 640 and tFrameSize.height == 960 then
    --         return "Iphone4"
    --     end
    -- elseif target == cc.PLATFORM_OS_ANDROID then
    --     if tFrameSize.width == 1440 and tFrameSize.height == 2960 then
    --         return "Sumsang_s8"
    --     end
    --     if tFrameSize.width == 1080 and tFrameSize.height == 2220 then
    --         return "Sumsang_s8"
    --     end
    --     if tFrameSize.width == 720 and tFrameSize.height == 1480 then
    --         return "Sumsang_s8"
    --     end
    end
    --return "Ipad"
    return "Iphone6s"
end
--获取多语言资源位置
function TTUtils:getMutiRes(url)
	local newUrl = ""
	local result = url:split("/")  --分隔字符串 	
	local len = #result
	for i,v in ipairs(result) do
		if i==1 then
			if TTGameData.language==TTConstant.LANGUAGE_EN then
				newUrl = newUrl..v.."_en/"
			elseif TTGameData.language==TTConstant.LANGUAGE_ZH_HANT then
				newUrl = newUrl..v.."_zhHant/"
			elseif TTGameData.language==TTConstant.LANGUAGE_ZH_SIMPLE then
				newUrl = newUrl..v.."/"
			end
		elseif len==i then
			newUrl = newUrl..v
		else
			newUrl = newUrl..v.."/"
		end		
	end
	return newUrl
end
 --有三种用法： 无参调用， 产生 （0,1） 之间的浮点随机数； 只有参数 n， 产生 1-n 之间的整数； 有两个参数 n， m， 产生 n-m 之间的随机整数
function TTUtils:random(p1, p2)
	--设置随机种子
	randomseed = randomseed+1
	if randomseed>9502447887 then
		randomseed = os.time()
	end
    math.randomseed(randomseed)
    if nil==p1 and nil==p2 then
    	return math.random()
    elseif nil~=p1 and nil==p2 then
    	return math.random(p1)
    elseif nil~=p1 and nil~=p2 then
    	return math.random(p1, p2)
    end
    return 0
end
--打乱数组
function TTUtils:shuffleTable( t )
	local len = #t
	for i=1,len do
		local x = self:random(len)
		--print(i,x)
		local temp = t[i]
		t[i] = t[x]
		t[x] = temp
	end
end
--lua提供了xpcall函数，xpcall接收第二个参数——一个错误处理函数，当错误发生时，Lua会在调用桟展看（unwind）前调用错误处理函数，于是就可以在这个函数中使用debug库来获取关于错误的额外信息了
function TTUtils:xpcall(f)
	if (type(f) ~= "function") then
		return
	end
	function traceback( msg )  
		local logInfo = ""
        logInfo = logInfo.."------------------------------------------------------------------------------------------------------------------------"
        logInfo = logInfo.."LUA ERROR: "..tostring(msg).."\n"  
        logInfo = logInfo..debug.traceback()
        logInfo = logInfo.."------------------------------------------------------------------------------------------------------------------------"
        self:writeLog(nil, logInfo)
    end      
    xpcall(f, traceback) 
end
function TTUtils:fileExists(filename)
	local file = io.open(filename, "rb")
	if file then file:close() end
	return file ~= nil
end
function TTUtils:lengthOfFile(filename)
	if self:fileExists(filename) then
		local fh = assert(io.open(filename, "rb"))
		local len = assert(fh:seek("end"))
		fh:close()
		return len
	end
	return 0
end
function TTUtils:writeLog(filename, log)
	if not filename then
		filename = cc.FileUtils:getInstance():getWritablePath().."ttGameLog.txt"
	end
	if self:lengthOfFile(filename)>30000 then--日志文件需小于30K
		os.remove(filename)
	end
	--追加写文件,如果没有该文件，会自动创建  
	local gFile = io.open(filename ,"a");  
	gFile:write(log.."\n")  
	gFile:close() 
end


return TTUtils
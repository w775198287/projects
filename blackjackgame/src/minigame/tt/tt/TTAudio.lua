local TTGameData = import("..tt.TTGameData")
local TTAudio = class("TTAudio")
local TTUtils = import("..tt.TTUtils")

----------------------------------------------------------------------------背景音乐----------------------------------------------------------------------------
function TTAudio:playMusic(filePath,loop)	
	if false == TTGameData.isBackgroundMusic then
		return
	end
	if nil==loop then
		loop = false
	end
	AudioEngine.setMusicVolume(TTGameData.backgroundMusicVolume)
	AudioEngine.playMusic(filePath, true)
end
function TTAudio:stopMusic(releaseData)	
	if false == TTGameData.isBackgroundMusic then
		return
	end
	if nil==releaseData then
		releaseData = false
	end
	AudioEngine.stopMusic(releaseData)
end
function TTAudio:isMusicPlaying()
	return AudioEngine.isMusicPlaying()
end
function TTAudio:pauseMusic()
	AudioEngine.pauseMusic()
end
function TTAudio:resumeMusic()
	AudioEngine.resumeMusic()
end
----------------------------------------------------------------------------音效----------------------------------------------------------------------------
function TTAudio:playEffect(filePath)	
	if false == TTGameData.isEffectsAudio then
		return
	end
 	return AudioEngine.playEffect(filePath, false, TTGameData.effectsVolume)
end
function TTAudio:preloadEffect( filePath )
	if false == TTGameData.isEffectsAudio then
		return
	end
	AudioEngine.preloadEffect(filePath)
end
function TTAudio:uncacheEffect( filePath )
	AudioEngine.unloadEffect(filePath)
end
function TTAudio:stopEffect(soundId)	
	if false == TTGameData.isEffectsAudio then
		return
	end
 	AudioEngine.stopEffect(soundId)
end
function TTAudio:stopAllEffects()
	AudioEngine.stopAllEffects()
end

return TTAudio
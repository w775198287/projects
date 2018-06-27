local NNGameData = import("..nn.NNGameData")
local NNAudio = class("NNAudio")
local NNUtils = import("..nn.NNUtils")

----------------------------------------------------------------------------背景音乐----------------------------------------------------------------------------
function NNAudio:playMusic(filePath,loop)	
	if false == NNGameData.isBackgroundMusic then
		return
	end
	if nil==loop then
		loop = false
	end
	AudioEngine.setMusicVolume(NNGameData.backgroundMusicVolume)
	AudioEngine.playMusic(filePath, true)
end
function NNAudio:stopMusic(releaseData)	
	if false == NNGameData.isBackgroundMusic then
		return
	end
	if nil==releaseData then
		releaseData = false
	end
	AudioEngine.stopMusic(releaseData)
end
function NNAudio:isMusicPlaying()
	return AudioEngine.isMusicPlaying()
end
function NNAudio:pauseMusic()
	AudioEngine.pauseMusic()
end
function NNAudio:resumeMusic()
	AudioEngine.resumeMusic()
end
----------------------------------------------------------------------------音效----------------------------------------------------------------------------
function NNAudio:playEffect(filePath)	
	if false == NNGameData.isEffectsAudio then
		return
	end
	return AudioEngine.playEffect(filePath, false, NNGameData.effectsVolume)
end
function NNAudio:preloadEffect( filePath )
	if false == NNGameData.isEffectsAudio then
		return
	end
	AudioEngine.preloadEffect(filePath)
end
function NNAudio:uncacheEffect( filePath )
	AudioEngine.unloadEffect(filePath)
end
function NNAudio:stopEffect(soundId)	
	if false == NNGameData.isEffectsAudio then
		return
	end
	AudioEngine.stopEffect(soundId)
end
function NNAudio:stopAllEffects()
	AudioEngine.stopAllEffects()
end

return NNAudio
package net.retrocade.retrocamel.core {
	import flash.media.Sound;
	import flash.utils.Dictionary;

	use namespace retrocamel_int;

	public class RetrocamelSoundManager {

		private static var _sounds:Dictionary = new Dictionary();

		private static var _soundVolume:Number = 1;

		private static var _musicVolume:Number = 1;
		private static var _musicFadeVolume:Number = 1;


		// ::::::::::::::::::::::::::::::::::::::::::::::
		// :: Music Volume
		// ::::::::::::::::::::::::::::::::::::::::::::::

		/**
		 * Accesses the volume of music, the one set in the options.
		 */
		public static function get musicVolume():Number {
			return _musicVolume;
		}

		/**
		 * @private
		 */
		public static function set musicVolume(value:Number):void {
			_musicVolume = value;

			rSfxMusicManager.volume = value * _musicFadeVolume;
		}


		// ::::::::::::::::::::::::::::::::::::::::::::::
		// :: Sound Volume
		// ::::::::::::::::::::::::::::::::::::::::::::::

		/**
		 * Accesses the volume of sounds, the one set in the options.
		 */
		public static function get soundVolume():Number {
			return _soundVolume;
		}

		/**
		 * @private
		 */
		public static function set soundVolume(value:Number):void {
			_soundVolume = value;

			rSfxSoundManager.volume = value;
		}


		/**
		 * Changes a temporary music volume (used for fading and stuff)
		 */
		retrocamel_int static function set musicFadeVolume(value:Number):void {
			_musicFadeVolume = value;

			rSfxMusicManager.volume = _musicVolume * _musicFadeVolume;
		}

		/**
		 * @private
		 */
		retrocamel_int static function get musicFadeVolume():Number {
			return _musicFadeVolume;
		}

		public static function resetMusicFadeVolume():void {
			musicFadeVolume = 1;
		}


		// ::::::::::::::::::::::::::::::::::::::::::::::
		// :: Music Status
		// ::::::::::::::::::::::::::::::::::::::::::::::

		/**
		 * Returns true if the music is paused
		 */
		public static function musicIsPaused():Boolean {
			return !isNaN(rSfxMusicManager._pausePosition);
		}

		/**
		 * Returns true if music is currently playing
		 */
		public static function musicIsPlaying():Boolean {
			return rSfxMusicManager._currentSoundChannel != null;
		}


		/****************************************************************************************************************/
		/**                                                                                                  FUNCTIONS  */
		/****************************************************************************************************************/

		public static function getS(sfx:Class):Sound {
			if (!_sounds[sfx]) {
				_sounds[sfx] = new sfx;
			}

			return _sounds[sfx];
		}

		public static function playSound(sound:*, offset:int = 100):void {
			if (sound is Sound == false)
				sound = getS(sound);

			rSfxSoundManager.play(sound, offset);
		}

		public static function playMusic(music:*, repeats:Number = 9999, onMusicRepeat:Function = null):void {
			if (music == null)
				return;

			if (music is Sound == false)
				music = getS(music);

			if (isNaN(repeats) || repeats < 0)
				repeats = 0;

			rSfxMusicManager.playMusic(music, 0, repeats, onMusicRepeat);
		}

		public static function stopMusic():void {
			rSfxMusicManager.stopMusic();
		}

		public static function pauseMusic():void {
			rSfxMusicManager.pauseMusic();
		}

		public static function resumeMusic():void {
			rSfxMusicManager.resumeMusic();
		}
	}
}


import flash.events.Event;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;

import net.retrocade.retrocamel.core.retrocamel_int;

use namespace retrocamel_int;

class rSfxSoundManager {
	private static var _soundTransform:SoundTransform = new SoundTransform(1);

	private static var _playingSounds:Array = [];
	private static var _emptyIndexes:Array = [];
	private static var _emptyIndexesLength:uint = 0;

	retrocamel_int static function set volume(value:Number):void {
		_soundTransform.volume = value;

		for each(var soundChannel:SoundChannel in _playingSounds) {
			if (soundChannel)
				soundChannel.soundTransform = _soundTransform;
		}
	}

	retrocamel_int static function stop():void {
		for each(var sound:SoundChannel in _playingSounds) {
			if (sound) {
				sound.stop();
			}
		}

		_playingSounds.length = 0;
		_emptyIndexes.length = 0;
		_emptyIndexesLength = 0;
	}

	retrocamel_int static function play(sfx:Sound, offset:int = 100):void {
		var soundChannel:SoundChannel = sfx.play(offset, 0, _soundTransform);
		if (!soundChannel) {
			return;
		}

		soundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundCompleted);

		if (_emptyIndexesLength == 0) {
			_playingSounds.push(soundChannel);
		} else {
			_playingSounds[_emptyIndexes[--_emptyIndexesLength]] = soundChannel;
		}
	}

	private static function onSoundCompleted(e:Event):void {
		var soundChannel:SoundChannel = e.target as SoundChannel;

		var index:uint = _playingSounds.indexOf(soundChannel);

		_playingSounds[index] = null;
		_emptyIndexes[_emptyIndexesLength++] = index;
	}
}


class rSfxMusicManager {
	// ::::::::::::::::::::::::::::::::::::::::::::::
	// :: Music Variables
	// ::::::::::::::::::::::::::::::::::::::::::::::

	retrocamel_int static var _pausePosition:Number = NaN;
	retrocamel_int static var _lastStopPosition:Number = NaN;
	retrocamel_int static var _currentSoundChannel:SoundChannel;

	private static var _soundTransform:SoundTransform = new SoundTransform(1);
	private static var _lastPlayedSound:Sound;

	private static var _onMusicRepeat:Function = null;

	private static var _currentMusicRepeatCount:uint;

	retrocamel_int static function set volume(value:Number):void {
		_soundTransform.volume = value;

		if (_currentSoundChannel) {
			_currentSoundChannel.soundTransform = _soundTransform;
		}
	}

	retrocamel_int static function playMusic(sfx:Sound, position:Number = 0, repeats:Number = NaN, onMusicRepeat:Function = null):void {
		stopMusic();

		if (!isNaN(repeats)) {
			_currentMusicRepeatCount = repeats;
		}

		_onMusicRepeat = onMusicRepeat;

		if (position != 0) {
			_currentSoundChannel = sfx.play(position, 0, _soundTransform);

			_currentSoundChannel.addEventListener(Event.SOUND_COMPLETE, onMusicLoop, false, 0, true);

		} else {
			_currentSoundChannel = sfx.play(0, 0, _soundTransform);

			_currentSoundChannel.addEventListener(Event.SOUND_COMPLETE, onMusicLoop, false, 0, true);
		}

		_lastPlayedSound = sfx;
		_pausePosition = NaN;
	}

	retrocamel_int static function pauseMusic():void {
		if (_currentSoundChannel) {
			_pausePosition = _currentSoundChannel.position;
			_currentSoundChannel.stop();
			_currentSoundChannel = null;
		}
	}

	retrocamel_int static function resumeMusic():void {
		if (!_currentSoundChannel && _lastPlayedSound && !isNaN(_pausePosition))
			playMusic(_lastPlayedSound, _pausePosition);
	}

	retrocamel_int static function stopMusic():void {
		if (_currentSoundChannel) {
			_lastStopPosition = _currentSoundChannel.position;
			_currentSoundChannel.stop();

			_currentSoundChannel = null;
		}
	}

	private static function onMusicLoop(e:Event):void {
		if (_onMusicRepeat != null && _onMusicRepeat() == false) {
			musicFinished();
			return;
		}

		if (_currentMusicRepeatCount > 0)
			playMusic(_lastPlayedSound, 0, _currentMusicRepeatCount - 1);

		else
			musicFinished();
	}

	private static function musicFinished():void {
		_currentSoundChannel = null;
	}
}

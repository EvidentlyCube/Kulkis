package net.retrocade.retrocamel.core {
	import flash.media.Sound;
	import flash.utils.Dictionary;

	use namespace retrocamel_int;

	public class RetrocamelSoundManager {

		private static var _sounds:Dictionary = new Dictionary();

		private static var _soundVolume:Number = 1;


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
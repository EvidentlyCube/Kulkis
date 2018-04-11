package game.global {
import flash.events.Event;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;

import net.retrocade.retrocamel.core.RetrocamelCore;
import net.retrocade.utils.UtilsNumber;

public class Music {
    [Embed(source='/../src.music/music.mp3')]
    private static var _music_:Class;
    [Embed(source='/../src.music/music2.mp3')]
    private static var _music2_:Class;
    private static var _musics:Vector.<Sound>;

    private static var _currentMusic:Sound;
    private static var _currentMusicChannel:SoundChannel;
    private static var _pausePosition:Number;

    private static var _musicVolume:Number;
    private static var _musicFadeFactor:Number;
    private static var _targetFadeFactor:Number;

    public static function get musicVolume():Number{
        return _musicVolume;
    }

    public static function set musicVolume(value:Number):void {
        _musicVolume = value;
        if (_currentMusicChannel) {
            _currentMusicChannel.soundTransform = new SoundTransform(_musicVolume * _musicFadeFactor);
        }
    }

    public static function set musicFadeFactor(value:Number):void {
        _musicFadeFactor = value;
        if (_currentMusicChannel) {
            _currentMusicChannel.soundTransform = new SoundTransform(_musicVolume * _musicFadeFactor);
        }
    }

    public static function set targetFadeFactor(value:Number):void {
        _targetFadeFactor = value;
    }

    {
        init();
    }

    private static function init():void {
        _musics = new Vector.<Sound>(2, true);
        _musics[0] = new _music_;
        _musics[1] = new _music2_;
        _currentMusic = _musics[0];
        _pausePosition = 0;

        _musicVolume = 1;
        _musicFadeFactor = 1;
        _targetFadeFactor = 1;

        RetrocamelCore.groupAfter.add(new UpdateCallbackObject(update));
    }

    private static function update():void {
        _musicFadeFactor = UtilsNumber.approachStep(_musicFadeFactor, _targetFadeFactor, 0.05);
        if (_currentMusicChannel) {
            _currentMusicChannel.soundTransform = new SoundTransform(_musicVolume * _musicFadeFactor);
        }
    }

    public static function play():void {
        if (!_currentMusicChannel) {
            _currentMusicChannel = _currentMusic.play(_pausePosition, 0, new SoundTransform(_musicVolume * _musicFadeFactor));
            _currentMusicChannel.addEventListener(Event.SOUND_COMPLETE, swapMusics, false, 0, true);
        }
    }

    public static function pause():void {
        if (_currentMusicChannel) {
            _pausePosition = _currentMusicChannel.position;
            _currentMusicChannel.stop();
            _currentMusicChannel = null;
        }
    }

    private static function swapMusics(e:Event):void {
        _currentMusic = _musics[0] == _currentMusic ? _musics[1] : _musics[0];
        _pausePosition = 0;
        _currentMusicChannel.stop();
        _currentMusicChannel = null;
        play();
    }
}
}

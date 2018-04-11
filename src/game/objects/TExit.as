package game.objects {
import flash.display.BitmapData;

import game.global.Game;
import game.global.Level;
import game.global.Sfx;

import net.retrocade.retrocamel.core.RetrocamelBitmapManager;
import net.retrocade.retrocamel.effects.RetrocamelEffectFadeScreen;
import net.retrocade.utils.UtilsNumber;
import net.retrocade.utils.UtilsObjects;

public class TExit extends TGameObject {
    [Embed(source="/../src.assets/sprites/exit_base.png")]
    public static var _base_:Class;

    [Embed(source="/../src.assets/sprites/exit_00.png")]
    public static var _0_:Class;
    [Embed(source="/../src.assets/sprites/exit_01.png")]
    public static var _1_:Class;
    [Embed(source="/../src.assets/sprites/exit_02.png")]
    public static var _2_:Class;
    [Embed(source="/../src.assets/sprites/exit_03.png")]
    public static var _3_:Class;
    [Embed(source="/../src.assets/sprites/exit_04.png")]
    public static var _4_:Class;
    [Embed(source="/../src.assets/sprites/exit_05.png")]
    public static var _5_:Class;
    [Embed(source="/../src.assets/sprites/exit_06.png")]
    public static var _6_:Class;
    [Embed(source="/../src.assets/sprites/exit_07.png")]
    public static var _7_:Class;
    [Embed(source="/../src.assets/sprites/exit_08.png")]
    public static var _8_:Class;
    [Embed(source="/../src.assets/sprites/exit_09.png")]
    public static var _9_:Class;

    private var _frame:Number = 0;
    private var _currentGfx:BitmapData;
    private var _baseGfx:BitmapData;

    private var _pX:Number;
    private var _pY:Number;

    private var _pXTo:Number;
    private var _pYTo:Number;

    private var _playerGfx:BitmapData;

    public function TExit(x:Number, y:Number) {
        _x = x;
        _y = y;

        _width = 32;
        _height = 32;

        _currentGfx = RetrocamelBitmapManager.getBD(_0_);
        _baseGfx = RetrocamelBitmapManager.getBD(_base_);

        addAtDefault(0);
    }

    override public function update():void {
        if (!_playerGfx) {
            Game.lGame.draw(_baseGfx, _x, _y);
            Game.lGame.draw(_currentGfx, _x, _y);

            if (_frame == 0 && Level.blocksCount.get() == 0) {
                _frame = 1;
                Sfx.sfxLevelCompleted.play();

            } else if (_frame > 0 && _frame < 9) {
                _frame += 0.25;
                _currentGfx = RetrocamelBitmapManager.getBD(TExit['_' + uint(_frame | 0) + '_']);

            }
            if (_frame == 9 && player && UtilsObjects.distanceSquaredFromCenter(this, player) < 400) {
                _pX = player.x;
                _pY = player.y;
                _pXTo = center - player.width / 2;
                _pYTo = middle - player.height / 2;

                _playerGfx = player.exitEntered();
                Game.lGame.draw(_playerGfx, _pX, _pY);
            }
        } else {
            if (_pX != _pXTo || _pY != _pYTo) {
                Game.lGame.draw(_baseGfx, _x, _y);
                Game.lGame.draw(_currentGfx, _x, _y);

                _pX = UtilsNumber.approach(_pX, _pXTo);
                _pY = UtilsNumber.approach(_pY, _pYTo);

                Game.lGame.draw(_playerGfx, _pX, _pY);

            } else if (_frame > 0) {
                Game.lGame.draw(_baseGfx, _x, _y);
                Game.lGame.draw(_playerGfx, _pX, _pY);
                Game.lGame.draw(_currentGfx, _x, _y);

                _frame -= 0.25;
                _currentGfx = RetrocamelBitmapManager.getBD(TExit['_' + uint(_frame | 0) + '_']);

                if (_frame == 0) {
                    RetrocamelEffectFadeScreen.makeOut().duration(1000).callback(onFadeCompleted).run();
                }
            } else {
                Game.lGame.draw(_baseGfx, _x, _y);
                Game.lGame.draw(_currentGfx, _x, _y);
            }
        }
    }

    private function onFadeCompleted():void {
        Level.levelCompleted();
    }
}
}
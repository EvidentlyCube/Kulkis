package game.states {
CF::air{
    import flash.desktop.NativeApplication;
}
import flash.display.Bitmap;

import game.display.rAnimGravitated;
import game.display.rAnimSprite;
import game.global.Game;
import game.global.Level;
import game.global.Make;
import game.global.Music;
import game.global.Sfx;
import game.objects.TRibbon;
import game.tiles.TTileBlock;
import game.tiles.TTileWall;
import game.windows.TWinCredits;
import game.windows.TWinOptions;

import net.retrocade.retrocamel.components.RetrocamelStateBase;
import net.retrocade.retrocamel.core.RetrocamelBitmapManager;
import net.retrocade.retrocamel.display.flash.RetrocamelButton;
import net.retrocade.retrocamel.display.flash.RetrocamelWindowFlash;
import net.retrocade.retrocamel.display.global.RetrocamelTooltip;
import net.retrocade.retrocamel.effects.RetrocamelEffectFadeScreen;
import net.retrocade.retrocamel.effects.RetrocamelEffectQuake;
import net.retrocade.retrocamel.global.RetrocamelSimpleSave;
import net.retrocade.retrocamel.locale._;

public class TStateTitle extends RetrocamelStateBase {
    [Embed(source="/../src.assets/bgs/title.png")]
    private var __logo__:Class;

    [Embed(source="/../src.assets/bgs/title_ani_00.png")]
    private var __logo_0__:Class;
    [Embed(source="/../src.assets/bgs/title_ani_01.png")]
    private var __logo_1__:Class;
    [Embed(source="/../src.assets/bgs/title_ani_02.png")]
    private var __logo_2__:Class;
    [Embed(source="/../src.assets/bgs/title_ani_03.png")]
    private var __logo_3__:Class;
    [Embed(source="/../src.assets/bgs/title_ani_04.png")]
    private var __logo_4__:Class;
    [Embed(source="/../src.assets/bgs/title_ani_05.png")]
    private var __logo_5__:Class;
    [Embed(source="/../src.assets/bgs/title_ani_06.png")]
    private var __logo_6__:Class;
    [Embed(source="/../src.assets/bgs/title_ani_07.png")]
    private var __logo_7__:Class;
    [Embed(source="/../src.assets/bgs/title_ani_08.png")]
    private var __logo_8__:Class;
    [Embed(source="/../src.assets/bgs/title_ani_09.png")]
    private var __logo_9__:Class;


    private static var _instance:TStateTitle = new TStateTitle();
    public static function get instance():TStateTitle {
        return _instance;
    }


    private var _logo:Bitmap;
    private var _startRegular:RetrocamelButton;
    private var _startHard:RetrocamelButton;
    private var _continueRegular:RetrocamelButton;
    private var _continueHard:RetrocamelButton;
    private var _options:RetrocamelButton;
    private var _credits:RetrocamelButton;
    private var _quit:RetrocamelButton;

    private var _ribbon1:TRibbon;

    private var _state:uint = 0;

    private var _isStartingHardMode:Boolean;

    public function TStateTitle() {
        rAnimGravitated.blitLayer = Game.lGame;

        _logo = new __logo__;

        _logo.scaleX = 2;
        _logo.scaleY = 2;

        _logo.x = (S().gameWidth - _logo.width) / 2 | 0;
        _logo.y = 10;

        _startRegular = Make.button(onStart, _("Start Game"));
        _startHard = Make.button(onStartHard, _("Start Game Hard"));
        _continueRegular = Make.button(onContinue, _("Continue"));
        _continueHard = Make.button(onContinueHard, _("Continue"));
        _options = Make.button(onOptions, _("Options"));
        _credits = Make.button(onCredits, _("Credits"));
        if (CF::air){
            _quit = Make.button(this['onQuit'], _("Quit"));
        } else {
            _quit = Make.button(null, _("Quit"));
        }

        const BUTTONS_Y_DISTANCE:Number = 43;
        _startRegular.y = 271;
        _continueRegular.y = 271;
        _startHard.y = _startRegular.y + BUTTONS_Y_DISTANCE;
        _continueHard.y = _startRegular.y + BUTTONS_Y_DISTANCE;

        _credits.y = _startHard.y + BUTTONS_Y_DISTANCE;
        _options.y = _startHard.y + BUTTONS_Y_DISTANCE;
        _quit.y = _options.y + BUTTONS_Y_DISTANCE;

        _startRegular.x = (S().gameWidth - _startRegular.width) / 2 | 0;
        _startHard.x = (S().gameWidth - _startHard.width) / 2 | 0;
        _quit.x = (S().gameWidth - _quit.width) / 2 | 0;

        _continueRegular.x = _startRegular.right + 10;
        _continueHard.x = _startHard.right + 10;

        _options.x = (S().gameWidth - _options.width - _credits.width - 10) / 2 | 0;
        _credits.x = _options.x + _options.width + 10;
    }

    override public function update():void {
        if (_state == 0) {
            var s:rAnimSprite = new rAnimSprite(_logo.x / 2, _logo.y / 2, 7, Game.lBG);
            s.addFrame(RetrocamelBitmapManager.getBD(__logo_0__));
            s.addFrame(RetrocamelBitmapManager.getBD(__logo_1__));
            s.addFrame(RetrocamelBitmapManager.getBD(__logo_2__));
            s.addFrame(RetrocamelBitmapManager.getBD(__logo_3__));
            s.addFrame(RetrocamelBitmapManager.getBD(__logo_4__));
            s.addFrame(RetrocamelBitmapManager.getBD(__logo_5__));
            s.addFrame(RetrocamelBitmapManager.getBD(__logo_6__));
            s.addFrame(RetrocamelBitmapManager.getBD(__logo_7__));
            s.addFrame(RetrocamelBitmapManager.getBD(__logo_8__));
            s.onFinishCallback = function ():void {
                _state = 2
            };

            Game.lMain.mouseChildren = false;

            _state = 1;

        } else if (_state == 1) {
            Game.lBG.clear();

        } else if (_state == 2) {
            RetrocamelEffectFadeScreen.makeIn().color(0xFFFFFF).duration(800).run();
            RetrocamelEffectQuake.make().power(20, 20).duration(500).run();
            Game.lGame.layer.alpha = 1;

            _logo.alpha = 1;
            _startRegular.alpha = 1;
            _startHard.alpha = 1;
            _continueRegular.alpha = 1;
            _continueHard.alpha = 1;
            _credits.alpha = 1;
            _options.alpha = 1;
            _quit.alpha = 1;

            _state = 3;

            Music.play();

            Sfx.sfxBlockBoom.play();
            Game.lBG.draw(RetrocamelBitmapManager.getBD(Level._bg_), 0, 0);

            Game.lMain.mouseChildren = true;
        }

        Game.lGame.clear();
        super.update();
    }

    override public function create():void {
        Game.lBG.clear();
        Game.lMain.clear();
        Game.lGame.clear();

        Game.lMain.add(_logo);
        Game.lMain.add(_startRegular);
        Game.lMain.add(_startHard);
        Game.lMain.add(_continueRegular);
        Game.lMain.add(_continueHard);
        Game.lMain.add(_credits);
        Game.lMain.add(_options);
        if (CF::air){
            Game.lMain.add(_quit);
        }

        _continueRegular.visible = (RetrocamelSimpleSave.read('bestLevel', 1) > 1);
        _continueHard.visible = (RetrocamelSimpleSave.read('bestLevelHard', 1) > 1);

        var r:TRibbon = new TRibbon(105, -2, Game.lGame);
        r.addItem(RetrocamelBitmapManager.getBD(TTileBlock._gfx_block_1_), 1);
        r.addItem(RetrocamelBitmapManager.getBD(TTileBlock._gfx_block_2_), 1);
        r.addItem(RetrocamelBitmapManager.getBD(TTileBlock._gfx_block_3_), 1);
        r.addItem(RetrocamelBitmapManager.getBD(TTileBlock._gfx_block_4_), 1);
        r.addItem(RetrocamelBitmapManager.getBD(TTileWall._gfx_tile_1_), 0.05);
        r.addItem(RetrocamelBitmapManager.getBD(TTileWall._gfx_tile_3_), 0.05);
        r.addItem(RetrocamelBitmapManager.getBD(TTileWall._gfx_tile_4_), 0.05);
        r.addItem(RetrocamelBitmapManager.getBD(TTileWall._gfx_tile_7_), 0.05);
        r.addItem(RetrocamelBitmapManager.getBD(TTileWall._gfx_tile_8_), 0.05);
        r.addItem(RetrocamelBitmapManager.getBD(TTileWall._gfx_tile_9_), 0.05);
        r.addItem(RetrocamelBitmapManager.getBD(TTileWall._gfx_tile_15_), 0.05);
        r.addItem(RetrocamelBitmapManager.getBD(TTileWall._gfx_tile_16_), 0.05);
        r.addItem(RetrocamelBitmapManager.getBD(TTileWall._gfx_tile_17_), 0.05);

        r.farthestEdge = S().levelWidth;
        r.addMany(20);
        r.moveAll(-S().levelWidth);

        r.swayPower = 10;
        r.swayOffset = -Math.PI / 75;
        r.swaySpeed = Math.PI / 60;

        _ribbon1 = r;

        //Game.lBG  .displayObject.alpha = 0;
        Game.lGame.layer.alpha = 0;

        _logo.alpha = 0;
        _startRegular.alpha = 0;
        _startHard.alpha = 0;
        _continueRegular.alpha = 0;
        _continueHard.alpha = 0;
        _credits.alpha = 0;
        _options.alpha = 0;
        _quit.alpha = 0;

        _state = 0;

    }

    override public function destroy():void {
        RetrocamelTooltip.unhook(_startRegular);
        RetrocamelTooltip.unhook(_continueRegular);

        Game.lMain.clear();
        Game.lGame.clear();
        _defaultGroup.clear();
    }


    // ::::::::::::::::::::::::::::::::::::::::::::::
    // :: On Start
    // ::::::::::::::::::::::::::::::::::::::::::::::

    private function onStart():void {
        _isStartingHardMode = false;
        Music.targetFadeFactor = 0;
        RetrocamelEffectFadeScreen.makeOut().duration(500).callback(onStartFadeFinish).run();
    }
    private function onStartHard():void {
        _isStartingHardMode = true;
        Music.targetFadeFactor = 0;
        RetrocamelEffectFadeScreen.makeOut().duration(500).callback(onStartFadeFinish).run();
    }

    private function onStartFadeFinish():void {
        Music.pause();
        TStateIntro.instance.setToMe();
        TStateIntro.instance.setMode(_isStartingHardMode)
        //TStateOutro.instance.set();
    }


    // ::::::::::::::::::::::::::::::::::::::::::::::
    // :: On Continue
    // ::::::::::::::::::::::::::::::::::::::::::::::

    private function onContinue():void {
        Music.targetFadeFactor = 0;
        RetrocamelEffectFadeScreen.makeOut().duration(500).callback(onContinueFadeFinish).run();
    }
    private function onContinueHard():void {
        Music.targetFadeFactor = 0;
        RetrocamelEffectFadeScreen.makeOut().duration(500).callback(onContinueFadeFinishHard).run();
    }

    private function onContinueFadeFinish():void {
        TStateGame.instance.setToMe();
        Level.continueGame(false);
    }

    private function onContinueFadeFinishHard():void {
        TStateGame.instance.setToMe();
        Level.continueGame(true);
    }


    // ::::::::::::::::::::::::::::::::::::::::::::::
    // :: On Options
    // ::::::::::::::::::::::::::::::::::::::::::::::

    private function onOptions():void {
        var win:RetrocamelWindowFlash = new TWinOptions();
        win.show();
    }


    // ::::::::::::::::::::::::::::::::::::::::::::::
    // :: On Credits
    // ::::::::::::::::::::::::::::::::::::::::::::::

    private function onCredits():void {
        TWinCredits.instance.show();
    }

    CF::air{
        private function onQuit():void {
            NativeApplication.nativeApplication.exit();
        }
    }
}
}
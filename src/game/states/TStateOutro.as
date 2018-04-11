package game.states {
import flash.display.BitmapData;

import game.global.*;
import game.objects.TRibbon;
import game.tiles.TTileBlock;
import game.tiles.TTileWall;

import net.retrocade.constants.KeyConst;
import net.retrocade.retrocamel.components.RetrocamelStateBase;
import net.retrocade.retrocamel.core.RetrocamelBitmapManager;
import net.retrocade.retrocamel.core.RetrocamelInputManager;
import net.retrocade.retrocamel.display.flash.RetrocamelBitmapText;
import net.retrocade.retrocamel.effects.RetrocamelEffectFadeFlash;
import net.retrocade.retrocamel.effects.RetrocamelEffectFadeScreen;
import net.retrocade.retrocamel.locale._;

public class TStateOutro extends RetrocamelStateBase {
    private static var _instance:TStateOutro = new TStateOutro();

    public static function get instance():TStateOutro {
        return _instance;
    }


    /****************************************************************************************************************/
    /**                                                                                                  VARIABLES  */
    /****************************************************************************************************************/

    private var _tStory1:RetrocamelBitmapText;
    private var _tStory2:RetrocamelBitmapText;
    private var _tStory3:RetrocamelBitmapText;
    private var _tStory4:RetrocamelBitmapText;
    private var _tStory5:RetrocamelBitmapText;
    private var _tStory6:RetrocamelBitmapText;
    private var _tStory7:RetrocamelBitmapText;
    private var _tStory8:RetrocamelBitmapText;
    private var _tStory9:RetrocamelBitmapText;
    private var _tStoryA:RetrocamelBitmapText;

    private var _timer:uint = 0;

    private var _bgBD:BitmapData;
    private var _bgY:Number = 0;

    /****************************************************************************************************************/
    /**                                                                                                  FUNCTIONS  */

    /****************************************************************************************************************/

    public function TStateOutro() {
        _tStory1 = Make.text(_('outro1'), 0xFFFFFF, 2);
        _tStory2 = Make.text(_('outro2'), 0xFFFFFF, 2);
        _tStory3 = Make.text(_('outro3'), 0xFFFFFF, 2);
        _tStory4 = Make.text(_('outro4'), 0xFFFFFF, 2);
        _tStory5 = Make.text(_('outro5'), 0xFFFFFF, 2);
        _tStory6 = Make.text(_('outro6'), 0xFFFFFF, 2);
        _tStory7 = Make.text(_('outro7'), 0xFFFFFF, 4);
        _tStory8 = Make.text(_('outro8'), 0xFFFFFF, 2);
        _tStory9 = Make.text(_('outro9'), 0xFFFFFF, 2);
        _tStoryA = Make.text(_('outroA'), 0xFFFFFF, 2);

        _tStory1.positionToCenterScreen();
        _tStory2.positionToCenterScreen();
        _tStory3.positionToCenterScreen();
        _tStory4.positionToCenterScreen();
        _tStory5.positionToCenterScreen();
        _tStory6.positionToCenterScreen();
        _tStory7.positionToCenterScreen();
        _tStory8.positionToCenterScreen();
        _tStory9.positionToCenterScreen();
        _tStoryA.positionToCenterScreen();

        _tStory1.y = 20;
        _tStory2.y = 50;
        _tStory3.y = 80;
        _tStory4.y = 110;
        _tStory5.y = 140;
        _tStory6.y = 170;
        _tStory7.y = (S().gameHeight - _tStory7.height) / 2 - 50;
        _tStory8.y = _tStory7.y + _tStory7.height + 5;
        _tStory9.y = _tStory8.y + _tStory8.height + 5;
        _tStoryA.y = _tStory9.y + _tStory9.height + 5;

        _tStory1.addShadow();
        _tStory2.addShadow();
        _tStory3.addShadow();
        _tStory4.addShadow();
        _tStory5.addShadow();
        _tStory6.addShadow();
        _tStory7.addShadow();
        _tStory8.addShadow();
        _tStory9.addShadow();
        _tStoryA.addShadow();

        _bgBD = RetrocamelBitmapManager.getBD(Level._bg_);
    }

    override public function create():void {
        Game.lMain.add(_tStory1);
        Game.lMain.add(_tStory2);
        Game.lMain.add(_tStory3);
        Game.lMain.add(_tStory4);
        Game.lMain.add(_tStory5);
        Game.lMain.add(_tStory6);
        Game.lMain.add(_tStory7);
        Game.lMain.add(_tStory8);
        Game.lMain.add(_tStory9);
        Game.lMain.add(_tStoryA);

        _tStory1.alpha = 0;
        _tStory2.alpha = 0;
        _tStory3.alpha = 0;
        _tStory4.alpha = 0;
        _tStory5.alpha = 0;
        _tStory6.alpha = 0;
        _tStory7.alpha = 0;
        _tStory8.alpha = 0;
        _tStory9.alpha = 0;
        _tStoryA.alpha = 0;

        _timer = 0;

        var r:TRibbon = makeRibbon(-2, 10);
        r.isVertical = true;
        r.farthestEdge = S().levelHeight;
        r.swayPower = 5;
        r.swaySpeed = -Math.PI / 60;
        r.swayOffset = Math.PI / 75;
        r.addMany(16);
        r.moveAll(-S().levelHeight);

        r = makeRibbon(2, S().levelWidth - 25);
        r.isVertical = true;
        r.farthestEdge = S().levelHeight;
        r.swayPower = 5;
        r.swaySpeed = Math.PI / 60;
        r.swayOffset = Math.PI / 75;
        r.addMany(16);
        r.moveAll(S().levelHeight);

        Music.musicFadeFactor = 0;
        Music.targetFadeFactor = 1;
        Music.play();

        _bgY = 0;
    }

    override public function update():void {
        Game.lGame.clear();
        Game.lBG.clear();

        _bgY += 0.71;

        Game.lBG.draw(_bgBD, 0, -(_bgY % S().levelHeight));
        Game.lBG.draw(_bgBD, 0, -(_bgY % S().levelHeight) + S().levelHeight);

        _defaultGroup.update();

        _timer++;

        if (_timer == 20) {
            RetrocamelEffectFadeFlash.make(_tStory1).alpha(0, 1).duration(500).run();
            RetrocamelEffectFadeFlash.make(_tStory2).alpha(0, 1).duration(500).run();
        } else if (_timer == 180) {
            RetrocamelEffectFadeFlash.make(_tStory3).alpha(0, 1).duration(500).run();
            RetrocamelEffectFadeFlash.make(_tStory4).alpha(0, 1).duration(500).run();
        } else if (_timer == 340) {
            RetrocamelEffectFadeFlash.make(_tStory5).alpha(0, 1).duration(500).run();
            RetrocamelEffectFadeFlash.make(_tStory6).alpha(0, 1).duration(500).run();
        } else if (_timer == 600) {
            RetrocamelEffectFadeFlash.make(_tStory1).alpha(1, 0).duration(500).run();
        } else if (_timer == 610) {
            RetrocamelEffectFadeFlash.make(_tStory2).alpha(1, 0).duration(500).run();
        } else if (_timer == 620) {
            RetrocamelEffectFadeFlash.make(_tStory3).alpha(1, 0).duration(500).run();
        } else if (_timer == 630) {
            RetrocamelEffectFadeFlash.make(_tStory4).alpha(1, 0).duration(500).run();
        } else if (_timer == 640) {
            RetrocamelEffectFadeFlash.make(_tStory5).alpha(1, 0).duration(500).run();
        } else if (_timer == 650) {
            RetrocamelEffectFadeFlash.make(_tStory6).alpha(1, 0).duration(500).run();

        } else if (_timer == 700) {
            RetrocamelEffectFadeFlash.make(_tStory7).alpha(0, 1).duration(500).run();
        } else if (_timer == 780) {
            RetrocamelEffectFadeFlash.make(_tStory8).alpha(0, 1).duration(500).run();
        } else if (_timer == 860) {
            RetrocamelEffectFadeFlash.make(_tStory9).alpha(0, 1).duration(500).run();
        } else if (_timer == 940) {
            RetrocamelEffectFadeFlash.make(_tStoryA).alpha(0, 1).duration(500).run();
        } else if (_timer == 955) {
            RetrocamelEffectFadeFlash.make(_tStoryA).alpha(1, 0).duration(500).run();
        } else if (_timer == 965) {
            RetrocamelEffectFadeFlash.make(_tStory9).alpha(1, 0).duration(500).run();
        } else if (_timer == 975) {
            RetrocamelEffectFadeFlash.make(_tStory8).alpha(1, 0).duration(500).run();
        } else if (_timer == 1020) {
            RetrocamelEffectFadeScreen.makeOut().duration(2500).callback(lastEffectEnded).run();
        }

        if (_timer > 940 && _timer < 950) {
            _timer = 945;
            if (RetrocamelInputManager.isKeyHit(KeyConst.SPACE))
                _timer = 950;
        }
    }

    public function setMode(isHardMode:Boolean):void{
        var suffix:String = (isHardMode ? "k" : "");
        _tStory1.text = _("outro1"+suffix);
        _tStory2.text = _("outro2"+suffix);
        _tStory3.text = _("outro3"+suffix);
        _tStory4.text = _("outro4"+suffix);
        _tStory5.text = _("outro5"+suffix);
        _tStory6.text = _("outro6"+suffix);
        _tStory7.text = _("outro7"+suffix);
        _tStory8.text = _("outro8"+suffix);
        _tStory9.text = _("outro9"+suffix);
        _tStoryA.text = _("outroA"+suffix);

        _tStory1.positionToCenterScreen();
        _tStory2.positionToCenterScreen();
        _tStory3.positionToCenterScreen();
        _tStory4.positionToCenterScreen();
        _tStory5.positionToCenterScreen();
        _tStory6.positionToCenterScreen();
        _tStory7.positionToCenterScreen();
        _tStory8.positionToCenterScreen();
        _tStory9.positionToCenterScreen();
        _tStoryA.positionToCenterScreen();
    }

    private function lastEffectEnded():void {
        TStateTitle.instance.setToMe();
    }

    private function makeRibbon(spd:Number, y:Number):TRibbon {
        var r:TRibbon = new TRibbon(y, spd, Game.lGame);
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
        return r;
    }
}
}
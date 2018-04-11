package game.global {
import flash.utils.ByteArray;
import flash.utils.setTimeout;

import game.global.levelList.ILevelList;
import game.global.levelList.LevelListHard;
import game.global.levelList.LevelListRegular;
import game.objects.TEscButton;
import game.objects.TExit;
import game.objects.THud;
import game.objects.TPlayer;
import game.objects.TSpikes;
import game.standalone.HelpMessage;
import game.states.TStateOutro;
import game.states.TStateTitle;
import game.tiles.TTileBlock;
import game.tiles.TTileColorizer;
import game.tiles.TTileWall;

import net.retrocade.data.RetrocamelTileGrid;
import net.retrocade.retrocamel.core.RetrocamelBitmapManager;
import net.retrocade.retrocamel.core.RetrocamelSoundManager;
import net.retrocade.retrocamel.display.flash.RetrocamelBitmapText;
import net.retrocade.retrocamel.effects.RetrocamelEffectFadeScreen;
import net.retrocade.retrocamel.effects.RetrocamelEffectQuake;
import net.retrocade.retrocamel.global.RetrocamelSimpleSave;
import net.retrocade.retrocamel.locale._;
import net.retrocade.vault.Safe;

/**
 * ...
 * @author
 */
public class Level {


    [Embed(source='/../src.assets/bgs/bg.png')]
    public static var _bg_:Class;

    public static var blocksCount:Safe = new Safe(0);

    public static var level:RetrocamelTileGrid = new RetrocamelTileGrid(S().TILE_GRID_WIDTH, S().TILE_GRID_HEIGHT, S().TILE_GRID_TILE_WIDTH, S().TILE_GRID_TILE_HEIGHT);
    public static var player:TPlayer;

    public static var isHardMode:Boolean;

    private static var startedFromScratch:Boolean = false;

    private static var _levelListRegular:ILevelList;
    private static var _levelListHard:ILevelList;

    {
        _levelListRegular = new LevelListRegular();
        _levelListHard = new LevelListHard();
    }

    public static function getLevel(id:uint, isHardMode:Boolean):ByteArray {
        return isHardMode
            ? _levelListHard.getLevel(id)
            : _levelListRegular.getLevel(id);
    }

    public static function startGame(isHard:Boolean):void {
        Score.resetGameStart();

        isHardMode = isHard;
        startedFromScratch = true;

        Score.level.set(1);
        playLevel(Score.level.get(), isHard);
    }

    public static function continueGame(isHard:Boolean):void {
        startedFromScratch = false;
        isHardMode = isHard;

        if (isHard){
            Score.level.set(RetrocamelSimpleSave.read('bestLevelHard', 1));

        } else {
            Score.level.set(RetrocamelSimpleSave.read('bestLevel', 1));

        }
        playLevel(Score.level.get(), isHard);
    }

    public static function restartLevel():void {
        Score.mostLevelsNoDeath.set(0);
        playLevel(Score.level.get(), isHardMode);
    }

    public static function levelCompleted():void {
        Score.level.add(1);


        Score.mostLevelsNoDeath.add(1);

        if (Score.level.get() == 26) {
            TStateOutro.instance.setMode(isHardMode);
            TStateOutro.instance.setToMe();

        } else {
            playLevel(Score.level.get(), isHardMode);
        }
    }

    private static function playLevel(id:uint, isHard:Boolean):void {
        if (isHard){
            RetrocamelSimpleSave.write('bestLevelHard', Score.level.get());
        } else {
            RetrocamelSimpleSave.write('bestLevel', Score.level.get());
        }

        RetrocamelSimpleSave.flush();

        Level.level.clear();
        Game.gAll.clear();
        Game.partPixel.clear();
        Game.lMain.clear();
        THud.instance.unhook();
        THud.instance.hookTo(Game.lGame);

        blocksCount.set(0);

        Game.lBG.draw(RetrocamelBitmapManager.getBD(_bg_), 0, 0);

        var level:ByteArray = getLevel(id, isHard);
        var dataByte:uint;
        var posX:uint = 0;
        var posY:uint = 0;

        while (level.position < level.length) {
            posX = (level.position % S().TILE_GRID_WIDTH) * S().TILE_GRID_TILE_WIDTH;
            posY = (level.position / S().TILE_GRID_TILE_WIDTH | 0) * S().TILE_GRID_TILE_HEIGHT;

            dataByte = level[level.position++];

            parse(dataByte, posX, posY);
        }

        loadHelp(id);

        Music.targetFadeFactor = 1;
        Music.play();
        RetrocamelEffectFadeScreen.makeIn().duration(250).run();

        TEscButton.activate();
    }


    // ::::::::::::::::::::::::::::::::::::::::::::::
    // :: Level Parsing
    // ::::::::::::::::::::::::::::::::::::::::::::::

    private static function loadHelp(levelID:uint):void {
        switch (levelID) {
            case(1):
                new HelpMessage(_('help1'));
                break;

            case(2):
                new HelpMessage(_('help2'));
                break;

            case(3):
                new HelpMessage(_('help3'));
                break;

            case(4):
                new HelpMessage(_('help4', _('key' + Game.keyAccelerate), _('key' + Game.keyDecelerate)));
                break;
        }
    }

    private static function parse(dataByte:uint, x:uint, y:uint):void {
        if (dataByte > 0 && dataByte < 31)
            new TTileWall(x, y, dataByte);
        else if (dataByte >= 100 && dataByte <= 103)
            new TTileBlock(x, y, dataByte);
        else if (dataByte >= 110 && dataByte <= 113)
            new TTileColorizer(x, y, dataByte);
        else if (dataByte == 150)
            new TSpikes(x, y);
        else if (dataByte == 250)
            new TPlayer(x, y);
        else if (dataByte == 251)
            new TExit(x, y);

    }
}
}
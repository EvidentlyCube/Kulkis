package game.global {
	import flash.utils.ByteArray;
	import flash.utils.setTimeout;

	import game.global.levelList.ILevelList;
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
	import net.retrocade.retrocamel.effects.RetrocamelEffectMusicFade;
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

		private static var startedFromScratch:Boolean = false;

		private static var levelList:ILevelList;

		{
			CF::isRegular{
				// Do not optimize this import to avoid the levels from different levelset
				// being included. The line should look like this:
				//levelList = new game.global.levelList.LevelListRegular();
				levelList = new game.global.levelList.LevelListRegular();
			}
			CF::isHard{
				// Do not optimize this import to avoid the levels from different levelset
				// being included. The line should look like this:
				//levelList = new game.global.levelList.LevelListHard();
				levelList = new game.global.levelList.LevelListHard();
			}
		}

		public static function getLevel(id:uint):ByteArray {
			return levelList.getLevel(id);
		}

		public static function startGame():void {
			Score.resetGameStart();

			startedFromScratch = true;

			Score.level.set(1);
			Score.lives.set(3);
			Score.score.set(0);
			playLevel(Score.level.get());
		}

		public static function continueGame():void {
			startedFromScratch = false;

			Score.level.set(RetrocamelSimpleSave.read('bestLevel', 1));
			Score.lives.set(3);
			Score.score.set(0);
			playLevel(Score.level.get());
		}

		public static function restartLevel():void {
			Score.mostLevelsNoDeath.set(0);
			playLevel(Score.level.get());
		}

		public static function levelCompleted():void {
			Score.level.add(1);

			Score.mostLevelsNoDeath.add(1);
			Score.mostLevelsNoGameOver.add(1);

			if (Score.level.get() == 26) {
				TStateOutro.instance.setToMe();

			} else
				playLevel(Score.level.get());
		}

		private static function playLevel(id:uint):void {
			RetrocamelSimpleSave.write('bestLevel', Score.level.get());

			Score.scoreAtLevelStart.set(Score.score.get());

			Level.level.clear();
			Game.gAll.clear();
			Game.partPixel.clear();
			Game.lMain.clear();
			THud.instance.unhook();
			THud.instance.hookTo(Game.lGame);

			blocksCount.set(0);

			Game.lBG.draw(RetrocamelBitmapManager.getBD(_bg_), 0, 0);

			var level:ByteArray = getLevel(id);
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

			RetrocamelEffectMusicFade.make(1).duration(500).run();
			RetrocamelSoundManager.playMusic(Game.music);
			RetrocamelEffectFadeScreen.makeIn().duration(250).run();

			TEscButton.activate();
		}

		public static function gameOver():void {
			RetrocamelSoundManager.playSound(Game._sfx_game_over_);

			RetrocamelEffectQuake.make().power(20, 20).duration(500).run();
			var t:RetrocamelBitmapText = Make.text(_("GAME OVER"), 0xFFFFFF, 6);
			t.positionToCenterScreen();
			t.y = (S().gameHeight - t.height) / 2 | 0;
			t.addShadow();

			Game.lMain.add(t);

			setTimeout(onGameOverEnd, 3000);
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


		// ::::::::::::::::::::::::::::::::::::::::::::::
		// :: Event Listeners & Callbacks
		// ::::::::::::::::::::::::::::::::::::::::::::::

		private static function onGameOverEnd():void {
			RetrocamelSoundManager.stopMusic();
			RetrocamelEffectFadeScreen.makeOut().duration(2000).callback(onGameOverFadeEnd).run();
		}

		private static function onGameOverFadeEnd():void {
			Game.lMain.clear();
			Game.partPixel.clear();

			TStateTitle.instance.setToMe();
		}
	}
}
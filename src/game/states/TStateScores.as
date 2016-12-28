package game.states {
	import game.global.Game;
	import game.global.Make;
	import game.objects.TRibbon;
	import game.tiles.TTileBlock;
	import game.tiles.TTileWall;

	import net.retrocade.retrocamel.components.RetrocamelStateBase;
	import net.retrocade.retrocamel.core.RetrocamelBitmapManager;
	import net.retrocade.retrocamel.core.RetrocamelSoundManager;
	import net.retrocade.retrocamel.display.flash.RetrocamelBitmapText;
	import net.retrocade.retrocamel.display.flash.RetrocamelButton;
	import net.retrocade.retrocamel.effects.RetrocamelEffectFadeScreen;
	import net.retrocade.retrocamel.effects.RetrocamelEffectMusicFade;

	/**
	 * ...
	 * @author
	 */
	public class TStateScores extends RetrocamelStateBase {
		private static var _instance:TStateScores = new TStateScores;
		public static function get instance():TStateScores {
			return _instance;
		}


		/****************************************************************************************************************/
		/**                                                                                                  VARIABLES  */
		/****************************************************************************************************************/

		private var _text:RetrocamelBitmapText;

		private var _close:RetrocamelButton;


		/****************************************************************************************************************/
		/**                                                                                                  FUNCTIONS  */
		/****************************************************************************************************************/

		public function TStateScores() {
			_text = Make.text("", 0xFFFFFF, 2);
		}

		override public function create():void {
			Game.lBG.clear();
			Game.lGame.clear();
			Game.lMain.clear();

			if (RetrocamelSoundManager.musicIsPaused())
				RetrocamelSoundManager.resumeMusic();

			else if (!RetrocamelSoundManager.musicIsPlaying())
				RetrocamelSoundManager.playMusic(Game.music);

			var r:TRibbon = makeRibbon(1.3, 30);

			r.moveAll(S().levelWidth);

			r.swayPower = 15;
			r.swayOffset = Math.PI / 75;
			r.swaySpeed = Math.PI / 60;

			r = makeRibbon(-1.3, 166);

			r.moveAll(-S().levelWidth);
			r.swayPower = 15;
			r.swayOffset = -Math.PI / 75;
			r.swaySpeed = Math.PI / 60;

			_close = Make.button(onFinish, "Close");
			_close.bottom = S().gameHeight - 5;
			_close.alignCenter();
			Game.lMain.add(_close);

			RetrocamelEffectFadeScreen.makeIn().duration(1000).run();
		}

		override public function update():void {
			Game.lGame.clear();
			_defaultGroup.update();
		}

		private function onFinish():void {
			_close.enabled = false;
			Game.lMain.clear();
			RetrocamelEffectMusicFade.make(0).duration(1200).callback(RetrocamelSoundManager.stopMusic).run();
			RetrocamelEffectFadeScreen.makeOut().duration(1250).callback(onFinishFade).run();
		}

		private function onFinishFade():void {
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
			r.farthestEdge = S().levelWidth;
			r.addMany(20);
			return r;
		}
	}
}
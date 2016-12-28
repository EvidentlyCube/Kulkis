package game.states {
	import game.global.Game;
	import game.global.Level;
	import game.global.Make;

	import net.retrocade.constants.KeyConst;
	import net.retrocade.retrocamel.components.RetrocamelStateBase;
	import net.retrocade.retrocamel.core.RetrocamelCore;
	import net.retrocade.retrocamel.core.RetrocamelInputManager;
	import net.retrocade.retrocamel.display.flash.RetrocamelBitmapText;
	import net.retrocade.retrocamel.effects.RetrocamelEffectFadeFlash;
	import net.retrocade.retrocamel.effects.RetrocamelEffectFadeScreen;
	import net.retrocade.retrocamel.locale._;

	/**
	 * ...
	 * @author
	 */
	public class TStateIntro extends RetrocamelStateBase {
		private static var _instance:TStateIntro = new TStateIntro();
		public static function get instance():TStateIntro {
			return _instance;
		}

		private var _timer:Number = 0;
		private var _state:Number = 0;

		private var _tSkip:RetrocamelBitmapText;

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
		private var _tStoryB:RetrocamelBitmapText;
		private var _tStoryC:RetrocamelBitmapText;

		public function TStateIntro() {
			_tSkip = Make.text(_("Hit Space to skip intro"), 0xC0C0C0, 2);
			_tStory1 = Make.text(_("intro1"), 0xFFFFFF, 2);
			_tStory2 = Make.text(_("intro2"), 0xFFFFFF, 2);

			_tStory3 = Make.text(_("intro3"), 0xFFFFFF, 2);
			_tStory4 = Make.text(_("intro4"), 0xFFFFFF, 2);
			_tStory5 = Make.text(_("intro5"), 0xFFFFFF, 2);

			_tStory6 = Make.text(_("intro6"), 0xFFFFFF, 2);
			_tStory7 = Make.text(_("intro7"), 0xFFFFFF, 2);

			_tStory8 = Make.text(_("intro8"), 0xFFFFFF, 2);
			_tStory9 = Make.text(_("intro9"), 0xFFFFFF, 2);

			_tStoryA = Make.text(_("introA"), 0xFFFFFF, 2);

			_tStoryB = Make.text(_("introB"), 0xFFFFFF, 2);
			_tStoryC = Make.text(_("introC"), 0xFFFFFF, 2);


			_tSkip.positionToCenterScreen();
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
			_tStoryB.positionToCenterScreen();
			_tStoryC.positionToCenterScreen();

			_tSkip.y = S().gameHeight - _tSkip.height - 5;
			_tStory1.y = 20;
			_tStory2.y = 50;
			_tStory3.y = 80;
			_tStory4.y = 110;
			_tStory5.y = 140;
			_tStory6.y = 170;
			_tStory7.y = 200;
			_tStory8.y = 230;
			_tStory9.y = 260;
			_tStoryA.y = 290;
			_tStoryB.y = 320;
			_tStoryC.y = 350;


			_tSkip.addShadow();
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
			_tStoryB.addShadow();
			_tStoryC.addShadow();
		}

		override public function create():void {
			Game.lMain.add(_tSkip);
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
			Game.lMain.add(_tStoryB);
			Game.lMain.add(_tStoryC);

			reset();

			_timer = 0;
			_state = 0;

			RetrocamelEffectFadeScreen.makeIn().duration(400).run();
		}

		override public function destroy():void {
			Game.lMain.clear();
		}

		override public function update():void {
			if (RetrocamelInputManager.isKeyHit(KeyConst.SPACE))
				startClosing();

			_timer++;

			if (_timer == 20) {
				RetrocamelEffectFadeFlash.make(_tStory1).alpha(0, 1).duration(500).run();
				RetrocamelEffectFadeFlash.make(_tStory2).alpha(0, 1).duration(500).run();
			} else if (_timer == 160) {
				RetrocamelEffectFadeFlash.make(_tStory3).alpha(0, 1).duration(500).run();
				RetrocamelEffectFadeFlash.make(_tStory4).alpha(0, 1).duration(500).run();
				RetrocamelEffectFadeFlash.make(_tStory5).alpha(0, 1).duration(500).run();
			} else if (_timer == 370) {
				RetrocamelEffectFadeFlash.make(_tStory6).alpha(0, 1).duration(500).run();
				RetrocamelEffectFadeFlash.make(_tStory7).alpha(0, 1).duration(500).run();
			} else if (_timer == 510) {
				RetrocamelEffectFadeFlash.make(_tStory8).alpha(0, 1).duration(500).run();
				RetrocamelEffectFadeFlash.make(_tStory9).alpha(0, 1).duration(500).run();
			} else if (_timer == 650) {
				RetrocamelEffectFadeFlash.make(_tStoryA).alpha(0, 1).duration(500).run();
			} else if (_timer == 720) {
				RetrocamelEffectFadeFlash.make(_tStoryB).alpha(0, 1).duration(500).run();
				RetrocamelEffectFadeFlash.make(_tStoryC).alpha(0, 1).duration(500).run();

			} else if (_timer == 1000) {
				RetrocamelEffectFadeFlash.make(_tStory1).alpha(1, 0).duration(500).run();
			} else if (_timer == 1010) {
				RetrocamelEffectFadeFlash.make(_tStory2).alpha(1, 0).duration(500).run();
			} else if (_timer == 1020) {
				RetrocamelEffectFadeFlash.make(_tStory3).alpha(1, 0).duration(500).run();
			} else if (_timer == 1030) {
				RetrocamelEffectFadeFlash.make(_tStory4).alpha(1, 0).duration(500).run();
			} else if (_timer == 1040) {
				RetrocamelEffectFadeFlash.make(_tStory5).alpha(1, 0).duration(500).run();
			} else if (_timer == 1050) {
				RetrocamelEffectFadeFlash.make(_tStory6).alpha(1, 0).duration(500).run();
			} else if (_timer == 1060) {
				RetrocamelEffectFadeFlash.make(_tStory7).alpha(1, 0).duration(500).run();
			} else if (_timer == 1070) {
				RetrocamelEffectFadeFlash.make(_tStory8).alpha(1, 0).duration(500).run();
			} else if (_timer == 1080) {
				RetrocamelEffectFadeFlash.make(_tStory9).alpha(1, 0).duration(500).run();
			} else if (_timer == 1090) {
				RetrocamelEffectFadeFlash.make(_tStoryA).alpha(1, 0).duration(500).run();
			} else if (_timer == 1100) {
				RetrocamelEffectFadeFlash.make(_tStoryB).alpha(1, 0).duration(500).run();
			} else if (_timer == 1110) {
				RetrocamelEffectFadeFlash.make(_tStoryC).alpha(1, 0).duration(500).callback(startClosing).run();
			}
		}

		private function startClosing():void {
			if (_state == 0) {
				RetrocamelEffectFadeScreen.makeOut().duration(1000).callback(startGame).run();
				_state = 1;
			}
		}

		private function startGame():void {
			RetrocamelCore.setState(TStateGame.instance);
			Level.startGame();
		}


		private function reset():void {
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
			_tStoryB.alpha = 0;
			_tStoryC.alpha = 0;
		}
	}
}
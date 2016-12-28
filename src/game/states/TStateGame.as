package game.states {
	import game.global.Game;
	import game.global.Level;
	import game.objects.THud;
	import game.windows.TWinPause;

	import net.retrocade.constants.KeyConst;
	import net.retrocade.retrocamel.components.RetrocamelStateBase;
	import net.retrocade.retrocamel.core.RetrocamelInputManager;
	import net.retrocade.retrocamel.display.global.RetrocamelTooltip;

	public class TStateGame extends RetrocamelStateBase {
		private static var _instance:TStateGame = new TStateGame();
		public static function get instance():TStateGame {
			return _instance;
		}

		override public function create():void {
			_defaultGroup = Game.gAll;
			RetrocamelTooltip.hide();
		}

		override public function destroy():void {
			_defaultGroup.clear();
			THud.instance.unhook();
			Game.lGame.clear();
			Game.lBG.clear();
			Game.lMain.clear();
		}

		override public function update():void {
			if (RetrocamelInputManager.isKeyHit(KeyConst.ESCAPE) && Level.player) {
				TWinPause.instance.show();
				return;
			}

			Game.lGame.clear();
			Game.gAll.update();
		}
	}
}
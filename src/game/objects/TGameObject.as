package game.objects {
	import game.global.Game;
	import game.global.Level;
	import game.tiles.TTile;

	import net.retrocade.retrocamel.components.RetrocamelDisplayObject;
	import net.retrocade.retrocamel.components.RetrocamelUpdatableGroup;

	public class TGameObject extends RetrocamelDisplayObject {
		/**
		 * X of the left edge of the level
		 */
		public function get levelLeft():Number {
			return 0;
		}

		/**
		 * Y of the top edge of the level
		 */
		public function get levelTop():Number {
			return 0;
		}

		/**
		 * X of the right edge of the level
		 */
		public function get levelRight():Number {
			return S().levelWidth;
		}

		/**
		 * Y of the bottom edge of the level
		 */
		public function get levelBottom():Number {
			return S().levelHeight;
		}


		public function get maxX():Number {
			return S().levelWidth - _width;
		}

		public function get maxY():Number {
			return S().levelHeight - _height;
		}

		public function getTile(x:Number, y:Number):TTile {
			return Level.level.getTile(x, y);
		}

		override public function get defaultGroup():RetrocamelUpdatableGroup {
			return Game.gAll;
		}

		public function get player():TPlayer {
			return Level.player;
		}
	}
}
package game.tiles {
	import flash.display.BitmapData;

	import game.global.Game;
	import game.global.Sfx;
	import game.objects.TGameObject;
	import game.objects.TPlayer;

	import net.retrocade.retrocamel.core.RetrocamelBitmapManager;

	/**
	 * ...
	 * @author
	 */
	public class TTileColorizer extends TTile {
		[Embed(source="/../src.assets/sprites/changer1.png")]
		public static var _gfx_block_1_:Class;
		[Embed(source="/../src.assets/sprites/changer2.png")]
		public static var _gfx_block_2_:Class;
		[Embed(source="/../src.assets/sprites/changer3.png")]
		public static var _gfx_block_3_:Class;
		[Embed(source="/../src.assets/sprites/changer4.png")]
		public static var _gfx_block_4_:Class;

		protected var color:uint;
		protected var gfx:BitmapData;

		public function TTileColorizer(x:Number, y:Number, code:uint) {
			super(x, y, code);

			color = code - 109;

			gfx = RetrocamelBitmapManager.getBD(TTileColorizer['_gfx_block_' + color + '_']);

			_x = x;
			_y = y;

			_w = gfx.width;
			_h = gfx.height;

			setLevel();

			setLevel();
			Game.gAll.add(this);
			update();
		}

		override public function update():void {
			Game.lGame.draw(gfx, _x, _y);
		}

		override public function hitTop(o:TGameObject):void {
			super.hitTop(o);
			if (o is TPlayer && TPlayer(o).colorID != color) {
				Sfx.sfxChangeColor.play();
				TPlayer(o).colorID = color;
			}
		}

		override public function hitBottom(o:TGameObject):void {
			super.hitBottom(o);
			if (o is TPlayer && TPlayer(o).colorID != color) {
				Sfx.sfxChangeColor.play();
				TPlayer(o).colorID = color;
			}
		}
	}
}
package game.tiles {
	import flash.display.BitmapData;

	import game.global.Game;
	import game.global.Level;
	import game.global.Score;
	import game.global.Sfx;
	import game.objects.TGameObject;
	import game.objects.TPlayer;

	import net.retrocade.retrocamel.core.RetrocamelBitmapManager;
	import net.retrocade.retrocamel.effects.RetrocamelEffectQuake;
	import net.retrocade.utils.UtilsNumber;

	/**
	 * ...
	 * @author
	 */
	public class TTileBlock extends TTile {
		[Embed(source="/../src.assets/sprites/block1.png")]
		public static var _gfx_block_1_:Class;
		[Embed(source="/../src.assets/sprites/block2.png")]
		public static var _gfx_block_2_:Class;
		[Embed(source="/../src.assets/sprites/block3.png")]
		public static var _gfx_block_3_:Class;
		[Embed(source="/../src.assets/sprites/block4.png")]
		public static var _gfx_block_4_:Class;

		[Embed(source="/../src.assets/sprites/block1_01.gif")]
		public static var _gfx_block_1_1_:Class;
		[Embed(source="/../src.assets/sprites/block1_02.gif")]
		public static var _gfx_block_1_2_:Class;
		[Embed(source="/../src.assets/sprites/block1_03.gif")]
		public static var _gfx_block_1_3_:Class;
		[Embed(source="/../src.assets/sprites/block2_01.gif")]
		public static var _gfx_block_2_1_:Class;
		[Embed(source="/../src.assets/sprites/block2_02.gif")]
		public static var _gfx_block_2_2_:Class;
		[Embed(source="/../src.assets/sprites/block2_03.gif")]
		public static var _gfx_block_2_3_:Class;
		[Embed(source="/../src.assets/sprites/block3_01.gif")]
		public static var _gfx_block_3_1_:Class;
		[Embed(source="/../src.assets/sprites/block3_02.gif")]
		public static var _gfx_block_3_2_:Class;
		[Embed(source="/../src.assets/sprites/block3_03.gif")]
		public static var _gfx_block_3_3_:Class;
		[Embed(source="/../src.assets/sprites/block4_01.gif")]
		public static var _gfx_block_4_1_:Class;
		[Embed(source="/../src.assets/sprites/block4_02.gif")]
		public static var _gfx_block_4_2_:Class;
		[Embed(source="/../src.assets/sprites/block4_03.gif")]
		public static var _gfx_block_4_3_:Class;


		protected var color:uint;
		protected var gfx:BitmapData;

		protected var animWait:Number = 0;
		protected var animFrame:Number = 0;

		public function TTileBlock(x:Number, y:Number, code:uint) {
			super(x, y, code);

			color = code - 99;

			gfx = RetrocamelBitmapManager.getBD(TTileBlock['_gfx_block_' + color + '_']);

			_x = x;
			_y = y;

			_w = gfx.width;
			_h = gfx.height;

			setLevel();

			setLevel();
			Game.gAll.add(this);

			Level.blocksCount.add(1);

			animWait = 30 + Math.random() * 570 | 0;

			update();
		}

		override public function update():void {
			Game.lGame.draw(gfx, _x, _y);

			if (animWait-- == 0) {
				animWait = 30 + Math.random() * 570 | 0;
				if (animFrame == 0) {
					animFrame = 1;
				}
			}

			if (animFrame > 0) {
				animFrame += 0.15;
				if (animFrame < 4)
					gfx = RetrocamelBitmapManager.getBD(TTileBlock['_gfx_block_' + color + '_' + (animFrame | 0) + '_']);
				else {
					gfx = RetrocamelBitmapManager.getBD(TTileBlock['_gfx_block_' + color + '_']);
					animFrame = 0;
				}
			}
		}

		override public function hitTop(o:TGameObject):void {
			super.hitTop(o);
			if (o is TPlayer && TPlayer(o).colorID == color)
				destroy();
		}

		override public function hitBottom(o:TGameObject):void {
			super.hitBottom(o);
			if (o is TPlayer && TPlayer(o).colorID == color)
				destroy(-1);
		}

		private function destroy(dir:Number = 1):void {
			Game.gAll.nullify(this);
			unsetLevel();
			Sfx.sfxBlockBoom.play();

			Score.blockDestroyed();

			Level.blocksCount.add(-1);

			RetrocamelEffectQuake.make().power(5, 5).duration(100).run();

			for (var i:uint = 0; i < _w; i++) {
				for (var j:uint = 0; j < _h; j++) {
					Game.partPixel.add(_x + i, _y + j, gfx.getPixel32(i, j),
						Math.min(UtilsNumber.randomWaved(15, 14), UtilsNumber.randomWaved(15, 14), UtilsNumber.randomWaved(15, 14)),
						UtilsNumber.randomWaved(0, 150), UtilsNumber.randomWaved(100, 100) * dir);
				}
			}
		}
	}

}
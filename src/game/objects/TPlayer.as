package game.objects {
	import flash.display.Bitmap;
	import flash.display.BitmapData;

	import game.global.Game;
	import game.global.Level;
	import game.global.Score;
	import game.global.Sfx;
	import game.tiles.TTile;

	import net.retrocade.retrocamel.core.RetrocamelInputManager;
	import net.retrocade.retrocamel.core.RetrocamelSoundManager;
	import net.retrocade.retrocamel.effects.RetrocamelEffectFadeScreen;
	import net.retrocade.retrocamel.effects.RetrocamelEffectMusicFade;
	import net.retrocade.retrocamel.effects.RetrocamelEffectQuake;
	import net.retrocade.utils.UtilsNumber;

	public class TPlayer extends TGameObject {
		[Embed(source='/../src.assets/sprites/player1.png')]
		public static var _gfx_player_red_:Class;
		[Embed(source='/../src.assets/sprites/player2.png')]
		public static var _gfx_player_blue_:Class;
		[Embed(source='/../src.assets/sprites/player3.png')]
		public static var _gfx_player_green_:Class;
		[Embed(source='/../src.assets/sprites/player4.png')]
		public static var _gfx_player_yellow_:Class;

		private var _colorID:uint = 1; //1 - Red, 2 - Blue, 3 - Green, 4 - Yellow
		public function get colorID():uint {
			return _colorID;
		}

		public function set colorID(id:uint):void {
			if (id === _colorID)
				return;

			blow(_gfxCurrent);

			_colorID = id;
			if (id == 1)
				_gfxCurrent = _gfxRed;
			else if (id == 2)
				_gfxCurrent = _gfxBlue;
			else if (id == 3)
				_gfxCurrent = _gfxGreen;
			else if (id == 4)
				_gfxCurrent = _gfxYellow;

		}

		private var _gfxRed:BitmapData;
		private var _gfxBlue:BitmapData;
		private var _gfxGreen:BitmapData;
		private var _gfxYellow:BitmapData;

		private var _gfxCurrent:BitmapData;

		private var spd:Number = 2;
		private var dir:Number = 1;

		private const SPD_X:Number = 1.0;
		private const SPD_Y_MAX:Number = 4;
		private const SPD_Y_MIN:Number = 0.50;
		private const SPD_Y_ACC:Number = 0.125;

		private var blockHit:Boolean = false;

		private var started:Boolean = false;

		public function TPlayer(x:int, y:int) {
			Level.player = this;

			_gfxRed = Bitmap(new _gfx_player_red_).bitmapData;
			_gfxBlue = Bitmap(new _gfx_player_blue_).bitmapData;
			_gfxGreen = Bitmap(new _gfx_player_green_).bitmapData;
			_gfxYellow = Bitmap(new _gfx_player_yellow_).bitmapData;

			_width = 10;
			_height = 10;

			_x = x;
			_y = y;

			_gfxCurrent = _gfxRed;

			addDefault();

			Score.multiplier.set(1);
		}

		override public function update():void {
			if (!active) {
				return;
			}

			if (!started) {
				if (RetrocamelInputManager.isKeyHit(Game.keyAccelerate) || RetrocamelInputManager.isKeyHit(Game.keyDecelerate) ||
					RetrocamelInputManager.isKeyHit(Game.keyLeft) || RetrocamelInputManager.isKeyHit(Game.keyRight)) {
					started = true;

				} else {
					Game.lGame.draw(_gfxCurrent, x, y);
					Game.lGame.plot(x + 2, y + 12, 0xFFFFFFFF);
					Game.lGame.plot(x + 3, y + 12, 0xFFFFFFFF);
					Game.lGame.plot(x + 4, y + 12, 0xFFFFFFFF);
					Game.lGame.plot(x + 5, y + 12, 0xFFFFFFFF);
					Game.lGame.plot(x + 6, y + 12, 0xFFFFFFFF);
					Game.lGame.plot(x + 7, y + 12, 0xFFFFFFFF);
					Game.lGame.plot(x + 3, y + 13, 0xFFFFFFFF);
					Game.lGame.plot(x + 4, y + 13, 0xFFFFFFFF);
					Game.lGame.plot(x + 5, y + 13, 0xFFFFFFFF);
					Game.lGame.plot(x + 6, y + 13, 0xFFFFFFFF);
					Game.lGame.plot(x + 4, y + 14, 0xFFFFFFFF);
					Game.lGame.plot(x + 5, y + 14, 0xFFFFFFFF);

					return;
				}
			}

			if (Score.multiplier.get() > 1)
				Score.multiplier.add(-0.25);

			// Manipulate speed
			if (RetrocamelInputManager.isKeyDown(Game.keyAccelerate) && spd < SPD_Y_MAX) {
				spd += SPD_Y_ACC;
			}

			if (RetrocamelInputManager.isKeyDown(Game.keyDecelerate) && spd > SPD_Y_MIN) {
				spd -= SPD_Y_ACC;
			}


			// Horizontal movement
			if (RetrocamelInputManager.isKeyDown(Game.keyLeft)) {
				x -= SPD_X;
				if (checkCollision(180)) {
					if (!blockHit)
						burstParticles(x, middle, 0);
					blockHit = true;
				} else {
					blockHit = false;
				}
			} else if (RetrocamelInputManager.isKeyDown(Game.keyRight)) {
				x += SPD_X;
				if (checkCollision(0)) {
					if (!blockHit)
						burstParticles(right, middle, 180);
					blockHit = true;
				} else {
					blockHit = false;
				}
			}

			if (dir == 1) {
				y += spd * dir;
				if (checkCollision(90)) {
					dir *= -1;
					burstParticles(center, bottom, -90);
				}

			} else if (dir == -1) {
				y += spd * dir;
				if (checkCollision(-90)) {
					dir *= -1;
					burstParticles(center, y, 90);
				}
			}

			Game.lGame.draw(_gfxCurrent, x, y);
		}

		private function checkCollision(dir:Number):Boolean {
			var tile1:TTile, tile2:TTile, func:String;
			switch (dir) {
				case(0):
					tile1 = getTile(right, y);
					tile2 = getTile(right, bottom);
					func = "hitLeft";
					break;
				case(90):
					if ((center / 16 | 0) * 16 - x > (right / 16 | 0) * 16 - center) {
						tile1 = getTile(x, bottom);
						tile2 = getTile(right, bottom);
					} else {
						tile2 = getTile(x, bottom);
						tile1 = getTile(right, bottom);
					}
					func = "hitTop";
					break;
				case(180):
					tile1 = getTile(x, y);
					tile2 = getTile(x, bottom);
					func = "hitRight";
					break;
				case(-90):
					if ((center / 16 | 0) * 16 - x > (right / 16 | 0) * 16 - center) {
						tile1 = getTile(x, y);
						tile2 = getTile(right, y);
					} else {
						tile2 = getTile(x, y);
						tile1 = getTile(right, y);
					}
					func = "hitBottom";
					break;

			}

			var ret:Boolean = false;
			if (tile1) {
				tile1[func](this);
				ret = true;
			}

			if (tile2 && tile2 != tile1) {
				tile2[func](this);
				ret = true;
			}

			return ret;
		}

		private function burstParticles(x:Number, y:Number, dir:Number):void {
			var i:int = 2 + Math.random() * 4 | 0;
			var color:uint = (colorID == 1 ? 0xFFFF0000 : colorID == 2 ? 0xFF0000FF : colorID == 3 ? 0xFF00FF00 : 0xFFFFFF00);
			Sfx.sfxPlayerBounce.play();
			while (i--) {
				var _dir:Number = UtilsNumber.randomWaved(dir, 45) * Math.PI / 180;
				var _spd:Number = UtilsNumber.randomWaved(100, 80);
				Game.partPixel.add(x, y, color, UtilsNumber.randomWaved(20, 15), Math.cos(_dir) * _spd, Math.sin(_dir) * _spd);
			}
		}

		public function kill():void {
			Sfx.sfxDeath.play();

			for (var i:Number = 0; i < _width; i += 0.5) {
				for (var j:Number = 0; j < _height; j += 0.5) {
					Game.partPixel.add(_x + i, _y + j, _gfxCurrent.getPixel32(i, j),
						Math.min(UtilsNumber.randomWaved(85, 20), UtilsNumber.randomWaved(85, 20), UtilsNumber.randomWaved(85, 20)),
						150 * Math.random() / (i - 5), 150 * Math.random() / (j - 5));
				}
			}

			RetrocamelEffectQuake.make().mode(RetrocamelEffectQuake.MODE_RANDOM).power(20, 20).duration(1200).callback(onKillQuakeFinished).run();
			active = false;

			RetrocamelSoundManager.stopMusic();

			Level.player = null;

			Score.lives.add(-1);
		}

		public function exitEntered():BitmapData {
			Level.player = null;
			active = false;
			RetrocamelEffectMusicFade.make(0).duration(500).callback(RetrocamelSoundManager.stopMusic).run();
			return _gfxCurrent;
		}

		private function blow(bd:BitmapData):void {
			for (var i:uint = 0; i < _width; i++) {
				for (var j:uint = 0; j < _height; j++) {
					Game.partPixel.add(_x + i, _y + j, bd.getPixel32(i, j),
						Math.min(UtilsNumber.randomWaved(15, 14), UtilsNumber.randomWaved(15, 14), UtilsNumber.randomWaved(15, 14)),
						200 * Math.random() / (i - 5), 200 * Math.random() / (j - 5));
				}
			}
		}

		private function onKillQuakeFinished():void {
			if (Score.lives.get() == 0) {
				Level.gameOver();
			}else {
				RetrocamelEffectFadeScreen.makeOut().duration(500).callback(onKillFadeFinished).run();
			}
		}

		private function onKillFadeFinished():void {
			Level.restartLevel();
		}

	}
}
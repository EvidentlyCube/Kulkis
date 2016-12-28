package net.retrocade.retrocamel.display.flash {
	import flash.display.Sprite;

	import net.retrocade.retrocamel.core.RetrocamelCore;
	import net.retrocade.retrocamel.core.retrocamel_int;

	use namespace retrocamel_int;

	public class RetrocamelSprite extends Sprite {

		// ::::::::::::::::::::::::::::::::::::::::::::::
		// :: Constructor
		// ::::::::::::::::::::::::::::::::::::::::::::::

		public function RetrocamelSprite() {
			tabChildren = tabEnabled = false;
		}

		/**
		 * @inherit
		 */
		override public function get x():Number {
			return super.x;
		}

		/**
		 * @inherit
		 */
		override public function set x(value:Number):void {
			super.x = value;
		}


		// ::::::::::::::::::::::::::::::::::::::::::::::
		// :: Y override
		// ::::::::::::::::::::::::::::::::::::::::::::::

		/**
		 * @inherit
		 */
		override public function get y():Number {
			return super.y;
		}

		/**
		 * @inherit
		 */
		override public function set y(value:Number):void {
			super.y = value;
		}


		/******************************************************************************************************/
		/**                                                                                           ALIGNS  */
		/******************************************************************************************************/

		// ::::::::::::::::::::::::::::::::::::::::::::::
		// :: Align Center
		// ::::::::::::::::::::::::::::::::::::::::::::::

		/**
		 * Horizontally aligns this component to the center of the screen
		 * @param offset The offset from the center at which this component should be aligned
		 */
		public function alignCenter(offset:Number = 0):void {
			x = ((RetrocamelCore.settings.gameWidth - width) / 2 | 0) + offset | 0;
		}

		/**
		 * The bottom edge of the sprite (y + height)
		 */
		public function get bottom():Number {
			return y + height;
		}

		/**
		 * @private
		 */
		public function set bottom(newVal:Number):void {
			y = newVal - height;
		}


		// ::::::::::::::::::::::::::::::::::::::::::::::
		// :: Right
		// ::::::::::::::::::::::::::::::::::::::::::::::

		/**
		 * The right edge of the sprite (x + width)
		 */
		public function get right():Number {
			return x + width;
		}

		/**
		 * @private
		 */
		public function set right(newVal:Number):void {
			x = newVal - width;
		}
	}
}
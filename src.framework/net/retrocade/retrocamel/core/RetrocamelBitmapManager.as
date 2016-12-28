package net.retrocade.retrocamel.core {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.utils.Dictionary;

	import net.retrocade.retrocamel.display.flash.RetrocamelBitmap;

	public class RetrocamelBitmapManager {
		private static var _graphics:Dictionary = new Dictionary();

		private static function bitmapLoaded(event:Event):void {
			var loader:Loader = LoaderInfo(event.target).loader;
			var gfxClass:Class = _graphics[loader];

			loader.contentLoaderInfo.removeEventListener(Event.INIT, bitmapLoaded);

			var bitmap:Bitmap = Bitmap(loader.content);

			_graphics[gfxClass] = new RetrocamelBitmap(bitmap.bitmapData);
		}

		/**
		 * Retrieves the Bitmap of the given asset
		 * @param gfx Class of the embedded asset
		 * @param smoothing
		 * @return Bitmap od the specified class
		 */
		public static function getB(gfx:Class, smoothing:Boolean = false):RetrocamelBitmap {
			if (!_graphics[gfx]) {
				var bitmap:Bitmap = new gfx;

				_graphics[gfx] = new RetrocamelBitmap(bitmap.bitmapData);
			}

			var retrocadeBitmap:RetrocamelBitmap = new RetrocamelBitmap(RetrocamelBitmap(_graphics[gfx]).bitmapData);
			retrocadeBitmap.smoothing = smoothing;

			return retrocadeBitmap;
		}

		/**
		 * Retrieves the BitmapData of the given asset
		 * @param gfx Class of the embedded asset
		 * @return BitmapData of the specified class
		 */
		public static function getBD(gfx:Class):BitmapData {
			if (!_graphics[gfx])
				getB(gfx);

			return Bitmap(_graphics[gfx]).bitmapData;
		}
	}
}
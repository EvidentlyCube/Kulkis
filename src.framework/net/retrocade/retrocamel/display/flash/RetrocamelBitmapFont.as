

package net.retrocade.retrocamel.display.flash {
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	import net.retrocade.retrocamel.core.RetrocamelBitmapManager;
	import net.retrocade.retrocamel.core.retrocamel_int;

	use namespace retrocamel_int;

	public class RetrocamelBitmapFont {

		/**
		 * String of the default characters used by the font
		 */
		public static const DEFAULT_CHARACTER_LIST:String = " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~";

		/**
		 * The default font used by the RetrocamelBitmapText (the first set font)
		 */
		private static var _default:RetrocamelBitmapFont;

		/**
		 * The default font used by the RetrocamelBitmapText (the first set font). Can't be set to null
		 */
		public static function get defaultFont():RetrocamelBitmapFont {
			return _default;
		}

		/****************************************************************************************************************/
		/**                                                                                                  VARIABLES  */
		/****************************************************************************************************************/

		/**
		 * The font's BitmapData
		 */
		private var _bitmapdata:BitmapData;

		/**
		 * An array containing Rectangles of all the letters
		 */
		private var _letters:Array = [];

		/**
		 * Width of one bitmap character (as if it was monospaced)
		 */
		private var _bitmapCharWidth:uint;

		/**
		 * Height of one bitmap character (as if it was monospaced)
		 */
		private var _bitmapCharHeight:uint;

		/**
		 * If the font is to be displayed in Monospace mode
		 */
		private var _monospace:Boolean = false;

		/**
		 * A HELPER, so that Point doesn't have to be continously instantiated
		 */
		private var _point:Point = new Point();


		/****************************************************************************************************************/
		/**                                                                                           PUBLIC FUNCTIONS  */
		/****************************************************************************************************************/

		/**
		 * Creates a new RetrocamelBitmapTextFont. First character is always skipped, it has to be space!
		 * @param bitmapClass Embedded bitmap to be used for this font
		 * @param charWidth Width of a single character (in the map)
		 * @param charHeight Height of a single character (in the map)
		 * @param monospace If true the font will be monospaced
		 * @param spaceWidth Width of the space character
		 * @param characterList
		 */
		public function RetrocamelBitmapFont(bitmapClass:Class, charWidth:uint, charHeight:uint, monospace:Boolean = false, spaceWidth:uint = 1, characterList:String = null) {
			if (!characterList)
				characterList = DEFAULT_CHARACTER_LIST;

			_bitmapdata = RetrocamelBitmapManager.getBD(bitmapClass);

			_bitmapCharWidth = charWidth;
			_bitmapCharHeight = charHeight;

			_monospace = monospace;

			_letters[32] = new Rectangle(0, 0, spaceWidth, _bitmapCharHeight);

			for (var i:int = 1, l:int = characterList.length; i < l; i++)
				extractLetter(characterList.charCodeAt(i), i);

			if (!_default)
				_default = this;
		}

		/**
		 * Height of one line of text
		 */
		public function get fontHeight():uint {
			return _bitmapCharHeight;
		}

		/****************************************************************************************************************/
		/**                                                                                          PRIVATE FUNCTIONS  */
		/****************************************************************************************************************/

		/**
		 * Extracts the Rectangle for a given letter from the Bitmap
		 * @param charCode ASCII Code of current letter
		 * @param positionInBitmap Position of this letter in the bitmap
		 */
		private function extractLetter(charCode:uint, positionInBitmap:uint):void {
			var rect:Rectangle = new Rectangle();
			rect.x = (positionInBitmap % (_bitmapdata.width / _bitmapCharWidth)) * _bitmapCharWidth;
			rect.y = (positionInBitmap / (_bitmapdata.width / _bitmapCharWidth) | 0) * _bitmapCharHeight;

			rect.height = _bitmapCharHeight;

			if (_monospace) {
				rect.width = _bitmapCharWidth;

			} else { // Calculate font size
				for (var x:int = _bitmapCharWidth - 1; x > 0; x--) {
					var doBreak:Boolean = false;
					for (var y:int = 0; y < _bitmapCharHeight; y++) {
						if (_bitmapdata.getPixel32(rect.x + x, rect.y + y) >> 24 != 0)
							doBreak = true;
					}

					if (doBreak)
						break;
				}

				rect.width = x + 1;
			}

			_letters[charCode] = rect;
		}

		/**
		 * Draws a text from the given RetrocamelBitmapText to a new BitmapData
		 * @param bitmapText A RetrocamelBitmapText to use as a source of properties
		 * @return A bitmap data with newly drawn text
		 */
		retrocamel_int function drawText(bitmapText:RetrocamelBitmapText):BitmapData {
			if (bitmapText.text == "")
				return null;

			var i:int;
			var l:int;


			// Prepare Text Array

			var text:Array;
			var linesWidth:Array = [];

			if (bitmapText.multiline)
				text = bitmapText.text.split("\n");
			else
				text = [bitmapText.text.replace(/\n/g, '')];


			// Calculate dimensions

			var calcWidth:uint = 0;
			var calcHeight:uint;

			for (i = 0, l = text.length; i < l; i++) {
				linesWidth[i] = calculateLineWidth(text[i], bitmapText.letterSpace);

				if (calcWidth < linesWidth[i])
					calcWidth = linesWidth[i];
			}

			calcHeight = text.length * (_bitmapCharHeight + bitmapText.lineSpace) - bitmapText.lineSpace;

			if (calcWidth <= 0) calcWidth = 1;
			if (calcHeight <= 0) calcHeight = 1;

			//So there is always one pixel of right-bottom padding
			calcWidth++;
			calcHeight++;


			// Start!

			var bitmap:BitmapData = new BitmapData(calcWidth, calcHeight, true, 0x00000000);

			for (i = 0; i < l; i++) {
				switch (bitmapText.align) {
					case RetrocamelBitmapText.ALIGN_LEFT:
						drawLine(bitmap, text[i], 0, i * (_bitmapCharHeight + bitmapText.lineSpace), bitmapText);
						break;

					case RetrocamelBitmapText.ALIGN_MIDDLE:
						drawLine(bitmap, text[i], (calcWidth - linesWidth[i] - 1) / 2, i * (_bitmapCharHeight + bitmapText.lineSpace), bitmapText);
						break;

					case RetrocamelBitmapText.ALIGN_RIGHT:
						drawLine(bitmap, text[i], calcWidth - linesWidth[i] - 1, i * (_bitmapCharHeight + bitmapText.lineSpace), bitmapText);
						break;
				}
			}

			return bitmap;
		}

		/**
		 * Draws a line of text on specified coordinates
		 * @param bitmap Bitmap to draw to
		 * @param text Text to draw
		 * @param x X coordinate of where the text has to be start drawing
		 * @param y Y coordinate of where the text has to be start drawing
		 * @param bitmapText RetrocamelBitmapText used for properties
		 */
		retrocamel_int function drawLine(bitmap:BitmapData, text:String, x:uint, y:uint, bitmapText:RetrocamelBitmapText):void {
			var i:int = 0;
			var l:int = text.length;
			var c:uint = 0;

			_point.x = x;
			_point.y = y;

			for (; i < l; i++) {
				c = text.charCodeAt(i);
				if (_letters[c] == undefined)
					c = 32;
				bitmap.copyPixels(_bitmapdata, _letters[c], _point, null, null, true);
				_point.x += _letters[c].width + bitmapText.letterSpace;
			}
		}

		/**
		 * Calculates a width in pixel of a line of text
		 * @param text Line of text to calculate
		 * @param letterSpacing space between each character
		 * @return Width of the line in pixels
		 */
		retrocamel_int function calculateLineWidth(text:String, letterSpacing:uint):uint {
			var length:uint = 0;
			var c:uint;
			for (var i:int = 0, l:int = text.length; i < l; i++) {
				c = text.charCodeAt(i);
				if (_letters[c] == undefined)
					c = 32;
				length += _letters[c].width + letterSpacing;
			}

			return length > 0 ? length - letterSpacing : 0;
		}
	}
}
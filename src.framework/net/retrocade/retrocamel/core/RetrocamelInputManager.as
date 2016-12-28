package net.retrocade.retrocamel.core {
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;

	import net.retrocade.signal.Signal;

	use namespace retrocamel_int;

	public class RetrocamelInputManager {

		public static var lockKeyboard:Boolean = false;

		/**
		 * Array containing hold down keys
		 */
		private static var _keyDowns:Array = new Array(256);

		/**
		 * Array containing hit keys
		 */
		private static var _keyHits:Array = new Array(256);

		/**
		 * A Boolean indicating if the mouse button is down.
		 */
		private static var _isMouseDown:Boolean = false;

		/**
		 * Returns true if the mouse button is down.
		 */
		public static function isMouseDown():Boolean {
			return _isMouseDown;
		}

		private static var _stage:Stage;

		private static var _keyDownSignal:Signal = new Signal(1);


		public static function get keyDownSignal():Signal {
			return _keyDownSignal;
		}


		public static function isKeyDown(keyCode:int):Boolean {
			return _keyDowns[keyCode % 256] && !lockKeyboard;
		}

		/**
		 * Checks if the specified key is hit
		 * @param keyCode KeyCode of the key to check if is hit
		 * @return True if the given key is hit
		 */
		public static function isKeyHit(keyCode:int):Boolean {
			return _keyHits[keyCode % 256] && !lockKeyboard;
		}

		/**
		 * Adds KeyboardEvent.KEY_DOWN event to the stage.
		 * @param f Function to be added to listening
		 * @param weakReference Whether to use te weak reference
		 * @param priority Priority of the function
		 */
		public static function addStageKeyDown(f:Function, weakReference:Boolean = true, priority:int = 0):void {
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, f, false, priority, weakReference);
		}


		// ::::::::::::::::::::::::::::::::::::::::::::::::
		// :: Removing Keyboard Listeners
		// ::::::::::::::::::::::::::::::::::::::::::::::::

		/**
		 * Remove KeyboardEvent.KEY_DOWN event from the stage
		 * @param f Function to be removed from listening
		 */
		public static function removeStageKeyDown(f:Function):void {
			_stage.removeEventListener(KeyboardEvent.KEY_DOWN, f);
		}

		internal static function initialize(stage:Stage):void {
			if (_stage) {
				throw new Error("You can't initialize the framework more than once!");
			}
			if (!stage) {
				throw new Error("You have to pass a valid Stage object!");
			}

			//Init Variables

			_stage = stage;

			for (var i:int = 0; i < 256; i++) {
				_keyDowns[i] = false;
				_keyHits [i] = false;
			}

			//Init listeners

			_stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			_stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			_stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			_stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}

		/**
		 * Internal framework update function. Flushes isMousHit and keyHits
		 */
		retrocamel_int static function onEnterFrameUpdate():void {
			for (var i:int = 0; i < 256; i++) {
				_keyHits [i] = false;
			}
		}

		// ==========================================================================================================================================
		// ==                                                                                                                     EVENT LISTENERS
		// ==========================================================================================================================================

		// ::::::::::::::::::::::::::::::::::::::::::::::::
		// :: Keyboard related
		// ::::::::::::::::::::::::::::::::::::::::::::::::

		private static function onKeyDown(e:KeyboardEvent):void {
			_keyHits [e.keyCode % 256] = _keyDowns[e.keyCode % 256] = true;

			_keyDownSignal.call(e.keyCode);

		}

		private static function onKeyUp(e:KeyboardEvent):void {
			_keyDowns[e.keyCode % 256] = false;
		}


		// ::::::::::::::::::::::::::::::::::::::::::::::::
		// :: Mouse related
		// ::::::::::::::::::::::::::::::::::::::::::::::::

		private static function onMouseMove(e:MouseEvent):void {
			_isMouseDown = e.buttonDown;
		}

		private static function onMouseDown(e:MouseEvent):void {
			_isMouseDown = e.buttonDown;
		}

		private static function onMouseUp(e:MouseEvent):void {
			_isMouseDown = e.buttonDown;
		}
	}
}
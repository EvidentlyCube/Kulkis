package game.global.preloader {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	import flash.utils.getTimer;

	import game.global.Pre;
	import game.global.Sfx;
	import game.states.TStateLang;
	import game.states.TStatePreload;

	import net.retrocade.retrocamel.core.RetrocamelCore;
	import net.retrocade.retrocamel.core.RetrocamelDisplayManager;
	import net.retrocade.retrocamel.display.layers.RetrocamelLayerFlashBlit;
	import net.retrocade.retrocamel.display.layers.RetrocamelLayerFlashSprite;
	import net.retrocade.retrocamel.effects.RetrocamelEffectFadeScreen;

	/**
	 * ...
	 * @author Maurycy Zarzycki
	 */
	public class Preloader extends MovieClip {
		public static var loaderLayer:RetrocamelLayerFlashSprite;
		public static var loaderLayerBG:RetrocamelLayerFlashBlit;

		public static var percent:Number = 0;

		/****************************************************************************************************************/
		/**                                                                                                  VARIABLES  */
		/****************************************************************************************************************/

		private var _afterAd:Boolean = false;
		private var _afterLoad:Boolean = false;

		private var _startedAt:Number;

		/****************************************************************************************************************/
		/**                                                                                                  FUNCTIONS  */
		/****************************************************************************************************************/

		public function Preloader() {
			/*var lc:LocalConnection = new LocalConnection();
			 if (lc.domain.indexOf("localhost") == -1 && 
			 lc.domain.indexOf("flashgamelicense") == -1)
			 return;
			 /*
			 if ((new Date).fullYear > 2011 || (new Date).month > 6 || (new Date).day > 31)
			 return;
			 */

			addEventListener(Event.ENTER_FRAME, init);
		}

		private function init(e:Event):void {
			if (!stage)
				return;

			removeEventListener(Event.ENTER_FRAME, init);

			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.frameRate = 60;

			Pre.preCoreInit();

			RetrocamelCore.initFlash(stage, this, S(), null);
			Sfx.initialize();
			Sfx.startGenerating(soundMakeFinished);
			RetrocamelDisplayManager.setBackgroundColor(0);

			Pre.init();

			loaderLayerBG = new RetrocamelLayerFlashBlit();
			loaderLayer = new RetrocamelLayerFlashSprite();
			loaderLayerBG.setScale(2, 2);

			RetrocamelCore.setState(new TStatePreload());

			initLanguageSelection();

			addEventListener(Event.ENTER_FRAME, checkFrame);

			_startedAt = getTimer();
		}

		private function checkFrame(e:Event):void {
			percent = stage.loaderInfo.bytesLoaded * 100 / stage.loaderInfo.bytesTotal;
			if (stage.loaderInfo.bytesLoaded >= stage.loaderInfo.bytesTotal) {
				gotoAndStop(2);
				removeEventListener(Event.ENTER_FRAME, checkFrame);

				dispatchEvent(new Event("gameloaded", false, false));

				_afterLoad = true;

				if (_afterAd)
					initLanguageSelection();

			}
		}

		private function initLanguageSelection():void {
			if (!_afterLoad) {
				_afterAd = true;
				return;
			}

			RetrocamelEffectFadeScreen.makeOut().duration(500).callback(loadLanguagesState).run();
		}

		private function loadLanguagesState():void {
			RetrocamelEffectFadeScreen.makeIn().duration(500).run();

			RetrocamelCore.setState(new TStateLang(startup));
		}

		private function soundMakeFinished():void {
			stage.frameRate = 60;
		}

		public function startup():void {
			loaderLayer.removeLayer();
			loaderLayerBG.removeLayer();

			stage.focus = stage;

			var mainClass:Class = Class(getDefinitionByName("game.global.Main"));
			addChild(new mainClass() as DisplayObject);
			stage.frameRate = 60;
		}

	}

} 
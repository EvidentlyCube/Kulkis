package game.states {
import flash.display.Bitmap;

import net.retrocade.retrocamel.components.RetrocamelStateBase;
import net.retrocade.retrocamel.core.RetrocamelCore;
import net.retrocade.retrocamel.core.RetrocamelDisplayManager;

/**
 * ...
 * @author
 */
public class TStateLogoSplash extends RetrocamelStateBase {
    [Embed(source="../../../src.assets/bgs/ec_logo.png")]
    private static var _logo_ec_class_:Class;

    private var _logo:Bitmap;
    private var _timer:Number = 0;

    override public function create():void {
        _logo = new _logo_ec_class_();
        _logo.smoothing = true;

        _logo.alpha = 0;

        RetrocamelDisplayManager.flashApplication.addChild(_logo);
    }

    override public function destroy():void {
        RetrocamelDisplayManager.flashApplication.removeChild(_logo);
    }

    override public function update():void {
        _timer += Math.PI / 300;
        _logo.alpha = Math.sin(_timer) * 1.4;

        if (_timer >= Math.PI) {
            RetrocamelCore.setState(TStateTitle.instance);
        }
    }
}
}
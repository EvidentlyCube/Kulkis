package game.objects {
import flash.display.BitmapData;

import game.global.Game;

import net.retrocade.constants.KeyConst;

import net.retrocade.retrocamel.core.RetrocamelBitmapManager;
import net.retrocade.retrocamel.core.RetrocamelInputManager;
import net.retrocade.utils.UtilsObjects;

/**
 * ...
 * @author
 */
public class TSpikes extends TGameObject {
    [Embed(source="/../src.assets/sprites/spikes.png")]
    public static var _gfx_spikes_:Class;

    private var _bd:BitmapData;
    private var _isDestroyed:Boolean;

    public function TSpikes(x:Number, y:Number) {
        _x = x;
        _y = y;

        _width = 16;
        _height = 16;

        _bd = RetrocamelBitmapManager.getBD(_gfx_spikes_);

        addDefault();

        update();
    }

    override public function update():void {
        if (_isDestroyed || RetrocamelInputManager.isKeyDown(KeyConst.F6)){
            _isDestroyed = true;
            return;
        }
        Game.lGame.draw(_bd, x, y);

        if (!player)
            return;

        if (UtilsObjects.distanceSquaredFromCenter(this, player) < 12 * 12) {
            player.kill();
        }
    }
}
}
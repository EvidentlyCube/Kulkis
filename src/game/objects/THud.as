package game.objects {
import flash.display.BitmapData;

import game.global.Game;
import game.global.Make;
import game.global.Score;

import net.retrocade.retrocamel.components.RetrocamelUpdatableObject;
import net.retrocade.retrocamel.core.RetrocamelBitmapManager;
import net.retrocade.retrocamel.core.RetrocamelCore;
import net.retrocade.retrocamel.display.flash.RetrocamelBitmapText;
import net.retrocade.retrocamel.display.layers.RetrocamelLayerFlashBlit;
import net.retrocade.retrocamel.locale._;
import net.retrocade.utils.UtilsString;

/**
 * ...
 * @author
 */
public class THud extends RetrocamelUpdatableObject {
    private static var _instance:THud = new THud;
    public static function get instance():THud {
        return _instance;
    }

    private var _layer:RetrocamelLayerFlashBlit;

    private var _level:RetrocamelBitmapText;

    public function THud() {
        _level = Make.text("", 0xFFFFFF, 2);
        _level.cache = true;
        _level.addShadow();

        _level.y = 1;
        _level.x = 0;
    }

    override public function update():void {
        _level.text = _("Level:") + " " + Score.level.get();

        _level.x = (S().gameWidth - _level.width) / 2;
    }

    public function hookTo(layer:RetrocamelLayerFlashBlit):void {
        RetrocamelCore.groupAfter.add(this);
        _layer = layer;

        Game.lMain.add(_level);
    }

    public function unhook():void {
        RetrocamelCore.groupAfter.nullify(this);
        if (Game.lMain.contains(_level))
            Game.lMain.remove(_level);
    }
}
}
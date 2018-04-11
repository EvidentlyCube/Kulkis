package game.objects {
import game.global.Game;
import game.global.Level;
import game.tiles.TTile;

import net.retrocade.retrocamel.components.RetrocamelDisplayObject;
import net.retrocade.retrocamel.components.RetrocamelUpdatableGroup;

public class TGameObject extends RetrocamelDisplayObject {
    public function getTile(x:Number, y:Number):TTile {
        return Level.level.getTile(x, y);
    }

    override public function get defaultGroup():RetrocamelUpdatableGroup {
        return Game.gAll;
    }

    public function get player():TPlayer {
        return Level.player;
    }
}
}
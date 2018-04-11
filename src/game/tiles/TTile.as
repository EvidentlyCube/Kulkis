package game.tiles {
import flash.display.BitmapData;

import game.global.Game;
import game.global.Level;
import game.objects.TGameObject;

import net.retrocade.retrocamel.components.RetrocamelUpdatableObject;

public class TTile extends RetrocamelUpdatableObject {
    protected var _x:Number;
    protected var _y:Number;

    protected var _w:Number;
    protected var _h:Number;

    public function TTile(x:Number, y:Number, code:uint) {
    }

    public function hitRight(o:TGameObject):void {
        o.x = _x + _w;
    }

    public function hitLeft(o:TGameObject):void {
        o.right = _x - 1;
    }

    public function hitTop(o:TGameObject):void {
        o.bottom = _y - 1;
    }

    public function hitBottom(o:TGameObject):void {
        o.y = _y + _h;
    }

    final protected function setLevel():void {
        for (var i:int = 0; i < _w / S().TILE_GRID_TILE_WIDTH; i++) {
            for (var j:int = 0; j < _h / S().TILE_GRID_TILE_HEIGHT; j++) {
                Level.level.setTile(_x + i * S().TILE_GRID_TILE_WIDTH, _y + j * S().TILE_GRID_TILE_HEIGHT, this);
            }
        }
    }

    final protected function unsetLevel():void {
        for (var i:int = 0; i < _w / S().TILE_GRID_TILE_WIDTH; i++) {
            for (var j:int = 0; j < _h / S().TILE_GRID_TILE_HEIGHT; j++) {
                Level.level.setTile(_x + i * S().TILE_GRID_TILE_WIDTH, _y + j * S().TILE_GRID_TILE_HEIGHT, null);
            }
        }
    }

    final protected function drawMe(gfx:BitmapData):void {
        Game.lBG.draw(gfx, _x, _y);
    }

}
}
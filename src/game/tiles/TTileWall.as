package game.tiles {
import flash.display.BitmapData;

import net.retrocade.retrocamel.core.RetrocamelBitmapManager;

/**
 * ...
 * @author
 */
public class TTileWall extends TTile {
    [Embed(source="/../src.assets/tiles/tile1x1-00.png")]
    public static var _gfx_tile_1_:Class;
    [Embed(source="/../src.assets/tiles/tile1x1-01.png")]
    public static var _gfx_tile_2_:Class;
    [Embed(source="/../src.assets/tiles/tile1x1-02.png")]
    public static var _gfx_tile_3_:Class;
    [Embed(source="/../src.assets/tiles/tile1x1-03.png")]
    public static var _gfx_tile_4_:Class;
    [Embed(source="/../src.assets/tiles/tile1x1-04.png")]
    public static var _gfx_tile_5_:Class;
    [Embed(source="/../src.assets/tiles/tile1x1-05.png")]
    public static var _gfx_tile_6_:Class;
    [Embed(source="/../src.assets/tiles/tile1x1-06.png")]
    public static var _gfx_tile_7_:Class;
    [Embed(source="/../src.assets/tiles/tile1x1-07.png")]
    public static var _gfx_tile_8_:Class;
    [Embed(source="/../src.assets/tiles/tile1x1-08.png")]
    public static var _gfx_tile_9_:Class;
    [Embed(source="/../src.assets/tiles/tile1x1-09.png")]
    public static var _gfx_tile_10_:Class;
    [Embed(source="/../src.assets/tiles/tile1x1-10.png")]
    public static var _gfx_tile_11_:Class;
    [Embed(source="/../src.assets/tiles/tile1x1-11.png")]
    public static var _gfx_tile_12_:Class;
    [Embed(source="/../src.assets/tiles/tile1x1-12.png")]
    public static var _gfx_tile_13_:Class;
    [Embed(source="/../src.assets/tiles/tile1x1-13.png")]
    public static var _gfx_tile_14_:Class;
    [Embed(source="/../src.assets/tiles/tile1x1-14.png")]
    public static var _gfx_tile_15_:Class;
    [Embed(source="/../src.assets/tiles/tile1x1-15.png")]
    public static var _gfx_tile_16_:Class;
    [Embed(source="/../src.assets/tiles/tile1x1-16.png")]
    public static var _gfx_tile_17_:Class;
    [Embed(source="/../src.assets/tiles/tile1x2-00.png")]
    public static var _gfx_tile_18_:Class;
    [Embed(source="/../src.assets/tiles/tile1x2-01.png")]
    public static var _gfx_tile_19_:Class;
    [Embed(source="/../src.assets/tiles/tile1x2-02.png")]
    public static var _gfx_tile_20_:Class;
    [Embed(source="/../src.assets/tiles/tile1x2-03.png")]
    public static var _gfx_tile_21_:Class;
    [Embed(source="/../src.assets/tiles/tile2x1-00.png")]
    public static var _gfx_tile_22_:Class;
    [Embed(source="/../src.assets/tiles/tile2x1-01.png")]
    public static var _gfx_tile_23_:Class;
    [Embed(source="/../src.assets/tiles/tile2x1-02.png")]
    public static var _gfx_tile_24_:Class;
    [Embed(source="/../src.assets/tiles/tile2x1-03.png")]
    public static var _gfx_tile_25_:Class;
    [Embed(source="/../src.assets/tiles/tile2x2-00.png")]
    public static var _gfx_tile_26_:Class;
    [Embed(source="/../src.assets/tiles/tile2x2-01.png")]
    public static var _gfx_tile_27_:Class;
    [Embed(source="/../src.assets/tiles/tile2x2-02.png")]
    public static var _gfx_tile_28_:Class;
    [Embed(source="/../src.assets/tiles/tile2x2-03.png")]
    public static var _gfx_tile_29_:Class;
    [Embed(source="/../src.assets/tiles/tile2x2-04.png")]
    public static var _gfx_tile_30_:Class;

    public function TTileWall(x:Number, y:Number, code:uint) {
        super(x, y, code);

        var cls:BitmapData = RetrocamelBitmapManager.getBD(TTileWall['_gfx_tile_' + code + '_']);

        _x = x;
        _y = y;

        _w = cls.width;
        _h = cls.height;

        setLevel();

        drawMe(cls);
    }

}

}
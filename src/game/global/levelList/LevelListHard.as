package game.global.levelList {
import flash.utils.ByteArray;
import flash.utils.Dictionary;

public class LevelListHard implements ILevelList {
    [Embed(source='/../src.levels/hard/1.lvl', mimeType="application/octet-stream")]
    private static var _level_1_:Class;
    [Embed(source='/../src.levels/hard/2.lvl', mimeType="application/octet-stream")]
    private static var _level_2_:Class;
    [Embed(source='/../src.levels/hard/3.lvl', mimeType="application/octet-stream")]
    private static var _level_3_:Class;
    [Embed(source='/../src.levels/hard/4.lvl', mimeType="application/octet-stream")]
    private static var _level_4_:Class;
    [Embed(source='/../src.levels/hard/5.lvl', mimeType="application/octet-stream")]
    private static var _level_5_:Class;
    [Embed(source='/../src.levels/hard/6.lvl', mimeType="application/octet-stream")]
    private static var _level_6_:Class;
    [Embed(source='/../src.levels/hard/7.lvl', mimeType="application/octet-stream")]
    private static var _level_7_:Class;
    [Embed(source='/../src.levels/hard/8.lvl', mimeType="application/octet-stream")]
    private static var _level_8_:Class;
    [Embed(source='/../src.levels/hard/9.lvl', mimeType="application/octet-stream")]
    private static var _level_9_:Class;
    [Embed(source='/../src.levels/hard/10.lvl', mimeType="application/octet-stream")]
    private static var _level_10_:Class;
    [Embed(source='/../src.levels/hard/11.lvl', mimeType="application/octet-stream")]
    private static var _level_11_:Class;
    [Embed(source='/../src.levels/hard/12.lvl', mimeType="application/octet-stream")]
    private static var _level_12_:Class;
    [Embed(source='/../src.levels/hard/13.lvl', mimeType="application/octet-stream")]
    private static var _level_13_:Class;
    [Embed(source='/../src.levels/hard/14.lvl', mimeType="application/octet-stream")]
    private static var _level_14_:Class;
    [Embed(source='/../src.levels/hard/15.lvl', mimeType="application/octet-stream")]
    private static var _level_15_:Class;
    [Embed(source='/../src.levels/hard/16.lvl', mimeType="application/octet-stream")]
    private static var _level_16_:Class;
    [Embed(source='/../src.levels/hard/17.lvl', mimeType="application/octet-stream")]
    private static var _level_17_:Class;
    [Embed(source='/../src.levels/hard/18.lvl', mimeType="application/octet-stream")]
    private static var _level_18_:Class;
    [Embed(source='/../src.levels/hard/19.lvl', mimeType="application/octet-stream")]
    private static var _level_19_:Class;
    [Embed(source='/../src.levels/hard/20.lvl', mimeType="application/octet-stream")]
    private static var _level_20_:Class;
    [Embed(source='/../src.levels/hard/21.lvl', mimeType="application/octet-stream")]
    private static var _level_21_:Class;
    [Embed(source='/../src.levels/hard/22.lvl', mimeType="application/octet-stream")]
    private static var _level_22_:Class;
    [Embed(source='/../src.levels/hard/23.lvl', mimeType="application/octet-stream")]
    private static var _level_23_:Class;
    [Embed(source='/../src.levels/hard/24.lvl', mimeType="application/octet-stream")]
    private static var _level_24_:Class;
    [Embed(source='/../src.levels/hard/25.lvl', mimeType="application/octet-stream")]
    private static var _level_25_:Class;

    private static var _levels:Dictionary = new Dictionary();

    public function getLevel(id:int):ByteArray {
        if (!_levels[id])
            _levels[id] = new LevelListHard['_level_' + id + '_'];

        ByteArray(_levels[id]).position = 0;
        return _levels[id];
    }
}
}

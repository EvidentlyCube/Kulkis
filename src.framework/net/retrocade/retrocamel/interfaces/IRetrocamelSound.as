

package net.retrocade.retrocamel.interfaces {
    public interface IRetrocamelSound {
        function play(loop:uint = 0, volumeModifier:Number = 1, pan:Number = 0):void;
        function stop():void;
        function get position():Number;
        function get length():Number;
    }
}


package net.retrocade.retrocamel.particles {

    import net.retrocade.retrocamel.components.RetrocamelUpdatableGroup;
    import net.retrocade.retrocamel.core.RetrocamelCore;
    import net.retrocade.retrocamel.display.layers.RetrocamelLayerFlashBlit;
    import net.retrocade.retrocamel.components.RetrocamelUpdatableObject;

    /**
     * ...
     * @author ...
     */
    public class RetrocamelParticlesPixel extends RetrocamelUpdatableObject {
        private var _blitLayer:RetrocamelLayerFlashBlit;
        private var _pixels:Vector.<Vector.<int>>;  //[x, y, color, life, xSpeed, ySpeed]
        private var _aliveParticles:uint = 0;

        public function RetrocamelParticlesPixel(blitLayer:RetrocamelLayerFlashBlit, maxParticles:uint = 100) {
            addDefault();

            _blitLayer = blitLayer;

            if (!_blitLayer) {
                throw new ArgumentError('blitLayer cannot be null!');
            }

            _pixels = new Vector.<Vector.<int>>(maxParticles, true);
            for (var i:int = 0; i < maxParticles; i++) {
                _pixels[i] = new Vector.<int>(6, true);
            }
        }


        override public function get defaultGroup():RetrocamelUpdatableGroup {
            return RetrocamelCore.groupAfter;
        }

        override public function update():void {
            _blitLayer.clear();

            var i:int = _aliveParticles;
            while (i--) {
                if (--_pixels[i][3] < 0) {
                    var temp:Vector.<int> = _pixels[i];
                    _pixels[i] = _pixels[--_aliveParticles];
                    _pixels[_aliveParticles] = temp;
                    continue;
                }

                _blitLayer.plot(_pixels[i][0] / 100, _pixels[i][1] / 100, _pixels[i][2]);
                _pixels[i][0] += _pixels[i][4];
                _pixels[i][1] += _pixels[i][5];
            }
        }

        public function clear():void {
            _aliveParticles = 0;
        }

        public function add(x:Number, y:Number, color:Number, life:Number, speedX:Number, speedY:Number):void {
            if (_aliveParticles == _pixels.length || (color & 0xFF000000) == 0) {
                return;
            }

            _pixels[_aliveParticles][0] = x * 100;
            _pixels[_aliveParticles][1] = y * 100;
            _pixels[_aliveParticles][2] = color;
            _pixels[_aliveParticles][3] = life;
            _pixels[_aliveParticles][4] = speedX;
            _pixels[_aliveParticles++][5] = speedY;
        }
    }

}
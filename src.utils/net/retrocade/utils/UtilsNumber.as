

package net.retrocade.utils {
   /**
    * An utility class which containst number-related functions
    *
    * @author Maurycy Zarzycki
    */
    public class UtilsNumber{
        /**
         * Modifies Initial to get closer to Target by a Factor, and rounds to it when the difference is equal or smaller to RoundWhen
         *
         * @param initial The number to be changed
         * @param target Target number
         * @param factor Factor by which the initial number is to be modified
         * @param roundWhen Set to target when difference between initial and target is smaller than
         * @param maxSpeed Maximum amount of change in one call
         * @return The new number
         */
        public static function approach(initial:Number, target:Number, factor:Number = 0.1, roundWhen:Number = 0.1, maxSpeed:Number = NaN):Number{
            if (isNaN(maxSpeed))
                initial += (target - initial) * factor;
            else
                initial += limit((target - initial) * factor, maxSpeed);

            if (target - initial <= roundWhen && target - initial >= -roundWhen)
                initial = target;

            return initial;
        }

        public static function approachStep(initial:Number, target:Number, step:Number = 0.1):Number{
            if (initial < target){
                return limit(initial + step, initial, target);
            } else {
                return limit(initial - step, target, initial);
            }
        }

        /**
         * Calculates the distance, using the Pythagorean theorem
         *
         * @param	x1 X of the first object
         * @param	y1 Y of the first object
         * @param	x2 X of the second object
         * @param	y2 Y of the second object
         * @return Distance between the objects
         */
        public static function distanceSquared(x1:Number, y1:Number, x2:Number, y2:Number):Number{
            return (x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1);
        }
        
        /**

        /**
         * Converts an HSV color to RGB
         * @param	hue Hue (0 - 360)
         * @param	sat Saturation (0 - 1)
         * @param	val (0 - 1)
         * @return RGB color
         */
        public static function hsvToRGB(hue:Number, sat:Number, val:Number):uint{
            hue = hue % 360;

            var i:int;
            var f:Number;
            var p:Number;
            var q:Number;
            var t:Number;
            var h:Number;
            var r:uint;
            var g:uint;
            var b:uint;

            if (sat == 0){
                r = val * 255;
                g = val * 255;
                b = val * 255;
                return (r << 16) | (g << 8) | b;
            }

            h = hue / 60;
            i = h | 0;
            f = h - i;
            p = val * (1 - sat);
            q = val * (1 - sat * f);
            t = val * (1 - sat * (1 - f));

            switch(i){
                case(0):
                    r = val * 255;
                    g = t * 255;
                    b = p * 255;
                    break;

                case(1):
                    r = q * 255;
                    g = val * 255;
                    b = p * 255;
                    break;

                case(2):
                    r = p * 255;
                    g = val * 255;
                    b = t * 255;
                    break;

                case(3):
                    r = p * 255;
                    g = q * 255;
                    b = val * 255;
                    break;

                case(4):
                    r = t * 255;
                    g = p * 255;
                    b = val * 255;
                    break;

                case(5):
                    r = val * 255;
                    g = p * 255;
                    b = q * 255;
                    break;
            }

            return (r << 16) | (g << 8) | b;
        }

        /**
         * Modifies the passed variable so that it doesn't exceed set limits
         *
         * @param limited The number to be modified
         * @param topLimit The largest value the variable can be
         * @param mirror If set to true, bottomLimit is set to negated value of topLimited
         * @param bottomLimit The smallest value the variable can be
         * @return The modified number
         */
        public static function limit(limited:Number, topLimit:Number = NaN, bottomLimit:Number = NaN, mirror:Boolean = true):Number {
            if (mirror && isNaN(bottomLimit)) {
                bottomLimit = -topLimit;
            }

            if (bottomLimit > topLimit) {
                var temp:Number = bottomLimit;
                bottomLimit = topLimit;
                topLimit = temp;
            }

            if (!isNaN(topLimit) && limited > topLimit) {
                return topLimit;
            }

            if (!isNaN(bottomLimit) && limited < bottomLimit) {
                return bottomLimit;
            }

            return limited;
        }


        /**
         * Using standard Math.net.retrocade.random(), it gives you a net.retrocade.random number which is in range:
         * <start - wave, start + wave>
         *
         * @param	start Initial value which will be offsetted by wave
         * @param	wave Maximum offset from start
         * @return A net.retrocade.random number
         */
        public static function randomWaved(start:Number, wave:Number):Number{
            return start + (Math.random() * 2 - 1) * wave;
        }
    }
}
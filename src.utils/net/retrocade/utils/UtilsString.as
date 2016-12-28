

package net.retrocade.utils {
   /**
    * An utility class which containst string-related functions
    *
    * @author Maurycy Zarzycki
    */
    public class UtilsString {
        /****************************************************************************************************************/
        /**                                                                                                  VARIABLES  */
        /****************************************************************************************************************/

        /****************************************************************************************************************/
        /**                                                                                                  FUNCTIONS  */
        /****************************************************************************************************************/

        /**
         * Adds characters at the beginning of a string to make it at least as long as length. Useful for making 0001 types
         * of strings. If the string is already longer than given length, nothing happens.
         *
         * @param toPad A string to be filled with trailing character
         * @param length A target string length
         * @param filler A characters to be added to the beginning of the string to make it at least long as length. Note,
         *        that using a more than one character long string may result in the target string being longer than
         *        specified length.
         * @return A modified string
         */
        public static function padLeft(toPad:Object, length:Number, filler:String = "0"):String {
            var string:String = (toPad ? toPad.toString() : '');

            while (string.length < length) {
                string=filler + string;
            }

            return string;
        }


        /**
         * Strip whitespace (or other characters) from the beginning and end of a string
         *
         * @param string A string to be trimmed
         * @param trimmables An array of characters to be trimmed. If nothing is specified, it uses following list:
         * ASCII 32 (0x20), an ordinary space;
         * ASCII 9  (0x09), a tab;
         * ASCII 10 (0x0A), a new line (line feed);
         * ASCII 13 (0x0D), a carriage return;
         * ASCII 0  (0x00), the NUL-byte;
         * ASCII 11 (0x0B), a vertical tab;
         * @param left Whether to trim the left side
         * @param right Whether to trim the right side
         * @return Trimmed string
         */
        public static function trim(string:String, trimmables:Array = null, left:Boolean = true, right:Boolean = true):String {
            var i:int;

            if (!trimmables) {
                trimmables = [32, 9, 10, 13, 0, 11];

            } else {
                i = trimmables.length;
                while (i--) {
                    if (trimmables[i] is String)
                        trimmables[i] = String(trimmables[i]).charCodeAt();

                    else if (!(trimmables[i] is Number))
                        throw new TypeError("Trimmables has to be an array of strings or character codes");
                }
            }

            //Trim Left
            if (left)
                while (trimmables.indexOf(string.charCodeAt(0)) > -1) {
                    string=string.substr(1);
                }

            //Trim Right
            if (right)
                while (trimmables.indexOf(string.charCodeAt(string.length - 1)) > -1) {
                    string=string.substr(0, string.length - 1);
                }

            return string;
        }
   }
}
package net.retrocade.retrocamel.locale {
    import flash.utils.ByteArray;

    public class RetrocamelLocaleParserAbstract {
        protected static function getText(textContainer:*):String{
            if (textContainer is String){
                return textContainer as String;
            } else if (textContainer is Class){
                var fileArray:ByteArray = new textContainer;
                return fileArray.readUTFBytes(fileArray.length);
            } else {
                throw new ArgumentError("Invalid text container");
            }
        }
    }
}

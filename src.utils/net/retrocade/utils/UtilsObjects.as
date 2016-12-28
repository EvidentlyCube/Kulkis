package net.retrocade.utils {
	import flash.utils.ByteArray;

	/**
	 * ...
	 * @author
	 */
	public class UtilsObjects {
		public static function toString(object:Object):String {
			var byteArray:ByteArray = new ByteArray();
			byteArray.writeObject(object);

			byteArray.position = 0;

			return byteArray.readUTFBytes(byteArray.length);
		}

		public static function distanceSquaredFromCenter(left:Object, right:Object):Number {
			return UtilsNumber.distanceSquared(left.x + left.width / 2, left.y + left.height / 2, right.x + right.width / 2, right.y + right.height / 2);
		}
	}
}
package game.global.levelList {
	import flash.utils.ByteArray;

	public interface ILevelList {
		function getLevel(index:int):ByteArray;
	}
}

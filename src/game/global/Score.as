package game.global {
import net.retrocade.vault.Safe;

public class Score {
    public static var level:Safe = new Safe(1);

    public static var mostLevelsNoDeath:Safe = new Safe();


    public static function resetGameStart():void {
        level.set(1);


        mostLevelsNoDeath.set(0);
    }

    public static function blockDestroyed():void {
    }
}
}
package game.global{
    import net.retrocade.vault.Safe;

    public class Score{
        public static var level:Safe = new Safe(1);
        public static var score:Safe = new Safe(0);
        public static var lives:Safe = new Safe(3);
        
        public static var scoreAtLevelStart:Safe = new Safe(0);
        
        public static var bestScore:Safe = new Safe(0);
        
        public static var mostLevelsNoDeath:Safe = new Safe();
        public static var mostLevelsNoGameOver:Safe = new Safe();
        
        public static var multiplier:Safe = new Safe(1);
        
        public static function resetGameStart():void{
            score.set(0);
            lives.set(0);
            level.set(1);
            
            
            mostLevelsNoDeath.set(0);
            mostLevelsNoGameOver.set(0);
        }
        
        public static function blockDestroyed():void{
            score.add(5 * multiplier.get() | 0);
            multiplier.set(10);
            
            if (bestScore.get() < score.get())
                bestScore.set(score.get());
        }
    }
}
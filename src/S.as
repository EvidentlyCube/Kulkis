package {
public function S():SettingsClass {
    return SettingsClass.instance;
}
}

import net.retrocade.retrocamel.interfaces.IRetrocamelSettings;

class SettingsClass implements IRetrocamelSettings {
    public static var instance:SettingsClass = new SettingsClass();


    // ::::::::::::::::::::::::::::::::::::::::::::::
    // :: Game Settings
    // ::::::::::::::::::::::::::::::::::::::::::::::

    public function get eventsCount():uint {
        return 1;
    }

    public function get languages():Array {
        return ['en', 'pl'];
    }

    public function get languagesNames():Array {
        return ['English', 'Polski'];
    }

    public function get gameWidth():uint {
        return 512;
    }

    public function get gameHeight():uint {
        return 448;
    }

    public function get levelWidth():uint {
        return 256;
    }

    public function get levelHeight():uint {
        return 224;
    }

    public const TILE_GRID_TILE_WIDTH:Number = 16;
    public const TILE_GRID_TILE_HEIGHT:Number = 16;
    public const TILE_GRID_WIDTH:Number = 16;
    public const TILE_GRID_HEIGHT:Number = 14;
}
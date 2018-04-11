package game.global {
import net.retrocade.retrocamel.interfaces.IRetrocamelUpdatable;

public class UpdateCallbackObject implements IRetrocamelUpdatable {
    private var _callback:Function;


    public function UpdateCallbackObject(callback:Function) {
        _callback = callback;
    }

    public function update():void {
        _callback();
    }
}
}

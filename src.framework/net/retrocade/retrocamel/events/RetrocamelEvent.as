package net.retrocade.retrocamel.events {
    import flash.events.Event;

    public class RetrocamelEvent extends Event{
        public static const SMOOTHING_CHANGED:String = "smoothing_changed";

        public function RetrocamelEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
            super(type, bubbles, cancelable);
        }


        override public function clone():Event {
            return new RetrocamelEvent(type, bubbles, cancelable);
        }
    }
}

package game.states {
import flash.display.Sprite;

import game.global.Make;
import game.global.preloader.Preloader;

import net.retrocade.retrocamel.components.RetrocamelStateBase;
import net.retrocade.retrocamel.display.flash.RetrocamelBitmapText;
import net.retrocade.retrocamel.effects.RetrocamelEffectFadeScreen;
import net.retrocade.retrocamel.locale._;

public class TStatePreload extends RetrocamelStateBase {
    private var txt:RetrocamelBitmapText;
    private var desc:RetrocamelBitmapText;
    private var parent:Sprite = new Sprite;

    private var load:RetrocamelBitmapText;
    private var loadWaver:Number = 0;

    public function TStatePreload() {
        txt = Make.text(_("preloadTitle"), 0xFFFFFF, 4);
        desc = Make.text(_("preloadDesc"));

        txt.x = (S().gameWidth - txt.width) / 2;
        txt.y = 100;

        desc.x = (S().gameWidth - desc.width) / 2;
        desc.y = 180;

        load = Make.text(_("loading") + " " + Preloader.percent.toFixed(1) + "%");
        load.setScale(2);

        parent.addChild(load);
        parent.addChild(txt);
        parent.addChild(desc);
    }

    override public function create():void {
        Preloader.loaderLayer.add(parent);
        RetrocamelEffectFadeScreen.makeIn().duration(500).run();
    }

    override public function destroy():void {
        Preloader.loaderLayer.remove(parent);
    }

    override public function update():void {
        super.update();

        load.text = _("loading") + " " + Preloader.percent.toFixed(1) + "%";
        load.x = (S().gameWidth - load.width) / 2;
        load.y = 320 + Math.cos(loadWaver += Math.PI / 110) * 5;
    }
}
}
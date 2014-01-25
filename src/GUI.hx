import flash.display.Sprite;
import flash.events.Event;
import flash.display.Bitmap;
import flash.ui.Keyboard;

@:bitmap("res/PLAY.png") class BtnPlayPic extends flash.display.BitmapData {}
@:bitmap("res/VS.png") class VSPic extends flash.display.BitmapData {}
@:bitmap("res/VS_BACK.png") class VSBackPic extends flash.display.BitmapData {}
@:bitmap("res/WIN_STAR.png") class WinStarPic extends flash.display.BitmapData {}
@:bitmap("res/CAT1_BAR_GREEN.png") class Cat1BarMaskPic extends flash.display.BitmapData {}
@:bitmap("res/CAT1_BAR.png") class Cat1BarPic extends flash.display.BitmapData {}
@:bitmap("res/CAT2_BAR_GREEN.png") class Cat2BarMaskPic extends flash.display.BitmapData {}
@:bitmap("res/CAT2_BAR.png") class Cat2BarPic extends flash.display.BitmapData {}

class GUI extends Sprite {

private var btnPlay:Sprite;
private var keyPoll:KeyPoll;

    public function new(keys:KeyPoll)
    {
    	super();
        btnPlay = new Sprite();
        keyPoll = keys;

        var btnPlayImg:Bitmap = new Bitmap(new BtnPlayPic(0, 0));
        btnPlay.addChild(btnPlayImg);

        btnPlay.x = (800 - btnPlay.width)/2;
        btnPlay.y = (600 - btnPlay.height)/2;

        addChild(btnPlay);

        addEventListener(Event.ENTER_FRAME, onFrame);
    }

    private function onFrame(event:Event):Void
    {
    	if (keyPoll.isDown(Keyboard.SPACE))
    	{
            btnPlay.visible = false;
    	}
    }
}
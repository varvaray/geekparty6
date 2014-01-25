import flash.display.Sprite;
import flash.display.MovieClip;
import flash.events.Event;
import flash.display.Shape;
import flash.display.Bitmap;
import flash.ui.Keyboard;
import flash.media.Sound;

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
private var bar1:Sprite;
private var bar2:Sprite;
private var shape1:Shape;
private var shape2:Shape;

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

        bar1 = new Sprite();
        bar1.x = 15;
        bar1.y = 15;

        var bar1Pic:Bitmap = new Bitmap(new Cat1BarPic(0,0));
        bar1.addChild(bar1Pic);

        var bar1PicHP:Bitmap = new Bitmap(new Cat1BarMaskPic(0,0));
        bar1.addChild(bar1PicHP);

        var shape1:Shape = new Shape();
        shape1.graphics.beginFill(0xFF0000);
        shape1.graphics.drawRect(0,0, 133,24);
        shape1.graphics.endFill();
        shape1.x = 78;
        shape1.y = 65;

        var bar1Mask:Bitmap = new Bitmap(new Cat1BarMaskPic(0,0));
        bar1PicHP.x = 78;
        bar1PicHP.y = 65;
        bar1Mask.alpha = 0;

        bar1.addChild(shape1);
        bar1.addChild(bar1Mask);
        // shape1.mask = bar1Mask;
        addChild(bar1);
        shape1.width = 0;


        bar2 = new Sprite();
        bar2.y = 15;
        var bar2Pic:Bitmap = new Bitmap(new Cat2BarPic(0,0));
        bar2.addChild(bar2Pic);

        var bar2PicHP:Bitmap = new Bitmap(new Cat2BarMaskPic(0,0));
        bar2.addChild(bar2PicHP);

        var shape2:Shape = new Shape();
        shape2.graphics.beginFill(0xFF0000);
        shape2.graphics.drawRect(0,0, 133,24);
        shape2.graphics.endFill();
        shape2.x = 800 - bar2.width - 15;
        shape2.y = 65;

        var bar2Mask:Bitmap = new Bitmap(new Cat2BarMaskPic(0,0));
        bar2PicHP.x = 800 - bar2.width - 15;
        bar2PicHP.y = 65;
        bar2Mask.alpha = 0;

        bar2.x = 800 - bar2.width - 15;

        bar2.addChild(shape2);
        bar2.addChild(bar2Mask);
        // shape1.mask = bar1Mask;
        addChild(bar2);
        shape2.width = 0;

    }

    public function onHit(game:Game):Void
    {
//    	shape1.width = 123;
    }

    private function onFrame(event:Event):Void
    {
    	if (keyPoll.isDown(Keyboard.SPACE))
    	{
            btnPlay.visible = false;
            if (start != null) start();
    	}
    }

    public var start:Void->Void;
}
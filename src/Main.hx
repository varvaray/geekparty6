import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;
import flash.ui.Keyboard;
import nape.callbacks.CbEvent;
import nape.callbacks.CbType;
import nape.callbacks.InteractionCallback;
import nape.callbacks.InteractionListener;
import nape.callbacks.InteractionType;
import nape.callbacks.OptionType;
import nape.constraint.Constraint;
import nape.constraint.PivotJoint;
import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Circle;
import nape.shape.Polygon;
import nape.space.Space;

@:bitmap("res/catback.png") class CatBack extends flash.display.BitmapData {}

class Main
{
    var game:Game;
    var gui:GUI;
    var root:DisplayObjectContainer;
    var keyPoll:KeyPoll;

    function new(root:MovieClip)
    {
        this.root = root;
        keyPoll = new KeyPoll(root.stage);

        var back = new Bitmap(new CatBack(0, 0));
        root.addChild(back);

        var help = new flash.text.TextField();
        help.defaultTextFormat = new flash.text.TextFormat("_sans", 14, 0xffffff, true);
        help.autoSize = flash.text.TextFieldAutoSize.LEFT;
        help.text = "Start: space\nPlayer1: Arrows\nPlayer2: WASD";
        root.addChild(help);
        help.x = (root.stage.stageWidth - help.textWidth) / 2;

        gui = new GUI(keyPoll);
        gui.start = start;
        root.addChild(gui);
    }

    function start()
    {
        gui.start = null;
        game = new Game(root, keyPoll);
        root.setChildIndex(game.root, 1);
        game.onHit = gui.onHit;
    }

    static function main()
    {
        new Main(flash.Lib.current);
    }
}

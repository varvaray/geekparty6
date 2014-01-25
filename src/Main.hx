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
import nape.constraint.PivotJoint;
import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Circle;
import nape.shape.Polygon;
import nape.space.Space;
import nape.util.BitmapDebug;
import nape.util.Debug;

@:bitmap("res/catback.png") class CatBack extends flash.display.BitmapData {}

class Main
{
<<<<<<< HEAD
    public static var HEAD = new CbType();
    public static var THING = new CbType();

=======
    var gui:GUI;
>>>>>>> Particles in res + few gui
    var root:DisplayObjectContainer;
    var space:Space;
    var prevTime:Float;
    var keyPoll:KeyPoll;
    var debug:Debug;

    var cat1:Cat;
    var cat2:Cat;

    function new(root:MovieClip)
    {
        this.root = root;
        keyPoll = new KeyPoll(root.stage);
        space = new Space(new nape.geom.Vec2(0, 100));

        createBorder();

        var back = new Bitmap(new CatBack(0, 0));
        root.addChild(back);

        cat1 = new Cat("Radiant", flash.Lib.attach("cat1"), space, root);
        cat2 = new Cat("Dire", flash.Lib.attach("cat2"), space, root);

        cat1.head.body.shapes.at(0).filter.collisionGroup = 2;
        cat1.thing.body.shapes.at(0).filter.collisionMask = 4;
        cat2.head.body.shapes.at(0).filter.collisionGroup = 4;
        cat2.thing.body.shapes.at(0).filter.collisionMask = 2;

        var listener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, HEAD, THING, hitHandler);
        space.listeners.add(listener);

        debug = new BitmapDebug(root.stage.stageWidth, root.stage.stageHeight, root.stage.color);
        // root.addChild(debug.display);
        debug.display.alpha = 0.5;

        root.addEventListener(Event.ENTER_FRAME, onFrame);
        prevTime = haxe.Timer.stamp();

        gui = new GUI(keyPoll);
        root.addChild(gui);
    }

    function hitHandler(cb:InteractionCallback)
    {
        var head = cb.int1;
        var thing = cb.int2;

        var bully = (thing == cat1.thing.body) ? cat1 : cat2;
        var victim = (head == cat1.head.body) ? cat1 : cat2;

        if (bully == victim)
            return;

        var now = haxe.Timer.stamp();
        if (now - victim.lastDamageTime < 1)
            return;

        victim.life--;
        victim.lastDamageTime = now;

        if (victim.life <= 0)
            victim.setDead();
        else
            victim.setHit();
        bully.setAngry();

        trace('${bully.name} hits ${victim.name} (life = ${victim.life})');
    }

    function createBorder()
    {
        var border = new Body(BodyType.STATIC);
        border.shapes.add(new Polygon(Polygon.rect(0, 0, -2, root.stage.stageHeight)));
        border.shapes.add(new Polygon(Polygon.rect(0, 0, root.stage.stageWidth, -2)));
        border.shapes.add(new Polygon(Polygon.rect(root.stage.stageWidth, 0, 2, root.stage.stageHeight)));
        border.shapes.add(new Polygon(Polygon.rect(0, root.stage.stageHeight, root.stage.stageWidth, 2)));
        for (shape in border.shapes)
            shape.filter.collisionMask = 6;
        border.space = space;
        return border;
    }

    function onFrame(_)
    {
        var now = haxe.Timer.stamp();
        var deltaTime = now - prevTime;
        prevTime = now;

        var vel = new Vec2();
        if (keyPoll.isDown(Keyboard.D))
            vel.x = 10000;
        if (keyPoll.isDown(Keyboard.A))
            vel.x = -10000;
        if (keyPoll.isDown(Keyboard.W))
            vel.y = -10000;
        if (keyPoll.isDown(Keyboard.S))
            vel.y = 10000;
        cat1.head.body.force.set(vel);

        var vel = new Vec2();
        if (keyPoll.isDown(Keyboard.RIGHT))
            vel.x = 10000;
        if (keyPoll.isDown(Keyboard.LEFT))
            vel.x = -10000;
        if (keyPoll.isDown(Keyboard.UP))
            vel.y = -10000;
        if (keyPoll.isDown(Keyboard.DOWN))
            vel.y = 10000;
        cat2.head.body.force.set(vel);

        if (deltaTime > 0)
            space.step(deltaTime);

        // test1.update();
        // test2.update();

        cat1.update();
        cat2.update();

        // Clear the debug display.
        debug.clear();
        // Draw our Space.
        debug.draw(space);
        // Flush draw calls, until this is called nothing will actually be displayed.
        debug.flush();
    }

    static function main()
    {
        new Main(flash.Lib.current);
    }
}

class Cat
{
    public var life = 9;
    public var lastDamageTime:Float = 0;
    public var name:String;

    public var head:Entity;
    var tail1:Entity;
    var tail2:Entity;
    var tail3:Entity;
    public var thing:Entity;

    var faceTimer:haxe.Timer;

    function createTailPartBody(space):Body
    {
        var tail1Body = new Body();
        var tailShape = new Polygon(Polygon.rect(-7, 0, 14, 42));
        tailShape.filter.collisionMask = 0;
        tail1Body.shapes.add(tailShape);
        tail1Body.space = space;
        return tail1Body;
    }

    public function new(name, mc:MovieClip, space:Space, container:DisplayObjectContainer)
    {
        this.name = name;

        var headBody = new Body();
        headBody.position.setxy(100, 100);
        var headShape = new Circle(54);
        headBody.shapes.add(headShape);
        headBody.allowRotation = false;
        headBody.cbTypes.add(Main.HEAD);

        var tail1Body = createTailPartBody(space);
        var joint = new PivotJoint(headBody, tail1Body, new Vec2(0, 48), new Vec2(0, 0));
        joint.space = space;

        var tail2Body = createTailPartBody(space);
        var joint = new PivotJoint(tail1Body, tail2Body, new Vec2(0, 36), new Vec2(0, 0));
        joint.space = space;

        var tail3Body = createTailPartBody(space);
        var joint = new PivotJoint(tail2Body, tail3Body, new Vec2(0, 36), new Vec2(0, 0));
        joint.space = space;

        var thingBody = new Body();
        thingBody.shapes.add(new Circle(40));
        thingBody.cbTypes.add(Main.THING);

        var joint = new PivotJoint(tail3Body, thingBody, new Vec2(0, 42), new Vec2(0, 0));
        joint.space = space;

        head = new Entity(mc.head, headBody);
        addEntity(head, space, container);
        tail1 = new Entity(mc.tail1, tail1Body);
        addEntity(tail1, space, container);
        tail2 = new Entity(mc.tail2, tail2Body);
        addEntity(tail2, space, container);
        tail3 = new Entity(mc.tail3, tail3Body);
        addEntity(tail3, space, container);
        thing = new Entity(mc.thing, thingBody);
        addEntity(thing, space, container);

        setCalm();
    }

    function addEntity(entity:Entity, space:Space, container:DisplayObjectContainer):Void
    {
        container.addChild(entity.sprite);
        entity.body.space = space;
    }

    public function setCalm()
    {
        setFrame(1);
    }

    public function setDead()
    {
        setFrame(4);
    }

    public function setAngry()
    {
        setFrame(3);
        faceTimer = haxe.Timer.delay(setCalm, 1000);
    }

    public function setHit()
    {
        setFrame(2);
        faceTimer = haxe.Timer.delay(setCalm, 1000);
    }

    function setFrame(n:Int)
    {
        if (faceTimer != null) faceTimer.stop();
        head.sprite.gotoAndStop(n);
        tail1.sprite.gotoAndStop(n);
        tail2.sprite.gotoAndStop(n);
        tail3.sprite.gotoAndStop(n);
        thing.sprite.gotoAndStop(n);
    }

    public function update()
    {
        head.update();
        tail1.update();
        tail2.update();
        tail3.update();
        thing.update();
    }
}

class Entity
{
    public var sprite:MovieClip;
    public var body:Body;

    public function new(sprite:MovieClip, body:Body)
    {
        this.sprite = sprite;
        this.body = body;
    }

    public function update():Void
    {
        var p = new Point(body.position.x, body.position.y);
        p = sprite.parent.globalToLocal(p);
        sprite.x = p.x;
        sprite.y = p.y;
        sprite.rotation = body.rotation * 180 / Math.PI;
    }
}
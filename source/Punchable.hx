package;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxColor;
import flixel.group.FlxGroup;
import flixel.math.FlxRect;

class Punchable extends FlxSpriteGroup
{
    public var daSprite:FlxSprite;
    public var grpHurtboxes:FlxTypedSpriteGroup<Hitbox>;
    public var grpHitboxes:FlxTypedSpriteGroup<Hitbox>;
    public var curAnimation:Int = 0;

    public var actualHealth:Float = 1;

    public var hurtboxes:Array<Dynamic> = 
    [
        [
            [0, -85, 100, 100]
        ]
    ];

    public var hitboxes:Array<Dynamic> =
    [
        [
            [100, 0, 30, 10]
        ]
    ];

    public function new(X: Float, Y: Float)
    {
        super(X, Y);
        daSprite = new FlxSprite(0, 85);
        daSprite.makeGraphic(100, 100);
       
        daSprite.offset.y = 85;
         var daOffsetY:Float = daSprite.height - daSprite.offset.y;
        daSprite.height = daOffsetY;
        add(daSprite);

        grpHurtboxes = new FlxTypedSpriteGroup<Hitbox>();
        add(grpHurtboxes);

        grpHitboxes = new FlxTypedSpriteGroup<Hitbox>();
        add(grpHitboxes);

        generateHitboxes();
    }

    public function generateHitboxes():Void
    {
        // Start fresh
        grpHitboxes.forEach(function(spr:Hitbox){grpHitboxes.remove(spr, true); });
        grpHurtboxes.forEach(function(spr:Hitbox){grpHurtboxes.remove(spr, true); });

        for (i in hurtboxes)
        {
            var dumb:Array<Dynamic> = i;
            for (b in dumb)
            {
                trace(b);
 
                var testObj:Hitbox = new Hitbox(b[0], b[1]);
                testObj.makeGraphic(Std.int(b[2]), Std.int(b[3]));
                testObj.offsetShit = new FlxRect(b[0], b[1], b[2], b[3]);
                testObj.alpha = 0.5;
                grpHurtboxes.add(testObj);
                testObj.color = FlxColor.GREEN;
            }
        }

        for (i in hitboxes)
        {
            var dumb:Array<Dynamic> = i;
            for (b in dumb)
            {
                var testObj:Hitbox = new Hitbox(b[0], b[1]);
                testObj.makeGraphic(Std.int(b[2]), Std.int(b[3]));
                testObj.offsetShit = new FlxRect(b[0], b[1], b[2], b[3]);
                testObj.alpha = 0.5;
                grpHitboxes.add(testObj);
                testObj.color = FlxColor.RED;
            }
        }
    }

    public function getHurt(dmg:Float):Void
    {
        actualHealth -= dmg;
        trace("OOF OUCH OWIE" + FlxG.random.int(0, 100));
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        
        if (actualHealth <= 0)
            alpha = 0.1;

        grpHurtboxes.forEach(function(spr:Hitbox)
        {
            spr.setPosition(daSprite.x + spr.offsetShit.x, daSprite.y + spr.offsetShit.y);
        });

        grpHitboxes.forEach(function(spr:Hitbox)
        {
            spr.setPosition(daSprite.x + spr.offsetShit.x, daSprite.y + spr.offsetShit.y);
        });
        // testObj.setPosition(daSprite.x + hurtboxes[0][0][0], daSprite.y + hurtboxes[0][0][1]);

    }
}
package;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxColor;
import flixel.group.FlxGroup;
import flixel.math.FlxRect;
import flixel.math.FlxPoint;

class Punchable extends FlxSpriteGroup
{
    public var daSprite:FlxSprite;
    public var grpHurtboxes:FlxTypedSpriteGroup<Hitbox>;
    public var grpHitboxes:FlxTypedSpriteGroup<Hitbox>;
    public var curAnimation:Int = 0;

    public var actualHealth:Float = 1;
    public var invincibleFrames:Float = 0;

    public var hurtboxes:Array<Dynamic> = 
    [
        [
            [-30, -85, 60, 100]
        ]
    ];

    public var hitboxes:Array<Dynamic> =
    [
        [
            [30, -50, 20, 20]
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

        drag.x = 300;

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

    public function getHurt(dmg:Float, ?fromPos:FlxSprite):Void
    {
        if (invincibleFrames <= 0)
        {
            actualHealth -= dmg;
            if (fromPos != null)
            {
                if (fromPos.x < x)
                    velocity.x = 200 + (fromPos.velocity.x * 1);
                if (fromPos.x > x)
                    velocity.x = -200 + (fromPos.velocity.x * 1); 
            }

            invincibleFrames = 0.8;
            trace("OOF OUCH OWIE" + FlxG.random.int(0, 100));
        }
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        if (invincibleFrames > 0)
            invincibleFrames -= FlxG.elapsed;
        
        if (actualHealth <= 0)
            alpha = 0.1;

        grpHurtboxes.forEach(function(spr:Hitbox)
        {
            setSpritePos(spr);
        });

        grpHitboxes.forEach(function(spr:Hitbox)
        {
            setSpritePos(spr);

        });
        // testObj.setPosition(daSprite.x + hurtboxes[0][0][0], daSprite.y + hurtboxes[0][0][1]);

    }

    private function setSpritePos(spr:Hitbox):Void
    {
        if (daSprite.facing == FlxObject.RIGHT)
            spr.setPosition(daSprite.getGraphicMidpoint().x + (spr.offsetShit.x), daSprite.y + spr.offsetShit.y);
        if (daSprite.facing == FlxObject.LEFT)
            spr.setPosition(daSprite.getGraphicMidpoint().x - (spr.offsetShit.x) - spr.width, daSprite.y + spr.offsetShit.y);
    }
}
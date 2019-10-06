package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxObject;
import flixel.math.FlxPoint;

class Player extends Character
{
    private var ogOffset:FlxPoint;

    public function new(X:Float, Y:Float)
    {
        super(X, Y);

        CHAR_TYPE = TypePLAYER;

        speed = 230;

        daSprite.color = FlxColor.WHITE;
        var tex = FlxAtlasFrames.fromSparrow(AssetPaths.HoboMoveSet__png, AssetPaths.HoboMoveSet__xml);
        daSprite.frames = tex;
        daSprite.setGraphicSize(0, 100);
        daSprite.updateHitbox();
        daSprite.antialiasing = true;
        daSprite.offset.y = 165;
         var daOffsetY:Float = daSprite.height - daSprite.offset.y;
        daSprite.height = 15;
        generateHitboxes();

        daSprite.animation.addByPrefix("idle", "HoboIdle", 24, true);
        daSprite.animation.addByPrefix("punch", "HoboPunch", 24, false);
        daSprite.animation.addByPrefix("walk", "HoboWalk", 24, true);
        daSprite.animation.addByPrefix("hurt", "HoboHurt", 20, false);
        daSprite.animation.play("idle");

        daSprite.setFacingFlip(FlxObject.LEFT, true, false);
        daSprite.setFacingFlip(FlxObject.RIGHT, false, false);

        grpHurtboxes.forEach(function(spr:Hitbox)
        {
            spr.color = FlxColor.GREEN;
        });

        grpHitboxes.forEach(function(spr:Hitbox)
        {
            spr.color = FlxColor.RED;
        });

        // grpHitboxes.visible = false;
        // grpHurtboxes.visible = false;

        facing = FlxObject.RIGHT;
        drag.x = 700;
        drag.y = 700;

        ogOffset = new FlxPoint(daSprite.offset.x, daSprite.offset.y);
        trace(ogOffset);
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        FlxG.watch.addQuick("FullPos", getPosition());
        FlxG.watch.addQuick("SpritePos", daSprite.getPosition());
        
        /* 
        if (getPosition().x != daSprite.getPosition().x)
            setPosition(daSprite.getPosition().x, getPosition().y);
        if (getPosition().y != daSprite.getPosition().y)
            y = daSprite.y - 85;
        */ 

        movement();

        FlxG.watch.addQuick("curANime", daSprite.animation.curAnim.name);
        FlxG.watch.addQuick("offset", daSprite.offset);

        animationFixins();
    }

    override public function getHurt(dmg:Float, ?fromPos:FlxSprite):Void
    {
        super.getHurt(dmg, fromPos);

        daSprite.animation.play("hurt", true);
    }

    private function movement():Void
    {
        var _left:Bool = FlxG.keys.anyPressed(["LEFT", "A"]);
        var _right:Bool = FlxG.keys.anyPressed(["RIGHT", "D"]);
        var _up:Bool = FlxG.keys.anyPressed(["UP", "W"]);
        var _down:Bool = FlxG.keys.anyPressed(["DOWN", "S"]);

        speed = 230;

        if (_left && _right)
            _left = _right = false;

        if (FlxG.keys.pressed.SHIFT)
            speed *= 1.6;

        if (_left || _right || _up || _down)
        {
            if (_left || _right)
            {
                if (_left)
                {
                    daSprite.facing = FlxObject.LEFT;
                    velocity.x = -speed;
                    
                }
                    
                if (_right)
                {
                    daSprite.facing = FlxObject.RIGHT;
                    velocity.x = speed;
                }

                
            }

            if (_up || _down)
            {
                if (_up)
                    velocity.y = -speed;
                if (_down)
                    velocity.y = speed;
                
                
            }

            if (daSprite.animation.curAnim.name == "idle")
                daSprite.animation.play("walk");
        }
        else
        {
            if (daSprite.animation.curAnim.name == "walk")
                daSprite.animation.play("idle");
        }
            
        
        
        if (FlxG.keys.justPressed.SPACE && canAttack)
        {
            isAttacking = true;
            daSprite.animation.play("punch", true);
        }

        if (daSprite.animation.curAnim.name != "idle" && daSprite.animation.curAnim.finished)
        {
            isAttacking = false;
            daSprite.animation.play("idle");
        }

        if (daSprite.animation.curAnim.name == "punch")
        {
            velocity.x *= 0.2;
            velocity.y *= 0.2;
        }

    }

    private function animationFixins():Void
    {
        if (daSprite.facing == FlxObject.LEFT && daSprite.animation.curAnim.name == "punch")
        {
            daSprite.offset.x = ogOffset.x + 50;
        }
        else
            daSprite.offset.x = ogOffset.x;
    }
}
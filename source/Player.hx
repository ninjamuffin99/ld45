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

        color = FlxColor.WHITE;
        var tex = FlxAtlasFrames.fromSparrow(AssetPaths.HoboMoveSet__png, AssetPaths.HoboMoveSet__xml);
        frames = tex;
        setGraphicSize(0, 100);
        updateHitbox();
        antialiasing = true;
        offset.y = 165;
        var daOffsetY:Float = height - offset.y;
        height = 15;
        generateHitboxes();

        animation.addByPrefix("idle", "HoboIdle", 24, true);
        animation.addByPrefix("punch", "HoboPunch", 24, false);
        animation.addByPrefix("walk", "HoboWalk", 24, true);
        animation.addByPrefix("hurt", "HoboHurt", 20, false);
        animation.addByPrefix("killed", "HoboDeath", 24, false);
        animation.play("idle");

        setFacingFlip(FlxObject.LEFT, true, false);
        setFacingFlip(FlxObject.RIGHT, false, false);

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

        ogOffset = new FlxPoint(offset.x, offset.y);
        trace(ogOffset);
    }

    private var resetTimer:Float = 0;

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        FlxG.watch.addQuick("FullPos", getPosition());
        FlxG.watch.addQuick("OriginPlayer", origin);
        
        /* 
        if (getPosition().x != daSprite.getPosition().x)
            setPosition(daSprite.getPosition().x, getPosition().y);
        if (getPosition().y != daSprite.getPosition().y)
            y = daSprite.y - 85;
        */ 

        if (!isDead)
        {
            movement();
        }
        else
        {
            resetTimer += FlxG.elapsed;

            if (resetTimer >= 3)
                FlxG.resetState();
        }
        

        FlxG.watch.addQuick("curANime", animation.curAnim.name);
        FlxG.watch.addQuick("offset", offset);

        animationFixins();
    }

    override public function getHurt(dmg:Float, ?fromPos:FlxSprite):Void
    {
        super.getHurt(dmg, fromPos);

        animation.play("hurt", true);
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
                    facing = FlxObject.LEFT;
                    velocity.x = -speed;
                    
                }
                    
                if (_right)
                {
                    facing = FlxObject.RIGHT;
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

            if (animation.curAnim.name == "idle")
                animation.play("walk");
        }
        else
        {
            if (animation.curAnim.name == "walk")
                animation.play("idle");
        }
            
        
        
        if (FlxG.keys.justPressed.SPACE && canAttack)
        {
            isAttacking = true;
            animation.play("punch", true);
        }

        if (animation.curAnim.name != "idle" && animation.curAnim.finished)
        {
            isAttacking = false;
            animation.play("idle");
        }

        if (animation.curAnim.name == "punch")
        {
            velocity.x *= 0.2;
            velocity.y *= 0.2;
        }

    }

    override private function getKilled():Void
    {
        if (animation.curAnim.name != "killed")
            animation.play("killed");
        
        isDead = true;

        super.getKilled();
    }

    private function animationFixins():Void
    {
        if (facing == FlxObject.LEFT && animation.curAnim.name == "punch")
        {
            offset.x = ogOffset.x + 50;
        }
        else
            offset.x = ogOffset.x;
    }
}
package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxObject;

class Player extends Character
{    

    public function new(X:Float, Y:Float)
    {
        super(X, Y);
        speed = 200;

        daSprite.color = FlxColor.WHITE;
        var tex = FlxAtlasFrames.fromSpriteSheetPacker(AssetPaths.hoboSheet__png, AssetPaths.hoboSheet__txt);
        daSprite.frames = tex;
        daSprite.updateHitbox();
        daSprite.offset.y = 85;
         var daOffsetY:Float = daSprite.height - daSprite.offset.y;
        daSprite.height = daOffsetY;

        daSprite.animation.add("idle", [0]);
        daSprite.animation.add("punch", [1], 6, false);
        daSprite.animation.play("idle");

        daSprite.setFacingFlip(FlxObject.LEFT, false, false);
        daSprite.setFacingFlip(FlxObject.RIGHT, true, false);

        grpHurtboxes.forEach(function(spr:Hitbox)
        {
            spr.color = FlxColor.GREEN;
        });

        grpHitboxes.forEach(function(spr:Hitbox)
        {
            spr.color = FlxColor.RED;
        });
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        movement();
    }

    private function movement():Void
    {
        var _left:Bool = FlxG.keys.anyPressed(["LEFT", "A"]);
        var _right:Bool = FlxG.keys.anyPressed(["RIGHT", "D"]);
        var _up:Bool = FlxG.keys.anyPressed(["UP", "W"]);
        var _down:Bool = FlxG.keys.anyPressed(["DOWN", "S"]);

        if (_left && _right)
            _left = _right = false;

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
        else
            velocity.x = 0;

        if (_up || _down)
        {
            if (_up)
                velocity.y = -speed;
            if (_down)
                velocity.y = speed;
        }
        else
            velocity.y = 0;
        
        if (FlxG.keys.justPressed.SPACE)
        {
            isAttacking = true;
            daSprite.animation.play("punch", true);
        }

        if (daSprite.animation.curAnim.name != "idle" && daSprite.animation.curAnim.finished)
        {
            isAttacking = false;
            daSprite.animation.play("idle");
        }

    }
}
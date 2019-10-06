package;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxG;
import flixel.math.FlxMath;
import flixel.FlxObject;
import flixel.math.FlxPoint;

class Grimbo extends Enemy
{
    public function new(x:Float, y:Float, p:Player)
    {
        super(x, y, p);

        var tex = FlxAtlasFrames.fromSparrow(AssetPaths.GrimboMoveset__png, AssetPaths.GrimboMoveset__xml);
        frames = tex;
        setGraphicSize(0, 100);
        updateHitbox();
        antialiasing = true;
        offset.y += 90;
        width -= 80;
        height = 15;

        hitboxes[0][0] = [-30, -15, 165, 10];
        generateHitboxes();

        animation.addByPrefix("idle", "GrimboIdle", 24);
        animation.addByPrefix("walk", "GrimboWalk", 24);
        animation.addByPrefix("attack", "GrimboAttack", 24, false);
        attackWindup = 0.3;
        animation.play("idle");

        setFacingFlip(FlxObject.LEFT, false, false);
        setFacingFlip(FlxObject.RIGHT, true, false);

        
        ogOffset = new FlxPoint(offset.x, offset.y);
    }

    override public function attackPlayer():Void
    {
        super.attackPlayer();
        animation.play("attack");
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        if (invincibleFrames <= 0 && !isAttacking)
        {
            if (velocity.x != 0 || velocity.y != 0)
                animation.play("walk");
            else if (animation.curAnim.name != "idle")
                animation.play("idle");     
        }
    }

    override public function chase():Void  
    {
        super.chase();

    }

    override private function animationFixins():Void
    {
        super.animationFixins();
        if (facing == FlxObject.LEFT && animation.curAnim.name == "attack")
        {
            offset.x = ogOffset.x + 100;
        }
        else
            offset.x = ogOffset.x;
    }
}
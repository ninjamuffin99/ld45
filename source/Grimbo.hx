package;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxG;
import flixel.math.FlxMath;
import flixel.FlxObject;

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
        generateHitboxes();

        animation.addByPrefix("idle", "GrimboIdle", 24);
        animation.addByPrefix("walk", "GrimboWalk", 24);
        animation.play("idle");

        setFacingFlip(FlxObject.LEFT, false, false);
        setFacingFlip(FlxObject.RIGHT, true, false);
        
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        FlxG.watch.addQuick("Grimbo Position", getPosition());
        FlxG.watch.addQuick("Grimbo Origin", origin);

        if (invincibleFrames <= 0)
        {
            if (velocity.x != 0)
                animation.play("walk");
            else
                animation.play("idle");
        }
    }
}
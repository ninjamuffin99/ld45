package;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxG;
import flixel.math.FlxMath;

class Grimbo extends Enemy
{
    public function new(x:Float, y:Float, p:Player)
    {
        super(x, y, p);

        var tex = FlxAtlasFrames.fromSparrow(AssetPaths.GrimboMoveset__png, AssetPaths.GrimboMoveset__xml);
        daSprite.frames = tex;
        daSprite.setGraphicSize(0, 100);
        daSprite.updateHitbox();
        daSprite.antialiasing = true;
        daSprite.width -= 80;
        daSprite.height = 15;
        generateHitboxes();

        daSprite.animation.addByPrefix("idle", "GrimboIdle", 24);
        daSprite.animation.play("idle");
        
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        FlxG.watch.addQuick("daSpritePos", daSprite.getPosition());
        FlxG.watch.addQuick("Distances", FlxMath.distanceToPoint(daSprite, _player.daSprite.getMidpoint()));
    }
}
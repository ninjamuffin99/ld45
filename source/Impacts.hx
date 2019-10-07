package;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxG;

class Impacts extends FlxSprite
{
    private var lifespan = 7;
    private var counter = 0;

    public function new(X:Float, Y:Float)
    {
        super(X, Y);
        var tex = FlxAtlasFrames.fromSparrow(AssetPaths.impactFrames__png, AssetPaths.impactFrames__xml);
        frames = tex;
        animation.addByPrefix("play", "impact", FlxG.random.int(20, 25), false);
        animation.play("play");
        setGraphicSize(0, Std.int(90 * FlxG.random.float(0.4, 1)));
        updateHitbox();
        angle = FlxG.random.float(0, 360);
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        if (animation.curAnim.finished)
            kill();
    }
}
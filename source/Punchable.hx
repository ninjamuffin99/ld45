package;

import flixel.FlxSprite;

class Punchable extends FlxSprite
{
    public function new(X: Float, Y: Float)
    {
        super(X, Y);
        makeGraphic(100, 100);
        var daOffsetY:Float = height * 0.85;
        offset.y = daOffsetY;
        height -= daOffsetY;
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }
}
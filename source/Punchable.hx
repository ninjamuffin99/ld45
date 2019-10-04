package;

import flixel.FlxSprite;

class Punchable extends FlxSprite
{
    public function new(X: Float, Y: Float)
    {
        super(X, Y);
        makeGraphic(10, 10);
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }
}
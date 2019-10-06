package;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class Item extends FlxSprite
{
    public function new(x:Float, y:Float)
    {
        super(x, y);
        makeGraphic(20, 20, FlxColor.GREEN);
    }
}
package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxColor;

class Player extends Character
{
    public function new(X:Float, Y:Float)
    {
        super(X, Y);

        color = FlxColor.BLUE;
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
                velocity.x = -speed;
            if (_right)
                velocity.x = speed;
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
        
    }
}
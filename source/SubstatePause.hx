package;

import flixel.FlxSubState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class SubstatePause extends FlxSubState
{
    public function new():Void
    {
        super();

        var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        bg.scrollFactor.set();
        bg.alpha = 0.4;
        add(bg);
    }

    override public function update(e:Float):Void
    {
        if (FlxG.keys.justPressed.ENTER)
            close();

        super.update(e);

        var gamepad = FlxG.gamepads.lastActive;
		if (gamepad != null)
		{
            if (gamepad.justPressed.START)
                close();
        }
    }
}
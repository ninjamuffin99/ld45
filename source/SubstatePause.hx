package;

import flixel.FlxSubState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class SubstatePause extends FlxSubState
{
    public function new():Void
    {
        super();

        var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        bg.scrollFactor.set();
        bg.alpha = 0.4;
        add(bg);

        var pauseShit:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.pause__png);
        pauseShit.antialiasing = true;
        pauseShit.setGraphicSize(Std.int(pauseShit.width * 0.5));
        pauseShit.updateHitbox();
        pauseShit.screenCenter();
        pauseShit.scrollFactor.set();
        add(pauseShit);

        FlxTween.tween(pauseShit, {y: pauseShit.y + 20}, 0.5, {type:PINGPONG, ease:FlxEase.quadInOut});
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
package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxSubState;
import flixel.util.FlxColor;

class StageSelect extends FlxSubState
{
    public function new():Void
    {
        super();

        var blackBG:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        blackBG.alpha = 0.5;
        add(blackBG);

        for (i in 0...3)
        {
            var thumb:FlxSprite = new FlxSprite((200 * (i + 1)), FlxG.height * 0.6).makeGraphic(160, 110);
            // thumb.x -= thumb.width / 2;
            add(thumb);
        }

    }

    override public function update(e:Float):Void
    {
        super.update(e);

        if (FlxG.keys.justPressed.ONE)
		{
			PlayState.curBG = 1;
            FlxG.switchState(new PlayState());
		}
		if (FlxG.keys.justPressed.TWO)
		{
			PlayState.curBG = 2;
			FlxG.switchState(new PlayState());
		}
		if (FlxG.keys.justPressed.THREE)
		{
			PlayState.curBG = 3;
			FlxG.switchState(new PlayState());
		}
			

    }
}
package;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;

class Gameover extends FlxState
{
    override public function create():Void
    {
        var bg:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.BohoEnd__png);
        bg.setGraphicSize(0, FlxG.height);
        bg.updateHitbox();
        add(bg);

        var txt:FlxText = new FlxText(630, 430, 0, "" + Scores.cash, 42);
        add(txt);

        Scores.cash = 0;

        // Score.cash

        super.create();
    }

    override public function update(e:Float):Void
    {
        if (FlxG.keys.justPressed.ENTER)
            FlxG.switchState(new MenuState());
        super.update(e);
    }
}
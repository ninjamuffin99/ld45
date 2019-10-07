package;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class Gameover extends FlxState
{
    override public function create():Void
    {
        FlxG.camera.fade(FlxColor.BLACK, 4, true);
        FlxG.sound.playMusic(AssetPaths.mall__mp3, 0);
        FlxG.sound.music.fadeIn(5, 0, 0.3);
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
        {
            FlxG.sound.music.fadeOut(2.8, 0);
            FlxG.camera.fade(FlxColor.BLACK, 3, false, function()
            {
                FlxG.switchState(new MenuState());
            });
        }
            
        super.update(e);
    }
}
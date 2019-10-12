package;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import io.newgrounds.NG;

class Gameover extends FlxState
{
    override public function create():Void
    {
        FlxG.camera.fade(FlxColor.BLACK, 4, true);
        FlxG.sound.playMusic("assets/music/mall" + Scores.curMusicType, 0);
        FlxG.sound.music.fadeIn(5, 0, 0.3);
        var bg:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.BohoEnd__png);
        bg.setGraphicSize(0, FlxG.height);
        bg.updateHitbox();
        add(bg);

        var txt:FlxText = new FlxText(630, 430, 0, "" + Scores.cash, 42);
        add(txt);

        if (NGio.isLoggedIn)
        {
            var board = NG.core.scoreBoards.get(8737);// ID found in NG project view
		    board.postScore(Scores.cash * 100); // converts it into cents, for NG scoreboards
        }
        

        Scores.cash = 0;

        // Score.cash

        super.create();
    }

    override public function update(e:Float):Void
    {
        if (FlxG.keys.justPressed.ENTER || FlxG.keys.justPressed.SPACE)
        {
            leaveState();
        }

        var gamepad = FlxG.gamepads.lastActive;
        if (gamepad != null)
        {
            if (gamepad.justPressed.A || gamepad.justPressed.START)
            {
                leaveState();
            }
        }
            
        super.update(e);
    }

    private function leaveState():Void
    {
        FlxG.sound.music.fadeOut(2.8, 0);
        FlxG.camera.fade(FlxColor.BLACK, 3, false, function()
        {
            FlxG.switchState(new MenuState());
        });

    }
}
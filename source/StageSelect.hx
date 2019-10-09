package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxSubState;
import flixel.util.FlxColor;
import flixel.graphics.frames.FlxAtlasFrames;

class StageSelect extends FlxSubState
{
    private var curSelected:Int = 1;
    private var dumbBoHo:FlxSprite;

    public function new():Void
    {
        super();

        var selectLevel:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.levelselect__png);
        selectLevel.setGraphicSize(0, FlxG.height);
        selectLevel.updateHitbox();
        add(selectLevel);

        dumbBoHo = new FlxSprite();
        var boTex = FlxAtlasFrames.fromSparrow(AssetPaths.HoboMoveSet__png, AssetPaths.HoboMoveSet__xml);
        dumbBoHo.frames = boTex;
        dumbBoHo.setGraphicSize(0, 75);
        dumbBoHo.antialiasing = true;
        dumbBoHo.updateHitbox();
        dumbBoHo.animation.addByPrefix("walk", "HoboWalk", 24, true);
        dumbBoHo.animation.addByPrefix("punch", "HoboPunch", 24, false);
        dumbBoHo.animation.play("walk");
        add(dumbBoHo);

    }

    private var switchin:Bool = false;

    override public function update(e:Float):Void
    {
        super.update(e);
        var _leftP:Bool = false;
        var _rightP:Bool = false;
        var _startP:Bool = false;

        var gamepad = FlxG.gamepads.lastActive;
        if (gamepad != null)
        {
            _leftP = gamepad.anyJustPressed(["DPAD_LEFT", "LEFT_STICK_DIGITAL_LEFT"]);
            _rightP = gamepad.anyJustPressed(["DPAD_RIGHT", "LEFT_STICK_DIGITAL_RIGHT"]);
            _startP = gamepad.anyJustPressed(["A", "X", "START"]);
        }


        if (FlxG.keys.anyJustPressed(["A", "LEFT"]) || _leftP)
            curSelected -= 1;
        if (FlxG.keys.anyJustPressed(["D", "RIGHT"]) || _rightP)
            curSelected += 1;

        if (curSelected < 1)
            curSelected = 3;
        if (curSelected > 3)
            curSelected = 1;
        
        switch (curSelected)
        {
            case 1:
                dumbBoHo.setPosition(130, 370);
            case 2:
                dumbBoHo.setPosition(420, 460);
            case 3:
                dumbBoHo.setPosition(730, 380);

        }
        
        if ((FlxG.keys.justPressed.SPACE || _startP) && !switchin)
        {
            switchin = true;
            dumbBoHo.animation.play("punch");
            switch (curSelected)
            {
                case 1:
                    PlayState.curBG = 3;
                case 2:
                    PlayState.curBG = 1;
                case 3:
                    PlayState.curBG = 2;
                default:

            }

            FlxG.sound.music.fadeOut(1, 0);
            FlxG.camera.fade(FlxColor.BLACK, 1, false, function()
            {
                FlxG.switchState(new PlayState());
            });
        }
    }
}
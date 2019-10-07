package;
import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class MenuState extends FlxState
{
    override public function create():Void
    {
        var boho:FlxText = new FlxText(0, 0, 0, "BOHO IN BALLER LAND", 50);
        boho.screenCenter();
        boho.angle = -45;
        FlxTween.tween(boho, {angle: 45}, 2, {type: PINGPONG, ease:FlxEase.quadInOut});
        add(boho);

        persistentUpdate = false;

        super.create();
    }

    override public function update(e:Float):Void
    {
        if (FlxG.keys.justPressed.ANY)
            openSubState(new StageSelect());

        super.update(e);
    }
}
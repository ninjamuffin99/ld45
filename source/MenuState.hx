package;
import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class MenuState extends FlxState
{
    override public function create():Void
    {
        FlxG.camera.fade(FlxColor.BLACK, 1, true);

        var title:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.titlescreen__png);
        title.setGraphicSize(0, FlxG.height);
        title.updateHitbox();
        title.antialiasing = true;
        add(title);

        var logo:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.boho__png);
        FlxTween.tween(logo.scale, {x: 1.05, y: 1.05}, 0.5, {ease:FlxEase.quadInOut, type:PINGPONG});
        logo.antialiasing = true;
        add(logo);

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
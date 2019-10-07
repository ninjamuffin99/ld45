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
        add(title);

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
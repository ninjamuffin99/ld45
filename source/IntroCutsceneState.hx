package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;

class IntroCutsceneState extends FlxState
{
    private var spaceBG:FlxSprite;
    private var islandBG:FlxSprite;
    private var bar1:FlxSprite;
    private var bar1Text:FlxSprite;
    private var canContinue:Bool = false;

    private var slide2:FlxSprite;

    private var curScene:Int = 0;

    override public function create():Void
    {
        spaceBG = new FlxSprite().loadGraphic(AssetPaths.space__png);
        spaceBG.setGraphicSize(0, Std.int(FlxG.height));
        spaceBG.updateHitbox();
        spaceBG.scrollFactor.set(0.3, 0.3);
        spaceBG.antialiasing = true;
        add(spaceBG);

        islandBG = new FlxSprite().loadGraphic(AssetPaths.island1__png);
        islandBG.setGraphicSize(0, FlxG.height);
        islandBG.updateHitbox();
        islandBG.scrollFactor.set(0.8, 0.8);
        FlxTween.tween(islandBG, {y: islandBG.y + 20}, 2.5, {ease: FlxEase.quadInOut, type:PINGPONG});
        islandBG.antialiasing = true;
        add(islandBG);

        bar1 = new FlxSprite().loadGraphic(AssetPaths.bar1__png);
        bar1.setGraphicSize(0, FlxG.height);
        bar1.updateHitbox();
        bar1.antialiasing = true;
        add(bar1);

        bar1Text = new FlxSprite().loadGraphic(AssetPaths.bar1Text__png);
        bar1Text.setGraphicSize(0, FlxG.height);
        bar1Text.updateHitbox();
        bar1Text.antialiasing = true;
        bar1Text.alpha = 0;
        add(bar1Text);

        slide2 = new FlxSprite().loadGraphic(AssetPaths.slide2__png);
        slide2.setGraphicSize(0, FlxG.height);
        slide2.updateHitbox();
        slide2.antialiasing = true;

        FlxG.camera.fade(FlxColor.BLACK, 2, true, function()
        {
            FlxTween.tween(bar1Text, {alpha:1}, 3);
            canContinue = true;
        });

        super.create();
    }

    override public function update(e:Float):Void
    {
        if (FlxG.keys.justPressed.R)
            FlxG.resetState();
        
        if (canContinue && FlxG.keys.justPressed.ANY)
        {
            switch curScene
            {
                case 0:
                    canContinue = false;
                    FlxTween.tween(bar1Text, {alpha:0}, 1.4);
                    FlxG.camera.fade(FlxColor.BLACK, 4, false, function()
                    {
                        add(slide2);
                        FlxG.camera.stopFX();
                        FlxG.camera.shake(0.01, 0.8);
                        canContinue = true;
                        curScene = 1;
                    });
                case 1:
                    FlxG.switchState(new PlayState());

            }
            
        }

        super.update(e);
    }
}
package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;

class IntroCutsceneState extends FlxState
{
    private var spaceBG:FlxSprite;
    private var islandBG:FlxSprite;
    private var bar1:FlxSprite;
    private var bar1Text:FlxSprite;
    private var canContinue:Bool = false;

    // SLIDE 2
    private var slide2:FlxSprite;

    //SLIDE 3
    private var grp3:FlxGroup;
    private var bg3:FlxSprite;
    private var boho3:FlxSprite;
    private var textBubble3:FlxSprite;
    private var bar3:FlxSprite;
    private var barText3:FlxSprite;

    //SLIDE 4
    private var grp4:FlxGroup;

    private var bg4:FlxSprite;
    private var boho4:FlxSprite;
    private var gloves4:FlxSprite;
    private var bar4:FlxSprite;
    private var barText4:FlxSprite;

    //SLIDE 5
    private var slide5:FlxSprite;

    //SLIDE 6
    private var slide6:FlxSprite;

    private var curScene:Int = 0;

    override public function create():Void
    {
        #if web
            Scores.curMusicType = ".mp3";
        #else
            Scores.curMusicType = ".ogg";
        #end

        FlxG.sound.playMusic("assets/music/introSong" + Scores.curMusicType, 0);
        FlxG.sound.music.fadeIn(4, 0, 0.2);
        FlxG.mouse.visible = false;

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

        // SLIDE 2
        slide2 = new FlxSprite().loadGraphic(AssetPaths.slide2__png);
        slide2.setGraphicSize(0, FlxG.height);
        slide2.updateHitbox();
        slide2.antialiasing = true;

        //SLIDE 3
        grp3 = new FlxGroup();
        bg3 = new FlxSprite().loadGraphic(AssetPaths.bg3__png);
        bg3.setGraphicSize(0, FlxG.height);
        bg3.updateHitbox();
        bg3.antialiasing = true;
        grp3.add(bg3);

        boho3 = new FlxSprite().loadGraphic(AssetPaths.boho3__png);
        boho3.setGraphicSize(0, FlxG.height);
        boho3.updateHitbox();
        boho3.antialiasing = true;
        grp3.add(boho3);

        bar3 = new FlxSprite().loadGraphic(AssetPaths.bar3__png);
        bar3.setGraphicSize(0, FlxG.height);
        bar3.updateHitbox();
        bar3.antialiasing = true;
        grp3.add(bar3);

        textBubble3 = new FlxSprite().loadGraphic(AssetPaths.bubble3__png);
        textBubble3.setGraphicSize(0, FlxG.height);
        textBubble3.updateHitbox();
        textBubble3.antialiasing = true;
        textBubble3.visible = false;
        FlxTween.tween(textBubble3, {y: textBubble3.y + 20, angle: -5}, 0.5, {ease:FlxEase.quadInOut, type:PINGPONG});
        grp3.add(textBubble3);

        barText3 = new FlxSprite().loadGraphic(AssetPaths.barText3__png);
        barText3.setGraphicSize(0, FlxG.height);
        barText3.updateHitbox();
        barText3.antialiasing = true;
        barText3.alpha = 0;
        grp3.add(barText3);

        //SLIDE 4 LMAO
        grp4 = new FlxGroup();
        bg4 = new FlxSprite().loadGraphic(AssetPaths.bg4__png);
        bg4.setGraphicSize(0, FlxG.height);
        bg4.updateHitbox();
        bg4.antialiasing = true;
        grp4.add(bg4);

        boho4 = new FlxSprite().loadGraphic(AssetPaths.boho4__png);
        boho4.setGraphicSize(0, FlxG.height);
        boho4.updateHitbox();
        boho4.antialiasing = true;
        grp4.add(boho4);

        bar4 = new FlxSprite().loadGraphic(AssetPaths.bar4__png);
        bar4.setGraphicSize(0, FlxG.height);
        bar4.updateHitbox();
        bar4.antialiasing = true;
        grp4.add(bar4);

        gloves4 = new FlxSprite().loadGraphic(AssetPaths.gloves4__png);
        gloves4.setGraphicSize(0, FlxG.height);
        gloves4.updateHitbox();
        gloves4.antialiasing = true;
        gloves4.angle = -10;
        FlxTween.tween(gloves4, {angle: 10}, 0.3, {ease:FlxEase.quadInOut, type:PINGPONG});
        grp4.add(gloves4);

        barText4 = new FlxSprite().loadGraphic(AssetPaths.barText4__png);
        barText4.setGraphicSize(0, FlxG.height);
        barText4.updateHitbox();
        barText4.antialiasing = true;
        barText4.alpha = 0;
        grp4.add(barText4);

        //SLIDE 5
        slide5 = new FlxSprite().loadGraphic(AssetPaths.slide5__png);
        slide5.setGraphicSize(0, FlxG.height);
        slide5.updateHitbox();
        slide5.antialiasing = true;

        slide6 = new FlxSprite().loadGraphic(AssetPaths.slide6__png);
        slide6.setGraphicSize(0, FlxG.height);
        slide6.updateHitbox();
        slide6.antialiasing = true;

        FlxG.camera.fade(FlxColor.BLACK, 2, true, function()
        {
            FlxTween.tween(bar1Text, {alpha:1}, 3);
            canContinue = true;
        });

        super.create();
    }

    override public function update(e:Float):Void
    {
        var justSkip:Bool = false;
        var advScene:Bool = false;
        var gamepad = FlxG.gamepads.lastActive;
        if (gamepad != null)
        {
            advScene = gamepad.justPressed.ANY;
            justSkip = gamepad.justPressed.START;
        }


        if (FlxG.keys.justPressed.ENTER || justSkip)
            skip();
        
        if (canContinue)
        {
            if (FlxG.keys.justPressed.ANY || advScene)
                sceneManager();
            
        }

        super.update(e);
    }

    private function skip():Void
    {
        FlxG.sound.music.fadeOut(0.4, 0);
        FlxG.camera.fade(FlxColor.BLACK, 0.5, false, function()
        {
            FlxG.switchState(new MenuState());
        });
    }

    private function sceneManager():Void
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
                canContinue = false;
                FlxG.camera.fade(FlxColor.BLACK, 0.4, false, function()
                {
                    add(grp3);
                    FlxG.camera.fade(FlxColor.BLACK, 0.4, true, function(){
                        canContinue = true;
                        curScene = 2;
                        FlxTween.tween(barText3, {alpha: 1}, 0.7, {onComplete: function(t:FlxTween)
                        {
                            textBubble3.visible = true;
                        }});
                    });
                });

            case 2:
                canContinue = false;
                FlxG.camera.fade(FlxColor.BLACK, 0.4, false, function()
                {
                    remove(grp3);
                    add(grp4);
                    FlxG.camera.fade(FlxColor.BLACK, 0.4, true, function(){
                        canContinue = true;
                        curScene = 3;
                        FlxTween.tween(barText4, {alpha: 1}, 0.7);
                    });
                });

            case 3:
                canContinue = false;
                FlxTween.tween(barText4, {alpha:0}, 1.4);
                FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
                {
                    add(slide5);
                    FlxG.camera.stopFX();
                    FlxG.camera.shake(0.005, 0.4);
                    canContinue = true;
                    curScene = 4;
                });

            case 4:
                canContinue = true;
                add(slide6);
                FlxG.camera.stopFX();
                FlxG.camera.shake(0.01, 0.8);
                FlxG.sound.music.fadeOut(2, 0.1);
                curScene = 5;
            case 5:
                canContinue = false;

                FlxG.switchState(new MenuState());
        }

    }
}
package;

import flixel.FlxSprite;
import flixel.FlxG;

class Healthbar extends FlxSprite
{

    private var theControlThing:Character;

    public function new(x:Float, y:Float, c:Character)
    {
        super(x, y);

        scrollFactor.set();
        theControlThing = c;

        
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        animation.curAnim.curFrame = Math.ceil(theControlThing.actualHealth * 4);
        
    }

}
package;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxG;
import flixel.math.FlxMath;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.FlxSprite;

class Grimbo extends Enemy
{
    public function new(x:Float, y:Float, p:Player)
    {
        super(x, y, p);

        var tex = FlxAtlasFrames.fromSparrow(AssetPaths.GrimboMoveset__png, AssetPaths.GrimboMoveset__xml);
        frames = tex;
        setGraphicSize(0, 100);
        updateHitbox();
        antialiasing = true;
        offset.y += 90;
        width -= 150;
        offset.x += 35;
        height = 15;

        hitboxes[0][0] = [-30, -15, 165, 10];
        generateHitboxes();

        animation.addByPrefix("idle", "GrimboIdle", 24);
        animation.addByPrefix("walk", "GrimboWalk", 24);
        animation.addByPrefix("death", "GrimboDeath", 16, false);
        animation.addByPrefix("attack", "GrimboAttack", 24, false);
        animation.add("hit", [25, 25, 25, 25], 12);
        attackWindup = 0.5;
        actualCooldownLol = 1.3;
        animation.play("idle");

        setFacingFlip(FlxObject.LEFT, false, false);
        setFacingFlip(FlxObject.RIGHT, true, false);

        
        ogOffset = new FlxPoint(offset.x, offset.y);
    }

    override public function attackPlayer():Void
    {
        super.attackPlayer();
        if (justAttacked && animation.curAnim.name != "attack")
            animation.play("attack");
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        FlxG.watch.addQuick("WINDUP", attackWindup);
        FlxG.watch.addQuick("TIMER", attackTmr);

        if (recoilTime <= 0 && !isAttacking)
        {
            if (velocity.x != 0 || velocity.y != 0)
                animation.play("walk");
            else if (animation.curAnim.name != "idle")
                animation.play("idle");     
        }

        if (offset != ogOffset && animation.curAnim.name == "walk")
            offset.x = ogOffset.x;
    }

    override public function chase():Void  
    {
        super.chase();
    }

    override public function kill():Void
    {
        if (animation.curAnim.name != "death")
            animation.play("death", true);
        else
        {
            super.kill();
            /* 
            if (animation.curAnim.finished)
            {
                super.kill();
            } 
            */
        }
    }

    override public function getHurt(dmg:Float, ?pos:FlxSprite):Void
    {
        super.getHurt(dmg, pos);
        animation.play("hit");
        recoilTime = 0.8;
    }

    override private function animationFixins():Void
    {
        super.animationFixins();

        if (facing == FlxObject.LEFT)
        {
            switch animation.curAnim.name
            {
                case "attack":
                    offset.x = ogOffset.x + 100;
                default:
                    offset.x = ogOffset.x;
            }
        }
        else
        {
            switch animation.curAnim.name
            {
                case "hit":
                    offset.x = ogOffset.x + 90;
                default:
                    offset.x = ogOffset.x;
            }
        }
        
        
            
    }
}
package;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

class Character extends Punchable
{
    private var speed:Float = 100;
    public var isAttacking:Bool = false;
    public var justAttacked:Bool = false;
    public var attackOverlapping:Bool = false;
    public var successfulAttack:Bool = false;
    public var actualCooldownLol:Float = 0.3;
    public var attackCooldown:Float = 0;
    public var canAttack:Bool = true;
    public var comboWinMin:Float = 0;
    public var comboWinMax:Float = 0;
    public var canCombo:Bool = false;
    public var alternatingPunch:Bool = false;

    public var paralyzed:Float = 0;

    public var CHAR_TYPE:Int = 0;
    public static inline var ENEMY:Int = 10;
    public static inline var PLAYER:Int = 1;
    public static inline var GRIMBO:Int = 11;
    public var seesPlayer:Bool = false;
    public var playerPos(default, null):FlxPoint;

    public var isDead:Bool = false;
    private var ogOffset:FlxPoint;

    public function new(X:Float, Y:Float)
    {
        super(X, Y);

    }

    override public function update(e:Float):Void
    {
        animationFixins();

        super.update(e);

        
        if (paralyzed <= 0)
        {
            if (justAttacked && canAttack)
            {
                attackCooldown = actualCooldownLol;
            }

            if (attackCooldown > 0)
            {   
                if (justAttacked)
                    successfulAttack = true;
                else
                    successfulAttack = false;

                attackCooldown -= FlxG.elapsed;
                if (attackCooldown > comboWinMin && attackCooldown < comboWinMax)
                {
                    canCombo = true;
                    canAttack = true;
                }
                else
                {
                    canCombo = false;
                    canAttack = false;
                }
                    
            }
            else
                canAttack = true;
        }
        else
        {
            paralyzed -= FlxG.elapsed;
            attackCooldown = actualCooldownLol;
            canAttack = false;
            canCombo = false;
            isAttacking = false;
            successfulAttack = false;
        }    
    }

    private function animationFixins():Void
    {
    }
}
package;
import flixel.FlxG;
import flixel.math.FlxPoint;

class Character extends Punchable
{
    private var speed:Float = 100;
    public var isAttacking:Bool = false;
    public var attackCooldown:Float = 0;
    public var canAttack:Bool = true;

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

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        animationFixins();

        if (isAttacking)
            attackCooldown = 0.3;

        if (attackCooldown > 0)
        {   
            attackCooldown -= FlxG.elapsed;
            canAttack = false;
        }
        else
            canAttack = true;
            
    }

    private function animationFixins():Void
    {
    }
}
package;

import flixel.math.FlxPoint;
import flixel.FlxG;
import flixel.math.FlxVelocity;
import flixel.FlxObject;

class Enemy extends Character
{
    private var _brain:FSM;
    private var _idleTmr:Float;
    private var _moveDir:Float;
    public var seesPlayer:Bool = false;
    public var playerPos(default, null):FlxPoint;
    private var attackTmr:Float = 0;
    private var _player:Player;

    public function new(X:Float, Y:Float, p:Player)
    {
        super(X, Y);
        generateHitboxes();

        _brain = new FSM(idle);
        _idleTmr = 0;
        playerPos = FlxPoint.get();

        _player = p;
    }


    public function idle():Void
    {
        if (seesPlayer)
        {
            _brain.activeState = chase;
        }
        else if (_idleTmr <= 0)
        {
            if (FlxG.random.bool(1))
            {
                _moveDir = -1;
                velocity.x = velocity.y = 0;
            }
            else
            {
                _moveDir = FlxG.random.int(0, 8) * 45;

                velocity.set(speed * 0.5, 0);
                velocity.rotate(FlxPoint.weak(), _moveDir);
            }
            _idleTmr = FlxG.random.int(1, 4);
        }
        else   
            _idleTmr -= FlxG.elapsed;
    }

    public function chase():Void
    {
        if (!seesPlayer)
        {
            _brain.activeState = idle;
        }
        else if (invincibleFrames <= 0)
        {
            FlxVelocity.moveTowardsPoint(this, playerPos, Std.int(speed));
        }
        
        if (isAttacking)
            _brain.activeState = attackPlayer;
    }

    public function attackPlayer():Void
    {
        attackTmr += FlxG.elapsed;

        if (attackTmr >= 1)
        {
            _player.getHurt(0.25, this);
            attackTmr = 0;
        }
            
        if (!isAttacking)
            _brain.activeState = idle;
    }

    override public function update(elapsed:Float):Void
    {
        _brain.update();
        super.update(elapsed);

        if (invincibleFrames <= 0)
        {
            if (velocity.x > 0)
                facing = FlxObject.RIGHT;
            if (velocity.x < 0)
                facing = FlxObject.LEFT;
        }
    }

}
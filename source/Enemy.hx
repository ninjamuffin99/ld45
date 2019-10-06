package;

import flixel.math.FlxPoint;
import flixel.FlxG;
import flixel.math.FlxVelocity;
import flixel.FlxObject;
import flixel.math.FlxMath;
import flixel.FlxSprite;
import flixel.math.FlxAngle;

class Enemy extends Character
{
    private var _brain:FSM;
    private var _idleTmr:Float;
    private var _moveDir:Float;

    private var attackTmr:Float = 0;
    private var attackWindup:Float = 1;
    private var _player:Player;

    public function new(X:Float, Y:Float, p:Player)
    {
        super(X, Y);
        generateHitboxes();

        CHAR_TYPE = Character.ENEMY;
        offset.y -= 20;
        height += 20;

        _brain = new FSM(idle);
        _idleTmr = 0;
        playerPos = FlxPoint.get();

        attackCooldown = 5;

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
            var rads:Float = Math.atan2(_player.getMidpoint().y - getMidpoint().y, _player.getMidpoint().x - getMidpoint().x);
		    var degs = FlxAngle.asDegrees(rads);

            velocity.set(speed, 0);
            velocity.rotate(FlxPoint.weak(0, 0), degs);

            //FlxVelocity.moveTowardsPoint(this, playerPos, Std.int(speed));
        }
        
        if (isAttacking)
            _brain.activeState = attackPlayer;
    }

    public function attackPlayer():Void
    {
        attackTmr += FlxG.elapsed;

        if (attackTmr >= attackWindup)
        {
            justAttacked = true;

            if (successfulAttack)
            {
                if (attackOverlapping)
                    _player.getHurt(0.25, this);
                attackTmr = 0;
                isAttacking = false;
            }
        }
            
        if (!isAttacking || _player.isDead)
            _brain.activeState = idle;
    }

    override public function getHurt(dmg:Float, ?fromPos:FlxSprite):Void
    {
        super.getHurt(dmg, fromPos);
        attackCooldown = 3;
        justAttacked = false;
        attackTmr = 0;
        isAttacking = false;
    }

    override private function getKilled():Void
    {
        super.getKilled();
        kill();
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
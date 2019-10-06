package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxObject;
import flixel.math.FlxPoint;

class Player extends Character
{
    public var rolling:Bool = false;

    public function new(X:Float, Y:Float)
    {
        super(X, Y);

        CHAR_TYPE = Character.PLAYER;

        speed = 230;

        color = FlxColor.WHITE;
        var tex = FlxAtlasFrames.fromSparrow(AssetPaths.HoboMoveSet__png, AssetPaths.HoboMoveSet__xml);
        frames = tex;
        setGraphicSize(0, 100);
        updateHitbox();
        antialiasing = true;
        offset.y = 165;
        var daOffsetY:Float = height - offset.y;
        height = 15;
        generateHitboxes();

        animation.addByPrefix("idle", "HoboIdle", 24, true);
        animation.addByPrefix("punch", "HoboPunch", 24, false);
        animation.addByPrefix("walk", "HoboWalk", 24, true);
        animation.addByPrefix("hurt", "HoboHurt", 20, false);
        animation.addByPrefix("killed", "HoboDeath", 24, false);
        animation.addByPrefix("block", "HoboBlock", 24, false);
        animation.play("idle");

        setFacingFlip(FlxObject.LEFT, true, false);
        setFacingFlip(FlxObject.RIGHT, false, false);

        grpHurtboxes.forEach(function(spr:Hitbox)
        {
            spr.color = FlxColor.GREEN;
        });

        grpHitboxes.forEach(function(spr:Hitbox)
        {
            spr.color = FlxColor.RED;
        });

        // grpHitboxes.visible = false;
        // grpHurtboxes.visible = false;

        facing = FlxObject.RIGHT;
        drag.x = 700;
        drag.y = 700;

        ogOffset = new FlxPoint(offset.x, offset.y);
        trace(ogOffset);
    }

    private var resetTimer:Float = 0;

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        FlxG.watch.addQuick("FullPos", getPosition());
        FlxG.watch.addQuick("OriginPlayer", origin);
        
        /* 
        if (getPosition().x != daSprite.getPosition().x)
            setPosition(daSprite.getPosition().x, getPosition().y);
        if (getPosition().y != daSprite.getPosition().y)
            y = daSprite.y - 85;
        */ 

        if (!isDead)
        {
            movement();
        }
        else
        {
            resetTimer += FlxG.elapsed;

            if (resetTimer >= 3)
                FlxG.resetState();
        }
        

        FlxG.watch.addQuick("curANime", animation.curAnim.name);
        FlxG.watch.addQuick("offset", offset);

    }

    override public function getHurt(dmg:Float, ?fromPos:FlxSprite):Void
    {
        super.getHurt(dmg, fromPos);

        if (!blocking)
            animation.play("hurt", true);
    }

    private function movement():Void
    {
        var _left:Bool = FlxG.keys.anyPressed(["LEFT", "A"]);
        var _right:Bool = FlxG.keys.anyPressed(["RIGHT", "D"]);
        var _up:Bool = FlxG.keys.anyPressed(["UP", "W"]);
        var _down:Bool = FlxG.keys.anyPressed(["DOWN", "S"]);

        var _leftP:Bool = FlxG.keys.anyJustPressed(["LEFT", "A"]);
        var _rightP:Bool = FlxG.keys.anyJustPressed(["RIGHT", "D"]);
        var _upP:Bool = FlxG.keys.anyJustPressed(["UP", "W"]);
        var _downP:Bool = FlxG.keys.anyJustPressed(["DOWN", "S"]);

        var _attack:Bool = FlxG.keys.justPressed.SPACE;
        var _blocking:Bool = FlxG.keys.pressed.SHIFT;

        speed = 230;

        var gamepad = FlxG.gamepads.lastActive;
		if (gamepad != null)
		{
            FlxG.watch.addQuick("AnalogSHit", gamepad.analog.value.LEFT_STICK_X);
			if (gamepad.anyPressed(["LEFT", "DPAD_LEFT", "LEFT_STICK_DIGITAL_LEFT"]))
			{
				_left = true;
			}
			
			if (gamepad.anyPressed(["RIGHT", "DPAD_RIGHT","LEFT_STICK_DIGITAL_RIGHT"]))
			{
				_right = true;
			}

            if (gamepad.anyPressed(["UP", "DPAD_UP", "LEFT_STICK_DIGITAL_UP"]))
			{
				_up = true;
			}
			
			if (gamepad.anyPressed(["DOWN", "DPAD_DOWN","LEFT_STICK_DIGITAL_DOWN"]))
			{
				_down = true;
			}

            if (gamepad.anyJustPressed(["LEFT", "DPAD_LEFT", "LEFT_STICK_DIGITAL_LEFT"]))
			{
				_leftP = true;
			}
			
			if (gamepad.anyJustPressed(["RIGHT", "DPAD_RIGHT","LEFT_STICK_DIGITAL_RIGHT"]))
			{
				_rightP = true;
			}

            if (gamepad.anyJustPressed(["UP", "DPAD_UP", "LEFT_STICK_DIGITAL_UP"]))
			{
				_upP = true;
			}
			
			if (gamepad.anyJustPressed(["DOWN", "DPAD_DOWN","LEFT_STICK_DIGITAL_DOWN"]))
			{
				_downP = true;
			}

            if (gamepad.justPressed.X)
                _attack = true;
            
            if (gamepad.pressed.LEFT_SHOULDER || gamepad.pressed.RIGHT_SHOULDER || gamepad.pressed.LEFT_TRIGGER || gamepad.pressed.RIGHT_TRIGGER)
                _blocking = true;

		}

        if (_left && _right)
            _left = _right = false;

        if ((_left || _right || _up || _down) && !rolling)
        {
            if (_left || _right)
            {
                if (_left)
                {
                    facing = FlxObject.LEFT;
                    velocity.x = -speed;
                    
                }
                    
                if (_right)
                {
                    facing = FlxObject.RIGHT;
                    velocity.x = speed;
                }

                
            }

            if (_up || _down)
            {
                if (_up)
                    velocity.y = -speed;
                if (_down)
                    velocity.y = speed;
                
                
            }

            var gamepad = FlxG.gamepads.lastActive;
            if (gamepad != null)
            {
                velocity.x = speed * gamepad.analog.value.LEFT_STICK_X;
                velocity.y = speed * gamepad.analog.value.LEFT_STICK_Y;
            }

            if (animation.curAnim.name == "idle")
                animation.play("walk");
        }
        else
        {
            if (animation.curAnim.name == "walk")
                animation.play("idle");
        }
            
        
        
        if (_attack && canAttack)
        {
            isAttacking = true;
            animation.play("punch", true);
        }

        if (animation.curAnim.name != "idle" && animation.curAnim.finished && animation.curAnim.name != "block")
        {
            isAttacking = false;
            animation.play("idle");
        }

        if (_blocking)
        {
            blocking = true;
            if (!rolling)
            {
                velocity.x *= 0;
                velocity.y *= 0;
            }
            
            if (animation.curAnim.name != "block")
                animation.play("block");
            
            if ((_leftP || _rightP || _upP || _downP) && !rolling)
            {
                rolling = true;
                
                if (_leftP || _rightP)
                {
                    if (_leftP)
                    {
                        facing = FlxObject.LEFT;
                        velocity.x = -speed * 2;
                        
                    }
                        
                    if (_rightP)
                    {
                        facing = FlxObject.RIGHT;
                        velocity.x = speed * 2;
                    }

                    
                }

                if (_upP || _downP)
                {
                    if (_upP)
                        velocity.y = -speed * 1.7;
                    if (_downP)
                        velocity.y = speed * 1.7;
                    
                    
                }

            }
        }
        else
        {
            if (animation.curAnim.name == "block")
                animation.play("idle");
            blocking = false;
        }

        if (rolling)
        {
            if (velocity.x == 0 && velocity.y == 0)
                rolling = false;
        }
            

        if (animation.curAnim.name == "punch")
        {
            velocity.x *= 0.2;
            velocity.y *= 0.2;
        }

    }

    override private function getKilled():Void
    {
        if (animation.curAnim.name != "killed")
            animation.play("killed");
        
        isDead = true;

        super.getKilled();
    }

    override private function animationFixins():Void
    {
        super.animationFixins();
        if (facing == FlxObject.LEFT && animation.curAnim.name == "punch")
        {
            offset.x = ogOffset.x + 50;
        }
        else
            offset.x = ogOffset.x;
    }
}
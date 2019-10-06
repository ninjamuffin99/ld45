package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.util.FlxSort;

class PlayState extends FlxState
{
	private var ground:FlxSprite;
	private var ground2:FlxSprite;
	private var _player:Player;
	private var grpCharacters:FlxTypedGroup<Character>;

	override public function create():Void
	{
		trace("BOOTED UP");

		FlxG.watch.addMouse();	

		ground = new FlxSprite(0, FlxG.height - 10).makeGraphic(FlxG.width, 10);
		ground.immovable = true;
		add(ground);

		ground2 = new FlxSprite(0, FlxG.height - 260).makeGraphic(FlxG.width, 10);
		ground2.immovable = true;
		add(ground2);

		var bg:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.beta_bg0__png);
		bg.setGraphicSize(FlxG.width, FlxG.height);
		bg.updateHitbox();
		add(bg);

		var bg4:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.beta_bg4__png);
		add(bg4);

		grpCharacters = new FlxTypedGroup<Character>();
		add(grpCharacters);

		_player = new Player(100, 400);
		grpCharacters.add(_player);

		var e:Enemy = new Enemy(_player.x + 300, _player.y, _player);
		grpCharacters.add(e);

		var g:Grimbo = new Grimbo(e.x + 100, e.y - 100, _player);
		grpCharacters.add(g);

		FlxG.worldBounds.set(0, 0, FlxG.width, FlxG.height);

		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		grpCharacters.forEach(function(c:Character)
		{
			
			if (c.CHAR_TYPE == c.TypeENEMY)
			{
				var distanceToPlayer:Float = FlxMath.distanceToPoint(c.daSprite, _player.daSprite.getMidpoint());
				if (distanceToPlayer < 300 && distanceToPlayer > 70 && !_player.isDead)
				{
					c.seesPlayer = true;
					c.playerPos.copyFrom(_player.daSprite.getPosition());
				}
				else
					c.seesPlayer = false;

				if (FlxG.overlap(c.grpHurtboxes, _player.grpHitboxes) && _player.isAttacking)
				{
					trace("HURTING???");
					c.getHurt(0.5, _player);
				}

				if (FlxG.overlap(_player.grpHurtboxes, c.grpHitboxes) && _player.invincibleFrames <= 0)
				{
					trace("GETTING HURT???");
					c.isAttacking = true;
						
				}
				else
					c.isAttacking = false;

			}
			
			/*
				_player.grpHurtboxes.forEach(function(pHit:Hitbox)
				{
					e.grpHurtboxes.forEach(function(eHurt:Hitbox)
					{
						if (FlxG.overlap(pHit, eHurt))
						{
							e.getHurt(0.1);
						}
					});
				});
			*/

			
		});

		grpCharacters.sort(Punchable.bySprite, FlxSort.ASCENDING);


		FlxG.collide(ground, grpCharacters);
		FlxG.collide(ground2, grpCharacters);
	
	}
}

package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.group.FlxGroup;

class PlayState extends FlxState
{
	private var ground:FlxSprite;
	private var ground2:FlxSprite;
	private var _player:Player;
	private var grpEnemies:FlxTypedGroup<Enemy>;

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

		grpEnemies = new FlxTypedGroup<Enemy>();
		add(grpEnemies);

		_player = new Player(100, 400);
		add(_player);

		var e:Enemy = new Enemy(_player.x + 300, _player.y);
		grpEnemies.add(e);

		FlxG.worldBounds.set(0, 0, FlxG.width, FlxG.height);

		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		grpEnemies.forEach(function(e:Enemy)
		{
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

			if (FlxG.overlap(e.grpHurtboxes, _player.grpHitboxes) && _player.isAttacking)
			{
				trace("HURTING???");
				e.getHurt(0.5, _player.getPosition());
			}

			if (FlxG.overlap(_player.grpHurtboxes, e.grpHitboxes))
			{
				trace("GETTING HURT???");
				_player.getHurt(0.1);
			}
		});

		FlxG.collide(ground, _player);
		FlxG.collide(ground2, _player);
	
	}
}

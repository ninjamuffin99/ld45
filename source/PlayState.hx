package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.util.FlxSort;
import flixel.math.FlxVector;

class PlayState extends FlxState
{
	private var ground:FlxSprite;
	private var ground2:FlxSprite;
	private var _player:Player;
	private var grpCharacters:FlxTypedGroup<Character>;
	private var grpItems:FlxTypedGroup<Item>;

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

		var bg:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.bg1_1__png);
		bg.setGraphicSize(FlxG.width, FlxG.height);
		bg.updateHitbox();
		add(bg);

		var bg4:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.bg1_6__png);
		add(bg4);

		grpItems = new FlxTypedGroup<Item>();
		add(grpItems);

		grpCharacters = new FlxTypedGroup<Character>();
		add(grpCharacters);

		_player = new Player(100, 400);
		grpCharacters.add(_player);
		add(_player.grpHitboxes);
		add(_player.grpHurtboxes);

		var e:Enemy = new Enemy(_player.x + 300, _player.y, _player);
		//grpCharacters.add(e);
		add(e.grpHitboxes);
		add(e.grpHurtboxes);

		var g:Grimbo = new Grimbo(e.x + 100, e.y - 100, _player);
		grpCharacters.add(g);
		add(g.grpHitboxes);
		add(g.grpHurtboxes);

		FlxG.worldBounds.set(0, 0, FlxG.width, FlxG.height);

		super.create();
	}



	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (grpCharacters.length == 1)
		{
			for (i in 0...FlxG.random.int(2, 6))
			{
				var grim:Grimbo = new Grimbo(FlxG.random.float(40, FlxG.width - 120), FlxG.random.float(FlxG.height - 220, FlxG.height - 130), _player);
				grpCharacters.add(grim);
				add(grim.grpHitboxes);
				add(grim.grpHurtboxes);
			}
		}

		FlxG.overlap(grpItems, _player, function(item:Item, p:Player)
		{
			item.kill();
			p.actualHealth += 0.25;
		});

		grpCharacters.forEach(function(c:Character)
		{
			
			if (c.CHAR_TYPE == Character.ENEMY)
			{
				

				var dx:Float = c.getMidpoint().x - _player.getMidpoint().x;
				var dy:Float = c.getMidpoint().y - _player.getMidpoint().y;
				var distanceToPlayer:Int = Std.int(FlxMath.vectorLength(dx, dy));

				FlxG.watch.addQuick("Dist to player", distanceToPlayer);

				if (distanceToPlayer < 300 && !_player.isDead)
				{
					c.seesPlayer = true;
					c.playerPos.copyFrom(_player.getPosition());
				}
				else
					c.seesPlayer = false;

				if (FlxG.overlap(c.grpHurtboxes, _player.grpHitboxes) && _player.isAttacking)
				{
					c.getHurt(0.5, _player);
				}

				if (FlxG.overlap(_player.grpHurtboxes, c.grpHitboxes) && _player.invincibleFrames <= 0)
				{
					c.isAttacking = true;
						
				}
				else
					c.isAttacking = false;
				
				if (!c.alive)
				{
					// if (FlxG.random.bool(10))
					//var health:HealthPack = new HealthPack(c.getPosition().x, c.getPosition().y);
					//grpItems.add(health);

					grpCharacters.remove(c, true);
				}
			}
		});

		grpCharacters.sort(Punchable.bySprite, FlxSort.ASCENDING);

		FlxG.collide(ground, grpCharacters);
		FlxG.collide(ground2, grpCharacters);
		FlxG.collide(grpCharacters, grpCharacters);
	
	}
}

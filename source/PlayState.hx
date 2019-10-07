package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.util.FlxSort;
import flixel.math.FlxVector;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	private var ground:FlxSprite;
	private var ground2:FlxSprite;
	private var _player:Player;
	private var grpCharacters:FlxTypedGroup<Character>;
	private var grpItems:FlxTypedGroup<Item>;

	private var fg:FlxSprite;

	public static var curBG:Int = 2;

	override public function create():Void
	{
		trace("BOOTED UP");
		FlxG.camera.fade(FlxColor.BLACK, 1, true);

		FlxG.watch.addMouse();	

		persistentUpdate = false;
		persistentDraw = true;

		ground = new FlxSprite(0, FlxG.height - 10).makeGraphic(FlxG.width * 3, 10);
		ground.immovable = true;
		add(ground);

		ground2 = new FlxSprite(0, FlxG.height - 260).makeGraphic(FlxG.width * 3, 10);
		ground2.immovable = true;
		add(ground2);

		var bgNum:Int = curBG;
		
		var bg:FlxSprite = new FlxSprite().loadGraphic("assets/images/bg" + bgNum + "/bg" + bgNum + "-1.png");
		bg.setGraphicSize(0, FlxG.height);
		bg.updateHitbox();
		bg.scrollFactor.set();
		add(bg);

		var clouds:FlxSprite = new FlxSprite().loadGraphic("assets/images/bg" + bgNum + "/bg" + bgNum + "-2.png");
		clouds.setGraphicSize(0, FlxG.height);
		clouds.updateHitbox();
		clouds.scrollFactor.set(0.25, 0.25);
		add(clouds);

		var mountain:FlxSprite = new FlxSprite().loadGraphic("assets/images/bg" + bgNum + "/bg" + bgNum + "-3.png");
		mountain.setGraphicSize(0, FlxG.height);
		mountain.updateHitbox();
		mountain.scrollFactor.set(0.4, 0.4);
		add(mountain);

		var mountain2:FlxSprite = new FlxSprite().loadGraphic("assets/images/bg" + bgNum + "/bg" + bgNum + "-4.png");
		mountain2.setGraphicSize(0, FlxG.height);
		mountain2.updateHitbox();
		mountain2.scrollFactor.set(0.55, 0.55);
		add(mountain2);

		var mountain3:FlxSprite = new FlxSprite().loadGraphic("assets/images/bg" + bgNum + "/bg" + bgNum + "-5.png");
		mountain3.setGraphicSize(0, FlxG.height);
		mountain3.updateHitbox();
		mountain3.scrollFactor.set(0.7, 0.7);
		add(mountain3);


		var bg4:FlxSprite = new FlxSprite().loadGraphic("assets/images/bg" + bgNum + "/bg" + bgNum + "-6.png");
		add(bg4);

		fg = new FlxSprite(0, 0).loadGraphic("assets/images/bg" + bgNum + "/bg" + bgNum + "-7.png");
		fg.alpha = 1;
		fg.scrollFactor.set(2.2, 2.2);

		if (curBG == 3)
		{
			fg.loadGraphic("assets/images/bg" + bgNum + "/bg" + bgNum + "-9.png");
			fg.scrollFactor.set(1, 1);
		}
			
		
		//gets added after the player
		

		grpItems = new FlxTypedGroup<Item>();
		add(grpItems);

		grpCharacters = new FlxTypedGroup<Character>();
		add(grpCharacters);

		add(fg);

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

		FlxG.camera.follow(_player);
		var camYOffset:Float = 50;
		FlxG.camera.setScrollBoundsRect(0, -camYOffset, bg4.width, bg4.height + camYOffset);

		FlxG.worldBounds.set(0, 0, FlxG.width * 3, FlxG.height);

		var daHealth:Healthbar = new Healthbar(10, 10, _player);
		var phealth = FlxAtlasFrames.fromSparrow(AssetPaths.HealthBears__png, AssetPaths.HealthBears__xml);
		daHealth.frames = phealth;
		daHealth.setGraphicSize(Std.int(daHealth.width * 0.5));
		daHealth.updateHitbox();
		daHealth.antialiasing = true;
		daHealth.animation.add("health", [4, 3, 2, 1, 0], 0);
        daHealth.animation.play("health");
		add(daHealth);

		super.create();
	}


	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		var xMin:Float = 0;
		var xMax:Float = 0;

		switch(curBG)
		{
			case 1:
				xMin = 460;
				xMax = 900;
			case 2:
				xMin = 0;
				xMax = 50;
			default:
				xMin = 0;
				xMax = 1;
		}

		if ((_player.x > xMin && _player.x < xMax) || curBG == 3 && _player.y > FlxG.height - 100)
		{
			if (fg.alpha > 0.3)
			{
				fg.alpha -= FlxG.elapsed;
			}
			
		}
		else
		{
			if (fg.alpha < 1)
			{
				fg.alpha += FlxG.elapsed;
			}
		}

		var gamepad = FlxG.gamepads.lastActive;
		if (gamepad != null)
		{
			if (gamepad.justPressed.START)
				openSubState(new SubstatePause());
		}

		if (FlxG.keys.justPressed.ENTER)
			openSubState(new SubstatePause());

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

				if (distanceToPlayer < 300 && !_player.isDead)
				{
					c.seesPlayer = true;
					c.playerPos.copyFrom(_player.getPosition());
				}
				else
					c.seesPlayer = false;

				if (FlxG.overlap(c.grpHurtboxes, _player.grpHitboxes) && _player.successfulAttack)
				{
					c.getHurt(0.5, _player);
					_player.attackOverlapping = true;
					var daImpact:Impacts = new Impacts(_player.grpHitboxes.members[0].x, _player.grpHitboxes.members[0].y - 50);
					add(daImpact);
					FlxG.camera.shake(FlxG.random.float(0.008, 0.012), FlxG.random.float(0.07, 0.11));
				}

				if (FlxG.overlap(_player.grpHurtboxes, c.grpHitboxes) && _player.invincibleFrames <= 0)
				{
					c.isAttacking = true;
					c.attackOverlapping = true;
				}
				else
					c.attackOverlapping = false;
				
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

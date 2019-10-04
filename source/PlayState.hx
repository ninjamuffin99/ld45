package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxG;

class PlayState extends FlxState
{
	private var ground:FlxSprite;
	private var ground2:FlxSprite;
	private var _player:Player;

	override public function create():Void
	{
		trace("BOOTED UP");

		

		ground = new FlxSprite(0, FlxG.height - 50).makeGraphic(FlxG.width, 10);
		ground.immovable = true;
		add(ground);

		ground2 = new FlxSprite(0, FlxG.height - 220).makeGraphic(FlxG.width, 10);
		ground2.immovable = true;
		add(ground2);

		_player = new Player(100, 400);
		add(_player);

		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		FlxG.collide(ground, _player);
		FlxG.collide(ground2, _player);
	}
}

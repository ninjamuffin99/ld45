package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxG;

class PlayState extends FlxState
{
	private var ground:FlxSprite;
	private var _player:Player;

	override public function create():Void
	{
		trace("BOOTED UP");

		_player = new Player(10, 10);
		add(_player);

		ground = new FlxSprite(0, FlxG.height - 50).makeGraphic(FlxG.width, 10);
		ground.immovable = true;
		add(ground);

		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		FlxG.collide(ground, _player);

		
		super.update(elapsed);
	}
}

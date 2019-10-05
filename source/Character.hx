package;

class Character extends Punchable
{
    private var speed:Float = 100;
    public var isAttacking:Bool = false;

    public function new(X:Float, Y:Float)
    {
        super(X, Y);

    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }
}
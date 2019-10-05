package;

class Enemy extends Character
{
    public function new(X:Float, Y:Float)
    {
        super(X, Y);
        hurtboxes[0][0] = [0, 0, 100, 100];
        generateHitboxes();
    }
}
package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class TypeShii extends FlxSprite
{
    var randomNums = FlxG.random.int(0,3);
    public function new(x:Float, y:Float) {
        super(x,y);
        loadGraphic('images/errors/${FlxG.random.int(0,3)}.png');
        this.scale.set(1.2,1.2);
        FlxTween.tween(this,{"scale.x":1,"scale.y":1},0.7,{type: ONESHOT, ease: FlxEase.expoOut});
    }
}
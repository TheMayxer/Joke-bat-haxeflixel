package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;

class Crached extends FlxState
{
    public function new() {
        super();
        var shit = new FlxSprite().loadGraphic("images/message.png");
        shit.screenCenter();
        add(shit);
    }

    override function update(elapsed:Float) {
        super.update(elapsed);
        if(FlxG.keys.justPressed.R) FlxG.switchState(PlayState.new);
    }
}
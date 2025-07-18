package;

import TypeShii;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class PlayState extends FlxState
{
	var spawnError:FlxTimer;
	var errosGroup:FlxTypedGroup<FlxSprite>;
	var quantities:Int = 0;
	var maxWin:Int = FlxG.random.int(2,10);
	var quantitiesWindow:FlxText;

	override public function create()
	{
		super.create();
		var chess = new FlxBackdrop("images/chess.png",XY,0.0,0.0);
		chess.velocity.set(30,30);
		add(chess);

		var taskbar = new FlxSprite(-13.2,420.95).loadGraphic("images/taskbar.png");
		add(taskbar);

		var windows = new FlxSprite(5.2,427.75).loadGraphic("images/windows.png");
		add(windows);

		var search = new FlxSprite(72.3,430.85).loadGraphic("images/search.png");
		add(search);

		var trash = new FlxSprite(13.8,24.6).loadGraphic("images/trash.png");
		add(trash);

		errosGroup = new FlxTypedGroup<FlxSprite>();
		add(errosGroup);

		spawnError = new FlxTimer();
		spawnError.start(FlxG.random.float(0.5,2),function (tmr:FlxTimer) {
			var error = new TypeShii(0,0);
			error.x = FlxG.random.float(0,FlxG.width - error.width);
			error.y = FlxG.random.float(0,FlxG.height - error.height);
			errosGroup.add(error);
			quantities ++;
			trace(quantities);
		},0);

		quantitiesWindow = new FlxText(0,0,FlxG.width,"Max of windows: coiso/0",20);
		quantitiesWindow.setFormat("fonts/comic-sans.ttf",20,FlxColor.WHITE,RIGHT,FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		add(quantitiesWindow);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		quantitiesWindow.text = 'Max of windows: ${maxWin}/${quantities}';
		for(turip in errosGroup.members){
			if(FlxG.mouse.overlaps(turip) && FlxG.mouse.justPressed)
			{
				errosGroup.remove(turip,true);
				quantities --;
				trace(quantities);
				quantitiesWindow.scale.set(0.8,0.6);
				FlxTween.cancelTweensOf(quantitiesWindow);
				FlxTween.tween(quantitiesWindow,{"scale.x":1,"scale.y":1},1,{type: ONESHOT, ease: FlxEase.smoothStepOut});
			}
		}

		if(quantities >= maxWin) 
		{
			spawnError.cancel();
			FlxTween.tween(FlxG.camera,{zoom:1.5},0.4,{type: ONESHOT, ease: FlxEase.smootherStepOut});
			FlxG.camera.fade(FlxColor.BLACK,0.7,false,function () {FlxG.switchState(Freeze.new);},false);
		}
	}
}

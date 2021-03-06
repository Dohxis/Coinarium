package;

import flixel.FlxSprite;
import flixel.util.FlxSpriteUtil;
import flixel.addons.effects.FlxTrail;

class Enemy extends FlxSprite {

	public var speed:Float = 1;
	public var increaseSpeed:Float = 0;
	
	public function new(X:Int, Y:Int){
		super(X, Y);
		loadGraphic("enemy");
		antialiasing = true;
	}

	override public function update():Void {
		increaseSpeed += 0.000001;
		x += speed + increaseSpeed;
		y += speed - 0.98;
		FlxSpriteUtil.screenWrap(this);
		super.update();
	}

	override public function destroy():Void {
		super.destroy();
	}

}
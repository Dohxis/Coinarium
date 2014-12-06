package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxColor;
import flixel.tile.FlxTilemap;
import flixel.group.FlxGroup;

class PlayState extends FlxState {

	private static var isDead:Bool = false;
	private var level:FlxTilemap;
	private var player:FlxSprite;
	private var score:FlxText;
	private var objects:FlxGroup;
	private var text:FlxText;

	override public function create():Void {
		FlxG.cameras.bgColor = FlxColor.WHITE;
		FlxG.mouse.visible = false;
		super.create();
	}
	
	override public function destroy():Void {
		super.destroy();
	}

	override public function update():Void {
		super.update();
	}	
}
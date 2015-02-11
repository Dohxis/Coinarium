package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class AboutState extends FlxState {

	override public function create():Void {
		FlxG.cameras.bgColor = 0x99356288;

		var title:FlxText = new FlxText(0, 0, FlxG.width, "\nCoinarium\nGame was created by Dohxis for Ludum Dare in 48 hours! It was developed with Haxe and 2D game engine HaxeFlixel. All sounds were generated with SFXR!\nThanks for playing my game :)\n\nPress [Enter] to go back...", 15);
		title.color = FlxColor.WHITE;
		title.alignment = "left";

		add(title);
		super.create();
	}
	
	override public function destroy():Void {
		super.destroy();
	}

	override public function update():Void {
		if(FlxG.keys.anyPressed(["ENTER"])){
			FlxG.switchState(new MenuState());
		}
		super.update();
	}	
}
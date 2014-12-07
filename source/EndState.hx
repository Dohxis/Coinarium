package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class EndState extends FlxState {

	override public function create():Void {
		FlxG.cameras.bgColor = 0x99356288;

		var title:FlxText = new FlxText(0, 80, FlxG.width, "You Lost!", 35);
		title.color = FlxColor.WHITE;
		title.alignment = "center";

		var desc:FlxText = new FlxText(0, 116, FlxG.width, "Your highscore " + Reg.hScore + "\nScore this time " + Reg.score, 15);
		desc.alignment = "center";
		desc.color = 0xFF6600;

		var next:FlxText = new FlxText(0, FlxG.height - 15, FlxG.width, "Press [Enter] to continue...", 10);
		next.alignment = "center";
		next.color = FlxColor.WHITE;

		add(title);
		add(desc);
		add(next);
		super.create();
	}
	
	override public function destroy():Void {
		super.destroy();
	}

	override public function update():Void {
		if(FlxG.keys.anyPressed(["ENTER"])){
			FlxG.switchState(new PlayState());
		}
		super.update();
	}	
}
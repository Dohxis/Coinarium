package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class MenuState extends FlxState {

	private function playScene():Void {
		FlxG.switchState(new PlayState());
	}

	private function aboutScene():Void {
		FlxG.switchState(new AboutState());
	}

	override public function create():Void {
		FlxG.sound.playMusic("track",0.25);
		FlxG.cameras.bgColor = 0x99356288;

		var title:FlxText = new FlxText(0, 50, FlxG.width, "PlaceHolder", 25);
		title.color = FlxColor.WHITE;
		title.alignment = "center";

		var dare:FlxText = new FlxText(67, 76, FlxG.width, "Ludum Dare ", 15);
		dare.color = 0xFF6600;
		dare.alignment = "center";

		var desc:FlxText = new FlxText(-55, 76, FlxG.width, "Developed for ", 15);
		desc.alignment = "center";	

		var playButton:FlxButton = new FlxButton(FlxG.width / 2 - 80, 125, "Play", playScene);
		playButton.label.setFormat(24,1,"center");
		playButton.makeGraphic(160, 35, FlxColor.GRAY);

		var aboutButton:FlxButton = new FlxButton(FlxG.width / 2 - 80, 165, "About", aboutScene);
		aboutButton.label.setFormat(24,1,"center");
		aboutButton.makeGraphic(160, 35, FlxColor.GRAY);

		add(title);
		add(desc);
		add(dare);
		add(playButton);
		add(aboutButton);
		super.create();
	}
	
	override public function destroy():Void {
		super.destroy();
	}

	override public function update():Void {
		super.update();
	}	
}
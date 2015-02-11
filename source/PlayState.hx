package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.FlxObject;
import flixel.util.FlxColor;
import flixel.tile.FlxTilemap;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;
using flixel.util.FlxSpriteUtil;
import openfl.Assets;
import flixel.addons.effects.FlxTrail;
import flixel.effects.particles.FlxEmitterExt;

class PlayState extends FlxState {

	private var map:FlxTilemap;
	private var player:FlxSprite;
	private var score:FlxText;
	private var objects:FlxGroup;
	private var enemies:FlxTypedGroup<Enemy>;
	private var text:FlxText;
	private var scoreNumber:Int = 0;
	private var level:Int = 1;
	private var X:Array<Int> = [1,4,10,18,22,30,37,5,9,20,27,31,10,34,1,4,13,31,35,2,6,21,25,27,7,16,31,1,6,11,14,18,22,30,38];
	private var Y:Array<Int> = [1,1,2,3,3,1,3,5,5,6,5,5,8,9,12,21,14,13,13,17,17,16,16,16,21,22,25,28,28,28,28,28,28,28,28];
	private var randomNumber:Int;
	private var playerTrail:FlxTrail;
	private var enemyTrail2:FlxTrail;
	private var enemyTrail3:FlxTrail;
	private var enemyTrail4:FlxTrail;
	private var enemyTrail1:FlxTrail;
	private var part:FlxEmitterExt;
	private var delay:Int = 10000;

	override public function create():Void {

		FlxG.cameras.bgColor = 0xffacbcd7;
		FlxG.mouse.visible = false;
		super.create();

		//Player
		player = new FlxSprite(34 * 8, 25 * 8);
		player.makeGraphic(8, 8, 0xff2d0000);
		player.maxVelocity.set(60, 200);
		player.acceleration.y = 125;
		player.drag.x = player.maxVelocity.x * 2;
		player.antialiasing = true;
		playerTrail = new FlxTrail(player, "player", 25, 0, 0.15, 0.001);

		//Text
		text = new FlxText(0, 80, FlxG.width, "Collect all coins!");
		text.setFormat(null, 16, 0x778ea1, "center");
		add(text);

		//Score
		score = new FlxText(0, 96, FlxG.width, "0");
		score.setFormat(null, 20, 0x778ea1, "center");
		add(score);

		//Map
		map = new FlxTilemap();
		map.loadMap(Assets.getText("map"), "tiles", 8, 8, FlxTilemap.OFF);
		add(map);

		//Coins
		objects = new FlxGroup();
		randomNumber = Std.random(20);
		addCoin(X[randomNumber],Y[randomNumber]);
		add(objects);

		//Explosion
		part = new FlxEmitterExt();
		part.setRotation(0, 0);
		part.setMotion(0, 5, 0.2, 360, 200, 1.8);
		part.makeParticles("parts", 1200, 0, true, 0);
		part.setAlpha(1, 1, 0, 0);
		add(part);

		//Enemies
		enemies = new FlxTypedGroup<Enemy>();
		for(y in 0...4){
			for(x in 0...2){
				enemies.add(new Enemy(300 + x * 55, 25 + y * 60));
			}
		}

		enemyTrail1 = new FlxTrail(enemies.members[4], "enemy", 20, 0, 0.2, 0.01);
		add(enemyTrail1);
		enemyTrail2 = new FlxTrail(enemies.members[0], "enemy", 20, 0, 0.2, 0.01);
		add(enemyTrail2);
		enemyTrail3 = new FlxTrail(enemies.members[6], "enemy", 20, 0, 0.2, 0.01);
		add(enemyTrail3);
		enemyTrail4 = new FlxTrail(enemies.members[2], "enemy", 20, 0, 0.2, 0.01);
		add(enemyTrail4);

		add(enemies);
		add(playerTrail);
		add(player);
	}
	
	override public function destroy():Void {
		super.destroy();
	}

	override public function update():Void {
		player.acceleration.x = 0;
		if(FlxG.keys.anyPressed(["LEFT","A"])){
			player.acceleration.x = -player.maxVelocity.x * 2;
		}
		if(FlxG.keys.anyPressed(["RIGHT","D"])){
			player.acceleration.x = player.maxVelocity.x * 2;
		}
		if(FlxG.keys.anyJustPressed(["SPACE","UP","W"])){
			player.velocity.y = -player.maxVelocity.y / 2;
		}
		if(player.y > FlxG.height){
			endGame();
		}

		super.update();
		updateCoins(level);
		FlxG.overlap(objects, player, getScore);
		FlxG.collide(map, player);
		FlxG.overlap(enemies, player, touchEnemy);
		
	}

	private function addCoin(X:Int, Y:Int):Void {
		var coin:FlxSprite = new FlxSprite(X * 8, Y * 8);
		coin.makeGraphic(8, 8, FlxColor.TRANSPARENT, true);
		coin.drawEllipse(0, 0, 7, 7, FlxColor.GOLDEN);
		objects.add(coin);
	}

	private function updateCoins(Level:Int):Void {
		if(objects.countLiving() == 0){
			var needToAdd:Int = 3 * Level;
			for(x in 0...needToAdd){
				randomNumber = Std.random(X.length);
				addCoin(X[randomNumber],Y[randomNumber]);
			} 
		}
	}

	private function getScore(Coin:FlxObject, Player:FlxObject):Void {
		Coin.kill();
		FlxG.sound.play("pickup");
		scoreNumber = scoreNumber + 1;
		score.text = "" + scoreNumber;
		if(objects.countLiving() == 0){
			level++;
		}
	}

	private function touchEnemy(Enemy:FlxObject, Player:FlxObject):Void {
		FlxG.sound.play("boom");
		startPart(Player.x, Player.y);
		Enemy.kill();
		var timer:haxe.Timer = new haxe.Timer(600);
		timer.run = function():Void{
		   endGame();
		   timer.stop();
		};
		
	}

	private function endGame():Void {
		Reg.score = scoreNumber;
		if(Reg.hScore < scoreNumber){
			Reg.hScore = scoreNumber;
		}
		FlxG.switchState(new EndState());
	}

	private function startPart(X:Float = 0, Y:Float = 0):Void {	
		if (part.visible) {
			part.x = X;
			part.y = Y;
			part.start(true, 2, 0, 400);
			part.update();
		}
	}
}
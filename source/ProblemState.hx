package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxTileFrames;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.text.FlxText;
import flixel.tile.FlxTileblock;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import openfl.Assets;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class ProblemState extends FlxState
{
	var blockB:Block;
	var blockA:Block;
	var spr:flixel.FlxSprite;
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		
		var arr = [[0, 1, 1, 1, 0, 1, 1, 1, 0, 1],
				   [1, 0, 1, 0, 1, 0, 1, 0, 1, 0],
				   [1, 1, 0, 1, 1, 1, 0, 1, 1, 1]];
		
		//There is apparently an extra pixel for every tile in the block
		blockB = new Block(1600, 352, 3, 47, 81);
		blockB.init(arr, AssetPaths.skew_left_c_export_1__png);
		add(blockB);
		
		blockA = new Block(0, 352, 3, 47, 81);
		blockA.init(arr, AssetPaths.skew_left_c_export_0__png);
		add(blockA);
		
		//Text does not appear!
		var label = new FlxText(10, 10, 1000, "Jittering / Tearing Problem - Press SPACE to start / stop movement - ESC to return to menu", 16);
		label.scrollFactor.set(0, 0);
		add(label);
		
		spr = new FlxSprite(128, 352);
		spr.makeGraphic(64, 128, FlxColor.GREEN);
		add(spr);
		
		FlxG.camera.follow(spr, null, null, 1);
		FlxG.camera.deadzone = new FlxRect(64, 360, 128, 120);
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		if (spr.x - 160 > blockA.bounds.x + blockA.bounds.width) {
			blockA.repositionX((blockB.bounds.x + blockB.bounds.width) - 47 * 3);
			
			remove(blockA);
			remove(blockB);
			add(blockA);
			add(blockB);
		}
		
		if (spr.x - 160 > blockB.bounds.x + blockB.bounds.width) {
			blockB.repositionX((blockA.bounds.x + blockA.bounds.width) - 47 * 3);
			
			remove(blockB);
			remove(blockA);
			add(blockB);
			add(blockA);
		}
		
		if (FlxG.keys.justPressed.SPACE) {
			if (spr.velocity.x == 0) {
				spr.velocity.x = 300;
			} else {
				spr.velocity.x = 0;
			}
		}
		
		if (FlxG.keys.justPressed.ESCAPE) {
			FlxG.switchState(new MenuState());
		}
	}
}

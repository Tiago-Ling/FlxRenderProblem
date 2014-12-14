package;

import flixel.addons.display.FlxBackdrop;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	var scaleModifier:Int;
	
	var spriteCam:FlxCamera;
	var textCam:FlxCamera;
	
	var canScroll:Bool;
	var canZoom:Bool;
	var spriteLabel:flixel.text.FlxText;
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		
		scaleModifier = 1;
		canScroll = true;
		canZoom = false;
		
		spriteCam = new FlxCamera(0, 0, 640, 480);
		FlxG.cameras.add(spriteCam);
		textCam = new FlxCamera(0, 0, 640, 480);
		textCam.bgColor = 0x0;
		FlxG.cameras.add(textCam);
		
		spriteCam.setScrollBounds(0, 640000, 0, 480);
		spriteCam.pixelPerfectRender = false;
		spriteCam.antialiasing = true;
		
		var bg:FlxBackdrop = new FlxBackdrop(AssetPaths.fuchsia_regular__png, 1, 1, true, false);
		bg.y = 150;
		bg.cameras = [spriteCam];
		add(bg);
		
		var bgLabel = new FlxText(0, 20, 640, 'First strip : FlxBackdrop | Second strip : FlxSprites', 12);
		bgLabel.alignment = FlxTextAlign.CENTER;
		bgLabel.scrollFactor.set(0, 0);
		bgLabel.cameras = [textCam];
		add(bgLabel);
		
		var label = new FlxText(0, 200, 640, '[X] - Toggle scroll\n [C] - Toggle zoom\n [SPACE] - Toggle between zoom level 1 and 2\n [E] - Toggle antialiasing\n [R] - Toggle pixelPerfectRender', 12);
		label.alignment = FlxTextAlign.CENTER;
		label.scrollFactor.set(0, 0);
		label.cameras = [textCam];
		add(label);
		
		spriteLabel = new FlxText(0, 440, 640, 'Antialiasing : true | pixelPerfectRendering : true | scroll : (x,y) | scale : 1', 12);
		spriteLabel.scrollFactor.set(0, 0);
		spriteLabel.cameras = [textCam];
		add(spriteLabel);
		
		for (i in 0...25) {
			var spr = new TestSprite(i * 32, 300);
			spr.cameras = [spriteCam];
			add(spr);
		}
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
		
		checkInput();
		
		if (canScroll)
			spriteCam.scroll.x += 100 * elapsed;
		
		if (canZoom) {
			if (spriteCam.zoom > 2) {
				scaleModifier = -1;
			} else if (spriteCam.zoom < 1) {
				scaleModifier = 1;
			}
			
			var amount = (1.5 * elapsed) * scaleModifier;
			spriteCam.zoom += amount;
		}
		
		spriteLabel.text = 'Antialiasing : ${spriteCam.antialiasing} | PixelPerfectRendering : ${spriteCam.pixelPerfectRender} | Scroll X : ${spriteCam.scroll.x}\nZoom : ${spriteCam.zoom}';
	}
	
	function checkInput() 
	{
		if (FlxG.keys.justPressed.X) {
			canScroll = !canScroll;
		}
		
		if (FlxG.keys.justPressed.C) {
			canZoom = !canZoom;
		}
		
		if (FlxG.keys.justPressed.SPACE) {
			if (spriteCam.zoom > 1) {
				spriteCam.zoom = 1;
			} else {
				spriteCam.zoom = 2;
			}
		}
		
		if (FlxG.keys.justPressed.E) {
			spriteCam.antialiasing = !spriteCam.antialiasing;
		}
		
		if (FlxG.keys.justPressed.R) {
			spriteCam.pixelPerfectRender = !spriteCam.pixelPerfectRender;
		}
	}
}
package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author Tiago Ling Alexandre
 */
class TestSprite extends FlxSprite
{
	var scaleModifier:Int;
	
	public function new(X:Float = 0, Y:Float = 0, ?SimpleGraphic:FlxGraphicAsset)
	{
		super(X, Y);
		
		init();
	}
	
	function init() 
	{
		scaleModifier = 1;
		
		loadGraphic(AssetPaths.fuchsia_regular__png);
	}
	
	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		
		if (!this.isOnScreen(this.camera)) {
			x += FlxG.width + width;
		}
	}
}
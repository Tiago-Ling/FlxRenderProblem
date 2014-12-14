package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxTileFrames;
import flixel.tile.FlxTileblock;
import flixel.util.FlxSpriteUtil;

/**
 * ...
 * @author Tiago Ling Alexandre
 */
class OffsetLane extends FlxTileblock
{
	public var tileOffsetX:Float;
	
	public function new(X:Int, Y:Int, tOffsetX:Float) 
	{
		super(X, Y, 1, 1);
		
		tileOffsetX = tOffsetX;
	}
	
	public function loadLane(tileFrames:FlxTileFrames, map:Array<Int>):OffsetLane
	{
		if (tileFrames == null)
		{
			return this;
		}
		
		// First create a tile brush
		tileSprite = (tileSprite == null) ? new FlxSprite() : tileSprite;
		tileSprite.frames = tileFrames;
		var spriteWidth:Int = Std.int(tileSprite.width);
		var spriteHeight:Int = Std.int(tileSprite.height);
		
		var widthInTiles:Int = map.length;
		
		// Then prep the "canvas" as it were (just doublechecking that the size is on tile boundaries)
		var regen:Bool = false;
		
		if (width % tileSprite.width != 0)
		{
			//The last term "+ Math.abs(tileOffsetX)" is used because the offset is just for positioning, when calculating width we must add the entire last column width to the lane
			width = (widthInTiles * spriteWidth) + (widthInTiles * tileOffsetX) + Math.abs(tileOffsetX);
			regen = true;
		}
		
		if (height % tileSprite.height != 0)
		{
			height = Std.int(spriteHeight);
			regen = true;
		}
		
		if (regen)
		{
			makeGraphic(Std.int(width), Std.int(height), 0, true);
		}
		else
		{
			FlxSpriteUtil.fill(this, 0);
		}
		
		// Stamp random tiles onto the canvas
		var destinationX:Int = 0;
		var destinationY:Int = 0;
		
		var column:Int = widthInTiles - 1;
		while (column > -1)
		{
			destinationX = Std.int((column * spriteWidth) + (column * tileOffsetX));
			destinationY = 0;
			
			tileSprite.animation.frameIndex = map[column];
			tileSprite.drawFrame();
			stamp(tileSprite, destinationX, destinationY);
			
			column--;
		}
		
		frame.destroyBitmaps();
		dirty = true;
		return this;
	}
	
}
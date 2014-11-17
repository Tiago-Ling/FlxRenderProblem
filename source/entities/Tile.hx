package entities;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author Tiago Ling Alexandre
 */
class Tile extends FlxSprite
{
	//Stores a reference to which lane the tile belongs
	public var lane:Int;
	
	//this.ID property is used to store the tile type.
	
	public function new(X:Float = 0, Y:Float = 0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		
	}
	
}
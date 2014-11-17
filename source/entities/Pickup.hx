package entities;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author Tiago Ling Alexandre
 */
class Pickup extends FlxSprite implements IObject
{
	//Stores a reference to which lane the tile belongs
	public var lane:Int;
	public var laneGroup:Array<FlxGroup>;
	public var type:Int;
	var player:FlxSprite;
	
	public function new(player:FlxSprite, X:Float = 0, Y:Float = 0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		
		this.player = player;
		//Pickup id
		this.ID = type = 1;
		
		init();
	}
	
	function init() {
		makeGraphic(48, 48, 0xFFFFAF13);
/*		if (FlxG.random.bool(50))
			loadGraphic("img/obstacle_barrel_0.png", false);
		else
			loadGraphic("img/obstacle_barrel_1.png", false);*/
			
		kill();
	}
	
	public function clearFromLane()
	{
		kill();
		laneGroup[lane].remove(this);
	}
	
	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		
		if (player.x - this.x >= 1280) {
			trace("I'm too far away from the player - i'm gonna kill myself!");
			clearFromLane();
		}
	}
	
}
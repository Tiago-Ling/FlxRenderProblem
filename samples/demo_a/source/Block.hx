package;
import flixel.FlxState;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxTileFrames;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import openfl.Assets;
import openfl.geom.Rectangle;

/**
 * ...
 * @author Tiago Ling Alexandre
 */
class Block extends FlxGroup
{
	public var numLanes:Int;
	public var lanes:Array<OffsetLane>;
	public var pos:FlxPoint;
	public var laneOffset:FlxPoint;
	
	public var laneGroups:Array<FlxGroup>;
	
	public var bounds:Rectangle;
	
	public function new(x:Float, y:Float, numLanes:Int, laneOffsetX:Float, laneOffsetY:Float) 
	{
		super(Std.int(numLanes * 2));
		
		pos = FlxPoint.get(x, y);
		this.numLanes = numLanes;
		laneOffset = FlxPoint.get(laneOffsetX, laneOffsetY);
		bounds = new Rectangle(0, 0, 0, 0);
	}
	
	public function init(map:Array<Array<Int>>, gfxPath:String) 
	{
		lanes = new Array<OffsetLane>();
		laneGroups = new Array<FlxGroup>();
		for (i in 0...numLanes) {
			var group = new FlxGroup();
			var lane = new OffsetLane(Std.int(pos.x + (laneOffset.x * i)), Std.int(pos.y + (laneOffset.y * i)), -47);
			var bd = Assets.getBitmapData(gfxPath);
			var gfx = FlxGraphic.fromBitmapData(bd);
			lane.loadLane(FlxTileFrames.fromGraphic(gfx, FlxPoint.weak(208, 264)), map[i]);
			lanes.push(lane);
			add(lane);
			laneGroups.push(group);
			add(group);
			
			if (i == 0) {
				bounds.x = lane.x;
				bounds.y = lane.y;
			} else if (i == numLanes - 1) {
				bounds.width = lane.width + (lanes[i].x - lanes[0].x);
				//height = ((heightInTiles * spriteHeight) + ((heightInTiles - 1) * tileOffset.y));
				bounds.height = (i * lane.height) + ((i - 1) * -183) + laneOffset.y;
			}
		}
		
		trace("Block rect : " + bounds.toString());
	}
	
	public function repositionX(newX:Float) {
		for (i in 0...lanes.length) {
			lanes[i].x = newX + (laneOffset.x * i);
		}
		
		bounds.x = newX;
	}
}
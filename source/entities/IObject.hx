package entities;
import flixel.group.FlxGroup;

/**
 * @author Tiago Ling Alexandre
 */

interface IObject 
{
	public var lane:Int;
	public var laneGroup:Array<FlxGroup>;
	public var type:Int;
	
	public function clearFromLane():Void;
}
package entities;
import flixel.FlxG;
import flixel.addons.editors.spine.FlxSpine;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import spinehaxe.SkeletonData;

/**
 * ...
 * @author Kris
 */
class Player extends FlxSpine
{
	public var isDead:Bool;
	var colliderOffset:FlxPoint;
	
	public function new(skeletonData:SkeletonData,  X:Float = 0, Y:Float = 0, W:Int = 0, H:Int = 0) 
	{
		super(skeletonData, X, Y, W, H, -32, 0);
		
		isDead = false;
		
		#if debug
		collider.debugBoundingBoxColor = 0xAA009900;
		#end
		collider.allowCollisions = FlxObject.ANY;
		
		stateData.setMixByName("walk", "jump", 0.2);
		stateData.setMixByName("jump", "walk", 0.4);
		stateData.setMixByName("jump", "jump", 0.2);
		
		state.setAnimationByName(0, "walk", true);
		
		for (track in state.tracks) {
			trace(track.toString());
		}
	}
	
	public function setColliderPos(x:Float, y:Float)
	{
		collider.x = x;
		collider.y = y;
		
		this.x = x + colliderOffset.x;
		this.y = y + colliderOffset.y;
	}
	
	override public function update(elapsed:Float):Void
	{
/*		var anim = state.getCurrent(0);
		
		if (anim.toString() == "walk") 
		{
			// After one second, change the current animation. Mixing is done by AnimationState for you.
			if (anim.time > 2) 
				state.setAnimationByName(0, "jump", false);
		} 
		else 
		{
			if (anim.time > 1) 
				state.setAnimationByName(0, "walk", true);
		}
		
		if (FlxG.mouse.justPressed)
		{
			state.setAnimationByName(0, "jump", false);
		}*/
		
		super.update(elapsed);
		
		//this.x = collider.x + colliderOffset.x;
		//this.y = collider.y + colliderOffset.y;
	}
}
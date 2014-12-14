package;

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
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		
		//Text simply won't appear!
		var label = new FlxText(10, 300, 1260, "Press 1 to load state with image tearing and jittering problem\nPress 2 to load state with image tearing only", 16, false);
		label.alignment = FlxTextAlign.CENTER;
		add(label);
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
		
		if (FlxG.keys.justPressed.ONE) {
			FlxG.switchState(new ProblemState());
		}
		
		if (FlxG.keys.justPressed.TWO) {
			FlxG.switchState(new NonProblemState());
		}
	}
}
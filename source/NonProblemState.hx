package ;
import entities.Tile;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import openfl.Assets;

/**
 * ...
 * @author Tiago Ling Alexandre
 */
class NonProblemState extends FlxState
{
	static inline var LANE_W:Int = 1600; //Actual tile size without counting hidden parts (160) x Number of tiles per lane (10) (19 - arbitrary offset)
	static inline var LANE_H:Int = 80;
	static inline var TILES_PER_LANE:Int = 9; //Indexes, counting 0, so 10 tiles total
	static inline var TOTAL_LANES:Int = 3;
	static inline var TILE_OFFSET:Int = 47;
	static inline var TILE_AABB_OFFSET_Y:Int = 48;
	static inline var SKEWED_GROUP_OFFSET:Float = 47;
	static inline var BOUNDING_BOX_OFFSET:Int = 47;
	static inline var LANE_A_POS:Float = 352;
	static inline var LANE_B_POS:Float = 432;
	static inline var LANE_C_POS:Float = 512;
	static inline var PL_POS_X:Float = 128;
	static inline var PL_LANE_Y_OFFSET:Float = 88;
	
	//Groups containing each tile block (one block equals one group of tiles) - used for moving everything inside the block together
	var groupA:FlxSpriteGroup;
	var groupB:FlxSpriteGroup;
	var player:FlxSprite;
	var lanePos:Array<Float>;
	var curLane:Int;
	var plPosLabel:flixel.text.FlxText;
	
	var bgLayer:flixel.group.FlxGroup;
	var groundLayer:flixel.group.FlxGroup;
	var overLayer:flixel.group.FlxGroup;
	var groupALanes:Array<FlxSpriteGroup>;
	var groupBLanes:Array<FlxSpriteGroup>;
	var groups:Array<Array<FlxSpriteGroup>>;
	var laneLayers:Array<FlxGroup>;
	
	override public function create()
	{
		super.create();
		
		FlxG.log.redirectTraces = false;
		curLane = 0;
		
		FlxG.autoPause = false;
		
		bgLayer = new FlxGroup();
		add(bgLayer);
		
		laneLayers = new Array<FlxGroup>();
		laneLayers.push(new FlxGroup());
		laneLayers.push(new FlxGroup());
		laneLayers.push(new FlxGroup());
		
		groundLayer = new FlxGroup();
		groundLayer.add(laneLayers[0]);
		groundLayer.add(laneLayers[1]);
		groundLayer.add(laneLayers[2]);
		
		add(groundLayer);
		
		overLayer = new FlxGroup();
		add(overLayer);
		
		lanePos = [LANE_A_POS, LANE_B_POS, LANE_C_POS];
		
		groups = new Array<Array<FlxSpriteGroup>>();
		groupALanes = new Array<FlxSpriteGroup>();
		groupALanes.push(new FlxSpriteGroup(0 - SKEWED_GROUP_OFFSET, 0, 10));
		groupALanes.push(new FlxSpriteGroup(0 - SKEWED_GROUP_OFFSET, 0, 10));
		groupALanes.push(new FlxSpriteGroup(0 - SKEWED_GROUP_OFFSET, 0, 10));
		
		groups.push(groupALanes);
		groupBLanes = new Array<FlxSpriteGroup>();
		groupBLanes.push(new FlxSpriteGroup(LANE_W - SKEWED_GROUP_OFFSET, 0, 10));
		groupBLanes.push(new FlxSpriteGroup(LANE_W - SKEWED_GROUP_OFFSET, 0, 10));
		groupBLanes.push(new FlxSpriteGroup(LANE_W - SKEWED_GROUP_OFFSET, 0, 10));
		
		groups.push(groupBLanes);
		
		player = new FlxSprite(PL_POS_X, LANE_A_POS - PL_LANE_Y_OFFSET);
		player.makeGraphic(64, 128, FlxColor.YELLOW);
		
		laneLayers[0].add(groupBLanes[0]);
		laneLayers[1].add(groupBLanes[1]);
		laneLayers[2].add(groupBLanes[2]);
		
		laneLayers[0].add(groupALanes[0]);
		laneLayers[1].add(groupALanes[1]);
		laneLayers[2].add(groupALanes[2]);
		
		//Init Tiles Here (initial position and animations)
		initTiles(groupB, 1);
		initTiles(groupA, 0);
		
		//Set tile type and elevation here
		setTileType(1);
		setTileType(0);
		
		//Adding player after adding tiles
		laneLayers[curLane].add(player);
		laneLayers[curLane].add(player);
		
		FlxG.camera.follow(player, null, null, 1);
		FlxG.camera.deadzone = new FlxRect(64, 360, 128, 120);
		
		FlxG.camera.minScrollY = -200;
		FlxG.camera.maxScrollY = 720;
		
		//Text does not appear 
		plPosLabel = new FlxText(10, 10, 1000, "Jittering Problem only - Press SPACE to start / stop movement - ESC to return to menu", 16);
		plPosLabel.scrollFactor.set(0, 0);
		overLayer.add(plPosLabel);
	}
	
	function initTiles(group:FlxSpriteGroup, blockId:Int = 0)
	{
		for (i in 0...TOTAL_LANES) {
			var count = TILES_PER_LANE;
			while (count > -1) {
				var tile = new Tile(count * (208 - TILE_OFFSET) + (i * TILE_OFFSET), LANE_A_POS + i * LANE_H);
				var tId = blockId == 0 ? 0 : 1;
				
				// ### Crazy Flixel behavior ###
				//var imageHeight = 273;	//Actual image size
				var imageHeight = 272;		//Reducing image height in 1px seems to solve the image tearing problem
				
				tile.loadGraphic(Assets.getBitmapData("img/skew_left_c_export_" + tId + ".png"), true, 208, imageHeight);
				
				tile.animation.add("blank", [0], 0);
				tile.animation.add("normal", [1], 0);
				tile.animation.play("blank");
				tile.immovable = true;
				tile.lane = i;
				
				groups[blockId][i].add(tile);
				
				tile.width = 160;
				tile.height = 2;
				tile.offset.set(23.5, TILE_AABB_OFFSET_Y);
				tile.y += TILE_AABB_OFFSET_Y; //Compensating for the offset
				
				count--;
			}
		}
	}
	
	function setTileType(group:Int)
	{
		var arr = [[0, 1, 1, 1, 0, 1, 1, 1, 0, 1],
				   [1, 0, 1, 0, 1, 0, 1, 0, 1, 0],
				   [1, 1, 0, 1, 1, 1, 0, 1, 1, 1]];
		
		for (i in 0...groups[group].length) {
			for (j in 0...groups[group][i].members.length) {
				var tile = cast(groups[group][i].members[j], Tile);
				
				switch (arr[i][j]) {
					case 0: //Holes
						tile.animation.play("blank");
						tile.ID = 0;
						tile.solid = false;
						tile.allowCollisions = FlxObject.NONE;
					case 1: //Normal, walkable tiles
						tile.animation.play("normal");
						tile.ID = 1;
						tile.allowCollisions = FlxObject.UP;
				}
			}
		}
	}
	
	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		
		checkGround();
		
		if (FlxG.keys.justPressed.SPACE) {
			if (player.velocity.x == 0) {
				player.velocity.x = 300;
			} else {
				player.velocity.x = 0;
			}
		}
		
		if (FlxG.keys.justPressed.ESCAPE) {
			FlxG.switchState(new MenuState());
		}
	}
	
	function checkGround()
	{
		if (player.x - (PL_POS_X / 2) > (groups[0][0].x + groups[0][0].width + SKEWED_GROUP_OFFSET * 2.25)) {
			
			groups[0][0].x = groups[1][0].x + (groups[1][0].width - SKEWED_GROUP_OFFSET) + BOUNDING_BOX_OFFSET;
			groups[0][1].x = groups[1][1].x + (groups[1][1].width - SKEWED_GROUP_OFFSET) + BOUNDING_BOX_OFFSET;
			groups[0][2].x = groups[1][2].x + (groups[1][2].width - SKEWED_GROUP_OFFSET) + BOUNDING_BOX_OFFSET;
			
			//Group B must be over group A
			laneLayers[0].remove(groups[0][0]);
			laneLayers[1].remove(groups[0][1]);
			laneLayers[2].remove(groups[0][2]);
			laneLayers[0].remove(groups[1][0]);
			laneLayers[1].remove(groups[1][1]);
			laneLayers[2].remove(groups[1][2]);
			
			laneLayers[0].add(groups[0][0]);
			laneLayers[1].add(groups[0][1]);
			laneLayers[2].add(groups[0][2]);
			laneLayers[0].add(groups[1][0]);
			laneLayers[1].add(groups[1][1]);
			laneLayers[2].add(groups[1][2]);
		}
		
		if (player.x - (PL_POS_X / 2) > (groups[1][0].x + groups[1][0].width + SKEWED_GROUP_OFFSET * 2.25)) {
			
			groups[1][0].x = groups[0][0].x + (groups[0][0].width - SKEWED_GROUP_OFFSET) + BOUNDING_BOX_OFFSET;
			groups[1][1].x = groups[0][1].x + (groups[0][1].width - SKEWED_GROUP_OFFSET) + BOUNDING_BOX_OFFSET;
			groups[1][2].x = groups[0][2].x + (groups[0][2].width - SKEWED_GROUP_OFFSET) + BOUNDING_BOX_OFFSET;
			
			//Group A must be over group B
			laneLayers[0].remove(groups[1][0]);
			laneLayers[1].remove(groups[1][1]);
			laneLayers[2].remove(groups[1][2]);
			laneLayers[0].remove(groups[0][0]);
			laneLayers[1].remove(groups[0][1]);
			laneLayers[2].remove(groups[0][2]);
			
			laneLayers[0].add(groups[1][0]);
			laneLayers[1].add(groups[1][1]);
			laneLayers[2].add(groups[1][2]);
			laneLayers[0].add(groups[0][0]);
			laneLayers[1].add(groups[0][1]);
			laneLayers[2].add(groups[0][2]);
		}
	}
	
	override public function destroy()
	{
		super.destroy();
		
		remove(bgLayer);
		remove(groundLayer);
		remove(overLayer);
		
		groupA = null;
		groupB = null;
		player = null;
		lanePos = null;
		plPosLabel = null;
		bgLayer = null;
		groundLayer = null;
		overLayer = null;
	
		groupALanes = null;
		groupBLanes = null;
		groups = null;
		laneLayers = null;
	}
	
}
FlixelRenderProblemDemo
=======================

Small demo to show render tearing, jittering and artifacts in cpp targets. Although i'm analyzing this problem using HaxeFlixel, it might be caused by OpenFL or Lime since HF is built on top of them. 

HaxeFlixel issues that might be related to this:
* [Issue #911 - Serious floating-point artifacts on CPP FlxTilemap & FlxSprite](https://github.com/HaxeFlixel/flixel/issues/911)
* [Issue #1022 - Position jittering due to floating imprecision](https://github.com/HaxeFlixel/flixel/issues/1022)
* [Issue #1271 - Jittering caused by sprite offsets](https://github.com/HaxeFlixel/flixel/issues/1271)

The following problems are described in this sample:

### Bitmap Tearing (running ProblemState.hx):
![Alt Text](https://github.com/Tiago-Ling/FlixelRenderProblemDemo/blob/master/images/bitmap_tearing.PNG)

* Bitmap tearing happens when using width and/or height values the renderer does not like:
```haxe
	//var imageHeight = 273;	//Actual image size
	var imageHeight = 272;		//Reducing image height in 1px seems to solve the image tearing problem
```

* The tearing is completely solved by setting the `smooth` property as <b>true</b> in `FlxCamera.render()`, line <b>420</b>:
```haxe
//Original line
//currItem.graphics.tilesheet.drawTiles(canvas.graphics, data, (antialiasing || currItem.antialiasing), tempFlags, position);
//Hardcoding 'smooth' as true solves the tearing
currItem.graphics.tilesheet.drawTiles(canvas.graphics, data, true, tempFlags, position);
```
This means that unless you set your sprites to use `antialiasing` as <b>true</b>, they may be distorted or have the tearing problem if their size is "not right". There have been cases like the above example when changing the size of the sprite by one pixel solves the problem, but there are also cases in which changing the size of the sprite does not work (by adding or subtracting one or more pixels from its size). This seems to be related to floating point issues, it's hard to verify because there is no "right size", different sprites with different sizes at different positions cause the problem.

### Jittering (running NonProblemState.hx):
![Alt Text](https://github.com/Tiago-Ling/FlixelRenderProblemDemo/blob/master/images/jittering.gif)

* What i mean by "jittering": when the camera is moving (by pressing space in one of the states in the sample), each consecutive frame seems to have ~1px of difference in position, "moving" the images to the left or right in the process. The perceived effect is seen as if the screen or the images in it are "shaking" horizontally;
* This problem is much harder to demonstrate since GIFs are lower in quality and frame rate - to better visualize it the best thing to do is compile and run the project;
* Jittering does happen in both states.
* I have tried different sets of config with `FlxG.fixedTimestep`, `FlxG.camera.pixelPerfectRender` and `vsync`, using the possible combinations of these values as <b>true</b> or <b>false</b> with no luck. If they affect this in some way, it could not be seen in this sample.

### Observations
The sample was created using a development version of FlashDevelop. Trying to open / run the sample in the latest release version of FlashDevelop won't work, to fix this you'll either have to:
* Get the latest development build of FlashDevelop: http://flashdevelop.org/downloads/builds/
* Create a new HaxeFlixel blank project (using the command line, type `flixel tpl -n "<project_name>"` in the folder you want to create it) and paste the folders `source` and `assets` from this repository there.

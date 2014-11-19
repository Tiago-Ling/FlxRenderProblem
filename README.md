FlixelRenderProblemDemo
=======================

Small demo to show render tearing, jittering and artifacts in cpp targets. Although i'm analyzing this problem using HaxeFlixel, it might be caused by OpenFL or Lime since HF is built on top of them. The following problems are described in this sample:

### Bitmap Tearing (running ProblemState.hx):
![Alt Text](https://github.com/Tiago-Ling/FlixelRenderProblemDemo/blob/master/assets/images/bitmap_tearing.PNG)

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

### Jittering
* What i mean by "jittering": when the camera is moving (by pressing space in one of the states in the sample), each consecutive frame seems to have ~1px of difference in position, "moving" the images to the left or right in the process. The perceived effect is seen as if the screen or the images in it are "shaking" horizontally;
* Jittering does happen in both states.
 

### Observations
The sample was created using a development version of FlashDevelop. Trying to open / run the sample in the latest release version of FlashDevelop won't work, to fix this you'll either have to:
* Get the latest development build of FlashDevelop: http://flashdevelop.org/downloads/builds/
* Create a new HaxeFlixel blank project (using the command line, type `flixel tpl -n "<project_name>"` in the folder you want to create it) and paste the folders `source` and `assets` from this repository there.

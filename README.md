FlixelRenderProblemDemo
=======================

Small demo to show render tearing, jittering and artifacts in cpp

### Problems

* Bitmap tearing happens when using width and/or height values the renderer does not like:
```haxe
	//var imageHeight = 273;	//Actual image size
	var imageHeight = 272;		//Reducing image height in 1px seems to solve the image tearing problem
```

* Jittering does happen in both states.
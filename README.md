FlxRenderProblem
================

Some demos showing render tearing, jittering and artifacts in cpp targets. These problems could be caused by HaxeFlixel, OpenFL, Lime or a combination of them - the investigation is a work in progress. 

HaxeFlixel issues that might be related to this:
* [Issue #911 - Serious floating-point artifacts on CPP FlxTilemap & FlxSprite](https://github.com/HaxeFlixel/flixel/issues/911)
* [Issue #1022 - Position jittering due to floating imprecision](https://github.com/HaxeFlixel/flixel/issues/1022)
* [Issue #1271 - Jittering caused by sprite offsets](https://github.com/HaxeFlixel/flixel/issues/1271)
* [Issue #1402 - Strange one pixel gap while camera zooming in non flash target](https://github.com/HaxeFlixel/flixel/issues/1402)

### Binaries
Zipped version of the most recent demo compiled for Windows in release mode. Just unzip it and run `FlxRenderProblem.exe`.

* [Demo B](https://github.com/Tiago-Ling/FlixelRenderProblemDemo/blob/master/binaries/demo_b.zip)

### Observations
* All demos created using development versions (from the dev branch in Github, where applicable) of flixel, flixel-addons, openfl and lime.
The sample was created using a development version of FlashDevelop. Trying to open / run the sample in the latest release version of FlashDevelop won't work, to fix this you'll either have to:
* Get the latest development build of FlashDevelop: http://flashdevelop.org/downloads/builds/
* Create a new HaxeFlixel blank project (using the command line, type `flixel tpl -n "<project_name>"` in the folder you want to create it) and paste the folders `source` and `assets` from this repository there.

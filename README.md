# NTRStack
Combine screenshots taken by 3DS NTR CFW using Windows Command Line and ImageMagick.

Requirements:
----
- Windows
 - Command Line
- [ImageMagick](http://imagemagick.org/script/binary-releases.php#windows)
 - `convert` must be in your path and accessible from Command Line. The installer does this by default.

How to:
----
1. Save or create a new [BAT file](https://raw.githubusercontent.com/RePod/NTRStack/master/ntr_stack.bat) in the desired working folder.
2. Place the screenshots in the same folder.
3. Modify the early lines containing `preset`, `orient`, `cleantemp`, and `cleansource` as needed.
 - Or not, the defaults are fine.
4. Run the BAT.
 - The first argument can be the preset name.


This could potentially support *hax 2.5 screenshots, the only difference is the naming scheme.

However, I'm lazy.

![](sample/HNI_0000.png)
![](sample/scr_0000.png)

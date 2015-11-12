# NTRStack
Preset-based converter for NTR and HANS screenshots.    
Combines screenshots taken by 3DS NTR CFW using Windows Command Line and ImageMagick.    
Also supports HANS/*hax 2.5+ screenshots, with side-by-side 3D options.

Utilizes a sort of "preset" system to config basic options to achieve results.    
Scroll down to see examples of default presets included.

Could potentially be made for Bash, given most of the work is done by ImageMagick.    
However, I'm lazy. I'll gladly accept pull requests that accomplish this.

Requirements:
----
####Windows
- Command Line
- [ImageMagick](http://imagemagick.org/script/binary-releases.php#windows)
 - `convert` must be in your path and accessible from Command Line. The installer does this by default.

####Everything else
- *Soon? But also with ImageMagick.*
- Possibly Wine.

How to:
----
1. Save or create a new [BAT file](https://raw.githubusercontent.com/RePod/NTRStack/master/ntr_stack.bat) in the desired working folder.
2. Place the screenshots in the same folder.
3. Go through and modify the options up until the "casuals beware" line.
 - Or not, the defaults are fine.
4. Run the BAT.
 - The first argument can be the preset name.

Default presets:
----
Click images to see a more detailed view of dimensions and transparency.    
Results may differ between NTR and HANS screenshots.

**native** *(pads similar to homemenu screenshots, padding white)*    
!["native" preset](sample/HNI_0000.png)

**default** *(stacks them normally, bottom padding transparent)*    
![](sample/scr_0000.png)

**wide** *(puts them side by side)*    
![](sample/wide_0000.png)

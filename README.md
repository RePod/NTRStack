# NTRStack
**June 5th, 2017:** *Most likely* supports Luma 8.0+ screenshots similar to NTR.

Preset-based converter for NTR and HANS screenshots.    
Combines NTR and HANS screenshots in various, configurable ways using ImageMagick.    
HANS has additional options for side-by-side 3D images.

Utilizes a sort of "preset" system to config basic options to achieve results.    
Scroll down to see examples of default presets included.

The code may not be the most optimized, but it works!

Requirements:
----
### Windows
 - [NTRStack for Windows](https://raw.githubusercontent.com/RePod/NTRStack/master/ntr_stack.bat)
 - [ImageMagick](http://imagemagick.org/script/binary-releases.php#windows)
   - `convert` must be in your path and accessible from Command Line. The installer does this by default.

### Everything else
- [NTRStack for everything else](https://raw.githubusercontent.com/RePod/NTRStack/master/ntr_stack.sh)
- ImageMagick
  - `convert` must be in your path and accessible from terminal.

How to:
----
1. Save or create a new (below) where you want: (*Right-click*, *Save link as...*)
   - [BAT](https://raw.githubusercontent.com/RePod/NTRStack/master/ntr_stack.bat) (Windows)
   - [SH](https://raw.githubusercontent.com/RePod/NTRStack/master/ntr_stack.sh) (*nix) 
2. Place the screenshots in the same folder.
4. Run NTRStack.
   - On Windows, double clicking the `.bat` is enough.
   - On *nix you may need to mark it as executable (`chmod +x ntr_stack.sh`) before using it.

**Tips**
 - The first argument can be the desired preset name, overriding the default.
 - The code can be edited to change various settings for different results.

Default presets:
----
Click images to see a more detailed view of dimensions and transparency.    
Results may differ between NTR and HANS screenshots.

**HANS** *(`top_screen=both`, `both_sbs=right`, `dupe_bot=yes`)*      
![HANS - Cross-eye side-by-side 3D](sample/sbs.png)

**NTR - native** *(pads similar to homemenu screenshots, padding white)*    
![NTR - "native" preset](sample/HNI_0000.png)

**NTR - default** *(stacks them normally, bottom padding transparent)*    
**HANS - default** *(single screen: `top_screen=left`)*    
![NTR/HANS - "default" preset](sample/scr_0000.png)

**NTR - wide** *(puts them side by side)*    
**HANS - wide** *(single screen: `top_screen=left`)*    
![NTR/HANS - "wide" preset](sample/wide_0000.png)

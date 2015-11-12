:: Intended to be used with 3DS NTR CFW's screenshot function, which spits out individual top and bottom screens.
:: Save this batch file as "whateveryouwanttocallit.bat" and place in the folder with your top_####.bmp and bot_####.bmp files.
:: Also supports HANS/*hax 2.5 screenshots in scr_#_*.png naming.

:: If run without specifying a preset (usually by double-clicking), it'll use the "native" preset, which replicates home menu screenshots.
:: Otherwise, the first argument should be the preset name.

:: Requires ImageMagick (latest preferred) to be installed and in your path ("convert" should be available from cmd).
:: Get it here: http://imagemagick.org/script/binary-releases.php#windows
:: The ImageMagick commands here aren't that bad, but definitely could be optimized with temporary image lists instead of working off temp files.

@echo off

:: It is highly recommended settings are kept lowercase.

:: Select the default preset to use when combining. Default: %~1
:: If empty or %~1 falls back to "default". Can pass preset name via command line otherwise.
:: Presets: default native custom wide
set preset=%~1
:: Orientation (if available), horizontal or vertical? Default: vertical
set orient=vertical
:: Automatically delete temporary files (bottom screen) when done? Default: yes
set cleantemp=yes
:: Automatically remove source files (original top/bottom screen) when done? Default: no
set cleansource=no

:: *hax HANS screenshot-specific options
:: Top screen preference, left/right/both. Default: left
set top_screen=left
:: If top_screen is "both", this is the screen on the left side. Default: right
:: Right would be cross-eye 3D, left would be parallel view.
set both_sbs=right
:: If top_screen is "both", duplicate the bottom screen for each eye for 3D viewing. Default: yes
set dupe_bot=yes


::
::
::    Casual users stop here, there is nothing more for you to do.
::
::





if "%preset%" equ "" set preset=default
echo Preset: %preset%
:: These are the default settings which are then overwritten by the presets specified after them.
:: Output prefix of combined images (prefix####.png). Default: scr_
set prefix=scr_
:: Background color to use when resizing the bottom screen. Default: rgba(0,0,0,0) (transparent).
set color=rgba(0,0,0,0)
:: Insert artificial padding to simulate home menu screenshots.
set padding=no
:: Gravity and Extent are useful for aligning the image, you probably shouldn't touch these.
:: A good example of their usage is the "native" preset.
:: http://www.imagemagick.org/script/command-line-options.php#gravity
set top_gravity=center
set bot_gravity=center
:: http://www.imagemagick.org/script/command-line-options.php#extent
set top_extent=400x240
set bot_extent=400x240

goto :%preset%

:: Presets
:default
    :: Do nothing.
    goto :post_preset
:custom
    set prefix=custom_
    set color=black
    set orient=vertical
    :: Do not process other presets.
    goto :post_preset
:wide
    :: Simple preset that combines them horizontally.
    set prefix=wide_
    set orient=horizontal
    goto :post_preset
:native
    :: Replicates home menu screenshots.
    set prefix=HNI_
    set color=white
    set orient=vertical
    set padding=yes
    set top_gravity=center
    set bot_gravity=north
    set top_extent=432x272
    set bot_extent=432x256
    goto :post_preset

:post_preset
:: Search for all files matching the pattern "bot_*.bmp" then pass them to the converter function.
for %%x in (scr_*_BOTTOM.png) do call :hans_converter %%x
for %%x in (bot_*.bmp) do call :ntr_converter %%x

:: Prevent the file from running the converter function below manually by skipping it.
goto :eof

:hans_converter
    :: Strip out the numeric to pair with the top screen.
    set bottom=%1
    set temp=%bottom%
    :: Remove scr_ and _BOTTOM.png
    set temp=%temp:~4,-11%
    set left=scr_%temp%_TOP_LEFT.png
    set right=scr_%temp%_TOP_RIGHT.png
    set top=temp_top_%temp%.png
    set ops=-gravity center -background %color%

    :: Select the correct or combine the two top screens.
    :: The If block we didn't know we needed. Surely this can be optimized.
    if "%top_screen%" == "both" set scro=%left% %right%
    if "%top_screen%" == "both" if "%both_sbs%" == "right" (set scro=%right% %left%)
    if "%top_screen%" == "both" convert %scro% +append %top%
    if "%top_screen%" == "left" convert %left% %top%
    if "%top_screen%" == "right" convert %right% %top%


    :: If using both screens and duping bottom, do so.
    set dupe=%bottom%
    if "%top_screen%" == "both" if "%dupe_bot%" == "yes" set dupe=( -extent 400x240 %bottom% %bottom% +append )

    convert %ops% %top% %dupe% -append %prefix%%temp%.png

    if "%cleantemp%" == "yes" del %top%
    if "%cleansource%" == "yes" del %bottom% & del %left% & del %right%

    echo Done: %prefix%%temp%.png
    goto :eof

:ntr_converter
    set bottom=%1
    set bottom2=%bottom%
    set temp=%bottom:~4,-4%
    set top=top_%temp%.bmp
    set top2=%top%
    set ops=-resize 400x240 -background %color% -gravity

    :: Transform the top and bottom screens as needed.
    if "%padding%" == "yes" set top=( %ops% %top_gravity% -extent %top_extent% %top% )
    if "%orient%" == "vertical" set bottom=( %ops% %bot_gravity% -extent %bot_extent% %bottom% )

    :: Determine orientation.
    set switch=-
    if "%orient%" == "horizontal" set switch=+

    :: Combine and clean up.
    convert %top% %bottom% %switch%append %prefix%%temp%.png
    if "%cleansource%" == "yes" del %bottom2% & del %top2%

    echo Done: %prefix%%temp%.png

:eof
echo Complete!
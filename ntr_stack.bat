:: Intended to be used with 3DS NTR CFW's screenshot function, which spits out individual top and bottom screens.
:: Save this batch file as "whateveryouwanttocallit.bat" and place in the folder with your top_####.bmp and bot_####.bmp files.

:: If run without specifying a preset (usually by double-clicking), it'll use the "native" preset, which replicates home menu screenshots.
:: Otherwise, the first argument should be the preset name.

:: Requires ImageMagick (latest preferred) to be installed and in your path ("convert" should be available from cmd).
:: Get it here: http://imagemagick.org/script/binary-releases.php#windows

@echo off

:: Select the default preset to use when combining. Default: %~1
:: If empty or %~1 falls back to "native". Can pass preset name via command line otherwise.
:: Presets: native default custom wide
set preset=%~1
:: Orientation (if available), horizontal or vertical? Default: vertical
set orient=vertical
:: Automatically delete temporary files (bottom screen) when done? Default: yes
set cleantemp=yes
:: Automatically remove source files (original top/bottom screen) when done? Default: no
set cleansource=no


::
::
::    Casual users stop here, there is nothing more for you to do.
::
::





if "%preset%" equ "" set preset=native
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
for %%x in (bot_*.bmp) do call :converter %%x

:: Prevent the file from running the converter function below manually by skipping it.
goto :eof

:converter
    :: Strip out the numeric to pair with the top screen.
    :: A lot of black magic happens here, don't question it.
    set temp=%1
    set temp=%temp:~4,4%
    set top=top_%temp%.bmp
    if "%padding%" == "yes" set top=temp_top_%temp%.png
    set command=-resize 400x240 -background %color% -compose Copy -gravity
    set command2=%bot_gravity% -extent %bot_extent%
    if "%padding%" == "yes" convert top_%temp%.bmp %command% %top_gravity% -extent %top_extent% %top%
    if "%padding%" == "yes" set command2=%bot_gravity% -extent %bot_extent%
    if "%orient%" == "vertical" set orient_expand=%command% %command2%

    convert %1 %orient_expand% temp_%~sn1.png

    :: Combine the top screen and bottom screen to a single file.
    set switch=-
    if "%orient%" == "horizontal" set switch=+
    convert %top% temp_%~sn1.png %switch%append %prefix%%temp%.png
    echo Done: %prefix%%temp%.png

    :: Delete the temporary and source files as needed, if enabled.
    if "%cleantemp%" == "yes" del temp_%~sn1.png & if "%padding%" == "yes" del %top%
    if "%cleansource%" == "yes" del %1 & del top_%temp%.bmp
:eof
echo Complete!
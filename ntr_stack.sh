#!/usr/bin/bash
# Caaz was here. 2015.
preset=$1;
orient="vertical"
cleansource="no"
top_screen="both"
both_sbs="right"
dupe_bot="yes"
# Fucking Casuals
[ "$preset" == "" ] && preset="default"
echo Preset: $preset
prefix="scr_"
color="rgba(0,0,0,0)"
padding="no"
top_gravity="center"
bot_gravity="center"
top_extent="400x240"
bot_extent="400x240"
default() {
  post_preset
}
custom() {
  prefix="custom_"
  color="black"
  orient="vertical"
  post_preset
}
wide() {
  prefix="wide_"
  orient="horizontal"
  post_preset
}
native() {
  prefix="HNI_"
  color="white"
  padding="yes"
  top_gravity="center"
  bot_gravity="north"
  top_extent="432x272"
  bot_extent="432x256"
  post_preset
}
post_preset() {
  for i in scr_*_BOTTOM.png; do
    hans_converter $i
  done
  for i in bot_*.bmp; do
    ntr_converter $i
  done
}
hans_converter() {
  bottom=$1
  temp=${bottom:4:-11}
  left="scr_${temp}_TOP_LEFT.png"
  right="scr_${temp}_TOP_RIGHT.png"
  ops="-gravity center -background $color"
  if [ "$top_screen" == "both" ]; then
    scro="$left $right"
    [ "$both_sbs" == "right" ] && scro="$right $left"
    top="( $scro +append )"
    [ "$dupe_bot" == "yes" ] && bottom="( -extent 400x240 $bottom $bottom +append )"
  elif [ "$top_screen" == "left" ]; then
    top="$left"
  elif [ "$top_screen" == "right" ]; then
    top="$right";
  fi
  convert $ops $top $bottom -append $prefix$temp.png
  echo Done: $prefix$temp.png
}
ntr_converter() {
  bottom=$1
  bottom2=$bottom
  temp=${bottom:4:-4}
  top=top_$temp.bmp
  top2=$top
  ops="-resize 400x240 -background $color -gravity"
  [ "$orient" == "vertical" ] && bottom="( $ops $bot_gravity -extent $bot_extent $bottom )"
  [ "$padding" == "yes" ] && top="( $ops $top_gravity -extent $top_extent $top )"
  switch="-"
  [ "$orient" == "horizontal" ] && switch="+"
  convert $top $bottom ${switch}append $prefix$temp.png
  echo Done: $prefix$temp.png
}
$preset
exit 0

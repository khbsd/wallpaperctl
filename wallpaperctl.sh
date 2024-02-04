# !/bin/sh
declare -i wallmod
declare -i value
declare -i new_wall
declare -i wallpaper_amount
declare -i safe_mod

# put folder path here:
folder=/home/ken/Pictures/gif_wallpapers/
wallpaper_folder=($folder*)
wallpaper_amount=${#wallpaper_folder[@]}
current_wallpaper="cur_wall.num"
wallmod=$1
safe_mod=2

# check for stored wallpaper index
if [ ! -f "$current_wallpaper" ]; then
    echo "no current wallpaper, starting from first image."
    value=0
else
    value=$(cat "$current_wallpaper")
    new_wall=$(($value + $wallmod))
fi

# overflow check for incrementing and decrementing by 1
while [ $safe_mod -gt 0 ]
do
    if [ $new_wall -gt $wallpaper_amount ]; then
        value=0
        new_wall=$(($value + $wallmod))
    fi   
    
    safe_mod=$(($safe_mod - 1))
done

# safety check in case $wallmod is still out of scope
if [ $new_wall -gt $wallpaper_amount ] || [$new_wall -lt $(($wallpaper_amount * -1))]; then
	new_wall=0

# write wallpaper index to storage file    
echo $new_wall > ./cur_wall.num
#echo ${new_wall}

# use swww to set new wallpaper
swww img ${wallpaper_folder[$new_wall]}



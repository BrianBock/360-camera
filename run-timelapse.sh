#! bin/sh

CURRENT_TIME=$(date +"%m-%d-%Y-%H-%M")
DIR="${1:-/home/pi/Time-Lapses/$CURRENT_TIME}" #Name for a folder with today's date and time. All pictures from the time-lapse will be saved here. 
INTERVAL=${2:-120} #Time between rounds (seconds)
index=1


echo "Creating $DIR"

mkdir "$DIR/" #Creates the folder with today's date and time as it's name. All pictures from the time-lapse will be saved here. 
mkdir "$DIR/tifs" #Creates a subfolder called tifs. All panorama tifs will be taken here after being stitched. 

echo "Starting timelapse"

while true; do
	start_time=$(date +%s)
	slug="round_$index" #Round Number
	echo "Starting round $index"

	CURRENT_DIR="$DIR/$slug"
	
	# TAKE PICS
	sudo python ./take-pictures.py "$CURRENT_DIR"

	# STITCH THE PHOTOS (DO DA MAGIC)
	bash ./stitch-pictures.sh "$slug" "$CURRENT_DIR"

	
	SCRIPT_DIR="$(pwd)"
	# MOVE TIFF TO TIFF FOLDER
	mv $slug.tif "$DIR/tifs/$slug.tif"

	#Clean up files
	rm "$SCRIPT_DIR/project.mk"
	rm "$SCRIPT_DIR/project.pto"
	find . -name '$SCRIPT_DIR/*.tiff' -delete

	end_time=$(date +%s)
	run_time=$(($end_time-$start_time)) #Calculate run time for that round
	echo "Completed Round $index in $run_time seconds"
	index=$((index + 1))

	DELAY=$(($INTERVAL-$run_time))
	echo "Starting next round in $DELAY seconds"
	sleep "$DELAY"
done
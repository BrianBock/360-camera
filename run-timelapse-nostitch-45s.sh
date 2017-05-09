#! bin/sh
source log.sh
CURRENT_TIME=$(date +"%m-%d-%Y-%H-%M")
DIR="${1:-/home/pi/Time-Lapses/$CURRENT_TIME}" #Name for a folder with today's date and time. All pictures from the time-lapse will be saved here. 
INTERVAL=${2:-30} #Time between rounds (seconds)
index=1


log "Creating $DIR"
echo "Creating $DIR"

mkdir "$DIR/" #Creates the folder with today's date and time as it's name. All pictures from the time-lapse will be saved here. 

log "Starting timelapse"
echo "Starting timelapse"

while true; do
	start_time=$(date +%s)
	slug="round_$index" #Round Number
	echo "Starting round $index"
	log "Starting round $index"

	CURRENT_DIR="$DIR/$slug"
	
	# TAKE PICS
	sudo python ./take-pictures.py "$CURRENT_DIR"

	end_time=$(date +%s)
	run_time=$(($end_time-$start_time)) #Calculate run time for that round
	echo "Completed Round $index in $run_time seconds"
	log "Completed Round $index in $run_time seconds"
	index=$((index + 1))

	DELAY=$(($INTERVAL-$run_time))
	echo "Starting next round in $DELAY seconds"
	log "Starting next round in $DELAY seconds"
	sleep "$DELAY"
done
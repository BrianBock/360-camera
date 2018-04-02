# README


## Setup
Download or clone the repo on your Raspberry Pi. We need Hugin and enblend to create the 360 pictures.

#### Install script (recommended)
Run `bash ./installer.sh` to grab these dependencies, create the proper folder structure, and move the scripts to the predefined location. `run-timelapse.sh`, `stitch-pictures.sh`, `take-pictures.py` and `template.pto` will be moved to `/home/pi/Documents/Time-Lapse Software`. All Time-lapses that you take will be saved in `/home/pi/Time-Lapses`. 


#### Manual installation
*Use this if  the installer does not work.*
Open your browser on the Pi and navigate to: [https://packages.debian.org/jessie/hugin-tools](https://packages.debian.org/jessie/hugin-tools). This page is the repository for Hugin tools in Debian. Scroll down to the bottom and choose armhf. Pick your region and favorite downloader. I used the ftp.us.debian.org/debian link without issue. When it finishes, launch the installer. Next run `sudo apt-get install enblend`

Create rename and move this repo to `/home/pi/Documents/Time-Lapse Software`. Finally create the needed folder `/home/pi/Time-Lapses` to store your timelapses.

## Pi Requirements

This program assumes you have [Arducam's camera splitter](arducam.com/multi-camera-adapter-module-raspberry-pi/) attached to your Pi with all 4 cameras connected. The number of cameras is scalable by changing the `take-pictures.py` file. Documentation on how to change number of cameras can be found at Arducam's website.

## How to use

On your computer, build a template in Hugin. This can be done the same way you'd make a panorama. When you have it perfect, save the project as template.pto and copy it to the Pi. The existing template.pto is a sample template I made, which you can use with the sample photos to get a feel for how this program works. 

To run a timelapse navigate to `/home/pi/Documents/Time-Lapse Software` and run the following.

```bash
bash ./run-timeplase.sh
```

The `run-timelapse.sh` script takes 2 optional parameters. The first if the directory in which to save the timeslapse. It defaults to `/home/pi/Time-Lapses`. The second is a [valid time to sleep](https://www.cyberciti.biz/faq/linux-unix-sleep-bash-scripting/) between each picture and stitching.

```bash
bash ./run-timelapse.sh "/home/Pictures/My-Timelapse" "5m"
```


## Deep dive

`run-timelapse.sh` creates a new folder inside /home/pi/Time-Lapses/ with the current date and time, kicks off `take-pictures.py` and 'stitch-pictures.py'. 

`take-pictures.py` iterates through each camera and takes a photo. It takes about 3 seconds per camera to take a picture. The command prompt window will update you with it's progress. Each photo is saved as capture_1.jpg, capture_2.jpg...capture_4.jpg in a `round_#` folder. `round` refers to how many photosets have been taken. The first round is `round_1`. 

Next `stitch-pictures.sh` runs. This uses Hugin's command line tools and the template you created to create a panorama. This produces panoramas very consistently. Any defects or tears present in the template will be propagated to any future panoramas, which is why it's so important to make the template as perfect as possible. With this setup, Hugin does NOT calculate control points to find the overlap in the images, which saves time and processing power, and means you don't need to worry about people moving between cameras' views or other issues that might cause stitching problems. On the other hand, Hugin is basically running blind. If your photos don't line up nicely, it won't care - you'll get a funky panorama. 

The stitching program creates a series of temporary tifs in the Software folder with the proper distortions. It uses these to create the final panorama tif for this photoset, named `round_#.tif`. This large image is then copied to the folder labeled "tifs" within `/home/pi/Time-Lapses/TIMESTAMP/` or the specified directory in `./run-timelapse.sh`. The temporary tifs are then auto-deleted. When the round is finished, the window will notify you of its completion and how long it took. On a Raspberry Pi 3, my preliminary tests averaged about 90 seconds/round.

You can run a time-lapse for however long you'd like. When you are finished, copy the tifs folder to your computer. Import them into Adobe [Premiere as frames](https://forums.creativecow.net/thread/3/980625) and export your time-lapse. Upload your video to Youtube and then it should be viewable with [Google Cardboard](https://support.google.com/youtube/answer/6239930?hl=en)



#### Learn more about this project at [http://ter.ps/360Camera](http://ter.ps/360Camera).

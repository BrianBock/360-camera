#! bin/sh

#This installer downloads and installs the components required to preform automated commandline stitching on a Raspberry Pi. 


#Download and install Hugin Command Line Tools
echo "Installing Hugin Command Line Tools"
wget -O /home/pi/Downloads/ "http://ftp.us.debian.org/debian/pool/main/h/hugin/hugin-tools_2014.0.0+dfsg-5_armhf.deb"
sudo dpkg -i /home/pi/Downloads/hugin-tools_2014.0.0+dfsg-5_armhf.deb 
sudo apt-get install -f
echo "Completed Hugin Tools install" #This doesn't actually check if the installation was successful, so it is possible for the install to fail but this message to still appear. 


#Download and install enblend
echo "Installing enblend"
sudo apt-get install enblend
echo "Completed enblend install"  #This doesn't actually check if the installation was successful, so it is possible for the install to fail but this message to still appear. 


#Create software directory
mkdir "/home/pi/Documents/Time-Lapse Software"

#Create photo directory
mkdir /home/pi/Time-Lapses


#Move files to correct location
mv run-timelapse.sh "/home/pi/Documents/Time-Lapse Software"
mv stitch-pictures.sh "/home/pi/Documents/Time-Lapse Software"
mv take-pictures.py "/home/pi/Documents/Time-Lapse Software"
mv template.pto "/home/pi/Documents/Time-Lapse Software"
#INCLUDE SAMPLE PHOTOS
# mv "sample photos" /home/pi/Documents/Time-Lapse Software/


echo "Install complete. Navigate to /home/pi/Documents/Time-Lapse Software and run 'bash run-timelapse.sh' to start taking a time-lapse."
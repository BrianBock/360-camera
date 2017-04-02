import RPi.GPIO as gp
import os
import sys

#Most of this comes from arducam.com/multi-camera-adapter-module-raspberry-pi/. This code assumes you have Arducam's Multiplexer attached to your Pi with all 4 cameras properly installed. 
#All of the gp lines are necessary to make the cameras work. Tamper with them at your own risk. 

gp.setmode(gp.BOARD)
gp.setwarnings(False)

    
gp.setup(7, gp.OUT)
gp.setup(11, gp.OUT)
gp.setup(12, gp.OUT)

gp.setup(15, gp.OUT)
gp.setup(16, gp.OUT)
gp.setup(21, gp.OUT)
gp.setup(22, gp.OUT)

gp.output(11, True)
gp.output(12, True)
gp.output(15, True)
gp.output(16, True)
gp.output(21, True)
gp.output(22, True)

def main():
    DIR=sys.argv[1]
    makeDirectory('%s' % DIR)
    
    #Turn on camera 1
    gp.output(7, False)
    gp.output(11, False)
    gp.output(12, True)
    capture(1,DIR)


    #Turn on camera 2
    gp.output(7, True)
    gp.output(11, False)
    gp.output(12, True)
    capture(2,DIR)

    #Turn on camera 3
    gp.output(7, False)
    gp.output(11, True)
    gp.output(12, False)
    capture(3,DIR)

    #Turn on camera 4
    gp.output(7, True)
    gp.output(11, True)
    gp.output(12, False)
    capture(4,DIR)

    # You need to turn off multiplexer 1 if you have more than 4 cameras and want to use the ones connected to multiplexer 2
    gp.output(11, True) #Turn off board 1
    gp.output(12, True) #Turn off board 1


    #Turn on camera 5
    # gp.output(7, False)
    # gp.output(15, False)
    # gp.output(16, True)
    # capture(5,DIR)
        
def makeDirectory(directory):
    if not os.path.exists(directory):
        os.makedirs(directory)
        
def capture(cam,DIR):
    print("Taking photo with camera %d" % cam)
    cmd = "raspistill -o %s/capture_%d.jpg" % (DIR,cam)
    os.system(cmd)

if __name__ == "__main__":
    main()

    gp.output(7, False)
    gp.output(11, False)
    gp.output(12, True)

import RPi.GPIO as gp
import os

gp.setwarnings(False)
gp.setmode(gp.BOARD)

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
	# Turn on camera 1
    gp.output(7, False)
    gp.output(11, False)
    gp.output(12, True)
    capture(1)

	# Turn on camera 2
    gp.output(7, True)
    gp.output(11, False)
    gp.output(12, True)
    capture(2)

	# Turn on camera 3
    gp.output(7, False)
    gp.output(11, True)
    gp.output(12, False)
    capture(3)

    # Turn on camera 4
    gp.output(7, True)
    gp.output(11, True)
    gp.output(12, False)
    capture(4)

def capture(cam):
    print("Taking photo with camera %d" % cam)
    cmd = "raspistill -o capture_%d.jpg" % cam
    os.system(cmd)

if __name__ == "__main__":
    main()

    gp.output(7, False)
    gp.output(11, False)
    gp.output(12, True)

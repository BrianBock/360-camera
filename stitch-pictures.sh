#! /bin/sh

#get the output file prefix
PREFIX="$1"
SOURCE="$2"


# get the fov
FOV=360
pto_gen --projection=1 --fov=$FOV -o "./project.pto" "$SOURCE/capture_1.jpg" "$SOURCE/capture_2.jpg" "$SOURCE/capture_3.jpg" "$SOURCE/capture_4.jpg" #Creates a Hugin project called project.pto, and imports the 4 images. 
pto_template --output="./project.pto" --template=./template.pto "./project.pto" #Matches project.pto to the template

pto2mk -o "./project.mk" -p $PREFIX "./project.pto" #Magic
make -f "./project.mk" all

# TODO: CLEAN UP TIFF FILES


#pto_lensstack -o project1.pto --new-lens i1 project.pto
#cpfind -o project.pto --multirow project.pto
#cpclean -o project.pto project.pto
# linefind -o project.pto project.pto
# pto_var -o project.pto --opt TrX,TrY,TrZ,r,Eev,Ra,Rb,Rc,Rd,Re,!TrX0,!TrY0,!TrZ0,!r0,!Eev0,!Ra1,!Rb1,!Rc1,!Rd1,!Re1 project.pto
#autooptimiser -n -o project.pto project.pto

#pano_modify  --projection=1 --fov=AUTO --center --canvas=AUTO --crop=AUTO -o project.pto project.pto

#!/bin/bash

if [ $# != 2 ]
then
	echo "$0 only takes 2 aguments"
	echo "Example:"
	echo "$0 1920 1080"
	exit
fi

re='^[0-9]+$'

if ! [[ $1 =~ $re ]]
then
	echo "$1 not a number"
	exit
fi

if ! [[ $2 =~ $re  ]]
then
	echo "$2 not a number"
	exit
fi

res=$(cvt $1 $2 | sed 1,1d | sed 's/Modeline //')
res1=$(echo $res | awk '{print $1;}')
screen=$(xrandr | sed 1,1d | head -n1 |awk '{print $1;}')

#echo $screen
#echo $res
#echo $res1

xrandr --newmode $res
xrandr --addmode $screen $res1
xrandr --output $screen --mode $res1

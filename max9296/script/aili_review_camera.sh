#!/bin/bash

#csi device path

csi_channle=$1
sensor_width=$2
sensor_hight=$3
channel_flag=$4

get_media_num() {
	find "$1" -maxdepth 1 -type d | while read dir; do
		#echo "dir:$dir"
		media_num=`echo $dir | grep -o 'media[0-9]\+' | sed 's/media//'`
		#echo "num $meida_num"
		if [ "$media_num" ];then
			echo "$media_num"
			break
		fi
	done
	#echo "$media_num"
}

#check param
if [ $# != 4 ]; then
	echo "input param not right count $#"
	exit 1
else
	echo "input device $1"
	echo "input cam width $2 hight $3 channle flag $4"
fi


if [ "$csi_channle" == "csi0" ]; then
	if [ "$channel_flag" == "1ch" ]; then
		run_gstream_csi0_1ch="gst-launch-1.0 v4l2src device=/dev/video8 ! 'video/x-raw,format=UYVY,width=${sensor_width},height=${sensor_hight},framerate=30/1' ! videoconvert ! videoscale ! video/x-raw,width=640,height=480 ! fpsdisplaysink video-sink=xvimagesink sync=false &"
		eval $run_gstream_csi0_1ch
	elif [ "$channel_flag" == "2ch" ]; then
		run_gstream_csi0_1ch="gst-launch-1.0 v4l2src device=/dev/video8 ! 'video/x-raw,format=UYVY,width=${sensor_width},height=${sensor_hight},framerate=30/1' ! videoconvert ! videoscale ! video/x-raw,width=640,height=480 ! fpsdisplaysink video-sink=xvimagesink sync=false &"
		eval $run_gstream_csi0_1ch
		run_gstream_csi0_2ch="gst-launch-1.0 v4l2src device=/dev/video10 ! 'video/x-raw,format=UYVY,width=${sensor_width},height=${sensor_hight},framerate=30/1' ! videoconvert ! videoscale ! video/x-raw,width=640,height=480 ! fpsdisplaysink video-sink=xvimagesink sync=false &"
		eval $run_gstream_csi0_2ch
	else
		echo "not support current channel $channel_flag"
		exit 1
	fi
elif [ "$csi_channle" == "csi1" ]; then
	if [ "$channel_flag" == "1ch" ]; then
		run_gstream_csi1_1ch="gst-launch-1.0 v4l2src device=/dev/video0 ! 'video/x-raw,format=UYVY,width=${sensor_width},height=${sensor_hight},framerate=30/1' ! videoconvert ! videoscale ! video/x-raw,width=640,height=480 ! fpsdisplaysink video-sink=xvimagesink sync=false &"
		eval $run_gstream_csi1_1ch
	elif [ "$channel_flag" == "2ch" ]; then
		run_gstream_csi1_1ch="gst-launch-1.0 v4l2src device=/dev/video0 ! 'video/x-raw,format=UYVY,width=${sensor_width},height=${sensor_hight},framerate=30/1' ! videoconvert ! videoscale ! video/x-raw,width=640,height=480 ! fpsdisplaysink video-sink=xvimagesink sync=false &"
		eval $run_gstream_csi1_1ch
		run_gstream_csi1_2ch="gst-launch-1.0 v4l2src device=/dev/video2 ! 'video/x-raw,format=UYVY,width=${sensor_width},height=${sensor_hight},framerate=30/1' ! videoconvert ! videoscale ! video/x-raw,width=640,height=480 ! fpsdisplaysink video-sink=xvimagesink sync=false &"
		eval $run_gstream_csi1_2ch
	else
		echo "not support current channel $channel_flag"
		exit 1
	fi
elif [ "$csi_channle" == "all" ]; then
	if [ "$channel_flag" == "1ch" ]; then
		run_gstream_csi0_1ch="gst-launch-1.0 v4l2src device=/dev/video8 ! 'video/x-raw,format=UYVY,width=${sensor_width},height=${sensor_hight},framerate=30/1' ! videoconvert ! videoscale ! video/x-raw,width=640,height=480 ! fpsdisplaysink video-sink=xvimagesink sync=false &"
		eval $run_gstream_csi0_1ch
		run_gstream_csi1_1ch="gst-launch-1.0 v4l2src device=/dev/video0 ! 'video/x-raw,format=UYVY,width=${sensor_width},height=${sensor_hight},framerate=30/1' ! videoconvert ! videoscale ! video/x-raw,width=640,height=480 ! fpsdisplaysink video-sink=xvimagesink sync=false &"
		eval $run_gstream_csi1_1ch
	elif [ "$channel_flag" == "2ch" ]; then
		run_gstream_csi0_1ch="gst-launch-1.0 v4l2src device=/dev/video8 ! 'video/x-raw,format=UYVY,width=${sensor_width},height=${sensor_hight},framerate=30/1' ! videoconvert ! videoscale ! video/x-raw,width=640,height=480 ! fpsdisplaysink video-sink=xvimagesink sync=false &"
		eval $run_gstream_csi0_1ch
		run_gstream_csi0_2ch="gst-launch-1.0 v4l2src device=/dev/video10 ! 'video/x-raw,format=UYVY,width=${sensor_width},height=${sensor_hight},framerate=30/1' ! videoconvert ! videoscale ! video/x-raw,width=640,height=480 ! fpsdisplaysink video-sink=xvimagesink sync=false &"
		eval $run_gstream_csi0_2ch
		run_gstream_csi1_1ch="gst-launch-1.0 v4l2src device=/dev/video0 ! 'video/x-raw,format=UYVY,width=${sensor_width},height=${sensor_hight},framerate=30/1' ! videoconvert ! videoscale ! video/x-raw,width=640,height=480 ! fpsdisplaysink video-sink=xvimagesink sync=false &"
		eval $run_gstream_csi1_1ch
		run_gstream_csi1_2ch="gst-launch-1.0 v4l2src device=/dev/video2 ! 'video/x-raw,format=UYVY,width=${sensor_width},height=${sensor_hight},framerate=30/1' ! videoconvert ! videoscale ! video/x-raw,width=640,height=480 ! fpsdisplaysink video-sink=xvimagesink sync=false &"
		eval $run_gstream_csi1_2ch
	else
		echo "not support current channel $channel_flag"
		exit 1
	fi

else
	echo "not suppot current deivce $1"

fi


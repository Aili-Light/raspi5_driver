#!/bin/bash

#csi device path
csi0_device_path="/sys/devices/platform/axi/1000120000.pcie/1f00110000.csi"
csi1_device_path="/sys/devices/platform/axi/1000120000.pcie/1f00128000.csi"

csi_channle=$1
csi0_i2c_num="6"
csi1_i2c_num="4"
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

#set ctl node param
if [ "$csi_channle" == "csi0" ]; then
	csi0_media_num=$(get_media_num "$csi0_device_path")
	echo "csi0_media_num $csi0_media_num"
	set_csi2_0_channel0_cfe_link="media-ctl -d $csi0_media_num -l ''\''csi2'\'':4 -> '\''rp1-cfe-csi2_ch0'\'':0 [1]'"
	set_csi2_0_channel0_pad0_fmt="media-ctl -d $csi0_media_num -V ''\''csi2'\'':0 [fmt:UYVY8_1X16/${sensor_width}x${sensor_hight} field:none colorspace:smpte170m]'"
	set_csi2_0_channel0_pad4_fmt="media-ctl -d $csi0_media_num -V ''\''csi2'\'':4 [fmt:UYVY8_1X16/${sensor_width}x${sensor_hight} field:none colorspace:smpte170m]'"
	set_9296_0_channel0_pad0_fmt="media-ctl -d $csi0_media_num -V ''\''max9296 ${csi0_i2c_num}-0010'\'':0 [fmt:UYVY8_1X16/${sensor_width}x${sensor_hight} field:none colorspace:smpte170m]'"
	set_csi2_0_channel1_cfe_link="media-ctl -d $csi0_media_num -l ''\''csi2'\'':6 -> '\''rp1-cfe-csi2_ch2'\'':0 [1]'"
	set_csi2_0_channel1_pad2_fmt_no_change="media-ctl -d $csi0_media_num -V ''\''csi2'\'':2 [fmt:UYVY8_1X16/1920x1536 field:none colorspace:smpte170m]'"
	set_csi2_0_channel1_pad2_fmt_change="media-ctl -d $csi0_media_num -V ''\''csi2'\'':2 [fmt:UYVY8_1X16/${sensor_width}x${sensor_hight} field:none colorspace:smpte170m]'"
	set_csi2_0_channel1_pad6_fmt="media-ctl -d $csi0_media_num -V ''\''csi2'\'':6 [fmt:UYVY8_1X16/${sensor_width}x${sensor_hight} field:none colorspace:smpte170m]'"
	set_9296_0_channel1_pad2_fmt="media-ctl -d $csi0_media_num -V ''\''max9296 ${csi0_i2c_num}-0010'\'':2 [fmt:UYVY8_1X16/${sensor_width}x${sensor_hight} field:none colorspace:smpte170m]'"
	set_video_0_channel0_fmt="v4l2-ctl --device=/dev/video8 --set-fmt-video=width=${sensor_width},height=${sensor_hight},pixelformat=UYVY"
	set_video_0_channel1_fmt="v4l2-ctl --device=/dev/video10 --set-fmt-video=width=${sensor_width},height=${sensor_hight},pixelformat=UYVY"
	set_media_ctl_0_reset="media-ctl -r -d $csi0_media_num"
	echo $set_csi2_0_channel0_cfe_link
	echo $set_csi2_0_channel0_pad0_fmt
	echo $set_csi2_0_channel0_pad4_fmt
	echo $set_csi2_0_channel1_cfe_link
	echo $set_9296_0_channel0_pad0_fmt
	echo $set_csi2_0_channel1_pad2_fmt_no_change
	echo $set_csi2_0_channel1_pad2_fmt_change
	echo $set_csi2_0_channel1_pad6_fmt
	echo $set_9296_0_channel1_pad2_fmt
	echo $set_video_0_channel0_fmt
	echo $set_video_0_channel1_fmt
	echo $set_media_ctl_0_reset
elif [ "$csi_channle" == "csi1" ]; then
	csi1_media_num=$(get_media_num "$csi1_device_path")
	echo "csi1_media_num $csi1_media_num"
	set_csi2_1_channel0_cfe_link="media-ctl -d $csi1_media_num -l ''\''csi2'\'':4 -> '\''rp1-cfe-csi2_ch0'\'':0 [1]'"
	set_csi2_1_channel0_pad0_fmt="media-ctl -d $csi1_media_num -V ''\''csi2'\'':0 [fmt:UYVY8_1X16/${sensor_width}x${sensor_hight} field:none colorspace:smpte170m]'"
	set_csi2_1_channel0_pad4_fmt="media-ctl -d $csi1_media_num -V ''\''csi2'\'':4 [fmt:UYVY8_1X16/${sensor_width}x${sensor_hight} field:none colorspace:smpte170m]'"
	set_9296_1_channel0_pad0_fmt="media-ctl -d $csi1_media_num -V ''\''max9296 ${csi1_i2c_num}-0010'\'':0 [fmt:UYVY8_1X16/${sensor_width}x${sensor_hight} field:none colorspace:smpte170m]'"
	set_csi2_1_channel1_cfe_link="media-ctl -d $csi1_media_num -l ''\''csi2'\'':6 -> '\''rp1-cfe-csi2_ch2'\'':0 [1]'"
	set_csi2_1_channel1_pad2_fmt_no_change="media-ctl -d $csi1_media_num -V ''\''csi2'\'':2 [fmt:UYVY8_1X16/1920x1536 field:none colorspace:smpte170m]'"
	set_csi2_1_channel1_pad2_fmt_change="media-ctl -d $csi1_media_num -V ''\''csi2'\'':2 [fmt:UYVY8_1X16/${sensor_width}x${sensor_hight} field:none colorspace:smpte170m]'"
	set_csi2_1_channel1_pad6_fmt="media-ctl -d $csi1_media_num -V ''\''csi2'\'':6 [fmt:UYVY8_1X16/${sensor_width}x${sensor_hight} field:none colorspace:smpte170m]'"
	set_9296_1_channel1_pad2_fmt="media-ctl -d $csi1_media_num -V ''\''max9296 ${csi1_i2c_num}-0010'\'':2 [fmt:UYVY8_1X16/${sensor_width}x${sensor_hight} field:none colorspace:smpte170m]'"
	set_video_1_channel0_fmt="v4l2-ctl --device=/dev/video0 --set-fmt-video=width=${sensor_width},height=${sensor_hight},pixelformat=UYVY"
	set_video_1_channel1_fmt="v4l2-ctl --device=/dev/video2 --set-fmt-video=width=${sensor_width},height=${sensor_hight},pixelformat=UYVY"
	set_media_ctl_1_reset="media-ctl -r -d $csi1_media_num"
	echo $set_csi2_1_channel0_cfe_link
	echo $set_csi2_1_channel0_pad0_fmt
	echo $set_csi2_1_channel0_pad4_fmt
	echo $set_csi2_1_channel1_cfe_link
	echo $set_9296_1_channel0_pad0_fmt
	echo $set_csi2_1_channel1_pad2_fmt_no_change
	echo $set_csi2_1_channel1_pad2_fmt_change
	echo $set_csi2_1_channel1_pad6_fmt
	echo $set_9296_1_channel1_pad2_fmt
	echo $set_video_1_channel0_fmt
	echo $set_video_1_channel1_fmt
	echo $set_media_ctl_1_reset
elif [ "$csi_channle" == "all" ]; then
	csi0_media_num=$(get_media_num "$csi0_device_path")
	echo "csi0_media_num $csi0_media_num"
	csi1_media_num=$(get_media_num "$csi1_device_path")
	echo "csi1_media_num $csi1_media_num"
	set_csi2_0_channel0_cfe_link="media-ctl -d $csi0_media_num -l ''\''csi2'\'':4 -> '\''rp1-cfe-csi2_ch0'\'':0 [1]'"
	set_csi2_0_channel0_pad0_fmt="media-ctl -d $csi0_media_num -V ''\''csi2'\'':0 [fmt:UYVY8_1X16/${sensor_width}x${sensor_hight} field:none colorspace:smpte170m]'"
	set_csi2_0_channel0_pad4_fmt="media-ctl -d $csi0_media_num -V ''\''csi2'\'':4 [fmt:UYVY8_1X16/${sensor_width}x${sensor_hight} field:none colorspace:smpte170m]'"
	set_9296_0_channel0_pad0_fmt="media-ctl -d $csi0_media_num -V ''\''max9296 ${csi0_i2c_num}-0010'\'':0 [fmt:UYVY8_1X16/${sensor_width}x${sensor_hight} field:none colorspace:smpte170m]'"
	set_csi2_0_channel1_cfe_link="media-ctl -d $csi0_media_num -l ''\''csi2'\'':6 -> '\''rp1-cfe-csi2_ch2'\'':0 [1]'"
	set_csi2_0_channel1_pad2_fmt_no_change="media-ctl -d $csi0_media_num -V ''\''csi2'\'':2 [fmt:UYVY8_1X16/1920x1536 field:none colorspace:smpte170m]'"
	set_csi2_0_channel1_pad2_fmt_change="media-ctl -d $csi0_media_num -V ''\''csi2'\'':2 [fmt:UYVY8_1X16/${sensor_width}x${sensor_hight} field:none colorspace:smpte170m]'"
	set_csi2_0_channel1_pad6_fmt="media-ctl -d $csi0_media_num -V ''\''csi2'\'':6 [fmt:UYVY8_1X16/${sensor_width}x${sensor_hight} field:none colorspace:smpte170m]'"
	set_9296_0_channel1_pad2_fmt="media-ctl -d $csi0_media_num -V ''\''max9296 ${csi0_i2c_num}-0010'\'':2 [fmt:UYVY8_1X16/${sensor_width}x${sensor_hight} field:none colorspace:smpte170m]'"
	set_video_0_channel0_fmt="v4l2-ctl --device=/dev/video8 --set-fmt-video=width=${sensor_width},height=${sensor_hight},pixelformat=UYVY"
	set_video_0_channel1_fmt="v4l2-ctl --device=/dev/video10 --set-fmt-video=width=${sensor_width},height=${sensor_hight},pixelformat=UYVY"
	set_media_ctl_0_reset="media-ctl -r -d $csi0_media_num"
	echo $set_csi2_0_channel0_cfe_link
	echo $set_csi2_0_channel0_pad0_fmt
	echo $set_csi2_0_channel0_pad4_fmt
	echo $set_csi2_0_channel1_cfe_link
	echo $set_9296_0_channel0_pad0_fmt
	echo $set_csi2_0_channel1_pad2_fmt_no_change
	echo $set_csi2_0_channel1_pad2_fmt_change
	echo $set_csi2_0_channel1_pad6_fmt
	echo $set_9296_0_channel1_pad2_fmt
	echo $set_video_0_channel0_fmt
	echo $set_video_0_channel1_fmt
	echo $set_media_ctl_0_reset

	
	set_csi2_1_channel0_cfe_link="media-ctl -d $csi1_media_num -l ''\''csi2'\'':4 -> '\''rp1-cfe-csi2_ch0'\'':0 [1]'"
	set_csi2_1_channel0_pad0_fmt="media-ctl -d $csi1_media_num -V ''\''csi2'\'':0 [fmt:UYVY8_1X16/${sensor_width}x${sensor_hight} field:none colorspace:smpte170m]'"
	set_csi2_1_channel0_pad4_fmt="media-ctl -d $csi1_media_num -V ''\''csi2'\'':4 [fmt:UYVY8_1X16/${sensor_width}x${sensor_hight} field:none colorspace:smpte170m]'"
	set_9296_1_channel0_pad0_fmt="media-ctl -d $csi1_media_num -V ''\''max9296 ${csi1_i2c_num}-0010'\'':0 [fmt:UYVY8_1X16/${sensor_width}x${sensor_hight} field:none colorspace:smpte170m]'"
	set_csi2_1_channel1_cfe_link="media-ctl -d $csi1_media_num -l ''\''csi2'\'':6 -> '\''rp1-cfe-csi2_ch2'\'':0 [1]'"
	set_csi2_1_channel1_pad2_fmt_no_change="media-ctl -d $csi1_media_num -V ''\''csi2'\'':2 [fmt:UYVY8_1X16/1920x1536 field:none colorspace:smpte170m]'"
	set_csi2_1_channel1_pad2_fmt_change="media-ctl -d $csi1_media_num -V ''\''csi2'\'':2 [fmt:UYVY8_1X16/${sensor_width}x${sensor_hight} field:none colorspace:smpte170m]'"
	set_csi2_1_channel1_pad6_fmt="media-ctl -d $csi1_media_num -V ''\''csi2'\'':6 [fmt:UYVY8_1X16/${sensor_width}x${sensor_hight} field:none colorspace:smpte170m]'"
	set_9296_1_channel1_pad2_fmt="media-ctl -d $csi1_media_num -V ''\''max9296 ${csi1_i2c_num}-0010'\'':2 [fmt:UYVY8_1X16/${sensor_width}x${sensor_hight} field:none colorspace:smpte170m]'"
	set_video_1_channel0_fmt="v4l2-ctl --device=/dev/video0 --set-fmt-video=width=${sensor_width},height=${sensor_hight},pixelformat=UYVY"
	set_video_1_channel1_fmt="v4l2-ctl --device=/dev/video2 --set-fmt-video=width=${sensor_width},height=${sensor_hight},pixelformat=UYVY"
	set_media_ctl_1_reset="media-ctl -r -d $csi1_media_num"
	echo $set_csi2_1_channel0_cfe_link
	echo $set_csi2_1_channel0_pad0_fmt
	echo $set_csi2_1_channel0_pad4_fmt
	echo $set_csi2_1_channel1_cfe_link
	echo $set_9296_1_channel0_pad0_fmt
	echo $set_csi2_1_channel1_pad2_fmt_no_change
	echo $set_csi2_1_channel1_pad2_fmt_change
	echo $set_csi2_1_channel1_pad6_fmt
	echo $set_9296_1_channel1_pad2_fmt
	echo $set_video_1_channel0_fmt
	echo $set_video_1_channel1_fmt
	echo $set_media_ctl_1_reset
else
	echo "not suppot current deivce $1"

fi

if [ "$csi_channle" == "csi0" ]; then
	if [ "$channel_flag" == "1ch" ]; then
		eval $set_media_ctl_0_reset
		eval $set_csi2_0_channel0_cfe_link
		eval $set_csi2_0_channel0_pad0_fmt
		eval $set_csi2_0_channel0_pad4_fmt
		eval $set_csi2_0_channel1_pad2_fmt_no_change
		eval $set_9296_0_channel0_pad0_fmt
		eval $set_video_0_channel0_fmt
	elif [ "$channel_flag" == "2ch" ]; then
		eval $set_media_ctl_0_reset
		eval $set_csi2_0_channel0_cfe_link
		eval $set_csi2_0_channel0_pad0_fmt
		eval $set_csi2_0_channel0_pad4_fmt
		eval $set_csi2_0_channel1_cfe_link
		eval $set_csi2_0_channel1_pad2_fmt_change
		eval $set_csi2_0_channel1_pad6_fmt
		eval $set_9296_0_channel1_pad2_fmt
		eval $set_video_0_channel0_fmt
		eval $set_video_0_channel1_fmt
	else
		echo "not support current channel $channel_flag"
		exit 1
	fi
elif [ "$csi_channle" == "csi1" ]; then
	if [ "$channel_flag" == "1ch" ]; then
		eval $set_media_ctl_1_reset
		eval $set_csi2_1_channel0_cfe_link
		eval $set_csi2_1_channel0_pad0_fmt
		eval $set_csi2_1_channel0_pad4_fmt
		eval $set_csi2_1_channel1_pad2_fmt_no_change
		eval $set_9296_1_channel0_pad0_fmt
		eval $set_video_1_channel0_fmt
	elif [ "$channel_flag" == "2ch" ]; then
		eval $set_media_ctl_1_reset
		eval $set_csi2_1_channel0_cfe_link
		eval $set_csi2_1_channel0_pad0_fmt
		eval $set_csi2_1_channel0_pad4_fmt
		eval $set_csi2_1_channel1_cfe_link
		eval $set_csi2_1_channel1_pad2_fmt_change
		eval $set_csi2_1_channel1_pad6_fmt
		eval $set_9296_1_channel1_pad2_fmt
		eval $set_video_1_channel0_fmt
		eval $set_video_1_channel1_fmt
	else
		echo "not support current channel $channel_flag"
		exit 1
	fi
elif [ "$csi_channle" == "all" ]; then
	if [ "$channel_flag" == "1ch" ]; then
		eval $set_media_ctl_0_reset
		eval $set_media_ctl_1_reset
		eval $set_csi2_0_channel0_cfe_link
		eval $set_csi2_0_channel0_pad0_fmt
		eval $set_csi2_0_channel0_pad4_fmt
		eval $set_csi2_0_channel1_pad2_fmt_no_change
		eval $set_9296_0_channel0_pad0_fmt
		eval $set_video_0_channel0_fmt
		eval $set_csi2_1_channel0_cfe_link
		eval $set_csi2_1_channel0_pad0_fmt
		eval $set_csi2_1_channel0_pad4_fmt
		eval $set_csi2_1_channel1_pad2_fmt_no_change
		eval $set_9296_1_channel0_pad0_fmt
		eval $set_video_1_channel0_fmt
	elif [ "$channel_flag" == "2ch" ]; then
		eval $set_media_ctl_0_reset
		eval $set_media_ctl_1_reset
		eval $set_csi2_0_channel0_cfe_link
		eval $set_csi2_0_channel0_pad0_fmt
		eval $set_csi2_0_channel0_pad4_fmt
		eval $set_csi2_0_channel1_cfe_link
		eval $set_csi2_0_channel1_pad2_fmt_change
		eval $set_csi2_0_channel1_pad6_fmt
		eval $set_9296_0_channel1_pad2_fmt
		eval $set_video_0_channel0_fmt
		eval $set_video_0_channel1_fmt
		eval $set_csi2_1_channel0_cfe_link
		eval $set_csi2_1_channel0_pad0_fmt
		eval $set_csi2_1_channel0_pad4_fmt
		eval $set_csi2_1_channel1_cfe_link
		eval $set_csi2_1_channel1_pad2_fmt_change
		eval $set_csi2_1_channel1_pad6_fmt
		eval $set_9296_1_channel1_pad2_fmt
		eval $set_video_1_channel0_fmt
		eval $set_video_1_channel1_fmt
	else
		echo "not support current channel $channel_flag"
		exit 1
	fi

else
	echo "not suppot current deivce $1"

fi


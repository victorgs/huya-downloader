rm -rf files
mkdir files
cd files
#ID=$1
#M3U8=$(curl -sS "https://liveapi.huya.com/moment/getMomentContent?&videoId=${ID}" | jq -r '.data.moment.videoInfo.definitions[0].m3u8')
#echo $M3U8
#TS_URL=$(echo $M3U8 | sed 's|\(.*\)/.*|\1|' | sed -r 's/hw/tx/g')
TS_FILES=$(cat ../4638697742409163_index.m3u8 | grep ts)
for file in $TS_FILES;
do
    #echo "downloading: $TS_URL/$file"
    echo $file
    echo "file $file" >> vidlist.txt
    #echo "https://live.video.weibocdn.com/$file"
    curl -O -sS "https://live.video.weibocdn.com/$file"
    #exit 1
done
ffmpeg -f concat -safe 0 -i vidlist.txt -c copy output.mkv

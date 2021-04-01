rm -rf files
mkdir files
cd files
ID=$1
M3U8=$(curl -sS "https://liveapi.huya.com/moment/getMomentContent?&videoId=${ID}" | jq -r '.data.moment.videoInfo.definitions[0].m3u8')
echo $M3U8
TS_URL=$(echo $M3U8 | sed 's|\(.*\)/.*|\1|' | sed -r 's/hw/tx/g')
TS_FILES=$(curl -sS "$M3U8"|grep ts)
NUM=$(echo $TS_FILES| wc -w)
COUNTER=0
echo $NUM
for file in $TS_FILES;
do
    #echo "downloading: $TS_URL/$file"
    echo "file $file" >> vidlist.txt
    curl -O -sS "$TS_URL/$file"
    let COUNTER=COUNTER+1
    echo "$COUNTER of $NUM"
done
ffmpeg -f concat -safe 0 -i vidlist.txt -c copy output.mkv

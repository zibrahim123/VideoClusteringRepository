#!/bin/bash

input="listVideo.txt"

while IFS= read -r var
do
  echo $var
  #echo "/media/zein/835C-4E2D/Research Datasets/test_Dataset/DEV_VIDEO/"$var
  #echo "/media/zein/835C-4E2D/Research Datasets/test_Dataset/DEV_AUDIO/"${var}".wav"
  avconv -loglevel quiet -i "/media/zein/835C-4E2D/Research Datasets/DataSet - MediaEval/Dev/Video/MEDIAEVAL/DEV_VIDEO/"$var "/media/zein/835C-4E2D/Research Datasets/test_Dataset/DEV_AUDIO/new/tmp_"$var".wav" < /dev/null
  echo "conv video passed"
  sizefile=$(ls -s "/media/zein/835C-4E2D/Research Datasets/test_Dataset/DEV_AUDIO/new/tmp_"$var".wav")
  if [[ $sizefile == 0* ]]; then
	echo "/media/zein/835C-4E2D/Research Datasets/DataSet - MediaEval/Dev/Video/MEDIAEVAL/DEV_VIDEO/"$var" has no audio track. It will be ignored"
	rm "/media/zein/835C-4E2D/Research Datasets/test_Dataset/DEV_AUDIO/new/tmp_"${var}".wav"
  else
	echo "/media/zein/835C-4E2D/Research Datasets/DataSet - MediaEval/Dev/Video/MEDIAEVAL/DEV_VIDEO/"$var" has audio track. It will be processed"
  	sox "/media/zein/835C-4E2D/Research Datasets/test_Dataset/DEV_AUDIO/new/tmp_"${var}".wav" -c 1 -r 16000 "/media/zein/835C-4E2D/Research Datasets/test_Dataset/DEV_AUDIO/new/"${var}".wav"
  	rm "/media/zein/835C-4E2D/Research Datasets/test_Dataset/DEV_AUDIO/new/tmp_"${var}".wav"
  	python generateLowLevelDescriptors.py ${var}
  fi
done < "$input"


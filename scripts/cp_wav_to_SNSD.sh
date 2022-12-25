#!/bin/bash

clean_train="/home/tester/bokleong/dl_project/MS-SNSD/clean_train"
noise_train="/home/tester/bokleong/dl_project/MS-SNSD/noise_train"

# hdf5_wavs_speech="hdf5_TEST_speech_smaller.txt"
# hdf5_wavs_noise="hdf5_TEST_noise_smaller.txt"
hdf5_wavs_speech="hdf5_TEST_speech.txt"
hdf5_wavs_noise="hdf5_TEST_noise.txt"
hdf5_wavs_dir="/home/tester/bokleong/dl_project_dfn/hdf5_info_TEST"

# SPEECH #
# input="${hdf5_wavs_dir}/${hdf5_wavs_speech}"
# # WARNING: For some reason this loop to read line by line only works if there is a newline after the last line of text you want to extract
# while read -r line
# do
#     # echo ${line}
#     basename=$(basename ${line})
#     echo Copying ${basename} to clean_train...
#     # echo cp ${line} ${clean_train}/${basename}

#     cp ${line} ${clean_train}/${basename}

# done < ${input}

# NOISE #
input="${hdf5_wavs_dir}/${hdf5_wavs_noise}"
# WARNING: For some reason this loop to read line by line only works if there is a newline after the last line of text you want to extract
while read -r line
do
    # echo ${line}
    basename=$(basename ${line})
    dirname=$(basename $(dirname ${line}))
    echo Copying ${dirname}_${basename} to noise_train...
    # echo cp ${line} ${noise_train}/${dirname}_${basename}

    cp ${line} ${noise_train}/${dirname}_${basename}

done < ${input}
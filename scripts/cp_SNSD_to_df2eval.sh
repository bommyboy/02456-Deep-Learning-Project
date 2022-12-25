#!/bin/bash

# !! CHANGE THIS !! #
# options=""
# run="1"
# options="--compensate-delay"
# run="2"
options="--compensate-delay --pf" 
echo Enter run number to zip:
read run


clean_source="/home/tester/bokleong/dl_project/MS-SNSD/CleanSpeech_training"
noise_source="/home/tester/bokleong/dl_project/MS-SNSD/NoisySpeech_training"

data_dir="/home/tester/bokleong/dl_project_eval/DeepFilterNet/my_data"
clean_dest="${data_dir}/run${run}/clean/"
noise_dest="${data_dir}/run${run}/noise/"

echo Copying clean files...
mkdir -p ${clean_dest} && cp -a ${clean_source}/. ${clean_dest}

echo Copying noise files...
mkdir -p ${noise_dest} && cp -a ${noise_source}/. ${noise_dest}

# Write a simple txt file to explain options used in run${run}
echo "Options used in run${run}: ${options}" > ${data_dir}/run${run}/run${run}_options.txt
echo "${options}" > ${data_dir}/run${run}/run${run}_options.txt

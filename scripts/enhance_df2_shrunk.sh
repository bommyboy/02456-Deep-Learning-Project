#!/bin/bash

path_to_enhance="/home/tester/bokleong/dl_project_eval/DeepFilterNet/DeepFilterNet/df/enhance.py"
path_to_df2_shrunk="/home/tester/bokleong/dl_project_eval/DeepFilterNet/models/df2_shrunk/"

echo "Enhancing audio using SHRUNK DeepFilterNet2 (df2_shrunk)"
echo "Run no. to enhance:"
read run

# # !! CHANGE THIS !! #
# # run="1"
# run="2"

data_dir="/home/tester/bokleong/dl_project_eval/DeepFilterNet/my_data/run${run}"
noisy_file_dir="${data_dir}/noise"
output_dir="${data_dir}/enhanced_df2_shrunk"

# Read options
options=$(head -n 1 ${data_dir}/run${run}_options.txt)
echo Enhancing run${run} with options: ${options}
echo "CTRL+C to cancel, or press any key to continue"
read confirmation
echo Enhancing...

nums=(1 2 3 4 5 6 7 8)
snrs=(-20.0 -15.0 -10.0 -5.0 0.0 5.0 10.0 15.0 20.0)

# nums=(1 2 3 4 5)
# snrs=(0.0 1.0 2.0 3.0 4.0 5.0 6.0 7.0 8.0 9.0)

mkdir -p ${output_dir}
for num in ${nums[@]}
do
    for snr in ${snrs[@]}
    do  
        # !! CHANGE THIS !! #
        # Without --compensate-delay
        # python3 ${path_to_enhance} -m ${path_to_df2_shrunk} ${noisy_file_dir}/noisy${num}_SNRdb_${snr}_clnsp${num}.wav -o ${output_dir}
        # With --compensate-delay
        python3 ${path_to_enhance} -m ${path_to_df2_shrunk} ${noisy_file_dir}/noisy${num}_SNRdb_${snr}_clnsp${num}.wav -o ${output_dir} ${options}
    done
done
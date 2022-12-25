#!/bin/bash

data_dir="/home/tester/bokleong/dl_project_eval/DeepFilterNet/my_data"

echo WARNING! YOU ARE ABOUT TO DELETE A FILE!!
echo Enter run number of zip to REMOVE:
read run
zip_file="${data_dir}/run${run}/run${run}.zip"

echo "REMOVING zip file for run${run}..."
rm ${zip_file}
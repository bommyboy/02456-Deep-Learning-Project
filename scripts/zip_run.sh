#!/bin/bash

data_dir="/home/tester/bokleong/dl_project_eval/DeepFilterNet/my_data"

echo Enter run number to zip:
read run
zip_file="run${run}.zip"
run_dir="${data_dir}/run${run}"

cd ${run_dir}
echo "Zipping files for run${run}..."
zip -r ${zip_file} .
#!/bin/bash

echo "Calculate metrics for run number:"
read run

data_dir="/home/tester/bokleong/dl_project_eval/DeepFilterNet/my_data/run${run}"
options=$(head -n 1 ${data_dir}/run${run}_options.txt)
if [[ ${options} == *"--pf"* ]]
then
    pf="--pf"
else
    pf=""
fi

# echo ${pf}

echo "Calculating metrics for run${run}..."
python3 calculate_metrics.py --run ${run} ${pf}
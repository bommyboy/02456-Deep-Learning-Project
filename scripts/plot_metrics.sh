#!/bin/bash

echo "Plot metrics for run number:"
read run

mkdir -p /home/tester/bokleong/dl_project_eval/DeepFilterNet/my_data/run${run}/metric_plots/

echo "Generating metric plots for run${run}..."
python3 plot_metrics.py --run ${run}
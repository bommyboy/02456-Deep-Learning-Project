import sys
import numpy as np
import matplotlib.pyplot as plt
# from matplotlib.pyplot import bar,xticks,show
from tqdm import tqdm
from helper import *

if __name__ == "__main__":

    # Get run number from command arguments
    args = sys.argv[1:]
    # print(args)
    assert len(args) == 2, "Specifying the run number is mandatory! Please specify the run number as the ONLY argument using '--run <run_no>'."
    
    run = str(args[1])

    # """(1) Run"""
    # run = 1

    data_dir  = f"/home/tester/bokleong/dl_project_eval/DeepFilterNet/my_data/run{run}"

    metrics_file = f"run{run}_metric_scores.json"

    # figures_dir = "my_figures/run1"
    figures_dir = f"{data_dir}/metric_plots"

    scores = load_json(f"{data_dir}/{metrics_file}")

    metrics = ["nb_pesq","pesq","sisdr"]

    """(1) SNRs"""
    snrs    = ["-10.0", "-5.0", "0.0", "10.0"]

    """(2) Speech numbers"""
    nums = ["1","2","3","4","5","6","7","8"]

    # for metric in tqdm(metrics[:1],"metric   "):
    for metric in tqdm(metrics,"metric   "):
        # for num in tqdm(nums[:1],"clnsp_num"):
        ldf2_vals = []
        ldf2_shrunk_vals = []
        laugnet_vals = []
        lnoise_vals = []
        for snr in snrs:
            this_dict = {k:v[metric] for k,v in scores.items()}
            print(this_dict)
            # plotting = dict()
            df2_vals = 0
            df2_shrunk_vals = 0
            augnet_vals = 0
            noise_vals = 0
            for num in tqdm(nums,"clnsp_num"):
                df2        = f"df2-{snr}-{num}"
                df2_shrunk = f"df2_shrunk-{snr}-{num}"
                augnet = f"augnet-{snr}-{num}"
                noise = f"Noise-{snr}-{num}"

                # For plotting difference
                # difference = this_dict[df2] - this_dict[df2_shrunk]
                # plotting[f"{snr}"] = difference
                df2_vals += this_dict[df2]
                df2_shrunk_vals += this_dict[df2_shrunk]
                augnet_vals += this_dict[augnet]
                noise_vals += this_dict[noise]
            df2_vals /= len(nums)
            df2_shrunk_vals /= len(nums)
            augnet_vals /= len(nums)
            noise_vals /= len(nums)
            ldf2_vals.append(df2_vals)
            ldf2_shrunk_vals.append(df2_shrunk_vals)
            laugnet_vals.append(augnet_vals)
            lnoise_vals.append(noise_vals)
        """
        Control how the plot looks
        """
        num_snrs = len(snrs)
        bar_width = 0.20
        title_size = 18
        label_size = 15
        gridline_thickness = 0.2
        height = 8
        width = num_snrs*0.9 + 0.5
        title = f"[{metric.upper()}] {run}\n"
        ylabel = f"{metric.upper()}"
        xlabel = f"\nSNR"
        fig, ax = plt.subplots(1,1,figsize=(width,height))
        ax.grid(zorder=0,linestyle='-',linewidth=gridline_thickness)
        loc = np.arange(len(snrs))
        df2 = ax.bar(loc - 1.5 * bar_width,ldf2_vals,bar_width,zorder=4,color="#1f77b4")
        df2_shrunk = ax.bar(loc - 0.5 * bar_width,ldf2_shrunk_vals,bar_width,zorder=4,color="#cb4c4e")
        augnet = ax.bar(loc + 0.5 * bar_width, laugnet_vals,bar_width,zorder=4,color="#4ccb5f")
        noise = ax.bar(loc + 1.5 * bar_width,lnoise_vals,bar_width,zorder=4,color="#FFA500")
        ax.set_title(title,size=title_size, y=0.96)
        ax.set_ylabel(ylabel,size=label_size, labelpad=-12)
        ax.set_xlabel(xlabel,size=label_size, labelpad=-12)
        ax.set_xticks(np.arange(len(snrs)))
        ax.set_xticklabels(snrs, size=label_size)
        ax.set_ylim(-7, 17)
        ax.tick_params(axis='both', which='major', labelsize=label_size)
        ax.legend((df2[0], df2_shrunk[0], augnet[0], noise[0]), ('DeepFilterNet2', 'DeepFilterNet2(S)', 'AugNet', 'Noise'),prop={'size': label_size - 4}, loc='lower right')
        ax.spines['top'].set_visible(False)
        ax.spines['right'].set_visible(False)
        plt.tight_layout()
        plt.savefig(f"{figures_dir}/{metric}_{run}.png")
        plt.close()
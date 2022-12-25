# the case of absolute metrics
import speechmetrics
import json
import sys
from scipy.io import wavfile
import numpy as np

def save_to_json(dic,output="metric_scores.json",indent=4):

    with open(output, 'w') as fp:
        json.dump(dic, fp, indent=indent)

if __name__ == "__main__":

    # Get run number from command arguments
    args = sys.argv[1:]
    # print(args)
    assert 2 <= len(args) <= 3, "Specifying the run number is mandatory! Please specify the run number as using '--run <run_no>', and additionally '--pf' is necessary."
    
    run = str(args[1])
    if "--pf" in args:
        pf = True
        print(f"--pf specified.")
    else:
        pf = False
        print(f"--pf NOT specified.")

    # Put a really large window length so that it considers the entire audio. Its fine to put a value larger than audio length
    window_length = None # seconds

    # We load stoi and pesq as per Michael's request
    metrics = speechmetrics.load(['pesq','nb_pesq', 'sisdr'], window_length)

    """(1) Models"""
    models   = ["df2","df2_shrunk", "augnet"]

    """(2) SNRs"""
    snrs     = ["-20.0","-15.0","-10.0","-5.0","0.0","5.0","10.0","15.0","20.0"]

    """(3) Speech numbers"""
    speech   = ["1","2","3","4","5","6","7","8"]

    data_dir = f"/home/tester/bokleong/dl_project_eval/DeepFilterNet/my_data/run{run}"
    metrics_output_name = f"run{run}_metric_scores.json"

    if pf:
        wav_dict = {"df2"       :"DeepFilterNet2_pf",
                    "df2_shrunk":"df2_shrunk_pf",
		    "augnet":"augnet"}
    else:
        wav_dict = {"df2"       :"DeepFilterNet2",
                    "df2_shrunk":"df2_shrunk",
		    "augnet":"augnet"}

    scores = dict()

    for snr in snrs:
        for num in speech:
            for model in models:
                label = f"{model}-{snr}-{num}"
                enhanced = f"{data_dir}/enhanced_{model}/noisy{num}_SNRdb_{snr}_clnsp{num}_{wav_dict[model]}.wav"
                clean    = f"{data_dir}/clean/clnsp{num}.wav"
                print(label)
                samplerate, enhanced= wavfile.read(enhanced)
                samplerate, clean= wavfile.read(clean)
                enhanced = enhanced.astype('float32')
                clean = clean.astype('float32')
                if model == "augnet":
                    enhanced = enhanced[1920:]
                    clean = clean[:-1920]
                print(len(enhanced), len(clean))
                assert(len(enhanced) == len(clean))
                score = metrics(enhanced, clean, rate=samplerate)
                print(score)
                # score = {k:float(v[0]) for k,v in score.items()}
                scores[label] = score
            label = f"Noise-{snr}-{num}"
            enhanced = f"{data_dir}/noise/noisy{num}_SNRdb_{snr}_clnsp{num}.wav"
            clean    = f"{data_dir}/clean/clnsp{num}.wav"
            score = metrics(enhanced,clean)
            print(score)
            # score = {k:float(v[0]) for k,v in score.items()}
            scores[label] = score
    save_to_json(scores,output=f"{data_dir}/{metrics_output_name}")
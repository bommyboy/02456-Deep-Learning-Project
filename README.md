# 02456 Deep Learning Project
## Project 7: Real Time Speech Enhancement using DeepFilterNet2 on low computation devices

## About
We attempted to shrink the existing DeepFilterNet2 speech enhancement model by reducing the trainable parameters and evaluating its performance against the original DeepFilterNet2 and AugNet (provided by AugmentedHearing.io in DTU).

## Shrinking
The configuration file for the model was first modified and then trained. The configuration file can be found under df2_shrunk/config.ini. The variable "emb_hidden_dim" and "df_hidden_dim" which correspond to the hidden units in the Gated Reccurent Unit layers were reduced from 256 to 160. 

## Training
The shrunk model was trained on three datasets that was split into train/valid/test (70%/15%/15%):
- Clean speech dataset from [VCTK Voice Bank](https://www.kaggle.com/datasets/pratt3000/vctk-corpus)
- Noise dataset from [DEMAND Dataset](https://zenodo.org/record/1227121#.Y3YF7C8w30o)
- Room Impulse dataset from [Icassp 2022 Deep Noise Suppression Challenge](https://www.microsoft.com/en-us/research/academic-program/deep-noise-suppression-challenge-icassp-2022/)

## Evaluation
Noisy speech was generated from the test set. Room Impulse was not mixed for testing. The types of noise used were cafe(CAFE), cafeteria(CAFETERIA), meeting(MEETING), metro(METRO), park(PARK), train station(STATION), and traffic intersection(TRAFFIC). Noises were mixed at an interval -5 dB from -20 Signal to Noise Ratio (SNR) to 20 SNR. However, only noisy speech at -10, -5, 0, 5 and 10 SNR were evaluated. The generated noisy speech can be found under the directory /run[Noise type]/noise. 8 audio clips totaling around a minute of noisy speech were generated for each noise type and SNR.
The noisy speech were enhanced using the thre models - DeepFilterNet2, Shrunk DeepFilterNet2 and AugNet. The enhanced speeches can be found under the directory /run[Noise type]/enhanced_[Model type].
The enhanced speeches were then evaluated with three different metrics. Perceptual Evaluation of Speech Quality (PESQ), Narrow Band Perceptual Evaluation of Speech Quality (NB_PESQ) and Signal Invariant Signal to Distortion Ratio (SISDR). These metric values were stored in json files located in /run[Noise type]/run[Noise type]_metric_scores.json.
Various scripts were used to perform these tasks located in directory /scripts. To be able to enhance speech using DeepFilterNet2 and the shrunk DeepFilterNet2, dependencies would have to be installed as outlined in [DeepFilterNet2 github page](https://github.com/Rikorose/DeepFilterNet).
A jupyter notebook is provided that obtain the various speech metrics and plots them. The notebook was tested on Ubuntu20.04 with ffmpeg and the [speechmetrics ](https://github.com/aliutkus/speechmetrics) module installed.

import librosa
import librosa.display
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.gridspec as gridspec
title_size = 11
fig, ax = plt.subplots(figsize=(4.2, 4.2))
signal, sr = librosa.load(r"G:\runCAFE\noise\noisy1_SNRdb_-10.0_clnsp1.wav")
S = librosa.feature.melspectrogram(y=signal, sr=sr, n_mels=128,
                                    fmax=8000)
S_dB = librosa.power_to_db(S, ref=np.max)
img = librosa.display.specshow(S_dB, x_axis='time',
                         y_axis='mel', sr=sr,
                         fmax=8000, ax=ax)
ax.set_title('Mel-frequency spectogram (Noisy Speech)', fontsize=title_size)
ax.set_yticks([0, 500, 1000, 2000, 4000, 8000])
fig.tight_layout()
plt.show()


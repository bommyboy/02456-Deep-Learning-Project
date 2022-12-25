#!/bin/bash

TRAIN_FILES=() 

for FILE in ${TRAIN_FILES[@]}
do
    echo ${FILE}
    python3 DeepFilterNet/DeepFilterNet/df/scripts/list_attrs_in_hdf5.py data_folder/${FILE}  --keys > hdf5_info_TRAIN/hdf5_${FILE}.txt
done

#!/bin/bash

TEST_FILES=(TEST_48K_SPEECH.hdf5 TMETRO_SET_TEST.hdf5 TCAR_SET_TEST.hdf5 TBUS_SET_TEST.hdf5 STRAFFIC_SET_TEST.hdf5 SCAFE_SET_TEST.hdf5 PSTATION_SET_TEST.hdf5 PRESTO_SET_TEST.hdf5 PCAFETER_SET_TEST.hdf5 OMEETING_SET_TEST.hdf5 OHALLWAY_SET_TEST.hdf5 NRIVER_SET_TEST.hdf5 NPARK_SET_TEST.hdf5 DWASHING_SET_TEST.hdf5 DKITCHEN_SET_TEST.hdf5) 

# Generate separate files --> output: >2 files
# for FILE in ${TEST_FILES[@]}
# do
#     echo ${FILE}
#     python3 DeepFilterNet/DeepFilterNet/df/scripts/list_attrs_in_hdf5.py data_folder/${FILE}  --keys > hdf5_info_TEST/hdf5_${FILE}.txt
# done

# Append all to single file --> output: 1 file
# for FILE in ${TEST_FILES[@]}
# do
#     echo ${FILE}
#     python3 DeepFilterNet/DeepFilterNet/df/scripts/list_attrs_in_hdf5.py data_folder/${FILE}  --keys >> hdf5_info_TEST/hdf5_TEST.txt
# done

# Append speech and noise to 2 separate files --> output: 2 files
for FILE in ${TEST_FILES[@]}
do
    echo ${FILE}
    if [[ ${FILE} == *"_SET_TEST"* ]]
    then
        echo Appending to noise...
        python3 DeepFilterNet/DeepFilterNet/df/scripts/list_attrs_in_hdf5.py data_folder/${FILE}  --keys >> hdf5_info_TEST/hdf5_TEST_noise.txt
    else
        echo Appending to speech...
        python3 DeepFilterNet/DeepFilterNet/df/scripts/list_attrs_in_hdf5.py data_folder/${FILE}  --keys >> hdf5_info_TEST/hdf5_TEST_speech.txt
    fi
done
#!/bin/bash

clean="/home/tester/bokleong/dl_project/MS-SNSD/CleanSpeech_training"
noise="/home/tester/bokleong/dl_project/MS-SNSD/NoisySpeech_training"

echo Removing all files from ${clean}...
rm ${clean}/*
echo Removing all files from ${noise}...
rm ${noise}/*

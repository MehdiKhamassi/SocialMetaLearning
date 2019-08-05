#!/bin/bash

# check to see if all required arguments were provided
if [ $# -eq 6 ]; then
    # assign the provided arguments to variables
    plot_title=$1
    input_data=$2
    whichModel=$3
    runOptimizedModels=$4
    episodeLength=$5
    vertiBars=$6
    nbBlock=$7
else
    # assign the default values to variables
    plot_title="Meta-learning based on social engagement reward signal"
    input_data="../data/bestModelsOptiSummer2016.mat"
    whichModel=5
    runOptimizedModels=1
    episodeLength=1000
    vertiBars=1
    nbBlock=5
fi

echo "Running main.m with arguments $plot_title, $input_data, $whichModel, $runOptimizedModels, $episodeLength, $vertiBars"
matlab -nodisplay -nosoftwareopengl -r \
  "main('$plot_title', '$input_data', $whichModel, $runOptimizedModels, $episodeLength, $vertiBars, $nbBlock)"

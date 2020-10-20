#!/bin/bash

PATHS="/media/rik/ethz_brik/campi_flegrei_sentinel/data/ascending
/media/rik/ethz_brik/campi_flegrei_sentinel/data/descending"
CONFIGS=""

echo "Processing the following folders recursively:"
for P in $PATHS
do
 echo "$P"
 for FOLDER in $P/*
 do
  CONFIGS="$CONFIGS $FOLDER/project.conf"
 done
done

for CONFIG in $CONFIGS
do
 echo "Executing snap2stamps with $CONFIG"

 # slave sorting
 # (fast)
 python slaves_prep.py $CONFIG

 # slave splitting and orbit correction
 # (approx. 50 seconds per slave)
 python splitting_slaves.py $CONFIG

 # master-slave coregistration and interferometric generation
 # (approx. 180 seconds per slave)
 python coreg_ifg_topsar.py $CONFIG

 # ouput data generation in StaMPS compatible format
 # (approx. 30 seconds)
 python stamps_export.py $CONFIG
done
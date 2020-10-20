#!/bin/bash

echo "Executing snap2stamps with $1"

# slave sorting
# (fast)
python slaves_prep.py $1

# slave splitting and orbit correction
# (approx. 50 seconds per slave)
python splitting_slaves.py $1

# master-slave coregistration and interferometric generation
# (approx. 180 seconds per slave)
python coreg_ifg_topsar.py $1

# ouput data generation in StaMPS compatible format
# (approx. 30 seconds)
python stamps_export.py $1

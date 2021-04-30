#!/bin/bash

#
# Script to preprocess the Cityscapes dataset. Note (1) the users should
# register the Cityscapes dataset website at
# https://www.cityscapes-dataset.com/downloads/ to download the dataset,
# and (2) the users should download the utility scripts provided by
# Cityscapes at https://github.com/mcordts/cityscapesScripts.
#
# Usage:
#   bash ./preprocess_cityscapes.sh
#
# The folder structure is assumed to be:
#  + datasets
#    - build_cityscapes_data.py
#    - convert_cityscapes.sh
#    + cityscapes
#      + cityscapesscripts (downloaded scripts)
#      + gtFine
#      + leftImg8bit
#

# Exit immediately if a command exits with a non-zero status.
set -e

CURRENT_DIR=$(pwd)
WORK_DIR="."

# Root path for Cityscapes dataset.
CITYSCAPES_ROOT="${WORK_DIR}/cityscapes"

# Create training labels.
python "${CITYSCAPES_ROOT}/cityscapesscripts/preparation/createTrainIdLabelImgs.py"

# Build TFRecords of the dataset.
# First, create output directory for storing TFRecords.
OUTPUT_DIR="${CITYSCAPES_ROOT}/tfrecord"
mkdir -p "${OUTPUT_DIR}"

BUILD_SCRIPT="${CURRENT_DIR}/build_cityscapes_data.py"

echo "Converting Cityscapes dataset..."
python "${BUILD_SCRIPT}" \
  --cityscapes_root="${CITYSCAPES_ROOT}" \
  --output_dir="${OUTPUT_DIR}" \
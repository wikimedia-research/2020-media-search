#!/bin/bash
SE_PATH=/home/nettrom/src/2020-media-search
PYTHON_HOME=/home/nettrom/venv/bin

cd $SE_PATH
{
  date

  echo "Running daily processing of VE Media Search funnel"
  $PYTHON_HOME/jupyter nbconvert --ExecutePreprocessor.timeout=1800 \
       --to html --execute T259308_VE_media_funnel_processing.ipynb
  hdfs dfs -chmod -R o+r /user/hive/warehouse/nettrom_sd.db/ve_media_funnel_aggregates
} >> $SE_PATH/VE_media_funnel_process.log 2>&1

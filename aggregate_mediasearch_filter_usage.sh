#!/bin/bash
SE_PATH=/home/nettrom/src/2020-media-search
PYTHON_HOME=/home/nettrom/venv/bin

cd $SE_PATH
{
  date

  echo "Running daily aggregation of Special:MediaSearch filter usage metrics"
  $PYTHON_HOME/jupyter nbconvert --ExecutePreprocessor.timeout=1800 \
       --to html --execute T258229_mediasearch_filter_usage.ipynb
  hdfs dfs -chmod -R o+rx /user/hive/warehouse/nettrom_sd.db/mediasearch_filter_change_aggregates
  hdfs dfs -chmod -R o+rx /user/hive/warehouse/nettrom_sd.db/mediasearch_filters_per_session_aggregates
} >> $SE_PATH/mediasearch_filter_usage_aggregation.log 2>&1

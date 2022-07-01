#!/bin/bash
SE_PATH=/home/nettrom/src/2020-media-search
CONDA_ENV_NAME="sd_dashboards"

cd $SE_PATH
{
  date

  echo "Running daily aggregation of search on Commons"

  source conda-activate-stacked $CONDA_ENV_NAME
  
  jupyter nbconvert --ExecutePreprocessor.timeout=1800 \
       --to html --execute T258229_commons_search_aggregation.ipynb
  jupyter nbconvert --ExecutePreprocessor.timeout=1800 \
       --to html --execute T258229_mediasearch_success_aggregation.ipynb
  jupyter nbconvert --ExecutePreprocessor.timeout=1800 \
       --to html --execute T258229_mediasearch_filter_usage.ipynb
  hdfs dfs -chmod -R o+rx /user/hive/warehouse/nettrom_sd.db
} >> $SE_PATH/commons_search_aggregation.log 2>&1

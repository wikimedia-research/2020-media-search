#!/bin/bash
SE_PATH=/home/nettrom/src/2020-media-search
PYTHON_HOME=/home/nettrom/venv/bin

cd $SE_PATH
{
  date

  echo "Running daily aggregation of search on Commons"
  $PYTHON_HOME/jupyter nbconvert --ExecutePreprocessor.timeout=1800 \
       --to html --execute T258229_commons_search_aggregation.ipynb
  hdfs dfs -chmod -R o+r /user/hive/warehouse/nettrom_sd.db/commons_search_counts
} >> $SE_PATH/commons_search_aggregation.log 2>&1

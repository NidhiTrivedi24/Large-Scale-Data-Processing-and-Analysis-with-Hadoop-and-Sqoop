#!/bin/bash

input_directory="/input-path"
output_directory="/home/log_processing/output"
input_file="/home/lab/Hadoop_2k.log"
mapper_py="/home/log_processing/mapper.py"
reducer_py="/home/log_processing/reducer.py"

# Remove output directory if it exists
hdfs dfs -rm -r $output_directory

hdfs dfs -mkdir -p $input_directory
hdfs dfs -put $input_file $input_directory

hadoop jar $HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-3.2.1.jar \
    -files $mapper_py,$reducer_py \
    -mapper "python3 $mapper_py" \
    -reducer "python3 $reducer_py" \
    -input $input_directory \
    -output $output_directory

hdfs dfs -cat $output_directory/part* | sort


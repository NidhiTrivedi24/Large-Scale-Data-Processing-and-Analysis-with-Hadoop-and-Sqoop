#!/bin/bash
 
input_directory="/home/Airline_detail/On_Time_On_Time_Performance_2016_1"
output_directory="/output/airline_delay_output"
 
mapper_py="/home/Airline_detail/airline_delays/mapper.py"
reducer_py="/home/Airline_detail/airline_delays/reducer.py"
 
hdfs dfs -mkdir -p $input_directory
 
hdfs dfs -put $input_directory/* $input_directory
 
hdfs dfs -rm -r $output_directory
hdfs dfs -mkdir $output_directory
 
hadoop jar $HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-3.2.1.jar \
    -files $mapper_py,$reducer_py \
    -mapper $mapper_py \
    -reducer $reducer_py \
    -input $input_directory \
    -output $output_directory
     
hdfs dfs -cat $output_directory/part* | sort
 

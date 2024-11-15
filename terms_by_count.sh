input_directory="/input"
output_directory="/output"
input_file="/data/textcorpora/austen-emma.txt"

hdfs dfs -mkdir $input_directory
hdfs dfs -rm -r $output_directory
hdfs dfs -mkdir $output_directory
hdfs dfs -put $input_file $input_directory/text_austen

hadoop jar $HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-3.2.1.jar \
       -files mapper.py, reducer.py          \
       -mapper mapper.py         \
       -reducer reducer.py       \
       -input $input_directory/text_austen \
       -output $output_directory/word_count1
#to check if out folder are getting created and have files
hdfs dfs -ls $output_directory/word_count1/word_count1
hdfs dfs -ls $output_directory/word_count1/word_count1/part*


hdfs dfs -get $output_directory/word_count1/part*
hdfs dfs -mkdir $input_directory/wc1
hdfs dfs -put part* $input_directory/wc1

hdfs dfs -ls $input_directory/wc1

hadoop jar $HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-3.2.1.jar \
       -files mapper2.py, reducer.py          \
       -mapper mapper2.py         \
       -reducer reducer2.py       \
       -input $input_directory/wc1        \
       -output $output_directory/wc2

hdfs dfs -ls $output_directory/wc2

rm part*
hdfs dfs -get $output_directory/wc2/part* output_file
cat output_file | head -n 10


# Replace "kafka-topics" 
# by "kafka-topics" or "kafka-topics.bat" based on your system # (or bin/kafka-topics or bin\windows\kafka-topics.bat if you didn't setup PATH / Environment variables)

kafka-topics 

kafka-topics --bootstrap-server 192.168.1.101:19092,192.168.1.101:29092,192.168.1.101:39092 --list 

kafka-topics --bootstrap-server 192.168.1.101:19092,192.168.1.101:29092,192.168.1.101:39092 --topic first_topic --create

kafka-topics --bootstrap-server 192.168.1.101:19092,192.168.1.101:29092,192.168.1.101:39092 --topic first_topic --create --partitions 4

kafka-topics --bootstrap-server 192.168.1.101:19092,192.168.1.101:29092,192.168.1.101:39092 --topic java_demo --create --partitions 3 --replication-factor 2

# Create a topic (working)
kafka-topics --bootstrap-server 192.168.1.101:19092,192.168.1.101:29092,192.168.1.101:39092 --topic first_topic --create --partitions 3 --replication-factor 1

# List topics
kafka-topics --bootstrap-server 192.168.1.101:19092,192.168.1.101:29092,192.168.1.101:39092 --list

# Describe a topic
kafka-topics --bootstrap-server 192.168.1.101:19092,192.168.1.101:29092,192.168.1.101:39092 --topic first_topic --describe

# Delete a topic 
kafka-topics --bootstrap-server 192.168.1.101:19092,192.168.1.101:29092,192.168.1.101:39092 --topic first_topic --delete
# (only works if delete.topic.enable=true)
# Replace "kafka-consumer-groups" 
# by "kafka-consumer-groups" or "kafka-consumer-groups.bat" based on your system # (or bin/kafka-consumer-groups or bin\windows\kafka-consumer-groups.bat if you didn't setup PATH / Environment variables)

# look at the documentation again
kafka-consumer-groups

# reset the offsets to the beginning of each partition
kafka-consumer-groups --bootstrap-server 192.168.1.101:19092,192.168.1.101:29092,192.168.1.101:39092 --group my-first-application --reset-offsets --to-earliest

# execute flag is needed
kafka-consumer-groups --bootstrap-server 192.168.1.101:19092,192.168.1.101:29092,192.168.1.101:39092 --group my-first-application --reset-offsets --to-earliest --execute

# topic flag is also needed
kafka-consumer-groups --bootstrap-server 192.168.1.101:19092,192.168.1.101:29092,192.168.1.101:39092 --group my-first-application --reset-offsets --to-earliest --execute --topic first_topic

# consume from where the offsets have been reset
kafka-console-consumer --bootstrap-server 192.168.1.101:19092,192.168.1.101:29092,192.168.1.101:39092 --topic first_topic --group my-first-application

# describe the group again
kafka-consumer-groups --bootstrap-server 192.168.1.101:19092,192.168.1.101:29092,192.168.1.101:39092 --describe --group my-first-application

# documentation for more options
kafka-consumer-groups

# shift offsets by 2 (forward) as another strategy
kafka-consumer-groups --bootstrap-server 192.168.1.101:19092,192.168.1.101:29092,192.168.1.101:39092 --group my-first-application --reset-offsets --shift-by 2 --execute --topic first_topic

# shift offsets by 2 (backward) as another strategy
kafka-consumer-groups --bootstrap-server 192.168.1.101:19092,192.168.1.101:29092,192.168.1.101:39092 --group my-first-application --reset-offsets --shift-by -2 --execute --topic first_topic

# consume again
kafka-console-consumer --bootstrap-server 192.168.1.101:19092,192.168.1.101:29092,192.168.1.101:39092 --topic first_topic --group my-first-application
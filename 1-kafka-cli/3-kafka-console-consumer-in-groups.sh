# Replace "kafka-console-consumer" 
# by "kafka-console-consumer" or "kafka-console-consumer.bat" based on your system # (or bin/kafka-console-consumer or bin\windows\kafka-console-consumer.bat if you didn't setup PATH / Environment variables)

# start one consumer
kafka-console-consumer --bootstrap-server 192.168.1.101:19092,192.168.1.101:29092,192.168.1.101:39092 --topic first_topic --group my-first-application

# start one producer and start producing
kafka-console-producer --bootstrap-server 192.168.1.101:19092,192.168.1.101:29092,192.168.1.101:39092 --topic first_topic

# start another consumer part of the same group. See messages being spread
kafka-console-consumer --bootstrap-server 192.168.1.101:19092,192.168.1.101:29092,192.168.1.101:39092 --topic first_topic --group my-first-application

# start another consumer part of a different group from beginning
kafka-console-consumer --bootstrap-server 192.168.1.101:19092,192.168.1.101:29092,192.168.1.101:39092 --topic first_topic --group my-second-application --from-beginning
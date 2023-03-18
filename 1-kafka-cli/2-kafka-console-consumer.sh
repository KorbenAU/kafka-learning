# Replace "kafka-console-consumer" 
# by "kafka-console-consumer" or "kafka-console-consumer.bat" based on your system # (or bin/kafka-console-consumer or bin\windows\kafka-console-consumer.bat if you didn't setup PATH / Environment variables)

kafka-console-consumer 

# consuming
kafka-console-consumer --bootstrap-server localhost:29092 --topic LmiLocalTest5

# other terminal
kafka-console-producer --bootstrap-server localhost:29092 --topic LmiLocalTest

# consuming from beginning
kafka-console-consumer --bootstrap-server localhost:29092 --topic LmiLocalTest3 --from-beginning

# display key, values and timestamp in consumer
kafka-console-consumer --bootstrap-server localhost:29092 --topic first_topic --formatter kafka.tools.DefaultMessageFormatter --property print.timestamp=true --property print.key=true --property print.value=true --from-beginning
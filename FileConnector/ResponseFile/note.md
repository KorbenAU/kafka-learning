# Code block to get partition offsets

```c#
_partitionOffsets = consumer.Assignment
                .Where(p => p.Topic.Equals(_topicName))
                .Aggregate(new Dictionary<Partition, Offset>(), (result, next) =>
                {
                    result.Add(next.Partition, consumer.GetWatermarkOffsets(next).High);
                    return result;
                });
```

## How does Kafka work in a nutshell?

Kafka is a `distributed system` consisting of `servers` and `clients` that **communicate via a high-performance TCP network protocol**. It can be deployed on bare-metal hardware, virtual machines, and containers in on-premise as well as cloud environments.

### Servers

Kafka is run as a cluster of one or more servers that can span multiple datacenters or cloud regions. **Some of these servers form the `storage layer`, called the `brokers`.** Other servers run Kafka Connect to continuously import and export data as `event streams` to integrate Kafka with your existing systems such as relational databases as well as other Kafka clusters. To let you implement mission-critical use cases, a Kafka cluster is highly scalable and fault-tolerant: if any of its servers fails, the other servers will take over their work to ensure continuous operations without any data loss.

### Clients

They allow you to write distributed applications and microservices that read, write, and process streams of events in parallel, at scale, and in a fault-tolerant manner even in the case of network problems or machine failures. Kafka ships with some such clients included, which are augmented by dozens of clients provided by the Kafka community: clients are available for `Java` and `Scala` including the higher-level Kafka Streams library, for `Go`, `Python`, `C/C++`, and many other programming languages as well as `REST APIs`.

## Main Concepts and Terminology

### Event

An `event` records the fact that "something happened" in the world or in your business. It is also called `record` or `message` in the documentation. When you read or write data to Kafka, you do this in the form of events. Conceptually, an event has a `key`, `value`, `timestamp`, and `optional metadata headers`. Here's an example event:

-   Event key: "Alice"
-   Event value: "Made a payment of $200 to Bob"
-   Event timestamp: "Jun. 25, 2020 at 2:06 p.m."

### Producer & Consumer

`Producers` are those client applications that publish (write) events to Kafka, and `consumers` are those that subscribe to (read and process) these events. In Kafka, producers and consumers are fully decoupled and agnostic of each other, which is a key design element to achieve the high scalability that Kafka is known for. For example, producers never need to wait for consumers. Kafka provides various guarantees such as the ability to process events exactly-once.

### Topics

Events are organized and durably stored in `topics`. Very simplified, a topic is similar to a folder in a filesystem, and the events are the files in that folder. An example topic name could be "payments". Topics in Kafka are always `multi-producer` and `multi-subscriber`: a topic can have zero, one, or many producers that write events to it, as well as zero, one, or many consumers that subscribe to these events. Events in a topic can be read as often as needed—unlike traditional messaging systems, events are **not deleted** after consumption. Instead, **you define for how long Kafka should retain your events through a per-topic configuration setting**, after which old events will be discarded. Kafka's performance is effectively constant with respect to data size, so storing data for a long time is perfectly fine.

> A **topic** is similar to a folder in a filesystem, and the events are the files in that folder.

### Partitions

Topics are `partitioned`, meaning a topic is spread over a number of "buckets" located on different Kafka brokers. This distributed placement of your data is very important for scalability because it allows client applications to both read and write the data from/to many brokers at the same time. **When a new event is published to a topic, it is actually appended to one of the topic's partitions**.

> Events with the same event key (e.g., a customer or vehicle ID) are written to the same partition, and Kafka guarantees that any consumer of a given topic-partition will always read that partition's events in exactly the same order as they were written.

#### Understand partitions

> Everything in Kafka is modeled around partitions. They rule Kafka’s storage, scalability, replication, and message movement.

Everything in Kafka revolves around partitions. They play a crucial role in structuring Kafka’s storage and the production and consumption of messages.

Understanding partitions helps you learn Kafka faster. This article walks through the concepts, structure, and behavior of Kafka’s partitions.

#### Events, Streams, and Kafka Topics

-   Events
    -   An event represents a fact that happened in the past. Events are immutable and never stay in one place. They always travel from one system to another system, carrying the state changes that happened.
-   Streams
    -   An event stream represents related events in motion.
-   Topics
    -   When an event stream enters Kafka, it is persisted as a topic. In Kafka’s universe, a topic is a `materialized event stream`. In other words, a topic is a stream at rest.
        -   Topic groups related events together and durably stores them. The closest analogy for a Kafka topic is a table in a database or folder in a file system.
        -   Topics are the central concept in Kafka that decouples producers and consumers. A consumer pulls messages off of a Kafka topic while producers push messages into a Kafka topic. A topic can have many producers and many consumers.
        *   [![](https://bookstack.korben-gao.com/uploads/images/gallery/2022-09/scaled-1680-/image-1664448775436.png)](https://bookstack.korben-gao.com/uploads/images/gallery/2022-09/image-1664448775436.png)
-   Partitions
    -   Kafka’s `topics` are divided into several partitions. While the topic is a logical concept in Kafka, **a `partition` is the smallest storage unit that holds a subset of records owned by a topic**. Each partition is a single log file where records are written to it in an append-only fashion.
        -   [![](https://bookstack.korben-gao.com/uploads/images/gallery/2022-09/scaled-1680-/image-1664448895726.png)](https://bookstack.korben-gao.com/uploads/images/gallery/2022-09/image-1664448895726.png)
        *   When talking about the content inside a partition, I will use the terms `record` and `message` interchangeably.

#### Offsets and the ordering of messages

The records in the partitions are each assigned a sequential identifier called the `offset`, which is unique for each record within the partition.

**The `offset` is an incremental and immutable number, maintained by Kafka.** When a record is written to a partition, it is appended to the end of the log, assigning the next sequential offset. Offsets are particularly useful for consumers when reading records from a partition. We’ll come to that at a later point.

The figure below shows a topic with three partitions. Records are being appended to the end of each one.

[![](https://bookstack.korben-gao.com/uploads/images/gallery/2022-09/scaled-1680-/image-1664449239645.png)](https://bookstack.korben-gao.com/uploads/images/gallery/2022-09/image-1664449239645.png)

> Although the messages within a partition are ordered, messages across a topic are not guaranteed to be ordered.

## Partitions are the way that Kafka provides scalability

A Kafka cluster is made of one or more servers. In the Kafka universe, they are called Brokers. Each broker holds a subset of records that belongs to the entire cluster.

Kafka distributes the partitions of a particular topic across multiple brokers. By doing so, we’ll get the following benefits.

-   If we are to put all partitions of a topic in a single broker, the scalability of that topic will be constrained by the broker’s IO throughput. A topic will never get bigger than the biggest machine in the cluster. By spreading partitions across multiple brokers, a single topic can be scaled horizontally to provide performance far beyond a single broker’s ability.
-   A single topic can be consumed by multiple consumers in parallel. Serving all partitions from a single broker limits the number of consumers it can support. Partitions on multiple brokers enable more consumers.
-   Multiple instances of the same consumer can connect to partitions on different brokers, allowing very high message processing throughput. Each consumer instance will be served by one partition, ensuring that each record has a clear processing owner.

## Partitions are the way that Kafka provides redundancy

Kafka keeps more than one copy of the same partition across multiple brokers. This redundant copy is called a replica. If a broker fails, Kafka can still serve consumers with the replicas of partitions that failed broker owned.

Partition replication is complex, and it deserves its own post. Next time maybe?

## Writing records to partitions

How does a producer decide to which partition a record should go? There are three ways a producer can rule on that.

### Using a partition key to specify the partition

A producer can use a `partition key` to direct messages to a specific partition. A partition key can be any value that can be derived from the application context. A unique device ID or a user ID will make a good partition key.

By default, the partition key is passed through a hashing function, which creates the partition assignment. **That assures that all records produced with the same key will arrive at the same partition**. Specifying a partition key enables keeping related events together in the same partition and in the exact order in which they were sent.

[![](https://bookstack.korben-gao.com/uploads/images/gallery/2022-09/scaled-1680-/image-1664449978932.png)](https://bookstack.korben-gao.com/uploads/images/gallery/2022-09/image-1664449978932.png)

Key based partition assignment can lead to broker skew if keys aren’t well distributed.

For example, when customer ID is used as the partition key, and one customer generates 90% of traffic, then one partition will be getting 90% of the traffic most of the time. On small topics, this is negligible, on larger ones, it can sometime take a broker down.

When choosing a partition key, ensure that they are well distributed.

### Allowing Kafka to decide the partition

If a producer doesn’t specify a partition key when producing a record, Kafka will use a round-robin partition assignment. Those records will be written evenly across all partitions of a particular topic.

> However, if no partition key is used, the ordering of records can not be guaranteed within a given partition.

The key takeaway is to use a partition key to put related events together in the same partition in the exact order in which they were sent.

### Writing a custom partitioner

In some situations, a producer can use its own partitioner implementation that uses other business rules to do the partition assignment.

## Reading records from partitions

Unlike the other pub/sub implementations, Kafka doesn’t push messages to consumers. Instead, consumers have to pull messages off Kafka topic partitions. A consumer connects to a partition in a broker, reads the messages in the order in which they were written.

The `offset` of a message works as a consumer side cursor at this point. The consumer keeps track of which messages it has already consumed by keeping track of the offset of messages. After reading a message, the consumer advances its cursor to the next offset in the partition and continues. Advancing and remembering the last read offset within a partition is the responsibility of the consumer. Kafka has nothing to do with it.

By remembering the offset of the last consumed message for each partition, a consumer can join a partition at the point in time they choose and resume from there. That is particularly useful for a consumer to resume reading after recovering from a crash.

[![](https://bookstack.korben-gao.com/uploads/images/gallery/2022-09/scaled-1680-/image-1664450468794.png)](https://bookstack.korben-gao.com/uploads/images/gallery/2022-09/image-1664450468794.png)

A partition can be consumed by one or more consumers, each reading at different offsets.

Kafka has the concept of `consumer groups` where several consumers are grouped to consume a given topic. Consumers in the same consumer group are assigned the same group-id value.

The consumer group concept ensures that a message is only ever read by a single consumer in the group.

> When a consumer group consumes the partitions of a topic, Kafka makes sure that each partition is consumed by exactly one consumer in the group.

The following figure shows the above relationship.

[![](https://bookstack.korben-gao.com/uploads/images/gallery/2022-09/scaled-1680-/image-1664450569430.png)](https://bookstack.korben-gao.com/uploads/images/gallery/2022-09/image-1664450569430.png)

Consumer groups enable consumers to parallelize and process messages at very high throughputs. However, the maximum parallelism of a group will be equal to the number of partitions of that topic.

For example, if you have N + 1 consumers for a topic with N partitions, then the first N consumers will be assigned a partition, and the remaining consumer will be idle, unless one of the N consumers fails, then the waiting consumer will be assigned its partition. This is a good strategy to implement a hot failover.

The figure below illustrates this.

[![](https://bookstack.korben-gao.com/uploads/images/gallery/2022-09/scaled-1680-/image-1664450617659.png)](https://bookstack.korben-gao.com/uploads/images/gallery/2022-09/image-1664450617659.png)

The key takeaway is that number of consumers don’t govern the degree of parallelism of a topic. It’s the number of partitions.

#Dockerizing KafkaPlugin

The goal is be able to use the [KafkaPlugin](https://github.com/metadaddy/KafkaPlugin) created by [@metadady](https://github.com/metadaddy) to Visualize Apache log data in Minecraft with StreamSets Data Collector using docker.
This branch takes care of setting up Minecraft Spigot server along with Kafka and Zookeeper. It also includes a SCD container with the necessary libraries.

##Requirements:

* Docker
* Docker compose
* Minecraft client
* Minecraft account
* Add your Minecraft user's name to .env. See [example.env](example.env?raw=true)

##Instructions:

Once this repo has been cloned, open your command line and initialize the docker containers using: `$ docker-compose up`.
This can take a while, be aware Minecraft Spigot server can take a while.

Once the containers are up and running follow these steps:

**- Import the Kakfa producer [pipeline](minecraft-kafka-producer.json?raw=true) into SDC by going to http://localhost:18630**

You should see the following pipeline

[![producer](images/producer.png?raw=true)](images/producer.png)

You can Preview or Start the pipeline right away.

[![start-pipeline](images/preview-start-pipeline.png?raw=true)](images/preview-start-pipeline.png)

**- Load the KafkkaCraft plugin**

A [slightly modified version](minecraft/KafkaCraft.jar?raw=true) of the original plugin has been created for this repo, here is the [source](https://github.com/AngelAlvarado/KafkaPlugin).
Place it into ./minecraft/data/plugins and restart the Spigot server `$docker restart mc`.

**- Connect your Minecraft (client) to the local Spigot server**

[![minecraft-client](images/minecraft-client.png?raw=true)](images/minecraft-client.png)

**- Run the kafka command and you'll see a map rendering in front of you**

To render the map from scratch:
```
/kafka world log true kafka
```

To reuse a map already rendered:
```
/kafka world log false kafka
```

[![minecraft-client](images/world.png?raw=true)](images/world.png)

For more information regarding the parameters see the [yml](https://github.com/AngelAlvarado/KafkaPlugin/blob/master/plugin.yml) file or `/kafka help`.

**- Play some data into the Minecraft world**

Once the map has been rendered, the plugin will subscribe a Kafka consumer to the topic `log`.

Play some data from your command line using the script [readfile.sh](streamsets/data/apache-logs/readfile.sh)

```
$ cd ./streamsets/apache-logs
$ ./readfile.sh apache_to_read.log >> apache_access.log
```

A small Apache file have been included but you can use any.


- **Thanks** to [@metadady](https://github.com/metadaddy) for the great Minecraft plugin
and to [@eosrei](https://github.com/eosrei) for the advice on Docker.
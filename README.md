# redis2statsd

redis2statsd is a tool written in JavaScript, used to monitor Redis.


It uses Redis [INFO](http://redis.io/commands/info) command to collect data, and sends it to [StatsD](https://github.com/etsy/statsd/).
We chose StatsD because it's very flexible and can be plugged with Graphite, Librato or any other tool you choose to plot the graphs.

## Installation and Configuration
* Install node.js
* Clone the project
* Run npm install
* Adjust config.json file

## Running

```
usage: node lib/Redis2StatsD.js ["HOST:PORT" ...]

    --interval=INTERVAl         Redis consult interval
    --environment=ENVIRONMENT   Select config.json environment configuration

$node lib/Redis2StatsD.js localhost --interval=60
```

## Extension to original design
Inv-redis-repl-monitor is a redis replication monitoring service which runs in mesos.
The code for the service was forked from the original Redis2StatsD repo, and we added the mesos deployment code for ci-sf, prod-sc, and prod-ln, and custom metrics for monitoring replication lag.
The service collects stats from a set of redis instances using the redis info command, and emits the stats to statsd at regular intervals.
These stats are used for visualizing performance in grafana and may be used for generating uchiwa alerts if performance is not acceptable.

## Service deployment in mesos

```
git clone https://github.com/opentable/redis2statsd
cd redis2statsd
git checkout replication-monitor
docker build -t docker.otenv.com/inv-redis-repl-monitor:0.2 .
docker tag docker.otenv.com/inv-redis-repl-monitor:0.2 docker.otenv.com/inv-redis-repl-monitor:latest
docker push docker.otenv.com/inv-redis-repl-monitor
otpl-deploy -d inv-redis-repl-monitor prod-sc latest
otpl-deploy -d inv-redis-repl-monitor prod-ln latest
```





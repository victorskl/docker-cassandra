# docker-cassandra

```
docker compose up -d
docker compose ps
docker compose down

docker exec -it cassandra cqlsh
> help
> show host;
> source '/scripts/data.cql';
> describe keyspaces;
> describe tables;
> use store;
> desc tables;
> desc schema;
> select * from shopping_cart;
> exit

(alternatively)
docker exec -it cassandra cqlsh -f /scripts/data.cql
docker exec -it cassandra nodetool info
```

On Client CLI
```
python3 -m venv venv
source venv/bin/activate
pip install cqlsh

which cqlsh
cqlsh --help
cqlsh -f data.cql
cqlsh
> select * from store.shopping_cart;
> insert into store.shopping_cart (userid, item_count) VALUES ('4567', 20);
```

On IntelliJ
```
IntelliJ > Database > Add Data Source > Apache Cassandra
```

REF:
- https://hub.docker.com/_/cassandra
- https://pypi.org/project/cqlsh/
- https://cassandra.apache.org/doc/latest/cassandra/tools/cqlsh.html

## Cluster

Make sure to have enough resources allocated to your container runtime. Tested with 16GB, 12 cores.

```
docker compose -f docker-compose-cluster.yml up -d
docker compose -f docker-compose-cluster.yml ps
docker compose -f docker-compose-cluster.yml down

docker logs cas1 -f
docker logs cas2 -f
docker logs cas3 -f
```

```
docker exec -it cas1 nodetool status

    Datacenter: dc1
    ===============
    Status=Up/Down
    |/ State=Normal/Leaving/Joining/Moving
    --  Address     Load        Tokens  Owns (effective)  Host ID                               Rack
    UN  172.23.0.3  75.21 KiB   16      59.3%             86fb09a9-c987-4ce8-b96a-90ad7dd79cf2  rack1
    UN  172.23.0.4  109.23 KiB  16      76.0%             a14c7c45-064d-4a62-885d-f0223b0a40d9  rack1
    UN  172.23.0.2  109.38 KiB  16      64.7%             72b9fac8-c80e-4dec-9615-01ca14006d3c  rack1
```

```
docker exec -it cas1 nodetool status
docker exec -it cas1 nodetool ring
docker exec -it cas1 nodetool gossipinfo
docker exec -it cas1 nodetool describecluster
```

REF:
- https://cassandra.apache.org/doc/latest/cassandra/tools/nodetool/nodetool.html

### Testing the Cluster

- Populate test data using `cas1`
```
cqlsh -f data-cluster.cql

 id | first | last
----+-------+------
  1 |  John |  Doe

(1 rows)
```

- Query from `cas2` and `cas3`
```
docker exec -it cas2 cqlsh -e "select * from MyKeySpace.MyColumns;"

 id | first | last
----+-------+------
  1 |  John |  Doe

(1 rows)

docker exec -it cas3 cqlsh -e "select * from MyKeySpace.MyColumns;"

 id | first | last
----+-------+------
  1 |  John |  Doe

(1 rows)
```

## Data Modelling

DOC:
- https://cassandra.apache.org/doc/latest/cassandra/data_modeling/index.html
- https://cassandra.apache.org/doc/latest/cassandra/cql/index.html
- https://cassandra.apache.org/doc/latest/cassandra/cql/json.html

Column Family:
- https://www.google.com/search?q=cassandra+column+family
- https://www.baeldung.com/cassandra-column-family-data-model
- https://stackoverflow.com/questions/18824390/whats-the-difference-between-creating-a-table-and-creating-a-columnfamily-in-ca
- It is a 2-dimensional key-value store under the hood.
    ```
    "Employees" : {
               row1 : { "ID":1, "Last":"Cooper", "First":"James", "Age":32},
               row2 : { "ID":2, "Last":"Bell", "First":"Lisa", "Age":57, "Address":"Earth"},
               row3 : { "ID":3, "Last":"Young", "First":"Jospeh", "Age":45},
               ...
         }
    ```

### Example: Hotel app

Workout exercise: _Query-driven data modelling_ walkthrough https://cassandra.apache.org/doc/stable/cassandra/data_modeling/index.html

Pattern: [the wide partition pattern](https://cassandra.apache.org/doc/stable/cassandra/data_modeling/data_modeling_logical.html#patterns-and-anti-patterns)

```
cqlsh -f hotel.schema.hotel.cql
cqlsh -f hotel.schema.reservation.cql
```

```
cqlsh -e 'describe keyspaces'
cqlsh -e 'describe hotel'
cqlsh -e 'describe reservation'
```

```
cqlsh -f hotel.insert.cql
```

```
cqlsh -f hotel.select.cql
```

```
cqlsh -f hotel.drop.cql
```

## AWS
- https://aws.amazon.com/keyspaces/what-is-cassandra/
- https://docs.aws.amazon.com/keyspaces/latest/devguide/data-modeling.html

Keyspaces vs Cassandra:
- https://stackoverflow.com/questions/69102079/why-do-native-cql-functions-like-min-and-max-not-work-in-amazon-keyspaces

## Notes

For more serious production setup, see the followings.
- https://k8ssandra.io
- http://cassandra-reaper.io
- https://github.com/akka/akka-persistence-cassandra
- https://github.com/thelastpickle/cassandra-medusa

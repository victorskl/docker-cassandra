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
    --  Address       Load        Tokens  Owns (effective)  Host ID                               Rack
    UN  192.168.32.2  74.11 KiB   16      64.7%             1e539577-abcb-41b5-b769-1b4264bab74b  rack1
    UN  192.168.32.4  128.04 KiB  16      76.0%             502de358-809f-43f0-9560-b3ac7171aeaf  rack1
    UN  192.168.32.3  74.12 KiB   16      59.3%             aea74503-8ccf-4333-a522-3efee74d4cb9  rack1
```

REF:
- https://cassandra.apache.org/doc/latest/cassandra/tools/nodetool/nodetool.html

Testing:

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

### Data Modelling

DOC:
- https://cassandra.apache.org/doc/latest/cassandra/data_modeling/index.html
- https://cassandra.apache.org/doc/latest/cassandra/cql/index.html
- https://cassandra.apache.org/doc/latest/cassandra/cql/json.html

Column Family:
- https://www.google.com/search?q=cassandra+column+family
- https://www.baeldung.com/cassandra-column-family-data-model
- https://stackoverflow.com/questions/18824390/whats-the-difference-between-creating-a-table-and-creating-a-columnfamily-in-ca

### AWS
- https://aws.amazon.com/keyspaces/what-is-cassandra/
- https://docs.aws.amazon.com/keyspaces/latest/devguide/data-modeling.html

Keyspaces vs Cassandra:
- https://stackoverflow.com/questions/69102079/why-do-native-cql-functions-like-min-and-max-not-work-in-amazon-keyspaces

### Notes

Alternatively, see Bitnami distribution for more serious docker setup
- https://github.com/bitnami/bitnami-docker-cassandra

And the following on some production setup aspect
- https://k8ssandra.io
- http://cassandra-reaper.io
- https://github.com/thelastpickle/cassandra-medusa

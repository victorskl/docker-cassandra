-- https://en.wikipedia.org/wiki/Apache_Cassandra#Main_features
-- https://cassandra.apache.org/doc/latest/cassandra/cql/ddl.html

CREATE KEYSPACE IF NOT EXISTS MyKeySpace
            WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 3 };

USE MyKeySpace;

CREATE TABLE IF NOT EXISTS MyColumns
(
    id    text,
    Last  text,
    First text,
    PRIMARY KEY (id)
);

INSERT INTO MyColumns (id, Last, First)
VALUES ('1', 'Doe', 'John');

SELECT *
FROM MyColumns;

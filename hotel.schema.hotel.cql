-- Hotel application: query-driven data model
-- https://cassandra.apache.org/doc/stable/cassandra/data_modeling/data_modeling_schema.html

CREATE KEYSPACE hotel WITH replication =
    {'class': 'SimpleStrategy', 'replication_factor' : 3};

CREATE TYPE hotel.address
    (
        street            text,
        city              text,
        state_or_province text,
        postal_code       text,
        country           text
    );

CREATE TABLE hotel.hotels_by_poi
(
    poi_name text,
    hotel_id text,
    name     text,
    phone    text,
    address  frozen<address>,
    PRIMARY KEY ((poi_name), hotel_id)
)
    WITH comment = 'Q1. Find hotels near given poi'
     AND CLUSTERING ORDER BY (hotel_id ASC);

CREATE TABLE hotel.hotels
(
    id      text PRIMARY KEY,
    name    text,
    phone   text,
    address frozen<address>,
    pois    set<text>
)
            WITH comment = 'Q2. Find information about a hotel';

CREATE TABLE hotel.pois_by_hotel
(
    poi_name    text,
    hotel_id    text,
    description text,
    PRIMARY KEY ((hotel_id), poi_name)
)
            WITH comment = 'Q3. Find pois near a hotel';

CREATE TABLE hotel.available_rooms_by_hotel_date
(
    hotel_id     text,
    date         date,
    room_number  smallint,
    is_available boolean,
    PRIMARY KEY ((hotel_id), date, room_number)
)
            WITH comment = 'Q4. Find available rooms by hotel date';

CREATE TABLE hotel.amenities_by_room
(
    hotel_id     text,
    room_number  smallint,
    amenity_name text,
    description  text,
    PRIMARY KEY ((hotel_id, room_number), amenity_name)
)
            WITH comment = 'Q5. Find amenities for a room';

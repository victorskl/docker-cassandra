-- Hotel application: query-driven data model
-- https://cassandra.apache.org/doc/stable/cassandra/data_modeling/data_modeling_schema.html

CREATE KEYSPACE reservation WITH replication =
    {'class': 'SimpleStrategy', 'replication_factor' : 3};

CREATE TYPE reservation.address
    (
        street            text,
        city              text,
        state_or_province text,
        postal_code       text,
        country           text
    );

CREATE TABLE reservation.reservations_by_confirmation
(
    confirm_number text,
    hotel_id       text,
    start_date     date,
    end_date       date,
    room_number    smallint,
    guest_id       uuid,
    PRIMARY KEY (confirm_number)
)
            WITH comment = 'Q6. Find reservations by confirmation number';

CREATE TABLE reservation.reservations_by_hotel_date
(
    hotel_id       text,
    start_date     date,
    end_date       date,
    room_number    smallint,
    confirm_number text,
    guest_id       uuid,
    PRIMARY KEY ((hotel_id, start_date), room_number)
)
            WITH comment = 'Q7. Find reservations by hotel and date';

CREATE TABLE reservation.reservations_by_guest
(
    guest_last_name text,
    hotel_id        text,
    start_date      date,
    end_date        date,
    room_number     smallint,
    confirm_number  text,
    guest_id        uuid,
    PRIMARY KEY ((guest_last_name), hotel_id)
)
            WITH comment = 'Q8. Find reservations by guest name';

CREATE TABLE reservation.guests
(
    guest_id      uuid PRIMARY KEY,
    first_name    text,
    last_name     text,
    title         text,
    emails        set<text>,
    phone_numbers list<text>,
    addresses     map<text, frozen<address>>,
    confirm_number text
)
            WITH comment = 'Q9. Find guest by ID';

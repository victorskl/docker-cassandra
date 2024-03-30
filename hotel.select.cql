-- Q1. Find hotels near given poi
SELECT * FROM hotel.hotels_by_poi;
SELECT * FROM hotel.hotels_by_poi WHERE poi_name = 'hyatt hotel';

-- Q2. Find information about a hotel
SELECT * FROM hotel.hotels;
SELECT * FROM hotel.hotels WHERE id = 'H0001';

-- Q3. Find pois near a hotel
SELECT * FROM hotel.pois_by_hotel;
SELECT * FROM hotel.pois_by_hotel WHERE hotel_id = 'H0001';

-- Q4. Find available rooms by hotel date
SELECT * FROM hotel.available_rooms_by_hotel_date;
SELECT * FROM hotel.available_rooms_by_hotel_date WHERE hotel_id = 'H0001';

-- Q5. Find amenities for a room
SELECT * FROM hotel.amenities_by_room;
SELECT * FROM hotel.amenities_by_room WHERE hotel_id = 'H0001' AND room_number = 1255;

-- Q6. Find reservations by confirmation number
SELECT * FROM reservation.reservations_by_confirmation;
SELECT * FROM reservation.reservations_by_confirmation WHERE confirm_number = 'C24000001';

-- Q7. Find reservations by hotel and date
SELECT * FROM reservation.reservations_by_hotel_date;
SELECT * FROM reservation.reservations_by_hotel_date WHERE hotel_id = 'H0001' and start_date = '2024-04-01';

-- Q8. Find reservations by guest name
SELECT * FROM reservation.reservations_by_guest;
SELECT * FROM reservation.reservations_by_guest WHERE guest_last_name = 'Jane';

-- Q9. Find guest by ID
SELECT * FROM reservation.guests;
SELECT * FROM reservation.guests WHERE guest_id = 2dc30820-f58a-4b59-aa1a-4e29ded4e31c;

-- -- --
-- Typically, it should only filter predicate (WHERE clause) by PRIMARY KEY (i.e. partition key).
-- An example query that has not designed to perform. Therefore, it involves (late) data filtering and, may have
-- unpredictable performance as it misses the partition key. Using `ALLOW FILTERING` to explicitly allowing it
-- for ad-hoc dev purpose.

-- SELECT * FROM reservation.guests WHERE confirm_number = 'C24000001';
SELECT * FROM reservation.guests WHERE confirm_number = 'C24000001' ALLOW FILTERING;

-- However, in this case, this is covered by the query route through `reservations_by_confirmation` table.
-- i.e.
-- first,
--      SELECT * FROM reservation.reservations_by_confirmation WHERE confirm_number = 'C24000001';
-- then,
--      SELECT * FROM reservation.guests WHERE guest_id = 2dc30820-f58a-4b59-aa1a-4e29ded4e31c;
-- -- --

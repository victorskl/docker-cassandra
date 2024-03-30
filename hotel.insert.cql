-- keyspace: hotel
INSERT INTO hotel.hotels_by_poi(poi_name, hotel_id, address, name, phone) VALUES ('hyatt hotel', 'H0001', {street: 'Hyatt Street', city: 'Mel', state_or_province: 'Vic', postal_code: '3000', country: 'Au'}, 'Hyatt', '65898891');
INSERT INTO hotel.hotels(id, address, name, phone, pois) VALUES ('H0001', {street: 'Hyatt Street', city: 'Mel', state_or_province: 'Vic', postal_code: '3000', country: 'Au'}, 'Hyatt', '65898891', {'hyatt hotel'});
INSERT INTO hotel.hotels(id, address, name, phone, pois) VALUES ('H0002', {street: 'George Street', city: 'Mel', state_or_province: 'Vic', postal_code: '3001', country: 'Au'}, 'ibis', '65251291', {'ibis hotel'});
INSERT INTO hotel.hotels(id, address, name, phone, pois) VALUES ('H0003', {street: 'Broad Street', city: 'Mel', state_or_province: 'Vic', postal_code: '3002', country: 'Au'}, 'Queen', '65558221', {'queen hotel'});
INSERT INTO hotel.pois_by_hotel(hotel_id, poi_name, description) VALUES ('H0001', 'hyatt hotel', 'Hyatt Hotel in Melbourne City');
INSERT INTO hotel.available_rooms_by_hotel_date(hotel_id, date, room_number, is_available) VALUES ('H0001', '2024-04-04', 1255, true);
INSERT INTO hotel.available_rooms_by_hotel_date(hotel_id, date, room_number, is_available) VALUES ('H0001', '2024-04-04', 1265, true);
INSERT INTO hotel.available_rooms_by_hotel_date(hotel_id, date, room_number, is_available) VALUES ('H0001', '2024-06-04', 1255, true);
INSERT INTO hotel.amenities_by_room(hotel_id, room_number, amenity_name, description) VALUES ('H0001', 1255, 'Gym', 'Fully facilitated gym');

-- keyspace: reservation
INSERT INTO reservation.reservations_by_confirmation(confirm_number, end_date, guest_id, hotel_id, room_number, start_date) VALUES ('C24000001', '2024-05-06', 2dc30820-f58a-4b59-aa1a-4e29ded4e31c, 'H0001', 1255, '2024-05-01');
INSERT INTO reservation.reservations_by_guest(guest_last_name, hotel_id, confirm_number, end_date, guest_id, room_number, start_date) VALUES ('Jane', 'H0001', 'C24000001', '2024-05-06', 2dc30820-f58a-4b59-aa1a-4e29ded4e31c, 1255, '2024-05-01');
INSERT INTO reservation.reservations_by_hotel_date(hotel_id, start_date, room_number, confirm_number, end_date, guest_id) VALUES ('H0001', '2024-05-01', 1255, 'C24000001', '2024-05-06', 2dc30820-f58a-4b59-aa1a-4e29ded4e31c);
INSERT INTO reservation.guests(guest_id, addresses, confirm_number, emails, first_name, last_name, phone_numbers, title) VALUES (2dc30820-f58a-4b59-aa1a-4e29ded4e31c, {'home': {street: 'Main Drive', city: 'Mel', state_or_province: 'Vic', postal_code: '3011', country: 'Au'}}, 'C24000001', {'jane@maindrive.co'}, 'Jessy', 'Jane', ['0355698752'], 'Ms');

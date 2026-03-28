use travel_agency_2025;

-- Procedure 1
-- select * from trip join driver on trip.tr_drv_AT = driver.drv_AT where tr_id=1;
-- select * from vehicle where v_id=3;
-- select * from trip where tr_v_id=3;
-- call attribute_vehicle_to_trip(1, 3, 4000);
-- select * from vehicle where v_id=3;
-- select * from trip where tr_v_id=3;

-- Procedure 2
-- select * from accomodation where acc_dst_id=1;
-- select * from destination where dst_id=1;
-- select * from trip where tr_id=2;
-- set @acc = 0;
-- call search_accomodations(1, '2014-05-30 12:44:14', '2014-07-30 12:44:14', 32, @acc);
-- select @acc;
-- update vehicle set v_brand='Volvo' where v_id=1;
-- select * from log;
-- Procedure 4
-- delete indexes if exist
-- drop index income_departure_index on trip_history;
-- drop index destination_index on trip_history;
-- indexes
-- create index income_departure_index
-- on trip_history (tr_h_departure, tr_h_return, tr_h_income);
-- create index destination_index
-- on trip_history (tr_h_dst_count, tr_h_departure, tr_h_return);
-- A
-- call search_history_income('2024-01-01 08:00:00', '2024-01-03 08:00:00');
-- B
-- call search_history_destination(6);

-- Trigger 2
-- select * from accomodation_trip_reservation;
-- select acc_room_value from accomodation where acc_id=1;
-- select to_departure, to_arrival from travel_to where to_tr_id=1 and to_dst_id=1;
-- select res_seatnum from reservation where res_tr_id=1 and res_status="PAID";
-- insert into accomodation_trip_reservation values (1, 1, 1, null, null);
-- select * from accomodation_trip_reservation;

-- Trigger 3
-- select * from vehicle where v_id=2;
-- select * from trip where tr_v_id=2;
-- update trip set tr_status="COMPLETED" where tr_id=1;
-- select * from vehicle where v_id=2;

-- Extra
-- select * from trip where tr_departure="2014-02-14 15:45:43";
-- update trip set tr_status="COMPLETED" where tr_id=5;
-- select * from trip_history where tr_h_departure="2014-02-14 15:45:43";
use travel_agency_2025;
-- ------------------ 1 -------------------------
drop procedure if exists attribute_vehicle_to_trip;
delimiter $
create procedure attribute_vehicle_to_trip(tri_id int(11),veh_id int(11),veh_km int(9))
begin
-- declarations
declare tri_start datetime;
declare tri_end datetime;
declare it_tri_start datetime;
declare it_tri_end datetime;
declare driv_lsc enum('A', 'B', 'C', 'D');
declare num_participants tinyint(4);
declare veh_seats tinyint(4);
declare veh_state enum('AVAILABLE', 'IN USE', 'IN MAINTENANCE');
declare veh_type enum('BUS', 'SMALL BUS', 'VAN', 'CAR');
declare can_update boolean;
declare finished_dates boolean;
-- cursor for date checking
declare trdate_cursor cursor for 
select tr_departure, tr_return from trip where tr_v_id=veh_id;
declare continue handler for not found set finished_dates=true;
-- selections & sets
select tr_departure, tr_return into tri_start, tri_end from trip where tr_id=tri_id;
select drv_liscense into driv_lsc from trip join driver on trip.tr_drv_AT=driver.drv_AT where tr_id=tri_id;
-- we accept that we only care about valid reservations, so we exclude cancelled or pending ones (pending can become 'confirmed', but it isn't yet, so it is not taken into consideration yet)
select sum(res_seatnum) into num_participants from reservation where res_tr_id=tri_id and res_status!='CANCELLED' and res_status!='PENDING';
select v_max_seats, v_state, v_type into veh_seats, veh_state, veh_type from vehicle where v_id=veh_id;
set can_update = true;
-- we accept that this vehicle isn't already assigned to this trip, otherwise there is no reason to call this procedure
-- conditions
-- condition 1: veh_seats>=reservations
if (veh_seats < num_participants) then set can_update = false;
select "Not enough seats for all participants" as "Condition I";
else select "Vehicle has enough seats for all participants" as "Condition I";
end if;
-- condition 2: veh_status=available
if (veh_state != 'AVAILABLE') then set can_update = false;
select "Vehicle not available" as "Condition II";
else select "Vehicle available" as "Condition II";
end if;
-- condition 3: driver liscense compatible with vehicle
-- A (motorbike), C (truck) not needed here, B -> Car, Van, D -> everything in this project
if (driv_lsc = 'A' or driv_lsc = 'C') then set can_update = false;
select "Driver has no liscense for this vehicle type" as "Condition III";
elseif (driv_lsc = 'B' and (veh_type = 'BUS' or veh_type = 'SMALL BUS')) then set can_update = false;
select "Driver has no liscense for this vehicle type" as "Condition III";
else select "Driver has the right liscense to drive this vehicle" as "Condition III";
end if;
-- condition 4: vehicle isn't in overlapping trips
-- let's just note here that, based on the project description, if a vehicle passes all the tests, it becomes 'IN USE', so if I assign vehicle 1 to trip 1, then the vehicle is in use, and I cannot assign it again to trip 2, even if there is no date overlap
-- this means that this specific check is never used by the code, and if it *should* be used, then there must be a change in how the vehicle state is handled by the code (for example, set a trigger that will render this vehicle 'IN USE' only one day before the trip, or on the day of the trip itself)
-- since this was not asked of us, we are not sure if there may be time for it, but we believe that this *is* the best approach for this problem
-- (otherwise, there could be a state called 'ASSIGNED TO TRIP' and in our procedure, Condition II can allow for both states 'AVAILABLE' and 'ASSIGNED TO TRIP', so long as Condition IV holds true
if (select count(tr_id) from trip where tr_v_id = veh_id) = 0 then
select "Vehicle has no other trips, so there is no overlap" as "Condition IV";
else
open trdate_cursor;
set finished_dates = false;
repeat
fetch trdate_cursor into it_tri_start, it_tri_end;
if not finished_dates then
if (it_tri_end < tri_start or it_tri_start > tri_end) then
select "This trip does not overlap with other trips this vehicle participates in" as "Condition IV";
else set can_update = false;
select "Trip overlaps with other trips this vehicle participates in" as "Condition IV";
set finished_dates = true;
end if;
end if;
until (finished_dates)
end repeat;
close trdate_cursor;
end if;
-- end result and table updates
if not can_update then
update vehicle set v_kilometers = veh_km where v_id = veh_id;
select "This vehicle didn't pass the tests, cannot be assigned to this trip" as "Final Message";
else update vehicle set v_kilometers = veh_km, v_state = "IN USE" where v_id = veh_id;
update trip set tr_v_id = veh_id where tr_id = tri_id;
select "This vehicle passed all the tests and was assigned to this trip" as "Final Message";
end if;
end$
delimiter ;

-- Condition I fails
-- select * from trip join driver on trip.tr_drv_AT=driver.drv_AT where tr_id=4;
-- select * from trip where tr_id=1;
-- select * from vehicle where v_id=3;
-- CALL attribute_vehicle_to_trip(1, 3, 46000);
-- select * from trip where tr_id=1;

-- ------------------------------------ 2 -----------------------------------------------
drop procedure if exists search_accomodations;
delimiter $
create procedure search_accomodations(in dest_id int(11), in dest_arr date, in dest_dep date, in room_num tinyint(4), out reserved_acc int(11))
begin
-- declarations
declare remaining_rooms tinyint(4);
-- from from travel_to with to_dst_id = dest_id join trip
declare trip_maxseats tinyint(4);
-- from accomodation
declare accom_id int(11);
declare accom_maxseats tinyint(4);
-- cursor (for iteration of the accomodations table, to see which ids are valid for our filters)
-- we put 3/4 of our filters in the cursor 'select' statement (where 1. state=ACTIVE, 2. acc in the given destination, 3. acc_max_rooms >= room_num (no point in looking at other accomodation reservations if the accomodation couldn't house all our clients anyway) and 4. if there exists another trip reservation for this accomodation, make sure that there are enough rooms left for this trip too
declare acc_c_done boolean;
declare acc_c cursor for
select acc_id, acc_max_rooms from accomodation
where acc_state = 'ACTIVE' and acc_dst_id = dest_id and not (acc_max_rooms < room_num);
declare continue handler for not found set acc_c_done = true;
-- we need a temporary table because the filters we'll use will be too complex to do in just one statement (we'd like to use a cursor, probably)
-- we only need to store the ids that are valid for our filters, then use it as a filter to get data from our accomodations table (and from our accomodations_benefits table)
drop table if exists selected_accomodations;
create table selected_accomodations (
	sacc_id int(11) not null,
    sacc_remaining_rooms tinyint(4) not null
) engine=InnoDB;
-- start the loop
open acc_c;
set acc_c_done = false;
repeat
fetch acc_c into accom_id, accom_maxseats;
-- we use ifnull, because when we didn't, we got null, so the if statement bellow returned false and no table was shown, nor did we return an output variable
select ifnull(sum(tr_maxseats), 0) into trip_maxseats from accomodation_trip_reservation
join trip on accomodation_trip_reservation.atr_tr_id=trip.tr_id
join travel_to on accomodation_trip_reservation.atr_tr_id=travel_to.to_tr_id
where atr_dst_id=dest_id and atr_acc_id=accom_id and (date(to_arrival)>dest_dep or date(to_departure)<dest_arr);
-- check if the remaining rooms are enough (total rooms - rooms from other trips >= rooms we want)
set remaining_rooms = accom_maxseats - trip_maxseats;
if not (room_num > remaining_rooms) then insert into selected_accomodations values (accom_id, remaining_rooms);
end if;
until (acc_c_done)
end repeat;
close acc_c;
-- show the final table
select acc_name as "Name",
acc_type as "Type",
concat(acc_street, acc_str_num, acc_city, acc_TK) as "Address",
acc_phone as "Phone",
acc_stars as "Stars",
acc_rev as "Reviews",
acc_room_value as "Value (Per Room)",
group_concat(ben_type) as "Benefits",
remaining_rooms as "Remaining Rooms"
from accomodation
inner join selected_accomodations on accomodation.acc_id = selected_accomodations.sacc_id
left join accomodation_benefits on accomodation_benefits.ben_acc_id = accomodation.acc_id
group by accomodation.acc_id
order by acc_room_value asc, acc_stars desc, acc_rev desc;
-- return the output variable (using limit 1 to select only the first row)
select acc_id into reserved_acc
from accomodation
inner join selected_accomodations on accomodation.acc_id = selected_accomodations.sacc_id
left join accomodation_benefits on accomodation_benefits.ben_acc_id = accomodation.acc_id
group by accomodation.acc_id
order by acc_room_value asc, acc_stars desc, acc_rev desc
limit 1;
end$
delimiter ;
-- select * from accomodation;
-- set @acc=0;
-- call search_accomodations(1, '2014-05-30 12:44:14', '2014-07-30 12:44:14', 32, @acc);
-- select @acc;

-- -------------------------------------------------------------------------------------

-- delete indexes if exist
-- drop index income_departure_index on trip_history;
-- drop index destination_index on trip_history;
-- indexes
create index income_departure_index
on trip_history (tr_h_departure, tr_h_return, tr_h_income);
create index destination_index
on trip_history (tr_h_dst_count, tr_h_departure, tr_h_return);

drop procedure if exists search_history_income;
delimiter $
create procedure search_history_income(in start_d datetime, in end_d datetime)
begin
select sum(tr_h_income) as 'Total Income' from trip_history where tr_h_departure>=start_d and tr_h_return<=end_d;
end$
-- call search_history_income('2024-01-01 08:00:00', '2024-01-03 08:00:00')$

drop procedure if exists search_history_destination$
create procedure search_history_destination(in total_dst tinyint(8))
begin
select tr_h_departure as 'Departure', tr_h_return as 'Return' from trip_history where tr_h_dst_count=total_dst;
end$
-- call search_history_destination(6)$
delimiter ;
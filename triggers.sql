use travel_agency_2025;
delimiter $
-- trip
drop trigger if exists update_log_trip$
create trigger update_log_trip
after insert on trip
for each row
begin
-- check if user() exists in the dba table (else insert it, using now() to get current time)
if (select count(*) from database_administrator where dba_username=user()) = 0 then
	insert into database_administrator values (user(), now(), null);
end if;
-- insert data
insert into log values (null, current_date(), current_time(), user(), "TRIP");
end$

drop trigger if exists update_log_trip_u$
create trigger update_log_trip_u
after update on trip
for each row
begin
if (select count(*) from database_administrator where dba_username=user()) = 0 then
	insert into database_administrator values (user(), now(), null);
end if;
insert into log values (null, current_date(), current_time(), user(), "TRIP");
end$

-- reservation
drop trigger if exists update_log_reservation$
create trigger update_log_reservation
after insert on reservation
for each row
begin
if (select count(*) from database_administrator where dba_username=user()) = 0 then
	insert into database_administrator values (user(), now(), null);
end if;
insert into log values (null, current_date(), current_time(), user(), "RESERVATION");
end$

drop trigger if exists update_log_reservation_u$
create trigger update_log_reservation_u
after update on reservation
for each row
begin
if (select count(*) from database_administrator where dba_username=user()) = 0 then
	insert into database_administrator values (user(), now(), null);
end if;
insert into log values (null, current_date(), current_time(), user(), "RESERVATION");
end$

-- customers
drop trigger if exists update_log_customer$
create trigger update_log_customer
after insert on customer
for each row
begin
if (select count(*) from database_administrator where dba_username=user()) = 0 then
	insert into database_administrator values (user(), now(), null);
end if;
insert into log values (null, current_date(), current_time(), user(), "CUSTOMER");
end$

drop trigger if exists update_log_customer_u$
create trigger update_log_customer_u
after update on customer
for each row
begin
if (select count(*) from database_administrator where dba_username=user()) = 0 then
	insert into database_administrator values (user(), now(), null);
end if;
insert into log values (null, current_date(), current_time(), user(), "CUSTOMER");
end$

-- destination
drop trigger if exists update_log_destination$
create trigger update_log_destination
after insert on destination
for each row
begin
if (select count(*) from database_administrator where dba_username=user()) = 0 then
	insert into database_administrator values (user(), now(), null);
end if;
insert into log values (null, current_date(), current_time(), user(), "DESTINATION");
end$

drop trigger if exists update_log_destination_u$
create trigger update_log_destination_u
after update on destination
for each row
begin
if (select count(*) from database_administrator where dba_username=user()) = 0 then
	insert into database_administrator values (user(), now(), null);
end if;
insert into log values (null, current_date(), current_time(), user(), "DESTINATION");
end$

-- vehicle
drop trigger if exists update_log_vehicle$
create trigger update_log_vehicle
after insert on vehicle
for each row
begin
if (select count(*) from database_administrator where dba_username=user()) = 0 then
	insert into database_administrator values (user(), now(), null);
end if;
insert into log values (null, current_date(), current_time(), user(), "VEHICLE");
end$

drop trigger if exists update_log_vehicle_u$
create trigger update_log_vehicle_u
after update on vehicle
for each row
begin
if (select count(*) from database_administrator where dba_username=user()) = 0 then
	insert into database_administrator values (user(), now(), null);
end if;
insert into log values (null, current_date(), current_time(), user(), "VEHICLE");
end$

-- accomodation
drop trigger if exists update_log_accomodation$
create trigger update_log_accomodation
after insert on accomodation
for each row
begin
if (select count(*) from database_administrator where dba_username=user()) = 0 then
	insert into database_administrator values (user(), now(), null);
end if;
insert into log values (null, current_date(), current_time(), user(), "ACCOMODATION");
end$

drop trigger if exists update_log_accomodation_u$
create trigger update_log_accomodation_u
after update on accomodation
for each row
begin
if (select count(*) from database_administrator where dba_username=user()) = 0 then
	insert into database_administrator values (user(), now(), null);
end if;
insert into log values (null, current_date(), current_time(), user(), "ACCOMODATION");
end$

-- accomodation reservation
drop trigger if exists update_log_acc_res$
create trigger update_log_acc_res
after insert on accomodation_trip_reservation
for each row
begin
if (select count(*) from database_administrator where dba_username=user()) = 0 then
	insert into database_administrator values (user(), now(), null);
end if;
insert into log values (null, current_date(), current_time(), user(), "ACCOMODATION RESERVATION");
end$

drop trigger if exists update_log_acc_res_u$
create trigger update_log_acc_res_u
after update on accomodation_trip_reservation
for each row
begin
if (select count(*) from database_administrator where dba_username=user()) = 0 then
	insert into database_administrator values (user(), now(), null);
end if;
insert into log values (null, current_date(), current_time(), user(), "ACCOMODATION RESERVATION");
end$



-- ----------------------------------------------------------------------

drop trigger if exists calculate_cost_of_res$
-- we use before to update the current row with 'set new.attribute=...'
create trigger calculate_cost_of_res
before insert on accomodation_trip_reservation
for each row
begin
-- declarations
-- we mainly need cost and nights, the other two are needed to calculate the cost
declare cost decimal(10,2);
declare nights tinyint(2);
declare participants tinyint(4);
declare cost_night decimal(10,2);
-- if a trip is cancelled or an accomodation is inactive, there is no point calculating costs
if (select tr_status from trip where tr_id=new.atr_tr_id)!= "CANCELLED" and (select acc_state from accomodation where acc_id=new.atr_acc_id) = "ACTIVE" then
select acc_room_value into cost_night from accomodation where acc_id=new.atr_acc_id;
select datediff(to_departure, to_arrival) into nights from travel_to where to_tr_id=new.atr_tr_id and to_dst_id=new.atr_dst_id;
select sum(res_seatnum) into participants from reservation where res_tr_id=new.atr_tr_id and res_status="PAID";
-- given that each room holds two participants (we accept that each room is filled) the cost is per room per night
select ceil(participants/2)*cost_night into cost;
-- update current row
set new.acc_res_cost = cost, new.acc_res_total_nights = nights;
end if;
end$
-- select * from accomodation_trip_reservation$
-- select acc_room_value from accomodation where acc_id=1$
-- select to_departure, to_arrival from travel_to where to_tr_id=1 and to_dst_id=1$
-- select res_seatnum from reservation where res_tr_id=1 and res_status="PAID"$
-- insert into accomodation_trip_reservation values (1, 1, 1, null, null)$
-- select * from accomodation_trip_reservation$

-- ---------------------------------------------------------------------------------------------------



drop trigger if exists end_trip$
create trigger end_trip
before update on trip
for each row
begin
-- declarations
declare veh int(11);
declare km int(9);
-- check if the change was in the status and if the trip is completed
-- if yes, then get the values of the trip distance and vehicle used
if (old.tr_status != new.tr_status) and (new.tr_status = "COMPLETED") then
select new.tr_v_id, new.tr_km into veh, km;
-- then, update the respective vehicle row with the data
update vehicle set v_state = "AVAILABLE", v_kilometers = v_kilometers + ifnull(km,0) where v_id=veh;
end if;
end$

-- select * from vehicle where v_id=2$
-- select * from trip where tr_v_id=2$
-- update trip set tr_status="COMPLETED" where tr_id=1$
-- select * from vehicle where v_id=2$



-- ----------------------------------------------------------------------

drop trigger if exists insert_into_history$
create trigger insert_into_history
before update on trip
for each row
begin
declare dep datetime;
declare ret datetime;
declare tot_dst tinyint(2);
declare par tinyint(4);
declare inc decimal(10,2);
if (old.tr_status != new.tr_status) and (new.tr_status = "COMPLETED") then
select new.tr_departure, new.tr_return into dep, ret;
select count(distinct to_dst_id) into tot_dst from travel_to where to_tr_id=new.tr_id;
select sum(res_seatnum), sum(res_total_cost) into par, inc from reservation where res_status="PAID" and res_tr_id=new.tr_id;
insert into trip_history values (null, dep, ret, tot_dst, par, inc);
end if;
end$
delimiter ;
-- select * from trip where tr_departure="2014-02-14 15:45:43";
-- update trip set tr_status="COMPLETED" where tr_id=5;
-- select * from trip_history where tr_h_departure="2014-02-14 15:45:43";
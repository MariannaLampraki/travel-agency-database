drop database if exists travel_agency_2025;
create database travel_agency_2025;
use travel_agency_2025;

create table branch (
    br_code int(11) auto_increment not null,
    br_street varchar(50) not null default 0,
    br_num int(4) not null default 0,
    br_city varchar(30) not null default 'unknown', 
    br_manager_AT char(10) default 'unknown',
    primary key (br_code)
) engine=InnoDB;

create table worker (
    wrk_AT char(10) not null,
    wrk_name varchar(30) not null default 'unknown',
    wrk_lname varchar(30) not null default 'unknown',
    wrk_email varchar(100) not null default 'unknown',
    wrk_salary decimal(10,2) not null default 0.0,
    wrk_br_code int(11) default 0,
    primary key (wrk_AT),
    constraint works_in foreign key (wrk_br_code) references branch (br_code)
    on delete cascade on update cascade
) engine=InnoDB;

create table admin (
    adm_AT char(10) not null,
    adm_type enum('LOGISTICS', 'ADMINISTRATIVE', 'ACCOUNTING') not null default 'ADMINISTRATIVE',
    adm_diploma varchar(200) not null default 'unknown',
    primary key (adm_AT),
    constraint worker_admin_info foreign key (adm_AT) references worker (wrk_AT)
    on delete cascade on update cascade
) engine=InnoDB;

alter table branch add constraint managed_by foreign key (br_manager_AT) references admin (adm_AT)
on delete cascade on update cascade;

create table driver (
    drv_AT char(10) not null,
    drv_liscense enum('A', 'B', 'C', 'D') not null default 'A',
    drv_route enum('LOCAL', 'ABROAD') not null default 'LOCAL',
    drv_experience tinyint(4) not null default 0,
    primary key (drv_AT),
    constraint worker_driver_info foreign key (drv_AT) references worker (wrk_AT)
    on delete cascade on update cascade
) engine=InnoDB;

create table guide (
    gui_AT char(10) not null,
    gui_cv text,
    primary key (gui_AT),
    constraint worker_guide_info foreign key (gui_AT) references worker (wrk_AT)
    on delete cascade on update cascade
) engine=InnoDB;

create table language_ref (
    lang_code varchar(5) not null default '-',
    lang_name varchar(50) not null default 'unknown',
    primary key (lang_code)
) engine=InnoDB;

create table languages (
    lng_gui_AT char(10),
    lng_language_code varchar(10),
    primary key (lng_gui_AT, lng_language_code),
    constraint language_reference foreign key (lng_language_code) references language_ref(lang_code)
    on delete cascade on update cascade,
    constraint known_by foreign key (lng_gui_AT) references guide (gui_AT)
    on delete cascade on update cascade
) engine=InnoDB;

create table manages (
    mng_adm_AT char(10) not null,
    mng_br_code int(11) not null,
    primary key (mng_adm_AT, mng_br_code),
    constraint manager foreign key (mng_adm_AT) references admin (adm_AT)
    on delete cascade on update cascade,
    constraint branch foreign key (mng_br_code) references branch (br_code)
    on delete cascade on update cascade
) engine=InnoDB;

 create table vehicle (
	v_id int(11) auto_increment,
    v_br_code int(11) null,
    v_brand varchar(50) not null default 'unknown',
    v_model varchar(50) not null default 'unknown',
    v_pl_num varchar(10) not null default 'unknown',
    v_max_seats tinyint(4) not null default 0,
    v_type enum('BUS', 'SMALL BUS', 'VAN', 'CAR') not null default 'CAR',
    v_state enum('AVAILABLE', 'IN USE', 'IN MAINTENANCE') not null default 'AVAILABLE',
    v_kilometers int(9) unsigned not null default 0,
    primary key (v_id),
    constraint vehicle_belongs_to_branch foreign key (v_br_code) references branch (br_code)
    on delete cascade on update cascade
 ) engine=InnoDB;
 
create table trip (
    tr_id int(11) auto_increment,
    tr_departure datetime not null default '2000-01-01 00:00:00',
    tr_return datetime not null default '2000-01-01 00:00:00', 
    tr_maxseats tinyint(4) not null default 0.0,
    tr_cost_adult decimal(10,2) not null default 0.0, 
    tr_cost_child decimal(10,2) not null default 0.0, 
    tr_status enum('PLANNED', 'CONFIRMED', 'ACTIVE', 'COMPLETED', 'CANCELLED') default 'PLANNED',
    tr_min_participants tinyint(4) not null default 0,
    tr_br_code int(11) null,
    tr_gui_AT char(10) null,
    tr_drv_AT char(10) null,
    tr_v_id int(11) null,
    tr_km int(9) null,
    primary key (tr_id),
    constraint organized_by foreign key (tr_br_code) references branch (br_code)
    on delete cascade on update cascade,
    constraint driven_by foreign key (tr_drv_AT) references driver (drv_AT)
    on delete cascade on update cascade,
    constraint guided_by foreign key (tr_gui_AT) references guide (gui_AT)
    on delete cascade on update cascade
) engine=InnoDB;

create table phones (
    ph_br_code int(11) not null,
    ph_number varchar(15) not null default 'unknown',
    primary key (ph_br_code, ph_number),
    constraint belongs_to_branch foreign key (ph_br_code) references branch(br_code)
    on delete cascade on update cascade
) engine=InnoDB;

create table event (
    ev_tr_id int(11) not null,
    ev_start datetime not null default '2000-01-01 00:00:00', 
    ev_end datetime not null default '2000-01-01 00:00:00',
    ev_descr text,
    primary key (ev_tr_id, ev_start),
    constraint belongs_in_trip foreign key (ev_tr_id) references trip (tr_id)
    on delete cascade on update cascade
) engine=InnoDB;

create table customer (
    cust_id int(11) auto_increment not null,
    cust_name varchar(30) not null default 'unknown',
    cust_lname varchar(30) not null default 'unknown',
    cust_email varchar(100) not null default 'unknown',
    cust_phone varchar(15) not null default 'unknown',
    cust_address text not null,
    cust_birth_date date not null default '2000-01-01',
    primary key (cust_id)
) engine=InnoDB;

create table destination (
    dst_id int(11) auto_increment,
    dst_name varchar(100) not null default 'unknown',
    dst_descr text,
    dst_type enum('LOCAL', 'ABROAD') not null default 'LOCAL',
    dst_language_code varchar(5) null,
    dst_location int(11) null,
    primary key (dst_id),
    constraint joanna foreign key (dst_location) references destination (dst_id)
    on delete cascade on update cascade,
    constraint marianna foreign key (dst_language_code) references language_ref(lang_code)
    on delete cascade on update cascade 
) engine=InnoDB;

create table reservation (
    res_tr_id int(11) not null,
    res_seatnum tinyint(4) not null default 0,
    res_cust_id int(11) not null,
    res_status enum('PENDING', 'CONFIRMED', 'PAID', 'CANCELLED') not null default 'PENDING',
    res_total_cost decimal(10,2) not null default 0.0,
    primary key (res_tr_id, res_seatnum),
    constraint niki foreign key (res_tr_id) references trip (tr_id)
    on delete cascade on update cascade,
    constraint maria foreign key (res_cust_id) references customer (cust_id)
    on delete cascade on update cascade
) engine=InnoDB;

create table travel_to (
    to_tr_id int(11) not null, 
    to_dst_id int(11) not null, 
    to_arrival datetime not null default '2000-01-01 00:00:00',
    to_departure datetime not null default '2000-01-01 00:00:00',
    to_sequence tinyint(4) not null default 0,
    primary key (to_tr_id, to_dst_id),
    constraint kostas foreign key (to_tr_id) references trip (tr_id)
    on delete cascade on update cascade,
    constraint giannis foreign key (to_dst_id) references destination (dst_id)
    on delete cascade on update cascade
) engine=InnoDB;

create table accomodation (
	acc_id int(11) auto_increment,
    acc_name varchar(50) not null default 'unknown',
    acc_type enum('HOTEL', 'GUESTHOUSE', 'RESORT', 'APARTMENT', 'ROOM FOR RENT') not null default 'HOTEL',
    acc_stars tinyint(1) default null,
    acc_rev decimal(2,2) not null default 0.0,
    acc_state enum('ACTIVE', 'CLOSED FOR RENNOVATION', 'TERMINATION OF COOPERATION') not null default 'ACTIVE',
    acc_street varchar(50) not null default 'unknown',
    acc_str_num tinyint(3) not null default 0,
    acc_city varchar(50) not null default 'unknown',
    acc_TK varchar(15) not null default 'unknown',
    acc_phone varchar(15) not null default 'unknown',
    acc_email varchar(50) not null default 'unknown',
    acc_max_rooms tinyint(4) not null default 0,
    acc_room_value decimal(10,2) not null default 0.0,
    acc_dst_id int(11) not null,
    primary key (acc_id),
    constraint accomodation_in_destination foreign key (acc_dst_id) references destination (dst_id)
    on delete cascade on update cascade
) engine=InnoDB;

create table accomodation_benefits (
	ben_acc_id int(11) auto_increment,
    ben_type enum('WIFI', 'RESTAURANT/BAR', 'AIR CONDITIONING', 'ACCESSIBILITY') not null default 'WIFI',
    primary key (ben_acc_id, ben_type),
    constraint for_accomodation foreign key (ben_acc_id) references accomodation (acc_id)
    on delete cascade on update cascade
) engine=InnoDB;

create table accomodation_trip_reservation (
	atr_tr_id int(11) auto_increment,
    atr_dst_id int(11) not null,
    atr_acc_id int(11) not null,
    acc_res_cost decimal(10,2) default null,
    acc_res_total_nights tinyint(2) default null,
    constraint atr_for_trip foreign key (atr_tr_id) references trip (tr_id)
    on delete cascade on update cascade,
    constraint atr_for_dst foreign key (atr_dst_id) references destination (dst_id)
    on delete cascade on update cascade,
    constraint atr_for_acc foreign key (atr_acc_id) references accomodation (acc_id)
    on delete cascade on update cascade
) engine=InnoDB;

create table trip_history (
	tr_h_id int(11) auto_increment,
    tr_h_departure datetime not null default '2000-01-01 00:00:00',
    tr_h_return datetime not null default '2000-01-01 00:00:00',
    tr_h_dst_count tinyint(2) not null default 0,
    tr_h_participants tinyint(4) not null default 0,
    tr_h_income decimal(10,2) not null default 0.0,
    primary key (tr_h_id)
) engine=InnoDB;

create table database_administrator (
	dba_username varchar(50),
    dba_start_date datetime not null default '2000-01-01 00:00:00',
    dba_end_date datetime default null,
    primary key (dba_username)
) engine=InnoDB;

create table log (
	log_id int(11) auto_increment,
	log_date date not null,
    log_time time not null,
    log_dba_username varchar(50) default 'unknown',
    log_table_updated enum("TRIP", "RESERVATION", "CUSTOMER", "DESTINATION", "VEHICLE", "ACCOMODATION", "ACCOMODATION RESERVATION"),
    primary key (log_id),
    constraint log_made_by foreign key (log_dba_username) references database_administrator (dba_username)
    on delete cascade on update cascade
) engine=InnoDB;
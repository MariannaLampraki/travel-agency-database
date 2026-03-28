use travel_agency_2025;

insert into branch values 
(null, 'Baker Street', 11, 'London', null),
(null, 'Ermou', 3, 'Patras', null),
(null, 'Othonos', 8, 'Athens', null);

insert into worker values 
('EG328089', 'Matt', 'Smith', 'iamthedoctor@hotmail.com', 414.54, 2),
('IO238034', 'Steve', 'Strange', 'itsstrange@yahoo.com', 542.43, 1),
('UI883231', 'Lily', 'Evans', 'lilianevans@outlook.com', 320.45, 3),
('TR438892', 'William', 'Smith', 'will.i.am@smith.eu', 62.30, 1),
('JI589478', 'Regulus', 'Black', 'regie43@gmail.com', 439.09, 2),
('UI934893', 'Bianca', 'Di Angelo', 'daughterofhades@gmail.com', 653.32, 2),
('HI393489', 'Percival', 'Weasley', 'iamnotbadiswear@gov.eu', 120.21, 3),
('HU303909', 'Thor', 'Odinson', 'godofthunder@asgard.com', 2310.83, 3),
('HI988209', 'Tom', 'Riddle', 'iamlordvoldemort@magic.uk', 843.88,3),
('IV734893', 'Theopoula', 'Tzini', 'ikontimedilitiriazei@voitheia.gr', 343.84, 1),
('HB388892', 'Dalia', 'Xatzialeksandrou', 'ritsaelaedo@gmail.com', 489212.32, 2),
('OH389833', 'Barry', 'Allen', 'iamtheflash@outlook.us', 388.23, 2),
('UI938983', 'Albus', 'Dumbledore', 'iamawesomegrandpa@yahoo.com', 3881.53, 1);

insert into admin values
('TR438892', 'ACCOUNTING', "I have no idea what a diploma is, I just account, I'm accounting"),
('IO238034', 'ACCOUNTING', 'Diploma of accounting for accountants'),
('HI393489', 'LOGISTICS', '*Logically* I do not need a diploma, I have my logic as proof'),
('HU303909', 'LOGISTICS', 'Diploma of people who like excell spreadsheets'),
('IV734893', 'ADMINISTRATIVE', 'Diploma of the admin of admins, bow to me you peasants');

update branch set br_manager_AT = 'IV734893' where br_code<4;

insert into driver values
('OH389833', 'A', 'ABROAD', 3),
('HI988209', 'D', 'LOCAL', 7),
('UI883231', 'B', 'LOCAL', 2),
('UI938983', 'B', 'ABROAD', 5);

insert into guide values
('EG328089', 'I have been to many places and know lots of stuff'),
('HB388892', 'I like talking to people'),
('JI589478', "I don't even know how I got here"),
('UI934893', 'My dad has taken me to many countries');

insert into language_ref values 
('GE', 'Georgian'),
('HU', 'Hungarian'),
('JC', 'Jamaican'),
('AGR', 'Ancient Greek');

insert into languages values
('EG328089', 'HU'),
('EG328089', 'JC'),
('UI934893', 'AGR'),
('HB388892', 'GE');

insert into manages values
('IV734893', 1),
('HI393489', 2),
('IO238034', 3);

insert into vehicle values
(null, 1, 'Toyota', 'Corolla', 'ABC1234', 5, 'CAR', 'AVAILABLE', 45000),
(null, 1, 'Mercedes', 'Sprinter', 'VAN5678', 9, 'VAN', 'IN USE', 120000),
(null, 2, 'Volvo', '9700', 'BUS9999', 50, 'BUS', 'AVAILABLE', 300000);

insert into trip values
(null, '2014-03-24 14:43:52', '2014-04-24 14:43:52', 31, 84.29, 43.43, 'PLANNED', 46, 1, 'HB388892', 'HI988209', 2, 12000),
(null, '2014-04-30 12:44:14', '2024-04-30 12:44:14', 32, 24.29, 12.33, 'CANCELLED', 31, 3, 'HB388892', 'HI988209', null, null),
(null, '2014-11-15 22:42:54', '2014-12-15 22:42:54', 41, 104.29, 53.83, 'PLANNED', 41, 1, 'JI589478', 'UI883231', 3, null),
(null, '2014-01-01 23:52:22', '2114-01-01 23:52:22', 45, 67.29, 36.73, 'COMPLETED', 42, 3, 'EG328089', 'OH389833', 2, null),
(null, '2014-02-14 15:45:43', '2224-02-14 15:45:43', 71, 64.29, 33.83, 'ACTIVE', 11, 2, 'UI934893', 'UI938983', null, null),
(null, '2014-12-12 10:25:22', '3014-12-12 10:25:22', 38, 34.29, 17.93, 'CONFIRMED', 51, 1, 'HB388892', 'UI883231', null, null),
(null, '2014-02-01 04:43:44', '2356-02-01 04:43:44', 21, 28.29, 14.03, 'ACTIVE', 45, 2, 'EG328089', 'OH389833', null, null);

insert into phones values 
(1, '1234555891'),
(1, '2110896438'),
(2, '2100932489'),
(3, '3828475347'),
(3, '4089348973');

insert into event values
(1, '2014-03-24 14:43:52', '2014-03-25 14:43:52', 'This event is awesome, you should go there!'),
(3, '2014-11-15 22:42:54', '2014-11-27 22:42:54', 'This event is not awesome, you should not go there!'),
(4, '2014-01-01 23:52:22', '2014-01-01 23:52:22', 'I do not even know where this is supposed to be'),
(5, '2014-02-14 15:45:43', '2014-03-14 15:45:43', 'This thing is getting tiring'),
(7, '2014-02-01 04:43:44', '2014-03-01 04:43:44', 'Are we lost? Maybe...'),
(6, '2014-12-12 10:25:22', '2015-12-12 10:25:22', 'I have lost track of how many of these I have made'),
(1, '2014-03-25 14:43:52', '2014-03-27 14:43:52', 'Are we theeereee yet??'),
(2, '2014-04-30 12:44:14', '2014-05-20 12:44:14', 'The customers are getting hungry...'),
(5, '2014-03-14 15:45:43', '2014-05-14 15:45:43', 'This event was of great cultural significance (I think)'),
(4, '2014-12-12 23:52:22', '2014-12-22 23:52:22', 'I was absent to this event');

insert into customer values 
(null, 'John', 'Snow', 'johnsnow@gmail.com', '6954468231', 'Privet Drive 33, Scottland', '1108-01-29'),
(null, 'Cornelius', 'Fudge', 'ministerofmagic@yahoo.com', '2104646090', 'London Sqare 42, London', '1954-06-13'),
(null, 'Dolores', 'Umbridge', 'highinquisitor@hotmail.com', '2117843264', 'London Sqare 43, London', '1959-04-24'),
(null, 'Jason', 'Grace', 'sonofjeus@chp.com', '1111111111', 'State Street 35, New York', '2000-09-23'),
(null, 'Harry', 'Black', 'harryblack@outlook.com', '2222222222', 'Grimmauld Place 12, London', '1983-07-31'),
(null, 'Sherlock', 'Holmes', 'iamsherlocked@yahoo.com', '6934556531', 'Baker Street 12, London', '1965-05-18'),
(null, 'Annabeth', 'Chase', 'itsanniechase@gmail.com', '3333333333', 'Jordan Street 73, Washington DC', '2001-02-15'),
(null, 'Hermione', 'Granger', 'smartysmartgranger@outlook.com', '2105783290', 'Yaml Drive 21, Crawley', '1982-09-14'),
(null, 'Peter', 'Parker', 'peterparker@gmail.com', '6976382901', 'Saint Columbus 410, Qeens', '2002-04-03'),
(null, 'Tony', 'Stark', 'iamironman@stark.com', '2110894735', 'Stark Island', '1982-10-25');

insert into destination values 
(null, 'New York', 'The capital of France', 'ABROAD', 'HU', 1),
(null, 'Empire State Building', 'This is a big building with more than 500 floors', 'ABROAD', 'HU', 1),
(null, 'Greece', 'The best place in Europe', 'LOCAL', 'AGR', 3),
(null, 'Athens', 'The parthenon and acropolis has very good souvlaki', 'LOCAL', 'AGR', 3),
(null, 'London', 'Have to visit China Town', 'ABROAD', 'JC', 5);

insert into reservation values
(5, 12, 2, 'PAID', 123.23),
(3, 32, 10, 'CANCELLED', 1323.23),
(2, 16, 9, 'CONFIRMED', 12352.23),
(4, 44, 6, 'PENDING', 123.23),
(5, 52, 5, 'PAID', 123.23),
(1, 12, 1, 'PAID', 1253.23),
(2, 18, 8, 'CANCELLED', 1232.23),
(6, 14, 2, 'CONFIRMED', 1235.23),
(6, 52, 6, 'PENDING', 1323.23),
(4, 17, 3, 'CANCELLED', 123.23),
(7, 64, 7, 'CONFIRMED', 1353.23),
(4, 12, 4, 'PENDING', 123.23);

insert into travel_to values
(1, 2, '2014-03-25 14:43:52', '2014-03-30 14:43:52', 1),
(2, 1, '2014-05-30 12:44:14', '2014-07-30 12:44:14', 2),
(3, 2, '2014-12-05 22:42:54', '2014-12-15 22:42:54', 3),
(4, 3, '2024-01-01 23:52:22', '2045-01-01 23:52:22', 3),
(5, 4, '2034-02-14 15:45:43', '2049-02-14 15:45:43', 1),
(3, 1, '3004-12-12 10:25:22', '3012-12-12 10:25:22', 2),
(2, 3, '2034-02-01 04:43:44', '2145-02-01 04:43:44', 3);

insert into accomodation values
(null, 'Sea View Hotel', 'HOTEL', 4, 4.50, 'ACTIVE', 'Ocean Drive', 12, 'Athens', '123456789', '2101234567', 'info@seaview.gr', 80, 120.00, 1),
(null, 'Mountain Guesthouse', 'GUESTHOUSE', 3, 4.10, 'ACTIVE', 'Pine Road', 5, 'Kalambaka', '987654321', '2432023456', 'contact@mountain.gr', 20, 70.00, 2),
(null, 'City Apartments', 'APARTMENT', null, 3.80, 'ACTIVE', 'Main Street', 101, 'Thessaloniki', '555666777', '2310123456', 'hello@cityapt.gr', 30, 90.00, 1),
(null, 'Sunrise Hotel', 'HOTEL', 4, 4.50, 'ACTIVE', 'Beach Road', 12, 'Athens', '10435', '2101111111', 'sunrise@hotel.gr', 80, 120.00, 1),
(null, 'Blue Bay Resort', 'RESORT', 5, 4.80, 'ACTIVE', 'Ocean Avenue', 5, 'Athens', '10436', '2102222222', 'bluebay@resort.gr', 120, 220.00, 1),
(null, 'City Comfort Inn', 'HOTEL', 3, 4.00, 'ACTIVE', 'Central Street', 88, 'Athens', '10437', '2103333333', 'comfort@inn.gr', 40, 75.00, 1),
(null, 'Budget Stay', 'ROOM FOR RENT', NULL, 3.60, 'ACTIVE', 'Old Town', 3, 'Athens', '10438', '2104444444', 'budget@stay.gr', 30, 45.00, 1),
(null, 'Luxury Suites', 'APARTMENT', 5, 4.90, 'ACTIVE', 'Elite Blvd', 1, 'Athens', '10439', '2105555555', 'luxury@suites.gr', 25, 300.00, 1);

insert into accomodation_benefits values
(3, 'WIFI'),
(2, 'RESTAURANT/BAR'),
(5, 'WIFI'),
(1, 'ACCESSIBILITY'),
(4, 'AIR CONDITIONING');

insert into database_administrator values
('marianna', '2022-01-01 09:00:00', null),
('spiros', '2023-03-15 10:00:00', '2024-12-31 18:00:00'),
('ioanna', '2024-01-10 08:30:00', null);


-- --------------------------------------------------------------------------------------------------------------

use travel_agency_2025;

insert into branch values 
(null, 'Ermou', 12, 'Patras', null),
(null, 'Agiou Andreou', 5, 'Patras', null),
(null, 'Othonos Amalias', 9, 'Rio', null);

insert into worker values 
('PA100001', 'Ioanna', 'Serakioti', 'ioanna.serakioti@gmail.com', 980.00, 2),
('PA100002', 'Maria', 'Bousiou', 'maria.bousiou@gmail.com', 1050.00, 1),
('PA100003', 'Eleni', 'Serakioti', 'eleni.serakioti@gmail.com', 920.00, 3),
('PA100004', 'Penelope', 'Parampati', 'penelope.parampati@gmail.com', 890.00, 1),
('PA100005', 'Kostas', 'Koutzounis', 'kostas.koutzounis@gmail.com', 870.00, 2),
('PA100006', 'Vaggelis', 'Valasotiri', 'vaggelis.valasotiri@gmail.com', 1150.00, 2),
('PA100007', 'Spyros', 'Koutzounis', 'spyros.koutzounis@gmail.com', 1250.00, 3),
('PA100008', 'Giorgos', 'Kotsalos', 'giorgos.kotsalos@gmail.com', 930.00, 3),
('PA100009', 'Nikos', 'Bousiou', 'nikos.bousiou@gmail.com', 910.00, 1),
('PA100010', 'Eirini', 'Serakioti', 'eirini.serakioti@gmail.com', 970.00, 1),
('PA100011', 'Dimitris', 'Andreou', 'dimitris.andreou@gmail.com', 1180.00, 2),
('PA100012', 'Sofia', 'Valasotiri', 'sofia.valasotiri@gmail.com', 940.00, 2),
('PA100013', 'Anastasia', 'Papadopoulou', 'anastasia.papadopoulou@gmail.com', 900.00, 1);

insert into admin values
('PA100004', 'ACCOUNTING', 'Accounting diploma'),
('PA100002', 'ACCOUNTING', 'Accounting studies certificate'),
('PA100008', 'LOGISTICS', 'Logistics management certificate'),
('PA100007', 'LOGISTICS', 'Transport coordination diploma'),
('PA100001', 'ADMINISTRATIVE', 'Administrative studies diploma');

update branch set br_manager_AT = 'PA100001' where br_code < 4;

insert into driver values
('PA100006', 'B', 'LOCAL', 4),
('PA100011', 'D', 'LOCAL', 7),
('PA100003', 'C', 'ABROAD', 3),
('PA100009', 'C', 'LOCAL', 5);

insert into guide values
('PA100001', 'Experienced city tour guide'),
('PA100002', 'Excellent communication skills'),
('PA100004', 'Calm and organized guide'),
('PA100010', 'Good knowledge of local history');

insert into language_ref values 
('EL', 'Greek'),
('EN', 'English'),
('IT', 'Italian'),
('FR', 'French');

insert into languages values
('PA100001', 'EN'),
('PA100001', 'FR'),
('PA100004', 'IT'),
('PA100002', 'EN');

insert into manages values
('PA100001', 1),
('PA100008', 2),
('PA100002', 3);

insert into vehicle values
(null, 1, 'Mercedes', 'Sprinter', 'PAT1234', 9, 'VAN', 'AVAILABLE', 135000),
(null, 1, 'BMW', 'X5', 'PAT5678', 5, 'CAR', 'IN USE', 85000),
(null, 2, 'Audi', 'A6', 'PAT9012', 5, 'CAR', 'IN MAINTENANCE', 92000);

insert into trip values
(null, '2023-03-10 09:00:00', '2023-03-20 18:00:00', 20, 120.00, 60.00, 'PLANNED', 25, 1, 'PA100001', 'PA100006', null, null),
(null, '2023-04-05 08:30:00', '2023-04-10 19:00:00', 15, 90.00, 45.00, 'CANCELLED', 18, 2, 'PA100004', 'PA100011', null, null),
(null, '2023-06-12 10:00:00', '2023-06-18 20:00:00', 30, 150.00, 75.00, 'PLANNED', 40, 3, 'PA100004', 'PA100003', null, null),
(null, '2023-01-02 07:45:00', '2023-01-06 18:30:00', 12, 80.00, 40.00, 'COMPLETED', 14, 1, 'PA100001', 'PA100006', null, null),
(null, '2023-02-14 09:15:00', '2023-02-20 21:00:00', 18, 110.00, 55.00, 'ACTIVE', 20, 2, 'PA100010', 'PA100009', null, null),
(null, '2023-09-01 06:30:00', '2023-09-07 22:00:00', 22, 140.00, 70.00, 'CONFIRMED', 28, 1, 'PA100002', 'PA100003', null, null),
(null, '2023-11-10 08:00:00', '2023-11-15 21:30:00', 10, 75.00, 37.50, 'ACTIVE', 12, 3, 'PA100001', 'PA100006', null, null);

insert into phones values 
(1, '2610558899'),
(1, '2610557788'),
(2, '2610223344'),
(3, '2610991122'),
(3, '2610992233');

insert into event values
(1, '2023-03-11 10:00:00', '2023-03-12 12:00:00', 'Team briefing session'),
(3, '2023-06-13 18:00:00', '2023-06-20 20:00:00', 'Hiking activity'),
(4, '2023-01-02 09:00:00', '2023-01-02 11:00:00', 'Short landmark visit'),
(5, '2023-02-15 16:00:00', '2023-03-01 18:00:00', 'Group activity'),
(7, '2023-11-11 08:30:00', '2023-12-01 10:00:00', 'Guided tour'),
(6, '2023-09-02 10:00:00', '2024-09-02 10:00:00', 'Annual event'),
(1, '2023-03-13 09:00:00', '2023-03-15 11:00:00', 'City center tour'),
(2, '2023-04-06 12:00:00', '2023-04-20 12:00:00', 'Travel break'),
(5, '2023-03-05 10:00:00', '2023-05-05 10:00:00', 'Cultural event'),
(4, '2023-12-12 18:00:00', '2023-12-22 18:00:00', 'Evening activity');

insert into customer values 
(null, 'Giorgos', 'Papadopoulos', 'giorgos.papadopoulos@gmail.com', '6944001122', 'Ermou 45, Patras', '1995-05-14'),
(null, 'Maria', 'Kanelou', 'maria.kanelou@gmail.com', '6977123456', 'Agiou Andreou 18, Patras', '1989-11-02'),
(null, 'Dimitris', 'Andreou', 'dimitris.andreou@gmail.com', '6988554433', 'Gounari 22, Patras', '1998-02-19'),
(null, 'Eleni', 'Sotiropoulou', 'eleni.sotiropoulou@gmail.com', '6901234567', 'Maizonos 60, Patras', '2001-09-23'),
(null, 'Nikos', 'Kotsalos', 'nikos.kotsalos@gmail.com', '6933008899', 'Riga Feraiou 11, Patras', '1987-07-31'),
(null, 'Sofia', 'Valasotiri', 'sofia.valasotiri@gmail.com', '6945667788', 'Akti Dimeon 9, Patras', '1993-04-18'),
(null, 'Ioanna', 'Serakioti', 'ioanna.serakioti@gmail.com', '6979001122', 'Othonos Amalias 7, Patras', '2000-12-05'),
(null, 'Spyros', 'Koutzounis', 'spyros.koutzounis@gmail.com', '6957889900', 'Patron Germanou 25, Patras', '1992-08-14'),
(null, 'Penelope', 'Parampati', 'penelope.parampati@gmail.com', '6984332211', 'Rio Center 3, Rio', '2002-03-16'),
(null, 'Vaggelis', 'Bousiou', 'vaggelis.bousiou@gmail.com', '6909988776', 'Kanakari 50, Patras', '1990-10-11');

insert into destination values 
(null, 'Patras', 'City center and pedestrian areas', 'LOCAL', 'EL', null),
(null, 'Rio', 'Area near the Rio-Antirrio bridge', 'LOCAL', 'EL', 1),
(null, 'Kalavryta', 'Mountain destination', 'LOCAL', 'EL', 2),
(null, 'Nafpaktos', 'Nearby coastal town', 'LOCAL', 'EL', 2),
(null, 'Bari', 'International destination by ferry', 'ABROAD', 'IT', 1);

insert into reservation values
(5, 10, 2, 'PAID', 180.00),
(3, 20, 8, 'CANCELLED', 1320.00),
(2, 15, 6, 'CONFIRMED', 980.00),
(4, 30, 4, 'PENDING', 210.00),
(5, 25, 5, 'PAID', 165.00),
(3, 12, 1, 'PAID', 1250.00),
(2, 10, 7, 'CANCELLED', 740.00),
(4, 14, 2, 'CONFIRMED', 1235.00),
(6, 22, 6, 'PENDING', 1380.00),
(2, 17, 3, 'CANCELLED', 199.00),
(7, 28, 7, 'CONFIRMED', 1540.00),
(4, 16, 4, 'PENDING', 225.00);

insert into travel_to values
(1, 1, '2023-03-11 09:00:00', '2023-03-20 18:00:00', 1),
(2, 2, '2023-04-06 08:30:00', '2023-04-10 19:00:00', 2),
(3, 3, '2023-06-12 10:00:00', '2023-06-18 20:00:00', 3),
(4, 4, '2023-01-02 07:45:00', '2023-01-06 18:30:00', 3),
(5, 5, '2023-02-14 09:15:00', '2023-02-20 21:00:00', 1),
(6, 2, '2023-09-01 06:30:00', '2023-09-07 22:00:00', 2),
(7, 4, '2023-11-10 08:00:00', '2023-11-15 21:30:00', 3);

insert into accomodation values
(null, 'Achaia City Hotel', 'HOTEL', 3, 4.20, 'ACTIVE', 'Korinthou', 95, 'Patras', '261011223', '2610123456', 'info@achaiacity.gr', 60, 88.00, 1),
(null, 'Rio View Guesthouse', 'GUESTHOUSE', 3, 4.10, 'ACTIVE', 'Old Rio Road', 12, 'Rio', '261045678', '2610456790', 'contact@rioview.gr', 18, 72.00, 2),
(null, 'Patras Central Apartments', 'APARTMENT', 4, 3.90, 'ACTIVE', 'Maizonos', 140, 'Patras', '261078901', '2610789012', 'hello@patrascentral.gr', 26, 95.00, 1),
(null, 'Gounari Comfort Hotel', 'HOTEL', 3, 4.00, 'ACTIVE', 'Gounari', 27, 'Patras', '261034567', '2610345680', 'reservations@gounarihotel.gr', 54, 82.00, 1),
(null, 'Akti Dimeon Resort', 'RESORT', 4, 4.35, 'ACTIVE', 'Akti Dimeon', 6, 'Patras', '261056789', '2610567900', 'welcome@aktidimeon.gr', 90, 165.00, 1),
(null, 'Kastro Inn', 'HOTEL', 3, 3.95, 'ACTIVE', 'Agiou Andreou', 51, 'Patras', '261023450', '2610234511', 'comfort@kastroinn.gr', 38, 74.00, 1),
(null, 'Budget Stay Patras', 'ROOM FOR RENT', 2, 3.60, 'ACTIVE', 'Patron Germanou', 11, 'Patras', '261067890', '2610678912', 'budget@staypatras.gr', 22, 46.00, 1),
(null, 'Luxury Suites Rio', 'APARTMENT', 5, 4.85, 'ACTIVE', 'Rio Center', 2, 'Rio', '261090120', '2610901212', 'luxury@rio-suites.gr', 20, 245.00, 1);

insert into accomodation_benefits values
(1, 'WIFI'),
(1, 'RESTAURANT/BAR'),
(2, 'WIFI'),
(2, 'ACCESSIBILITY'),
(3, 'AIR CONDITIONING');

insert into trip_history values
(2001, '2024-04-10 08:30:00', '2024-04-14 20:00:00', 3, 21, 9850.00),
(2002, '2024-08-05 07:45:00', '2024-08-10 22:15:00', 2, 17, 8120.00),
(2003, '2025-03-12 09:10:00', '2025-03-16 21:40:00', 1, 12, 5600.00);

insert into database_administrator values
('tania', '2022-09-01 09:00:00', null),
('giorgos', '2023-11-10 10:15:00', '2025-06-30 18:00:00'),
('gianna', '2024-02-05 08:30:00', null);


-- select * from log;
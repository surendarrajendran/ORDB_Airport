                      -- AIRCRAFT_DETAILS OBJECT


-- creating aircraft details objects--
create or replace type aircraft_details as object (
    aircraft_id varchar2(10),
    aircraft_size float,
    weight float,
    speed integer,
    min_turning_radius integer,
    min_circling_radius float,
    
    member procedure display_aircraft_details
);
/

-- creating aircraft details table--
create table aircraft_details_table of aircraft_details (
    aircraft_id primary key
);
/

/*create or replace type body aircraft_details as
    member procedure display_aircraft_details is
        cursorparam sys_refcursor;
        rec aircraft_details;
        begin
            open cursorparam for
                select value(obj) from aircraft_details_table obj;
                dbms_output.put_line('aircraft_details Details');
                dbms_output.put_line('aircraft_details ID' || ' ' || 'aircraft_details size' || ' '  || 'weight' || ' ' || 'speed' || ' ' || 'minimum turning radius' || ' '  || 'minimum circling radius');
                dbms_output.put_line('****************************************************************************************************************');
                loop
                    fetch cursorparam into rec;
                    exit when cursorparam%NOTFOUND;
                    dbms_output.put_line(rec.aircraft_id ||' ' || rec.aircraft_size || ' ' || rec.weight || ' ' || rec.min_turning_radius || ' ' || rec.min_circling_radius);
                end loop;
                dbms_output.put_line('****************************************************************************************************************');
    end display_aircraft_details;
end;
/

declare 
    a1 aircraft_details;
begin
    a1 := aircraft_details('boeing213', 213, 8000.5, 1250, 23, 35.2);
    a1.display_aircraft_details;
end;
/
*/
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                        -- WEATHER_DETAILS OBJECT


-- creating weather details objects--
create type weather_details as object (
    weather_date_time TIMESTAMP,
    UV_index INTEGER,
    sunset TIMESTAMP,
    wind FLOAT,
    rainfall FLOAT,
    humidity FLOAT,
    visibility FLOAT,
    pressure FLOAT,
    weather_type VARCHAR2(10),
    
    member procedure display_weather_details,
    member procedure update_weather_details
);
/

-- creating weather table of weather details--
create table weather_table of weather_details (
    weather_date_time primary key
);
/

/*create or replace type body weather_details as
    member procedure display_weather_details is
        cursorparam sys_refcursor;
        rec weather_details;
        begin
            open cursorparam for
                select value(obj) from weather_table obj;
                dbms_output.put_line('Weather Details');
                dbms_output.put_line('Date and time' || ' ' || 'UV index' || ' '  || 'sunset' || ' ' || 'wind' || ' ' || 'rainfall' || ' '  || 'humidity' || ' ' | 'visibility' || ' ' || 'pressure' || ' ' || 'type');
                dbms_output.put_line('******************************************************************************************************************************************************************************');
                loop
                    fetch cursorparam into rec;
                    exit when cursorparam%NOTFOUND;
                    dbms_output.put_line(rec.weather_date_time ||' ' || rec.UV_index || ' ' || rec.sunset || ' ' || rec.wind || ' ' || rec.rainfalll || ' ' || rec.humidity || ' ' || rec.visibility || ' ' || rec.pressure || ' ' || rec.weather_type);
                end loop;
                dbms_output.put_line('******************************************************************************************************************************************************************************');
    end display_aircraft_details;
end;
/

declare 
    w1 weather_details;
begin
    w1 := weather_details(to_date('26/12/2021 01:23', 'dd/mm/yyyy hh:mi'), 7, to_date('07:58', 'hh:mi'), 34, 15, 67, 12, 1540, 'sunny');
    w1.display_weather_details;
end;
/
*/
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                         -- AIRLINE COMPANY OBJECT


-- creating airline company objects--
create type airline_company as object
(
    airline_id VARCHAR2(10),
    airline_name VARCHAR2(20),
    address varchar2(50),
    contact_number NUMBER
);
/

-- creating airline comapny table of airline company object--
create table airline_companies_table of airline_company (
    airline_id primary key
);
/

/*create or replace type body airline_company as
    member procedure display_passenger_details is
        cursorparam sys_refcursor;
        rec airline_company;
        begin
            open cursorparam for
                select value(obj) from airline_companies_table obj;
                dbms_output.put_line('Airline company Details');
                dbms_output.put_line('Airline ID' || ' ' || 'Airline name' || ' ' || 'Address' || ' ' || 'Contact number' || ' ' || 'List of crew members');
                dbms_output.put_line('*******************************************************************************************************************');
                loop
                    fetch cursorparam into rec;
                    exit when cursorparam%NOTFOUND;
                    dbms_output.put_line(rec.airline_id || ' ' || rec.airline_name || ' ' || rec.address || ' ' || rec.contact_number || ' ' || rec.crew_members);
                end loop;
                dbms_output.put_line('*******************************************************************************************************************');
    end display_passenger_details;
end;
/

declare 
    a1 airline_company;
begin
    a1 := airline_company('rya123', 'Ryainair', 'terbates 33/35, riga, lv-1050', 2320942942, crew_member_nt('cmrya1232', 'cmrya2321', 'cmrya2324', 'cmrya2313')));
    a1.display_passenger_details;
end;
/
*/

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                        -- AIRPORT_SCHEDULE - OBJECT --
                        


-- creating airport schedule objects--
create type airport_schedule as object 
( 
    flight_number varchar2(10), 
    from_or_to varchar2(40), 
    flight_date_time timestamp, 
    airline ref airline_company,
    aircraft ref aircraft_details,
    terminal varchar2(5), 
    trip_id varchar2(10), 
    status_date_time timestamp, 
    status_description varchar2(15), 
    arr_or_dept varchar2(10), 
    weather ref weather_details,
    notes varchar2(50),
    
    member procedure update_schedule, 
    member procedure display_status
);
/

-- creating airport schedule table of airport schedule object--
Create table airport_schedule_table of airport_schedule (
    trip_id primary key,	
    airline with rowid scope is airline_companies_table,
    aircraft with rowid scope is aircraft_details_table,
    weather with rowid scope is weather_table
);
/

/*create or replace type body airport_schedule as
    member procedure receive_request is
    begin
    dbms_output.put_line('Request to update the schedule of AF12 to +30 Minutes received');
    end receive_request;
    member procedure update_schedule is
    fl_time timestamp;
    fl_time1 timestamp;
    begin
    select flight_date_time into fl_time from schedule where airline_id = 'AF12';
    fl_time1 := fl_time  + (1/1440*30);
    update schedule set flight_date_time = fl_time1, status_date_time = fl_time1 where airline_id = 'AF12';
    dbms_output.put_line('Updated the schedule of AF12 to +30 Minutes : ' || 'Previous Schedule ' || fl_time || ' Updtated schedule ' || fl_time1);
    end update_schedule; 
    member procedure display_status is
    cursorparam sys_refcursor;
    rec airport_schedule;
    begin
    OPEN cursorParam FOR
    SELECT value(obj)from schedule obj;
    dbms_output.put_line('Latest Schedule: ');
    dbms_output.put_line('flight_number ' || 'from_or_to ' || 'flight_date_time ' || 'airline_id ' || 'aircraft ' || 'terminal '  || 'trip_id ' || 'status_date_time '|| 'status_description ' || 'arr_or_dept ');
    dbms_output.put_line('-------------------------------------------------------------------------------------------------------------------------------------------------------' );
        LOOP
            FETCH cursorparam INTO rec;
            EXIT WHEN cursorparam%NOTFOUND;
            dbms_output.put_line(rec.flight_number ||' '||rec.from_or_to||' ' || rec.flight_date_time ||' '||rec.airline_id||' '|| rec.aircraft ||' '||rec.terminal||' ' || rec.trip_id ||' '|| rec.status_date_time||' ' || rec.status_description||' ' || rec.arr_or_dept);
        END LOOP;
    dbms_output.put_line('-------------------------------------------------------------------------------------------------------------------------------------------------------' );
    end display_status;
end;
/
*/

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                -- USER_INFO - SUPER CLASS -- 



-- creating user info object as supertype--
CREATE TYPE user_info AS OBJECT 
( 
    first_name VARCHAR2(20),
    last_name VARCHAR2(20),
    DOB DATE,
    gender CHAR,
    contact_number NUMBER,
    user_address varchar2(50)
)
not final;
/

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
                        -- AIRPORT_INFRASTRUCTURE -- 
                        


-- creating varray of checkin type of varchar2--
create type checkin_type as varray(2) of varchar2(40); -- number of domestic checkins, number of international checkins.
/


-- creating user info object as subtype--
create type airport_infrastructure as object 
( 
 serial_num number,
 runway integer,
 check_in_facility checkin_type,
 passenger_gates INTEGER,
 car_parking INTEGER,
 connections INTEGER,
 
 member procedure display_infrastructure_details
);
/

-- creating infrastructure table of airport infrastructure object--
Create table infrastructure of airport_infrastructure (
    serial_num primary key
);
/

/*create or replace type body infrastructure as
    member procedure display_infrastructure_details is
    begin
    select * from infrastructure;
    end display_infrastructure_details;
end;


DECLARE  
   r1 airport_infrastructure;  
BEGIN   
r1:= airport_infrastructure(15,15,6000,25);
   r1.display_infrastructure_details;  
END;
*/

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
                        -- TRAFFIC_MANAGER -- 
                        


-- creating traffic manager as object as subtype of user_info--
create type traffic_manager under user_info
(
    tmanager_id varchar2(10),
    airport_infrastructure_details ref airport_infrastructure,
    
    member procedure display_traffic_manager_details,
    member procedure request_infrastructure_details,
    member procedure request_schedule,
    member procedure request_aircraft_details
);
/


-- creating tmanager table of traffic manager object--
create table tmanager_table of traffic_manager
(
    tmanager_id primary key,	
    airport_infrastructure_details with rowid scope is infrastructure
);
/

/*create or replace type body infrastructure as
    member procedure display_traffic_manager_details is
    begin
    select * from tmanager_table;
    end display_traffic_manager_details;
end;


DECLARE  
   t1 traffic_manager;  
BEGIN   
    t1 := traffic_manager('shiva', 'anbalagan', to_date('07/09/2000', 'dd/mm/yyyy'), 'm', 23242423, 'lacplesha iela 3, riga, lv-1050', 'tm123', NULL));
   r1.display_traffic manager_details;  
END;
*/

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
                        -- AIRPORT_MACHINERY -- 
                        

--creating airport machinery as object--
create type airport_machinery as object 
( 
 serial_number NUMBER,
 dollies INTEGER,
 chocks INTEGER,
 tripod_jack INTEGER,
 service_stairs INTEGER,
 refuelers INTEGER,
 tugs_tractors INTEGER,
 power_units INTEGER,
 buses INTEGER,
 container_loader INTEGER,
 transporters INTEGER,
 airstart_unit INTEGER,
 water_trucks INTEGER,
 lavatory_vehicles INTEGER,
 catering_vehicles INTEGER,
 belt_loader INTEGER,
 passenger_stairs INTEGER,
 anti_icing_vehicles INTEGER,
 rescue_firefighting INTEGER,
 
 member procedure display_machinery,
 member procedure update_machinery
);
/


--creating airport machinery table of airport machinery object--
Create table airport_machinery_table of airport_machinery (
    serial_number primary key
);
/

/*create type body airport_machinery as
member procedure display_machinery is
    cursorparam sys_refcursor;
    rec airport_machinery;
    begin
    OPEN cursorParam FOR
    SELECT value(obj)from airport_machinery_table obj;
    dbms_output.put_line('The machineries in airport: ');
    dbms_output.put_line('dollies ' ||' '|| 'chocks ' ||' '|| 'Tripod jack ' ||' '|| 'service_stairs ' || 'refuelers ' || 'tugs_tractors'  || 'power units ' || 'buses '|| 'container loader ' || 'transporters '||'airstart units'||'water trucks'||'lavatory vechiles'||'catering vehicles'||'belt loader'||'passenger stairs'||'anti-icing vechicles'||'rescue firefighiting');
    dbms_output.put_line('-------------------------------------------------------------------------------------------------------------------------------------------------------' );
        LOOP
            FETCH cursorparam INTO rec;
            EXIT WHEN cursorparam%NOTFOUND;
             dbms_output.put_line(rec.dollies || rec.chocks || rec.Tripod_jack || rec.service_stairs || rec.refuelers  || rec.tugs_tractors  || rec.power_units || rec.buses || rec.container_loader || rec.transporters ||rec.airstart_units||rec.water_trucks||rec.lavatory_vechiles||rec.catering_vehicles||rec.belt_loader||rec.passenger_stairs||rec.anti_icing_vechicles||rec.rescue_firefighiting);
        END LOOP;
    dbms_output.put_line('-------------------------------------------------------------------------------------------------------------------------------------------------------' );
    end display_machinery;
end;
/

DECLARE  
   r1 airport_machinery;  
BEGIN   
r1:= airport_machinery(40,35,40,27,65,76,87,90,10,23,45,67,89,45,65,76,87,98);
   r1.display_machinery;  
END;
/
*/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
                        -- MECHANICS_ENGINEERS --


-- creating mechanics engineers object as subtype of user_info object--                        
create type mechanics_engineers under user_info
(
    mengg_id varchar2(10),
    machinery ref airport_machinery,
    
    member procedure request_machinery
    
);
/

create table mechengg_table of mechanics_engineers (
	mengg_id primary key,
	machinery with rowid scope is airport_machinery_table
);
/

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
                       -- AIRLINE CREW -- 
                       

-- creating airline_crew object as subtype of user_info object-- 
create type airline_crew under user_info
(
  crew_member_id varchar2(10),
  designation varchar2(10),
  airline_details ref airline_company
);
/

create table airline_crew_table of airline_crew (
	crew_member_id primary key,
	airline_details with rowid scope is airline_companies_table
);
/

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                            -- PASSENGER -- 
                            


-- creating passenger object as subtype of user_info object-- 
create type passenger under user_info
(
    passenger_id varchar2(10)
);
/

create table passengers of passenger (
	passenger_id primary key
);
/


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--creating varray type named baggage_list which can hold upto 3 numbers---
create type baggage_list as varray(3) of number; -- 7, 23
/
                        -- BAGGAGE -- 


-- creating baggage object as subtype of user_info object--
create or replace type baggage as object
(
    serialnum number,    
    passenger_details ref passenger,
    trip_details ref airport_schedule,
    baggage_details baggage_list,
    
    member function baggage_sum (trip varchar2) return integer
 );
/
 
create table baggage_table of baggage (
    serialnum primary key,
    passenger_details with rowid scope is passengers,
    trip_details with rowid scope is airport_schedule_table
);
/

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------INSERT QUERIES--------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

                                                                                    --  AIRCRAFT DETAILS --
                                                                                    
insert into aircraft_details_table values(aircraft_details('boeing213', 213, 8000.5, 1250, 23, 35.2));
insert into aircraft_details_table values(aircraft_details('boeing412', 412, 9000.5, 1150, 25, 36.6));
insert into aircraft_details_table values(aircraft_details('boeing756', 400, 9003.5, 1140, 22, 37.6));
insert into aircraft_details_table values(aircraft_details('boeing090', 414, 9000.5, 1200, 24, 35.6));
insert into aircraft_details_table values(aircraft_details('boeing555', 411, 9006.5, 1250, 26, 38.6));

declare 
    var1 aircraft_details;
    var2 aircraft_details;
    var3 aircraft_details;
    var4 aircraft_details;
    var5 aircraft_details;
begin
    var1 := aircraft_details('boeing123', 234, 7000.2, 750, 17, 45);
    insert into aircraft_details_table values(var1);
    
    var2 := aircraft_details('boeing525', 250, 6500, 957, 24, 54.2);
    insert into aircraft_details_table values(var2);
    
    var3 := aircraft_details('boeing234', 415, 9012.5, 1870, 26, 40.6);
    insert into aircraft_details_table values(var3);
    
    var4 := aircraft_details('boeing876', 417, 9000.5, 1230, 29, 36.6);
    insert into aircraft_details_table values(var4);
    
    var5 := aircraft_details('boeing656', 409, 9000.5, 1090, 21, 39.9);
    insert into aircraft_details_table values(var5);
    
end;
/
                                                                                    
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

                                                                                    -- WEATHER DETAILS --

insert into weather_table values(weather_details(to_date('23/12/2021 01:23', 'dd/mm/yyyy hh:mi'), 0, to_date('23/12/2021 07:58', 'dd/mm/yyyy hh:mi'), 14.2, 1.23, 88.42, 11.4, 1010.4, 'cloudy'));
insert into weather_table values(weather_details(to_date('24/12/2021 01:23', 'dd/mm/yyyy hh:mi'), 1, to_date('24/12/2021 06:58', 'dd/mm/yyyy hh:mi'), 13.2, 1.32, 88.43, 11.5, 1010.2, 'rainy'));
insert into weather_table values(weather_details(to_date('25/12/2021 01:23', 'dd/mm/yyyy hh:mi'), 3, to_date('25/12/2021 06:23', 'dd/mm/yyyy hh:mi'), 14.4, 1.25, 87.54, 10.9, 1010.3, 'cloudy'));
insert into weather_table values(weather_details(to_date('26/12/2021 01:23', 'dd/mm/yyyy hh:mi'), 2, to_date('26/12/2021 07:50', 'dd/mm/yyyy hh:mi'), 14.6, 1.54, 85.65, 11.7, 1010.2, 'rainy'));
insert into weather_table values(weather_details(to_date('27/12/2021 01:23', 'dd/mm/yyyy hh:mi'), 0, to_date('27/12/2021 06:59', 'dd/mm/yyyy hh:mi'), 14.5, 1.54, 87.65, 11.3, 1010.1, 'cloudy'));
insert into weather_table values(weather_details(to_date('28/12/2021 01:23', 'dd/mm/yyyy hh:mi'), 6, to_date('28/12/2021 07:58', 'dd/mm/yyyy hh:mi'), 13.2, 1.43, 88.75, 11.2, 1410.2, 'windy'));
insert into weather_table values(weather_details(to_date('29/12/2021 01:23', 'dd/mm/yyyy hh:mi'), 7, to_date('29/12/202  07:58', 'dd/mm/yyyy hh:mi'), 12.3, 1.43, 87.76, 12.1, 1540.4, 'sunny'));
insert into weather_table values(weather_details(to_date('30/12/2021 01:23', 'dd/mm/yyyy hh:mi'), 7, to_date('30/12/2021 07:58', 'dd/mm/yyyy hh:mi'), 12.4, 1.24, 88.65, 12.4, 1540.2, 'sunny'));
insert into weather_table values(weather_details(to_date('31/12/2021 01:23', 'dd/mm/yyyy hh:mi'), 7, to_date('31/12/2021 07:58', 'dd/mm/yyyy hh:mi'), 15.6, 1.24, 87.65, 12.1, 1540.5, 'sunny'));
insert into weather_table values(weather_details(to_date('01/01/2022 01:23', 'dd/mm/yyyy hh:mi'), 7, to_date('01/01/2022 07:58', 'dd/mm/yyyy hh:mi'), 13.2, 1.42, 88.76, 11.9, 1540.2, 'sunny'));


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

                                                                                     -- AIRLINE COMPANY --
                                                                                     
insert into airline_companies_table values(airline_company('emi12', 'Emirates', 'stabu 70, Riga, LV-1050', 2849493849));
insert into airline_companies_table values(airline_company('klm12', 'KLM', 'vecpilsetas 20, Riga, LV-1051', 23241213));
insert into airline_companies_table values(airline_company('aind12', 'Air India', 'Grostonas iela 40, Riga, LV-1050', 29302842));
insert into airline_companies_table values(airline_company('Afr12', 'Air France', 'Tallinas ieal 77, Riga, LV-1023', 239378492));
insert into airline_companies_table values(airline_company('qtr12', 'Qatar Airline', 'Alfreda Kalnina iela - 6, Riga, LV-1034', 23983923));

declare 
    var1 airline_company;
    var2 airline_company;
    var3 airline_company;
    var4 airline_company;
    var5 airline_company;

begin
    var1 := airline_company('rya123', 'Ryainair', 'Terbates 33/35, Riga, LV-1050', 232094294);
    insert into airline_companies_table values(var1);
    
    var2 := airline_company('arf123', 'Aeroflot', 'Maskavas 234, Riga, LV-1043', 273827382);
    insert into airline_companies_table values(var2);
    
    var3 := airline_company('jpn12', 'Japan Airline', 'Jauniela iela 33, Riga, LV-1032', 27384937);
    insert into airline_companies_table values(var3);
    
    var4 := airline_company('sng12', 'Singapore Airline', 'Lacplesha iela 45, Riga, LV-1001', 272937392);
    insert into airline_companies_table values(var4);
    
    var5 := airline_company('tur12', 'Turkish Airlines', 'Dzirnavu 101, Riga, LV-1045', 283920373);
    insert into airline_companies_table values(var5);

end;
/

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

                                                                                    -- AIRPORT SCHEDULE --
                                                                                
insert into airport_schedule_table values(airport_schedule('RTC123',
'Riga', to_date('23/12/2021 01:23', 'dd/mm/yyyy hh:mi'),
NULL, NULL, '2', 'trip11', to_date('23/12/2021 01:23', 
'dd/mm/yyyy hh:mi'), 'on time', 'arrival', NULL, 'Flight arrived on time'));

insert into airport_schedule_table values(airport_schedule('RTC213',
'Brussels', to_date('23/12/2021 01:23', 
'dd/mm/yyyy hh:mi'), NULL, null, '2', 'trip12', to_date('23/12/2021 01:23', 
'dd/mm/yyyy hh:mi'), 'on time', 'arrival', NULL, 'Flight was late by 5 minutes'));

insert into airport_schedule_table values(airport_schedule('LTC555',
'London', to_date('24/12/2021 01:23', 
'dd/mm/yyyy hh:mi'), NULL, null, '7', 'trip13', to_date('24/12/2021 01:23', 
'dd/mm/yyyy hh:mi'), 'on time', 'departure', NULL, 'Flight departed on time'));

insert into airport_schedule_table values(airport_schedule('BTC321',
'Belarus', to_date('25/12/2021 01:23', 
'dd/mm/yyyy hh:mi'), NULL, null, '24', 'trip14', to_date('25/12/2021 01:30', 
'dd/mm/yyyy hh:mi'), 'delayed ', 'arrival', NULL, 'Flight arrived late by 15 mins'));

insert into airport_schedule_table values(airport_schedule('LTC444',
'Latvia', to_date('26/12/2021 01:23', 
'dd/mm/yyyy hh:mi'), NULL, null, '4', 'trip15', to_date('26/12/2021 01:23', 
'dd/mm/yyyy hh:mi'), 'on time', 'departure', NULL, 'Flight departed on time'));

declare
    var1 airport_schedule;
    var2 airport_schedule;
    var3 airport_schedule;
    var4 airport_schedule;
    var5 airport_schedule;
    
begin
    var1 := airport_schedule('RTC412', 
            'Amsterdam', to_date('27/12/2021 01:23', 
            'dd/mm/yyyy hh:mi'), NULL, NULL, '2', 'trip16', 
            to_date('27/12/2021 01:23', 
            'dd/mm/yyyy hh:mi'), 'on time', 'arrival', NULL, 'Flight was cancelled');
    insert into airport_schedule_table values (var1);

    var2 := airport_schedule('ATC222',
            'Australia', to_date('27/12/2021 01:23', 
            'dd/mm/yyyy hh:mi'), NULL, NULL, '30', 'trip17', 
            to_date('27/12/2021 01:23', 
            'dd/mm/yyyy hh:mi'), 'on time', 'arrival', NULL, 'Flight arrived on time');
    insert into airport_schedule_table values (var2);

    var3 := airport_schedule('FTC954',
            'France', to_date('29/12/2021 07:58', 
            'dd/mm/yyyy hh:mi'), NULL, NULL, '30', 'trip18', 
            to_date('29/12/2021 08:05', 
            'dd/mm/yyyy hh:mi'), 'delayed', 'departure', NULL, 'Flight is delayed by 30 mins');
    insert into airport_schedule_table values (var3);

    var4 := airport_schedule('DTC854',
            'Dublin', to_date('30/12/2021 07:58', 
            'dd/mm/yyyy hh:mi'), NULL, NULL, '15', 'trip19', 
            to_date('30/12/2021 08:06', 
            'dd/mm/yyyy hh:mi'), 'delayed', 'arrival', NULL, 'Flight was delayed by 8 minutes.');
    insert into airport_schedule_table values (var4);

    var5 := airport_schedule('JTC654',
            'Jamaica', to_date('01/12/2021 07:58', 
            'dd/mm/yyyy hh:mi'), NULL, NULL, '15', 'trip20', 
            to_date('01/12/2021 07:58', 
            'dd/mm/yyyy hh:mi'), 'on time', 'departure', NULL, 'Flight departed on time');
    insert into airport_schedule_table values (var5);
end;
/

DECLARE
    airline_ref1 REF airline_company;
    airline_ref2 REF airline_company;
    airline_ref3 REF airline_company;
    airline_ref4 REF airline_company;
    airline_ref5 REF airline_company;
    airline_ref6 REF airline_company;
    airline_ref7 REF airline_company;
    airline_ref8 REF airline_company;
    airline_ref9 REF airline_company;
    airline_ref10 REF airline_company;
    
BEGIN
    SELECT REF(A) INTO airline_ref1 FROM airline_companies_table A
    WHERE A.airline_id = 'emi12';
    
    UPDATE airport_schedule_table A
    SET A.airline = airline_ref1 WHERE A.trip_id ='trip11';
    
    SELECT REF(A) INTO airline_ref2 FROM airline_companies_table A
    WHERE A.airline_id = 'klm12';
    
    UPDATE airport_schedule_table A
    SET A.airline = airline_ref2 WHERE A.trip_id ='trip12';
    
    SELECT REF(A) INTO airline_ref3 FROM airline_companies_table A
    WHERE A.airline_id = 'aind12';
    
    UPDATE airport_schedule_table A
    SET A.airline = airline_ref3 WHERE A.trip_id ='trip13';
    
    SELECT REF(A) INTO airline_ref4 FROM airline_companies_table A
    WHERE A.airline_id = 'Afr12';
    
    UPDATE airport_schedule_table A
    SET A.airline = airline_ref4 WHERE A.trip_id ='trip14';
    
       SELECT REF(A) INTO airline_ref5 FROM airline_companies_table A
    WHERE A.airline_id = 'qtr12';
    
    UPDATE airport_schedule_table A
    SET A.airline = airline_ref5 WHERE A.trip_id ='trip15';
    
    SELECT REF(A) INTO airline_ref6 FROM airline_companies_table A
    WHERE A.airline_id = 'rya123';
    
    UPDATE airport_schedule_table A
    SET A.airline = airline_ref6 WHERE A.trip_id ='trip16';
    
    SELECT REF(A) INTO airline_ref7 FROM airline_companies_table A
    WHERE A.airline_id = 'emi12';
    
    UPDATE airport_schedule_table A
    SET A.airline = airline_ref7 WHERE A.trip_id ='trip17';
    
    SELECT REF(A) INTO airline_ref8 FROM airline_companies_table A
    WHERE A.airline_id = 'emi12';
    
    UPDATE airport_schedule_table A
    SET A.airline = airline_ref8 WHERE A.trip_id ='trip18';
    
    SELECT REF(A) INTO airline_ref9 FROM airline_companies_table A
    WHERE A.airline_id = 'emi12';
    
    UPDATE airport_schedule_table A
    SET A.airline = airline_ref9 WHERE A.trip_id ='trip19';
    
    SELECT REF(A) INTO airline_ref10 FROM airline_companies_table A
    WHERE A.airline_id = 'tur12';
    
    UPDATE airport_schedule_table A
    SET A.airline = airline_ref10 WHERE A.trip_id ='trip20';
    
END;
/

DECLARE
    aircraft_ref1 REF aircraft_details;
    aircraft_ref2 REF aircraft_details;
    aircraft_ref3 REF aircraft_details;
    aircraft_ref4 REF aircraft_details;
    aircraft_ref5 REF aircraft_details;
    aircraft_ref6 REF aircraft_details;
    aircraft_ref7 REF aircraft_details;
    aircraft_ref8 REF aircraft_details;
    aircraft_ref9 REF aircraft_details;
    aircraft_ref10 REF aircraft_details;
BEGIN
    SELECT REF(A) INTO aircraft_ref1 FROM aircraft_details_table A
    WHERE A.aircraft_id = 'boeing123';
    
    UPDATE airport_schedule_table A
    SET A.aircraft = aircraft_ref1 WHERE A.trip_id ='trip11';
    
    SELECT REF(A) INTO aircraft_ref2 FROM aircraft_details_table A
    WHERE A.aircraft_id = 'boeing213';
    
    UPDATE airport_schedule_table A
    SET A.aircraft = aircraft_ref2 WHERE A.trip_id ='trip12';
    
    SELECT REF(A) INTO aircraft_ref3 FROM aircraft_details_table A
    WHERE A.aircraft_id = 'boeing412';
    
    UPDATE airport_schedule_table A
    SET A.aircraft = aircraft_ref3 WHERE A.trip_id ='trip13';
     
    SELECT REF(A) INTO aircraft_ref4 FROM aircraft_details_table A
    WHERE A.aircraft_id = 'boeing756';
    
    UPDATE airport_schedule_table A
    SET A.aircraft = aircraft_ref4 WHERE A.trip_id ='trip14';
    
    SELECT REF(A) INTO aircraft_ref5 FROM aircraft_details_table A
    WHERE A.aircraft_id = 'boeing123';
    
    UPDATE airport_schedule_table A
    SET A.aircraft = aircraft_ref5 WHERE A.trip_id ='trip15';
    
    SELECT REF(A) INTO aircraft_ref6 FROM aircraft_details_table A
    WHERE A.aircraft_id = 'boeing123';
    
    UPDATE airport_schedule_table A
    SET A.aircraft = aircraft_ref6 WHERE A.trip_id ='trip16';
    
    SELECT REF(A) INTO aircraft_ref7 FROM aircraft_details_table A
    WHERE A.aircraft_id = 'boeing555';
    
    UPDATE airport_schedule_table A
    SET A.aircraft = aircraft_ref7 WHERE A.trip_id ='trip17';
    
    SELECT REF(A) INTO aircraft_ref8 FROM aircraft_details_table A
    WHERE A.aircraft_id = 'boeing090';
    
    UPDATE airport_schedule_table A
    SET A.aircraft = aircraft_ref8 WHERE A.trip_id ='trip18';
    
    SELECT REF(A) INTO aircraft_ref9 FROM aircraft_details_table A
    WHERE A.aircraft_id = 'boeing412';
    
    UPDATE airport_schedule_table A
    SET A.aircraft = aircraft_ref9 WHERE A.trip_id ='trip19';
    
    SELECT REF(A) INTO aircraft_ref10 FROM aircraft_details_table A
    WHERE A.aircraft_id = 'boeing876';
    
    UPDATE airport_schedule_table A
    SET A.aircraft = aircraft_ref10 WHERE A.trip_id ='trip20';
END;
/

declare 
    weather_ref1 ref weather_details;
    weather_ref2 ref weather_details;
    weather_ref3 ref weather_details;
    weather_ref4 ref weather_details;
    weather_ref5 ref weather_details;
    weather_ref6 ref weather_details;
    weather_ref7 ref weather_details;
    weather_ref8 ref weather_details;
    
begin

    select ref(A) into weather_ref1 from weather_table A
    where A.weather_date_time = to_date('23/12/2021 01:23', 'dd/mm/yyyy hh:mi');
    
    update airport_schedule_table A
    set A.weather = weather_ref1 where A.flight_date_time = to_date('23/12/2021 01:23', 'dd/mm/yyyy hh:mi');
    
    select ref(A) into weather_ref2 from weather_table A
    where A.weather_date_time = to_date('24/12/2021 01:23', 'dd/mm/yyyy hh:mi');
    
    update airport_schedule_table A
    set A.weather = weather_ref2 where A.flight_date_time = to_date('24/12/2021 01:23', 'dd/mm/yyyy hh:mi');
    
    select ref(A) into weather_ref3 from weather_table A
    where A.weather_date_time = to_date('25/12/2021 01:23', 'dd/mm/yyyy hh:mi');
    
    update airport_schedule_table A
    set A.weather = weather_ref3 where A.flight_date_time = to_date('25/12/2021 01:23', 'dd/mm/yyyy hh:mi');
    
    select ref(A) into weather_ref4 from weather_table A
    where A.weather_date_time = to_date('26/12/2021 01:23', 'dd/mm/yyyy hh:mi');
    
    update airport_schedule_table A
    set A.weather = weather_ref4 where A.flight_date_time = to_date('26/12/2021 01:23', 'dd/mm/yyyy hh:mi');
    
    select ref(A) into weather_ref5 from weather_table A
    where A.weather_date_time = to_date('27/12/2021 01:23', 'dd/mm/yyyy hh:mi');
    
    update airport_schedule_table A
    set A.weather = weather_ref5 where A.flight_date_time = to_date('27/12/2021 01:23', 'dd/mm/yyyy hh:mi');
    
    select ref(A) into weather_ref6 from weather_table A
    where A.weather_date_time = to_date('29/12/2021 01:23', 'dd/mm/yyyy hh:mi');
    
    update airport_schedule_table A
    set A.weather = weather_ref6 where A.flight_date_time = to_date('29/12/2021 01:23', 'dd/mm/yyyy hh:mi');
    
    select ref(A) into weather_ref7 from weather_table A
    where A.weather_date_time = to_date('30/12/2021 01:23', 'dd/mm/yyyy hh:mi');
    
    update airport_schedule_table A
    set A.weather = weather_ref7 where A.flight_date_time = to_date('30/12/2021 01:23', 'dd/mm/yyyy hh:mi');
    
    select ref(A) into weather_ref8 from weather_table A
    where A.weather_date_time = to_date('01/01/2022 01:23', 'dd/mm/yyyy hh:mi');
    
    update airport_schedule_table A
    set A.weather = weather_ref8 where A.flight_date_time = to_date('01/01/2022 01:23', 'dd/mm/yyyy hh:mi');
    
end;
/
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

                                                                                    -- AIRPORT INFRASTRUCTURE --

declare
    var1 airport_infrastructure;
    
begin
    var1 := airport_infrastructure(1, 5, checkin_type('15 International check_ins', '10 Domestic check_ins'), 15, 6000, 25);
    insert into infrastructure values (var1);
    
end;
/

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                                                                    -- TRAFFIC MANAGER --
                                                        
insert into tmanager_table values (traffic_manager('Tulip', 'Graceson', to_date('06/05/2000', 'dd/mm/yyyy'), 'm', 273648493, 'lacplesha iela 3 - 7, Riga, LV-1050', 'tm1', NULL));
insert into tmanager_table values (traffic_manager('Tejas', 'Chandrasekar', to_date('09/09/2000', 'dd/mm/yyyy'), 'm', 2738474893, 'Smilsu iela 14 - 2, Riga, LV-1050', 'tm2', NULL));
insert into tmanager_table values (traffic_manager('Aswin', 'Kumar', to_date('10/10/2000', 'dd/mm/yyyy'), 'm', 283749843, 'vecpilsetas iela 3 - 3, Riga, LV-1050', 'tm3', NULL));
insert into tmanager_table values (traffic_manager('Ruthul', 'Jindal', to_date('04/03/2000', 'dd/mm/yyyy'), 'm', 28393743, 'Brivibias iela 40 - 32, Riga, LV-1050', 'tm4', NULL));
insert into tmanager_table values (traffic_manager('Ritik', 'Bharadwaj', to_date('02/01/2000', 'dd/mm/yyyy'), 'm', 27383943, 'Brivibas gatve 234 - 12, Riga, LV-1024', 'tm5', NULL));

declare 
    var1 traffic_manager;
    var2 traffic_manager;
    var3 traffic_manager;
    var4 traffic_manager;
    var5 traffic_manager;
    
begin
    var1 := traffic_manager('Anushika', 'Varma', to_date('06/06/2001', 'dd/mm/yyyy'), 'f', 293042943, 'Avoti iela 35 - 5, Riga, LV-1050', 'tm6', NULL);
    insert into tmanager_table values(var1);
    
    var1 := traffic_manager('Sundaresan', 'Agarwal', to_date('06/05/2002', 'dd/mm/yyyy'), 'm', 209874785, 'Avotu iela 37- 7 , Riga, LV-1050', 'tm7', NULL);
    insert into tmanager_table values(var1);
    
    var1 := traffic_manager('Mohana', 'Rajendran', to_date('20/12/1997', 'dd/mm/yyyy'), 'f', 283940383, 'Getrudes iela 44 - 314, Riga, LV-1050', 'tm8', NULL);
    insert into tmanager_table values(var1);
    
    var1 := traffic_manager('Rajendran', 'Gopal', to_date('16/10/1995', 'dd/mm/yyyy'), 'm', 273839483, 'Merkela iela 3 - 7a, Riga, LV-1050', 'tm9', NULL);
    insert into tmanager_table values(var1);
    
    var1 := traffic_manager('Jayachitra', 'Rajendran', to_date('03/03/1996', 'dd/mm/yyyy'), 'f', 242323244, 'Merkela iela 3 - 7a, Riga, LV-1050', 'tm10', NULL);
    insert into tmanager_table values(var1);
    
end;
/

DECLARE
    ainf_ref REF airport_infrastructure;

BEGIN

    SELECT REF(A) INTO ainf_ref FROM infrastructure A
    WHERE A.serial_num = 1;
    
    UPDATE tmanager_table A
    SET A.airport_infrastructure_details = ainf_ref WHERE A.tmanager_id in ('tm1', 'tm2', 'tm3', 'tm4', 'tm5', 'tm6', 'tm7', 'tm8', 'tm9', 'tm10') ;

END;
/

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

                                                                                    -- AIRPORT MACHINERY --
                                                                                    
insert into airport_machinery_table values(airport_machinery(1, 40, 35, 40, 27, 65, 76, 87, 90, 10, 23, 45, 67, 89, 45, 65, 76, 87, 98));

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

                                                                                    -- MECHANICS_ENGINEERS --
                                                                                    
insert into mechengg_table values (mechanics_engineers('midhun', 'asokkumar', to_date('07/07/2000', 'dd/mm/yyyy'), 'm', 23241121, 'lacplesha iela 35, riga, lv-1050', 'me1', NULL));
insert into mechengg_table values (mechanics_engineers('rakshith', 'easwar', to_date('13/02/2001', 'dd/mm/yyyy'),'m', 23666121, ' zemitana laukums 12, riga, lv-1002', 'me2', NULL));
insert into mechengg_table values (mechanics_engineers('Harjith', 'shiva', to_date('24/04/2001', 'dd/mm/yyyy'), 'm', 23998121, 'gustava zemgala gatve, riga, lv-1044', 'me3', NULL));
insert into mechengg_table values (mechanics_engineers('nithish', 'kumar', to_date('03/03/2002', 'dd/mm/yyyy'), 'm', 23555121, 'getrudes iela, riga, lv-1034', 'me4', NULL));
insert into mechengg_table values (mechanics_engineers('markus', 'kumar', to_date('02/02/2002', 'dd/mm/yyyy'), 'm', 23000121, 'tallinas iela 33, riga, lv-1051', 'me5', NULL));


declare
    var1 mechanics_engineers;
    var2 mechanics_engineers;
    var3 mechanics_engineers;
    var4 mechanics_engineers;
    var5 mechanics_engineers;
    
begin
    var1 := mechanics_engineers('sebastian', 'lee', to_date('04/04/2001', 'dd/mm/yyyy'), 'm', 23399121, 'dzutas iela 21, riga, lv-1053', 'me6', NULL);
    insert into mechengg_table values (var1);

    var2 := mechanics_engineers('vibitha', 'kumar', to_date('31/12/2003', 'dd/mm/yyyy'), 'f', 23399090, ' aizkraukles iela 31, riga, lv-1123', 'me7', NULL);
    insert into mechengg_table values (var2);

    var3 := mechanics_engineers('swathi', 'ram', to_date('18/11/2002', 'dd/mm/yyyy'), 'f', 23399887, ' linezers 43, riga, lv-1189', 'me8', NULL);
    insert into mechengg_table values (var3);

    var4 := mechanics_engineers('anadhi', 'kumar', to_date('19/03/2002', 'dd/mm/yyyy'), 'f', 23396787, ' ausmas iela 33, riga, lv-1111', 'me9', NULL);
    insert into mechengg_table values (var4);

    var5 := mechanics_engineers('kayalvizhi', 'sekar', to_date('19/08/2002', 'dd/mm/yyyy'), 'f', 23396610, ' matisa iela, riga, lv-1341', 'me10', NULL);
    insert into mechengg_table values (var5);
end;
/

DECLARE
    mengg_ref REF airport_machinery;
BEGIN
    SELECT REF(A) INTO mengg_ref FROM airport_machinery_table A
    WHERE A.serial_number = 1;
    
    UPDATE mechengg_table A
    SET A.machinery = mengg_ref WHERE A.mengg_id in ('me1', 'me2', 'me3', 'me4', 'me5', 'me6', 'me7', 'me8', 'me9', 'me10');
END;
/
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

                                                                                    -- AIRLINE CREW --
                                                                                    
insert into airline_crew_table values (airline_crew('Nedumaran', 'Rajangam', to_date('11/01/1999', 'dd/mm/yyyy'), 'm', 890498121, 'matisa iela 21, riga, lv-1033', 'cid1001','pilot', NULL));
insert into airline_crew_table values (airline_crew('gokul', 'chellaiya',to_date('07/09/2001' , 'dd/mm/yyyy'),'m', 32567890, 'laimdotas iela 22 , riga, LV-1005', 'cid1003', 'co-pilot', NULL));
insert into airline_crew_table values (airline_crew('dinesh', 'ram',to_date('07/01/2001' , 'dd/mm/yyyy'),'m', 32456890, 'laimdotas iela 25 , riga, LV-1006', 'cid1009', 'pilot', NULL));
insert into airline_crew_table values (airline_crew('markus', 'kumar', to_date('02/02/2002', 'dd/mm/yyyy'), 'm', 23000121, 'tallinas iela 33, riga, lv-1051', 'cid1007','attendant', NULL));
insert into airline_crew_table values (airline_crew('Harjith', 'shiva', to_date('11/01/2001', 'dd/mm/yyyy'), 'm', 45398121, 'gustava zemgala gatve, riga, lv-1044', 'cid1005','pilot', NULL));


declare
    var1 airline_crew;
    var2 airline_crew;
    var3 airline_crew;
    var4 airline_crew;
    var5 airline_crew;
    
begin
    var1 := airline_crew('vibitha', 'kumar', to_date('31/01/2004', 'dd/mm/yyyy'), 'f', 09099090, ' aizkraukles iela 31, riga, lv-1123', 'cid1011','co-pilot', NULL);
    insert into airline_crew_table values (var1);

    var2 := airline_crew('indhumati', 'kumar', to_date('03/01/1998', 'dd/mm/yyyy'), 'f', 09087690, ' tallinas iela 31, riga, lv-1123', 'cid1012','attendant', NULL);
    insert into airline_crew_table values (var2);

    var3 := airline_crew('jayanthi', 'ram', to_date('11/11/1998', 'dd/mm/yyyy'), 'f', 09008490, ' getrudes iela 11, riga, lv-1123', 'cid1013','co-pilot', NULL);
    insert into airline_crew_table values (var3);

    var4 := airline_crew('nalina', 'raj', to_date('11/12/1996', 'dd/mm/yyyy'), 'f', 09650860, ' getrudes iela 17, riga, lv-1123', 'cid1014','pilot', NULL);
    insert into airline_crew_table values (var4);

    var5 := airline_crew('melina', 'natraj', to_date('07/07/1997', 'dd/mm/yyyy'), 'f', 08884490, ' gustava gatve 15, riga, lv-1126', 'cid1015','co-pilot', NULL);
    insert into airline_crew_table values (var5);
end;
/

DECLARE
    airline_ref1 REF airline_company;
    airline_ref2 REF airline_company;
    airline_ref3 REF airline_company;
    airline_ref4 REF airline_company;
    airline_ref5 REF airline_company;
    airline_ref6 REF airline_company;
    airline_ref7 REF airline_company;
    airline_ref8 REF airline_company;
    airline_ref9 REF airline_company;
    airline_ref10 REF airline_company;
    airline_ref11 REF airline_company;
    
BEGIN

    SELECT REF(A) INTO airline_ref1 FROM airline_companies_table A
    WHERE A.airline_id = 'emi12';
    
    UPDATE airline_crew_table A
    SET A.airline_details = airline_ref1 WHERE A.crew_member_id ='cid1003';
    
    SELECT REF(A) INTO airline_ref2 FROM airline_companies_table A
    WHERE A.airline_id = 'qtr12';
    
    UPDATE airline_crew_table A
    SET A.airline_details = airline_ref2 WHERE A.crew_member_id ='cid1033';
    
    SELECT REF(A) INTO airline_ref3 FROM airline_companies_table A
    WHERE A.airline_id = 'qtr12';
    
    UPDATE airline_crew_table A
    SET A.airline_details = airline_ref3 WHERE A.crew_member_id ='cid1009';
    
    SELECT REF(A) INTO airline_ref4 FROM airline_companies_table A
    WHERE A.airline_id = 'Afr12';
    
    UPDATE airline_crew_table A
    SET A.airline_details = airline_ref4 WHERE A.crew_member_id ='cid1007';
    
    SELECT REF(A) INTO airline_ref5 FROM airline_companies_table A
    WHERE A.airline_id = 'Afr12';
    
    UPDATE airline_crew_table A
    SET A.airline_details = airline_ref5 WHERE A.crew_member_id ='cid1005';
    
    SELECT REF(A) INTO airline_ref6 FROM airline_companies_table A
    WHERE A.airline_id = 'rya123';
    
    UPDATE airline_crew_table A
    SET A.airline_details = airline_ref6 WHERE A.crew_member_id ='cid1011';
    
    SELECT REF(A) INTO airline_ref7 FROM airline_companies_table A
    WHERE A.airline_id = 'rya123';
    
    UPDATE airline_crew_table A
    SET A.airline_details = airline_ref7 WHERE A.crew_member_id ='cid1012';
    
    SELECT REF(A) INTO airline_ref8 FROM airline_companies_table A
    WHERE A.airline_id = 'rya123';
    
    UPDATE airline_crew_table A
    SET A.airline_details = airline_ref8 WHERE A.crew_member_id ='cid1013';
    
    
    SELECT REF(A) INTO airline_ref9 FROM airline_companies_table A
    WHERE A.airline_id = 'sng12';
    
    UPDATE airline_crew_table A
    SET A.airline_details = airline_ref9 WHERE A.crew_member_id ='cid1014';
    
    
    SELECT REF(A) INTO airline_ref10 FROM airline_companies_table A
    WHERE A.airline_id = 'sng12';
    
    UPDATE airline_crew_table A
    SET A.airline_details = airline_ref10 WHERE A.crew_member_id ='cid1015';
    
    SELECT REF(A) INTO airline_ref11 FROM airline_companies_table A
    WHERE A.airline_id = 'sng12';
    
    UPDATE airline_crew_table A
    SET A.airline_details = airline_ref11 WHERE A.crew_member_id ='cid1001';
    
END;
/

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

                                                                                    -- PASSENGER -- 
                                                                                
insert into passengers values (passenger('Surendar', 'Rajendran', to_date('07/09/2001', 'dd/mm/yyyy'), 'm', 22053434, 'Merkela iela 3 - 7a, Riga, LV-1050', 'p1'));
insert into passengers values (passenger('Shiva', 'Anbalagan', to_date('07/10/2001', 'dd/mm/yyyy'), 'm', 23548756, 'Laimdotas 2 - 47, Riga, LV-1049', 'p2'));
insert into passengers values (passenger('Midhun', 'Padma', to_date('07/12/2001', 'dd/mm/yyyy'), 'm', 245784957, 'Lacplesha iela 35 - 8, Riga, LV-1050', 'p3'));
insert into passengers values (passenger('Nebin', 'Thomas', to_date('12/09/2001', 'dd/mm/yyyy'), 'm', 27653434, 'Lacplesha iela 35 - 8, Riga, LV-1050', 'p4'));
insert into passengers values (passenger('Varun', 'Sai', to_date('13/09/2001', 'dd/mm/yyyy'), 'm', 20983743, 'Merkela iela 3 - 7a, Riga, LV-1050', 'p5'));

declare 
    var1 passenger;
    var2 passenger;
    var3 passenger;
    var4 passenger;
    var5 passenger;
    
begin
    var1 := passenger('Tarak', 'Ravula', to_date('07/04/2001', 'dd/mm/yyyy'), 'm', 29846373, 'Merkela iela 3 - 7a, Riga, LV-1050', 'p6');
    insert into passengers values(var1);
    
    var2 := passenger('Shivani', 'Gokulram', to_date('30/09/2001', 'dd/mm/yyyy'), 'f', 273846493, 'Elizabetes iela 3 - 23, Riga, LV-1050', 'p7');
    insert into passengers values(var2);
    
    var3 := passenger('Harini', 'Gokulram', to_date('30/09/2001', 'dd/mm/yyyy'), 'f', 239493043, 'Elizabetes iela 3 - 23, Riga, LV-1050', 'p8');
    insert into passengers values(var3);
    
    var4 := passenger('Nikitha', 'Moksham', to_date('10/03/2001', 'dd/mm/yyyy'), 'm', 273738373, 'Stabu iela 40 - 4, Riga, LV-1050', 'p9');
    insert into passengers values(var4);
    
    var5 := passenger('Vaishnavi', 'Arunkumar', to_date('25/11/2001', 'dd/mm/yyyy'), 'm', 20393742, 'Getrudes iela 14 - 7, Riga, LV-1050', 'p10');
    insert into passengers values(var5);

end;
/

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

                                                                                    -- BAGGAGE --
                                                                                    
insert into baggage_table values (baggage(1, null, null, baggage_list(23)));
insert into baggage_table values (baggage(2, null, null, baggage_list(7, 23)));
insert into baggage_table values (baggage(3, null, null, baggage_list(7, 23)));
insert into baggage_table values (baggage(4, null, null, baggage_list(7)));
insert into baggage_table values (baggage(5, null, null, baggage_list(7)));

declare 
    var1 baggage;
    var2 baggage;
    var3 baggage;
    var4 baggage;
    var5 baggage;
    
begin
    var1 := baggage(6, null, null,  baggage_list(23));
    insert into baggage_table values(var1);
    
    var2 := baggage(7, null, null,  baggage_list(7, 23));
    insert into baggage_table values(var2);
    
    var3 := baggage(8, null, null,  baggage_list(0));
    insert into baggage_table values(var3);
    
    var4 := baggage(9, null, null,  baggage_list(0));
    insert into baggage_table values(var4);
    
    var5 := baggage(10, null, null,  baggage_list(7, 23));
    insert into baggage_table values(var5);
    
end;
/

DECLARE
    pass_ref1 REF passenger;
    pass_ref2 REF passenger;
    pass_ref3 REF passenger;
    pass_ref4 REF passenger;
    pass_ref5 REF passenger;
    pass_ref6 REF passenger;
    pass_ref7 REF passenger;
    pass_ref8 REF passenger;
    pass_ref9 REF passenger;
    pass_ref10 REF passenger;
    
BEGIN

    SELECT REF(A) INTO pass_ref1 FROM passengers A
    WHERE A.passenger_id = 'p1';
    
    UPDATE baggage_table A
    SET A.passenger_details = pass_ref1 WHERE A.serialnum = 1;
    
    SELECT REF(A) INTO pass_ref2 FROM passengers A
    WHERE A.passenger_id = 'p1';
    
    UPDATE baggage_table A
    SET A.passenger_details = pass_ref2 WHERE A.serialnum = 7;
    
    SELECT REF(A) INTO pass_ref3 FROM passengers A
    WHERE A.passenger_id = 'p2';
    
    UPDATE baggage_table A
    SET A.passenger_details = pass_ref3 WHERE A.serialnum = 2;
    
    SELECT REF(A) INTO pass_ref4 FROM passengers A
    WHERE A.passenger_id = 'p2';
    
    UPDATE baggage_table A
    SET A.passenger_details = pass_ref4 WHERE A.serialnum = 8;
    
    SELECT REF(A) INTO pass_ref5 FROM passengers A
    WHERE A.passenger_id = 'p3';
    
    UPDATE baggage_table A
    SET A.passenger_details = pass_ref5 WHERE A.serialnum = 3;
    
    SELECT REF(A) INTO pass_ref6 FROM passengers A
    WHERE A.passenger_id = 'p3';
    
    UPDATE baggage_table A
    SET A.passenger_details = pass_ref6 WHERE A.serialnum = 9;
    
    SELECT REF(A) INTO pass_ref7 FROM passengers A
    WHERE A.passenger_id = 'p4';
    
    UPDATE baggage_table A
    SET A.passenger_details = pass_ref7 WHERE A.serialnum = 4;
    
    SELECT REF(A) INTO pass_ref8 FROM passengers A
    WHERE A.passenger_id = 'p4';
    
    UPDATE baggage_table A
    SET A.passenger_details = pass_ref8 WHERE A.serialnum = 10;
    
    SELECT REF(A) INTO pass_ref9 FROM passengers A
    WHERE A.passenger_id = 'p5';
    
    UPDATE baggage_table A
    SET A.passenger_details = pass_ref9 WHERE A.serialnum = 5;
    
    SELECT REF(A) INTO pass_ref10 FROM passengers A
    WHERE A.passenger_id = 'p5';
    
    UPDATE baggage_table A
    SET A.passenger_details = pass_ref10 WHERE A.serialnum = 6;
    
END;
/


DECLARE
    trip_ref1 REF airport_schedule;
    trip_ref2 REF airport_schedule;
    trip_ref3 REF airport_schedule;
    trip_ref4 REF airport_schedule;
    trip_ref5 REF airport_schedule;
    trip_ref6 REF airport_schedule;
    trip_ref7 REF airport_schedule;
    trip_ref8 REF airport_schedule;
    trip_ref9 REF airport_schedule;
    trip_ref10 REF airport_schedule;
    
BEGIN

    SELECT REF(A) INTO trip_ref1 FROM airport_schedule_table A
    WHERE A.trip_id = 'trip11';
    
    UPDATE baggage_table A
    SET A.trip_details = trip_ref1 WHERE A.serialnum = 1;
    
    SELECT REF(A) INTO trip_ref2 FROM airport_schedule_table A
    WHERE A.trip_id = 'trip17';
    
    UPDATE baggage_table A
    SET A.trip_details = trip_ref2 WHERE A.serialnum = 7;
    
    SELECT REF(A) INTO trip_ref3 FROM airport_schedule_table A
    WHERE A.trip_id = 'trip12';
    
    UPDATE baggage_table A
    SET A.trip_details = trip_ref3 WHERE A.serialnum = 2;
    
    SELECT REF(A) INTO trip_ref4 FROM airport_schedule_table A
    WHERE A.trip_id = 'trip18';
    
    UPDATE baggage_table A
    SET A.trip_details = trip_ref4 WHERE A.serialnum = 8;
    
    SELECT REF(A) INTO trip_ref5 FROM airport_schedule_table A
    WHERE A.trip_id = 'trip13';
    
    UPDATE baggage_table A
    SET A.trip_details = trip_ref5 WHERE A.serialnum = 3;
    
    SELECT REF(A) INTO trip_ref6 FROM airport_schedule_table A
    WHERE A.trip_id = 'trip19';
    
    UPDATE baggage_table A
    SET A.trip_details = trip_ref6 WHERE A.serialnum = 9;
    
    SELECT REF(A) INTO trip_ref7 FROM airport_schedule_table A
    WHERE A.trip_id = 'trip20';
    
    UPDATE baggage_table A
    SET A.trip_details = trip_ref7 WHERE A.serialnum = 4;
    
    SELECT REF(A) INTO trip_ref8 FROM airport_schedule_table A
    WHERE A.trip_id = 'trip14';
    
    UPDATE baggage_table A
    SET A.trip_details = trip_ref8 WHERE A.serialnum = 10;
    
    SELECT REF(A) INTO trip_ref9 FROM airport_schedule_table A
    WHERE A.trip_id = 'trip15';
    
    UPDATE baggage_table A
    SET A.trip_details = trip_ref9 WHERE A.serialnum = 5;
    
    SELECT REF(A) INTO trip_ref10 FROM airport_schedule_table A
    WHERE A.trip_id = 'trip19';
    
    UPDATE baggage_table A
    SET A.trip_details = trip_ref10 WHERE A.serialnum = 6;

END;
/


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

                                                                                 -- SQL QUERIES --

-- the goal of this queries is to list the passenger ID along with trip ID i.e, which passenger has travelled in which trip it tells us--
SELECT b.serialnum, deref(b.passenger_details).passenger_id as PASSENGER_ID, deref(b.trip_details).trip_id as TRIP_ID, t.*  FROM baggage_table b , TABLE(b.baggage_details) t  ORDER BY b.serialnum;


-- it gives all the infrastructure details in the airport --
select t.runway, t.passenger_gates, t.car_parking, t.connections, c.* from infrastructure t, table(t.check_in_facility) c;

-- This query is the one which is used to display all the information that will be in the screens of airport for the passengers to be informed and to navigate to the corrrect terminal --
select f.flight_number, f.arr_or_dept, f.from_or_to, f.flight_date_time, deref(f.airline).airline_id as airline_ID, deref(f.airline).airline_name as airline_name, deref(f.aircraft).aircraft_id as aircraft_type, f.terminal, f.status_date_time, f.status_description from airport_schedule_table f order by f.flight_date_time;

-- This query gives us all the pilots and co-pilots of all the airline comapny that are operating in this airport --
select c.crew_member_id, c.first_name, c.last_name, c.DOB, c.gender, c.contact_number, c.user_address, deref(c.airline_details).airline_name as Airline_name, c.designation from airline_crew_table c where c.designation in ('pilot', 'co-pilot') order by c.crew_member_id;

-- this query retrieves all the aircrafts which has minimum circling radius between 35 and 41 --
select * from aircraft_details_table where min_circling_radius between 35 and 41;

-- this query retrieves the count of all the passengers in a particular trip using a trip ID --
select deref(trip_details).trip_id as TRIP_ID, count(serialnum) as NUMBER_OF_PASSENGERS from baggage_table group by deref(trip_details).trip_id order by deref(trip_details).trip_id;

-- this query displays the weather details betwwen the dates 24/12/2021 and 27/12/2021 --
select * from weather_table where weather_date_time between to_date('24/12/2021', 'dd/mm/yyyy') and to_date('27/12/2021', 'dd/mm/yyyy');

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

                                                      -- SAMPLE MEMBER PROCEDURE --

create or replace type body aircraft_details as
    member procedure display_aircraft_details is
        cursorparam sys_refcursor;
        rec aircraft_details;
        begin
            open cursorparam for
                select value(obj) from aircraft_details_table obj;
                dbms_output.put_line('aircraft_details Details');
                dbms_output.put_line('aircraft_details ID' || ' ' || 'aircraft_details size' || ' '  || 'weight' || ' ' || 'speed' || ' ' || 'minimum turning radius' || ' '  || 'minimum circling radius');
                dbms_output.put_line('****************************************************************************************************************');
                loop
                    fetch cursorparam into rec;
                    exit when cursorparam%NOTFOUND;
                    dbms_output.put_line(rec.aircraft_id ||' ' || rec.aircraft_size || ' ' || rec.weight || ' ' || rec.min_turning_radius || ' ' || rec.min_circling_radius);
                end loop;
                dbms_output.put_line('****************************************************************************************************************');
    end display_aircraft_details;
end;
/

declare 
    a1 aircraft_details;
begin
    a1 := aircraft_details('boeing213', 213, 8000.5, 1250, 23, 35.2);
    a1.display_aircraft_details;
end;
/

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
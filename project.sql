create database project;

use project;

-- Accounts table
CREATE TABLE Accounts (
    username VARCHAR(255) PRIMARY KEY,
    password VARCHAR(255) NOT NULL
);

SELECT * FROM Accounts;

DROP TABLE Accounts;

DELETE FROM Accounts;

DELETE FROM Accounts WHERE username = 'manavparikh2003@gmail.com';

-- Customer table
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Username VARCHAR(255) UNIQUE,
    FOREIGN KEY (Username) REFERENCES Accounts(username),
    BillingAddress VARCHAR(255)
);

CREATE TABLE Customer (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Username VARCHAR(255) UNIQUE,
    FOREIGN KEY (Username) REFERENCES Accounts(username),
    BillingAddress VARCHAR(255)
);


DELETE FROM Customer;

DELETE FROM Customer WHERE username = 'manavparikh2003@gmail.com';

DROP TABLE Customer;

select * from Customer;

-- ServiceLocation table
CREATE TABLE ServiceLocation (
    LocationID INT PRIMARY KEY,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    Address VARCHAR(255) NOT NULL,
    ZipCode VARCHAR(10) NOT NULL,
    UnitNumber VARCHAR(50),
    TakeoverDate DATE,
    SquareFootage DECIMAL(10, 2),
    Bedrooms INT,
    Occupants INT,
    UNIQUE (CustomerID, Address) -- Ensures unique combination of Customer and Address
);

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE ServiceLocation;

select * from Customer;

select * from ServiceLocation;


-- Device table
CREATE TABLE Device (
    DeviceID INT PRIMARY KEY,
    LocationID INT,
    FOREIGN KEY (LocationID) REFERENCES ServiceLocation(LocationID),
    Type VARCHAR(50) NOT NULL,
    ModelNumber VARCHAR(50) NOT NULL
);

select * from Device;



-- EventData table
CREATE TABLE EventData (
    DataID INT PRIMARY KEY,
    DeviceID INT,
    FOREIGN KEY (DeviceID) REFERENCES Device(DeviceID),
    Timestamp TIMESTAMP,
    EventType VARCHAR(50) NOT NULL,
    Value DECIMAL(10, 2) -- Adjust precision and scale based on your requirements
);

select * from EventData;

-- EnergyPrice table
CREATE TABLE EnergyPrice (
    PriceID INT PRIMARY KEY,
    ZipCode VARCHAR(10) NOT NULL,
    Time TIME,
    PricePerKWh DECIMAL(10, 4) -- Adjust precision and scale based on your requirements
);

select * from EnergyPrice;

use project;

-- Customer Entries
INSERT INTO Customer (CustomerID, Name, BillingAddress)
VALUES (1, 'John Doe', '123 Main Street, Cityville'),
       (2, 'Jane Smith', '456 Oak Avenue, Townsville'),
       (3, 'Christopher Johnson', '789 Pine Lane, Villageton'),
       (4, 'Alice Johnson', '540 72st, Brooklyn'),
       (5, 'Bob Brown', '101 Elm Street, Hamlet');
       
select * from Customer;

-- ServiceLocation Entries
INSERT INTO ServiceLocation (LocationID, CustomerID, Address, ZipCode, UnitNumber, TakeoverDate, SquareFootage, Bedrooms, Occupants)
VALUES 
    (1, 1, '123 Main Street, Apt 101', '12345', 'Apt 101', '2022-09-01', 950.00, 2, 3),
    (2, 1, '456 Oak Avenue, Unit 6', '67890', 'Unit 6', '2022-02-15', 1000.00, 3, 2),
    (3, 2, '456 Oak Avenue, Unit 5', '67890', 'Unit 5', '2022-03-20', 1100.00, 3, 2),
    (4, 3, '456 Oak Avenue, Unit 7', '67890', 'Unit 7', '2022-04-10', 925.50, 2, 3),
    (5, 3, '789 Pine Lane, House 2', '23456', 'House 2', '2022-05-05', 1050.75, 3, 2),
    (6, 3, '101 Elm Street, Unit 15', '56789', 'Unit 15', '2022-06-18', 980.25, 2, 4),
    (7, 4, '101 Elm Street, Unit 12', '56789', 'Unit 12', '2022-07-22', 1005.00, 3, 2),
    (8, 4, '789 Pine Lane, House 3', '23456', 'House 3', '2022-08-30', 950.50, 2, 4),
    (9, 5, '101 Elm Street, Unit 18', '56789', 'Unit 18', '2022-09-15', 850.75, 3, 2),
    (10, 4, '123 Main Street, Apt 102', '12345', 'Unit 102', '2022-09-05', 875.25, 2, 3);
    
select * from ServiceLocation;

SET SQL_SAFE_UPDATES = 0;

delete from ServiceLocation;

-- Device Entries
-- Devices for LocationID 1
INSERT INTO Device (DeviceID, LocationID, Type, ModelNumber)
VALUES 
    (1, 1, 'AC System', 'CoolMaster 2000'),
    (2, 1, 'Refrigerator', 'GE Cafe 400'),
    (3, 1, 'Light', 'Philips LED 100W'),
    (4, 1, 'Light', 'Philips LED 100W'),
    (5, 1, 'Light', 'Philips LED 100W');

-- Devices for LocationID 2
INSERT INTO Device (DeviceID, LocationID, Type, ModelNumber)
VALUES 
    (6, 2, 'AC System', 'CoolTech 3000'),
    (7, 2, 'Light', 'SmartBulb XYZ'),
    (8, 2, 'Light', 'SmartBulb XYZ'),
    (9, 2, 'Light', 'SmartBulb XYZ');

-- Devices for LocationID 3
INSERT INTO Device (DeviceID, LocationID, Type, ModelNumber)
VALUES 
    (10, 3, 'Refrigerator', 'Samsung QB800'),
    (11, 3, 'Light', 'LED Glow 150W'),
    (12, 3, 'Light', 'LED Glow 150W'),
    (13, 3, 'AC System', 'CoolTech 3500'),
    (14, 3, 'AC System', 'CoolTech 3500');

-- Devices for LocationID 4
INSERT INTO Device (DeviceID, LocationID, Type, ModelNumber)
VALUES 
    (15, 4, 'Light', 'SmartBulb ABC'),
    (16, 4, 'Light', 'SmartBulb ABC'),
    (17, 4, 'Light', 'SmartBulb ABC'),
    (18, 4, 'Refrigerator', 'LG Fresh 600'),
    (19, 4, 'AC System', 'CoolBreeze 5000');
    
-- Devices for LocationID 5
INSERT INTO Device (DeviceID, LocationID, Type, ModelNumber)
VALUES 
    (20, 5, 'Light', 'LED Bright 120W'),
    (21, 5, 'Light', 'LED Bright 120W'),
    (22, 5, 'Refrigerator', 'Whirlpool FrostFree 700'),
    (23, 5, 'AC System', 'AirCool Max 4500');

-- Devices for LocationID 6
INSERT INTO Device (DeviceID, LocationID, Type, ModelNumber)
VALUES 
    (24, 6, 'Light', 'SmartLED 200W'),
    (25, 6, 'Light', 'SmartLED 200W'),
    (26, 6, 'Light', 'SmartLED 200W'),
    (27, 6, 'AC System', 'CoolBlast 6000');

-- Devices for LocationID 7
INSERT INTO Device (DeviceID, LocationID, Type, ModelNumber)
VALUES 
    (28, 7, 'Refrigerator', 'KitchenMaster 900'),
    (29, 7, 'Light', 'GlowSmart 180W'),
    (30, 7, 'Light', 'GlowSmart 180W'),
    (31, 7, 'Light', 'GlowSmart 180W'),
    (32, 7, 'AC System', 'BreezeCool 5500');

-- Devices for LocationID 8
INSERT INTO Device (DeviceID, LocationID, Type, ModelNumber)
VALUES 
    (33, 8, 'Light', 'LumiTech 150W'),
    (34, 8, 'Light', 'LumiTech 150W'),
    (35, 8, 'Refrigerator', 'Maytag IceMaster 800'),
    (36, 8, 'AC System', 'CoolFlow 7000');

-- Devices for LocationID 9
INSERT INTO Device (DeviceID, LocationID, Type, ModelNumber)
VALUES 
    (37, 9, 'AC System', 'SuperCool 8000'),
    (38, 9, 'Light', 'BrightLite 160W'),
    (39, 9, 'Light', 'BrightLite 160W'),
    (40, 9, 'Light', 'BrightLite 160W');

-- Devices for LocationID 10
INSERT INTO Device (DeviceID, LocationID, Type, ModelNumber)
VALUES 
    (41, 10, 'Light', 'SmartGlow 140W'),
    (42, 10, 'Light', 'SmartGlow 140W'),
    (43, 10, 'Light', 'SmartGlow 140W'),
    (44, 10, 'Refrigerator', 'ElectroCool 950'),
    (45, 10, 'AC System', 'CoolBlast 7000');
    
select * from Device;

-- EnergyPrice Entries
-- Energy prices for ZIP Code 12345
INSERT INTO EnergyPrice (PriceID, ZipCode, Time, PricePerKWh)
VALUES 
    (1, '12345', '00:00:00', 0.1200),
    (2, '12345', '06:00:00', 0.1150),
    (3, '12345', '12:00:00', 0.1180),
    (4, '12345', '18:00:00', 0.1225);

-- Energy prices for ZIP Code 67890
INSERT INTO EnergyPrice (PriceID, ZipCode, Time, PricePerKWh)
VALUES 
    (5, '67890', '00:00:00', 0.1100),
    (6, '67890', '06:00:00', 0.1135),
    (7, '67890', '12:00:00', 0.1120),
    (8, '67890', '18:00:00', 0.1155);

-- Energy prices for ZIP Code 23456
INSERT INTO EnergyPrice (PriceID, ZipCode, Time, PricePerKWh)
VALUES 
    (9, '23456', '00:00:00', 0.1250),
    (10, '23456', '06:00:00', 0.1220),
    (11, '23456', '12:00:00', 0.1245),
    (12, '23456', '18:00:00', 0.1275);

-- Energy prices for ZIP Code 56789
INSERT INTO EnergyPrice (PriceID, ZipCode, Time, PricePerKWh)
VALUES 
    (13, '56789', '00:00:00', 0.1185),
    (14, '56789', '06:00:00', 0.1205),
    (15, '56789', '12:00:00', 0.1170),
    (16, '56789', '18:00:00', 0.1195);
    
select * from EnergyPrice;

delete from EnergyPrice;

-- EventData Entries
-- Device 1 AC
-- Event data for DeviceID 1 on August 15, 2022
INSERT INTO EventData (DataID, DeviceID, Timestamp, EventType, Value)
VALUES 
    (1, 1, '2022-08-15 08:00:00', 'switched on', NULL),
    (2, 1, '2022-08-15 08:00:00', 'energy use', 0.21),
    (3, 1, '2022-08-15 08:30:00', 'energy use', 0.21),
    (4, 1, '2022-08-15 09:00:00', 'energy use', 0.19),
    (5, 1, '2022-08-15 09:30:00', 'energy use', 0.17),
    (6, 1, '2022-08-15 10:00:00', 'energy use', 0.15),
    (7, 1, '2022-08-15 10:30:00', 'temperature changed', 75),
    (8, 1, '2022-08-15 10:30:00', 'energy use', 0.14),
    (9, 1, '2022-08-15 11:00:00', 'energy use', 0.13),
    (10, 1, '2022-08-15 11:30:00', 'energy use', 0.12),
    (11, 1, '2022-08-15 12:00:00', 'energy use', 0.11),
    (12, 1, '2022-08-15 12:30:00', 'energy use', 0.10),
    (13, 1, '2022-08-15 13:00:00', 'energy use', 0.09),
    (14, 1, '2022-08-15 13:30:00', 'energy use', 0.08),
    (15, 1, '2022-08-15 14:00:00', 'energy use', 0.10),
    (16, 1, '2022-08-15 14:30:00', 'energy use', 0.12),
    (17, 1, '2022-08-15 15:00:00', 'energy use', 0.14),
    (18, 1, '2022-08-15 15:30:00', 'energy use', 0.16),
    (19, 1, '2022-08-15 16:00:00', 'energy use', 0.18),
    (20, 1, '2022-08-15 16:30:00', 'energy use', 0.20),
    (21, 1, '2022-08-15 16:30:00', 'switched off', NULL);
    
-- For Device 3 Light
-- Additional Event data for DeviceID 3 on August 17, 20, and 22, 2022
INSERT INTO EventData (DataID, DeviceID, Timestamp, EventType, Value)
VALUES 
    -- August 17, 2022
    (22, 3, '2022-08-17 09:00:00', 'switched on', NULL),
    (23, 3, '2022-08-17 9:00:00', 'energy use', 0.00),
    (24, 3, '2022-08-17 9:30:00', 'energy use', 0.12),
    (25, 3, '2022-08-17 10:00:00', 'energy use', 0.15),
    (26, 3, '2022-08-17 10:30:00', 'energy use', 0.13),
    (27, 3, '2022-08-17 11:00:00', 'energy use', 0.11),
    (28, 3, '2022-08-17 11:30:00', 'energy use', 0.09),
    (29, 3, '2022-08-17 12:30:00', 'brightness changed', 50),
    (30, 3, '2022-08-17 12:45:00', 'switched off', NULL),
    (31, 3, '2022-08-17 13:00:00', 'energy use', 0.10),
    (32, 3, '2022-08-17 16:30:00', 'switched on', NULL),
    (33, 3, '2022-08-17 16:30:00', 'energy use', 0.00),
    (34, 3, '2022-08-17 15:00:00', 'energy use', 0.15),
    (35, 3, '2022-08-17 15:30:00', 'energy use', 0.13),
    (36, 3, '2022-08-17 16:00:00', 'energy use', 0.11),
    (37, 3, '2022-08-17 16:30:00', 'energy use', 0.09),
    (38, 3, '2022-08-17 17:00:00', 'switched off', NULL),
    (39, 3, '2022-08-17 17:00:00', 'energy use', 0.14);
    -- ... (add more events for DeviceID 3 on August 17, 2022)

INSERT INTO EventData (DataID, DeviceID, Timestamp, EventType, Value)
VALUES
    -- August 20, 2022
    (40, 3, '2022-08-20 08:30:00', 'switched on', NULL),
    (41, 3, '2022-08-17 8:30:00', 'energy use', 0.00),
    (42, 3, '2022-08-17 9:00:00', 'energy use', 0.12),
    (43, 3, '2022-08-17 9:30:00', 'energy use', 0.12),
    (44, 3, '2022-08-17 10:00:00', 'energy use', 0.15),
    (45, 3, '2022-08-17 10:30:00', 'energy use', 0.13),
    (46, 3, '2022-08-20 11:00:00', 'brightness changed', 60),
    (47, 3, '2022-08-17 11:00:00', 'energy use', 0.11),
    (48, 3, '2022-08-17 11:30:00', 'energy use', 0.09),
    (49, 3, '2022-08-20 12:00:00', 'energy use', 0.18),
    (50, 3, '2022-08-20 12:30:00', 'energy use', 0.20),
    (51, 3, '2022-08-20 13:00:00', 'energy use', 0.22),
    (52, 3, '2022-08-20 13:15:00', 'switched off', NULL),
    (53, 3, '2022-08-20 13:30:00', 'energy use', 0.10),
    (54, 3, '2022-08-20 16:30:00', 'switched on', NULL),
    (55, 3, '2022-08-20 16:30:00', 'energy use', 0.00),
    (56, 3, '2022-08-20 17:00:00', 'energy use', 0.20),
    (57, 3, '2022-08-20 17:30:00', 'energy use', 0.22),
    (58, 3, '2022-08-20 18:00:00', 'switched off', NULL),
    (59, 3, '2022-08-20 18:00:00', 'energy use', 0.21);
    -- ... (add more events for DeviceID 3 on August 20, 2022)

   --  -- August 22, 2022
--     (153, 3, '2022-08-22 10:00:00', 'switched on', NULL),
--     (154, 3, '2022-08-22 12:30:00', 'brightness changed', 70),
--     (155, 3, '2022-08-22 14:45:00', 'switched off', NULL),
--     (156, 3, '2022-08-22 15:00:00', 'energy use', 0.22),
--     (157, 3, '2022-08-22 15:30:00', 'energy use', 0.21),
--     (158, 3, '2022-08-22 16:00:00', 'energy use', 0.19),
--     (159, 3, '2022-08-22 16:30:00',

-- For Device 7 Ligth
-- Event data for DeviceID 7 on August 27 and 28, 2022
INSERT INTO EventData (DataID, DeviceID, Timestamp, EventType, Value)
VALUES 
    -- August 27, 2022
    (60, 7, '2022-08-27 10:00:00', 'switched on', NULL),
    (61, 7, '2022-08-27 10:00:00', 'energy use', 0.00),
    (62, 7, '2022-08-27 10:30:00', 'energy use', 0.12),
    (63, 7, '2022-08-27 11:00:00', 'energy use', 0.15),
    (64, 7, '2022-08-27 11:30:00', 'energy use', 0.13),
    (65, 7, '2022-08-27 12:00:00', 'energy use', 0.11),
    (66, 7, '2022-08-27 12:30:00', 'energy use', 0.09),
    (67, 7, '2022-08-27 12:30:00', 'brightness changed', 40),
    (68, 7, '2022-08-27 12:30:00', 'energy use', 0.10),
    (69, 7, '2022-08-27 13:00:00', 'energy use', 0.15),
    (70, 7, '2022-08-27 13:30:00', 'energy use', 0.13),
    (71, 7, '2022-08-27 14:00:00', 'energy use', 0.11),
    (72, 7, '2022-08-27 14:45:00', 'switched off', NULL),
    (73, 7, '2022-08-27 15:00:00', 'energy use', 0.07),
    (74, 7, '2022-08-27 15:30:00', 'energy use', 0.12),
    (75, 7, '2022-08-27 16:00:00', 'energy use', 0.15),
    (76, 7, '2022-08-27 16:30:00', 'energy use', 0.13),
    (77, 7, '2022-08-27 17:00:00', 'energy use', 0.11),
    (78, 7, '2022-08-27 17:30:00', 'energy use', 0.09),
    (79, 7, '2022-08-27 18:30:00', 'switched on', NULL),
    (80, 7, '2022-08-27 18:30:00', 'energy use', 0.00),
    (81, 7, '2022-08-27 17:00:00', 'energy use', 0.15),
    (82, 7, '2022-08-27 17:30:00', 'energy use', 0.13),
    (83, 7, '2022-08-27 18:00:00', 'energy use', 0.11),
    (84, 7, '2022-08-27 18:30:00', 'energy use', 0.09),
    (85, 7, '2022-08-27 19:00:00', 'energy use', 0.15),
    (86, 7, '2022-08-27 19:30:00', 'energy use', 0.13),
    (87, 7, '2022-08-27 20:00:00', 'switched off', NULL),
    (88, 7, '2022-08-27 20:00:00', 'energy use', 0.14);
    -- ... (add more events for DeviceID 7 on August 27, 2022)

  --   -- August 28, 2022
--     (73, 7, '2022-08-28 08:30:00', 'switched on', NULL),
--     (74, 7, '2022-08-28 11:00:00', 'volume changed', 60),
--     (75, 7, '2022-08-28 13:15:00', 'switched off', NULL),
--     (76, 7, '2022-08-28 13:30:00', 'energy use', 0.18),
--     (77, 7, '2022-08-28 14:00:00', 'energy use', 0.20),
--     (78, 7, '2022-08-28 14:30:00', 'energy use', 0.22),
--     (79, 7, '2022-08-28 15:00:00', 'energy use', 0.21),
--     (80, 7, '2022-08-28 15:30:00', 'energy use', 0.19),
--     (81, 7, '2022-08-28 16:30:00', 'switched on', NULL),
--     (82, 7, '2022-08-28 18:00:00', 'switched off', NULL),
--     (83, 7, '2022-08-28 18:15:00', 'energy use', 0.17),
--     (84, 7, '2022-08-28 18:45:00', 'energy use', 0.15),
--     -- ... (add more events for DeviceID 7 on August 28, 2022)

-- For Device 2 Refrigerator
-- Event data for DeviceID 2 on September 23, 2022
INSERT INTO EventData (DataID, DeviceID, Timestamp, EventType, Value)
VALUES 
    (89, 2, '2022-09-23 08:00:00', 'switched on', NULL),
    (90, 2, '2022-09-23 08:30:00', 'energy use', 0.20),
    (91, 2, '2022-09-23 09:00:00', 'energy use', 0.20),
    (92, 2, '2022-09-23 09:30:00', 'energy use', 0.20),
    (93, 2, '2022-09-23 10:00:00', 'energy use', 0.20),
    (94, 2, '2022-09-23 10:30:00', 'energy use', 0.20),
    (95, 2, '2022-09-23 10:30:00', 'door opened', NULL),
    (96, 2, '2022-09-23 11:00:00', 'energy use', 0.27),
    (97, 2, '2022-09-23 11:15:00', 'door closed', NULL),
    (98, 2, '2022-09-23 11:30:00', 'energy use', 0.23),
    (99, 2, '2022-09-23 12:00:00', 'energy use', 0.20),
    (100, 2, '2022-09-23 12:30:00', 'energy use', 0.20),
    (101, 2, '2022-09-23 13:00:00', 'energy use', 0.20),
    (102, 2, '2022-09-23 13:30:00', 'energy use', 0.15),
    (103, 2, '2022-09-23 14:00:00', 'energy use', 0.15),
    (104, 2, '2022-09-23 14:30:00', 'energy use', 0.15),
    (105, 2, '2022-09-23 15:00:00', 'energy use', 0.15),
    (106, 2, '2022-09-23 15:30:00', 'energy use', 0.15),
    (107, 2, '2022-09-23 16:00:00', 'energy use', 0.15),
    (108, 2, '2022-09-23 16:30:00', 'energy use', 0.15),
    (109, 2, '2022-09-23 16:30:00', 'door opened', NULL),
    (110, 2, '2022-09-23 16:55:00', 'door closed', NULL),
    (111, 2, '2022-09-23 17:00:00', 'energy use', 0.20),
    (112, 2, '2022-09-23 17:30:00', 'energy use', 0.15),
    (113, 2, '2022-09-23 18:00:00', 'energy use', 0.15),
    (114, 2, '2022-09-23 18:30:00', 'energy use', 0.15),
    (115, 2, '2022-09-23 19:00:00', 'energy use', 0.20),
    (116, 2, '2022-09-23 19:30:00', 'energy use', 0.20),
    (117, 2, '2022-09-23 20:00:00', 'energy use', 0.20),
    (119, 2, '2022-09-23 20:00:00', 'switched off', NULL);
    
    
    -- (101, 2, '2022-09-23 20:30:00', 'energy use', 0.20),
--     (102, 2, '2022-09-23 21:00:00', 'energy use', 0.20),
--     (103, 2, '2022-09-23 21:30:00', 'energy use', 0.20),
-- 	(104, 2, '2022-09-23 21:30:00', 'energy use', 0.20),
--     (105, 2, '2022-09-23 22:00:00', 'door opened', NULL),
--     (106, 2, '2022-09-23 23:30:00', 'energy use', 0.25),
--     (107, 2, '2022-09-23 23:45:00', 'door closed', NULL),
--     (108, 2, '2022-09-24 00:00:00', 'energy use', 0.25),
--     (109, 2, '2022-09-24 00:30:00', 'energy use', 0.25),
--     (110, 2, '2022-09-24 01:00:00', 'energy use', 0.25),
--     (111, 2, '2022-09-24 01:30:00', 'energy use', 0.25),
--     (112, 2, '2022-09-24 02:00:00', 'energy use', 0.25),
--     (113, 2, '2022-09-24 02:30:00', 'energy use', 0.25),
--     (114, 2, '2022-09-24 03:00:00', 'energy use', 0.25),
--     (115, 2, '2022-09-24 03:30:00', 'energy use', 0.25),
--     (116, 2, '2022-09-24 04:00:00', 'energy use', 0.25),
--     (117, 2, '2022-09-24 04:30:00', 'energy use', 0.25),
--     (118, 2, '2022-09-24 05:00:00', 'energy use', 0.25),
--     (119, 2, '2022-09-24 05:30:00', 'energy use', 0.25),
--     (120, 2, '2022-09-24 06:00:00', 'energy use', 0.25),
    -- ... (add more events for DeviceID 2 on September 23, 2022)
    
select * from Device;

-- For Device 20 Light
-- Event data for DeviceID 20 on August 21, 2022
INSERT INTO EventData (DataID, DeviceID, Timestamp, EventType, Value)
VALUES 
    (120, 20, '2022-08-21 10:00:00', 'switched on', NULL),
    (121, 20, '2022-08-21 10:00:00', 'energy use', 0.00),
    (122, 20, '2022-08-21 10:30:00', 'energy use', 0.12),
    (123, 20, '2022-08-21 11:00:00', 'energy use', 0.15),
    (124, 20, '2022-08-21 11:30:00', 'energy use', 0.13),
    (125, 20, '2022-08-21 12:00:00', 'energy use', 0.13),
    (126, 20, '2022-08-21 12:30:00', 'energy use', 0.13),
    (127, 20, '2022-08-21 12:30:00', 'brightness changed', 40),
    (128, 20, '2022-08-21 12:30:00', 'energy use', 0.10),
    (129, 20, '2022-08-21 13:00:00', 'energy use', 0.15),
    (130, 20, '2022-08-21 13:30:00', 'energy use', 0.13),
    (131, 20, '2022-08-21 14:00:00', 'energy use', 0.13),
    (132, 20, '2022-08-21 14:45:00', 'switched off', NULL),
    (133, 20, '2022-08-21 15:00:00', 'energy use', 0.13),
    (134, 20, '2022-08-21 15:30:00', 'energy use', 0.12),
    (135, 20, '2022-08-21 16:00:00', 'energy use', 0.15),
    (136, 20, '2022-08-21 16:30:00', 'energy use', 0.13),
    (137, 20, '2022-08-21 17:00:00', 'energy use', 0.11),
    (138, 20, '2022-08-21 17:30:00', 'energy use', 0.13),
    (139, 20, '2022-08-21 18:30:00', 'switched on', NULL),
    (140, 20, '2022-08-21 18:30:00', 'energy use', 0.00),
    (141, 20, '2022-08-21 17:00:00', 'energy use', 0.15),
    (142, 20, '2022-08-21 17:30:00', 'energy use', 0.13),
    (143, 20, '2022-08-21 18:00:00', 'energy use', 0.13),
    (144, 20, '2022-08-21 18:30:00', 'energy use', 0.13),
    (145, 20, '2022-08-21 19:00:00', 'energy use', 0.15),
    (146, 20, '2022-08-21 19:30:00', 'energy use', 0.13),
    (147, 20, '2022-08-21 20:00:00', 'switched off', NULL),
    (148, 20, '2022-08-21 20:00:00', 'energy use', 0.14);
    
-- For Device 28 Refrigerator
-- Event data for DeviceID 28 on August 23, 2022
INSERT INTO EventData (DataID, DeviceID, Timestamp, EventType, Value)
VALUES 
    (149, 28, '2022-09-23 08:00:00', 'switched on', NULL),
    (150, 28, '2022-09-23 08:30:00', 'energy use', 0.18),
    (151, 28, '2022-09-23 09:00:00', 'energy use', 0.18),
    (152, 28, '2022-09-23 09:30:00', 'energy use', 0.18),
    (153, 28, '2022-09-23 10:00:00', 'energy use', 0.18),
    (154, 28, '2022-09-23 10:30:00', 'energy use', 0.18),
    (155, 28, '2022-09-23 10:30:00', 'door opened', NULL),
    (156, 28, '2022-09-23 11:00:00', 'energy use', 0.25),
    (157, 28, '2022-09-23 11:15:00', 'door closed', NULL),
    (158, 28, '2022-09-23 11:30:00', 'energy use', 0.21),
    (159, 28, '2022-09-23 12:00:00', 'energy use', 0.18),
    (160, 28, '2022-09-23 12:30:00', 'energy use', 0.18),
    (161, 28, '2022-09-23 13:00:00', 'energy use', 0.18),
    (162, 28, '2022-09-23 13:30:00', 'energy use', 0.13),
    (163, 28, '2022-09-23 14:00:00', 'energy use', 0.13),
    (164, 28, '2022-09-23 14:30:00', 'energy use', 0.13),
    (165, 28, '2022-09-23 15:00:00', 'energy use', 0.13),
    (166, 28, '2022-09-23 15:30:00', 'energy use', 0.13),
    (167, 28, '2022-09-23 16:00:00', 'energy use', 0.13),
    (168, 28, '2022-09-23 16:30:00', 'energy use', 0.13),
    (169, 28, '2022-09-23 16:30:00', 'door opened', NULL),
    (170, 28, '2022-09-23 16:55:00', 'door closed', NULL),
    (171, 28, '2022-09-23 17:00:00', 'energy use', 0.18),
    (172, 28, '2022-09-23 17:30:00', 'energy use', 0.13),
    (173, 28, '2022-09-23 18:00:00', 'energy use', 0.13),
    (174, 28, '2022-09-23 18:30:00', 'energy use', 0.13),
    (175, 28, '2022-09-23 19:00:00', 'energy use', 0.18),
    (176, 28, '2022-09-23 19:30:00', 'energy use', 0.18),
    (177, 28, '2022-09-23 20:00:00', 'energy use', 0.18),
    (179, 28, '2022-09-23 20:00:00', 'switched off', NULL);
    
-- For Device 28 Refrigerator September
-- Event data for DeviceID 28 on September 14, 2022
INSERT INTO EventData (DataID, DeviceID, Timestamp, EventType, Value)
VALUES 
    (180, 28, '2022-09-14 08:00:00', 'switched on', NULL),
    (181, 28, '2022-09-14 08:30:00', 'energy use', 0.21),
    (182, 28, '2022-09-14 09:00:00', 'energy use', 0.21),
    (183, 28, '2022-09-14 09:30:00', 'energy use', 0.21),
    (184, 28, '2022-09-14 10:00:00', 'energy use', 0.21),
    (185, 28, '2022-09-14 10:30:00', 'energy use', 0.21),
    (186, 28, '2022-09-14 10:30:00', 'door opened', NULL),
    (187, 28, '2022-09-14 11:00:00', 'energy use', 0.28),
    (188, 28, '2022-09-14 11:15:00', 'door closed', NULL),
    (189, 28, '2022-09-14 11:30:00', 'energy use', 0.24),
    (190, 28, '2022-09-14 12:00:00', 'energy use', 0.21),
    (191, 28, '2022-09-14 12:30:00', 'energy use', 0.21),
    (192, 28, '2022-09-14 13:00:00', 'energy use', 0.21),
    (193, 28, '2022-09-14 13:30:00', 'energy use', 0.16),
    (194, 28, '2022-09-14 14:00:00', 'energy use', 0.16),
    (195, 28, '2022-09-14 14:30:00', 'energy use', 0.16),
    (196, 28, '2022-09-14 15:00:00', 'energy use', 0.16),
    (197, 28, '2022-09-14 15:30:00', 'energy use', 0.16),
    (198, 28, '2022-09-14 16:00:00', 'energy use', 0.16),
    (199, 28, '2022-09-14 16:30:00', 'energy use', 0.16),
    (200, 28, '2022-09-14 16:30:00', 'door opened', NULL),
    (201, 28, '2022-09-14 16:55:00', 'door closed', NULL),
    (202, 28, '2022-09-14 17:00:00', 'energy use', 0.21),
    (203, 28, '2022-09-14 17:30:00', 'energy use', 0.16),
    (204, 28, '2022-09-14 18:00:00', 'energy use', 0.16),
    (205, 28, '2022-09-14 18:30:00', 'energy use', 0.16),
    (206, 28, '2022-09-14 19:00:00', 'energy use', 0.21),
    (207, 28, '2022-09-14 19:30:00', 'energy use', 0.21),
    (208, 28, '2022-09-14 20:00:00', 'energy use', 0.21),
    (209, 28, '2022-09-14 20:00:00', 'switched off', NULL);
    
select * from Device;

-- For Device 45 AC
-- Event data for DeviceID 45 on August 19, 2022
INSERT INTO EventData (DataID, DeviceID, Timestamp, EventType, Value)
VALUES 
    (210, 45, '2022-08-19 08:00:00', 'switched on', NULL),
    (211, 45, '2022-08-19 08:00:00', 'energy use', 0.22),
    (212, 45, '2022-08-19 08:30:00', 'energy use', 0.22),
    (213, 45, '2022-08-19 09:00:00', 'energy use', 0.20),
    (214, 45, '2022-08-19 09:30:00', 'energy use', 0.18),
    (215, 45, '2022-08-19 10:00:00', 'energy use', 0.16),
    (216, 45, '2022-08-19 10:30:00', 'temperature changed', 76),
    (217, 45, '2022-08-19 10:30:00', 'energy use', 0.15),
    (218, 45, '2022-08-19 11:00:00', 'energy use', 0.14),
    (219, 45, '2022-08-19 11:30:00', 'energy use', 0.13),
    (220, 45, '2022-08-19 12:00:00', 'energy use', 0.12),
    (221, 45, '2022-08-19 12:30:00', 'energy use', 0.11),
    (222, 45, '2022-08-19 13:00:00', 'energy use', 0.10),
    (223, 45, '2022-08-19 13:30:00', 'energy use', 0.09),
    (224, 45, '2022-08-19 14:00:00', 'energy use', 0.11),
    (225, 45, '2022-08-19 14:30:00', 'energy use', 0.13),
    (226, 45, '2022-08-19 15:00:00', 'energy use', 0.15),
    (227, 45, '2022-08-19 15:30:00', 'energy use', 0.17),
    (228, 45, '2022-08-19 16:00:00', 'energy use', 0.19),
    (229, 45, '2022-08-19 16:30:00', 'energy use', 0.21),
    (230, 45, '2022-08-19 16:30:00', 'switched off', NULL);
    

-- For Device 45 AC September
-- Event data for DeviceID 45 on September 15, 2022
INSERT INTO EventData (DataID, DeviceID, Timestamp, EventType, Value)
VALUES 
    (231, 45, '2022-09-15 08:00:00', 'switched on', NULL),
    (232, 45, '2022-09-15 08:00:00', 'energy use', 0.24),
    (233, 45, '2022-09-15 08:30:00', 'energy use', 0.24),
    (234, 45, '2022-09-15 09:00:00', 'energy use', 0.22),
    (235, 45, '2022-09-15 09:30:00', 'energy use', 0.20),
    (236, 45, '2022-09-15 10:00:00', 'energy use', 0.18),
    (237, 45, '2022-09-15 10:30:00', 'temperature changed', 76),
    (238, 45, '2022-09-15 10:30:00', 'energy use', 0.17),
    (239, 45, '2022-09-15 11:00:00', 'energy use', 0.16),
    (240, 45, '2022-09-15 11:30:00', 'energy use', 0.15),
    (241, 45, '2022-09-15 12:00:00', 'energy use', 0.14),
    (242, 45, '2022-09-15 12:30:00', 'energy use', 0.13),
    (243, 45, '2022-09-15 13:00:00', 'energy use', 0.12),
    (244, 45, '2022-09-15 13:30:00', 'energy use', 0.11),
    (245, 45, '2022-09-15 14:00:00', 'energy use', 0.13),
    (246, 45, '2022-09-15 14:30:00', 'energy use', 0.15),
    (247, 45, '2022-09-15 15:00:00', 'energy use', 0.17),
    (248, 45, '2022-09-15 15:30:00', 'energy use', 0.19),
    (249, 45, '2022-09-15 16:00:00', 'energy use', 0.21),
    (250, 45, '2022-09-15 16:30:00', 'energy use', 0.23),
    (251, 45, '2022-09-15 16:30:00', 'switched off', NULL);
    
select * from Device;


-- For Device 41 Light
-- Event data for DeviceID 41 on August 23, 2022
INSERT INTO EventData (DataID, DeviceID, Timestamp, EventType, Value)
VALUES 
    (252, 41, '2022-08-23 10:00:00', 'switched on', NULL),
    (253, 41, '2022-08-23 10:00:00', 'energy use', 0.00),
    (254, 41, '2022-08-23 10:30:00', 'energy use', 0.14),
    (255, 41, '2022-08-23 11:00:00', 'energy use', 0.13),
    (256, 41, '2022-08-23 11:30:00', 'energy use', 0.11),
    (257, 41, '2022-08-23 12:00:00', 'energy use', 0.15),
    (258, 41, '2022-08-23 12:30:00', 'energy use', 0.11),
    (259, 41, '2022-08-23 12:30:00', 'brightness changed', 40),
    (260, 41, '2022-08-23 12:30:00', 'energy use', 0.12),
    (261, 41, '2022-08-23 13:00:00', 'energy use', 0.17),
    (262, 41, '2022-08-23 13:30:00', 'energy use', 0.15),
    (263, 41, '2022-08-23 14:00:00', 'energy use', 0.11),
    (264, 41, '2022-08-23 14:45:00', 'switched off', NULL),
    (265, 41, '2022-08-23 15:00:00', 'energy use', 0.09),
    (266, 41, '2022-08-23 18:30:00', 'switched on', NULL),
    (267, 41, '2022-08-23 18:30:00', 'energy use', 0.00),
    (268, 41, '2022-08-23 17:00:00', 'energy use', 0.17),
    (269, 41, '2022-08-23 17:30:00', 'energy use', 0.13),
    (270, 41, '2022-08-23 18:00:00', 'energy use', 0.15),
    (271, 41, '2022-08-23 18:30:00', 'energy use', 0.13),
    (272, 41, '2022-08-23 19:00:00', 'energy use', 0.13),
    (273, 41, '2022-08-23 19:30:00', 'energy use', 0.15),
    (274, 41, '2022-08-23 20:00:00', 'switched off', NULL),
    (275, 41, '2022-08-23 20:00:00', 'energy use', 0.12);
    
-- For Device 41 Light September
-- Event data for DeviceID 41 on September 09, 2022
INSERT INTO EventData (DataID, DeviceID, Timestamp, EventType, Value)
VALUES 
    (276, 41, '2022-09-09 10:00:00', 'switched on', NULL),
    (277, 41, '2022-09-09 10:00:00', 'energy use', 0.04),
    (278, 41, '2022-09-09 10:30:00', 'energy use', 0.13),
    (279, 41, '2022-09-09 11:00:00', 'energy use', 0.15),
    (280, 41, '2022-09-09 11:30:00', 'energy use', 0.13),
    (281, 41, '2022-09-09 12:00:00', 'energy use', 0.17),
    (282, 41, '2022-09-09 12:30:00', 'energy use', 0.11),
    (283, 41, '2022-09-09 12:30:00', 'brightness changed', 40),
    (284, 41, '2022-09-09 12:30:00', 'energy use', 0.14),
    (285, 41, '2022-09-09 13:00:00', 'energy use', 0.19),
    (286, 41, '2022-09-09 13:30:00', 'energy use', 0.19),
    (287, 41, '2022-09-09 14:00:00', 'energy use', 0.15),
    (288, 41, '2022-09-09 14:45:00', 'switched off', NULL),
    (289, 41, '2022-09-09 15:00:00', 'energy use', 0.11),
    (290, 41, '2022-09-09 18:30:00', 'switched on', NULL),
    (291, 41, '2022-09-09 18:30:00', 'energy use', 0.04),
    (292, 41, '2022-09-09 17:00:00', 'energy use', 0.19),
    (293, 41, '2022-09-09 17:30:00', 'energy use', 0.17),
    (294, 41, '2022-09-09 18:00:00', 'energy use', 0.17),
    (295, 41, '2022-09-09 18:30:00', 'energy use', 0.15),
    (296, 41, '2022-09-09 19:00:00', 'energy use', 0.15),
    (297, 41, '2022-09-09 19:30:00', 'energy use', 0.17),
    (298, 41, '2022-09-09 20:00:00', 'switched off', NULL),
    (299, 41, '2022-09-09 20:00:00', 'energy use', 0.14);
    
select * from Device;

-- For Device 35 Refrigerator
-- Event data for DeviceID 35 on August 08, 2022
INSERT INTO EventData (DataID, DeviceID, Timestamp, EventType, Value)
VALUES 
    (300, 35, '2022-08-08 08:00:00', 'switched on', NULL),
    (301, 35, '2022-08-08 08:30:00', 'energy use', 0.14),
    (302, 35, '2022-08-08 09:00:00', 'energy use', 0.14),
    (303, 35, '2022-08-08 09:30:00', 'energy use', 0.14),
    (304, 35, '2022-08-08 10:00:00', 'energy use', 0.14),
    (305, 35, '2022-08-08 10:30:00', 'energy use', 0.14),
    (306, 35, '2022-08-08 10:30:00', 'door opened', NULL),
    (307, 35, '2022-08-08 11:00:00', 'energy use', 0.21),
    (308, 35, '2022-08-08 11:15:00', 'door closed', NULL),
    (309, 35, '2022-08-08 11:30:00', 'energy use', 0.17),
    (310, 35, '2022-08-08 12:00:00', 'energy use', 0.14),
    (311, 35, '2022-08-08 12:30:00', 'energy use', 0.14),
    (312, 35, '2022-08-08 13:00:00', 'energy use', 0.14),
    (313, 35, '2022-08-08 13:30:00', 'energy use', 0.09),
    (314, 35, '2022-08-08 14:00:00', 'energy use', 0.09),
    (315, 35, '2022-08-08 14:30:00', 'energy use', 0.09),
    (316, 35, '2022-08-08 15:00:00', 'energy use', 0.09),
    (317, 35, '2022-08-08 15:30:00', 'energy use', 0.09),
    (318, 35, '2022-08-08 16:00:00', 'energy use', 0.09),
    (319, 35, '2022-08-08 16:30:00', 'energy use', 0.09),
    (320, 35, '2022-08-08 16:30:00', 'door opened', NULL),
    (321, 35, '2022-08-08 16:55:00', 'door closed', NULL),
    (322, 35, '2022-08-08 17:00:00', 'energy use', 0.14),
    (323, 35, '2022-08-08 17:30:00', 'energy use', 0.09),
    (324, 35, '2022-08-08 18:00:00', 'energy use', 0.09),
    (325, 35, '2022-08-08 18:30:00', 'energy use', 0.09),
    (326, 35, '2022-08-08 19:00:00', 'energy use', 0.14),
    (327, 35, '2022-08-08 19:30:00', 'energy use', 0.14),
    (328, 35, '2022-08-08 20:00:00', 'energy use', 0.14),
    (330, 35, '2022-08-08 20:00:00', 'switched off', NULL);
    
-- For Device 35 Regrigerator September
-- Event data for DeviceID 35 on September 06, 2022
INSERT INTO EventData (DataID, DeviceID, Timestamp, EventType, Value)
VALUES 
    (331, 35, '2022-09-06 08:00:00', 'switched on', NULL),
    (332, 35, '2022-09-06 08:30:00', 'energy use', 0.16),
    (333, 35, '2022-09-06 09:00:00', 'energy use', 0.16),
    (334, 35, '2022-09-06 09:30:00', 'energy use', 0.16),
    (335, 35, '2022-09-06 10:00:00', 'energy use', 0.16),
    (336, 35, '2022-09-06 10:30:00', 'energy use', 0.16),
    (337, 35, '2022-09-06 10:30:00', 'door opened', NULL),
    (338, 35, '2022-09-06 11:00:00', 'energy use', 0.23),
    (339, 35, '2022-09-06 11:15:00', 'door closed', NULL),
    (340, 35, '2022-09-06 11:30:00', 'energy use', 0.19),
    (341, 35, '2022-09-06 12:00:00', 'energy use', 0.16),
    (342, 35, '2022-09-06 12:30:00', 'energy use', 0.16),
    (343, 35, '2022-09-06 13:00:00', 'energy use', 0.16),
    (344, 35, '2022-09-06 13:30:00', 'energy use', 0.11),
    (345, 35, '2022-09-06 14:00:00', 'energy use', 0.11),
    (346, 35, '2022-09-06 14:30:00', 'energy use', 0.11),
    (347, 35, '2022-09-06 15:00:00', 'energy use', 0.11),
    (348, 35, '2022-09-06 15:30:00', 'energy use', 0.11),
    (349, 35, '2022-09-06 16:00:00', 'energy use', 0.11),
    (350, 35, '2022-09-06 16:30:00', 'energy use', 0.11),
    (351, 35, '2022-09-06 16:30:00', 'door opened', NULL),
    (352, 35, '2022-09-06 16:55:00', 'door closed', NULL),
    (353, 35, '2022-09-06 17:00:00', 'energy use', 0.16),
    (354, 35, '2022-09-06 17:30:00', 'energy use', 0.11),
    (355, 35, '2022-09-06 18:00:00', 'energy use', 0.11),
    (356, 35, '2022-09-06 18:30:00', 'energy use', 0.11),
    (357, 35, '2022-09-06 19:00:00', 'energy use', 0.16),
    (358, 35, '2022-09-06 19:30:00', 'energy use', 0.16),
    (359, 35, '2022-09-06 20:00:00', 'energy use', 0.16),
    (361, 35, '2022-09-06 20:00:00', 'switched off', NULL);
    
select * from Device;

-- For Device 33 Light
-- Event data for DeviceID 33 on August 10, 2022
INSERT INTO EventData (DataID, DeviceID, Timestamp, EventType, Value)
VALUES 
    (362, 33, '2022-08-10 10:00:00', 'switched on', NULL),
    (363, 33, '2022-08-10 10:00:00', 'energy use', 0.03),
    (364, 33, '2022-08-10 10:30:00', 'energy use', 0.12),
    (365, 33, '2022-08-10 11:00:00', 'energy use', 0.11),
    (366, 33, '2022-08-10 11:30:00', 'energy use', 0.09),
    (367, 33, '2022-08-10 12:00:00', 'energy use', 0.14),
    (368, 33, '2022-08-10 12:30:00', 'energy use', 0.09),
    (369, 33, '2022-08-10 12:30:00', 'brightness changed', 40),
    (370, 33, '2022-08-10 12:30:00', 'energy use', 0.10),
    (371, 33, '2022-08-10 13:00:00', 'energy use', 0.15),
    (372, 33, '2022-08-10 13:30:00', 'energy use', 0.13),
    (373, 33, '2022-08-10 14:00:00', 'energy use', 0.09),
    (374, 33, '2022-08-10 14:45:00', 'switched off', NULL),
    (375, 33, '2022-08-10 15:00:00', 'energy use', 0.07),
    (376, 33, '2022-08-10 18:30:00', 'switched on', NULL),
    (377, 33, '2022-08-10 18:30:00', 'energy use', 0.00),
    (378, 33, '2022-08-10 17:00:00', 'energy use', 0.17),
    (379, 33, '2022-08-10 17:30:00', 'energy use', 0.13),
    (380, 33, '2022-08-10 18:00:00', 'energy use', 0.15),
    (381, 33, '2022-08-10 18:30:00', 'energy use', 0.13),
    (382, 33, '2022-08-10 19:00:00', 'energy use', 0.13),
    (383, 33, '2022-08-10 19:30:00', 'energy use', 0.15),
    (384, 33, '2022-08-10 20:00:00', 'switched off', NULL),
    (385, 33, '2022-08-10 20:00:00', 'energy use', 0.10);
    
-- For Device 33 Light September
-- Event data for DeviceID 33 on September 03, 2022
INSERT INTO EventData (DataID, DeviceID, Timestamp, EventType, Value)
VALUES 
    (386, 33, '2022-09-03 10:00:00', 'switched on', NULL),
    (387, 33, '2022-09-03 10:00:00', 'energy use', 0.12),
    (388, 33, '2022-09-03 10:30:00', 'energy use', 0.14),
    (389, 33, '2022-09-03 11:00:00', 'energy use', 0.13),
    (390, 33, '2022-09-03 11:30:00', 'energy use', 0.11),
    (391, 33, '2022-09-03 12:00:00', 'energy use', 0.16),
    (392, 33, '2022-09-03 12:30:00', 'energy use', 0.11),
    (393, 33, '2022-09-03 12:30:00', 'brightness changed', 40),
    (394, 33, '2022-09-03 12:30:00', 'energy use', 0.12),
    (395, 33, '2022-09-03 13:00:00', 'energy use', 0.17),
    (396, 33, '2022-09-03 13:30:00', 'energy use', 0.15),
    (397, 33, '2022-09-03 14:00:00', 'energy use', 0.11),
    (398, 33, '2022-09-03 14:45:00', 'switched off', NULL),
    (399, 33, '2022-09-03 15:00:00', 'energy use', 0.09),
    (400, 33, '2022-09-03 18:30:00', 'switched on', NULL),
    (401, 33, '2022-09-03 18:30:00', 'energy use', 0.05),
    (402, 33, '2022-09-03 17:00:00', 'energy use', 0.22),
    (403, 33, '2022-09-03 17:30:00', 'energy use', 0.18),
    (404, 33, '2022-09-03 18:00:00', 'energy use', 0.20),
    (405, 33, '2022-09-03 18:30:00', 'energy use', 0.18),
    (406, 33, '2022-09-03 19:00:00', 'energy use', 0.18),
    (407, 33, '2022-09-03 19:30:00', 'energy use', 0.20),
    (408, 33, '2022-09-03 20:00:00', 'switched off', NULL),
    (409, 33, '2022-09-03 20:00:00', 'energy use', 0.15);
    
-- For Device 33 Light Today
-- Event data for DeviceID 33 on November 28, 2023
INSERT INTO EventData (DataID, DeviceID, Timestamp, EventType, Value)
VALUES 
    (410, 33, '2023-11-28 10:00:00', 'switched on', NULL),
    (411, 33, '2023-11-28 10:00:00', 'energy use', 0.12),
    (412, 33, '2023-11-28 10:30:00', 'energy use', 0.14),
    (413, 33, '2023-11-28 11:00:00', 'energy use', 0.13),
    (414, 33, '2023-11-28 11:30:00', 'energy use', 0.11),
    (415, 33, '2023-11-28 12:00:00', 'energy use', 0.16),
    (416, 33, '2023-11-28 12:30:00', 'energy use', 0.11),
    (417, 33, '2023-11-28 12:30:00', 'brightness changed', 40),
    (418, 33, '2023-11-28 12:30:00', 'energy use', 0.12),
    (419, 33, '2023-11-28 13:00:00', 'energy use', 0.17),
    (420, 33, '2023-11-28 13:30:00', 'energy use', 0.15),
    (421, 33, '2023-11-28 14:00:00', 'energy use', 0.11),
    (422, 33, '2023-11-28 14:45:00', 'switched off', NULL),
    (423, 33, '2023-11-28 15:00:00', 'energy use', 0.09),
    (424, 33, '2023-11-28 18:30:00', 'switched on', NULL),
    (425, 33, '2023-11-28 18:30:00', 'energy use', 0.05),
    (426, 33, '2023-11-28 17:00:00', 'energy use', 0.22),
    (427, 33, '2023-11-28 17:30:00', 'energy use', 0.18),
    (428, 33, '2023-11-28 18:00:00', 'energy use', 0.20),
    (429, 33, '2023-11-28 18:30:00', 'energy use', 0.18),
    (430, 33, '2023-11-28 19:00:00', 'energy use', 0.18),
    (431, 33, '2023-11-28 19:30:00', 'energy use', 0.20),
    (432, 33, '2023-11-28 20:00:00', 'switched off', NULL),
    (433, 33, '2023-11-28 20:00:00', 'energy use', 0.15);
    
    
    
select * from Device;

-- For Device 7 Light Today
-- Event data for DeviceID 7 on November 28, 2023
INSERT INTO EventData (DataID, DeviceID, Timestamp, EventType, Value)
VALUES 
    (434, 7, '2023-11-28 10:00:00', 'switched on', NULL),
    (435, 7, '2023-11-28 10:00:00', 'energy use', 0.11),
    (436, 7, '2023-11-28 10:30:00', 'energy use', 0.14),
    (437, 7, '2023-11-28 11:00:00', 'energy use', 0.09),
    (438, 7, '2023-11-28 11:30:00', 'energy use', 0.15),
    (439, 7, '2023-11-28 12:00:00', 'energy use', 0.12),
    (440, 7, '2023-11-28 12:30:00', 'energy use', 0.08),
    (441, 7, '2023-11-28 12:30:00', 'brightness changed', 40),
    (442, 7, '2023-11-28 12:30:00', 'energy use', 0.13),
    (443, 7, '2023-11-28 13:00:00', 'energy use', 0.18),
    (444, 7, '2023-11-28 13:30:00', 'energy use', 0.14),
    (445, 7, '2023-11-28 14:00:00', 'energy use', 0.10),
    (446, 7, '2023-11-28 14:45:00', 'switched off', NULL),
    (447, 7, '2023-11-28 15:00:00', 'energy use', 0.06),
    (448, 7, '2023-11-28 18:30:00', 'switched on', NULL),
    (449, 7, '2023-11-28 18:30:00', 'energy use', 0.02),
    (450, 7, '2023-11-28 17:00:00', 'energy use', 0.19),
    (451, 7, '2023-11-28 17:30:00', 'energy use', 0.14),
    (452, 7, '2023-11-28 18:00:00', 'energy use', 0.16),
    (453, 7, '2023-11-28 18:30:00', 'energy use', 0.14),
    (454, 7, '2023-11-28 19:00:00', 'energy use', 0.14),
    (455, 7, '2023-11-28 19:30:00', 'energy use', 0.16),
    (456, 7, '2023-11-28 20:00:00', 'switched off', NULL),
    (457, 7, '2023-11-28 20:00:00', 'energy use', 0.11);
    
select * from Device;

-- For Device 19 AC Today
-- Event data for DeviceID 19 on November 28, 2023
INSERT INTO EventData (DataID, DeviceID, Timestamp, EventType, Value)
VALUES 
    (458, 19, '2023-11-28 08:00:00', 'switched on', NULL),
    (459, 19, '2023-11-28 08:00:00', 'energy use', 0.24),
    (460, 19, '2023-11-28 08:30:00', 'energy use', 0.24),
    (461, 19, '2023-11-28 09:00:00', 'energy use', 0.22),
    (462, 19, '2023-11-28 09:30:00', 'energy use', 0.20),
    (463, 19, '2023-11-28 10:00:00', 'energy use', 0.18),
    (464, 19, '2023-11-28 10:30:00', 'temperature changed', 76),
    (465, 19, '2023-11-28 10:30:00', 'energy use', 0.17),
    (466, 19, '2023-11-28 11:00:00', 'energy use', 0.16),
    (467, 19, '2023-11-28 11:30:00', 'energy use', 0.15),
    (468, 19, '2023-11-28 12:00:00', 'energy use', 0.14),
    (469, 19, '2023-11-28 12:30:00', 'energy use', 0.13),
    (470, 19, '2023-11-28 13:00:00', 'energy use', 0.12),
    (471, 19, '2023-11-28 13:30:00', 'energy use', 0.11),
    (472, 19, '2023-11-28 14:00:00', 'energy use', 0.13),
    (473, 19, '2023-11-28 14:30:00', 'energy use', 0.15),
    (474, 19, '2023-11-28 15:00:00', 'energy use', 0.17),
    (475, 19, '2023-11-28 15:30:00', 'energy use', 0.19),
    (476, 19, '2023-11-28 16:00:00', 'energy use', 0.21),
    (477, 19, '2023-11-28 16:30:00', 'energy use', 0.23),
    (478, 19, '2023-11-28 16:30:00', 'switched off', NULL);
    
select * from Device;

-- For Device 28 Refrigerator Today
-- Event data for DeviceID 28 on November 28, 2023
INSERT INTO EventData (DataID, DeviceID, Timestamp, EventType, Value)
VALUES 
    (479, 28, '2023-11-28 08:00:00', 'switched on', NULL),
    (480, 28, '2023-11-28 08:30:00', 'energy use', 0.14),
    (481, 28, '2023-11-28 09:00:00', 'energy use', 0.14),
    (482, 28, '2023-11-28 09:30:00', 'energy use', 0.14),
    (483, 28, '2023-11-28 10:00:00', 'energy use', 0.14),
    (484, 28, '2023-11-28 10:30:00', 'energy use', 0.14),
    (485, 28, '2023-11-28 10:30:00', 'door opened', NULL),
    (486, 28, '2023-11-28 11:00:00', 'energy use', 0.21),
    (487, 28, '2023-11-28 11:15:00', 'door closed', NULL),
    (488, 28, '2023-11-28 11:30:00', 'energy use', 0.17),
    (489, 28, '2023-11-28 12:00:00', 'energy use', 0.14),
    (490, 28, '2023-11-28 12:30:00', 'energy use', 0.14),
    (491, 28, '2023-11-28 13:00:00', 'energy use', 0.14),
    (492, 28, '2023-11-28 13:30:00', 'energy use', 0.09),
    (493, 28, '2023-11-28 14:00:00', 'energy use', 0.09),
    (494, 28, '2023-11-28 14:30:00', 'energy use', 0.09),
    (495, 28, '2023-11-28 15:00:00', 'energy use', 0.09),
    (496, 28, '2023-11-28 15:30:00', 'energy use', 0.09),
    (497, 28, '2023-11-28 16:00:00', 'energy use', 0.09),
    (498, 28, '2023-11-28 16:30:00', 'energy use', 0.09),
    (499, 28, '2023-11-28 16:30:00', 'door opened', NULL),
    (500, 28, '2023-11-28 16:55:00', 'door closed', NULL),
    (501, 28, '2023-11-28 17:00:00', 'energy use', 0.14),
    (502, 28, '2023-11-28 17:30:00', 'energy use', 0.09),
    (503, 28, '2023-11-28 18:00:00', 'energy use', 0.09),
    (504, 28, '2023-11-28 18:30:00', 'energy use', 0.09),
    (505, 28, '2023-11-28 19:00:00', 'energy use', 0.14),
    (506, 28, '2023-11-28 19:30:00', 'energy use', 0.14),
    (507, 28, '2023-11-28 20:00:00', 'energy use', 0.14),
    (509, 28, '2023-11-28 20:00:00', 'switched off', NULL);
    
select * from EventData;

INSERT INTO EventData (DataID, DeviceID, Timestamp, EventType, Value)
VALUES 
    (510, 33, '2023-12-01 10:00:00', 'switched on', NULL),
    (511, 33, '2023-12-01 10:00:00', 'energy use', 0.12),
    (512, 33, '2023-12-01 10:30:00', 'energy use', 0.14),
    (513, 33, '2023-12-01 11:00:00', 'energy use', 0.13),
    (514, 33, '2023-12-01 11:30:00', 'energy use', 0.11),
    (515, 33, '2023-12-01 12:00:00', 'energy use', 0.16),
    (516, 33, '2023-12-01 12:30:00', 'energy use', 0.11),
    (517, 33, '2023-12-01 12:30:00', 'brightness changed', 40),
    (518, 33, '2023-12-01 12:30:00', 'energy use', 0.12),
    (519, 33, '2023-12-01 13:00:00', 'energy use', 0.17),
    (520, 33, '2023-12-01 13:30:00', 'energy use', 0.15),
    (521, 33, '2023-12-01 14:00:00', 'energy use', 0.11),
    (522, 33, '2023-12-01 14:45:00', 'switched off', NULL),
    (523, 33, '2023-12-01 15:00:00', 'energy use', 0.09),
    (524, 33, '2023-12-01 18:30:00', 'switched on', NULL),
    (525, 33, '2023-12-01 18:30:00', 'energy use', 0.05),
    (526, 33, '2023-12-01 17:00:00', 'energy use', 0.22),
    (527, 33, '2023-12-01 17:30:00', 'energy use', 0.18),
    (528, 33, '2023-12-01 18:00:00', 'energy use', 0.20),
    (529, 33, '2023-12-01 18:30:00', 'energy use', 0.18),
    (530, 33, '2023-12-01 19:00:00', 'energy use', 0.18),
    (531, 33, '2023-12-01 19:30:00', 'energy use', 0.20),
    (532, 33, '2023-12-01 20:00:00', 'switched off', NULL),
    (533, 33, '2023-12-01 20:00:00', 'energy use', 0.15);
    
INSERT INTO EventData (DataID, DeviceID, Timestamp, EventType, Value)
VALUES 
    (334, 7, '2023-12-01 10:00:00', 'switched on', NULL),
    (335, 7, '2023-12-01 10:00:00', 'energy use', 0.11),
    (336, 7, '2023-12-01 10:30:00', 'energy use', 0.14),
    (337, 7, '2023-12-01 11:00:00', 'energy use', 0.09),
    (338, 7, '2023-12-01 11:30:00', 'energy use', 0.15),
    (339, 7, '2023-12-01 12:00:00', 'energy use', 0.12),
    (340, 7, '2023-12-01 12:30:00', 'energy use', 0.08),
    (341, 7, '2023-12-01 12:30:00', 'brightness changed', 40),
    (342, 7, '2023-12-01 12:30:00', 'energy use', 0.13),
    (343, 7, '2023-12-01 13:00:00', 'energy use', 0.18),
    (344, 7, '2023-12-01 13:30:00', 'energy use', 0.14),
    (345, 7, '2023-12-01 14:00:00', 'energy use', 0.10),
    (346, 7, '2023-12-01 14:45:00', 'switched off', NULL),
    (347, 7, '2023-12-01 15:00:00', 'energy use', 0.06),
    (348, 7, '2023-12-01 18:30:00', 'switched on', NULL),
    (349, 7, '2023-12-01 18:30:00', 'energy use', 0.02),
    (350, 7, '2023-12-01 17:00:00', 'energy use', 0.19),
    (351, 7, '2023-12-01 17:30:00', 'energy use', 0.14),
    (352, 7, '2023-12-01 18:00:00', 'energy use', 0.16),
    (353, 7, '2023-12-01 18:30:00', 'energy use', 0.14),
    (354, 7, '2023-12-01 19:00:00', 'energy use', 0.14),
    (355, 7, '2023-12-01 19:30:00', 'energy use', 0.16),
    (356, 7, '2023-12-01 20:00:00', 'switched off', NULL),
    (357, 7, '2023-12-01 20:00:00', 'energy use', 0.11);

INSERT INTO EventData (DataID, DeviceID, Timestamp, EventType, Value)
VALUES 
    (534, 7, '2023-12-01 10:00:00', 'switched on', NULL),
    (535, 7, '2023-12-01 10:00:00', 'energy use', 0.11),
    (536, 7, '2023-12-01 10:30:00', 'energy use', 0.14),
    (537, 7, '2023-12-01 11:00:00', 'energy use', 0.09),
    (538, 7, '2023-12-01 11:30:00', 'energy use', 0.15),
    (539, 7, '2023-12-01 12:00:00', 'energy use', 0.12),
    (540, 7, '2023-12-01 12:30:00', 'energy use', 0.08),
    (541, 7, '2023-12-01 12:30:00', 'brightness changed', 40),
    (542, 7, '2023-12-01 12:30:00', 'energy use', 0.13),
    (543, 7, '2023-12-01 13:00:00', 'energy use', 0.18),
    (544, 7, '2023-12-01 13:30:00', 'energy use', 0.14),
    (545, 7, '2023-12-01 14:00:00', 'energy use', 0.10),
    (546, 7, '2023-12-01 14:45:00', 'switched off', NULL),
    (547, 7, '2023-12-01 15:00:00', 'energy use', 0.06),
    (548, 7, '2023-12-01 18:30:00', 'switched on', NULL),
    (549, 7, '2023-12-01 18:30:00', 'energy use', 0.02),
    (550, 7, '2023-12-01 17:00:00', 'energy use', 0.19),
    (551, 7, '2023-12-01 17:30:00', 'energy use', 0.14),
    (552, 7, '2023-12-01 18:00:00', 'energy use', 0.16),
    (553, 7, '2023-12-01 18:30:00', 'energy use', 0.14),
    (554, 7, '2023-12-01 19:00:00', 'energy use', 0.14),
    (555, 7, '2023-12-01 19:30:00', 'energy use', 0.16),
    (556, 7, '2023-12-01 20:00:00', 'switched off', NULL),
    (557, 7, '2023-12-01 20:00:00', 'energy use', 0.11);

INSERT INTO EventData (DataID, DeviceID, Timestamp, EventType, Value)
VALUES 
    (558, 19, '2023-12-01 08:00:00', 'switched on', NULL),
    (559, 19, '2023-12-01 08:00:00', 'energy use', 0.24),
    (560, 19, '2023-12-01 08:30:00', 'energy use', 0.24),
    (561, 19, '2023-12-01 09:00:00', 'energy use', 0.22),
    (562, 19, '2023-12-01 09:30:00', 'energy use', 0.20),
    (563, 19, '2023-12-01 10:00:00', 'energy use', 0.18),
    (564, 19, '2023-12-01 10:30:00', 'temperature changed', 76),
    (565, 19, '2023-12-01 10:30:00', 'energy use', 0.17),
    (566, 19, '2023-12-01 11:00:00', 'energy use', 0.16),
    (567, 19, '2023-12-01 11:30:00', 'energy use', 0.15),
    (568, 19, '2023-12-01 12:00:00', 'energy use', 0.14),
    (569, 19, '2023-12-01 12:30:00', 'energy use', 0.13),
    (570, 19, '2023-12-01 13:00:00', 'energy use', 0.12),
    (571, 19, '2023-12-01 13:30:00', 'energy use', 0.11),
    (572, 19, '2023-12-01 14:00:00', 'energy use', 0.13),
    (573, 19, '2023-12-01 14:30:00', 'energy use', 0.15),
    (574, 19, '2023-12-01 15:00:00', 'energy use', 0.17),
    (575, 19, '2023-12-01 15:30:00', 'energy use', 0.19),
    (576, 19, '2023-12-01 16:00:00', 'energy use', 0.21),
    (577, 19, '2023-12-01 16:30:00', 'energy use', 0.23),
    (578, 19, '2023-12-01 16:30:00', 'switched off', NULL);

INSERT INTO EventData (DataID, DeviceID, Timestamp, EventType, Value)
VALUES 
    (579, 28, '2023-12-01 08:00:00', 'switched on', NULL),
    (580, 28, '2023-12-01 08:30:00', 'energy use', 0.14),
    (581, 28, '2023-12-01 09:00:00', 'energy use', 0.14),
    (582, 28, '2023-12-01 09:30:00', 'energy use', 0.14),
    (583, 28, '2023-12-01 10:00:00', 'energy use', 0.14),
    (584, 28, '2023-12-01 10:30:00', 'energy use', 0.14),
    (585, 28, '2023-12-01 10:30:00', 'door opened', NULL),
    (586, 28, '2023-12-01 11:00:00', 'energy use', 0.21),
    (587, 28, '2023-12-01 11:15:00', 'door closed', NULL),
    (588, 28, '2023-12-01 11:30:00', 'energy use', 0.17),
    (589, 28, '2023-12-01 12:00:00', 'energy use', 0.14),
    (590, 28, '2023-12-01 12:30:00', 'energy use', 0.14),
    (591, 28, '2023-12-01 13:00:00', 'energy use', 0.14),
    (592, 28, '2023-12-01 13:30:00', 'energy use', 0.09),
    (593, 28, '2023-12-01 14:00:00', 'energy use', 0.09),
    (594, 28, '2023-12-01 14:30:00', 'energy use', 0.09),
    (595, 28, '2023-12-01 15:00:00', 'energy use', 0.09),
    (596, 28, '2023-12-01 15:30:00', 'energy use', 0.09),
    (597, 28, '2023-12-01 16:00:00', 'energy use', 0.09),
    (598, 28, '2023-12-01 16:30:00', 'energy use', 0.09),
    (599, 28, '2023-12-01 16:30:00', 'door opened', NULL),
    (600, 28, '2023-12-01 16:55:00', 'door closed', NULL),
    (601, 28, '2023-12-01 17:00:00', 'energy use', 0.14),
    (602, 28, '2023-12-01 17:30:00', 'energy use', 0.09),
    (603, 28, '2023-12-01 18:00:00', 'energy use', 0.09),
    (604, 28, '2023-12-01 18:30:00', 'energy use', 0.09),
    (605, 28, '2023-12-01 19:00:00', 'energy use', 0.14),
    (606, 28, '2023-12-01 19:30:00', 'energy use', 0.14),
    (607, 28, '2023-12-01 20:00:00', 'energy use', 0.14),
    (608, 28, '2023-12-01 20:00:00', 'switched off', NULL);


-- 1

SELECT d.DeviceID, c.CustomerID, d.Type,
    SUM(ed.Value) AS TotalEnergyConsumption
FROM Customer c
JOIN ServiceLocation sl ON c.CustomerID = sl.CustomerID
JOIN Device d ON sl.LocationID = d.LocationID
LEFT JOIN EventData ed ON d.DeviceID = ed.DeviceID
WHERE c.CustomerID IN (SELECT CustomerID FROM Customer)
    AND ed.Timestamp >= NOW() - INTERVAL 24 HOUR
    AND ed.EventType = 'energy use'
GROUP BY d.DeviceID;
    
-- 2

SELECT DeviceEnergy.Type, AVG(TotalEnergyConsumption) AS AvgMonthlyEnergyConsumption
FROM (SELECT d.DeviceID,d.Type,
        SUM(CASE WHEN e.EventType = 'energy use' THEN CAST(e.Value AS DECIMAL(10,2)) ELSE 0 END) AS TotalEnergyConsumption
     FROM Device d
     JOIN EventData e ON d.DeviceID = e.DeviceID
     WHERE e.Timestamp BETWEEN '2022-08-01 00:00:00' AND '2022-08-31 23:59:59'
        AND e.EventType = 'energy use'
     GROUP BY d.DeviceID, d.Type) AS DeviceEnergy
WHERE DeviceEnergy.DeviceID IN (
        SELECT DISTINCT DeviceID
        FROM EventData
        WHERE EventType = 'switched on' 
        AND Timestamp BETWEEN '2022-08-01 00:00:00' AND '2022-08-31 23:59:59'
    )
GROUP BY Type;

-- 3

SELECT OpenEvent.Timestamp AS DoorOpenedTime,
    CloseEvent.Timestamp AS DoorClosedTime,
    sl.Address AS ServiceLocation,
    d.DeviceID,
    d.ModelNumber
FROM EventData OpenEvent
JOIN EventData CloseEvent ON OpenEvent.DeviceID = CloseEvent.DeviceID
JOIN Device d ON OpenEvent.DeviceID = d.DeviceID
JOIN ServiceLocation sl ON d.LocationID = sl.LocationID
WHERE OpenEvent.EventType = 'door opened'
    AND CloseEvent.EventType = 'door closed'
    AND OpenEvent.Timestamp < CloseEvent.Timestamp
    AND TIMESTAMPDIFF(MINUTE, OpenEvent.Timestamp, CloseEvent.Timestamp) > 30
    AND TIMESTAMPDIFF(MINUTE, OpenEvent.Timestamp, CloseEvent.Timestamp) < 240
    AND d.Type = 'refrigerator'
ORDER BY  OpenEvent.Timestamp;


-- 4

SELECT 
    sl.LocationID,
    sl.Address,
    SUM(CASE WHEN ed.EventType = 'energy use' THEN CAST(ed.Value AS DECIMAL(10,2)) ELSE 0 END 
        * ep.PricePerKWh) AS TotalEnergyCost
FROM 
    ServiceLocation sl
JOIN 
    Device d ON sl.LocationID = d.LocationID
JOIN 
    EventData ed ON d.DeviceID = ed.DeviceID
LEFT OUTER JOIN 
    EnergyPrice ep ON sl.ZipCode = ep.ZipCode
WHERE 
    ed.Timestamp BETWEEN '2022-08-01 00:00:00' AND '2022-08-31 23:59:59'
    AND ed.EventType = 'energy use'
GROUP BY 
    sl.LocationID, sl.Address;
    
-- 4 attempt 2

SELECT 
    sl.LocationID,
    sl.Address,
    ep.PricePerKWh,
    ed.Timestamp,
    ep.Time
    -- SUM(ed.Value * ep.PricePerKWh) AS TotalEnergyCost
FROM 
    ServiceLocation sl
JOIN 
    Device d ON sl.LocationID = d.LocationID
JOIN 
    EventData ed ON d.DeviceID = ed.DeviceID
LEFT OUTER JOIN 
    EnergyPrice ep ON sl.ZipCode = ep.ZipCode
WHERE 
    ed.Timestamp BETWEEN '2022-08-01 00:00:00' AND '2022-08-31 23:59:59'
    AND ed.EventType = 'energy use';
    -- AND TIME_TO_SEC(TIMEDIFF(ed.Timestamp, ep.Time)) BETWEEN -21600 AND 21600; -- Within 6 hours
    
-- 4 attempt 3

SELECT 
    sl.LocationID,
    sl.Address,
    ed.Value,
    ed.Timestamp,
    ep.PricePerKWh
    -- SUM( CASE WHEN ed.EventType = 'energy use' THEN CAST(ed.Value AS DECIMAL(10,2)) * ep.PricePerKWh ELSE 0 END
--     ) AS TotalEnergyCost
FROM 
    ServiceLocation sl
JOIN 
    Device d ON sl.LocationID = d.LocationID
JOIN 
    EventData ed ON d.DeviceID = ed.DeviceID
LEFT OUTER JOIN
    EnergyPrice ep ON sl.ZipCode = ep.ZipCode
                    -- AND ed.Timestamp >= ep.Time
WHERE 
    ed.Timestamp BETWEEN '2022-08-01 00:00:00' AND '2022-08-31 23:59:59'
    AND ed.EventType = 'energy use'
    -- AND ep.Time = (SELECT MAX(Time) FROM EnergyPrice WHERE ZipCode = sl.ZipCode AND Time <= ed.Timestamp)
ORDER BY
   sl.LocationID;
   
-- 4 attempt 4

SELECT sl.LocationID, sl.Address,
    SUM(CASE WHEN ed.EventType = 'energy use' THEN CAST(ed.Value AS DECIMAL(10,2)) * ep.PricePerKWh ELSE 0 END
    ) AS TotalEnergyCost
FROM ServiceLocation sl
JOIN Device d ON sl.LocationID = d.LocationID
JOIN EventData ed ON d.DeviceID = ed.DeviceID
LEFT OUTER JOIN EnergyPrice ep ON sl.ZipCode = ep.ZipCode
                    AND ep.Time = (
                        SELECT MAX(Time) 
                        FROM EnergyPrice 
                        WHERE ZipCode = sl.ZipCode 
                            AND Time <= TIME(ed.Timestamp)
                    )
WHERE ed.Timestamp BETWEEN '2022-08-01 00:00:00' AND '2022-08-31 23:59:59'
AND ed.EventType = 'energy use'
GROUP BY sl.LocationID, sl.Address;


    
    
    
select * from EnergyPrice;



-- 5

SELECT 
    a.LocationID,
    a.Address,
    a.TotalEnergyConsumption,
    a.SquareFootage,
    IFNULL((a.TotalEnergyConsumption / b.AvgEnergyConsumption) * 100, 0) AS ConsumptionPercentage
FROM 
    (SELECT 
        sl.LocationID,
        sl.Address,
        sl.SquareFootage,
        SUM(CASE WHEN ed.EventType = 'energy use' THEN CAST(ed.Value AS DECIMAL(10,2)) ELSE 0 END) AS TotalEnergyConsumption
     FROM 
        ServiceLocation sl
     JOIN 
        Device d ON sl.LocationID = d.LocationID
     JOIN 
        EventData ed ON d.DeviceID = ed.DeviceID
     WHERE 
        ed.Timestamp BETWEEN '2022-08-01 00:00:00' AND '2022-08-31 23:59:59'
        AND ed.EventType = 'energy use'
     GROUP BY 
        sl.LocationID, sl.Address, sl.SquareFootage) a
LEFT JOIN 
    (SELECT 
        sl2.SquareFootage,
        AVG(SUM(CASE WHEN ed2.EventType = 'energy use' THEN CAST(ed2.Value AS DECIMAL(10,2)) ELSE 0 END)) AS AvgEnergyConsumption
     FROM 
        ServiceLocation sl2
     JOIN 
        Device d2 ON sl2.LocationID = d2.LocationID
     JOIN 
        EventData ed2 ON d2.DeviceID = ed2.DeviceID
     WHERE 
        ed2.Timestamp BETWEEN '2022-08-01 00:00:00' AND '2022-08-31 23:59:59'
        AND ed2.EventType = 'energy use'
     GROUP BY 
        sl2.SquareFootage) b ON a.SquareFootage BETWEEN b.SquareFootage * 0.95 AND b.SquareFootage * 1.05
WHERE 
    a.LocationID NOT IN (SELECT LocationID FROM ServiceLocation WHERE SquareFootage BETWEEN b.SquareFootage * 0.95 AND b.SquareFootage * 1.05)
ORDER BY 
    a.LocationID;
    
-- 5 attempt 2

SELECT a.LocationID, a.Address, a.TotalEnergyConsumption,
    a.SquareFootage,
    IFNULL((a.TotalEnergyConsumption / b.AvgEnergyConsumption) * 100, 0) AS ConsumptionPercentage
FROM (SELECT sl.LocationID, sl.Address,
        sl.SquareFootage,
        SUM(CASE WHEN ed.EventType = 'energy use' THEN CAST(ed.Value AS DECIMAL(10,2)) ELSE 0 END) AS TotalEnergyConsumption
     FROM ServiceLocation sl
     JOIN Device d ON sl.LocationID = d.LocationID
     JOIN EventData ed ON d.DeviceID = ed.DeviceID
     WHERE ed.Timestamp BETWEEN '2022-08-01 00:00:00' AND '2022-08-31 23:59:59'
        AND ed.EventType = 'energy use'
     GROUP BY sl.LocationID, sl.Address, sl.SquareFootage) a
LEFT JOIN (SELECT InnerQuery.SquareFootage,
           AVG(TotalEnergy) AS AvgEnergyConsumption
		 FROM (SELECT sl2.LocationID, sl2.SquareFootage,
			SUM(CASE WHEN ed2.EventType = 'energy use' THEN CAST(ed2.Value AS DECIMAL(10,2)) ELSE 0 END) AS TotalEnergy
         FROM ServiceLocation sl2
         JOIN Device d2 ON sl2.LocationID = d2.LocationID
         JOIN EventData ed2 ON d2.DeviceID = ed2.DeviceID
         WHERE ed2.Timestamp BETWEEN '2022-08-01 00:00:00' AND '2022-08-31 23:59:59'
            AND ed2.EventType = 'energy use'
         GROUP BY sl2.LocationID, sl2.SquareFootage) AS InnerQuery
     GROUP BY InnerQuery.SquareFootage) b ON a.SquareFootage BETWEEN b.SquareFootage * 0.95 AND b.SquareFootage * 1.05
ORDER BY a.LocationID;

-- 5 attempt 3

WITH 
    INITIAL AS (
        SELECT de.LocationID, SUM(dde.Value) AS energy_used, sl.SquareFootage AS sqfootage
        FROM Device de
        JOIN EventData dde ON de.DeviceID = dde.DeviceID
        JOIN ServiceLocation sl ON sl.LocationID = de.LocationID
      WHERE MONTH(dde.Timestamp) = 8 AND YEAR(dde.Timestamp) = 2022
        AND dde.EventType = 'energy use'
        GROUP BY de.LocationID, dde.DeviceID
    ),
    AVG_POWER AS (
        SELECT i1.LocationID AS loc1, AVG(i2.energy_used) AS avg_energy_used
        FROM INITIAL i1 
        CROSS JOIN INITIAL i2 
        WHERE i1.sqfootage BETWEEN i2.sqfootage * 0.95 AND i2.sqfootage * 1.05
        GROUP BY i1.LocationID
    )

SELECT i1.LocationID, i1.sqfootage,
    (i1.energy_used / a.avg_energy_used) * 100 AS Percentage_of_Avg 
FROM INITIAL i1 
LEFT JOIN AVG_POWER a ON i1.LocationID = a.loc1;
    
-- 6

SELECT a.LocationID, a.Address,
    ((b.TotalEnergySept - a.TotalEnergyAug) / a.TotalEnergyAug) * 100 AS PercentageIncrease
FROM (SELECT sl.LocationID, sl.Address,
        SUM(CASE WHEN ed.EventType = 'energy use' THEN CAST(ed.Value AS DECIMAL(10,2)) ELSE 0 END) AS TotalEnergyAug
     FROM ServiceLocation sl
     JOIN Device d ON sl.LocationID = d.LocationID
     JOIN EventData ed ON d.DeviceID = ed.DeviceID
     WHERE ed.Timestamp BETWEEN '2022-08-01 00:00:00' AND '2022-08-31 23:59:59'
        AND ed.EventType = 'energy use'
     GROUP BY sl.LocationID) a
JOIN (SELECT sl.LocationID,
        SUM(CASE WHEN ed.EventType = 'energy use' THEN CAST(ed.Value AS DECIMAL(10,2)) ELSE 0 END) AS TotalEnergySept
     FROM ServiceLocation sl
     JOIN Device d ON sl.LocationID = d.LocationID
     JOIN EventData ed ON d.DeviceID = ed.DeviceID
     WHERE ed.Timestamp BETWEEN '2022-09-01 00:00:00' AND '2022-09-30 23:59:59'
        AND ed.EventType = 'energy use'
     GROUP BY sl.LocationID) b ON a.LocationID = b.LocationID
ORDER BY PercentageIncrease DESC
LIMIT 1;
    
select * from ServiceLocation;

select * from Device;




    



    


    









    






















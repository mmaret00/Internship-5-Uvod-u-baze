CREATE DATABASE Hospital

USE Hospital

CREATE TABLE Location(
	Id int IDENTITY(1,1) PRIMARY KEY,
	Name nvarchar(50) NOT NULL,
	PostalCode nvarchar(5),
	Country nvarchar(50) NOT NULL
)

CREATE TABLE PatientRooms (
	RoomNumber int IDENTITY(1,1) PRIMARY KEY,
	FloorOfRoom int NOT NULL
)

CREATE TABLE OperatingRooms (
	RoomNumber int IDENTITY(1,1) PRIMARY KEY,
	FloorOfRoom int NOT NULL
)

CREATE TABLE Patients (
	OIB nvarchar(11) PRIMARY KEY,
	FirstName nvarchar(50) NOT NULL,
	LastName nvarchar(50) NOT NULL,
	Address nvarchar(50) NOT NULL,
	CurrentLocation int FOREIGN KEY REFERENCES Location(Id) NOT NULL,
	PhoneNumber nvarchar(50) NOT NULL,
	DateOfBirth date NOT NULL,
	PlaceOfBirth int FOREIGN KEY REFERENCES Location(Id),
	CheckIn datetime2 NOT NULL,
	PatientRoomId int FOREIGN KEY REFERENCES PatientRooms(RoomNumber) NOT NULL
)

CREATE TABLE Nurses (
	OIB nvarchar(11) PRIMARY KEY,
	FirstName nvarchar(50) NOT NULL,
	LastName nvarchar(50) NOT NULL,
	Address nvarchar(50) NOT NULL,
	CurrentLocation int FOREIGN KEY REFERENCES Location(Id) NOT NULL,
	PhoneNumber nvarchar(50) NOT NULL UNIQUE,
	DateOfBirth date NOT NULL,
	PlaceOfBirth int FOREIGN KEY REFERENCES Location(Id) NOT NULL,
	PatientRoomId int FOREIGN KEY REFERENCES PatientRooms(RoomNumber),
	OperatingRoomId int FOREIGN KEY REFERENCES OperatingRooms(RoomNumber)
)

CREATE TABLE Surgeons (
	OIB nvarchar(11) PRIMARY KEY,
	FirstName nvarchar(50) NOT NULL,
	LastName nvarchar(50) NOT NULL,
	Address nvarchar(50) NOT NULL,
	CurrentLocation int FOREIGN KEY REFERENCES Location(Id) NOT NULL,
	PhoneNumber nvarchar(50) NOT NULL  UNIQUE,
	DateOfBirth date NOT NULL,
	PlaceOfBirth int FOREIGN KEY REFERENCES Location(Id) NOT NULL,
	Specialty nvarchar(50) NOT NULL
)

CREATE TABLE Surgeries(
	Id int IDENTITY(1,1) PRIMARY KEY,
	TypeOfSurgery nvarchar(100) NOT NULL,
	PatientId nvarchar(11) FOREIGN KEY REFERENCES Patients(OIB) NOT NULL,
	SurgeonId nvarchar(11) FOREIGN KEY REFERENCES Surgeons(OIB) NOT NULL,
	DateOfSurgery date NOT NULL,
	TimeOfSurgery time NOT NULL,
	OperatingRoomId int FOREIGN KEY REFERENCES OperatingRooms(RoomNumber) NOT NULL
)



INSERT INTO PatientRooms(FloorOfRoom) VALUES
(1),
(1),
(1),
(1),
(2),
(2),
(2)

INSERT INTO OperatingRooms(FloorOfRoom) VALUES
(2),
(3),
(3)

INSERT INTO Location (Name, PostalCode, Country) VALUES
('Split', '21000', 'Croatia'),
('Zagreb', '10000', 'Croatia'),
('Solin', '21210', 'Croatia'),
('Mostar', '88000', 'Bosnia and Herzegovina'),
('Ljubljana', '1000', 'Slovenia')

INSERT INTO Patients(OIB, FirstName, LastName, Address, CurrentLocation, PhoneNumber, DateOfBirth, PlaceOfBirth, CheckIn, PatientRoomId) VALUES 
('12345678912', 'Ante', 'Antić', 'Ruđera Boškovića 32', 1, '090123456', '1980-05-21', 1, '2021-12-01 01:00:00', 1),
('23432532532', 'Ana', 'Šimić', 'Vukovarska 11', 2, '0998765432', '1990-04-25', 1, '2021-12-03 12:22:20', 1),
('45757457457', 'Enver', 'Hoxha', 'Put Puta 1', 4, '+387 123 456', '2000-01-01', 5, '2021-12-02 03:33:30', 2),
('34345436436', 'Imenjak', 'Prezimenić', 'Usrid Ničega 40', 3, '+385 095 123 4567', '1940-12-02', 2, '2021-12-01 12:44:44', 7),
('36536456456', 'Josip', 'Pisoj', 'Ulica Brijestova 85', 3, '9899998888', '1940-06-20', 1, '2021-12-01 11:55:00', 7),
('34545435435', 'Josipa', 'Apisoj', 'Ulica Brijestova 85', 3, '0911111111', '1995-04-04', 1, '2021-12-02 04:11:00', 3),
('87687687687', 'Ana', 'Šimić', 'Put Puta 22', 4, '092 222 222', '1990-07-04', 4, '2021-12-10 03:22:00', 7),
('12312321321', 'Anđa', 'Šimić', 'Marmontova 2', 1, '098 888 777', '1910-11-12', 5, '2021-12-07 09:43:32', 1),
('97987213423', 'Jure', 'Šimunović', 'Vukovarska 8', 1, '9494949494', '2005-10-11', 1, '2021-12-08 22:34:12', 3)

INSERT INTO Nurses(OIB, FirstName, LastName, Address, CurrentLocation, PhoneNumber, DateOfBirth, PlaceOfBirth ,PatientRoomId, OperatingRoomId) VALUES 
('12312312312', 'Petra', 'Sestrić', 'Solinska 1', 1, '096 666 777', '1991-05-21', 1, 1, 1),
('24324324324', 'Petra', 'Sestrić', 'Marmontova 8', 1, '098098098', '1995-10-10', 1, 2, 1),
('34524235243', 'Šimun', 'Šimunović', 'Krivi put 10', 3, '091 234 567', '1997-11-21', 2, NULL, 3),
('23543154354', 'Josipa', 'Josipović', 'Put Pazdigrada 100', 1, '0922345678', '1990-02-28', 1, 4, 2),
('76876876876', 'Petar', 'Jurić', 'Vukovarska 16', 1, '091 2342332', '1990-11-11', 2, 7, 3),
('53636564564', 'Ana', 'Jurić', 'Solinska 15', 1, '0900100200', '1970-12-22', 1, 7, 2),
('45345435436', 'Ivana', 'Šimić', 'Solinska 15', 1, '091 645 6444', '1985-04-03', 4, 1, NULL)

INSERT INTO Surgeons(OIB, FirstName, LastName, Address, CurrentLocation, PhoneNumber, DateOfBirth, PlaceOfBirth, Specialty) VALUES 
('45345435436', 'Šima', 'Kirurgović', 'Gotovčeva 2', 1, '095 5555555', '1991-05-21', 2, 'Neurosurgery'),
('34534543543', 'Josip', 'Šimunović', 'Krivi put 10', 3, '989999999', '1996-11-01', 1, 'General surgery'),
('14124343214', 'Matija', 'Neznanić', 'Velebitska 101', 1, '99 990 0909', '1997-11-21', 5, 'Plastic surgery'),
('67876976987', 'Ante', 'Anić', 'Poljička 99', 1, '091 190 190', '1970-03-30', 1, 'Cardiac Surgery'),
('56765756765', 'Ana', 'Antić', 'Trg Gaje Bulata 1', 1, '919109100', '1975-11-20', 4, 'Neurosurgery')

INSERT INTO Surgeries(TypeOfSurgery, PatientId, SurgeonId, DateOfSurgery, TimeOfSurgery, OperatingRoomId) VALUES
('Appendectomy', '23432532532', '45345435436', '2021-12-08', '00:30:00', 1),
('Cataract surgery', '45757457457', '14124343214', '2021-12-08', '14:23:00', 2),
('Cholecystectomy', '34345436436', '56765756765', '2021-12-09', '12:32:00', 1),
('Coronary artery bypass', '23432532532', '14124343214', '2021-12-09', '22:33:00', 1),
('Debridement of wound', '45757457457', '14124343214', '2021-12-09', '10:22:00', 3),
('Cataract surgery', '36536456456', '67876976987', '2021-12-09', '00:59:00', 3),
('Appendectomy', '34545435435', '45345435436', '2021-12-09', '15:19:00', 2),
('Cholecystectomy', '97987213423', '56765756765', '2021-12-10', '05:16:00', 2),
('Cataract surgery', '23432532532', '45345435436', '2021-12-10', '23:24:00', 1),
('Coronary artery bypass', '12312321321', '14124343214', '2021-12-10', '00:35:00', 2),
('Cholecystectomy', '87687687687', '56765756765', '2021-12-10', '04:42:00', 3),
('Cataract surgery', '45757457457', '45345435436', '2021-12-10', '14:34:00', 2)

SELECT * FROM Surgeries WHERE DateOfSurgery = '2021-12-10' ORDER BY TimeOfSurgery ASC

SELECT FirstName, LastName FROM Surgeons WHERE PlaceOfBirth != 1

UPDATE Nurses SET PatientRoomId = 1 WHERE PatientRoomId = 4

SELECT OIB, FirstName, LastName FROM Patients WHERE PatientRoomId = 7 ORDER BY LastName DESC

SELECT * FROM Surgeries WHERE DateOfSurgery = CAST(GETDATE() AS Date)
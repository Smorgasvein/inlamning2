/*
Oliver Aldorsson
YH24
*/

-- Från inlamning1.sql:
DROP DATABASE IF EXISTS Bokhandel; -- Tar bort existerande databasen om det redan finns en Bokhandel
CREATE DATABASE Bokhandel; -- Skapa databasen för bokhandeln
USE Bokhandel; -- För att börja använda databasen

-- För att skapa tabellen för böckerna:
CREATE TABLE Böcker (
	ISBN VARCHAR(20) PRIMARY KEY,
	Titel VARCHAR(255) NOT NULL,
	Författare VARCHAR(255) NOT NULL,
	Pris DECIMAL(10,2) NOT NULL CHECK (Pris > 0),
	Lagerstatus INT
);

-- Lägger in böckerna och dess tillhörande data:
INSERT INTO Böcker (Titel, ISBN, Författare, Pris, Lagerstatus) VALUES
("The Pragmatic Programmer","978-0135957059","Andrew Hunt, David Thomas",450,10),
("Clean Code", "978-0132350884", "Robert C. Martin", 420, 5),
("Design Patterns: Elements of Reusable Object-Oriented Software","978-0201633610","Erich Gamma, Richard Helm, Ralph Johnson, John Vlissides",550,7),
("The Art of Computer Programming, Vol. 1","978-0201896830","Donald Knuth",800,3),
("Eloquent JavaScript","978-1593279509","Marijn Haverbeke",390,12)
;

/*
ROLLBACK; -- Ångra

SELECT * FROM Böcker; -- Visar alla böcker i databasen

DELETE FROM Böcker WHERE ISBN = "978-0135957059"; -- Ta bort en bok via den unika primära nyckeln

SET SQL_SAFE_UPDATES = 1; -- Safe mode
*/

-- För att skapa tabellen för kunderna:
CREATE TABLE Kunder (
	KundID INT AUTO_INCREMENT PRIMARY KEY,
	Epost VARCHAR(100) NOT NULL,
	Namn VARCHAR(255) NOT NULL,
	Telefon VARCHAR(20) NOT NULL, -- Man kan också köra integers som telefon, men om man vill ha det lite snyggare med bindestreck och mellanslag behöver man ha en sträng
	Adress VARCHAR(255) NOT NULL
);

-- För att lägga in kunder:
INSERT INTO Kunder(Namn, Epost, Telefon, Adress) VALUES
("John Svensson", "johnsven@email.com", "070-669 33 55", "Johnsgata 52"),
("Mikael Brändrot", "mickebränd@email.com", "075-354 69 82", "Brändgränd 22"),
("Datsick Jada", "onedog@dada.se", "072-697 32 43", "Kalmarsväg 3"),
("Maj Blomqvist", "majblomman@email.com", "070-465 91 88", "Majvägen 2")
;

-- För att skapa tabellen Beställningar:
CREATE TABLE Beställningar (
	Ordernummer INT AUTO_INCREMENT PRIMARY KEY,
	KundID INT NOT NULL,
    FOREIGN KEY (KundID) REFERENCES Kunder(KundID),
	Datum DATE NOT NULL,
	Totalbelopp DECIMAL(10,2) NOT NULL CHECK (Totalbelopp > 0)
);

-- För att lägga in beställningar:
INSERT INTO Beställningar(KundID, Totalbelopp, Datum) VALUES
(1, 420, "2025-03-08"),
(4, 550, "2025-03-06"),
(2, 800, "2025-03-04"),
(3, 450, "2025-03-05"),
(2, 450, "2025-03-07"),
(4, 390, "2025-03-08"),
(1, 1250, "2025-02-28"),
(2, 390, "2025-03-05"),
(3, 940, "2025-03-04"),
(4, 420, "2025-03-02")
;

-- För att skapa tabellen Orderrader:
CREATE TABLE Orderrader(
	OrderradID INT AUTO_INCREMENT PRIMARY KEY,
    Ordernummer INT NOT NULL,
    ISBN VARCHAR(20) NOT NULL,
    Antal INT NOT NULL,
    Pris DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (Ordernummer) REFERENCES Beställningar(Ordernummer),
    FOREIGN KEY (ISBN) REFERENCES Böcker(ISBN)
);

-- Trigger för att uppdatera lagersaldo:
DELIMITER $$

CREATE TRIGGER UppdateraLagersaldo
AFTER INSERT ON Orderrader
FOR EACH ROW
BEGIN
    UPDATE Böcker
    SET Lagerstatus = Lagerstatus - NEW.Antal
    WHERE ISBN = NEW.ISBN;
END $$

DELIMITER ;

-- För att lägga in beställningar i Orderrader:
INSERT INTO Orderrader (Ordernummer, ISBN, Antal, Pris) VALUES
(1, "978-0132350884",1,420),
(2, "978-0201633610",1,550),
(3, "978-0201896830",1,800),
(4, "978-0135957059",1,450),
(5, "978-0135957059",1,450),
(6, "978-1593279509",1,390),
(7, "978-0135957059",1,450),
(7, "978-0201896830",1,800),
(8, "978-1593279509",1,390),
(9, "978-1593279509",1,390),
(9, "978-0201633610",1,550),
(10, "978-0132350884",1,420);

-- Visa böcker och lagersaldo:
SELECT * FROM Böcker;

-- Visa orderrader, beställningar, kunder (välj en):
SELECT * FROM Orderrader;
SELECT * FROM Beställningar;
SELECT * FROM Kunder;

-- Visa antal beställningar per kund:
SELECT KundID, COUNT(Ordernummer) AS AntalBeställningar
FROM Beställningar
GROUP BY KundID;


-- inlamning2.sql

-- Hämta alla kunder:
SELECT * FROM Kunder;

-- Hämta alla beställningar:
SELECT * FROM Beställningar;

-- Sortera efter pris:
SELECT * FROM Böcker ORDER BY Pris ASC; -- Billigast först
SELECT * FROM Böcker ORDER BY Pris DESC; -- Dyrast först

-- Visa specifik data:
SELECT * FROM Böcker WHERE Pris > 500; -- Visa alla böcker där priset är mer än 500
SELECT * FROM Beställningar WHERE KundID = 4; -- Visar alla beställningar som beställts av Maj Blomqvist
SELECT * FROM Orderrader WHERE Ordernummer = 9; -- Visar alla orderrader på ordernummer 9. Alltså hela beställningen

-- Update:
-- UPDATE Kunder SET Epost = 'johnsvensson@email.com' WHERE Namn = 'John Svensson'; -- Fungerar inte i safe mode eftersom namnet inte är unikt
UPDATE Kunder SET Epost = 'johnsvensson@email.com' WHERE KundID = 1; -- Fungerar eftersom KundID är unikt och PK

-- Ta bort:
DELETE FROM Orderrader WHERE Ordernummer = 10; -- Tar bort Ordernummer 10 från Orderrader
SELECT * FROM Orderrader;

-- Transaktion och ångra:
START TRANSACTION;
DELETE FROM Orderrader WHERE Ordernummer = 9;
ROLLBACK;

SELECT * FROM Orderrader; -- Se på Orderrader att Ordernummer 9 inte försvunnit, så ångra (rollback) fungerar

-- JOIN:
-- Visar namnen på vilka kunder som har gjort vilka beställningar. Dock bara de som har gjort minst en beställning
SELECT Kunder.Namn, Beställningar.Ordernummer
FROM Kunder
INNER JOIN Beställningar ON Kunder.KundID = Beställningar.KundID;

SELECT * FROM Beställningar;

-- LEFT JOIN
-- Visar även namnen på de kunder som inte gjort någon beställning
SELECT Kunder.Namn, Beställningar.Ordernummer
FROM Kunder
LEFT JOIN Beställningar ON Kunder.KundID = Beställningar.KundID;

SELECT * FROM Kunder;

-- GROUP BY -- Visar hur många beställningar varje kund har gjort
SELECT KundID, COUNT(Ordernummer) AS AntalBeställningar
FROM Beställningar
GROUP BY KundID;

-- Visar hur många beställningar varje kund har gjort, med namn:
SELECT Kunder.Namn, COUNT(Beställningar.Ordernummer) AS AntalBeställningar
FROM Kunder
INNER JOIN Beställningar ON Kunder.KundID = Beställningar.KundID
GROUP BY Kunder.Namn;

-- HAVING -- Visar endast de kunder med fler än 2 beställningar
SELECT KundID, COUNT(Ordernummer) AS AntalBeställningar
FROM Beställningar
GROUP BY KundID
HAVING COUNT(Ordernummer) > 2;

-- Gör ett index:
CREATE INDEX idx_email ON Kunder(Epost)

-- En trigger som loggar när en ny kund registreras:
DELIMITER $$

CREATE TRIGGER LoggaNyKund
AFTER INSERT ON Kunder
FOR EACH ROW
BEGIN
	INSERT INTO KundLogg (KundID, Registreringsdatum)
    VALUES (NEW.KundID, NOW());
END $$

DELIMITER ;

-- Ny tabell som lagrar kundloggar:
CREATE TABLE KundLogg (
	LoggID INT AUTO_INCREMENT PRIMARY KEY,
    KundID INT NOT NULL,
    Registreringsdatum DATETIME NOT NULL,
    FOREIGN KEY (KundID) REFERENCES Kunder(KundID)
);

SELECT * FROM KundLogg;

-- Skapa en backup: Kör i kommandotolk:
-- mysqldump -u root -p Bokhandel > bokhandel_backup.sql
-- Återställ från en backup:
-- mysql -u root -p Bokhandel < bokhandel_backup.sql

-- Registrera ny kund:
INSERT INTO Kunder(Namn, Epost, Telefon, Adress) VALUES
("Fredrik Jönsson", "freddejon@email.com", "073-655 62 13", "Engata 50");

-- Visa kundlogg:
SELECT * FROM KundLogg;


-- Se alla orderrader + boktitel, pris och datum. Pris både per styck och totalpris, ifall man beställt fler böcker:
SELECT 
    Beställningar.Ordernummer,
    Kunder.Namn AS Kundnamn,
    Beställningar.Datum,
    Böcker.Titel AS Boktitel,
    Orderrader.Antal,
    Orderrader.Pris AS PrisPerStyck,
    (Orderrader.Antal * Orderrader.Pris) AS TotalprisFörRad
FROM 
    Beställningar
INNER JOIN Kunder ON Beställningar.KundID = Kunder.KundID
INNER JOIN Orderrader ON Beställningar.Ordernummer = Orderrader.Ordernummer
INNER JOIN Böcker ON Orderrader.ISBN = Böcker.ISBN
ORDER BY Beställningar.Ordernummer, Böcker.Titel;

-- Lite mer simplifierat. Se hela ordrar per rad, dvs inte från tabellen orderrader per rad:
SELECT 
    Beställningar.Ordernummer,
    Kunder.Namn AS Kundnamn,
    Beställningar.Datum,
    SUM(Orderrader.Antal * Orderrader.Pris) AS OrderTotal
FROM 
    Beställningar
INNER JOIN Kunder ON Beställningar.KundID = Kunder.KundID
INNER JOIN Orderrader ON Beställningar.Ordernummer = Orderrader.Ordernummer
GROUP BY 
    Beställningar.Ordernummer, 
    Kunder.Namn, 
    Beställningar.Datum
ORDER BY Beställningar.Ordernummer;
    
SELECT USER(); -- Visar användaren

/*
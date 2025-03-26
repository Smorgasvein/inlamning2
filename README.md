# inlamning2

# Oliver Aldorsson, YH24
# Bokhandel - SQL-projekt

Detta projekt består av två SQL-skript ("inlamning1.sql" och "inlamning2.sql") som tillsammans skapar en databas för en bokhandel, fyller den med data och utför olika SQL-operationer såsom selekteringar, uppdateringar, borttagningar, triggers och transaktioner.

## Innehåll

### Funktioner
- Skapande av databas:  
  Databasen "Bokhandel" skapas från grunden.
  Om du redan använder en "Bokhandel"-databas som kommer den att droppas för att skapa denna.
  
- Tabeller:
  - Böcker: Innehåller information om böcker (ISBN, titel, författare, pris, lagerstatus).
  - Kunder: Innehåller kundinformation (namn, e-post, telefon, adress).
  - Beställningar: Hanterar beställningar med datum och totalbelopp.
  - Orderrader: Kopplar beställningar till specifika böcker och antal.
  - KundLogg: Loggar registreringstillfällen för nya kunder via en trigger.

- Triggers:
  - Automatiskt uppdatera lagersaldo vid nya orderrader.
  - Loggar nya kundregistreringar i KundLogg.

- Index:
  - Index på e-postadress för snabbare sökningar i "Kunder".

- Transaktioner:
  - Exempel på hur man använder START TRANSACTION, ROLLBACK och COMMIT.

- Backup:
  - Instruktioner för att ta backup och återställa databasen med "mysqldump".
-- Skapa en backup: Kör i kommandotolk:
-- mysqldump -u root -p Bokhandel > bokhandel_backup.sql
-- Återställ från en backup:
-- mysql -u root -p Bokhandel < bokhandel_backup.sql

## Filinnehåll

### inlamning1.sql
- Skapar databasen och tabeller.
- Lägger in data i samtliga tabeller.
- Trigger för att uppdatera lagersaldo.
- Exempel på SELECT-frågor, borttagning och grupperingar.

### inlamning2.sql
- Mer avancerade SELECT-frågor med JOIN, GROUP BY och HAVING.
- Sortering av böcker efter pris.
- Uppdatering och borttagning av data.
- Skapande av index.
- Trigger för att logga kundregistreringar.
- Exempel på att jämföra registrerat belopp med beräknat belopp för beställningar.

## Installation:
Ladda ner och installera MySQL Workbench och kör igång databasen. Öppna sedan den här .SQL-filen och kör scriptet! Sedan kan du lägga in egen data själv om du vill och testa.

## Bidrag:
Jag tar inte emot bidrag egentligen men vill du ge så får du gärna :) skojar

//Smorgasvein

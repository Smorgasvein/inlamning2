-- MySQL dump 10.13  Distrib 9.2.0, for Win64 (x86_64)
--
-- Host: localhost    Database: Bokhandel
-- ------------------------------------------------------
-- Server version	9.2.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `beställningar`
--

DROP TABLE IF EXISTS `beställningar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `beställningar` (
  `Ordernummer` int NOT NULL AUTO_INCREMENT,
  `KundID` int NOT NULL,
  `Datum` date NOT NULL,
  `Totalbelopp` decimal(10,2) NOT NULL,
  PRIMARY KEY (`Ordernummer`),
  KEY `KundID` (`KundID`),
  CONSTRAINT `beställningar_ibfk_1` FOREIGN KEY (`KundID`) REFERENCES `kunder` (`KundID`),
  CONSTRAINT `beställningar_chk_1` CHECK ((`Totalbelopp` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `beställningar`
--

LOCK TABLES `beställningar` WRITE;
/*!40000 ALTER TABLE `beställningar` DISABLE KEYS */;
INSERT INTO `beställningar` VALUES (1,1,'2025-03-08',420.00),(2,4,'2025-03-06',550.00),(3,2,'2025-03-04',800.00),(4,3,'2025-03-05',450.00),(5,2,'2025-03-07',450.00),(6,4,'2025-03-08',390.00),(7,1,'2025-02-28',1250.00),(8,2,'2025-03-05',390.00),(9,3,'2025-03-04',940.00),(10,4,'2025-03-02',420.00);
/*!40000 ALTER TABLE `beställningar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `böcker`
--

DROP TABLE IF EXISTS `böcker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `böcker` (
  `ISBN` varchar(20) NOT NULL,
  `Titel` varchar(255) NOT NULL,
  `Författare` varchar(255) NOT NULL,
  `Pris` decimal(10,2) NOT NULL,
  `Lagerstatus` int DEFAULT NULL,
  PRIMARY KEY (`ISBN`),
  CONSTRAINT `böcker_chk_1` CHECK ((`Pris` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `böcker`
--

LOCK TABLES `böcker` WRITE;
/*!40000 ALTER TABLE `böcker` DISABLE KEYS */;
INSERT INTO `böcker` VALUES ('978-0132350884','Clean Code','Robert C. Martin',420.00,3),('978-0135957059','The Pragmatic Programmer','Andrew Hunt, David Thomas',450.00,7),('978-0201633610','Design Patterns: Elements of Reusable Object-Oriented Software','Erich Gamma, Richard Helm, Ralph Johnson, John Vlissides',550.00,5),('978-0201896830','The Art of Computer Programming, Vol. 1','Donald Knuth',800.00,1),('978-1593279509','Eloquent JavaScript','Marijn Haverbeke',390.00,9);
/*!40000 ALTER TABLE `böcker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kunder`
--

DROP TABLE IF EXISTS `kunder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kunder` (
  `KundID` int NOT NULL AUTO_INCREMENT,
  `Epost` varchar(100) NOT NULL,
  `Namn` varchar(255) NOT NULL,
  `Telefon` varchar(20) NOT NULL,
  `Adress` varchar(255) NOT NULL,
  PRIMARY KEY (`KundID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kunder`
--

LOCK TABLES `kunder` WRITE;
/*!40000 ALTER TABLE `kunder` DISABLE KEYS */;
INSERT INTO `kunder` VALUES (1,'johnsvensson@email.com','John Svensson','070-669 33 55','Johnsgata 52'),(2,'mickebränd@email.com','Mikael Brändrot','075-354 69 82','Brändgränd 22'),(3,'onedog@dada.se','Datsick Jada','072-697 32 43','Kalmarsväg 3'),(4,'majblomman@email.com','Maj Blomqvist','070-465 91 88','Majvägen 2'),(5,'freddejon@email.com','Fredrik Jönsson','073-655 62 13','Engata 50');
/*!40000 ALTER TABLE `kunder` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `LoggaNyKund` AFTER INSERT ON `kunder` FOR EACH ROW BEGIN
	INSERT INTO KundLogg (KundID, Registreringsdatum)
    VALUES (NEW.KundID, NOW());
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `kundlogg`
--

DROP TABLE IF EXISTS `kundlogg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kundlogg` (
  `LoggID` int NOT NULL AUTO_INCREMENT,
  `KundID` int NOT NULL,
  `Registreringsdatum` datetime NOT NULL,
  PRIMARY KEY (`LoggID`),
  KEY `KundID` (`KundID`),
  CONSTRAINT `kundlogg_ibfk_1` FOREIGN KEY (`KundID`) REFERENCES `kunder` (`KundID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kundlogg`
--

LOCK TABLES `kundlogg` WRITE;
/*!40000 ALTER TABLE `kundlogg` DISABLE KEYS */;
INSERT INTO `kundlogg` VALUES (1,5,'2025-03-22 23:08:30');
/*!40000 ALTER TABLE `kundlogg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderrader`
--

DROP TABLE IF EXISTS `orderrader`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderrader` (
  `OrderradID` int NOT NULL AUTO_INCREMENT,
  `Ordernummer` int NOT NULL,
  `ISBN` varchar(20) NOT NULL,
  `Antal` int NOT NULL,
  `Pris` decimal(10,2) NOT NULL,
  PRIMARY KEY (`OrderradID`),
  KEY `Ordernummer` (`Ordernummer`),
  KEY `ISBN` (`ISBN`),
  CONSTRAINT `orderrader_ibfk_1` FOREIGN KEY (`Ordernummer`) REFERENCES `beställningar` (`Ordernummer`),
  CONSTRAINT `orderrader_ibfk_2` FOREIGN KEY (`ISBN`) REFERENCES `böcker` (`ISBN`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderrader`
--

LOCK TABLES `orderrader` WRITE;
/*!40000 ALTER TABLE `orderrader` DISABLE KEYS */;
INSERT INTO `orderrader` VALUES (1,1,'978-0132350884',1,420.00),(2,2,'978-0201633610',1,550.00),(3,3,'978-0201896830',1,800.00),(4,4,'978-0135957059',1,450.00),(5,5,'978-0135957059',1,450.00),(6,6,'978-1593279509',1,390.00),(7,7,'978-0135957059',1,450.00),(8,7,'978-0201896830',1,800.00),(9,8,'978-1593279509',1,390.00),(10,9,'978-1593279509',1,390.00),(11,9,'978-0201633610',1,550.00);
/*!40000 ALTER TABLE `orderrader` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `UppdateraLagersaldo` AFTER INSERT ON `orderrader` FOR EACH ROW BEGIN
    UPDATE Böcker
    SET Lagerstatus = Lagerstatus - NEW.Antal
    WHERE ISBN = NEW.ISBN;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-22 23:21:33

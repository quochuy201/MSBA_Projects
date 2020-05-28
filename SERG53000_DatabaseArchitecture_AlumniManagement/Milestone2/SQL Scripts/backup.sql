CREATE DATABASE  IF NOT EXISTS `segr5300` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin */;
USE `segr5300`;
-- MySQL dump 10.13  Distrib 8.0.16, for macos10.14 (x86_64)
--
-- Host: localhost    Database: segr5300
-- ------------------------------------------------------
-- Server version	8.0.15

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `all_events`
--

DROP TABLE IF EXISTS `all_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `all_events` (
  `all_events_id` int(6) NOT NULL AUTO_INCREMENT,
  `all_events_name` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `all_events_start_time` datetime DEFAULT NULL,
  `all_events_end_time` datetime DEFAULT NULL,
  `all_events_address` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `department_id` int(11) NOT NULL,
  `city_id` int(11) NOT NULL,
  PRIMARY KEY (`all_events_id`),
  KEY `dept_id_idx` (`department_id`),
  KEY `city_id_idx` (`city_id`),
  CONSTRAINT `city_id` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`),
  CONSTRAINT `dept_id` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `all_events`
--

LOCK TABLES `all_events` WRITE;
/*!40000 ALTER TABLE `all_events` DISABLE KEYS */;
INSERT INTO `all_events` VALUES (1,'Alumni Meet 2013','2013-01-24 16:30:00','2013-01-24 18:30:00','Garfield Community Center',12,9),(2,'Senior Signature 2013','2013-04-14 09:30:00','2013-01-24 13:00:00','International Community Center',17,6),(3,'Rendezvous 2013','2013-10-16 13:00:00','2013-01-24 15:00:00','Pacific Hall',29,7),(4,'Alumni Meet 2014','2014-01-20 16:30:00','2014-01-20 18:30:00','Garfield Community Center',12,9),(5,'Rendezvous 2014','2014-10-06 13:00:00','2014-10-06 15:00:00','Pacific Hall',29,7),(6,'Senior Signature 2014','2014-04-04 09:30:00','2014-04-04 13:00:00','International Community Center',17,6),(7,'Alumni Meet 2015','2015-01-08 16:30:00','2015-01-08 18:30:00','Garfield Community Center',12,9),(8,'Rendezvous 2015','2015-10-26 13:00:00','2015-10-26 15:00:00','Pacific Hall',29,7),(9,'Senior Signature 2015','2015-04-01 09:30:00','2015-04-01 13:00:00','International Community Center',17,6),(10,'Alumni Meet 2016','2016-01-20 16:30:00','2016-01-20 18:30:00','Garfield Community Center',12,9),(11,'Rendezvous 2016','2016-10-26 13:00:00','2016-10-26 15:00:00','Pacific Hall',29,7),(12,'Senior Signature 2016','2016-04-12 09:30:00','2016-04-12 13:00:00','International Community Center',17,6),(13,'Alumni Meet 2017','2017-01-30 16:30:00','2017-01-30 18:30:00','Garfield Community Center',12,9),(14,'Rendezvous 2017','2017-10-10 13:00:00','2017-10-10 15:00:00','Pacific Hall',29,7),(15,'Senior Signature 2017','2017-04-20 09:30:00','2017-04-20 13:00:00','International Community Center',17,6);
/*!40000 ALTER TABLE `all_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alum_events`
--

DROP TABLE IF EXISTS `alum_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `alum_events` (
  `alum_events_id` int(6) NOT NULL AUTO_INCREMENT,
  `all_events_id` int(6) NOT NULL,
  `alumni_id` int(6) NOT NULL,
  `attended` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`alum_events_id`),
  KEY `all_events_id` (`all_events_id`),
  KEY `alumni_id` (`alumni_id`),
  CONSTRAINT `alum_events_ibfk_1` FOREIGN KEY (`all_events_id`) REFERENCES `all_events` (`all_events_id`),
  CONSTRAINT `alum_events_ibfk_2` FOREIGN KEY (`alumni_id`) REFERENCES `alumni` (`alumni_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alum_events`
--

LOCK TABLES `alum_events` WRITE;
/*!40000 ALTER TABLE `alum_events` DISABLE KEYS */;
INSERT INTO `alum_events` VALUES (1,9,47,1),(2,3,21,1),(3,6,37,1),(4,4,8,1),(5,3,6,0),(6,9,5,0),(7,6,6,1),(8,8,14,1),(9,2,47,0),(10,2,6,1),(11,8,36,0),(12,5,7,0),(13,2,11,0),(14,7,44,1),(15,2,2,1),(16,2,43,0),(17,6,37,1),(18,5,20,0),(19,1,41,1),(20,8,35,0),(21,2,1,0),(22,3,37,1),(23,1,40,0),(24,6,37,0),(25,7,6,0),(26,1,23,1),(27,1,16,1),(28,4,46,1),(29,6,9,1),(30,6,28,1),(31,7,17,0),(32,4,17,0),(33,1,4,1),(34,8,1,1),(35,3,11,0),(36,7,40,1),(37,8,15,1),(38,3,11,0),(39,5,32,1),(40,3,48,1);
/*!40000 ALTER TABLE `alum_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alum_program`
--

DROP TABLE IF EXISTS `alum_program`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `alum_program` (
  `alum_program_id` int(6) NOT NULL AUTO_INCREMENT,
  `alumni_id` int(6) NOT NULL,
  `program_id` int(6) NOT NULL,
  `alum_program_grad_year` year(4) DEFAULT NULL,
  PRIMARY KEY (`alum_program_id`),
  KEY `alumni_id` (`alumni_id`),
  KEY `program_id` (`program_id`),
  CONSTRAINT `alum_program_ibfk_1` FOREIGN KEY (`alumni_id`) REFERENCES `alumni` (`alumni_id`),
  CONSTRAINT `alum_program_ibfk_2` FOREIGN KEY (`program_id`) REFERENCES `program` (`program_id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alum_program`
--

LOCK TABLES `alum_program` WRITE;
/*!40000 ALTER TABLE `alum_program` DISABLE KEYS */;
INSERT INTO `alum_program` VALUES (1,1,21,1990),(2,2,8,2010),(3,3,2,2014),(4,4,6,1991),(5,5,8,2005),(6,6,2,2012),(7,7,4,2008),(8,8,3,1996),(9,9,4,1992),(10,10,24,2010),(11,11,1,2002),(12,12,18,2013),(13,13,25,2002),(14,14,23,2013),(15,15,2,2005),(16,16,7,2003),(17,17,18,1991),(18,18,11,2002),(19,19,2,2004),(20,20,22,2008),(21,21,15,1996),(22,22,12,1998),(23,23,6,1994),(24,24,8,2010),(25,25,25,1992),(26,26,17,2010),(27,27,14,1991),(28,28,21,1999),(29,29,22,2013),(30,30,7,1996),(31,31,16,1995),(32,32,7,1991),(33,33,8,1999),(34,34,3,1992),(35,35,15,1995),(36,36,22,2002),(37,37,3,2009),(38,38,19,2002),(39,39,6,2012),(40,40,16,2003),(41,41,24,2003),(42,42,22,1996),(43,43,20,1996),(44,44,12,2013),(45,45,14,2001),(46,46,9,1996),(47,47,5,2010),(48,48,21,2005),(49,49,3,1999),(50,50,15,1998),(51,51,2,2000);
/*!40000 ALTER TABLE `alum_program` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alumni`
--

DROP TABLE IF EXISTS `alumni`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `alumni` (
  `alumni_id` int(6) NOT NULL AUTO_INCREMENT,
  `alumni_student_id` int(10) DEFAULT NULL,
  `alumni_name` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `alumni_emailID` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `alumni_contact_no` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `alumni_postal_street_address` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `city_id` int(11) NOT NULL,
  `alumni_postal_zip` int(6) DEFAULT NULL,
  `company_id` int(11) NOT NULL,
  `alumni_designation` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`alumni_id`),
  KEY `company_id_idx` (`company_id`),
  KEY `city_id_idx` (`city_id`),
  CONSTRAINT `alumni_city_id` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`),
  CONSTRAINT `company_id` FOREIGN KEY (`company_id`) REFERENCES `company` (`company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alumni`
--

LOCK TABLES `alumni` WRITE;
/*!40000 ALTER TABLE `alumni` DISABLE KEYS */;
INSERT INTO `alumni` VALUES (1,400401,'Lennon Mccullough','Lennon.MCCULL1787@mail2web.com','2256198495','8378 Conservatory',1,94579,23,'Sales Manager'),(2,400402,'Matias Gamble','Mati.GAMB9672@hushmail.com','7573492222','5262 Randolph',1,6954,5,'Senior Engineer'),(3,400403,'Ainsley Mclaughlin','Ainsley.MCLAUGH2847@mail2web.com','5708831725','528 Evergreen',2,57013,5,'Business Analyst'),(4,400404,'Jessie Finley','Jessie.FIN6992@yahoo.com','9387744791','7594 Holbrook',2,43593,2,'Senior Manager'),(5,400405,'Dallas Cross','Dallas.CR5969@mail2web.com','2527320124','2834 Private',5,97339,26,'Data Engineer'),(6,400406,'Raymond Leblanc','Raymon.LEB2200@live.com','7192831062','9724 Prairie Park',1,30062,31,'Executive Assistant'),(7,400407,'Lainey Davenport','Lain.DAVEN1440@live.com','6366920691','844 St James',5,93946,36,'Vice President'),(8,400408,'Quintin Lyons','Quintin.LY8671@gmail.com','5419994982','6601 Walnut',1,80632,1,'Senior Engineer'),(9,400409,'Corinne Cortez','Cor.CORT9235@live.com','8134978207','9549 Chicago River',3,68689,40,'Human Resources'),(10,400410,'Rogelio House','Rogelio.HOU1129@live.com','7475141618','5559 Laramie',10,70647,6,'Customer Service Representative'),(11,400411,'Yoselin Armstrong','Yosel.ARMSTRONG7942@live.com','9518493985','4783 North Shore',10,23220,49,'Software Engineer'),(12,400412,'Israel Baxter','Isra.BAX4207@live.com','5599900052','9552 Elbridge',1,89665,15,'Marketing Director'),(13,400413,'Sullivan Powers','Sull.POW6526@gmail.com','2624146124','1450 Sheridan',1,48016,32,'Vice President'),(14,400414,'Londyn Henson','Londyn.HENSO3764@yahoo.com','5172638118','2784 Kedvale',9,38320,49,'Project Manager'),(15,400415,'Iris Chambers','Iris.CHAMB2765@mail2web.com','7709677500','6504 Germania',3,70469,31,'Office Assistant'),(16,400416,'Trent Roberson','Tren.ROBE8413@gmail.com','5032718076','3048 Harper',7,6140,17,'Vice President'),(17,400417,'Tinley Bell','Tin.BE4516@live.com','4429487578','5200 Bennett',8,33072,3,'Sales Manager'),(18,400418,'Luka Sharpe','Lu.SHA5584@hushmail.com','6313844462','1021 Douglas',9,32333,24,'Administrative Assistant'),(19,400419,'Kailynn Meyer','Kailyn.MEY5479@hushmail.com','2168499363','933 Fuller',7,35847,9,'Software Engineer'),(20,400420,'Ishaan Allen','Ishaan.AL6087@gmail.com','7012206716','3103 Village',3,35871,35,'Accountant'),(21,400421,'Armani Holman','Arm.HOLM7515@yahoo.com','9513226962','3039 Erie',10,89058,41,'Director Assistant'),(22,400422,'Brandon Vinson','Bran.VINSO6863@yahoo.com','2603633588','7265 Burley',4,80233,38,'Data Engineer Clerk'),(23,400423,'Marianna Morse','Marianna.MORS7166@yahoo.com','9372631936','4644 Arthington',3,38705,3,'Sales Manager'),(24,400424,'Valeria Rush','Valer.RUSH1203@live.com','3099949087','6369 138th',2,36120,26,'Project Manager'),(25,400425,'Coleman Murray','Col.MURRA4855@mail2web.com','6822227601','6070 Butler',5,76005,29,'Administrative Assistant'),(26,400426,'Tyree Noel','Tyr.NOEL7301@live.com','5076159628','2518 Webster',7,92571,48,'Senior Manager'),(27,400427,'Blaine Bradshaw','Blaine.BRAD6459@yahoo.com','4252037791','2786 Winnemac',7,98092,5,'Senior Manager'),(28,400428,'Danny Bishop','Dan.BISHO4985@yahoo.com','2105567228','1731 Brompton',1,33926,34,'Senior Manager'),(29,400429,'Rebekah Fernandez','Rebekah.FERNANDEZ7317@live.com','2679903252','1375 Brandon',1,89590,46,'Customer Service Representative'),(30,400430,'Linda Holder','Linda.HOLD3292@yahoo.com','7578888514','7893 Hood',3,97591,22,'Accountant'),(31,400431,'Alyssa Charles','Alyss.CHARLE3234@gmail.com','9523599684','8715 Seminole',9,30922,6,'Human Resources Director'),(32,400432,'Adriel Orr','Adri.OR7827@yahoo.com','3088765742','2594 Paulina',7,95359,4,'Senior Engineer'),(33,400433,'Jonas Mcknight','Jonas.MCKNIGHT6259@live.com','5014772368','300 Kennison',2,48048,27,'Operational Manager'),(34,400434,'Millie Wright','Mil.WRI1643@gmail.com','7851331696','4892 Caldwell',1,70768,11,'Data Analyst'),(35,400435,'Deborah Obrien','Debor.OBRIEN8177@gmail.com','4016053223','6948 Fulton Market',10,19930,48,'Director Assistant'),(36,400436,'Malcolm Gentry','Mal.GENTRY7087@yahoo.com','9042953805','9972 Dan Ryan Ib Stevenson',3,95736,21,'Accountant'),(37,400437,'Ximena Sparks','Ximen.SPARK5942@live.com','7729013926','4054 Bishop',4,30940,19,'Senior Engineer'),(38,400438,'Dakota Price','Dakot.PRIC9423@hushmail.com','9803832232','8219 Haynes',8,6938,22,'Marketing Director'),(39,400439,'Nicholas Ratliff','Nicho.RAT3436@yahoo.com','9897544329','2813 Cottage',8,85425,27,'Vice President'),(40,400440,'Sophie Wilkins','Sophi.WILKINS3656@hushmail.com','3524151787','1411 Marquette',1,60552,16,'Software Engineer'),(41,400441,'Karlie Rutledge','Karli.RUTLEDG1334@mail2web.com','6575061696','5254 Kilpatrick',3,32860,35,'Office Assistant'),(42,400442,'Barbara Ford','Bar.FOR4478@live.com','4756548366','6596 Navarre',6,2425,2,'Executive Assistant'),(43,400443,'Reese Fisher','Ree.FIS7374@yahoo.com','8185520297','5121 Winston',2,84026,22,'Executive Assistant'),(44,400444,'Solomon Collins','Solomo.COL3170@live.com','8437487154','6946 Kennedy Ogden Av',1,48817,47,'Senior Data Scientist'),(45,400445,'Lucy Boyd','Lu.BOYD9078@gmail.com','6076150258','9747 Germania',1,92986,48,'Vice President'),(46,400446,'Sienna Pickett','Sie.PIC1268@hushmail.com','9795358716','5153 72nd',3,14226,23,'Sales Manager'),(47,400447,'Alonso Finch','Alonso.FIN9499@yahoo.com','7631148200','8421 108th',3,78740,23,'Project Manager'),(48,400448,'Ezekiel Rosa','Ezek.ROSA7590@yahoo.com','4845641431','837 Artesian',9,32821,34,'Project Manager'),(49,400449,'Pierre Mullen','Pierr.MULLEN4033@hushmail.com','5856232365','4074 Felton',3,90726,10,'Marketing Director'),(50,400450,'Giovanny Sutton','Giovan.SUTTO9001@live.com','5597548969','8839 122nd',8,52225,32,'Business Analyst'),(51,400400,'Perla Herring','Perla.HERRING5573@yahoo.com','4141537167','5370 Lynn White',9,66358,33,'Senior Engineer');
/*!40000 ALTER TABLE `alumni` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alumni_donation`
--

DROP TABLE IF EXISTS `alumni_donation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `alumni_donation` (
  `alumni_donation_id` int(6) NOT NULL AUTO_INCREMENT,
  `alumni_donation_memo` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `alumni_donation_amount` decimal(13,2) DEFAULT NULL,
  `alumni_id` int(6) NOT NULL,
  PRIMARY KEY (`alumni_donation_id`),
  KEY `alumni_id` (`alumni_id`),
  CONSTRAINT `alumni_donation_ibfk_1` FOREIGN KEY (`alumni_id`) REFERENCES `alumni` (`alumni_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alumni_donation`
--

LOCK TABLES `alumni_donation` WRITE;
/*!40000 ALTER TABLE `alumni_donation` DISABLE KEYS */;
INSERT INTO `alumni_donation` VALUES (1,'New Machine Learning Building',100.00,5),(2,'New Machine Learning Building',80.00,8),(3,'New Machine Learning Building',50.00,10),(4,'Annual Scholarship fund',100.00,21),(5,'Annual Scholarship fund',100.00,1),(6,'Annual Scholarship fund',100.00,3),(7,'New Machine Learning Building',200.00,11),(8,'New Machine Learning Building',100.00,18),(9,'Annual Scholarship fund',100.00,18),(10,'New Research Lab',100.00,15),(11,'New Machine Learning Building',100.00,23),(12,'New Research Lab',80.00,33),(13,'New Machine Learning Building',50.00,22),(14,'Annual Scholarship fund',100.00,16),(15,'Annual International Scholarship fund',100.00,14),(16,'Annual Scholarship fund',100.00,33),(17,'New Research Lab',200.00,31),(18,'New Machine Learning Building',100.00,19),(19,'Annual International Scholarship fund',100.00,28),(20,'New Machine Learning Building',100.00,45),(21,'New Machine Learning Building',200.00,43),(22,'New Research Lab',50.00,43),(23,'New Machine Learning Building',150.00,42),(24,'Annual Scholarship fund',120.00,46),(25,'Annual International Scholarship fund',150.00,44),(26,'Annual Scholarship fund',100.00,39),(27,'New Research Lab',200.00,41),(28,'New Machine Learning Building',100.00,49),(29,'Annual International Scholarship fund',100.00,27),(30,'New Machine Learning Building',100.00,38);
/*!40000 ALTER TABLE `alumni_donation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `city` (
  `city_id` int(11) NOT NULL AUTO_INCREMENT,
  `city_name` varchar(50) COLLATE utf8_bin NOT NULL,
  `country_id` int(11) NOT NULL,
  PRIMARY KEY (`city_id`),
  KEY `country_id_idx` (`country_id`),
  CONSTRAINT `country_id` FOREIGN KEY (`country_id`) REFERENCES `country` (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city`
--

LOCK TABLES `city` WRITE;
/*!40000 ALTER TABLE `city` DISABLE KEYS */;
INSERT INTO `city` VALUES (1,'Syracuse',1),(2,'Honolulu',10),(3,'Mobile',8),(4,'West Valley City',2),(5,'Rochester',7),(6,'Tulsa',3),(7,'Long Beach',2),(8,'Chattanooga',6),(9,'Tacoma',3),(10,'Kansas City',3),(11,'New Delhi',12);
/*!40000 ALTER TABLE `city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company`
--

DROP TABLE IF EXISTS `company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `company` (
  `company_id` int(11) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company`
--

LOCK TABLES `company` WRITE;
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
INSERT INTO `company` VALUES (1,'Adams Resources & Energy'),(2,'Campbell Soup Company'),(3,'Synnex Corporation'),(4,'Oge Energy Corp'),(5,'Allstate'),(6,'Patriot Coal Corporation'),(7,'Agco Corporation'),(8,'Union Pacific Corporation'),(9,'A.o. Smith Corporation'),(10,'Baxter International'),(11,'Reliance Steel And Aluminum'),(12,'Select Medical Corporation'),(13,'Abercrombie & Fitch Co'),(14,'Chevron Corp'),(15,'Allstate Insurance Company'),(16,'Carter\'s'),(17,'Sanderson Farms'),(18,'Kiewit'),(19,'Continental Airlines'),(20,'Jarden Corporation'),(21,'Cummins Engine'),(22,'Capital One Financial Corporation'),(23,'Exxonmobil'),(24,'Freeport-mcmoran Copper & Gold'),(25,'Quiksilver'),(26,'Adobe Systemsorporated'),(27,'Levi Strauss And Co'),(28,'Hasbro'),(29,'W. R. Berkley Corporation'),(30,'Metlife'),(31,'Southern Company'),(32,'Targa Resources'),(33,'Ametek'),(34,'Reader\'s Digest Association'),(35,'Directv'),(36,'American Tire Distributors'),(37,'Berry Plastics Corporation'),(38,'The Kroger Co'),(39,'Coventry Health Care'),(40,'Bristol Myers Squibb Company'),(41,'Flowers Foods'),(42,'Genworth Financial'),(43,'Nationwide Insurance Company'),(44,'The Scotts Miracle-gro Company'),(45,'Bio-rad Laboratories'),(46,'Teradata Corporation'),(47,'Constellation Brands'),(48,'Republic Airways Holdings'),(49,'Republic Services'),(50,'Graphic Packaging Holding Company'),(51,'Beckman Coulter');
/*!40000 ALTER TABLE `company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `country` (
  `country_id` int(11) NOT NULL AUTO_INCREMENT,
  `country_name` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
INSERT INTO `country` VALUES (1,'Norway'),(2,'Korea'),(3,'Brazil'),(4,'Vietnam'),(5,'United States'),(6,'Germany'),(7,'Australia'),(8,'Argentina'),(9,'Canada'),(10,'United Kingdom'),(11,'China'),(12,'India');
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `department` (
  `department_id` int(6) NOT NULL AUTO_INCREMENT,
  `department_name` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'Accounting'),(2,'Adult Education & Training'),(3,'Anthropology, Sociology, & Social work'),(4,'Biology'),(5,'Business School'),(6,'Civil/Environmental Engineering'),(7,'Chemistry'),(8,'Culture and Language Bridge'),(9,'Communication/Journalism'),(10,'Counseling'),(11,'Criminal Justice'),(12,'Computer Science/Software Engineering'),(13,'Center for the Study of Sport'),(14,'Curriculum & Instruction'),(15,'Digital Cultures'),(16,'Diagnostic Ultrasound'),(17,'Electrical/Computer Engineering'),(18,'Economics'),(19,'Education Administration'),(20,'Education Leadership'),(21,'Education Professional Development'),(22,'General Education'),(23,'Educating Non-Native English Speakers'),(24,'English'),(25,'Center for Leadership Formation'),(26,'Finance'),(27,'History'),(28,'Interdisciplinary Liberal Studies'),(29,'International Studies'),(30,'Institute of Public Service'),(31,'Interdisciplinary Studies'),(32,'Kinesiology'),(33,'Law School'),(34,'Literacy for Diverse Learners'),(35,'Mathematics'),(36,'Modern Languages'),(37,'Mechanical Engineering'),(38,'Management'),(39,'Marketing'),(40,'Matteo Ricci'),(41,'Nursing'),(42,'Organizational Leadership-NCS'),(43,'Performing Arts & Arts Leadership'),(44,'Philosophy'),(45,'Physics'),(46,'Political Science'),(47,'Pre-Collegiate High School Program'),(48,'Psychology'),(49,'Study Abroad'),(50,'Sport Administration & Leadership'),(51,'Student Development Administration'),(52,'Special Education'),(53,'School Psychology'),(54,'School of Theology & Ministry'),(55,'Teacher Education'),(56,'Theology and Religious Studies'),(57,'Teaching English to Speakers of Other Languages'),(58,'University Core'),(59,'Web Application & Technology Studies'),(60,'Art and Art History');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program`
--

DROP TABLE IF EXISTS `program`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `program` (
  `program_id` int(6) NOT NULL AUTO_INCREMENT,
  `program_name` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `program_begin_date` date DEFAULT NULL,
  `department_id` int(6) DEFAULT NULL,
  `program_categories_id` int(6) DEFAULT NULL,
  PRIMARY KEY (`program_id`),
  KEY `department_id` (`department_id`),
  KEY `program_categories_id` (`program_categories_id`),
  CONSTRAINT `program_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`),
  CONSTRAINT `program_ibfk_2` FOREIGN KEY (`program_categories_id`) REFERENCES `program_categories` (`program_categories_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program`
--

LOCK TABLES `program` WRITE;
/*!40000 ALTER TABLE `program` DISABLE KEYS */;
INSERT INTO `program` VALUES (1,'Mechanical Engineering','1910-10-31',37,2),(2,'Computer Science','1981-12-16',12,2),(3,'Civil and Environmental Engineering ','1929-05-16',6,2),(4,'MSBA','1996-03-12',5,1),(5,'Chemistry','2007-10-12',7,2),(6,'MSF','1985-02-23',26,1),(7,'PMBA','2005-04-30',5,1),(8,'Business 118omics','1921-12-09',5,2),(9,'Sociology','2008-01-23',3,2),(10,'Finance','1991-03-01',26,2),(11,'Business and Law','1973-09-09',5,2),(12,'Business Analytics','1906-05-22',5,2),(13,'BRMB','2013-04-18',5,1),(14,'MPAC','1904-07-11',1,1),(15,'MSBL','1932-04-24',5,1),(16,'MSBA','1982-10-03',5,1),(17,'Information System','1988-02-01',5,2),(18,'Marketing','1961-01-13',39,2),(19,'118omics','1944-02-21',18,2),(20,'107ory','2005-08-01',27,2),(21,'Management','1972-04-29',38,2),(22,'Mathematics','2009-04-03',35,2),(23,'International Business','2001-09-24',29,2),(24,'Psychology ','2009-04-03',53,2),(25,'Accounting','1995-02-09',1,2),(26,'Nursing','2009-04-03',41,2);
/*!40000 ALTER TABLE `program` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program_categories`
--

DROP TABLE IF EXISTS `program_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `program_categories` (
  `program_categories_id` int(6) NOT NULL AUTO_INCREMENT,
  `program_categories_name` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`program_categories_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program_categories`
--

LOCK TABLES `program_categories` WRITE;
/*!40000 ALTER TABLE `program_categories` DISABLE KEYS */;
INSERT INTO `program_categories` VALUES (1,'Graduate'),(2,'Under Graduate'),(3,'Certificate');
/*!40000 ALTER TABLE `program_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `viewalleventscatalogue`
--

DROP TABLE IF EXISTS `viewalleventscatalogue`;
/*!50001 DROP VIEW IF EXISTS `viewalleventscatalogue`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `viewalleventscatalogue` AS SELECT 
 1 AS `all_events_name`,
 1 AS `event_date`,
 1 AS `event_start_time`,
 1 AS `event_end_time`,
 1 AS `host_department`,
 1 AS `location`,
 1 AS `city_name`,
 1 AS `country_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `viewdonationbycampaign`
--

DROP TABLE IF EXISTS `viewdonationbycampaign`;
/*!50001 DROP VIEW IF EXISTS `viewdonationbycampaign`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `viewdonationbycampaign` AS SELECT 
 1 AS `CampaignName`,
 1 AS `TotalDonation_USD`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `viewtop5donation`
--

DROP TABLE IF EXISTS `viewtop5donation`;
/*!50001 DROP VIEW IF EXISTS `viewtop5donation`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `viewtop5donation` AS SELECT 
 1 AS `alumni_name`,
 1 AS `Total_Donation`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'segr5300'
--
/*!50003 DROP PROCEDURE IF EXISTS `spFindAlumniByDepartment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=CURRENT_USER PROCEDURE `spFindAlumniByDepartment`(
				dept_id INT
                )
    COMMENT 'EXAMPLE CALL -> CALL spFindAlumniByDepartment(5)'
BEGIN

SET @dept_name = (SELECT department_name from department where department_id = dept_id);

SELECT alumni_name, alumni_emailID, alumni_designation, 
		c.company_name, @dept_name as department
FROM alumni a
LEFT JOIN alum_program ap
ON a.alumni_id = ap.alumni_id
LEFT JOIN company c
ON a.company_id = c.company_id
WHERE ap.program_id IN (SELECT program_id FROM program WHERE department_id = dept_id);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spInviteProgramAlumniToEvent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=CURRENT_USER PROCEDURE `spInviteProgramAlumniToEvent`(
				event_name VARCHAR(50),
                event_start_DT DATETIME,
                event_end_DT DATETIME,
                event_location VARCHAR(50),
                event_department_id INT,
                event_city_id INT,
                my_program_name VARCHAR(50)
                )
    COMMENT 'This stored procedure allows the user to create an event and invite all alumni from a program.'
BEGIN

INSERT INTO `segr5300`.`all_events`
(`all_events_name`,
`all_events_start_time`,
`all_events_end_time`,
`all_events_address`,
`department_id`,
`city_id`)
VALUES
(event_name,
event_start_DT,
event_end_DT,
event_location,
event_department_id,
event_city_id);


SET @event_id = (SELECT LAST_INSERT_ID());

INSERT INTO `segr5300`.`alum_events`
(`all_events_id`,`alumni_id`,`attended`)
SELECT @event_id, a.alumni_id, 0
FROM alum_program ap
LEFT JOIN alumni a
ON ap.alumni_id = a.alumni_id
WHERE program_id IN (SELECT program_id 
					FROM program
					WHERE program_name = my_program_name);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `viewalleventscatalogue`
--

/*!50001 DROP VIEW IF EXISTS `viewalleventscatalogue`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=CURRENT_USER SQL SECURITY DEFINER */
/*!50001 VIEW `viewalleventscatalogue` AS select `e`.`all_events_name` AS `all_events_name`,date_format(`e`.`all_events_start_time`,'%e %b %Y') AS `event_date`,date_format(`e`.`all_events_start_time`,'%r') AS `event_start_time`,date_format(`e`.`all_events_end_time`,'%r') AS `event_end_time`,`d`.`department_name` AS `host_department`,`e`.`all_events_address` AS `location`,`c`.`city_name` AS `city_name`,`cn`.`country_name` AS `country_name` from (((`all_events` `e` left join `department` `d` on((`e`.`department_id` = `d`.`department_id`))) left join `city` `c` on((`e`.`city_id` = `c`.`city_id`))) left join `country` `cn` on((`c`.`country_id` = `cn`.`country_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `viewdonationbycampaign`
--

/*!50001 DROP VIEW IF EXISTS `viewdonationbycampaign`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=CURRENT_USER SQL SECURITY DEFINER */
/*!50001 VIEW `viewdonationbycampaign` AS select `d`.`alumni_donation_memo` AS `CampaignName`,sum(`d`.`alumni_donation_amount`) AS `TotalDonation_USD` from `alumni_donation` `d` group by `d`.`alumni_donation_memo` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `viewtop5donation`
--

/*!50001 DROP VIEW IF EXISTS `viewtop5donation`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=CURRENT_USER SQL SECURITY DEFINER */
/*!50001 VIEW `viewtop5donation` AS select `a`.`alumni_name` AS `alumni_name`,`d`.`Total_Donation` AS `Total_Donation` from ((select `d`.`alumni_id` AS `alumni_id`,sum(`d`.`alumni_donation_amount`) AS `Total_Donation` from `alumni_donation` `d` group by `d`.`alumni_id` order by `Total_Donation` desc limit 5) `d` left join `alumni` `a` on((`a`.`alumni_id` = `d`.`alumni_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-06-04 21:55:36

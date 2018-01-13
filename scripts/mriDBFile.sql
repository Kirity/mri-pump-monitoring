CREATE DATABASE  IF NOT EXISTS `mri` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `mri`;
-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: localhost    Database: mri
-- ------------------------------------------------------
-- Server version	5.7.11-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `errorlogs`
--

DROP TABLE IF EXISTS `errorlogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `errorlogs` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Message` varchar(3000) NOT NULL,
  `MeasuredDateTime` datetime NOT NULL,
  `MeasureTypes_ID` int(11) NOT NULL,
  `MRI_ID` int(11) NOT NULL,
  `PI_DATETIME` datetime NOT NULL,
  `CREATEDON` datetime NOT NULL,
  `LOGFILENAME` varchar(200) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_ErrorLogs_MeasureTypes1_idx` (`MeasureTypes_ID`),
  KEY `fk_ErrorLogs_MRIList1_idx` (`MRI_ID`),
  CONSTRAINT `fk_ErrorLogs_MRIList1` FOREIGN KEY (`MRI_ID`) REFERENCES `mrilist` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ErrorLogs_MeasureTypes1` FOREIGN KEY (`MeasureTypes_ID`) REFERENCES `measuretypes` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `errorlogs`
--

LOCK TABLES `errorlogs` WRITE;
/*!40000 ALTER TABLE `errorlogs` DISABLE KEYS */;
/*!40000 ALTER TABLE `errorlogs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fileprocesshistory`
--

DROP TABLE IF EXISTS `fileprocesshistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fileprocesshistory` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `MRIList_ID` int(11) NOT NULL,
  `PROCESSDATETIME` datetime NOT NULL,
  `MeasureTypes_ID` int(11) NOT NULL,
  `TOTALFILES` int(11) NOT NULL,
  `ERRORCOUNT` int(11) NOT NULL,
  `SUCCESSCOUNT` int(11) NOT NULL,
  `CREATEDON` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_FileProcessHistory_MRIList1_idx` (`MRIList_ID`),
  KEY `fk_FileProcessHistory_MeasureTypes1_idx` (`MeasureTypes_ID`),
  CONSTRAINT `fk_FileProcessHistory_MRIList1` FOREIGN KEY (`MRIList_ID`) REFERENCES `mrilist` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_FileProcessHistory_MeasureTypes1` FOREIGN KEY (`MeasureTypes_ID`) REFERENCES `measuretypes` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=283 DEFAULT CHARSET=utf8 COMMENT='		';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fileprocesshistory`
--

LOCK TABLES `fileprocesshistory` WRITE;
/*!40000 ALTER TABLE `fileprocesshistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `fileprocesshistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `images` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `MRI_ID` int(11) NOT NULL,
  `IMAGE` blob NOT NULL,
  `FILENAME` varchar(100) NOT NULL,
  `CREATEDDATE` datetime NOT NULL,
  `PI_CREATEDDATE` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_Temperature_MRIList1_idx` (`MRI_ID`),
  CONSTRAINT `fk_Temperature_MRIList11` FOREIGN KEY (`MRI_ID`) REFERENCES `mrilist` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobrunhistory`
--

DROP TABLE IF EXISTS `jobrunhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobrunhistory` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `JobRunStatus_ID` int(11) NOT NULL,
  `MRIList_ID` int(11) NOT NULL,
  `RUNTIME` datetime NOT NULL,
  `MESSAGE` varchar(3000) DEFAULT NULL,
  `CREATEDON` datetime NOT NULL,
  `STATUSMAILSENT` int(1) DEFAULT NULL,
  `TEMPERATURE_ALERT` int(1) DEFAULT NULL,
  `PRESSURE_ALERT` int(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_JobRunHistory_MRIList1_idx` (`MRIList_ID`),
  KEY `fk_JobRunHistory_JobRunStatus1_idx` (`JobRunStatus_ID`),
  CONSTRAINT `fk_JobRunHistory_JobRunStatus1` FOREIGN KEY (`JobRunStatus_ID`) REFERENCES `jobrunstatus` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_JobRunHistory_MRIList1` FOREIGN KEY (`MRIList_ID`) REFERENCES `mrilist` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=dec8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobrunhistory`
--

LOCK TABLES `jobrunhistory` WRITE;
/*!40000 ALTER TABLE `jobrunhistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobrunhistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobrunstatus`
--

DROP TABLE IF EXISTS `jobrunstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobrunstatus` (
  `ID` int(11) NOT NULL,
  `Name` varchar(45) NOT NULL,
  `CreatedOn` datetime NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobrunstatus`
--

LOCK TABLES `jobrunstatus` WRITE;
/*!40000 ALTER TABLE `jobrunstatus` DISABLE KEYS */;
INSERT INTO `jobrunstatus` VALUES (1,'Success','2017-05-11 15:25:24'),(2,'Error','2017-05-11 15:29:41'),(3,'Database Error','2017-05-11 15:29:43');
/*!40000 ALTER TABLE `jobrunstatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locations` (
  `ID` int(11) NOT NULL,
  `Location` varchar(45) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
INSERT INTO `locations` VALUES (1,'Magdeburg-Uni'),(2,'Magdeburg-Klinikum'),(3,'Magdeburg-Fabrik'),(4,'Magdeburg-Nord'),(5,'Berlin-Klinikum'),(6,'Stendal'),(7,'Munich-Nord');
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `measuretypes`
--

DROP TABLE IF EXISTS `measuretypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `measuretypes` (
  `ID` int(11) NOT NULL,
  `Name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `measuretypes`
--

LOCK TABLES `measuretypes` WRITE;
/*!40000 ALTER TABLE `measuretypes` DISABLE KEYS */;
INSERT INTO `measuretypes` VALUES (1,'Temperature'),(2,'Pressure'),(3,'Image '),(4,'Sound '),(5,'Temperature error'),(6,'Pressure error');
/*!40000 ALTER TABLE `measuretypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mri`
--

DROP TABLE IF EXISTS `mri`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mri` (
  `Name` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mri`
--

LOCK TABLES `mri` WRITE;
/*!40000 ALTER TABLE `mri` DISABLE KEYS */;
/*!40000 ALTER TABLE `mri` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mrilist`
--

DROP TABLE IF EXISTS `mrilist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mrilist` (
  `ID` int(11) NOT NULL,
  `Name` varchar(45) NOT NULL,
  `LocationID` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `Location_FK_idx` (`LocationID`),
  CONSTRAINT `Location_FK` FOREIGN KEY (`LocationID`) REFERENCES `locations` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mrilist`
--

LOCK TABLES `mrilist` WRITE;
/*!40000 ALTER TABLE `mrilist` DISABLE KEYS */;
INSERT INTO `mrilist` VALUES (1,'Mag Uni -1 ',1),(2,'Mag Uni -2',1),(3,'Magdeburg-Klinikum - 1',2),(4,'Magdeburg-Fabrik - 1',3),(5,'Magdeburg-Nord',4),(6,'Magdeburg-Nord',4),(7,'Berlin-Klinikum',5);
/*!40000 ALTER TABLE `mrilist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pressure`
--

DROP TABLE IF EXISTS `pressure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pressure` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `MRI_ID` int(11) NOT NULL,
  `VALUE` double NOT NULL,
  `MEASURED_DATE_TIME` datetime NOT NULL,
  `CREATEDDATE` datetime DEFAULT NULL,
  `PI_CREATEDDATE` datetime DEFAULT NULL,
  `LOGFILENAME` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_Temperature_MRIList1_idx` (`MRI_ID`),
  CONSTRAINT `fk_Temperature_MRIList10` FOREIGN KEY (`MRI_ID`) REFERENCES `mrilist` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=241 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pressure`
--

LOCK TABLES `pressure` WRITE;
/*!40000 ALTER TABLE `pressure` DISABLE KEYS */;
/*!40000 ALTER TABLE `pressure` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recordings`
--

DROP TABLE IF EXISTS `recordings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recordings` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `MRIList_ID` int(11) NOT NULL,
  `VALUE` blob NOT NULL,
  `FILENAME` varchar(100) NOT NULL,
  `CREATEDDATE` datetime NOT NULL,
  `PI_CREATEDDATE` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_RECORDINGS_MRIList1_idx` (`MRIList_ID`),
  CONSTRAINT `fk_RECORDINGS_MRIList1` FOREIGN KEY (`MRIList_ID`) REFERENCES `mrilist` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recordings`
--

LOCK TABLES `recordings` WRITE;
/*!40000 ALTER TABLE `recordings` DISABLE KEYS */;
/*!40000 ALTER TABLE `recordings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `ID` int(11) NOT NULL,
  `NAME` varchar(45) NOT NULL,
  `DESCRIPTION` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'MRI User','Normal user who may have some MRI\'s under him'),(2,'Admin','Who should able see data of all MRI\'s');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student` (
  `id` int(11) NOT NULL,
  `name` text,
  `score` int(11) DEFAULT NULL,
  `percentage` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (1,'rakesh',50,51.2),(2,'roshan',70,71.3),(3,'pavan',80,83.3);
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `temperature`
--

DROP TABLE IF EXISTS `temperature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temperature` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `MRI_ID` int(11) NOT NULL,
  `VALUE` double NOT NULL,
  `MEASURED_DATE_TIME` datetime NOT NULL,
  `LOGFILENAME` varchar(100) DEFAULT NULL,
  `PI_CREATEDDATE` datetime DEFAULT NULL,
  `CREATEDDATE` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_Temperature_MRIList1_idx` (`MRI_ID`),
  CONSTRAINT `fk_Temperature_MRIList1` FOREIGN KEY (`MRI_ID`) REFERENCES `mrilist` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=356 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `temperature`
--

LOCK TABLES `temperature` WRITE;
/*!40000 ALTER TABLE `temperature` DISABLE KEYS */;
/*!40000 ALTER TABLE `temperature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test` (
  `Type` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test`
--

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
INSERT INTO `test` VALUES ('�\��\�\0JFIF\0\0\0\0\0\0�\�\0�\0	( \Z%!1!%)+...383-7(-.+\n\n\n\r-%%--------------------------------------------------��\0\0�\0�\�\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\�\0>\0\0\0\0\0!1AQa\"q��2���\��BRb\�\�#3r����CSs��\�\0\0\0\0\0\0\0\0\0\0\0\0\0�\�\04\0\0\0\0\0!1AQa\"q�����2�\�\�B�#3rR�\�\0\0\0?\0��!�R\�\0\�Er\�N�)*6B\���R%2X;4\nF-\�B\"\�\0y\�Q2\�\n�l#E\�+�X\�<�D�\�!+����\"|�\�KS.-�i���E�hp�%�-\Z�m\�D�\�\�L�ŜS\"��Ǌ�Z\��F\r����B�+�\�}OiV\�0�\�I�\�\�x��ޝ>{�\�;\�j6\�7N�\�M��ԁ7�^~�Z�]\�\�\�Gԏ\�le7L\�~����4���\�u��\�\�x>W\�1Y\�NXa3`N�t騷x\�\��V&i\�@i�i�\'�\�7�Z�S\�a]u�$6M�\�M�G�d-\����\�\�iF\\��\�vw�Z\���\�\�M�gn\���\�\�\�\�\����\�\�2�b���\�?�u\�z����ZN;m/\��f�j\�.貦ݤI�\�\"[\�>ˇ=\rH\�\�5F��\�ՊOo%6/��M쎝;\�eN/^V�\�¤\�,	\�+E j\�\n�Lj�-��p\�I\�&R�Ĭ�qàE\Z}�M�MQK�rԻ�/U��`�yQ\\�,�nY�!�c\�d��a�\��E�z\�\�\0���\�5m	rY��k%��l����Ja.\��ڕ\�Ӌ\\�hJϪ\�B�7O\�Sj9g\��xO\�\�is\�\�E�|�\\N�U�����\�\�Ȋ\�ZX�<��t\�o�\�\�\�H�\rϒʝ�W�zV(�O�\�I\�L\�\�P�\�g��\�c�/U6|\�b�\�\�iA#\�N\�\�ã�7c�\�ih#3�\�<�˧U�jo)�v\�#8��2*�\�\��a��.[�2�-.:�~\�\�I\�0D\�\�4��+^)\�J;&�qw\�U1�}F8���\�r��Tz�Ҍ�pW�סf+\�\�\�\rpqc\�q���\0�mE\�Ҥ\��\�\��\�������8�\rLA�p\��\��>+�\�WNj�\��\���\�Ӗ\�n�\�c�xH��A4\�B�EV@�J\Z\�2\�W\r��b%�\�r��5�d�R��Ct\�XD1\rE��#l��.H$˖\�a�)�\�|�\n�\�\�\��mHt*�\�2\�\�	cJLC`�\�\0�\n\�k��S��)MB.O�\n\�\�8^�\�a�~��q\�\�ޒ��z��J�\��\�b�\�&N�\�\��\�\�B\�\n1�d\�W����\�o`\��^z�{�>�4�bՙ�=\n\�\'�.ߞ+V�v�B�J\�\�>r\�\\���sR\�x_\\�X\��>����$\�\�\�\\�Ӫ\�\�N��\�\�[\�Fm�S�w��\�--ze�pg4�CHi?�U\0�|s��~�\�\�l\'.\�#Po�7%,\�=-��C4M��\�na\�b�f#}-\�G�\0#\�S����UT�4��S�\�\��\���#F��\���\��\�ܴ�\Z\�4=\�5�\�\�NRDG�	�t�-�k�\�\�\��\�|\��7�4�=�c-<\�}\�踺�?�Sj\�\�F[�^Vp\�I��%�U\�\"�1\�6\n����\�P\'`�\n�ѩ.\���U\"P).\�\� 1v&2�4�	��ԉ;0\�~&˧R�����\�!K܄ipV��򋬖<�Ƕ\��v�:���Sg�\�\'���z,ڽ\\h��y>\�\�Ԛ�58^I�\Z\��2|]̮L�U\'�\��\�+6�\�\'��Ir�b�ٶi�Uր~˗^i�m2v\��Dx$ri��K\�\�،�O鉟%\��};�?\�[�\r\�fn�h�.\�	\�w�� W��Cj[^~�Jm�\'\�p�����Cr�\�d�bA���[|�+I\�\�#s\�q�Y-\0���\�\�\'.�Y&�\n��1\n2�V\���\�\�wxG�\���\\��\�Ƣە�U���f�b\�\"a�\�\�$\��z���\�\�N��\�إİ�$��\�\�jUՃ�\�~w[�?B��4ˤ���\�x_�&c\�o\��2�\�\�\�9�8�3k��\\h���A��V-ER��T\�_��\�\�Q\\!芅����e�@Blj y&\�%�p�V1)�\�u\�U)\�_��D��\�\�=&H����\0\�\�R&^\�\�\�W�\�\'\�%\'�$*)�\�\"8標�P%�\r\�=\�S& IөV��*F��\�\�P�\�N$��I2\�Lf\�\Z�\�֛�����\�\�ZQc±��\�\�V2�o\���3�H�����ӹ��-\Z.T���h�*�V�Iۗ�*p��|\�ݣ\r\�8�q�\0-:�w�\�\�\�h�(�\�7�XMNn�����\�Ǚ��3��<}J��\�fߋG�3�46 ͚G;N�Kx-1���\�Ж%�y5\0\�6hu\�\�I��U�URQ^d_\�_���\��\�`�TkK�y��\�0DA��\�\�p#�p��\��q���������?r;�mLC�@@m\����5����\�ҫ*\�\�V\\{�?0s%<�@c��fwh1�\�4\�Ԥ����\�Jd)\�|�\�\�-?#JJi\�\�z��bۆ�9\�M�mk���>\��%V\�.~�N\�ý�`\�oE\�*Cd\�{;�H ,�\n���͒�a\Z\��� U�\�\���8\�$�S+1\�Zi1l�+HA��\�$�c�$u,EѲ�L�U\�\�V�\�R9\n\�k:J�VDQ\�D�\0gL�\0=\Z)�`�d,dx-�ns^��ngLD\�s\�.�\��2\�쁩��I�\�	\�M\�H\�\�qa�2Q�6\���&ܑmv)F\�<3\Zm�UjnHӥh��\0\�1��\�갭-I~�s�\Z\�2��q�\�pm\�\��\�xw�Tu\"\�Lا]\�\��d+b�\�\�\0�\�-�j\�\�k�\�\�;�\�\�:	\��ZgM\�^.ނ�\�*!\�<�H�A\�c\�\Z\�ɴT�+\�߷\�\"\�f��0\�e�k\�IL\�\"�h��\r��O�p�RLR�<\�Hyi\���^Vt�NMIs���YJv\�u�I|���>�[T˶\�\�\�~˥\�R\�xI�MkS��WRn�-0H�1��\�]WrT��\�\�\�ϙ�K i�5\�I��E�믌!�$��>�}Bv�i\�Z\�\�G{0�\���Q\�jW��\�`7t2u$�d�\�\�\�ɮ\�\�nXD\�< \�7\�,h���h �\�K�J\�\"6!�j\�I�T\�\�kA\�\�e1\�:�F��2,CpI\��\�$�\�KA&\�\�\Z�\�[t3�R�dE�3���N��\�\�=\��C\"s�~�E�;\�B\�Cs]/�.丷d\�\�K\�.kI.q��\0\\�͂ki�Y\��oqW�\�\\Ii.hm�\��l��B�vN�\09ge1E�y`c[&\\\�cX\��:j)ݾ\�ʬ%^�d��D�ื�dc�MB\Z]\�\�Ho�\�,��P�7\�_nm\���Mb\�\�0\0 2\�\Z\�\�`�\0!��\�euZ��ZM�\�?!.N\�\'\�\�zmm�m?\�\�{D�,/\�\�	\r\�o��v<=%\Zi�\�}\�:i�J\�\�ĮhHI\�r��\�\�\Zw{ȹvmbD��\�\�\�R���e�K��	\�\�L�\��\0JB�[��\�ة6��\� �\�p\��xj�v����\��`��fyf>S\'q��\�\���\01m<\�`\�bF�\"�\Zm%sjh�\�^)ŚUI.r �k�mk[t�-5��K\�ｑ\Z\�q@6\�r���Z}T�\�X\��$t\�u!�\�w]\'�l\�8�Ϊ�\�۠\�y\��\\\ZV�Q�i;\n�(Y6�(x,\�pD��l:	�=H��,W\Z�L���Z\�DK�Dc�(��\�\�W���\0�\�V\�\�;h|a#Q^��L�\��\�Xl;�F�\�:��\�oP\�C���zv�WWR�me?�\��\0\�0�E�4\�}G\rɒdn\�M��yIg�\��@_�*�\0\�\�&I�\�㭴h<�?\�N��\�.\�UN&��\�N�t~}TtTa��M\r9\�4;��|�\\L�AA{\0{C\��Z\����\�Ǫ	��q�i��`\r\� �%ӌ԰�K�E�hs\"�\Z\�e�h\"\�\0�mI�y6�v˴�W\�-�g�\��ԓ��;\�\�j�[�;G\�4�����\�\r$\��\�WӡO�\�\�\�J�\�+�1\�ik\�mo���\�i⭺<\Z!\�+\�\�\�-6�o��H˯�|;u+\��ϒ\�M��e-:|d��*\�VfGR�\�-Άb\'���ǩm \��~\�\�\��1{�S��6\�\�m\r\�9��@ӗy\�T1������\\au*\�.�H&\�\�DV�+���Z�\�*t��,�O\���\��\�q�J�=P\�qĳٺy�\�\�t��gZz*R���\�\0��E\�->Dx�S\\��S\�\�{<��\�:\��p*�\n�p�:�,Zՙ����\�(\�;*e�6\�%4�b.�)��ڴŔ�{�\�\�`M�\'ԡ�8\�\��\�Qhψ�.\r\�\�$\�6h=\\v\\z�\"�W��\��\�M�58\Zl�kCl��\�\0�\�4z4\�5�`�\�&ۻ�K\���@o��TcD8�\�ng̕ \�Kw�X��dN�s\�sn\�\��\�\'S\�\�O|\�xDk 1�9w|I\�\����\�	\�A��8$0-1��En�\��{��AD>�s\\h�N�h�\Z�R\�li\�WEuz�As��S\\��\�f�S$N�\0�\�\�\�S\�5)�\Z#Xq\�0\�a��\\zz���=,��QS�%����U=�u�Δd݋�L�\�u\�^\�o\nr�Rl٥���\nע\� k\�\�\�\�0J\�W=%\r$9j\�_-\�<\�\��2�\'w�CTt[n\�\�C\�$s\��]%Y\��_ɚ��R��\�++`\Z\�`�\��*\�l��Ie�Lf ���\�\Z��S�ǃ$��\\X�%I��[��S�\�w0�\0���Z�3\�^&s.\�ؔ\�\��\�N�i�{�P���#\'\���\�8�ٸe\���>g\�g�\�g�_\�s$�*��Z���4fX\�7�M]`�z_�X\�\�Z�`��\�Ѿ\0��x�\�X0k5~\\Z�)J\�y��Q��		���daY0FQ�D@���M\�$�a�\�%�	\�����)�Fc�ZH\�{uu1�M\��=X2>���8\�3\Z\�\���Γ���ڝl\�;�\�=q�E��ݭ\�\�\�\��X�\��	/B�L�;-��s-H��\�ps\�\�A??�ن�*.\�\�1�ow�V��\�\�\�F�~�w+xH�|�\�f\�`�\'��\�\����~Ȩ\�$��>+\�h�I֝�2�\ZP�d\�7P�;ar3�\��>�\"t\0X��AW[{4�o�u����/��S�\���\'ě�5u5*\�o\�\�\�t#��Vf�\�E\�?��)n͊t\�\08!\��\0�\�߯>��\�b\�\�*+v\�o�vo.!\�s=\�\�Ϸ����\�\�ڱ\���L�M.b\�y�Ü[����\0�S�p[��3�\�\�I�u?R��\0d�׸�T�_\�6�@2�U.\�ٸ鉷4I�*̰�xn��Z\�Ԩ�fe�(\��B�ce��\�m-�\\b��Ith4��\�y��S��{�\�\�s*5\�6���O�\�ti4\�޿�\��B��\�\�\��Z\�$SR_�\n��\0\�7ᯨs�\�#�x*�f�#��\�iS\�I?��\�\�\r��+#�^��\�t�J`��XA��\�\n���?M�Y\�)�\�\�\�$\r2ŌP	5\�\�\� \rJLcvSi+�\������Z@\�\\�d�\�\�f#\�W\�w9�\��\0\�͆�Τo\����\r]zw��\�#,t�y\�Ђ\�Y�a�Z)\�h�B\�c�R,t\�&>_�]M<������1>\"\�\�\�\�DJmv�\��&!L\�f]ɓ�Z\Z\�+����\�0w�\�.6\�T5j�GsEᮣR��:�\06\0@e\�M�vw8�d6\��7.�J\�۹\�\�Zd���T�\�\�q�\r\�u\�.NªJ\�\�t��t�	2\\�,�v\�.tM\�f���tQqL\0tTa9��\�?u��k{\�\�:-MK��ɏi*MJǠ�\�Sף�\n\�]\\\�	�L�\����k��U\�\�T�\�\�(\�@ĸ�����B*1�BTh\� O>JFKnyQ����\�ܵ)\�4\�\�L�b�R�\�\��\�ҋ�y1\�\r\��\�vzs���\�\��\�z\�WV�}�̕�ϣ�G\�\��(f�\'�H\�bjK�NHC\�;�QS(YA����Wr�u�m,�r$\�U�m�	RW!s�\�\Z~\�}\��A\� ��<\��iW�c��\�y\�\�H�\��H�\�v��\�\0{�=\�,>!���9\�<~�\0���c��\�\��\'��\� �S���֧QI&��p�\rUJ��/\�\�B}9���\\0f�� #���\�t\�I�eL��\�\�l>�GE�MJ)�t�}\�/.Yb*\�k@�GH�+<��N���E=ɱ�<ە�\�:\\��J\�kw�|�B㋋R�.�a\�\�t�M{*\�\�V�\��g���5ȁt/�F���\\3z������\�\�l\Z\�/3\�7Dc/?���\���\�e��~�\�ے8�3�ًW\�\05\�\�:�G\'bo�\�#M�4�\��\�\�dğ�\�ۜe\��f�VҋO�\�\r:��\�phu�8\�\�&&F�5�LKb��/j\�\�Ò\�\�\�*�\�,��J3OwS7�\�ң�ٝH$\r��ݡV.\n\�.Ǟ���&ѕℴ\�W�[�Pi�j&���ʥ\�;\n\�\"eb	$$\��\"\�\��d�-�]�Z���e�9n�!�~�Tx,x��`8C����H��W(�\�\�\�\'��]�\'ܬ:���\�@E(n�����3\�\'��\��6|�\0\\I\�~~j���i6M\�\�c&�U(\�l�\\\ZU�2�N6=\'tD���\rH�4h�lv${l�\0\�~p]ZTߕ�-\��G�\\F��NR\�G�\�\���u$\�+�&�\�o5N��ǨF	\�ڎ\'(�\�\�d-F\�a\�Ouz�ȅ|\�\�+sj\��H C!����/)\�,�\�{�?����v:�uH�~��Q\��!ӯ��\0\����`���:�P�\�)���\��4r\�\�	n���\�`q&H�8a\\\�\��\�-0 �{�c%,�~��~́V$\��\�2�%���{\rR�\�L��i�\�#���*`ɩ�\�a�o�ٙ1���J��Э�Q�mpG\��\ZZ\'��d�\�6\�d�`jg�����\�Ws\�F�\�y�\"m��KW^\�vb-\�f�CR��Z�p?��s|�> �Βuee�s�E\�Uc��\�$1��34ɍsG�\�\�t)j7\�cY8��0�\�tV�\\\�D�E��d\����%T+L0-e\�~�8Kd.8]3�t\�\�C`>Bu:r�\�\�\�}Q��W�~}\�\�%\�q;�v�?\�d\�i\�>(%�$*\�V]H$�w�\�\�\\\"�$\�==\�T�\�\�.\�\�\Z5&m\�\�j�nqs}pr\�i\�nX4�n6ưI\��\�\�p���\�\�:Tu)G<�\�-ox<�O�fzi&�n����	[���A\Zf�\��e\��A\'@��\�WY7\n)!�n�~\�\�\n ߕ�:,r�X=\"°cB`\�\�\\�M���M�\�:���\�\"��N��\n�pk��\"T�\�h��}\�9\�N�N�\�\�\�������\�\\q�\�\�Oת\Z��%~\Zd\�Ɵ��avV�\�\�\��%T�������C�04uEE�3��V\�|�M�8Z`��:�HӚo�y*����\��uԩ\�\�B�.`3\�ܼV�\�M\�\r{Z�+\��	{ÄF\�:->D%f���jJOl�\ZM\�\�Iק�\�,J\�\�Ќb��k��[\�nP\�]\�!ל\�w�nsc\���N��\�jF[?c?\�J%�\�34\Z�M��\�褣8��#Z\�M�bm�P����â\�X7R�I�AYG3(ct �颹e�=��\�D�G��ٳ!\�Ľ\�>@.��m��\�s�/�]^�$�\�Hq��\0U̫QoW\�\\^\�K�\n�\�\�1\�\���M�{\�)\�\�.�\�V�y�;\�tR)�E���V	\�\��Aȃ\�;\�D��ZޝEyr\�\����b�w\�\���Ca\�|�\�~��T�RYj�\0�R\�8\�)dkǝ0L�\�~ҹ:�گl�\�%n>�\�Y\�hc�\\���\����\�\Zt\��\"9\�\�gc	dv���K�)\�$\�͇��N�ݜ��[�\�\���\n��Q$�\�s\���x�{|�j\�db\�\�\\��\'�7MLr�僸|[����S��������\�\0�}\�R{� \�+����A�	�PV\�J�$�6gB�=�\�9pG�~S�\�uE\n\��\��S�\����b��Av��^+�{+���NipQqv1\�	k�u��ɋ=�rj\n�26\�6\��r8��\��u��(j\�.;�\Z(\�2\�\�;\�:m�apH�\�\�<�\\G ��Rx1��\�C�a�[G�\�\�\�c�{��p�M\\\�\�\�\�mS\���\�[\�0�����\�\�\�<��y�[ B�\��i�,\�\�Q\�P��@X\�\r�B�\���-	,�F�\r�ՠxܐ|��\�%\�\��\0���f*�\�+c,$I��ZEZP�m~�\0�\Z���\�\0r�o�\�\�\�zє\Z�P�w���H\�ۛ>>Z�\�\��n��~��Y��D\�@$���������V�\�n}_\�ǣ\�%z	Wq�\�w~%d�9mN8k\r|�s\�p\�ϗ�\�R/=G�nM�e�%\�w8\�s;�cF|ד\�\�Q��\�\��;=���dm�f�\0\���\�p\�f�ua&Ʃ�v�r��SV�\\j�!y~|����]�\�t��ѥdD��M�\�22i�\�\"�9h�\�76�&��1JHtj8���rG���;�8\�h6O��I�Ũ���X��B\�D\�lz�h\��+��\\�\�Z \�\�&yW�\\&�r��U$\�|=I=\�\���#��*R$\�\":�]��-\�t�s%w�v\�8l�2�@�Zi��\�J�C�F+#4x��Û.m�\�0�J��>\�b*{\�8\�\�\�\�1Eq&��N/h�\�5�~\�\Z`�\�\�\�ӡ5��a�Q�\�>Y�\�i�\�\�O\�u�\�i3�V6i�B\�yMhH\��\��1��\�\�#\�KM�\�Wb0�n�hRк��U2\rQ9J�,&\�lAj�sx����z]�M5�ž��h\�_|\�\�\'\��Bq�xq\��\"~Ř\� v\0\�%?Q��&\�5�\�,�2g��\�\����\�\�\�\'�$��%re�t\�T��\�\�\�\����,Ys|/�+�L��myt �������E5\�\�?Ka|��\�t�+R�\�F��\�?���q\�ǔ%GU&u\'\�\��4�\�&���a\�c�u�\�\Z��| ����B�?\�4h\��\�E.\�3\�\n����.\'\�l�\�h8%s\�A���0\�/\0|O�X\�K�o|k9Xi䩾\�[R��D�\�R`�<Dw\r4)M�rJklc}�E\"E�۪(I&v�pF\�u?u�U\\\�ҥ\�s�\�/�\�&u7�V{�dq8�\r�\�\�\�\n}KL%PXX0�ԋR�\�UN��\�\�l�y)i[z�\�ۢ��\�\�7\�l\�A\�\��4\�F��\\z�>�kLD�>��\�Q��f�\��d��1\�K\�&\�E���FU�#OkW��\�\0��\0�\rO+�\�S�BUq\\r�|\�i��d�E�\r�K\�kk���\�\�\�\Z�V\�>J\�[Zֹ\�p�L����79�\�Wt�m\�?ɗQR;6u\�\�qL>P	ԙ���\'�\��U��\� ´4c-xmQ)�\�\�V\n\�eIq~#��nX�#3SAWp\Z��J���\�f�A4s\�\�a�\�ɣS�\�B;\�Z\�Vp�C���\�o��Y]��ٺO�\�<	\�AIn\�\�\��?���8/j˯�d]\�\�O?(R�rRN<g\�\�Ȗ��*\�\�O$.�\��$G+\�4�\Z�k���M%xT�\�J\�\���3\�@u\�@>\0_W�\��\0`���!v��\���T\�-�t��|D�\���\�t<�96\��\�\�#\�\�\�>���q\�`\�ߩ\\\rv�Q퍶�L�M�Z��\n�h�\�_>���\�\�\�\Zƶ\�� D��\�\�\�\�{R\�\��\0ǥK��{�GvW�\�޷\�r5�<ܠk\�\�V.�mU\�]̊\�\�\�?$|�\�\�n~\n�\�/�b^^(�B�2�5q�R)w����d[2�\0\\<=��+T<��d7\�	\�\�7�r�x���\�9��\�cu\��J�2\���sA�\\ׯ��O\�Ԕf��MQ\�ԧ\�E\�\�6��\�.=OH�۹<~)�0u\���tiu�2\�\�\�o\�k\�J�\ZD\�I\�n�Z�EOˊ�3G\�ݹ4\�Z؀WY�\�\�gE�Q�^˻\�g�VI\�l�\�U\�Y\�|\0\�:��Z\�f\��Z\�q\�˶{+���jz�R���p��M�J~\�ӈ�\'䙠\�@jT�)K�(虮3�t��&h8}^�8jE\�\�.B$ɸN���%\�\�tJ�.,g�!�-�p\�L3�>�\0\�f�o��|[\�i�\�\n@\��Y��\�ٟ�A=Th\�7y|�\��q}t!z\�-H\�b�c�\�Ωc�7>@�M\�\�۾@| �Ź��L�\�]!q5r��\�����\�\n�[��\�s�D\rm��DZzonW??\���Eԝ\�	S\�\�s��lA;Ŭ#d>%����r�g7J\�v\��\�7ME֨��b\�+m\�F�\�E\�ᨌ\�\�t���f���\0;;C�~�	��\\��3���\�p���Ǉ\��n��\\��:\�y\�\�\��J�\'��o�\0iWL�fq�>\n\�JGMC�\�M��=䁁̡%��\�&Z�Y\nf\\�ٌj\�}�\�e]�@[hLN\���T��������\�ߛ��m\�v�\"!��F���*���\�ė\�\�\�㷊_����\�$�qQ�k�RXM���yL\"�SmE\'�|�\'=�R\�|��Yq3\�E\�tPn��5��wN��\�(�Rc0\�;y�A\�_\'�z�O�=K�\�\�A7r\�WL�\�\�~�6Ƭ��\�\�\���9٧�\�\�[��\0\�~\�N�B�f\�\�\���2W���2\����	�qԐq�u3��\'cô\�i74�\��\�C�\��I.n�4欭dP��z�9L\�U�G�\"q-�*Ҕ��,|��sM�\�W�\0\�\\�\0q�3�\����6�Q�i\�?��V��ǐ\��\�j��M\�\\!�NN\�\�8O	ki��\0\0\�$\�\��ө=E}ϫ6��&/�}�v�s[4\�\\t<�b�o�\�i%ig�\�d�EUX25*\0Di�y�פ��\'8q\�\�s]�>I\�ú�Ů�lO^����\�\'-�|u�\0�M\Z2Jϩ�\��:�k�\Z�533y�\�{����\'9c㓫GCF��2%�\�\�8R�D\�\0|.y�\��j�eGw\�\�tFU�mǗ\�\�\�/�KV�ϛ\�y�Nn��\�,�)Ti�Y�ϐ�\0p�P	\0z\��\\�B�\�=�T�]\�\�j*�Z\r{�0{��\r~˓5iED\�/�\�\\��\�Xn\'N��A�63�T��\Z6\�\�B|0\�+Z\�?d\n9ɱ4�\"kE�W����kz�\0D*\�ȼ�\�6L�\�\�@\�p�k`J�xlf6&gh�\�\�(ׇ+�w�\�ֈ\�r7}\�	6�ȼ�\�j���(�&A��5�}�m�<��\0\� �\�fε\�x�l��<e3$�U.�A\�\�/�J��ܮvN�\�}D4�\�\�\�iT���`\�:��۲��JX���<\�����&��Lr\�T�W�����3\�Y!�Ts�&m�R\�F�nAU�*�\��\Z\�sD\�G!3�N��II�\�Ln\�\�^Gx5!�7Y�+\�x̣\�%�>�t�z\�ў̹>=\��ts��%�N�v����\��\"\�	\�MZ)1x\\�h�\�H�G,���\�\�����i\�\�	\Z��a�\�+Sb��Uۑ�����<H\�ɤ\�.��7��\�~Ο�p\���\��cS�j�x\\�\�t#es\�\\D\�\�\�f幅RVE�h8e,M3I\�[w\��V\�x\�ǿ���\�aqj;ٌ\�\Z?n��t�{q/�\'ȥ\�W\�\0�\�~�J�\�iIٿ��M\�\���*\�Őnw$	\�=9ߙ\\���\'p5U�+h�9#�\��ε*�\�Ģ\�1\�-6�-�\�Æfz[tO`�0y���)u6͝/\�\�˔e\�\�~�1�35\�D�\�\�\�9AJ��\�]�\�\�\�\�R\\2��!\�\�\��>c\�������hǷ\\\�8�v�	�1�\�WèMqop�UjAbO\�=G�\�ɻY����\'ಿ��/\�>��S\'d\�=��,n���K�\0M\�=k\�u�� 8�y�hLl\�\0�GáO�|\�խ\�w�x�\r\';\�}�#\�\��\�� �A_ln�Y\�Om\�碏I8K.\�\�d\�V�x\�/k��Ը��!\�.\��\�h���Sڂ��\�KS���q����Q�\0��\�):��$�*tU\�o맽ju(Դ\'��y}~=Eqj\�3b6��N�X\�\� OÜs�`�8\�\0\�\0u��q�L�\0_N~\�x\����}��|n+\�..\�Gؽ�6�W7.�,#�\�e�\�t�!^����N�Z�\�+�C<?>K\�Ж�X��\�!\Z#U�(\��\r\�gd�R\�b\�9���ͱ>�a\�n���\�6��^�ǆS,l\�\�}\��^\�*y��\�s_S���1Y�n\����bm)�U��{\�\�\�LhVf�M��(\�-�ը\�r\"\Z\�\�fD��.6,\�\�{AO(�`\�a\�/v�z���Gv!\��c_ƛ\�vg�_\��E���\�s샊\�\�}oK@:/���\�oXF\��N�\�w\��/C�t\�W,\�{��u_ۯ�߫�\��\0�ܿ��\�7i�f�\Z1v��\'|LZ��Q�Iq\�\�\�T\��\�Hˠ�o�\�\"\�m�A6\�z�\���!:��J�\�\rڝ<�n\�\r\Z�\'Q�)��3�;ő��\�K\�i�u.�\�<�\�\�E۠���KG�\�3O\r\�\�\�?���\�����\0Uԧ�q�\�%m^���\�:U�G2D\�\�fR�2ݷ\�-7�-by�(�\�d\�&\�\�\�\n\�O\�+�<E\��z*\�\�^�쐡\\���\�B	��jTk$�%\��Tqj\��>�e�:\�k�\\\�EkOj:�<�Q\�,zu�v��lN\�	�����ȿ�8\�k\�\'@S&E����oSG��\�\���K\��\0��x�;�Li\�\�\�4�W�7Gũ�:n.\��Qq\ZYG��\�\��\"@<�>���E\�Ȕӕ��W\�\�>\�́eѶ�\�ꎄb�\�n\��\�T�	9I\��\�^/\0�\��kc��4\�d�V�RS�D\�Xr��;\0O��Źp�{$�E\�A\�D��R{�k�RN\nR}��R�د�\�\�5@\0\�{\���/!F��77���&���I\'\�\��\�׋�H\�FA\�\�S@M0Y���EO\����Jw�#\r2\�D�\�\�j-�}�\�����y\��^\0{��\�:�l,s��F��V��- C\�$�\�\�\�\�*V��\�:rQ�\���$˄}�둤�걖\�=\�\�Ut/\r:�$\�M�Ś5\�U�eI6\�\�\�U\�\�o��cPێ\�F�]S\�ғw��d�b;M�\�\�*�1�M���\0ԑ�\��\�S�\nQ�د\��\��\��\�ϼ˟U̧J�����lҸA\�b\�8 [\�x��s�\�\�ՖZ6V���X��wfk@�\�-���ʕ\Z�\�\�&����x���\'�X�{�=;\��e\�+R�6��ʖ�4\��7�c2\�Loߧ<\�Դ\�=\�ͺ��\��]G�X�:�x����r\�=\�`	S�Qꝕœ�\��҂6�h\�Ed�.}S\�\�0\�;�~��n#�61O���$у�\�O����.\�J�]\��X(�楷��N\�.}\�\��cF\��S�:\�g.\��\�l���	�S\�;#�RT��EIIp�a�?�u�{\�\�o���8E\�(\�V�[{$�\\[\���\��\02��\�\�5ƵyCd\�ս\n\��w\Z�&t�\�G��Ze6\�\�\��9W�X��\���=-|s�Mu�n�I1\n��Ǔ���k��j@#��R�A�{�cI;n\��c�\�zt\��$��T��\�\�U���KjN\�s�\'�������u\�V��?s�\�S\�7�\0��\0���\�\�\�Q\�\�T��\��ŴA�c�t�]\'=�C_Q�\�\�)\�J\�q��\�)NbzrӠ��ے\�Z�7�\�q���\�\��B�h�\�jNfܝw\\\np�\�C�\�3���\�Q\'�t��ZT[\�)v{\Z?��\��t�q}\��V(Y\�H�\0]?��l}�\�{3Z��\0�\0\�g�\"Qe4fq=�\�O�?�\��\02$�Vd)�O\Z\nG����S�a&�\�');
/*!40000 ALTER TABLE `test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testtable`
--

DROP TABLE IF EXISTS `testtable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testtable` (
  `Name` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testtable`
--

LOCK TABLES `testtable` WRITE;
/*!40000 ALTER TABLE `testtable` DISABLE KEYS */;
INSERT INTO `testtable` VALUES ('122\n'),('150\n'),('200\n'),('452\n'),('55\n');
/*!40000 ALTER TABLE `testtable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thresholdvalues`
--

DROP TABLE IF EXISTS `thresholdvalues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `thresholdvalues` (
  `ID` int(11) NOT NULL,
  `VALUE` int(11) NOT NULL,
  `MeasureTypes_ID` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_THRESHOLDVALUES_MeasureTypes1_idx` (`MeasureTypes_ID`),
  CONSTRAINT `fk_THRESHOLDVALUES_MeasureTypes1` FOREIGN KEY (`MeasureTypes_ID`) REFERENCES `measuretypes` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thresholdvalues`
--

LOCK TABLES `thresholdvalues` WRITE;
/*!40000 ALTER TABLE `thresholdvalues` DISABLE KEYS */;
INSERT INTO `thresholdvalues` VALUES (1,140,1),(2,50,2);
/*!40000 ALTER TABLE `thresholdvalues` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `USERID` int(11) NOT NULL,
  `FIRSTNAME` varchar(45) NOT NULL,
  `MIDDLENAME` varchar(45) DEFAULT NULL,
  `LASTNAME` varchar(45) DEFAULT NULL,
  `EMAIL` varchar(45) DEFAULT NULL,
  `PASSWORD` varchar(45) DEFAULT NULL,
  `ROLES_ID` int(11) NOT NULL,
  `CREATEDDATE` datetime DEFAULT NULL,
  `CREATEDBY` int(11) DEFAULT NULL,
  PRIMARY KEY (`USERID`),
  KEY `fk_USERS_USERS1_idx` (`CREATEDBY`),
  KEY `fk_USERS_ROLES1_idx` (`ROLES_ID`),
  CONSTRAINT `fk_USERS_ROLES1` FOREIGN KEY (`ROLES_ID`) REFERENCES `roles` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_USERS_USERS1` FOREIGN KEY (`CREATEDBY`) REFERENCES `users` (`USERID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_mri_map`
--

DROP TABLE IF EXISTS `users_mri_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_mri_map` (
  `ID` int(11) NOT NULL,
  `USERS_USERID` int(11) NOT NULL,
  `MRIList_ID` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_USERS_MRI_MAP_USERS1_idx` (`USERS_USERID`),
  KEY `fk_USERS_MRI_MAP_MRIList1_idx` (`MRIList_ID`),
  CONSTRAINT `fk_USERS_MRI_MAP_MRIList1` FOREIGN KEY (`MRIList_ID`) REFERENCES `mrilist` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_USERS_MRI_MAP_USERS1` FOREIGN KEY (`USERS_USERID`) REFERENCES `users` (`USERID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_mri_map`
--

LOCK TABLES `users_mri_map` WRITE;
/*!40000 ALTER TABLE `users_mri_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_mri_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'mri'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-05-19 17:27:25

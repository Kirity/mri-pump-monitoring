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
INSERT INTO `test` VALUES ('ÿ\Øÿ\à\0JFIF\0\0\0\0\0\0ÿ\Û\0„\0	( \Z%!1!%)+...383-7(-.+\n\n\n\r-%%--------------------------------------------------ÿÀ\0\0·\0ÿ\Ä\0\0\0\0\0\0\0\0\0\0\0\0\0\0ÿ\Ä\0>\0\0\0\0\0!1AQa\"q‘2¡±Á\ÑðBRb\Ò\á#3r‚’²ñCSs¢ÿ\Ä\0\0\0\0\0\0\0\0\0\0\0\0\0ÿ\Ä\04\0\0\0\0\0!1AQa\"q‘¡±ð2Á\Ñ\áBñ#3rRÿ\Ú\0\0\0?\0ø¾!òR\ã€\0\åEr\îN•)*6B\Û†R%2X;4\nF-\å’B\"\éœ\0y\ìQ2\ì\nól#E\Ã+ÀX\ê<ŒDñ\Ä!+‘¢¸º\"|€\ÅKS.-ƒi‚‹”E†hp•%©-\Z¯m\åDŠ\Ú\ÏLŠÅœS\"‚÷ÇŠðZ\äúF\r¹©˜ŒBü+²\Ì}OiV\í¼0ƒ\äI•\Ê\×x„©Þ>{™\å;\Ëj6\Ü7N\ËM­Ô7õ^~½Z•]\æ\î\ÇGÔ\âle7L\Ô~š„§4»öþ\Ëu °\í\îx>W\Æ1Y\ÞNXa3`N¤î´°té¨·x\Ä\âøV&i\Æ@iˆi\'¤\ë7ðZ”S\Âa]uñ$6M´\ÚM¤G’d-\Äñùù\ê\ãiF\\¤—\ÏvwZ\í³¢\è\ÓMµgn\ÍýŸ\ì\ß\Ì\Î\×÷ü„\Ã\â2“b±½½\à?ˆu\Ôz¡­£¥ZN;m/\ßó—f¤j\Ê.è²¦Ý¤Iˆ\ë\"[\ê>Ë‡=\rH\Þ\Ù5F¢®\àÕŠOo%6/ˆMìŽ;\äŽeN/^V¸\ÆÂ¤\î,	\Ç+E j\Â\n„Lj„-ðøp\ÆI\Õ&R¸Ä¬„qÃ E\Z}ÀM±MQK‘rÔ»–/U‰‘`°yQ\\—,°nYª!±c\îd„¨a†\ÊüEŠz\Å\å\0ž‰µ\á5m	rY¬k%ª‘l¤¬¦…Ja.\ÏðÚ•\ê†Ó‹\\—hJÏª\ÔBŒ7O\èSj9g\ÔðxO\ì\Íis\Ú\âE |‰\\N¦U ¬š¿¯\Þ\ßÈŠ\ÕZXÀ<¸’t\éo’\æ\Ö\ÂHª\rÏ’Ê–W“zV(»O‡\ÏI\äL\Æ\ßP·\èg¶¢\ìcœ/U6|\ï‡bž\Ì\ÍiA#\ÄN\ë\ÛÃ£‹7c†\Òih#3±\Ó<´Ë§U£jo)¦v\ã#8š©2*†\É\æñ®a±·.[­2”-.:þ~\Â\ÓI\à0D\É\ï4ˆñ+^)\ÖJ;&Šqw\ÝU1}F8ˆŒ¡\Çr³½Tz–ÒŒºpW—×¡f+\Ó\Ù\Ô\rpqc\Ùqˆ‰¸\0ƒmE\ÂÒ¤\äó\Ã\ëù\×÷÷Šµ•…8­\rLA¸p\ê \îƒ>+…\âšWNj¢\áö\ïýý\ÇÓ–\ån¨\ÈcxH¦°A4\ÒB•EV@ˆJ\Z\Â2\ê™W\rŒªb%’\ïr±Á5Žd R¤ŠCt\ÒXD1\rE€´#l¡Š.H$Ë–\è•a·)±\îº|™\nµ\È\ì\ç¸mHt*˜\È2\å\×	cJLC`”\Ä\0½\n\ïk«ˆS¯‚)MB.O \n\ç\Ð8^…\åa—~ª“q\Ü\ÚÞ’¼õzµ«Jò\ã¢ü\êbœ\å&N›\Ü\ç™\ä\ÎB\Ó\n1òd\ÚWù„‡´\Ío`\Èó^z³{²>4‘bÕ™š=\n\î\'„.ßž+Vžv’B§J\ë\Ù>r\Ü\\÷‡sR\ßx_\\§X\åø>¤Žø$\Ð\É\î\\Óª\à\ÓN›ƒ\é\Ü[\äFm¸S’w‹µ\Ô--zepî—g4CHi?…U\0·|s©–~¦\Ô\Ìl\'.\Ð#Po²7%,\Û=-ü“C4M°´\Óna\ábýf#}-\â´Gÿ\0#\ÛSóûôðUTÀ4·»Sõ\È\Üõ\îü“#F÷\íùù\îû\ìÜ´ \Z\æ4=\Ä5®\Ê\ëNRDGù	t²-«kŒ\Õ\ï\Êý\É|\Ý¾7ƒ4«=‡c-<\Ú}\Óè¸º­?‘Sj\á\åF[‘^Vp\ÏIªŠ%•U\È\"¢1\Ê6\n¤ÁµÀ\ÔP\'`˜\n”Ñ©.\à‘U\"P).\ä«\èª 1v&2‚4¡	”®Ô‰;0\Ê~&Ë§R•À£˜\Ø!KÜ„ipVò‰’ò‹¬–<®Ç¶\é‘Œv‚:»‹³Sg¼\á©\'ô·¬z,Ú½\\h¤­y>\î\ÅÔšŠ58^I\Z\Øñ2|]Ì®LõU\'–\Ì®\å+6–\Í\'ðõIròb¼Ù¶i¸UÖ€~Ë—^i¼m2v\ÈóDx$riµ™K\Ç\ÞØŒðOé‰Ÿ%\Ûð};©?\Ó[ð\r\Úfn¦hˆ.\Ò	\ç˜w£— W»£Cj[^~ Jmò\'\Æp¡®ö¹Cr‚\Éd‘bA˜¬ð[|¨+I\ß\à#s\àq€Y-\0‹–\â\ã»\'.úY&¥\n’ý1\n2V\ãšü…\í\ÍwxG¼\Óú¤\\›ü\ÕÆ¢Û•”U³ƒœf¦b\è\"aö\Ê\æ$\Æñ¼z­°…\Õ\×Ný„\ÉØ¥Ä°‚$ƒ¾\ä\àjUÕƒ¾\è~w[†?B«Ÿ4Ë¤ö¨\ßx_œ&c\Ùo\áü2®\Ý\Ñ\Þ9…8œ3k¾‹\\h†´’Að–üV-ER›T\Û_ž£\Í\ÌQ\\!èŠ…„¦©e¬@Blj y&\ç%·pV1)²\ìu\ÔU)\Ñ_ˆ§DÁÂ–\Æ\è=&H«‡©¢\0\Ä\ÆR&^\à\Ý\ÝW\î\'\Ä%\'€$*)¦\î\"8æ¨™žP%¦\r\Ò=\ÇS& IÓ©V¹*F“‡\Ð\ÄP¦\ÊN$´¶I2\çLf\è\Z¬\èÖ›š¿¿¿»\Ð\ÅZQcÂ±˜ü\ê³\íV2¾o\Ø…·3µH®ö ¨­Ó¹ª -\Z.T»ºhö*®V›IÛ—ª*pö“|\åµÝ£\r\Æ8¨q»\0-:‡w­\È\ì½\ç‚h•(¹\Ë7øXMNnº”¢³œ\éÇ™œþ3£¿<}J¦“\Ýfß‹Gº3³46 ÍšG;N£Kx-1…•½\âœÐ–%¬y5\0\Ë6hu\Î\äI·‡U›URQ^d_\Ï_•¿°\áð\É`ªTkK€y»²\é0DA˜¹\×\Ép#­pªö\Þýqƒ§þ¾£¤§Œð®·?r;ˆmLC@@m\æ÷°5“°¿ª\ìÒ«*\Ê\ÐV\\{¿?0s%<‰@c›€fwh1¨\æ4\ê·Ô¤¯ôü\äJd)\Ó|¤\Ø\í©-?#JJi\Å\Ýz‘µbÛ†‡9\ÄMžmk¹··>\ë­ü%V\ß.~„N\èÃ½°`\íoE\æ*Cd\Ü{;¾H ,“\nŒƒôÍ’™a\Z\Ô•Á U¢\Ð\Å©„8\Ö$¶S+1\ÌZi1l®+HA¨º\è$c»$u,EÑ²¬LµU\Ê\ÂV²\ÏR9\n\çk:J‘VDQ\ÖD‘\0gL±\0=\Z)`Ÿd,dx-¸ns^Ÿ³ngLD\Ûs\ä.³\ê¶ù2\Þì©˜³IŠ\Ä	\ÊM\æH\ç\Õqa§2Q—6\à¨&Ü‘mv)F\ã<3\Zm¢UjnHÓ¥h¾ÿ\0\Ë1±˜\íê°­-I~•s¥\Z\É2«‰q¼\Ípm\ì\åª\îxw„Tu\"\ßLØ§]\Í\Ùðd+bŒ\Ú\ã‘\0…\î¡-‹j\Ë\í‹k•\ï\Ã;º\æ\É:	\ëôZgM\É^.Þ‚³\É*!\Ä<‡HA\×c\Þ\Z\ÖÉ´T£+\Íß·\ç\"\åf¬‘0\×eƒk\ÜIL\Ä\"ûhŠ­\rô¥O¹p›RLRµ<\ÙHyi\ï ô^Vt§NMIsðûYJv\ËušI|¸µ½>¤[TË¶\È\é\Î~Ë¥\áR\ÙxIò¾¦MkS›œWRn¥-0H“1¨©\Û]WrTýž\Þ\ï\ÏÏ™…K i—5\ÙI¶½E¶ë¯Œ!Œ$¤½>ý}Bv±i\ÃZ\â\âG{0ñ˜‹\ë‡™Q\ÒjW÷þ\ß`7t2u$žd•\å\ë´\êÉ®\ï\înXD\Â< \Õ7\Ù,h”€”h ô\æK–J\Í\"6!j\ÑI€T\Ô\ÕkA\Ã\êªe1\í’:–Fžª2,CpI\áð\î$€\ÒKA&\Þ\è\Z“\È[t3œR»dE¾3³µ™N‹\ê\Ö=\ÊõC\"s¼~E;\ÂB\ÔCs]/ö.ä¸·d\ë\ÒK\ì­.kI.qŒ\0\\Í‚ki¹Y\ãó¯oqW£\Ù\\Ii.hm¤\á˜ô€l¤¼B‚vNÿ\09ge1E®y`c[&\\\æ€cX\Ýñ:j)Ý¾\ÈÊ¬%^«d•†D¾à¸·‡dcƒMB\Z]\à\ÝHo\Ð,šºP”7\Í_nm\Òþ¥Mb\å\Ã0\0 2\ã\Z\É\Ù`ÿ\0!¤’\êeuZ˜ZM‹\ì?!.N\â\'\Ý\Ðzmmým?\Ñ\ì{DŒ,/\Å\Ü	\r\äo÷…v<=%\Zi·\Ã}\á:i¬J\ë\ÒÄ®hHI\Õrƒ–\Ä\ìº\Zw{È¹vmbDƒ°\Ø\í¢\éR¼—´e›Kƒ­Â€	\Ë\ÖLÀ\åÿ\0JB”[¼¹\íØ©6•‘\ã €\Øp\æ›xj™v’²»û\Ôñ`›‚fyf>S\'ÂŠq„£\í\Ùûÿ\01m<\Å`\ËbF¢\"¾\Zm%sjh©\Í^)ÅšUI.r úk¬mk[t¯-5”§K\éï½‘\Z\Ìq@6\êrøÀZ}T©\âŠX\Ûó$t\íu!Š\Åw]\'¼l\ß8ŸÎªª\ëÛ \Òy\éò\\\ZV‘QŠi;\nô(Y6ª(x,\åpD‹¸l:	”=H¬ò,W\ZL¢¢¨Z\âDKªDc(±þ\Â\êW¨Á©\0¸\ÎV\Î\î;h|a#Q^£ºL\Øú\àXl;F»\Ú:€\çoP\èC„‰ŸzvWWR¬me?Ÿ\çð\0\Æ0‚E´4\È}G\rÉ’dn\âM‚¥yIg…\ßú@_¸*ÿ\0\Ý\Ö&I±\Îã­´h<‰?\êN„¯\Ê.\åUN&ú\ÌNºt~}TtTa·°M\r9\Î4;ü’|¬\\L–AA{\0{C\Ú„Z\Êö¸½\ÐÇª	®¡q•i–‰`\r\Ö ú%ÓŒÔ°òK´Ehs\"›\Z\æe¬h\"\×\0…mI§y6ŸvË´˜W\ä-†g›\ØÁÔ“²½;\Ê\Æj”[»;G\ç4²’¨¢\î\r$\çª\ÈWÓ¡O¤\â\Ý\ßJ”\Ó+«1\Íik\Îmoú‡‚\ïiâ­º<\Z!\Ê+\ë\ß\Ó-6‘o¶•HË¯À|;u+\ê§Ï’\ßM¥€e-:|d®œ*\ÞVfGR¤\Ð-Î†b\'œ£‹Ç©m \ìÁ~\è\Ô\ÄÀ1{’S•˜6\à\Êm\r\ï9¾ô@Ó—y\ïT1‹›¼­ \\au*\ß.’H&\Æ\ÚDVô+‹­ñZ´\ç*tš¶,þO\Ýý\í…\Òq…J‹=P\ÃqÄ³ÙºyÁ\æ¸\Þt›»gZz*R¶\Ë\0†—E\å³->Dx£S\\³S\Ã\í{<º¦\å:\çòp*˜\nˆp…:„,ZÕ™²ˆ½ª\Ó(\í;*e¤6\Ç%4€b.Ž)•µÚ´Å”…{\Ê\×`M¦\'Ô¡©8\Å\åú\ìQhÏˆƒ.\r\î‹\Ô$\í6h=\\v\\zþ\"œW”®\ß§\ç¡Mö58\Zl˜kCl÷\Ñ\0½\Ä4z4\Ð5¡`\ê&Û»²K\çýý@o©”TcD8º\ÇngÌ• \ÒKwýX¨¼dN­s\Ýsn\ã\Þó\ç\'S\×\îŽO|\ÛxDk 1³9w|I\Ü\Åü…ö\ê	\ÉA –8$0-1ù§En¤\å™{®‹AD>™s\\h÷N¤h‘\ZªR\äli\ïWEuz As¤”S\\±\ÜfS$Nÿ\0¨\Ï\Ê\êS\Ò5)»\Z#Xq\ç0\Æa­õ\\zz¥´ø=,š¼QS„%„´‹­U=¥uÁÎ”dÝ‹¡L\á®u\à^\Ço\nrŒRlÙ¥¾ý©\n×¢\Ð k\Ï\Ã\ä·\Ê0J\ÖW=%\r$9j\à_-\ã<\æ\ßš2œ\'wCTt[n\Þ\áC\Û$s\å¡ò]%Y\Úð_Éš¯‡R“³\Ã++`\Z\â`—\Ñû*\ÛlúºIeƒLf õü²\Ù\Z¨’SÇƒ$¼ž\\Xü%I±ð[—SŠ\Âw0ÿ\0¤›–Z°3\Ã^&s.\ÖØ”\ç\âô\åN÷i«{½P¯ôõ#\'\×úŠ\Æ8·Ù¸e\Ð¸>g\Õg­\â•g«_\ìs$*ž¨Z†À‡4fX\Ö7¹M]`ôz_…X\íž\ÐZ³`¢\ÉÑ¾\0¿x¦\ÆX0k5~\\Zô)J\Ôy³­Q”¡		–ª¹daY0FQ¢D@‹‘¤M\È$‚až\Ë%¦	\ÎÁŸ‰ª)°FcûZH\ã{uu1£M\Éü=X2>«Áû8\Ì3\Z\à\Þ†¹Î“þ·òÚl\ë;÷\Î=qöE¨²Ý­\î\å\ç\ÞóXü\Çò	/B‹L¶;-´¥s-H²¥\Îps\Ì\ßA??ºÙ†’*.\ê\Ì1–owõVý¬\Û\Ï\ÐF­~ùw+xH¼|“\ãf\Ã`°\'ý¡\Å\Æ§Ÿ’~È¨\ä$¬¬>+\Ôh³IÖ‡2—\ZP–d\Ò7P¥;ar3\à¥À>©\"t\0XûñAW[{4¾o“u”Ÿµò/ð€S€\Ð—‰\'Ä›¬5u5*\æo\á\Ó\ät#¢„Vfó\ÞE\Ç?‚Á)nÍŠt\í\08!\í›\0þ\èß¯>¨¼\ßb\Ì\Å*+v\î¦oˆvo.!\Õs=\ä\ÍÏ·º´õ\é\ÒÚ±\îýýL¯M.b\ìy•Ãœ[£€˜ÿ\0´S“p[²º3³\áš\ÉIºu?Rúÿ\0d¢×¸ðTª_\í6¹@2·U.\×Ù¸é‰·4I÷*Ì°öxn—õZ\éÔ¨­fe©(\Æ÷BÂ‹›cež¤\å¸m-­\\bIth4‘­\Ñy«©SŒ­{¾\Ô\Ðs*5\Ä6‰›Oˆ\Ýti4\ÖÞ¿±\ãüB•ª\î\è\ÉðZ\ã$SR_¥\n¥ÿ\0\È7á¯¨s¹\Í#¬x*Œfó#¬µ\ÔiS\ÙI?‰\â¬\ä\r–¨+#^¬ª\Ët„J`“XA˜–\Ê\nˆ?MöY\Ú)¨\ä\È\Ä$\r2ÅŒP	5\Æ\Û\Þ \rJLcvSi+³\èýŒÁ²“Z@\ç\\d¶\Ó\Ôf#\ÊW\Åw9¬\Åÿ\0\ÙÍ†¥Î¤o\ßúú¾\r]zwøù\ç#,t®y\äÐ‚\ÚY§a¨Z)\Ëh©B\æcŒR,t\Þ&>_¹]M<”•º™ü»1>\"\ì¡\Ü\â\ÝDJmvŠ\Ø÷&!L\æf]É“ôZ\Z\Û+ŒŠö‚\à0w“\Î.6\ßT5jôGsEá®£RŸš:­\06\0@e\ÍM§vw8§d6\ÚÀ7.±J\ÚÛ¹\Ñ\êZd˜žT¢\Â\éqš\r\Ìu\Ù.NÂªJ\Ê\ÃtŸ£tƒ	2\\³,£v\Ø.tM\Âfžö¡tQqL\0tTa9†š\é?uº…k{\à\Ï:-MK°ñ¤Éi*MJÇ ƒ\êS×£\n\Ù]\\\Ý	§L“\Æ¬ð­k¡¡U\Í\æT¥\ä\Ï(\Æ@Ä¸Œû¬ó•ò‡B*1´BTh\Ì O>JFKnyQ·°µð\ìªÜµ)\Ò4\Ò\ãL§bR®\Ç\Çš\ÕÒ‹ºy1\ã\r\ìû\ìvzs—“˜\ï\Úö\ìz\èWV•}þÌ•¥Ï£õG\Ö\Æñ(f»\'¢H\ÇbjK‰NHC\Ë;•QS(YAš€‡ˆWr®uµm,ñr$\ÐUm–	RW!s†\Ã\Z~\Ò}\îûA\Ò µ¦<\ÉòiW«cóò\Æy\Ï\ÚH¼\àüHµ\Ív€’\ï\0{­=\È,>!§Œ©9\Û<~ÿ\0±Š¤c¾ù\Ç\Ðú\'µ›\Ï ¼S™Ö§QI&¿p‰\rUJ°†/\Ò\ÔB}9¸» \\0f¸­ #¥¿Ÿ\Åt\èI°eL¥¤\Ò\×l>ýGEºMJ)štº}\Õ/.Yb*\æk@÷GH˜+<¡²Nüž“E=É±÷<Û•¾\ë:\\“J\ì“kw¢|öBã‹‹R¼.‰a\ß\Þt•M{*\á\îV°\æ’g‹©‡5Èt/’Fò¾\\3z¡µ£‚¼´\Ö\×l\Z\èŠ/3\Ê7Dc/?§Š¿\Ôž¶\ßeð¬~¦\ÉÛ’8ú3­Ù‹W\Â\05\×\Í:G\'bo’\Ê#M€4¹\àÀ\Ë\àdÄŸ‚\ÒÛœe\Ïðf¯VÒ‹O\ì\r:…\Ýphu•8\Ü\Ü&&F5óLKbœ¥/j\Ø\îÃ’\ì¢\Ö\Ñ*¤\í,™§J3OwS7\áÒ£œÙH$\rú•Ý¡V.\n\ß.Çž­§”&Ñ•â„´\ÆWü[­Pi™j&Š°’Ê¥\Ë;\n\Ë\"eb	$$\àŒ\"\Ê\È‹d„-–]ðZª·“eþ9n¬!—~ÀTx,x£œ`8Cœ¶‘œHòƒñW(¸\Û\Ô\Í\'›®]˜\'Ü¬:™ý¢\â@E(n–ºóð3\Í\'¹µ\éó6|‰\0\\I\Ü~~j¼ˆi6M\í\ïc&‹U(\Ël¸\\\ZU‘2¹N6=\'tDŸŠ»\rH‡4h»lv${l›\0\ã~p]ZTß•¸-\Õ©G¼\\F¶™NR\ÂG¤\Ó\éö¬u$\Ì+¢&ú\Ûo5N¢½Ç¨F	\íÚŽ\'(¹\Ç\Ïd-F\×a\ÃOuzŒeÌ|\Ï\É+sj\ÑŸH C!­™ü²/)\Û,ñ\Û{¤?ƒ«¢v:ùuH©~ˆ’Q\è•!Ó¯¤ÿ\0\Ú¢¤±`ù‹œ:žP‚\Ê)‚½”\Æñ4r\å\æ“	n¹½\×`q&H’8a\\\Î\Ö«\Ò-0 {ýc%,³~Š²~ÌV$\Èð\Ñ2–%ƒ¢¯{\rR¤\ÓL´‰i±\Ë#§¨”*`É©§\æa•o¢Ù™1´™ŽJ÷·Ð­óQ´mpG\Ô\ZZ\'Á‹dŒ\ï6\Ûdð`jgÀŸ¢ª—\áWs\ÄF‹\Çy­\"m·KW^\Óvb-\äfûCRˆZ˜p?¨‰s|õ> ®Î’ueeðsõE\íUc¹“\âœ$1¢­34ÉsG˜\Û\Åt)j7\ËcY8úš0¦\ïtV´\\\ÊD£E‘…d\Ô£ªŠ%T+L0-e\Ñ~•8Kd.8]3–t\Ì\èC`>Bu:rò\Ü\í\Ë}Qš«Wø~}\É\ã±%\Îq;¾v€?\Ød\ãi\ç¦>(%µ$*\ìV]H$¢w½\í\Ñ\\\"”$\ß==\àT¦\å\Æ.\Ä\Ã\Z5&m\áº\äj´nqs}pr\ëi\æªnX4øn6Æ°I\Æñ\Ë\Íp§¢¨\æ\ì¸:Tu)G<–\â¬-ox<ýOÁfzi&ðn¥ª„ø	[óóôA\Zf­\Éðe\ÐüA\'@÷\èWY7\n)!ún«~\Å\Å\n ß•¼:,r“X=\"Â°cB`\í’\Ò\\²MÁ ¿Mü\Õ:­ò¤\ß\"¸ŒN²›\n­pk¸«\"T°\íh˜ù}\Õ9\ÊNÀN´\ä\ì‘\ÌÀÀŽº«¾\Ö\\q–\è\ÔO×ª\Zªü%~\Zd\ÌÆŸ™ñavV°\Þ\ç¸\Éû%Tš‚Á’½¢°C‰04uEE¹3œ²V\×|ºM¦8Z`¬°:•HÓšo‚y*±ªý†\îðuÔ©\Ë\ÚBñ.`3\ÖÜ¼V˜\ÒM\Ý\r{Zº+\èñ	{Ã„F\â:->D%fþ‡¬jJOl‹\ZM\Ì\ÙI×§š\Å,J\Ì\èÐŒb’‡k›û[\ÎnP\Í]\Û!×œ\êwŠnsc\Üü•Nœ¶\ÙjF[?c?\ÚJ%ô\êº34\Z·M·²\èè¤£8®‡#Z\ïM¤bmœP¢š‰Ã¢\ÞX7R„I–AYG3(ct ”é¢¹e=¤¤\ÊD¨G³¦Ù³!\ÇÄ½\Ó>@.þm ½\Ðsó/™]^©$–\ÜHqøÿ\0UÌ«QoW\î\\^\ÜK¨\n”\ì\ã±1\È\Éõ£Mµ{\á)\É\á.¤\éVƒy;\îtR)¹EöûöV	\Ç\ÙüAÈƒ\È;\ÜDƒñZÞEyr\å\æþ½¾bñw\Ð\ïö§Ca\Ä|…\â~ðøT”RYjÿ\0ŸR\Ý8\Ç)dkÇ0LŽ\Ä~Ò¹:Ú¯l…\é%n>¥\ïY\çhc¾\\º¿ú\Ò÷ž›\Ã\Zt\î\"9\ì¹\Ógc	dvùªK“)\Ô$\æÍ‡ýªNÀÝœ©†[•\Û\à‘\n¡£Q$ü\Çs\à—“x«{|Šj\ìdb\Å\Ù\\³‘\'¢7MLr¤åƒ¸|[‰½ŽûS§°©¨—´±­\Ë\0ú}\ÖR{Œ \î+¼ƒúAü	·PV\êJõ$ü6gB¥=ª\æ9pG‚~S”\ÜuE\n\ë‡À\Ý¥Sž\Éþ—ôb§¶Av¶ž^+£{+¥“µNipQqv1\Õ	kµu‰¼É‹=Šrj\nù26\á6\ßŸr8½®\Êºuðô(j\Æ.;»\Z(\Î2\ã‚\Ø;\Þ:m²apH¨\å\Å<´\\G ŠšRx1µ¹\áˆCóš“a”[Gš\Û\å\ÇcŒ{ªùp‹M\\\Å\ã\Þ\ÏmS\Ùû™\Ü[\Ð0º´”¼¸\ï\æ\Ù<½¬y…[ B‚\äôi–,\ä\ÔQ\ÈP @X\î\r²B\àˆ¹-	,°F©\rˆÕ xÜ| …\é¨%\ä\Çÿ\0•öüf*\Ú+c,$IšZEZP„m~ÿ\0–\Z¢÷\Ä\0r‚o¯\Ø\Í\ÖzÑ”\Z‰P“w’¢ÀH\äÛ›>>Zô\Ô\â§¼ný¹~—÷Yû¾D\Þ@$“ú§§ˆúŽ«¥V–\Én}_\ËÇ£\ê%z	Wqˆ\Üw~%d9mN8k\r|øs\ïp\ÃÏ—ª\ÃR/=G§nMŸe±%\Øw8\És;cF|×“\×\ÓQ¬’\á\çù;=´¤½dm¨f—\0\è‰ñó\Ñp\åf°ua&Æ©¾vør“ºSV¹\\j!y~|’œŸŽ]€\Ôt˜ˆÑ¥dD¬½M¯\Õ22i¤\Ð\"À9h®\Ù76¥&¥1JHtj8€ÀúrG—€¥;õ8\ìh6OŠµIòÅ¨·‘ºX‚™B\ìD\Òlzˆh\Þð‘+±‹\\þ\ÐZ \Ï\Ì&yW³\\&³rˆU$\Ø|=I=\Ê\ìô”#·¸*R$\è\":]ñø-\Út¥s%w²v\â8lµ2¶@€Zi¾‡\ÉJ¶C©F+#4x“²Ã›.m‰\ç°0²J‚¿>\Ïb*{\ß8\ç¹\î\Þ\å1Eq&¬£N/h\Å5µ~\ë\Z`ò›\ë\Ö\ÉÓ¡5£–a“Q¦\å>YŒ\ãi¬\â\ÑO\Íu´\éªi3V6i÷B\ÌyMhH\î…\É²1¸ñ\á\î#\ÝKM„\àWb0Žn¡hRÐº²¦U2\rQ9J„,&\ÈlAjµsxõþ¥z]þM5¯Å¾øh\É_|\æ±\æ\'\Ä‰Bq«xq\ßö\"~Å˜\Ý v\0\Ø%?Q§Œ&\í™5Ž\Ü,ü2g”¤\ã…\ÇÀ±À\á\Ý\È\'™$%re©t\ÜT¹ô\Ï\Ì\ë\éô’«,Ys|/û+ñL´ƒmyt ˆº”«­E5\Ú\Í?Ka|úª\Ñt¤+R¥\æFšù\êµ?ý«q\ÏÇ”%GU&u\'\ã\Ó÷4¨\ß&³°•a\îcuÀ\Î\Zö| ¼÷ŒBñŒ—?\Ê4h\æü\ÉE.\ß3\è˜\n™‹€ƒ.\'\Êl¼\Åh8%s\ÐA½«³0\Ð/\0|O‰X\ÝKðo|k9Xiä©¾\ã[R˜ñD¤\ËR`‹<Dw\r4)MƒrJklc}‘E\"EôÛª(I&v•pF\Âu?u±U\\\ØÒ¥\Ðs†\É/\Ñ&u7õV{¸dq8€\r…\Õ\Â\Ù\n}KL%PXX0²Ô‹Rµ\ÄUNö¹\æ\Ôly)i[z”\ÞÛ¢‹\á\Ø7\Êl\ÚA\Ó\âý4\ÓFý¢\\z >©kLD>Ÿ‚\éQ“ŠfŠ\Ñód„1\ÕK\Ý&\ÃEœ¥ŽFUŒ#OkW­Š\Ë\0ºÿ\0¤\rO+ò\êS¡BUq\\rú|\èi•ždøEö\r¤K\Ìkkù¬”\ä©\Ô\Ç\ZµV\Ë>J\Ì[ZÖ¹\ÏpƒL½³ûœ79‚\ÕWtœm\×?É—QR;6u\à\ÅqL>P	Ô™û­ô\'¹\Ù­U•’\è Â´4c-xmQ)ˆ\Ä\ÍV\n\ãeIq~#nX«#3SAWp\ZÁ¶J¹”\ÝfÀA4s\Ü\î‚a \ãÉ£Sö\êB;\ÔZ\äVp÷CÀ°\Ýo¥Y]¯žÙºO¯\Ý<	\ÔAIn\ì\Ã\Þò?ž«µ8/jË¯òd]\æ\×O?(RªrRN<g\í\ÇÈ–µ†*\Ñ\ÍO$.–\Þð$G+\åµ4¥\ZŠkªüùM%xT \éJ\ê\Îýý3\Ç@u\Ú@>\0_W¹\Öÿ\0`™¥ó!vºó\Ï½¹T\á-©túþ|D‹\Ðý\Ùt<¨96\Ýý\Ê\ß#\Ú\ä¹\áœ>³Áq\Ô`\àß©\\\rv«Qí¶¯LüMžZŒõ\nhó\Æ_>¦£„\Ñ\Ê\à\ZÆ¶\Çô D’\â\Õ\Ô\É{R\É\ìÿ\0Ç¥Kô«{GvWœ\ÃÞ·\Ùr5µ<Ü k\Ç\ÙV.žmU\Ì]ÌŠ\È\î\ï?$|‡\É\ín~\n¸\Â/…b^^(ˆB©25q¿R)w¬Á¹ºd[2¿\0\\<= ®+T<“£d7\é´	\Ý\é7‘r›x‚« \Ö9º‘\Ãcu\ÒòJŠ2\È¦…sA÷\\×¯‰O\ÓÔ”f‘›MQ\ÓÔ§\ßE\Ø\æ€6º\í.=OH–Û¹<~)0u\éùªtiu’2\Õ\Ô\Óo\Ùk\ÞJ…\ZD\æI\änŸZµEOËŠ²3G\ËÝ¹4\ØZØ€WY¢\ä\êgEQ’^Ë»\ìg­VI\ïl¬\âU\ÙY\Ì|\0\Æ:ûœZ\Ûf\ÉõZ\êq\ÙË¶{+ô÷œjz§R«”ºpºöMýJ~\ÖÓˆˆ\'ä™ \â@jT÷)Kª(è™®3†t¹¢&h8}^«8jE\Ë\Ò.B$É¸N¶¤£%\Ì\ÇtJ“.,gû!Š-p\ÉL3õ>ÿ\0\áf¬oŸ¼|[\Éi‚\ê\n@\Ï©Y®¨\ÆÙŸ–A=Th\Î7y|±\É¥q}t!z\Í-H\êbªc³\ÉÎ©c­7>@­M\Å\ÉÛ¾@| ®Å¹€L¤\Û]!q5rŒŽ\Õýõþ¾\Ù\n”[–‰\åsõD\rmù¯DZzonW??\êýøEÔ\Þ	S\á\Ïs²€lA;Å¬#d>%«†žšrøg7J\Üv\ïô\è7MEÖ¨¡ùb\æ¶+m\ïF›\ÏE\çá¨Œ\Õ\ät¥£¥fºù–\0;;C~ð	¿ô\\Ÿ”3·ƒ¯\áp¨¢üÇ‡\Çòn°ù\\™¦:\Ùy\É\î‹\ÏƒJ­\'£„oÿ\0iWL§fqõ>\n\ÔJGMC°\ÕM«©=äÌ¡%À—\Ð&ZÁY\nf\\¦ÙŒj\Ä} \Þe]Ÿ@[hLN\Öû¢Tú‚§ž¢Œ§˜\Þß›§¹m\àvû\"!™µF÷¬*›•˜\ÈÄ—\Ù\Ú\íã·Š_–£À‰\Ú$ñqQkŽRXM‹yL\"§SmE\'•|™\'=’R\ì|ûòYq3\ÏE\êtPn­’5øwN‚¿\Ç(«Rc0\é;y¯A\ä_\'–z©O–=Kö\Ä\ËA7r\ÇWL¦\î\Ò~™6Æ¬ –\æ\í\ßþƒ9Ù§û\Ò\à[šÿ\0\æˆ~\ëNŸB¥f\á±\æ\Ë÷™2W®¯²2\Ý¿À–	®qÔqõu3·¯\'cÃ´\Ôi74²\Ãñ\êCº\ß—I.n‰4æ¬­dPº™z’9L\ãU°Gð•¡\"q-ø*Ò”‚,|“‰sMðœ\ÑWÁ\0\â\\ÿ\0qƒ3‡\îý¬ó6ð•Q‰i\Ü?Á¿V¼ó™Ç\×ó\Éj±£M\Ê\\!‘NN\Ç\Ö8O	ki¶˜\0\0\Ú$\Å\ÊñÓ©=E}Ï«6¥¶&/·}˜v s[4\ê\\t<§b½o…\ëªi%igó\îd¯EUX25*\0Diýyý×¤—ˆ\'8q\×\æs]¬>I\ÑÃº£Å®šlO^ö«©\Ö\'-ò|uÿ\0£M\Z2JÏ©¨\áü:©kš\ZÀ533y°\Ó{•‚¯‹\'9cã“«GCF›¿2%ô\à¶\Ã8R§D\Ñ\0|.y•\ÈójþeGw\ëŸ\ËtFU§mÇ—\Ë\ã\à»/¹KV¹Ï›\Úy‚NnŒ©\Ù,™)Ti§Y¯Ïÿ\0pP	\0z\ïó\\B½\Ë=«T„]\Ë\àj*ñZ\r{Ÿ0{ ù\r~Ë“5iED\Ë/¢\åº\\ðý\ãXn\'N§ºA±63ºTôó†\Z6\Ñ\ÕB|0\Õ+Z\Þ?d\n9É±4ù\"kE‰W´ Ž¯kzÿ\0D*\ÉÈ¼‹\É6L³\è\ì@\Õp‹k`J´xlf6&gh¢\å\Ø(×‡+«w»\ÍÖˆ\år7}\Ö	6£È¼\Ìj£Œ©(ó&A˜5—}ºmñƒ<§ÿ\0\ã ›\ÄfÎµ\íxûl´‰<e3$µU.÷A\à¡\í/¯Jœ€Ü®vN½\à}D4ú\Ð\Ð\èiT«µò¬`\Õ:²Û²œ™JX‡“<\Êöñðø&¤–Lr\ÕT³WÁ…ª›’3\ÝY!—Tsˆ&mR\ÒF›nAU¯*–\Ïž\Z\ÐsD\ÄG!3ôN©µIIö\àLn\Ö\ß^Gx5!—7Yó+\ÆxÌ£\ç%«>ötôz\ÈÑžÌ¹>=\Ýñts¸Ÿ%‡N­vª£œ®\Äñ\"\Ó	\êMZ)1x\\¥h„\îHÁG,”‘£\à\Ä•¬†¢i\é\à	\Z«³aó\Ò+Sb¶–UÛ‘¥¿ø•<H\î·É¤\È.£²7‹\á~ÎŸ´p\ï¾þô…\æücS¾j”x\\û\Ít#es\èœ\\D\è“\á\Úfå¹…RVE‡h8e,M3I\â[î·˜w\î§V\Òx\éÇ¿¨¸»\íaqj;ÙŒ\ì\Z?n „tõ{q/¡\'È¥\ÏW\Ê\0©\Í~½J©\ëiIÙ¿¡«M\å\Û—ø*\ÞÅnw$	\è=9ß™\\š°ó\'p5U+h‡9#…\âò…Îµ*ñ\ÏÄ¢\âœ1\Ó-6ù-ô\ëÃ†fz[tO`ó0y­þ)u6Í/\Ð\ÏË”e\Ã\à~®1•35\ÐD¹\Â\Û\ë·9AJ›¦\Ó]‘\Å\Ô\é¦\ÛR\\2•!\Ò\×\èÁ>c\Çú®³†øûhÇ·\\\á8½v“	1ù\è“WÃ¨MqopúUjAbO\â=G´\ÕÉ»Y¦À™õ\'à²¿¢—/\â>ž»S\'d\Ò=¤©,nšõñKÿ\0M\á¶=k\êu’ø 8ñyhLl\Ñ\0¦GÃ¡Oˆ|\ØÕ­\ïwôxø\r\';\Ì}“#\á\Õ\Ò÷ ˆA_lnýY\ìOm\Úç¢I8K.\ë\Üd\ÔVx\Ý/kŽ¢Ô¸›˜!\Ï.\Å÷\Õh©¡¥SÚ‚·¸\ÍKS¨£‰qóüø«Q•\0–¸\Û):ø$¯*tU\Üoë§½ju(Ô´\'‡ôy}~=Eqj\Ì3b6›õN…X\Þ\Î OÃœs‡`ô8\ã¢\0\ï\0u™±qóLÿ\0_N~\Úx\íÀóµ}‹þ|n+\Ú..\ãGØ½ 6®W7.,#\çe£\Ãt´!^ñú™ªNµZ›\å+ñŸC<?>K\ÓÐ–ûXªŠ\Ï!\Z#U©(\Ç‘\r\Ügd£R\Ãb\äƒ9¤´¹Í±>ƒa\ê±nö®ý\Ã6½¶^òÇ†S,l\Ø\Ï}\íò^\Ä*y•¥\ßs_S££Œ1Y¿n\ÖüøÁbm)ªU’{\î\Ø\ÅLhVf‘M§(\â-”Õ¨\Âr\"\Z\á¸\ÏfD¡”.6,\Ù\á{AO(º`\Éa\è/vz‡™Gv!\àøc_Æ›\çvg”_\ïðE¨ª¨\ÒsìƒŠ\Ü\ì}oK@:/š“»\êoXF\ÏÁN˜\Þw\Ãð/Cªt\ÔW,\Ï{»œu_Û¯ºß«\Þÿ\0§Ü¿’ý\å7i±f“\Z1v“·\'|LZú£Q³Iq\Ç\ç\ÄT\Þ†\ÓHË ‚oö\ä¹\"\Ým©A6\ìŠzõ\äÀ·!:’¶JŽ\Þ\rÚ<¶n\ä\r\Z€\'Qù)´û3;Å‘¥Ž\ÊK\Ùiøu.¥\å<\Ó\ë¥EÛ ¯­”KG—\É3O\r\î\Ì\ë?šƒ’\å¸€úÿ\0UÔ§§q•\Î%m^¦º´\Ù:UƒG2D\ß\ä´fRô2Ý·\Ø-7‚-by§(†\ãd\Ô&\Å\Ñ\á\n\ÚO\Þ+”<E\Ìùz*\Û\Ø^÷ì¡\\‰¶»\èB	Á¶jTk$¨%\àTqj\Öö>Œeôƒ™:\Ìkó\\\ÝEkOj:ô<˜Q\ß,zuŠv­´lN\Ý	ô”œ•“È¿£8\ßk\Ã\'@S&E¾›‚†oSGº¤\Ö\é§ª«K\èÿ\0€µx;—Li\æ\Û\ä¤4•Wú7GÅ©¨:n.\ëôQq\ZYGµ¤\í\Èò\"@<­>‹¦¿E\ÖÈ”Ó•­†W\×\â>\ÝÍeÑ¶‚\ßêŽ„b¤\ån\ßÀ\ÊT¥	9I\ßò\à^/\0®\Å·kc‚ª4\Ûd˜VšRSöD\ÉXr‹¯;\0OÁ–Å¹p·{$ñE\ÙA\ÒDÀýR{¾k›RN\nR}®R¶Ø¯ƒ\Æ\×5@\0\Ú{\Öñù/!F›ó77——ñ&’ƒ§I\'\Í\Û²\Â×‹²H\èFA\Í\ÊS@M0Y‚¸¡EO\Ã”ø°Jw¼#\r2\ÃD¥\É\äj-ñ}š\Æµ‚¿y\Ýú^\0{ü§\Õ:œl,s²œF¹©Vƒ€- C\é$\ã\Ò\Ë\â*V£²\Ü:rQ•\Ùõ„$Ë„}¾ë‘¤ðê±–\é®=\Ã\çUt/\r:Ž$\ÄM…Åš5\ßU£eI6\Ú\ç\ìU\Ò\Êo÷ƒcPÛŽ\ëF§]S\èÒ“wµ¿d¤b;M…\Å\â*´1‘M¦½°\0Ô‘š\æñ\æSõ\nQ†Ø¯\ÎÂ›§\Ùú\í\ÜÏ¼ËŸUÌ§J¢–÷·òlÒ¸A\îb\Õ8 [\Ùx÷™sþ\å\ãÕ–Z6V¨ªûXøžwfk@þ\ê-³›üÊ•\Z·\ã\ì&¶ŽŒ£x¿¸†\'³X{¬=;\Ôþe\Þ+R¥6³©Ê–Ž4\Ö†7c2\åLoß§<\ÉÔ´\Í=\ÌÍº¬–\×Á]G²X·:øxý”¼ôr\Õ=\é`	SœQê•Å“þ\×÷Ò‚6ýh\é©Ed¿.}S\ì\Æ0\è;~—ó§n#§61O²˜’$Ñƒ°\ÏO—ù¹¢.\ÒJÁ]\ÙüX(ùæ¥·ú”N\Ì.}\Ð\à³cF\ÜóSú:\èg.\Äò\çl’•®	šS\×;#þRTŒ“EIIpƒa»?Šu´{\Ô\àoû¹¤8E\Ë(\ËV•[{$±\\[\Æû÷\éÿ\02ŠŽ\Ù\î‹5ÆµyCd\ÕÕ½\n\×öw\Zø&t÷\éGü´Ze6\Ø\Ó\Êù9W³X¼±\ì¹£=-|sõMu‰n•I1\n—Ç“•´ˆk¬ñž”j@#¿®R³Aµ{šcI;n\éÁc…\ì…zt\Èö$“üTöŸ\â\êU•ðKjN\ås»\'¿÷ýô¿u\ãVš?s–\ÏS\ìŽ7ÿ\0€ÿ\0¾—ó§\Ñ\Ô\ÑQ\ç\îT©±\Ú˜Å´A¡cüt§]\'=´C_Q©\ã\â)\ÉJ\áq˜\Æ)NbzrÓ ›™Û’\ÃZ¥7¾\Íq“‹Š\î‹\æöB«h†\ä—jNfÜw\\\np’\ËCð•Œ\Ö3²¸À\ëQ\'ýt¾¯ZT[\ç)v{\Z?ô÷\Òþt›q}\ÂøV(Y\ÔHÿ\0]?£•l}€\Ä{3Z ÿ\0ÿ\0\ægó\"Qe4fq=\ÅOø?þ\éÿ\02$™Vd)öO\Z\nGýô¿S‹a&ÿ\Ù');
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

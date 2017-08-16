CREATE DATABASE  IF NOT EXISTS `exo` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `exo`;
-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: exo
-- ------------------------------------------------------
-- Server version	5.7.17-0ubuntu0.16.04.1

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
-- Table structure for table `EXO-OBJECTS_has_STARS`
--

DROP TABLE IF EXISTS `EXO-OBJECTS_has_STARS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EXO-OBJECTS_has_STARS` (
  `EXO-OBJECTS_ID` int(11) NOT NULL,
  `STARS_ID` int(11) NOT NULL,
  `STARS_Star_Name` char(11) NOT NULL,
  PRIMARY KEY (`EXO-OBJECTS_ID`,`STARS_ID`,`STARS_Star_Name`),
  KEY `fk_EXO-OBJECTS_has_STARS_STARS1_idx` (`STARS_ID`,`STARS_Star_Name`),
  KEY `fk_EXO-OBJECTS_has_STARS_EXO-OBJECTS1_idx` (`EXO-OBJECTS_ID`),
  CONSTRAINT `fk_EXO-OBJECTS_has_STARS_EXO-OBJECTS1` FOREIGN KEY (`EXO-OBJECTS_ID`) REFERENCES `EXO_OBJECTS` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_EXO-OBJECTS_has_STARS_STARS1` FOREIGN KEY (`STARS_ID`) REFERENCES `VSX` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EXO-OBJECTS_has_STARS`
--

LOCK TABLES `EXO-OBJECTS_has_STARS` WRITE;
/*!40000 ALTER TABLE `EXO-OBJECTS_has_STARS` DISABLE KEYS */;
/*!40000 ALTER TABLE `EXO-OBJECTS_has_STARS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EXO_OBJECTS`
--

DROP TABLE IF EXISTS `EXO_OBJECTS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EXO_OBJECTS` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `object_id` varchar(45) NOT NULL COMMENT 'Provided by EOD administrator\n',
  `Type` int(2) NOT NULL COMMENT 'Type of Exo-Object:\n1 = Exoplanet\n2 = Other planetesimal\n3 = TBD',
  `Epoch` decimal(16,9) NOT NULL COMMENT 'The Julian Date/Time of the epoch''s midpoint',
  `Epoch_Time_Standard` char(7) NOT NULL COMMENT 'Valid entries are:\nJD_UTC\nHJD_UTC\nBJD_UTC\nBJD_TDB',
  `Period` decimal(9,6) NOT NULL COMMENT 'In days',
  `Transit_Duration` decimal(7,6) NOT NULL COMMENT 'In days',
  `Orbit_Inclination` decimal(4,2) NOT NULL COMMENT 'In degees',
  `Ephemeris_Source` varchar(45) DEFAULT NULL COMMENT 'Publsihed source of the above exo-object planetary parameters\n',
  `eod_administators_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_EXO_OBJECTS_eod_administators1_idx` (`eod_administators_id`),
  CONSTRAINT `fk_EXO_OBJECTS_eod_administators1` FOREIGN KEY (`eod_administators_id`) REFERENCES `eod_administators` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EXO_OBJECTS`
--

LOCK TABLES `EXO_OBJECTS` WRITE;
/*!40000 ALTER TABLE `EXO_OBJECTS` DISABLE KEYS */;
/*!40000 ALTER TABLE `EXO_OBJECTS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LIMB_DARKENING_COEFFICIENTS`
--

DROP TABLE IF EXISTS `LIMB_DARKENING_COEFFICIENTS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LIMB_DARKENING_COEFFICIENTS` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `LDC_ID` varchar(45) NOT NULL COMMENT 'A unique name for this filter and limb-darkening coefficient combination',
  `Filter` char(5) NOT NULL COMMENT 'User choices for filter are the same ones currently valid for AAVSO''s AID, plus CBB',
  `U1` decimal(10,9) NOT NULL COMMENT 'The linear limb-darkening coefficient for the specified filter and exo-object''s host star',
  `U2` decimal(10,9) NOT NULL COMMENT 'The quadratic limb darkening coefficient for the specified filter and the exo-object''s host star',
  `EXO_OBJECTS_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_LIMB_DARKENING_COEFFICIENTS_EXO_OBJECTS1_idx` (`EXO_OBJECTS_id`),
  CONSTRAINT `fk_LIMB_DARKENING_COEFFICIENTS_EXO_OBJECTS1` FOREIGN KEY (`EXO_OBJECTS_id`) REFERENCES `EXO_OBJECTS` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LIMB_DARKENING_COEFFICIENTS`
--

LOCK TABLES `LIMB_DARKENING_COEFFICIENTS` WRITE;
/*!40000 ALTER TABLE `LIMB_DARKENING_COEFFICIENTS` DISABLE KEYS */;
/*!40000 ALTER TABLE `LIMB_DARKENING_COEFFICIENTS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LINK_EXO_OBJECTS_and_VSX`
--

DROP TABLE IF EXISTS `LINK_EXO_OBJECTS_and_VSX`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LINK_EXO_OBJECTS_and_VSX` (
  `EXO_OBJECTS_id` int(11) NOT NULL,
  `VSX_id` int(11) NOT NULL,
  PRIMARY KEY (`EXO_OBJECTS_id`,`VSX_id`),
  KEY `fk_EXO_OBJECTS_has_VSX_VSX1_idx` (`VSX_id`),
  KEY `fk_EXO_OBJECTS_has_VSX_EXO_OBJECTS1_idx` (`EXO_OBJECTS_id`),
  CONSTRAINT `fk_EXO_OBJECTS_has_VSX_EXO_OBJECTS1` FOREIGN KEY (`EXO_OBJECTS_id`) REFERENCES `EXO_OBJECTS` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_EXO_OBJECTS_has_VSX_VSX1` FOREIGN KEY (`VSX_id`) REFERENCES `VSX` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LINK_EXO_OBJECTS_and_VSX`
--

LOCK TABLES `LINK_EXO_OBJECTS_and_VSX` WRITE;
/*!40000 ALTER TABLE `LINK_EXO_OBJECTS_and_VSX` DISABLE KEYS */;
/*!40000 ALTER TABLE `LINK_EXO_OBJECTS_and_VSX` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LINK_OBSERVATIONS_and_hq_person`
--

DROP TABLE IF EXISTS `LINK_OBSERVATIONS_and_hq_person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LINK_OBSERVATIONS_and_hq_person` (
  `OBSERVATIONS_id` int(11) NOT NULL,
  `hq_person_id` int(11) NOT NULL,
  PRIMARY KEY (`OBSERVATIONS_id`,`hq_person_id`),
  KEY `fk_OBSERVATIONS_has_hq_person_hq_person1_idx` (`hq_person_id`),
  KEY `fk_OBSERVATIONS_has_hq_person_OBSERVATIONS1_idx` (`OBSERVATIONS_id`),
  CONSTRAINT `fk_OBSERVATIONS_has_hq_person_OBSERVATIONS1` FOREIGN KEY (`OBSERVATIONS_id`) REFERENCES `OBSERVATIONS` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_OBSERVATIONS_has_hq_person_hq_person1` FOREIGN KEY (`hq_person_id`) REFERENCES `hq_person` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LINK_OBSERVATIONS_and_hq_person`
--

LOCK TABLES `LINK_OBSERVATIONS_and_hq_person` WRITE;
/*!40000 ALTER TABLE `LINK_OBSERVATIONS_and_hq_person` DISABLE KEYS */;
/*!40000 ALTER TABLE `LINK_OBSERVATIONS_and_hq_person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OBSERVATIONS`
--

DROP TABLE IF EXISTS `OBSERVATIONS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OBSERVATIONS` (
  `id` int(11) NOT NULL,
  `observation_id` varchar(45) DEFAULT NULL COMMENT 'A Primary Observer provided observation name',
  `Begin_Time` datetime NOT NULL COMMENT 'Local time',
  `Meridian_Flip_Flag` tinyint(1) NOT NULL COMMENT 'False if no meridian flip occurred\nTrue if a meridian flip occurred at Meridian_Flip_Time',
  `Meridian_Flip_Time` datetime DEFAULT NULL COMMENT 'Local time',
  `Transit_Time_Standard` char(7) NOT NULL COMMENT 'Time standard of predicted transit times. Valid values are \nJD UTC\nHJD UTC\nBJD UTC\nBJD TDB',
  `Predicted_Ingress` decimal(16,9) NOT NULL COMMENT 'Filename of uploaded .zip file containing bias files',
  `Predicted_Egress` decimal(16,9) NOT NULL,
  `Bias_Files_Zip_Filename` varchar(45) DEFAULT NULL COMMENT 'Filename of uploaded .zip file containing bias files',
  `Dark_Files_Zip_Filename` varchar(45) DEFAULT NULL COMMENT 'Filename of uploaded .zip file containing dark files',
  `Flat_Files_Zip_Filename` varchar(45) DEFAULT NULL COMMENT 'Filename of uploaded .zip file containing flat files',
  `Flat_Dark_Files_Zip_Filename` varchar(45) DEFAULT NULL COMMENT 'Filename of uploaded .zip file containing flat dark files',
  `Results_Depth` decimal(10,9) DEFAULT NULL COMMENT 'Model results of (Rp/R*)**2',
  `Results_a/R*` decimal(11,9) DEFAULT NULL,
  `Results_Tc` decimal(16,9) DEFAULT NULL COMMENT 'Model results of a/R*',
  `Results_Orbital_Incl` decimal(7,6) DEFAULT NULL COMMENT 'Model results of orbital inclination (in degrees)',
  `Results_RMS` decimal(7,6) DEFAULT NULL COMMENT 'Resulting RMS from the transit modeling',
  `Detrend_Airmass` tinyint(1) DEFAULT NULL,
  `Detrend_Meridian_Flip` tinyint(1) DEFAULT NULL,
  `Detrend_Target_Width` tinyint(1) DEFAULT NULL,
  `Target_Sky_Cnts/Pixel` tinyint(1) DEFAULT NULL,
  `Detrend_Target_X(FITS)` tinyint(1) DEFAULT NULL,
  `Detrend_Target_Y(FITS)` tinyint(1) DEFAULT NULL,
  `Detrend_Total_Comp_Star_Cnts` tinyint(1) DEFAULT NULL,
  `Detrend_JD_UTC` tinyint(1) DEFAULT NULL,
  `Detrend_HJD_UTC` tinyint(1) DEFAULT NULL,
  `Detrend_BJD_UTC` tinyint(1) DEFAULT NULL,
  `Detrend_BJD_TDB` tinyint(1) DEFAULT NULL,
  `Detrend_CCD_Temp` tinyint(1) DEFAULT NULL,
  `Notes` mediumtext COMMENT 'User entry of observational notes (e.g., weather conditions, instrumentation issues, etc.)',
  `EXO_OBJECTS_id` int(11) NOT NULL,
  `hq_person_id` int(11) NOT NULL,
  `hq_person_site_site_id` int(11) NOT NULL,
  `hq_person_equipment_equipment_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_OBSERVATIONS_EXO_OBJECTS1_idx` (`EXO_OBJECTS_id`),
  KEY `fk_OBSERVATIONS_hq_person1_idx` (`hq_person_id`),
  KEY `fk_OBSERVATIONS_hq_person_site1_idx` (`hq_person_site_site_id`),
  KEY `fk_OBSERVATIONS_hq_person_equipment1_idx` (`hq_person_equipment_equipment_id`),
  CONSTRAINT `fk_OBSERVATIONS_EXO_OBJECTS1` FOREIGN KEY (`EXO_OBJECTS_id`) REFERENCES `EXO_OBJECTS` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_OBSERVATIONS_hq_person1` FOREIGN KEY (`hq_person_id`) REFERENCES `hq_person` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_OBSERVATIONS_hq_person_equipment1` FOREIGN KEY (`hq_person_equipment_equipment_id`) REFERENCES `hq_person_equipment` (`equipment_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_OBSERVATIONS_hq_person_site1` FOREIGN KEY (`hq_person_site_site_id`) REFERENCES `hq_person_site` (`site_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OBSERVATIONS`
--

LOCK TABLES `OBSERVATIONS` WRITE;
/*!40000 ALTER TABLE `OBSERVATIONS` DISABLE KEYS */;
/*!40000 ALTER TABLE `OBSERVATIONS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OBSERVATION_SEGMENTS`
--

DROP TABLE IF EXISTS `OBSERVATION_SEGMENTS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OBSERVATION_SEGMENTS` (
  `id` int(11) NOT NULL,
  `Segment_Number` int(2) NOT NULL COMMENT 'A user-provided segment number',
  `Begin_Time` datetime NOT NULL COMMENT 'Local time',
  `Binning` char(3) NOT NULL COMMENT 'Valid values are:\n1x1\n2x2\n3x3\n4x4',
  `Pixel_Scale` decimal(4,2) NOT NULL COMMENT 'Pixel scale in arcsec/pixel',
  `Exposure_Time` decimal(5,1) NOT NULL COMMENT 'Exposure time In seconds',
  `Filter_Used` char(5) NOT NULL COMMENT 'User choices for filter are the same ones currently valid for AAVSO''s AID, plus CBB',
  `FWHM` decimal(3,1) NOT NULL COMMENT 'In pixels',
  `Measurements_Zip_Filename` varchar(45) DEFAULT NULL COMMENT 'Filename of the uploaded .zip file containing the Measurements file',
  `OBSERVATIONS_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_OBSERVATION_SEGMENTS_OBSERVATIONS1_idx` (`OBSERVATIONS_id`),
  CONSTRAINT `fk_OBSERVATION_SEGMENTS_OBSERVATIONS1` FOREIGN KEY (`OBSERVATIONS_id`) REFERENCES `OBSERVATIONS` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OBSERVATION_SEGMENTS`
--

LOCK TABLES `OBSERVATION_SEGMENTS` WRITE;
/*!40000 ALTER TABLE `OBSERVATION_SEGMENTS` DISABLE KEYS */;
/*!40000 ALTER TABLE `OBSERVATION_SEGMENTS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TARGET_COMP_STAR`
--

DROP TABLE IF EXISTS `TARGET_COMP_STAR`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TARGET_COMP_STAR` (
  `id` int(11) NOT NULL,
  `Star_Number` int(3) NOT NULL COMMENT 'A user-defined number for this star; each star is an ensemble of stars for a given observation segment must have a unique number',
  `Target_or_Comp` int(2) NOT NULL COMMENT '=1 if this is a target star; >1 otherwise',
  `Aperture_Radius` int(3) NOT NULL COMMENT 'The radius in pixels of the aperture used for this star',
  `Annulus_Inner_Radius` int(3) NOT NULL COMMENT 'The inner radius in pixels of the annulus used for this star',
  `Annulus_Outer_Radius` int(3) NOT NULL COMMENT 'The outer radius in pixels of the annulus used for this star',
  `Star_RA` char(11) DEFAULT NULL COMMENT 'RA coordinates of the target or comp star if there is no link to an AAVSO VSD ',
  `Star_DEC` char(11) DEFAULT NULL COMMENT 'DEC coordinates of the target or comp star if there is no link to an AAVSO VSD',
  `VSD_id` int(11) NOT NULL,
  `OBSERVATION_SEGMENTS_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_TARGET_COMP_STAR_VSD1_idx` (`VSD_id`),
  KEY `fk_TARGET_COMP_STAR_OBSERVATION_SEGMENTS1_idx` (`OBSERVATION_SEGMENTS_id`),
  CONSTRAINT `fk_TARGET_COMP_STAR_OBSERVATION_SEGMENTS1` FOREIGN KEY (`OBSERVATION_SEGMENTS_id`) REFERENCES `OBSERVATION_SEGMENTS` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_TARGET_COMP_STAR_VSD1` FOREIGN KEY (`VSD_id`) REFERENCES `VSD` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TARGET_COMP_STAR`
--

LOCK TABLES `TARGET_COMP_STAR` WRITE;
/*!40000 ALTER TABLE `TARGET_COMP_STAR` DISABLE KEYS */;
/*!40000 ALTER TABLE `TARGET_COMP_STAR` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `VSD`
--

DROP TABLE IF EXISTS `VSD`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `VSD` (
  `id` int(11) NOT NULL,
  `AUID` char(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VSD`
--

LOCK TABLES `VSD` WRITE;
/*!40000 ALTER TABLE `VSD` DISABLE KEYS */;
/*!40000 ALTER TABLE `VSD` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `VSX`
--

DROP TABLE IF EXISTS `VSX`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `VSX` (
  `id` int(11) NOT NULL,
  `AUID` char(11) NOT NULL,
  `Rstar` decimal(5,3) DEFAULT NULL,
  `Teff` int(11) DEFAULT NULL,
  `Fe/H` decimal(4,2) DEFAULT NULL,
  `log(g)` decimal(4,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VSX`
--

LOCK TABLES `VSX` WRITE;
/*!40000 ALTER TABLE `VSX` DISABLE KEYS */;
/*!40000 ALTER TABLE `VSX` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eod_administators`
--

DROP TABLE IF EXISTS `eod_administators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eod_administators` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hq_person_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_eod_administators_hq_person1_idx` (`hq_person_id`),
  CONSTRAINT `fk_eod_administators_hq_person1` FOREIGN KEY (`hq_person_id`) REFERENCES `hq_person` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eod_administators`
--

LOCK TABLES `eod_administators` WRITE;
/*!40000 ALTER TABLE `eod_administators` DISABLE KEYS */;
/*!40000 ALTER TABLE `eod_administators` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exoplanet.exo_data`
--

DROP TABLE IF EXISTS `exoplanet.exo_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exoplanet.exo_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `JD` decimal(13,6) DEFAULT NULL,
  `HJD_UTC` decimal(13,6) DEFAULT NULL,
  `BJD_TDB` decimal(13,6) DEFAULT NULL,
  `differential_magnitude` decimal(8,6) DEFAULT NULL,
  `mag_uncertainty` decimal(8,6) DEFAULT NULL,
  `detrend_1` decimal(15,6) DEFAULT NULL,
  `detrend_2` decimal(15,6) DEFAULT NULL,
  `detrend_3` decimal(15,6) DEFAULT NULL,
  `detrend_4` decimal(15,6) DEFAULT NULL,
  `added_date` decimal(13,6) DEFAULT NULL,
  `exoplanet.exo_observation_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_exoplanet.exo_data_exoplanet.exo_observation1_idx` (`exoplanet.exo_observation_id`),
  CONSTRAINT `fk_exoplanet.exo_data_exoplanet.exo_observation1` FOREIGN KEY (`exoplanet.exo_observation_id`) REFERENCES `exoplanet.exo_observation` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exoplanet.exo_data`
--

LOCK TABLES `exoplanet.exo_data` WRITE;
/*!40000 ALTER TABLE `exoplanet.exo_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `exoplanet.exo_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exoplanet.exo_observation`
--

DROP TABLE IF EXISTS `exoplanet.exo_observation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exoplanet.exo_observation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `AUID` varchar(11) DEFAULT NULL,
  `star_name` char(45) DEFAULT NULL,
  `exoplanet_name` varchar(45) DEFAULT NULL,
  `obscode` char(5) DEFAULT NULL,
  `software` varchar(45) DEFAULT NULL,
  `obstype` int(2) DEFAULT NULL,
  `secondary_stars` varchar(45) DEFAULT NULL,
  `secondary_obscodes` varchar(50) DEFAULT NULL,
  `exposure_time` decimal(5,1) DEFAULT NULL,
  `binning` char(3) DEFAULT NULL,
  `filter` char(5) DEFAULT NULL,
  `reference_star_filename` varchar(45) DEFAULT NULL,
  `notes` mediumtext,
  `detrend_name_1` varchar(45) DEFAULT NULL,
  `detrend_name_2` varchar(45) DEFAULT NULL,
  `detrend_name_3` varchar(45) DEFAULT NULL,
  `detrend_name_4` varchar(45) DEFAULT NULL,
  `priors` varchar(45) DEFAULT NULL,
  `results` varchar(45) DEFAULT NULL,
  `valflag` enum('U','V','T','Y') DEFAULT NULL,
  `group` int(11) DEFAULT NULL,
  `added_date` decimal(13,6) DEFAULT NULL,
  `web_djanjo.hq_person_site_id` int(11) NOT NULL,
  `web-django.hq_person_equipment_id` int(11) NOT NULL,
  `exoplanet.names_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_exoplanet.exo_observation_web_djanjo.hq_person_site1_idx` (`web_djanjo.hq_person_site_id`),
  KEY `fk_exoplanet.exo_observation_web-django.hq_person_equipment_idx` (`web-django.hq_person_equipment_id`),
  KEY `fk_exoplanet.exo_observation_exoplanet_names1_idx` (`exoplanet.names_id`),
  CONSTRAINT `fk_exoplanet.exo_observation_exoplanet_names1` FOREIGN KEY (`exoplanet.names_id`) REFERENCES `exoplanet.names` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_exoplanet.exo_observation_web-django.hq_person_equipment1` FOREIGN KEY (`web-django.hq_person_equipment_id`) REFERENCES `web_django.hq_person_equipment` (`equipment_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_exoplanet.exo_observation_web_djanjo.hq_person_site1` FOREIGN KEY (`web_djanjo.hq_person_site_id`) REFERENCES `web_djanjo.hq_person_site` (`site_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exoplanet.exo_observation`
--

LOCK TABLES `exoplanet.exo_observation` WRITE;
/*!40000 ALTER TABLE `exoplanet.exo_observation` DISABLE KEYS */;
/*!40000 ALTER TABLE `exoplanet.exo_observation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exoplanet.names`
--

DROP TABLE IF EXISTS `exoplanet.names`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exoplanet.names` (
  `id` int(11) NOT NULL,
  `AUID` varchar(11) DEFAULT NULL,
  `alias_1` varchar(45) DEFAULT NULL,
  `alias_2` varchar(45) DEFAULT NULL,
  `alias_3` varchar(45) DEFAULT NULL,
  `alias_4` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exoplanet.names`
--

LOCK TABLES `exoplanet.names` WRITE;
/*!40000 ALTER TABLE `exoplanet.names` DISABLE KEYS */;
/*!40000 ALTER TABLE `exoplanet.names` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exoplanet.secondary_obscode_link`
--

DROP TABLE IF EXISTS `exoplanet.secondary_obscode_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exoplanet.secondary_obscode_link` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `obscode` char(5) DEFAULT NULL,
  `added_date` decimal(13,6) DEFAULT NULL,
  `exoplanet.exo_observation_id` int(11) NOT NULL,
  `web_djanjo.hq_person_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_exoplanet.obscode_link_exoplanet.exo_observation1_idx` (`exoplanet.exo_observation_id`),
  KEY `fk_exoplanet.secondary_obscode_link_web_djanjo.hq_person1_idx` (`web_djanjo.hq_person_id`),
  CONSTRAINT `fk_exoplanet.obscode_link_exoplanet.exo_observation1` FOREIGN KEY (`exoplanet.exo_observation_id`) REFERENCES `exoplanet.exo_observation` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_exoplanet.secondary_obscode_link_web_djanjo.hq_person1` FOREIGN KEY (`web_djanjo.hq_person_id`) REFERENCES `web_djanjo.hq_person` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exoplanet.secondary_obscode_link`
--

LOCK TABLES `exoplanet.secondary_obscode_link` WRITE;
/*!40000 ALTER TABLE `exoplanet.secondary_obscode_link` DISABLE KEYS */;
/*!40000 ALTER TABLE `exoplanet.secondary_obscode_link` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exoplanet.secondary_star_link`
--

DROP TABLE IF EXISTS `exoplanet.secondary_star_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exoplanet.secondary_star_link` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `AUID` varchar(11) DEFAULT NULL,
  `added_date` decimal(13,6) DEFAULT NULL,
  `exoplanet.exo_observation_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_exoplanet.secondary_star_link_exoplanet.exo_observation1_idx` (`exoplanet.exo_observation_id`),
  CONSTRAINT `fk_exoplanet.secondary_star_link_exoplanet.exo_observation1` FOREIGN KEY (`exoplanet.exo_observation_id`) REFERENCES `exoplanet.exo_observation` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exoplanet.secondary_star_link`
--

LOCK TABLES `exoplanet.secondary_star_link` WRITE;
/*!40000 ALTER TABLE `exoplanet.secondary_star_link` DISABLE KEYS */;
/*!40000 ALTER TABLE `exoplanet.secondary_star_link` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hq_person`
--

DROP TABLE IF EXISTS `hq_person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hq_person` (
  `id` int(11) NOT NULL,
  `obscode` char(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hq_person`
--

LOCK TABLES `hq_person` WRITE;
/*!40000 ALTER TABLE `hq_person` DISABLE KEYS */;
/*!40000 ALTER TABLE `hq_person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hq_person_equipment`
--

DROP TABLE IF EXISTS `hq_person_equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hq_person_equipment` (
  `equipment_id` int(11) NOT NULL AUTO_INCREMENT,
  `equipment_name` varchar(45) NOT NULL,
  `telescope` varchar(45) NOT NULL,
  `spectrograph` varchar(45) DEFAULT NULL,
  `rpow` decimal(6,1) DEFAULT NULL,
  `aperture` int(8) NOT NULL,
  `fl` int(8) NOT NULL COMMENT 'Focal Length',
  `imaging_camera` varchar(45) NOT NULL,
  `gain` decimal(5,3) NOT NULL,
  `readout_noise` int(2) NOT NULL,
  `dark_current` decimal(4,3) NOT NULL,
  `linearity` int(7) NOT NULL,
  `x_photosites` int(5) NOT NULL,
  `y_photosites` int(5) NOT NULL,
  `x_photosite_size` decimal(3,1) NOT NULL,
  `y_photosite_size` decimal(3,1) NOT NULL,
  `obsolete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1=record obsolete\n0-OK',
  `hq_person_id` int(11) NOT NULL,
  PRIMARY KEY (`equipment_id`),
  KEY `fk_hq_person_equipment_hq_person1_idx` (`hq_person_id`),
  CONSTRAINT `fk_hq_person_equipment_hq_person1` FOREIGN KEY (`hq_person_id`) REFERENCES `hq_person` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hq_person_equipment`
--

LOCK TABLES `hq_person_equipment` WRITE;
/*!40000 ALTER TABLE `hq_person_equipment` DISABLE KEYS */;
/*!40000 ALTER TABLE `hq_person_equipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hq_person_site`
--

DROP TABLE IF EXISTS `hq_person_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hq_person_site` (
  `site_id` int(11) NOT NULL AUTO_INCREMENT,
  `sitename` varchar(45) NOT NULL,
  `sitelat` double NOT NULL,
  `sitelong` double NOT NULL,
  `sitealt` int(6) NOT NULL,
  `obsolete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1=record obsolete\n0=OK',
  `hq_person_id` int(11) NOT NULL,
  PRIMARY KEY (`site_id`),
  KEY `fk_hq_person_site_hq_person1_idx` (`hq_person_id`),
  CONSTRAINT `fk_hq_person_site_hq_person1` FOREIGN KEY (`hq_person_id`) REFERENCES `hq_person` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hq_person_site`
--

LOCK TABLES `hq_person_site` WRITE;
/*!40000 ALTER TABLE `hq_person_site` DISABLE KEYS */;
/*!40000 ALTER TABLE `hq_person_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `web_django.hq_person_equipment`
--

DROP TABLE IF EXISTS `web_django.hq_person_equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `web_django.hq_person_equipment` (
  `equipment_id` int(11) NOT NULL AUTO_INCREMENT,
  `equipment_name` varchar(45) DEFAULT NULL,
  `telescope` varchar(45) DEFAULT NULL,
  `spectrograph` varchar(45) DEFAULT NULL,
  `rpow` decimal(6,1) DEFAULT NULL,
  `aperture` int(8) DEFAULT NULL,
  `focal_length` int(8) DEFAULT NULL,
  `imaging_camera` varchar(45) DEFAULT NULL,
  `gain` decimal(5,3) DEFAULT NULL,
  `readout_noise` int(2) DEFAULT NULL,
  `dark_current` decimal(4,3) DEFAULT NULL,
  `linearity` int(7) DEFAULT NULL,
  `x_photosites` int(5) DEFAULT NULL,
  `y_photosites` int(5) DEFAULT NULL,
  `x_photosite_size` decimal(3,1) DEFAULT NULL,
  `y_photosite_size` decimal(3,1) DEFAULT NULL,
  `obsolete` tinyint(1) DEFAULT NULL,
  `added_date` datetime DEFAULT NULL,
  `web_djanjo.hq_person_id` int(11) NOT NULL,
  PRIMARY KEY (`equipment_id`),
  KEY `fk_web_django.hq_person_equipment_web_djanjo.hq_person1_idx` (`web_djanjo.hq_person_id`),
  CONSTRAINT `fk_web_django.hq_person_equipment_web_djanjo.hq_person1` FOREIGN KEY (`web_djanjo.hq_person_id`) REFERENCES `web_djanjo.hq_person` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `web_django.hq_person_equipment`
--

LOCK TABLES `web_django.hq_person_equipment` WRITE;
/*!40000 ALTER TABLE `web_django.hq_person_equipment` DISABLE KEYS */;
/*!40000 ALTER TABLE `web_django.hq_person_equipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `web_djanjo.hq_person`
--

DROP TABLE IF EXISTS `web_djanjo.hq_person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `web_djanjo.hq_person` (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `web_djanjo.hq_person`
--

LOCK TABLES `web_djanjo.hq_person` WRITE;
/*!40000 ALTER TABLE `web_djanjo.hq_person` DISABLE KEYS */;
/*!40000 ALTER TABLE `web_djanjo.hq_person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `web_djanjo.hq_person_site`
--

DROP TABLE IF EXISTS `web_djanjo.hq_person_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `web_djanjo.hq_person_site` (
  `site_id` int(11) NOT NULL,
  `sitename` varchar(45) DEFAULT NULL,
  `sitelat` double DEFAULT NULL,
  `sitelong` double DEFAULT NULL,
  `sitealt` int(6) DEFAULT NULL,
  `obsolete` tinyint(1) DEFAULT NULL,
  `added_date` datetime DEFAULT NULL,
  `web_djanjo.hq_person_id` int(11) NOT NULL,
  PRIMARY KEY (`site_id`),
  KEY `fk_web_djanjo.hq_person_site_web_djanjo.hq_person1_idx` (`web_djanjo.hq_person_id`),
  CONSTRAINT `fk_web_djanjo.hq_person_site_web_djanjo.hq_person1` FOREIGN KEY (`web_djanjo.hq_person_id`) REFERENCES `web_djanjo.hq_person` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `web_djanjo.hq_person_site`
--

LOCK TABLES `web_djanjo.hq_person_site` WRITE;
/*!40000 ALTER TABLE `web_djanjo.hq_person_site` DISABLE KEYS */;
/*!40000 ALTER TABLE `web_djanjo.hq_person_site` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-03-13  0:55:58

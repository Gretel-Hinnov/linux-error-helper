-- MariaDB dump 10.19  Distrib 10.11.14-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: error_helper
-- ------------------------------------------------------
-- Server version	10.11.14-MariaDB-0ubuntu0.24.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `errors`
--

DROP TABLE IF EXISTS `errors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `errors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `veateade` varchar(500) NOT NULL,
  `kategooria` varchar(255) DEFAULT NULL,
  `ohtlikkus` enum('madal','keskmine','kõrge','kriitiline') DEFAULT 'keskmine',
  `selgitus` text DEFAULT NULL,
  `parandus` text NOT NULL,
  `alternatiivne_parandus` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `errors`
--

LOCK TABLES `errors` WRITE;
/*!40000 ALTER TABLE `errors` DISABLE KEYS */;
INSERT INTO `errors` VALUES
(1,'no space left on device','kettaruum','kriitiline','Kettaruum lõppes täielikult','sudo apt autoremove -y',NULL),
(2,'Address already in use','võrk','kõrge','Port 80 on juba kasutusel','sudo lsof -i :8080 && sudo fuser -k 8080/tcp',NULL),
(3,'Permission denied','õigused','madal','Failiõigused puuduvad','sudo chmod 755 fail.txt',NULL),
(4,'failed to start','teenused','keskmine','Süsteemiteenus ei käivitu','sudo systemctl restart nginx',NULL),
(5,'Connection refused','võrk','kõrge','SSH port 22 blokeeritud','sudo ufw allow 22',NULL),
(6,'No such file or directory','fail','madal','Faili nimi on valesti kirjutatud või fail puudub','ls -la || find . -name \"failinimi\"',NULL),
(7,'Command not found','käsk','madal','Programm pole PATH-is või pole installitud','which käsk || sudo apt install paket',NULL),
(8,'NO_PUBKEY','käsk','kriitiline','APT-pakendihaldur ei saa pakettide terviklikkust kontrollida, kuna süsteemis puudub konkreetne avalik GPG-võti, mis on vajalik nende autentimiseks','sudo mkdir -pm755 /etc/apt/keyrings','sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key'),
(9,'Argument list too long','käsk','madal','käsureale kirjutatud käskude kogu suurus ületab süsteemi piiri.','ulimit -s 65536','NULL'),
(10,'ERROR 1698 (28000): Access denied for user \'root\'@\'localhost\'','õigused','madal','MySQL-i \"root\" konto on konfigureeritud kasutama parooli asemel autentimiseks auth_socket või unix_socket plugini','sudo mysql',NULL),
(11,'ERROR 1045 (28000): Access denied for user \'root\'@\'localhost\' (using password: YES)','õigused','keskmine','Sisestatud kasutajanimi või parool on vale','mysql -u root -p','Vaheta autentimismeetod auth_socketist paroolile: käivita käsk `ALTER USER \'root\'@\'localhost\' IDENTIFIED WITH mysql_native_password BY \'parool\';`'),
(12,'Address not available','võrk','madal','Kontrolli IP-aadressi','Kasuta aadressi 0.0.0.0','veendu, et aadress on seotud võrguadapteriga'),
(13,'Address family not supported.','võrk','madal','programm üritab kasutada võrguühendust (nt IPv6), mida süsteem ei toeta.','Kontrolli, et failis `/etc/hosts` oleks `localhost` seotud ainult IPv4 aadressiga `127.0.0.1`.   ','Luba IPv6 või kasuta IPv4'),
(14,'Connection already in progress.','võrk','madal','programm proovib luua uut võrguühendust, aga eelmine ühendus on kasutusel',' Oota, kuni rakendus eelmise ühenduse katkestab ','NULL'),
(15,'Bad file descriptor','süsteem','keskmine','programm proovib kasutada soketi (või faili) failideskriptorit, mis on juba suletud, vigane või mille väärtus on muutunud','int fd = open(\"output\", O_CREAT|O_WRONLY, 0600);',' Kasuta strace-i, et jälgida, millal ja kus failideskriptor suleti. '),
(16,'Bad message','süsteem','keskmine','faili ei saa avada, sest andmed on kaduma läinud või failisüsteemiga on mingi probleem','sudo fsck -p /dev/sdXn','NULL'),
(17,'Device or resource busy','süsteem','madal',' kernel ei saa toimingut lõpule viia, kuna ressurss või teenus on kasutuses','sudo umount -l /path/to/mount','NULL'),
(18,'No child processes','süsteem','keskmine','kasutajaprotsessi piir on ületatud või muude protsesside arv taustal on liiga suur, takistades uute protsesside loomist','suurendada lubatud maksimaalseid protsesse redigeerides faili /etc/security/limits.conf','NULL'),
(19,'Connection aborted','võrk','madal','tarkvara sulges kliendi või serveri poolel ootamatult võrguühenduse','sudo firewall-cmd --list-all','sudo firewall-cmd --permanent --add-service=ssh'),
(20,'Connection aborted','teenused','madal','SSH-teenus ei tööta, kuulab valet porti või seda blokeerib tulemüür','Kontrollige, kas teenus töötab käsuga systemctl status [teenus]','sudo ufw allow [teenus]'),
(21,'Connection refused','teenused','madal','teenus ei tööta, kuulab valet porti või seda blokeerib tulemüür','kontrolli, kas teenus töötab käsuga systemctl status [teenus]','sudo ufw allow [teenus]'),
(22,'Connection reset by peer','teenused','madal','TCP-voog on kaugsüsteemi poolt suletud, mis sunnib süsteemil ühenduse katkestada','sudo systemctl restart [teenus] ','taaskäivita võrgu haldur käsuga sudo systemctl restart NetworkManager.service');
/*!40000 ALTER TABLE `errors` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-01 15:59:33

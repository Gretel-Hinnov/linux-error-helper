/*M!999999\- enable the sandbox mode */ 
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
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `errors`
--

LOCK TABLES `errors` WRITE;
/*!40000 ALTER TABLE `errors` DISABLE KEYS */;
INSERT INTO `errors` VALUES
(1,'No space left on device','kettaruum','kriitiline','Kettaruum lõppes täielikult','sudo apt autoremove -y',NULL),
(2,'Address already in use','võrk','kõrge','Port 80 on juba kasutusel','sudo lsof -i :8080 && sudo fuser -k 8080/tcp',NULL),
(3,'Permission denied','õigused','madal','Failiõigused puuduvad','sudo chmod 755 fail.txt',NULL),
(4,'Failed to start','teenused','keskmine','Süsteemiteenus ei käivitu','sudo systemctl restart nginx',NULL),
(5,'Connection refused','võrk','kõrge','SSH port 22 blokeeritud','sudo ufw allow 22',NULL),
(6,'No such file or directory','fail','madal','Faili nimi on valesti kirjutatud või fail puudub','ls -la || find . -name \"failinimi\"',NULL),
(7,'Command not found','käsk','madal','Programm pole PATH-is või pole installitud','which käsk || sudo apt install paket',NULL),
(8,'NO_PUBKEY','käsk','kriitiline','APT-pakendihaldur ei saa pakettide terviklikkust kontrollida, kuna süsteemis puudub konkreetne avalik GPG-võti, mis on vajalik nende autentimiseks','sudo mkdir -pm755 /etc/apt/keyrings','sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key'),
(9,'Argument list too long','käsk','madal','käsureale kirjutatud käskude kogu suurus ületab süsteemi piiri.','ulimit -s 65536','NULL'),
(10,'ERROR 1698 (28000): Access denied for user \'root\'@\'localhost\'','õigused','madal','MySQL-i \"root\" konto on konfigureeritud kasutama parooli asemel autentimiseks auth_socket või unix_socket plugini','sudo mysql',NULL),
(11,'ERROR 1045 (28000): Access denied for user \'root\'@\'localhost\' (using password: YES)','õigused','keskmine','Sisestatud kasutajanimi või parool on vale','mysql -u root -p','Vaheta autentimismeetod auth_socketist paroolile: käivita käsk `ALTER USER \'root\'@\'localhost\' IDENTIFIED WITH mysql_native_password BY \'parool\';`'),
(12,'Address not available','võrk','madal','Kontrolli IP-aadressi','Kasuta aadressi 0.0.0.0','veendu, et aadress on seotud võrguadapteriga'),
(13,'Address family not supported','võrk','madal','programm üritab kasutada võrguühendust (nt IPv6), mida süsteem ei toeta.','Kontrolli, et failis `/etc/hosts` oleks `localhost` seotud ainult IPv4 aadressiga `127.0.0.1`.   ','Luba IPv6 või kasuta IPv4'),
(14,'Connection already in progress','võrk','madal','programm proovib luua uut võrguühendust, aga eelmine ühendus on kasutusel',' Oota, kuni rakendus eelmise ühenduse katkestab ','NULL'),
(15,'Bad file descriptor','süsteem','keskmine','programm proovib kasutada soketi (või faili) failideskriptorit, mis on juba suletud, vigane või mille väärtus on muutunud','int fd = open(\"output\", O_CREAT|O_WRONLY, 0600);',' Kasuta strace-i, et jälgida, millal ja kus failideskriptor suleti. '),
(16,'Bad message','süsteem','keskmine','faili ei saa avada, sest andmed on kaduma läinud või failisüsteemiga on mingi probleem','sudo fsck -p /dev/sdXn','NULL'),
(17,'Device or resource busy','süsteem','madal',' kernel ei saa toimingut lõpule viia, kuna ressurss või teenus on kasutuses','sudo umount -l /path/to/mount','NULL'),
(18,'No child processes','süsteem','keskmine','kasutajaprotsessi piir on ületatud või muude protsesside arv taustal on liiga suur, takistades uute protsesside loomist','suurendada lubatud maksimaalseid protsesse redigeerides faili /etc/security/limits.conf','NULL'),
(19,'Connection aborted','võrk','madal','tarkvara sulges kliendi või serveri poolel ootamatult võrguühenduse','sudo firewall-cmd --list-all','sudo firewall-cmd --permanent --add-service=ssh'),
(20,'Connection reset by peer','teenused','madal','TCP-voog on kaugsüsteemi poolt suletud, mis sunnib süsteemil ühenduse katkestada','sudo systemctl restart [teenus] ','taaskäivita võrgu haldur käsuga sudo systemctl restart NetworkManager.service'),
(21,'Cannot allocate memory','süsteem','kriitiline','Programm ei saanud süsteemilt piisavalt mälu.','Kontrolli mälu kasutust: free -h','Lisa või suurenda swap-ala'),
(22,'Exec format error','käsk','madal','Fail ei ole käivitatav programm või on vale arhitektuuriga.','Kontrolli faili tüüpi käsuga: file binary',NULL),
(23,'Invalid argument','käsk','madal','Programm sai argumendi, mida ei osata töödelda.','Kontrolli käsu süntaksit ja dokumentatsiooni (man <käsk>)',NULL),
(24,'Not a directory','fail','madal','Failitee osas eeldati kataloogi, kuid tegelikult on see fail.','Kontrolli teed käsuga ls -l <tee>',NULL),
(25,'Is a directory','fail','madal','Programm üritab käsitleda kataloogi nagu faili.','Kasuta faili asemel korrektset failiteed',NULL),
(26,'Directory not empty','fail','madal','Kataloogi ei saa kustutada, sest see sisaldab faile.','Kustuta kataloogi sisu enne eemaldamist','Kasuta rekursiivset kustutamist: rm -r <kataloog>'),
(27,'Text file busy','süsteem','keskmine','Käivitatavat faili kasutatakse teise protsessi poolt.','Sulge või lõpeta protsess, mis faili kasutab (lsof)',NULL),
(28,'Resource temporarily unavailable','süsteem','madal','Süsteemi ressurss (nt CPU, fail või lukustus) pole hetkel saadaval.','Oota ja proovi toimingut uuesti',NULL),
(29,'Connection refused','võrk','keskmine','Sihtteenus ei tööta või ei kuula antud pordil.','Kontrolli teenuse olekut: systemctl status <teenus>','Kontrolli tulemüüri reegleid'),
(30,'Network is unreachable','võrk','keskmine','Süsteem ei leia teed sihtvõrku.','Kontrolli marsruute käsuga ip route',NULL),
(31,'No such device','süsteem','keskmine','Tuvastatud seadet ei eksisteeri või pole süsteemi küljes.','Kontrolli seadmeid käsuga lsblk või dmesg',NULL),
(32,'Inappropriate ioctl for device','süsteem','madal','Käsk või programm üritab kasutada mitte‑sobivat seadet.','Veendu, et kasutad käsku õige seadme või faili peal',NULL),
(33,'File name too long','fail','madal','Faili nimi ületab failisüsteemi lubatud pikkuse.','Lühenda faili nime või kataloogistruktuuri',NULL),
(34,'Too many open files','süsteem','keskmine','Protsess on avanud rohkem faile kui lubatud.','Kontrolli limiite käsuga ulimit -n','Suurenda piiranguid failis /etc/security/limits.conf'),
(35,'Broken pipe','võrk','madal','Protsess kirjutas torusse või soketisse, mille teine ots on suletud.','Kontrolli torude ja võrguühenduste elutsüklit',NULL),
(36,'Connection timed out','võrk','keskmine','Võrguühendus ei saanud määratud aja jooksul vastust.','Kontrolli võrguühendust ja sihtserveri olekut',NULL),
(37,'Operation now in progress','võrk','madal','Mitteblokeeriv ühendus on loodud, kuid pole veel valmis.','Oota, kuni ühendus lõpetab loomise',NULL),
(38,'Host is unreachable','võrk','keskmine','Sihtmasin ei ole võrgus kättesaadav.','Kontrolli võrguühendust ja marsruutimist',NULL),
(39,'Protocol not supported','võrk','madal','Programm üritab kasutada protokolli, mida kernel ei toeta.','Kontrolli protokolli tuge ja kernelimooduleid',NULL),
(40,'Function not implemented','süsteem','madal','Kernel või süsteemikõne ei toeta nõutud funktsionaalsust.','Kasuta alternatiivset funktsiooni või uuemat kernelit',NULL),
(41,'Numerical result out of range','käsk','madal','Arvutus andis tulemuse, mis ületab lubatud vahemiku.','Kontrolli sisendandmeid ja andmetüüpe',NULL),
(42,'No such process','süsteem','madal','Antud PID‑ga protsessi ei eksisteeri või see on juba lõppenud.','Kontrolli protsesse käsuga ps aux',NULL),
(43,'Operation not permitted','õigused','keskmine','Operatsioon on keelatud ka siis, kui fail või ressurss eksisteerib.','Käivita käsk administraatori õigustes (sudo)',NULL),
(44,'Interrupted system call','süsteem','madal','Süsteemikõne katkestati signaali (nt SIGINT või SIGTERM) tõttu.','Korda toimingut',NULL),
(45,'File exists','fail','madal','Faili loomine ebaõnnestus, sest samanimeline fail on juba olemas.','Kasuta teist failinime või eemalda olemasolev',NULL),
(46,'Cross-device link','fail','madal','Faili ei saa liigutada eri failisüsteemide vahel hard‑linkiga.','Kasuta kopeerimist ja seejärel kustutamist',NULL),
(47,'Read-only file system','fail','kõrge','Failisüsteem on ühendatud ainult lugemiseks.','Kontrolli ühenduse olekut käsuga mount','Ühenda failisüsteem uuesti kirjutatavaks'),
(48,'Too many levels of symbolic links','fail','madal','Sümbollingid viitavad üksteisele tsükliliselt.','Kontrolli ja paranda sümbollingid käsuga ls -l',NULL),
(49,'Bad address','süsteem','keskmine','Programm proovis kasutada vigast või lubamatut mäluaadressi.','Kontrolli programmi sisendeid ja mälukasutust',NULL),
(50,'Too many open files in system','süsteem','keskmine','Süsteemi globaalne avatud failide piir on ületatud.','Kontrolli ja kohanda väärtust /proc/sys/fs/file-max',NULL),
(51,'Network is down','võrk','kõrge','Võrguliides või kogu võrk ei ole töökorras.','Kontrolli võrguühendust ja liideste olekut käsuga ip link',NULL),
(52,'Network dropped connection on reset','võrk','keskmine','Võrk katkestas ühenduse reseti tõttu.','Kontrolli võrgu stabiilsust ja vahepealseid seadmeid',NULL),
(53,'No buffer space available','võrk','keskmine','Süsteemil ei ole piisavalt võrgu puhvrit uute pakettide jaoks.','Kontrolli avatud ühenduste arvu','Suurenda võrgupuhvreid (net.core.rmem_max / wmem_max)'),
(54,'Operation already in progress','võrk','madal','Sama võrguoperatsioon on juba aktiivne.','Väldi mitu korda sama ühenduse käivitamist',NULL),
(55,'Transport endpoint is already connected','võrk','madal','Soketil on juba aktiivne ühendus.','Ära ühenda soketit uuesti enne katkestamist',NULL),
(56,'Transport endpoint is not connected','võrk','madal','Toimingut üritati soketiga, millel pole aktiivset ühendust.','Loo ühendus enne andmete saatmist või vastuvõttu',NULL),
(57,'Destination address required','võrk','madal','Saatmisel puudub sihtaadress.','Määra sihtaadress enne pakettide saatmist',NULL),
(58,'Message too long','võrk','madal','Saadetav võrgusõnum ületab lubatud maksimaalse suuruse.','Vähenda sõnumi suurust või kasuta fragmentatsiooni',NULL),
(59,'Protocol not available','võrk','madal','Nõutud võrguprotokoll ei ole süsteemis saadaval.','Kontrolli kerneli tuge ja laaditud mooduleid',NULL),
(60,'Host is down','võrk','keskmine','Sihtmasin on küll tuvastatav, kuid ei vasta.','Kontrolli sihtmasina olekut ja võrguühendust',NULL),
(61,'Cannot send after transport endpoint shutdown','võrk','madal','Andmeid üritati saata pärast soketi sulgemist.','Ära saada andmeid pärast ühenduse sulgemist',NULL),
(62,'Socket operation on non-socket','võrk','madal','Operatsiooni üritati teha failil, mis ei ole soket.','Veendu, et kasutatav failikirjeldus on soket',NULL),
(63,'Protocol wrong type for socket','võrk','madal','Soket loodi vale protokolliga.','Kasuta soketi loomisel korrektset protokolli ja tüüpi',NULL),
(64,'Protocol family not supported','võrk','madal','Süsteem ei toeta määratud protokolliperekonda.','Kasuta toetatud protokolliperekonda (nt AF_INET)',NULL),
(65,'Operation canceled','süsteem','madal','Operatsioon katkestati enne selle lõpetamist (kasutaja, süsteemi või teise protsessi poolt).','Käivita operatsioon uuesti ja kontrolli, mis selle katkestas',NULL),
(66,'Resource deadlock avoided','süsteem','keskmine','Süsteem vältis deadlock’i olukorda protsesside vahel.','Vaata lukustusloogika üle või muuda käskude järjekorda',NULL),
(67,'File too large','fail','madal','Fail ületab failisüsteemi lubatud maksimaalse suuruse.','Kasuta teist failisüsteemi või jaga fail väiksemateks osadeks',NULL),
(68,'Disk quota exceeded','kettaruum','keskmine','Kasutaja või grupp on ületanud talle määratud kettakvoodi.','Vabasta kettaruumi või suurenda kasutaja kvooti',NULL),
(69,'Too many links','fail','madal','Failil on liiga palju hard‑linke.','Eemalda mittevajalikud hard‑lingid',NULL),
(70,'No route to host','võrk','keskmine','Süsteem ei leia marsruuti sihtmasinani.','Kontrolli marsruutimist ja tulemüüri reegleid käsuga ip route',NULL);
/*!40000 ALTER TABLE `errors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `errors_backup`
--

DROP TABLE IF EXISTS `errors_backup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `errors_backup` (
  `id` int(11) NOT NULL DEFAULT 0,
  `veateade` varchar(500) NOT NULL,
  `kategooria` varchar(255) DEFAULT NULL,
  `ohtlikkus` enum('madal','keskmine','kõrge','kriitiline') DEFAULT 'keskmine',
  `selgitus` text DEFAULT NULL,
  `parandus` text NOT NULL,
  `alternatiivne_parandus` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `errors_backup`
--

LOCK TABLES `errors_backup` WRITE;
/*!40000 ALTER TABLE `errors_backup` DISABLE KEYS */;
INSERT INTO `errors_backup` VALUES
(1,'No space left on device','kettaruum','kriitiline','Kettaruum lõppes täielikult','sudo apt autoremove -y',NULL),
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
(13,'Address family not supported','võrk','madal','programm üritab kasutada võrguühendust (nt IPv6), mida süsteem ei toeta.','Kontrolli, et failis `/etc/hosts` oleks `localhost` seotud ainult IPv4 aadressiga `127.0.0.1`.   ','Luba IPv6 või kasuta IPv4'),
(14,'Connection already in progress','võrk','madal','programm proovib luua uut võrguühendust, aga eelmine ühendus on kasutusel',' Oota, kuni rakendus eelmise ühenduse katkestab ','NULL'),
(15,'Bad file descriptor','süsteem','keskmine','programm proovib kasutada soketi (või faili) failideskriptorit, mis on juba suletud, vigane või mille väärtus on muutunud','int fd = open(\"output\", O_CREAT|O_WRONLY, 0600);',' Kasuta strace-i, et jälgida, millal ja kus failideskriptor suleti. '),
(16,'Bad message','süsteem','keskmine','faili ei saa avada, sest andmed on kaduma läinud või failisüsteemiga on mingi probleem','sudo fsck -p /dev/sdXn','NULL'),
(17,'Device or resource busy','süsteem','madal',' kernel ei saa toimingut lõpule viia, kuna ressurss või teenus on kasutuses','sudo umount -l /path/to/mount','NULL'),
(18,'No child processes','süsteem','keskmine','kasutajaprotsessi piir on ületatud või muude protsesside arv taustal on liiga suur, takistades uute protsesside loomist','suurendada lubatud maksimaalseid protsesse redigeerides faili /etc/security/limits.conf','NULL'),
(19,'Connection aborted','võrk','madal','tarkvara sulges kliendi või serveri poolel ootamatult võrguühenduse','sudo firewall-cmd --list-all','sudo firewall-cmd --permanent --add-service=ssh'),
(22,'Connection reset by peer','teenused','madal','TCP-voog on kaugsüsteemi poolt suletud, mis sunnib süsteemil ühenduse katkestada','sudo systemctl restart [teenus] ','taaskäivita võrgu haldur käsuga sudo systemctl restart NetworkManager.service'),
(25,'Cannot allocate memory','süsteem','kriitiline','Programm ei saanud süsteemilt piisavalt mälu.','Kontrolli mälu kasutust: free -h','Lisa või suurenda swap-ala'),
(26,'Exec format error','käsk','madal','Fail ei ole käivitatav programm või on vale arhitektuuriga.','Kontrolli faili tüüpi käsuga: file binary',NULL),
(28,'Invalid argument','käsk','madal','Programm sai argumendi, mida ei osata töödelda.','Kontrolli käsu süntaksit ja dokumentatsiooni (man <käsk>)',NULL),
(29,'Not a directory','fail','madal','Failitee osas eeldati kataloogi, kuid tegelikult on see fail.','Kontrolli teed käsuga ls -l <tee>',NULL),
(30,'Is a directory','fail','madal','Programm üritab käsitleda kataloogi nagu faili.','Kasuta faili asemel korrektset failiteed',NULL),
(31,'Directory not empty','fail','madal','Kataloogi ei saa kustutada, sest see sisaldab faile.','Kustuta kataloogi sisu enne eemaldamist','Kasuta rekursiivset kustutamist: rm -r <kataloog>'),
(32,'Text file busy','süsteem','keskmine','Käivitatavat faili kasutatakse teise protsessi poolt.','Sulge või lõpeta protsess, mis faili kasutab (lsof)',NULL),
(33,'Resource temporarily unavailable','süsteem','madal','Süsteemi ressurss (nt CPU, fail või lukustus) pole hetkel saadaval.','Oota ja proovi toimingut uuesti',NULL),
(34,'Connection refused','võrk','keskmine','Sihtteenus ei tööta või ei kuula antud pordil.','Kontrolli teenuse olekut: systemctl status <teenus>','Kontrolli tulemüüri reegleid'),
(35,'Network is unreachable','võrk','keskmine','Süsteem ei leia teed sihtvõrku.','Kontrolli marsruute käsuga ip route',NULL),
(36,'No such device','süsteem','keskmine','Tuvastatud seadet ei eksisteeri või pole süsteemi küljes.','Kontrolli seadmeid käsuga lsblk või dmesg',NULL),
(37,'Inappropriate ioctl for device','süsteem','madal','Käsk või programm üritab kasutada mitte‑sobivat seadet.','Veendu, et kasutad käsku õige seadme või faili peal',NULL),
(38,'File name too long','fail','madal','Faili nimi ületab failisüsteemi lubatud pikkuse.','Lühenda faili nime või kataloogistruktuuri',NULL),
(39,'Too many open files','süsteem','keskmine','Protsess on avanud rohkem faile kui lubatud.','Kontrolli limiite käsuga ulimit -n','Suurenda piiranguid failis /etc/security/limits.conf'),
(40,'Broken pipe','võrk','madal','Protsess kirjutas torusse või soketisse, mille teine ots on suletud.','Kontrolli torude ja võrguühenduste elutsüklit',NULL),
(41,'Connection timed out','võrk','keskmine','Võrguühendus ei saanud määratud aja jooksul vastust.','Kontrolli võrguühendust ja sihtserveri olekut',NULL),
(42,'Operation now in progress','võrk','madal','Mitteblokeeriv ühendus on loodud, kuid pole veel valmis.','Oota, kuni ühendus lõpetab loomise',NULL),
(43,'Host is unreachable','võrk','keskmine','Sihtmasin ei ole võrgus kättesaadav.','Kontrolli võrguühendust ja marsruutimist',NULL),
(44,'Protocol not supported','võrk','madal','Programm üritab kasutada protokolli, mida kernel ei toeta.','Kontrolli protokolli tuge ja kernelimooduleid',NULL),
(45,'Function not implemented','süsteem','madal','Kernel või süsteemikõne ei toeta nõutud funktsionaalsust.','Kasuta alternatiivset funktsiooni või uuemat kernelit',NULL),
(46,'Numerical result out of range','käsk','madal','Arvutus andis tulemuse, mis ületab lubatud vahemiku.','Kontrolli sisendandmeid ja andmetüüpe',NULL),
(47,'No such process','süsteem','madal','Antud PID‑ga protsessi ei eksisteeri või see on juba lõppenud.','Kontrolli protsesse käsuga ps aux',NULL),
(48,'Operation not permitted','õigused','keskmine','Operatsioon on keelatud ka siis, kui fail või ressurss eksisteerib.','Käivita käsk administraatori õigustes (sudo)',NULL),
(49,'Interrupted system call','süsteem','madal','Süsteemikõne katkestati signaali (nt SIGINT või SIGTERM) tõttu.','Korda toimingut',NULL),
(50,'File exists','fail','madal','Faili loomine ebaõnnestus, sest samanimeline fail on juba olemas.','Kasuta teist failinime või eemalda olemasolev',NULL),
(51,'Cross-device link','fail','madal','Faili ei saa liigutada eri failisüsteemide vahel hard‑linkiga.','Kasuta kopeerimist ja seejärel kustutamist',NULL),
(52,'Read-only file system','fail','kõrge','Failisüsteem on ühendatud ainult lugemiseks.','Kontrolli ühenduse olekut käsuga mount','Ühenda failisüsteem uuesti kirjutatavaks'),
(53,'Too many levels of symbolic links','fail','madal','Sümbollingid viitavad üksteisele tsükliliselt.','Kontrolli ja paranda sümbollingid käsuga ls -l',NULL),
(54,'Bad address','süsteem','keskmine','Programm proovis kasutada vigast või lubamatut mäluaadressi.','Kontrolli programmi sisendeid ja mälukasutust',NULL),
(55,'Too many open files in system','süsteem','keskmine','Süsteemi globaalne avatud failide piir on ületatud.','Kontrolli ja kohanda väärtust /proc/sys/fs/file-max',NULL),
(56,'Network is down','võrk','kõrge','Võrguliides või kogu võrk ei ole töökorras.','Kontrolli võrguühendust ja liideste olekut käsuga ip link',NULL),
(57,'Network dropped connection on reset','võrk','keskmine','Võrk katkestas ühenduse reseti tõttu.','Kontrolli võrgu stabiilsust ja vahepealseid seadmeid',NULL),
(58,'No buffer space available','võrk','keskmine','Süsteemil ei ole piisavalt võrgu puhvrit uute pakettide jaoks.','Kontrolli avatud ühenduste arvu','Suurenda võrgupuhvreid (net.core.rmem_max / wmem_max)'),
(59,'Operation already in progress','võrk','madal','Sama võrguoperatsioon on juba aktiivne.','Väldi mitu korda sama ühenduse käivitamist',NULL),
(60,'Transport endpoint is already connected','võrk','madal','Soketil on juba aktiivne ühendus.','Ära ühenda soketit uuesti enne katkestamist',NULL),
(61,'Transport endpoint is not connected','võrk','madal','Toimingut üritati soketiga, millel pole aktiivset ühendust.','Loo ühendus enne andmete saatmist või vastuvõttu',NULL),
(62,'Destination address required','võrk','madal','Saatmisel puudub sihtaadress.','Määra sihtaadress enne pakettide saatmist',NULL),
(63,'Message too long','võrk','madal','Saadetav võrgusõnum ületab lubatud maksimaalse suuruse.','Vähenda sõnumi suurust või kasuta fragmentatsiooni',NULL),
(64,'Protocol not available','võrk','madal','Nõutud võrguprotokoll ei ole süsteemis saadaval.','Kontrolli kerneli tuge ja laaditud mooduleid',NULL),
(65,'Host is down','võrk','keskmine','Sihtmasin on küll tuvastatav, kuid ei vasta.','Kontrolli sihtmasina olekut ja võrguühendust',NULL),
(66,'Cannot send after transport endpoint shutdown','võrk','madal','Andmeid üritati saata pärast soketi sulgemist.','Ära saada andmeid pärast ühenduse sulgemist',NULL),
(67,'Socket operation on non-socket','võrk','madal','Operatsiooni üritati teha failil, mis ei ole soket.','Veendu, et kasutatav failikirjeldus on soket',NULL),
(68,'Protocol wrong type for socket','võrk','madal','Soket loodi vale protokolliga.','Kasuta soketi loomisel korrektset protokolli ja tüüpi',NULL),
(69,'Protocol family not supported','võrk','madal','Süsteem ei toeta määratud protokolliperekonda.','Kasuta toetatud protokolliperekonda (nt AF_INET)',NULL),
(70,'Operation canceled','süsteem','madal','Operatsioon katkestati enne selle lõpetamist (kasutaja, süsteemi või teise protsessi poolt).','Käivita operatsioon uuesti ja kontrolli, mis selle katkestas',NULL);
/*!40000 ALTER TABLE `errors_backup` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-06 17:44:24

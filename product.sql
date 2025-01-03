-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: snack_shop
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `products`
--

create database snack_shop
use snack_shop

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  `price` decimal(10,2) NOT NULL,
  `stock` int NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Khoai tây chiên','Snack khoai tây giòn rụm',15000.00,20,'https://example.com/chips.jpg'),(2,'Bánh quy','Bánh quy bơ thơm ngon',20000.00,15,'https://example.com/cookies.jpg'),(3,'Kẹo dẻo','Kẹo dẻo trái cây nhiều màu sắc',10000.00,30,'https://example.com/gummies.jpg'),(4,'Sô cô la','Sô cô la đen hảo hạng',25000.00,25,''),(5,'Bánh ngọt','Bánh ngọt mềm mịn, thơm lừng',18000.00,18,''),(6,'Nước ép trái cây','Nước ép cam tự nhiên',12000.00,40,''),(7,'Bánh mì nướng','Bánh mì nướng giòn, thơm ngon',22000.00,10,''),(8,'Kẹo cao su','Kẹo cao su trái cây vị dâu',5000.00,50,''),(9,'Mì gói','Mì gói ăn liền, dễ chế biến',7000.00,35,''),(10,'Sữa chua','Sữa chua trái cây, giàu vitamin',15000.00,20,''),(11,'Cà phê','Cà phê đen nguyên chất',30000.00,15,''),(12,'Trái cây sấy','Trái cây sấy khô, giữ nguyên dinh dưỡng',20000.00,25,''),(13,'Bánh bao','Bánh bao nhân thịt, nóng hổi',15000.00,30,''),(14,'Mứt trái cây','Mứt trái cây ngọt ngào',12000.00,40,''),(15,'Bánh pizza','Bánh pizza phô mai thơm ngon',40000.00,12,''),(16,'Bánh cupcake','Bánh cupcake ngọt ngào, dễ thương',25000.00,22,''),(17,'Snack ngô','Snack ngô giòn, mặn vừa phải',15000.00,30,''),(18,'Thạch rau câu','Thạch rau câu nhiều màu sắc',10000.00,50,''),(19,'Kẹo dẻo trái cây','Kẹo dẻo nhiều hương vị trái cây',12000.00,40,''),(20,'Bánh crepe','Bánh crepe mềm, nhân ngọt',22000.00,18,''),(21,'Bánh mì kẹp','Bánh mì kẹp thịt, rau sống',30000.00,10,''),(22,'Nước ngọt','Nước ngọt có gas, vị chanh',15000.00,30,''),(23,'Bánh quy socola','Bánh quy socola, vị ngọt vừa phải',25000.00,20,''),(24,'Chè','Chè đậu xanh, thanh mát',10000.00,25,''),(25,'Mì xào','Mì xào rau củ, thơm ngon',18000.00,20,''),(26,'Nước ép dưa hấu','Nước ép dưa hấu mát lạnh',13000.00,30,''),(27,'Bánh mì sandwich','Bánh mì sandwich kẹp thịt',20000.00,15,''),(28,'Sữa tươi','Sữa tươi nguyên chất',22000.00,20,''),(29,'Cà phê sữa','Cà phê sữa đá',25000.00,25,''),(30,'Bánh pancake','Bánh pancake mềm, thơm ngon',20000.00,18,''),(31,'Sữa đậu nành','Sữa đậu nành tự nhiên',15000.00,30,''),(32,'Bánh tráng','Bánh tráng cuốn thịt',18000.00,12,''),(33,'Kẹo socola','Kẹo socola ngọt ngào',10000.00,40,''),(34,'Bánh mì que','Bánh mì que giòn, thơm',12000.00,20,''),(35,'Sữa chua uống','Sữa chua uống có hương trái cây',15000.00,25,''),(36,'Kẹo bạc hà','Kẹo bạc hà mát lạnh',8000.00,50,''),(37,'Bánh trôi','Bánh trôi nước ngọt ngào',10000.00,30,''),(38,'Mứt dừa','Mứt dừa ngọt ngào, thơm phức',12000.00,35,''),(39,'Chả giò','Chả giò giòn rụm',25000.00,18,''),(40,'Nước ép táo','Nước ép táo nguyên chất',13000.00,40,''),(41,'Bánh xèo','Bánh xèo giòn, nhân tôm thịt',30000.00,20,''),(42,'Bánh mì nướng mật ong','Bánh mì nướng với mật ong ngọt ngào',20000.00,15,''),(43,'Thịt nướng','Thịt nướng thơm ngon, đậm đà',35000.00,12,''),(44,'Cơm chiên','Cơm chiên hải sản, thơm ngon',25000.00,20,''),(45,'Mì trộn','Mì trộn sốt cà chua',20000.00,30,''),(46,'Bánh trứng','Bánh trứng mềm, thơm',12000.00,40,''),(47,'Chè đậu đỏ','Chè đậu đỏ ngọt ngào',10000.00,50,''),(48,'Bánh chưng','Bánh chưng truyền thống',35000.00,10,''),(49,'Mì ăn liền','Mì ăn liền hương vị thịt bò',7000.00,35,''),(50,'Bánh đậu xanh','Bánh đậu xanh truyền thống',15000.00,20,''),(51,'Bánh mì thịt','Bánh mì thịt kẹp rau sống',20000.00,30,''),(52,'Sữa đậu nành','Sữa đậu nành ngọt ngào',12000.00,25,''),(53,'Bánh cuốn','Bánh cuốn thơm ngon',25000.00,20,''),(54,'Bánh xốp','Bánh xốp giòn, thơm',10000.00,50,''),(55,'Chè thái','Chè thái mát lạnh',15000.00,35,''),(56,'Bánh mì phô mai','Bánh mì phô mai thơm lừng',22000.00,15,''),(57,'Mứt cam','Mứt cam ngọt ngào',12000.00,30,''),(58,'Kẹo sữa','Kẹo sữa dẻo',8000.00,40,''),(59,'Bánh bao nhân thịt','Bánh bao nhân thịt thơm ngon',20000.00,25,''),(60,'Sữa chua trái cây','Sữa chua trái cây ngọt ngào',15000.00,30,''),(61,'Cơm cuộn','Cơm cuộn hải sản',30000.00,18,''),(62,'Bánh phở','Bánh phở mềm, thơm',12000.00,20,''),(63,'Kẹo mút','Kẹo mút vị trái cây',6000.00,50,'');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-01-03 22:00:18

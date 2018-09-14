/*
SQLyog Ultimate v12.08 (64 bit)
MySQL - 5.7.16 : Database - db_practice
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`db_practice` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `db_practice`;

/*Table structure for table `liqi_taobao_cart` */

DROP TABLE IF EXISTS `liqi_taobao_cart`;

CREATE TABLE `liqi_taobao_cart` (
  `cartId` bigint(20) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '购物车id',
  `goodsId` bigint(20) unsigned zerofill NOT NULL COMMENT '商品id',
  `userId` bigint(20) unsigned zerofill NOT NULL COMMENT '用户id',
  `cartCount` int(2) NOT NULL DEFAULT '1' COMMENT '购物车商品数量',
  PRIMARY KEY (`cartId`),
  KEY `goodsId` (`goodsId`),
  KEY `userId` (`userId`),
  CONSTRAINT `liqi_taobao_cart_ibfk_1` FOREIGN KEY (`goodsId`) REFERENCES `liqi_taobao_goods` (`goodsId`),
  CONSTRAINT `liqi_taobao_cart_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `liqi_taobao_user` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `liqi_taobao_cart` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

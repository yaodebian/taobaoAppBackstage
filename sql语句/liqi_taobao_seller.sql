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

/*Table structure for table `liqi_taobao_seller` */

DROP TABLE IF EXISTS `liqi_taobao_seller`;

CREATE TABLE `liqi_taobao_seller` (
  `sellerId` bigint(20) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '商家id',
  `userId` bigint(20) unsigned zerofill NOT NULL COMMENT '用户id',
  `sellerImg` varchar(50) NOT NULL COMMENT '商家头像',
  `storeName` varchar(50) NOT NULL COMMENT '店铺名',
  `goodsCode` float NOT NULL COMMENT '宝贝描述',
  `serviceCode` float NOT NULL COMMENT '卖家服务',
  `transCode` float NOT NULL COMMENT '物流服务',
  PRIMARY KEY (`sellerId`),
  KEY `userId` (`userId`),
  CONSTRAINT `liqi_taobao_seller_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `liqi_taobao_user` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `liqi_taobao_seller` */

insert  into `liqi_taobao_seller`(`sellerId`,`userId`,`sellerImg`,`storeName`,`goodsCode`,`serviceCode`,`transCode`) values (00000000000000000001,00000000000000000002,'1.jpg','海迷の家',4.7,4.8,4.8);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

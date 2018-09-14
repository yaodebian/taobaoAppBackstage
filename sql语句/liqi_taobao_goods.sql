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

/*Table structure for table `liqi_taobao_keywords` */

DROP TABLE IF EXISTS `liqi_taobao_keywords`;

CREATE TABLE `liqi_taobao_keywords` (
  `keyId` bigint(20) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '关键词id',
  `keyword` varchar(50) NOT NULL COMMENT '关键词内容',
  PRIMARY KEY (`keyId`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

/*Data for the table `liqi_taobao_keywords` */

insert  into `liqi_taobao_keywords`(`keyId`,`keyword`) values (00000000000000000001,'海贼王手办'),(00000000000000000002,'海尔官方旗舰店'),(00000000000000000003,'海藻面膜'),(00000000000000000004,'海鲜 水产 鲜活'),(00000000000000000005,'海蓝之谜'),(00000000000000000006,'海边度假套装 女夏 沙滩裙'),(00000000000000000007,'海苔'),(00000000000000000008,'海鲜'),(00000000000000000009,'海绵垫'),(00000000000000000010,'海贼王'),(00000000000000000011,'海边裙女');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

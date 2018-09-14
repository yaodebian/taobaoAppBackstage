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

/*Table structure for table `liqi_taobao_user` */

DROP TABLE IF EXISTS `liqi_taobao_user`;

CREATE TABLE `liqi_taobao_user` (
  `userId` bigint(20) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `username` varchar(20) NOT NULL DEFAULT '点击我设置你的登录名吧' COMMENT '用户名',
  `phone` varchar(11) NOT NULL COMMENT '手机号',
  `password` varchar(12) DEFAULT NULL COMMENT '密码',
  `userImg` varchar(50) NOT NULL DEFAULT 'icon.svg' COMMENT '用户头像',
  `nick` varchar(20) NOT NULL DEFAULT '点击我设置昵称吧' COMMENT '用户昵称',
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

/*Data for the table `liqi_taobao_user` */

insert  into `liqi_taobao_user`(`userId`,`username`,`phone`,`password`,`userImg`,`nick`) values (00000000000000000001,'点击我设置你的登录名吧','44444444444',NULL,'icon.svg','点击我设置昵称'),(00000000000000000002,'点击我设置你的登录名吧','12345678900',NULL,'icon.svg','点击我设置昵称'),(00000000000000000003,'垚的彼岸','11111111111','123456Abc','icon.svg','yaodebian'),(00000000000000000004,'点击我设置你的登录名吧','99999999999',NULL,'icon.svg','点击我设置昵称'),(00000000000000000005,'点击我设置你的登录名吧','44444444444',NULL,'icon.svg','点击我设置昵称'),(00000000000000000006,'点击我设置你的登录名吧','55555555555',NULL,'icon.svg','点击我设置昵称'),(00000000000000000007,'点击我设置你的登录名吧','66666666666',NULL,'icon.svg','点击我设置昵称'),(00000000000000000008,'点击我设置你的登录名吧','77777777777',NULL,'icon.svg','点击我设置昵称'),(00000000000000000009,'点击我设置你的登录名吧','88888888888',NULL,'icon.svg','点击我设置昵称'),(00000000000000000010,'点击我设置你的登录名吧','12222222222',NULL,'icon.svg','点击我设置昵称'),(00000000000000000011,'点击我设置你的登录名吧','13333333333',NULL,'icon.svg','点击我设置昵称');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

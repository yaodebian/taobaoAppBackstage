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

/*Table structure for table `liqi_taobao_goods` */

DROP TABLE IF EXISTS `liqi_taobao_goods`;

CREATE TABLE `liqi_taobao_goods` (
  `goodsId` bigint(20) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '商品id',
  `sellerId` bigint(20) unsigned zerofill NOT NULL COMMENT '商家id',
  `goodsName` varchar(100) NOT NULL COMMENT '商品名称',
  `goodsPrice` varchar(10) NOT NULL COMMENT '商品价格',
  `tags` varchar(100) DEFAULT NULL COMMENT '商品标签',
  `column` varchar(20) DEFAULT NULL COMMENT '商品栏目',
  `img` varchar(50) NOT NULL COMMENT '商品展示图片',
  `discount` varchar(20) NOT NULL COMMENT '打折优惠',
  `customers` varchar(20) NOT NULL DEFAULT '0' COMMENT '购买用户数量',
  `location` varchar(20) NOT NULL COMMENT '商品生产地点',
  PRIMARY KEY (`goodsId`),
  KEY `liqi_taobao_goods_ibfk_1` (`sellerId`),
  CONSTRAINT `liqi_taobao_goods_ibfk_1` FOREIGN KEY (`sellerId`) REFERENCES `liqi_taobao_seller` (`sellerId`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

/*Data for the table `liqi_taobao_goods` */

insert  into `liqi_taobao_goods`(`goodsId`,`sellerId`,`goodsName`,`goodsPrice`,`tags`,`column`,`img`,`discount`,`customers`,`location`) values (00000000000000000001,00000000000000000001,'路飞15亿,海贼王通缉令海贼王海报周边全套悬赏令墙纸索隆山治','21.9',NULL,NULL,'1.jpg','包邮','0','深圳'),(00000000000000000002,00000000000000000001,'即将现货 MRC 艾斯之死 路飞赤犬 海贼王手办雕像 猴子gk','1980',NULL,NULL,'2.jpg','包邮','0','上海'),(00000000000000000006,00000000000000000001,'动漫全套海贼手办王模型路飞索隆乔巴 七武海摆件玩偶公仔礼物','238',NULL,NULL,'3.jpg','包邮','363','广东 广州'),(00000000000000000007,00000000000000000001,'海贼航海王海贼团路飞乔巴索隆周边手办发光水晶挂饰创意生日礼物','15',NULL,NULL,'4.jpg','包邮','89','广东 江门'),(00000000000000000008,00000000000000000001,'onepiece手办模型路飞索隆艾斯罗公仔动漫生日礼物摆件玩偶','163',NULL,NULL,'5.jpg','包邮','1664','广东 广州'),(00000000000000000009,00000000000000000001,'正版onepiece手办模型全套草帽路飞手办果实海贼船手办 生日礼物','8',NULL,NULL,'6.jpg','包邮','161','广东 广州'),(00000000000000000010,00000000000000000001,'万代海贼王手办MegaHouse POP四档路飞SOC艾斯 BB泳装娜美歌舞伎','549',NULL,NULL,'7.jpg','包邮','14','山东 青岛'),(00000000000000000011,00000000000000000001,'海贼王手办Q版乔巴路飞手办索隆模型摆件玩偶周边生日礼物','38',NULL,NULL,'8.jpg','包邮','56','浙江 金华'),(00000000000000000012,00000000000000000001,'黑色中分头路长直发海贼王女帝假发波雅汉库克仙剑四cosplay假发','70',NULL,NULL,'9.jpg','包邮','4','广东 广州'),(00000000000000000013,00000000000000000001,'海贼王手办路飞索隆山治艾斯模型公仔动漫周边生日礼物男女帝国产','45',NULL,NULL,'10.jpg','包邮','613','广东 广州');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

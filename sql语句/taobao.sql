/*
SQLyog Ultimate v12.08 (64 bit)
MySQL - 5.7.19 : Database - db_practice
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

/*Table structure for table `liqi_taobao_address` */

DROP TABLE IF EXISTS `liqi_taobao_address`;

CREATE TABLE `liqi_taobao_address` (
  `addressId` bigint(20) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '地址id',
  `userId` bigint(20) unsigned zerofill NOT NULL COMMENT '用户id',
  `receiver` varchar(10) NOT NULL COMMENT '收货人',
  `tel` varchar(11) NOT NULL COMMENT '手机号',
  `area` varchar(50) NOT NULL COMMENT '所在地区',
  `detailAdd` varchar(50) NOT NULL COMMENT '详细地址',
  `tagVal` varchar(50) NOT NULL COMMENT '地址标签',
  `isDefault` tinyint(1) NOT NULL COMMENT '是否为默认地址',
  PRIMARY KEY (`addressId`),
  KEY `userId` (`userId`),
  CONSTRAINT `liqi_taobao_address_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `liqi_taobao_user` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

/*Data for the table `liqi_taobao_address` */

insert  into `liqi_taobao_address`(`addressId`,`userId`,`receiver`,`tel`,`area`,`detailAdd`,`tagVal`,`isDefault`) values (00000000000000000006,00000000000000000003,'fdsfa','11111111111','福建 南平市 邵武市','福建 南平市 邵武市','公司',0),(00000000000000000007,00000000000000000003,'fdsfsfdsf','22222222222','福建 南平市 武夷山市','福建 南平市 武夷山市','学校',0),(00000000000000000008,00000000000000000003,'dfsfdsf','33333333333','内蒙古 呼伦贝尔市 新巴尔虎左旗','内蒙古 呼伦贝尔市 新巴尔虎左旗','',0),(00000000000000000009,00000000000000000003,'rgthj','11111111111','江西 吉安市 遂川县','dvfghgfdfgh','家',1),(00000000000000000010,00000000000000000014,'估计快','11111111111','辽宁 本溪市 明山区','/刚好近近景近景','家',1);

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
) ENGINE=InnoDB AUTO_INCREMENT=435 DEFAULT CHARSET=utf8;

/*Data for the table `liqi_taobao_cart` */

insert  into `liqi_taobao_cart`(`cartId`,`goodsId`,`userId`,`cartCount`) values (00000000000000000429,00000000000000000001,00000000000000000003,1);

/*Table structure for table `liqi_taobao_deal_record` */

DROP TABLE IF EXISTS `liqi_taobao_deal_record`;

CREATE TABLE `liqi_taobao_deal_record` (
  `recordId` bigint(20) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '交易id',
  `goodsId` bigint(20) unsigned NOT NULL COMMENT '商品id',
  `userId` bigint(20) unsigned zerofill NOT NULL COMMENT '用户id',
  PRIMARY KEY (`recordId`),
  KEY `goodsId` (`goodsId`),
  KEY `userId` (`userId`),
  CONSTRAINT `liqi_taobao_deal_record_ibfk_1` FOREIGN KEY (`goodsId`) REFERENCES `liqi_taobao_goods` (`goodsId`),
  CONSTRAINT `liqi_taobao_deal_record_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `liqi_taobao_user` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `liqi_taobao_deal_record` */

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

insert  into `liqi_taobao_goods`(`goodsId`,`sellerId`,`goodsName`,`goodsPrice`,`tags`,`column`,`img`,`discount`,`customers`,`location`) values (00000000000000000001,00000000000000000001,'路飞15亿,海贼王通缉令海贼王海报周边全套悬赏令墙纸索隆山治','21.9',NULL,NULL,'1.jpg','包邮','0','深圳'),(00000000000000000002,00000000000000000001,'即将现货 MRC 艾斯之死 路飞赤犬 海贼王手办雕像 猴子gk','1980',NULL,NULL,'2.jpg','包邮','0','上海'),(00000000000000000006,00000000000000000002,'动漫全套海贼手办王模型路飞索隆乔巴 七武海摆件玩偶公仔礼物','238',NULL,NULL,'3.jpg','包邮','363','广东 广州'),(00000000000000000007,00000000000000000001,'海贼航海王海贼团路飞乔巴索隆周边手办发光水晶挂饰创意生日礼物','15',NULL,NULL,'4.jpg','包邮','89','广东 江门'),(00000000000000000008,00000000000000000001,'onepiece手办模型路飞索隆艾斯罗公仔动漫生日礼物摆件玩偶','163',NULL,NULL,'5.jpg','包邮','1664','广东 广州'),(00000000000000000009,00000000000000000002,'正版onepiece手办模型全套草帽路飞手办果实海贼船手办 生日礼物','8',NULL,NULL,'6.jpg','包邮','161','广东 广州'),(00000000000000000010,00000000000000000001,'万代海贼王手办MegaHouse POP四档路飞SOC艾斯 BB泳装娜美歌舞伎','549',NULL,NULL,'7.jpg','包邮','14','山东 青岛'),(00000000000000000011,00000000000000000001,'海贼王手办Q版乔巴路飞手办索隆模型摆件玩偶周边生日礼物','38',NULL,NULL,'8.jpg','包邮','56','浙江 金华'),(00000000000000000012,00000000000000000002,'黑色中分头路长直发海贼王女帝假发波雅汉库克仙剑四cosplay假发','70',NULL,NULL,'9.jpg','包邮','4','广东 广州'),(00000000000000000013,00000000000000000001,'海贼王手办路飞索隆山治艾斯模型公仔动漫周边生日礼物男女帝国产','45',NULL,NULL,'10.jpg','包邮','613','广东 广州');

/*Table structure for table `liqi_taobao_keywords` */

DROP TABLE IF EXISTS `liqi_taobao_keywords`;

CREATE TABLE `liqi_taobao_keywords` (
  `keyId` bigint(20) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '关键词id',
  `keyword` varchar(50) NOT NULL COMMENT '关键词内容',
  PRIMARY KEY (`keyId`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

/*Data for the table `liqi_taobao_keywords` */

insert  into `liqi_taobao_keywords`(`keyId`,`keyword`) values (00000000000000000001,'海贼王手办'),(00000000000000000002,'海尔官方旗舰店'),(00000000000000000003,'海藻面膜'),(00000000000000000004,'海鲜 水产 鲜活'),(00000000000000000005,'海蓝之谜'),(00000000000000000006,'海边度假套装 女夏 沙滩裙'),(00000000000000000007,'海苔'),(00000000000000000008,'海鲜'),(00000000000000000009,'海绵垫'),(00000000000000000010,'海贼王'),(00000000000000000011,'海边裙女');

/*Table structure for table `liqi_taobao_order` */

DROP TABLE IF EXISTS `liqi_taobao_order`;

CREATE TABLE `liqi_taobao_order` (
  `orderId` bigint(20) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `userId` bigint(20) unsigned zerofill NOT NULL COMMENT '用户id',
  `addressId` bigint(20) unsigned zerofill NOT NULL COMMENT '地址id',
  `totalAmount` varchar(10) NOT NULL COMMENT '订单总计',
  `payPrice` varchar(10) NOT NULL COMMENT '运费险支付',
  `getPrice` varchar(10) NOT NULL COMMENT '运费险偿还',
  `msgtxt` varchar(50) NOT NULL COMMENT '买家留言',
  `status` int(1) NOT NULL DEFAULT '1' COMMENT '订单状态：0表示待付款，1表示待发货，2表示待收货，3表示已收货，4表示待评价，5表示退款或者售后的订单',
  `isFreight` tinyint(1) NOT NULL COMMENT '快递是否免运费',
  PRIMARY KEY (`orderId`),
  KEY `userId` (`userId`),
  CONSTRAINT `liqi_taobao_order_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `liqi_taobao_user` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

/*Data for the table `liqi_taobao_order` */

insert  into `liqi_taobao_order`(`orderId`,`userId`,`addressId`,`totalAmount`,`payPrice`,`getPrice`,`msgtxt`,`status`,`isFreight`) values (00000000000000000027,00000000000000000003,00000000000000000009,'386','0.8','11','',2,0),(00000000000000000028,00000000000000000014,00000000000000000010,'792.8','0.8','11','',2,0),(00000000000000000029,00000000000000000014,00000000000000000010,'173.9','0.8','11','',1,0);

/*Table structure for table `liqi_taobao_ordergood` */

DROP TABLE IF EXISTS `liqi_taobao_ordergood`;

CREATE TABLE `liqi_taobao_ordergood` (
  `orderGoodId` bigint(20) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '订单涉及的商品记录id',
  `orderId` bigint(20) unsigned zerofill NOT NULL COMMENT '订单id',
  `goodsId` bigint(20) unsigned zerofill NOT NULL COMMENT '商品id',
  `count` int(2) NOT NULL DEFAULT '1' COMMENT '商品数量',
  PRIMARY KEY (`orderGoodId`),
  KEY `orderId` (`orderId`),
  KEY `goodsId` (`goodsId`),
  CONSTRAINT `liqi_taobao_ordergood_ibfk_1` FOREIGN KEY (`orderId`) REFERENCES `liqi_taobao_order` (`orderId`),
  CONSTRAINT `liqi_taobao_ordergood_ibfk_2` FOREIGN KEY (`goodsId`) REFERENCES `liqi_taobao_goods` (`goodsId`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8;

/*Data for the table `liqi_taobao_ordergood` */

insert  into `liqi_taobao_ordergood`(`orderGoodId`,`orderId`,`goodsId`,`count`) values (00000000000000000063,00000000000000000027,00000000000000000006,1),(00000000000000000065,00000000000000000027,00000000000000000009,1),(00000000000000000069,00000000000000000027,00000000000000000012,2),(00000000000000000071,00000000000000000029,00000000000000000001,1),(00000000000000000072,00000000000000000028,00000000000000000006,3),(00000000000000000073,00000000000000000028,00000000000000000009,1),(00000000000000000074,00000000000000000028,00000000000000000012,1),(00000000000000000075,00000000000000000029,00000000000000000011,4);

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
  `freightPrice` int(3) DEFAULT '0' COMMENT '快递免邮最低消费',
  PRIMARY KEY (`sellerId`),
  KEY `userId` (`userId`),
  CONSTRAINT `liqi_taobao_seller_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `liqi_taobao_user` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `liqi_taobao_seller` */

insert  into `liqi_taobao_seller`(`sellerId`,`userId`,`sellerImg`,`storeName`,`goodsCode`,`serviceCode`,`transCode`,`freightPrice`) values (00000000000000000001,00000000000000000002,'1.jpg','海迷の家',4.7,4.8,4.8,50),(00000000000000000002,00000000000000000003,'2.jpg','小哥哥',3.7,4,4,95);

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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

/*Data for the table `liqi_taobao_user` */

insert  into `liqi_taobao_user`(`userId`,`username`,`phone`,`password`,`userImg`,`nick`) values (00000000000000000001,'点击我设置你的登录名吧','44444444444',NULL,'icon.svg','点击我设置昵称'),(00000000000000000002,'点击我设置你的登录名吧','12345678900',NULL,'icon.svg','点击我设置昵称'),(00000000000000000003,'垚的彼岸','11111111111','123456Abc','icon.svg','yaodebian'),(00000000000000000004,'点击我设置你的登录名吧','99999999999',NULL,'icon.svg','点击我设置昵称'),(00000000000000000005,'点击我设置你的登录名吧','44444444444',NULL,'icon.svg','点击我设置昵称'),(00000000000000000006,'点击我设置你的登录名吧','55555555555',NULL,'icon.svg','点击我设置昵称'),(00000000000000000007,'点击我设置你的登录名吧','66666666666',NULL,'icon.svg','点击我设置昵称'),(00000000000000000008,'点击我设置你的登录名吧','77777777777',NULL,'icon.svg','点击我设置昵称'),(00000000000000000009,'点击我设置你的登录名吧','88888888888',NULL,'icon.svg','点击我设置昵称'),(00000000000000000010,'点击我设置你的登录名吧','12222222222',NULL,'icon.svg','点击我设置昵称'),(00000000000000000011,'点击我设置你的登录名吧','13333333333',NULL,'icon.svg','点击我设置昵称'),(00000000000000000012,'yaodebian','11111111111','Yaode123','icon.svg','垚的彼岸'),(00000000000000000013,'点击我设置你的登录名吧','undefined',NULL,'icon.svg','点击我设置昵称吧'),(00000000000000000014,'yaode','undefined','123456Abc','icon.svg','点击我设置昵称吧');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

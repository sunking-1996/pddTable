/*
Navicat MySQL Data Transfer

Source Server         : 开发环境
Source Server Version : 50651
Source Host           : 192.168.16.200:3307
Source Database       : pdd_cluster_01

Target Server Type    : MYSQL
Target Server Version : 50651
File Encoding         : 65001

Date: 2022-06-08 10:31:37
*/

SET FOREIGN_KEY_CHECKS=0;

/*核单记录表 check_trade_log*/
-- ----------------------------
-- Table structure for check_trade_log
-- ----------------------------
DROP TABLE IF EXISTS `check_trade_log202312`;
CREATE TABLE `check_trade_log202312` (
  `checkId` varchar(32) NOT NULL DEFAULT '' COMMENT '核单编号',
  `userId` bigint(20) NOT NULL,
  `platform` tinyint(4) NOT NULL DEFAULT '0' COMMENT '第三方平台类型',
  `createTime` int(11) NOT NULL COMMENT '扫码核单时间',
  `orderSn` varchar(32) NOT NULL DEFAULT '' COMMENT '订单编号',
  `mergeCount` int(11) NOT NULL COMMENT '合并订单数',
  `mergeTids` varchar(512) NOT NULL DEFAULT '' COMMENT '合并订单编号',
  `outSid` varchar(64) NOT NULL DEFAULT '' COMMENT '运单号',
  `consigneeName` varchar(255) NOT NULL DEFAULT '' COMMENT '收件人姓名',
  `consigneeProvince` varchar(32) NOT NULL DEFAULT '' COMMENT '收件人省',
  `cpCode` varchar(32) NOT NULL DEFAULT '' COMMENT '物流公司代码',
  `companieName` varchar(32) NOT NULL DEFAULT '' COMMENT '快递公司',
  `itemCount` int(11) NOT NULL COMMENT '商品总数',
  `sendWay` tinyint(4) NOT NULL DEFAULT '1' COMMENT '发货方式 1 自动发货 2 手动发货',
  `operator` varchar(64) NOT NULL DEFAULT '' COMMENT '操作人',
  `orderNo` bigint(20) NOT NULL,
  PRIMARY KEY (`checkId`),
  KEY `userId` (`userId`,`createTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='核单记录表';

/*包裹信息 package_info*/
-- ----------------------------
-- Table structure for package_info
-- ----------------------------
DROP TABLE IF EXISTS `package_info202312`;
CREATE TABLE `package_info202312` (
  `packageId` varchar(32) NOT NULL DEFAULT '',
  `printInfo` mediumtext NOT NULL COMMENT '电子面单信息',
  `orderInfo` text NOT NULL COMMENT '订单信息',
  `createTime` int(11) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`packageId`),
  KEY `createTime` (`createTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED COMMENT='包裹信息';

/*拼多多订单打印信息表 pdd_order_print*/
-- ----------------------------
-- Table structure for pdd_order_print
-- ----------------------------
DROP TABLE IF EXISTS `pdd_order_print202312`;
CREATE TABLE `pdd_order_print202312` (
  `tradePrintKey` varchar(64) NOT NULL COMMENT '唯一键',
  `orderSn` varchar(32) NOT NULL COMMENT '订单编号',
  `shopId` varchar(32) NOT NULL COMMENT '店铺编号',
  `shopName` varchar(64) NOT NULL COMMENT '店铺名称',
  `printType` tinyint(4) NOT NULL COMMENT '打印类型 1 快递单 2 发货单',
  `printStatus` tinyint(4) NOT NULL COMMENT '打印状态 0 已打印 1 未打印 2 已提交',
  `expressType` tinyint(4) NOT NULL COMMENT '快递单类型 1 普通 2 电子面单',
  `companieCode` varchar(20) NOT NULL COMMENT '公司编码',
  `companieName` varchar(20) NOT NULL COMMENT '公司名称',
  `outSid` varchar(64) NOT NULL COMMENT '物流单号',
  `printInfo` mediumtext NOT NULL COMMENT '打印信息',
  `updateTime` int(11) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`tradePrintKey`),
  KEY `orderSn` (`orderSn`) USING BTREE,
  KEY `shopId` (`shopId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED COMMENT='拼多多订单打印信息表';

/*已打印包裹日志信息表 print_log_info*/
-- ----------------------------
-- Table structure for print_log_info
-- ----------------------------
DROP TABLE IF EXISTS `print_log_info202312`;
CREATE TABLE `print_log_info202312` (
  `printId` char(38) NOT NULL COMMENT '打印编号',
  `printInfo` mediumtext COMMENT '打印信息',
  `createTime` int(11) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`printId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED COMMENT='已打印包裹日志信息表';

/*包裹打印记录 print_log_part*/
-- ----------------------------
-- Table structure for print_log_part
-- ----------------------------
DROP TABLE IF EXISTS `print_log_part202312`;
CREATE TABLE `print_log_part202312` (
  `printId` varchar(32) NOT NULL,
  `userId` bigint(20) NOT NULL,
  `buyerUserId` bigint(20) NOT NULL,
  `packageId` varchar(32) NOT NULL DEFAULT '' COMMENT '交易ID',
  `createTime` int(11) NOT NULL COMMENT '创建时间',
  `consigneeName` varchar(128) NOT NULL DEFAULT '' COMMENT '收件人',
  `consigneeNameIndex` varchar(128) NOT NULL DEFAULT '' COMMENT '收件人姓名索引',
  `consigneeMobile` varchar(128) NOT NULL DEFAULT '' COMMENT '收件人手机',
  `consigneeMobileIndex` varchar(128) NOT NULL DEFAULT '' COMMENT '收件人手机索引',
  `consigneePhone` varchar(128) NOT NULL DEFAULT '' COMMENT '收件人电话',
  `consigneePhoneIndex` varchar(128) NOT NULL DEFAULT '' COMMENT '收件人电话索引',
  `consigneeProvince` varchar(16) NOT NULL DEFAULT '' COMMENT '收件人省',
  `consigneeCity` varchar(16) NOT NULL DEFAULT '' COMMENT '收件人市',
  `consigneeArea` varchar(16) NOT NULL DEFAULT '' COMMENT '收件人区',
  `consigneeTown` varchar(16) NOT NULL DEFAULT '' COMMENT '收件人街道',
  `consigneeAddress` varchar(512) NOT NULL DEFAULT '' COMMENT '收件人地址',
  `consigneeAddressIndex` varchar(512) NOT NULL DEFAULT '' COMMENT '收件人地址索引',
  `consigneeZip` varchar(16) NOT NULL DEFAULT '' COMMENT '收件人邮编',
  `shippingName` varchar(32) NOT NULL DEFAULT '' COMMENT '发件人姓名',
  `shippingMobile` varchar(32) NOT NULL DEFAULT '' COMMENT '发件人手机',
  `shippingPhone` varchar(32) NOT NULL DEFAULT '' COMMENT '发件人电话',
  `shippingProvince` varchar(16) NOT NULL DEFAULT '' COMMENT '发件人省',
  `shippingCity` varchar(16) NOT NULL DEFAULT '' COMMENT '发件人市',
  `shippingArea` varchar(16) NOT NULL DEFAULT '' COMMENT '发件人区',
  `shippingTown` varchar(16) NOT NULL DEFAULT '' COMMENT '发件人街道',
  `shippingAddress` varchar(128) NOT NULL DEFAULT '' COMMENT '发件人地址',
  `shippingZip` varchar(16) NOT NULL DEFAULT '' COMMENT '发件人邮编',
  `shippingCompany` varchar(64) NOT NULL DEFAULT '' COMMENT '寄件人公司',
  `printType` tinyint(4) NOT NULL COMMENT '打印类型，1自己打2帮别人打3他人帮我打印',
  `expressType` tinyint(4) NOT NULL COMMENT '快递单类型 1 普通 2 电子面单',
  `cpCode` varchar(32) NOT NULL DEFAULT '' COMMENT '物流公司',
  `netpointName` varchar(32) NOT NULL DEFAULT '',
  `wlbCode` varchar(32) NOT NULL DEFAULT '' COMMENT '电子面单号（接口回流）',
  `batchId` varchar(32) NOT NULL DEFAULT '' COMMENT '批次号',
  `batchPackageId` varchar(32) NOT NULL DEFAULT '' COMMENT '批货号',
  `batchNote` varchar(32) NOT NULL DEFAULT '' COMMENT '批包备注',
  `packageCategory` varchar(32) NOT NULL DEFAULT '',
  `packageNote` varchar(255) NOT NULL DEFAULT '',
  `operator` varchar(64) NOT NULL DEFAULT '' COMMENT '操作人',
  `deviceName` varchar(32) NOT NULL DEFAULT '' COMMENT '打印机设备',
  `otherUserId` bigint(20) NOT NULL DEFAULT '0' COMMENT '他人打印用户ID',
  `note` varchar(255) NOT NULL DEFAULT '',
  `orderNo` bigint(20) NOT NULL DEFAULT '0',
  `platform` tinyint(4) NOT NULL DEFAULT '0' COMMENT '第三方平台类型',
  `platformKey` varchar(64) NOT NULL DEFAULT '' COMMENT '第三方平台账户主键',
  `platformName` varchar(64) NOT NULL DEFAULT '' COMMENT '第三方平台账户名称',
  `coalitionPackageId` varchar(32) NOT NULL DEFAULT '' COMMENT '合并订单数',
  `mergeCount` int(11) NOT NULL DEFAULT '0' COMMENT '合并订单数',
  `mergePackageIds` varchar(512) NOT NULL DEFAULT '' COMMENT '合并订单编号',
  `type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '类型 1 快递单 2 发货单',
  `templateName` varchar(64) NOT NULL DEFAULT '' COMMENT '打印模板名称',
  `orderId` varchar(64) NOT NULL DEFAULT '' COMMENT '外部订单号',
  PRIMARY KEY (`printId`,`userId`),
  KEY `userId` (`userId`,`packageId`) USING BTREE,
  KEY `userId_2` (`userId`,`createTime`),
  KEY `createTime` (`createTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='包裹打印记录'
/*!50100 PARTITION BY HASH (userId)
PARTITIONS 1 */;

/*发货日志信息表 send_order_log_info*/
-- ----------------------------
-- Table structure for send_order_log_info
-- ----------------------------
DROP TABLE IF EXISTS `send_order_log_info202312`;
CREATE TABLE `send_order_log_info202312` (
  `sendId` char(32) NOT NULL,
  `sendInfo` mediumtext NOT NULL,
  PRIMARY KEY (`sendId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED COMMENT='发货日志信息表';

/*发货日志表 send_order_log*/
-- ----------------------------
-- Table structure for send_order_log
-- ----------------------------
DROP TABLE IF EXISTS `send_order_log202312`;
CREATE TABLE `send_order_log202312` (
  `sendId` char(32) NOT NULL COMMENT '发货编号',
  `userId` bigint(20) NOT NULL COMMENT '用户编号',
  `userNick` varchar(64) NOT NULL COMMENT '用户昵称',
  `platform` tinyint(4) NOT NULL COMMENT '第三方平台类型',
  `platformKey` varchar(64) NOT NULL COMMENT '第三方平台账户主键',
  `platformName` varchar(64) NOT NULL COMMENT '第三方平台账户名称',
  `orderId` varchar(32) NOT NULL COMMENT '订单编号',
  `logisticsId` varchar(32) NOT NULL COMMENT '快递公司编号',
  `outSid` varchar(64) NOT NULL COMMENT '快递单号',
  `companyCode` varchar(32) NOT NULL COMMENT '物流公司代码',
  `companyName` varchar(32) NOT NULL COMMENT '物流公司名称',
  `receiverName` varchar(255) NOT NULL COMMENT '收件人姓名',
  `receiverNameIndex` varchar(128) NOT NULL DEFAULT '' COMMENT '收件人姓名索引',
  `receiverPhone` varchar(255) NOT NULL COMMENT '收件人电话',
  `receiverPhoneIndex` varchar(128) NOT NULL DEFAULT '' COMMENT '收件人电话索引',
  `receiverCountry` varchar(255) NOT NULL COMMENT '收件人国家',
  `receiverProvince` varchar(255) NOT NULL COMMENT '收件人省',
  `receiverCity` varchar(255) NOT NULL COMMENT '收件人市',
  `receiverTown` varchar(255) NOT NULL COMMENT '收件人区',
  `receiverAddress` varchar(512) NOT NULL COMMENT '收件人地址',
  `receiverAddressIndex` varchar(512) NOT NULL DEFAULT '' COMMENT '收件人地址索引',
  `sendTime` int(11) NOT NULL COMMENT '发货时间',
  `location` varchar(16) NOT NULL COMMENT '发货位置',
  `referer` varchar(16) NOT NULL COMMENT '来源',
  `batchId` varchar(32) NOT NULL COMMENT '批次号',
  `operator` varchar(64) NOT NULL COMMENT '操作人',
  `ip` varchar(32) NOT NULL COMMENT 'ip地址',
  `note` varchar(128) NOT NULL COMMENT '备注',
  `orderNo` bigint(20) NOT NULL COMMENT '排序',
  PRIMARY KEY (`sendId`),
  KEY `userId` (`userId`,`sendTime`) USING BTREE,
  KEY `orderId` (`orderId`) USING BTREE,
  KEY `idx_userId_platformKey_sendTime` (`userId`,`platformKey`,`sendTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='发货日志表';

/*电子面单记录信息表 waybill_account_apply_log_info*/
-- ----------------------------
-- Table structure for waybill_account_apply_log_info
-- ----------------------------
DROP TABLE IF EXISTS `waybill_account_apply_log_info202312`;
CREATE TABLE `waybill_account_apply_log_info202312` (
  `applyId` char(32) NOT NULL COMMENT '编号',
  `wlbCodeInfo` mediumtext NOT NULL COMMENT '电子面单信息',
  PRIMARY KEY (`applyId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED COMMENT='电子面单记录信息表';

/*电子面单申请日志 waybill_account_apply_log*/
-- ----------------------------
-- Table structure for waybill_account_apply_log
-- ----------------------------
DROP TABLE IF EXISTS `waybill_account_apply_log202312`;
CREATE TABLE `waybill_account_apply_log202312` (
  `applyId` varchar(32) NOT NULL DEFAULT '0',
  `accountUserId` bigint(20) DEFAULT NULL,
  `operationUserId` bigint(20) DEFAULT NULL,
  `accountOperactionUserId` bigint(20) NOT NULL DEFAULT '0' COMMENT '账号使用者用户ID',
  `status` tinyint(4) DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL COMMENT '1自己打 2别人帮打 3共享打印',
  `cpCode` varchar(32) DEFAULT NULL,
  `wlbAccountId` bigint(20) DEFAULT NULL,
  `wlbAccountType` tinyint(4) DEFAULT NULL COMMENT '面单类型 1 网点 2 菜鸟淘外 3 菜鸟淘宝 4 淘宝超级账号',
  `netpointName` varchar(32) DEFAULT NULL,
  `wlbUsername` varchar(32) DEFAULT NULL,
  `wlbCode` varchar(32) DEFAULT NULL,
  `packageId` varchar(512) DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `postFee` double DEFAULT NULL,
  `batchId` varchar(16) DEFAULT NULL,
  `errorInfo` varchar(255) DEFAULT NULL,
  `createTime` int(11) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `netpointTime` int(11) NOT NULL DEFAULT '0' COMMENT '网点系统时间',
  `logisticsStatus` tinyint(4) NOT NULL COMMENT '物流状态',
  `acceptTime` int(11) NOT NULL COMMENT '揽收时间',
  `packageUserId` bigint(20) NOT NULL DEFAULT '0' COMMENT '包裹用户id',
  `platform` tinyint(4) NOT NULL DEFAULT '0' COMMENT '第三方平台类型',
  `platformKey` varchar(64) NOT NULL DEFAULT '' COMMENT '第三方平台账户主键',
  `platformName` varchar(64) NOT NULL DEFAULT '' COMMENT '第三方平台账户名称',
  `netpointCode` varchar(32) NOT NULL DEFAULT '' COMMENT '网点代码',
  `branchAccount` varchar(32) NOT NULL DEFAULT '' COMMENT '网点账号',
  `receiverName` varchar(255) NOT NULL DEFAULT '' COMMENT '收件人姓名',
  `receiverNameIndex` varchar(128) NOT NULL DEFAULT '' COMMENT '收件人姓名索引',
  `receiverPhone` varchar(255) NOT NULL DEFAULT '' COMMENT '收件人电话',
  `receiverPhoneIndex` varchar(128) NOT NULL DEFAULT '' COMMENT '收件人电话索引',
  `receiverProvince` varchar(32) NOT NULL DEFAULT '' COMMENT '收件人省份',
  `location` varchar(16) NOT NULL DEFAULT '' COMMENT '操作位置',
  `operator` varchar(64) NOT NULL DEFAULT '' COMMENT '操作人',
  `note1` varchar(128) NOT NULL DEFAULT '' COMMENT '备注1',
  `note2` varchar(128) NOT NULL DEFAULT '' COMMENT '备注2',
  `orderNo` bigint(20) NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`applyId`),
  KEY `accountUserId` (`accountUserId`,`wlbAccountId`,`createTime`),
  KEY `accountUserId_2` (`accountUserId`,`wlbAccountId`,`status`),
  KEY `accountUserId_3` (`accountUserId`,`wlbAccountId`,`operationUserId`,`createTime`),
  KEY `accountUserId_4` (`accountUserId`,`operationUserId`,`createTime`,`orderNo`),
  KEY `accountUserId_5` (`accountUserId`,`createTime`,`orderNo`),
  KEY `accountUserId_6` (`accountUserId`,`wlbAccountId`,`operationUserId`,`status`),
  KEY `accountUserId_7` (`accountUserId`,`wlbAccountId`,`accountOperactionUserId`,`createTime`),
  KEY `accountUserId_8` (`accountUserId`,`accountOperactionUserId`,`createTime`,`orderNo`),
  KEY `accountUserId_9` (`accountUserId`,`wlbAccountId`,`accountOperactionUserId`,`status`),
  KEY `wlbCode` (`wlbCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='电子面单申请日志';
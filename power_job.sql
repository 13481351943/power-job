/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50720
Source Host           : localhost:3306
Source Database       : power_job

Target Server Type    : MYSQL
Target Server Version : 50720
File Encoding         : 65001

Date: 2019-03-07 14:01:20
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `mem_attament`
-- ----------------------------
DROP TABLE IF EXISTS `mem_attament`;
CREATE TABLE `mem_attament` (
  `ID` varchar(32) NOT NULL,
  `NAME` varchar(32) DEFAULT NULL,
  `CODE` varchar(32) DEFAULT NULL,
  `STATUS` int(11) DEFAULT NULL,
  `TYPE` int(11) DEFAULT NULL,
  `IS_LOCKED` int(11) DEFAULT '0',
  `IS_VALID` int(11) DEFAULT '1',
  `SORT_NUM` int(11) NOT NULL AUTO_INCREMENT,
  `CREATE_BY` varchar(32) DEFAULT NULL,
  `UPDATE_BY` varchar(32) DEFAULT NULL,
  `CREATE_TIME` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UPDATE_TIME` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `ICON` varchar(512) DEFAULT NULL,
  `DESCRIPTION` varchar(512) DEFAULT NULL,
  `MEMBER_ID` varchar(32) DEFAULT NULL COMMENT '会员ID',
  `URL` varchar(512) DEFAULT NULL,
  `LOCATION` varchar(512) DEFAULT NULL,
  `JOB_ID` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `SORT_INDEX` (`SORT_NUM`),
  KEY `FK_MEM_ATTAMENT_TO_MEM_MEMBER_idx` (`MEMBER_ID`),
  KEY `FK_MEM_ATTAMENT_TO_MEM_JOB_idx` (`JOB_ID`),
  CONSTRAINT `FK_MEM_ATTAMENT_TO_MEM_JOB` FOREIGN KEY (`JOB_ID`) REFERENCES `mem_job` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MEM_ATTAMENT_TO_MEM_MEMBER` FOREIGN KEY (`MEMBER_ID`) REFERENCES `mem_member` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='作业附件';

-- ----------------------------
-- Records of mem_attament
-- ----------------------------

-- ----------------------------
-- Table structure for `mem_dept`
-- ----------------------------
DROP TABLE IF EXISTS `mem_dept`;
CREATE TABLE `mem_dept` (
  `ID` varchar(32) NOT NULL,
  `NAME` varchar(32) DEFAULT NULL,
  `CODE` varchar(32) DEFAULT NULL,
  `STATUS` int(11) DEFAULT NULL,
  `TYPE` int(11) DEFAULT NULL,
  `IS_LOCKED` int(11) DEFAULT '0',
  `IS_VALID` int(11) DEFAULT '1',
  `SORT_NUM` int(11) NOT NULL AUTO_INCREMENT,
  `CREATE_BY` varchar(32) DEFAULT NULL,
  `UPDATE_BY` varchar(32) DEFAULT NULL,
  `CREATE_TIME` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UPDATE_TIME` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `ICON` varchar(512) DEFAULT NULL,
  `DESCRIPTION` varchar(512) DEFAULT NULL,
  `PARENT_ID` varchar(32) DEFAULT NULL,
  `LEVEL` int(11) DEFAULT '0' COMMENT '层级',
  `IS_LEAF` tinyint(4) DEFAULT '1' COMMENT '是否为叶子',
  PRIMARY KEY (`ID`),
  KEY `SORT_INDEX` (`SORT_NUM`),
  KEY `FK_MEM_DEPT_TO_MEM_DEPT_idx` (`PARENT_ID`),
  CONSTRAINT `FK_MEM_DEPT_TO_MEM_DEPT` FOREIGN KEY (`PARENT_ID`) REFERENCES `mem_dept` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of mem_dept
-- ----------------------------

-- ----------------------------
-- Table structure for `mem_exception_job`
-- ----------------------------
DROP TABLE IF EXISTS `mem_exception_job`;
CREATE TABLE `mem_exception_job` (
  `ID` varchar(32) NOT NULL,
  `JOB_ID` varchar(32) DEFAULT NULL,
  `MEMBER_ID` varchar(32) DEFAULT NULL,
  `STATUS` int(11) DEFAULT '1' COMMENT '状态，1为有效，表示问题仍然存在；0表示问题已经得到解决',
  `CREATE_TIME` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UPDATE_TIME` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_MEM_EXCEPTION_JOB_TO_MEM_JOB_idx` (`JOB_ID`),
  KEY `FK_MEM_EXCEPTION_JOB_TO_MEM_MEMBER_idx` (`MEMBER_ID`),
  CONSTRAINT `FK_MEM_EXCEPTION_JOB_TO_MEM_JOB` FOREIGN KEY (`JOB_ID`) REFERENCES `mem_job` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MEM_EXCEPTION_JOB_TO_MEM_MEMBER` FOREIGN KEY (`MEMBER_ID`) REFERENCES `mem_member` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='标注为有问题的作业';

-- ----------------------------
-- Records of mem_exception_job
-- ----------------------------

-- ----------------------------
-- Table structure for `mem_job`
-- ----------------------------
DROP TABLE IF EXISTS `mem_job`;
CREATE TABLE `mem_job` (
  `ID` varchar(32) NOT NULL,
  `NAME` varchar(32) DEFAULT NULL,
  `CODE` varchar(32) DEFAULT NULL,
  `STATUS` int(11) DEFAULT '1' COMMENT '状态：1马上生效，0为草稿',
  `TYPE` int(11) DEFAULT NULL,
  `IS_LOCKED` int(11) DEFAULT '0',
  `IS_VALID` int(11) DEFAULT '1',
  `SORT_NUM` int(11) NOT NULL AUTO_INCREMENT,
  `CREATE_BY` varchar(32) DEFAULT NULL,
  `UPDATE_BY` varchar(32) DEFAULT NULL,
  `CREATE_TIME` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UPDATE_TIME` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `ICON` varchar(512) DEFAULT NULL,
  `DESCRIPTION` varchar(512) DEFAULT NULL,
  `MEMBER_ID` varchar(32) DEFAULT NULL COMMENT '会员ID',
  PRIMARY KEY (`ID`),
  KEY `SORT_INDEX` (`SORT_NUM`),
  KEY `FK_MEM_JOB_TO_MEM_MEMBER_idx` (`MEMBER_ID`),
  CONSTRAINT `FK_MEM_JOB_TO_MEM_MEMBER` FOREIGN KEY (`MEMBER_ID`) REFERENCES `mem_member` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='用户作业';

-- ----------------------------
-- Records of mem_job
-- ----------------------------

-- ----------------------------
-- Table structure for `mem_job_record`
-- ----------------------------
DROP TABLE IF EXISTS `mem_job_record`;
CREATE TABLE `mem_job_record` (
  `ID` varchar(32) NOT NULL COMMENT '与作业步骤一致的ID',
  `NAME` varchar(32) DEFAULT NULL,
  `CODE` varchar(32) DEFAULT NULL,
  `STATUS` int(11) DEFAULT NULL,
  `TYPE` int(11) DEFAULT NULL,
  `IS_LOCKED` int(11) DEFAULT '0',
  `IS_VALID` int(11) DEFAULT '1',
  `SORT_NUM` int(11) NOT NULL AUTO_INCREMENT,
  `CREATE_BY` varchar(32) DEFAULT NULL,
  `CREATE_TIME` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `DESCRIPTION` varchar(512) DEFAULT 'ON UPDATE CURRENT_TIMESTAMP',
  `URL` varchar(512) DEFAULT NULL COMMENT '作业连接',
  `LOCATION` varchar(45) DEFAULT NULL COMMENT '物理地址',
  `JOB_ID` varchar(32) DEFAULT NULL COMMENT '作业ID',
  PRIMARY KEY (`ID`),
  KEY `FK_MEM_JOB_RECORD_TO_MEM_JOB_idx` (`JOB_ID`),
  KEY `SORT_INDEX` (`SORT_NUM`),
  CONSTRAINT `FK_MEM_JOB_RECORD_TO_MEM_JOB` FOREIGN KEY (`JOB_ID`) REFERENCES `mem_job` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='作业步骤录像';

-- ----------------------------
-- Records of mem_job_record
-- ----------------------------

-- ----------------------------
-- Table structure for `mem_job_step`
-- ----------------------------
DROP TABLE IF EXISTS `mem_job_step`;
CREATE TABLE `mem_job_step` (
  `ID` varchar(32) NOT NULL,
  `NAME` varchar(32) DEFAULT NULL,
  `CODE` varchar(32) DEFAULT NULL,
  `STATUS` int(11) DEFAULT NULL,
  `TYPE` int(11) DEFAULT NULL,
  `IS_LOCKED` int(11) DEFAULT '0',
  `IS_VALID` int(11) DEFAULT '1',
  `SORT_NUM` int(11) NOT NULL AUTO_INCREMENT,
  `CREATE_BY` varchar(32) DEFAULT NULL,
  `UPDATE_BY` varchar(32) DEFAULT NULL,
  `CREATE_TIME` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UPDATE_TIME` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `ICON` varchar(512) DEFAULT NULL,
  `DESCRIPTION` varchar(512) DEFAULT NULL,
  `JOB_ID` varchar(32) DEFAULT NULL COMMENT '作业ID',
  PRIMARY KEY (`ID`),
  KEY `SORT_INDEX` (`SORT_NUM`),
  KEY `FK_MEM_JOB_STEP_TO_MEM_JOB_idx` (`JOB_ID`),
  CONSTRAINT `FK_MEM_JOB_STEP_TO_MEM_JOB` FOREIGN KEY (`JOB_ID`) REFERENCES `mem_job` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='作业步骤';

-- ----------------------------
-- Records of mem_job_step
-- ----------------------------

-- ----------------------------
-- Table structure for `mem_member`
-- ----------------------------
DROP TABLE IF EXISTS `mem_member`;
CREATE TABLE `mem_member` (
  `ID` varchar(32) NOT NULL,
  `NAME` varchar(32) DEFAULT NULL,
  `CODE` varchar(32) DEFAULT NULL,
  `STATUS` int(11) DEFAULT NULL,
  `TYPE` int(11) DEFAULT NULL,
  `IS_LOCKED` int(11) DEFAULT '0',
  `IS_VALID` int(11) DEFAULT '1',
  `SORT_NUM` int(11) NOT NULL AUTO_INCREMENT,
  `CREATE_BY` varchar(32) DEFAULT NULL,
  `UPDATE_BY` varchar(32) DEFAULT NULL,
  `CREATE_TIME` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UPDATE_TIME` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `ICON` varchar(512) DEFAULT NULL,
  `DESCRIPTION` varchar(512) DEFAULT NULL COMMENT '描述',
  `LOGIN_NAME` varchar(32) DEFAULT NULL COMMENT '登录账号',
  `MOBILE` varchar(32) DEFAULT NULL COMMENT '电话号码',
  `PASSWORD` varchar(32) DEFAULT NULL COMMENT '密码',
  `SEX` int(11) DEFAULT NULL COMMENT '1表示男，0表示女',
  `WECHAT` varchar(32) DEFAULT NULL COMMENT '微信号码',
  `IF_BIND_WECHAT` varchar(32) DEFAULT NULL COMMENT '是否绑定微信号',
  `OPEN_ID` varchar(64) DEFAULT NULL,
  `UNION_ID` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `SORT_INDEX` (`SORT_NUM`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COMMENT='会员';

-- ----------------------------
-- Records of mem_member
-- ----------------------------
INSERT INTO `mem_member` VALUES ('1', '1', null, null, null, '0', '1', '1', null, null, '2018-12-11 11:55:12', null, null, null, null, null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for `mem_member_role`
-- ----------------------------
DROP TABLE IF EXISTS `mem_member_role`;
CREATE TABLE `mem_member_role` (
  `ID` varchar(32) NOT NULL,
  `MEMBER_ID` varchar(32) DEFAULT NULL COMMENT '会员ID',
  `ROLE_ID` varchar(32) DEFAULT NULL COMMENT '会员用户的角色ID',
  PRIMARY KEY (`ID`),
  KEY `FK_MEM_MEMBER_ROLE_TO_MEM_MEMBER_idx` (`MEMBER_ID`),
  KEY `FK_MEM_MEMBER_ROLE_TO_MEM_ROLE_idx` (`ROLE_ID`),
  CONSTRAINT `FK_MEM_MEMBER_ROLE_TO_MEM_MEMBER` FOREIGN KEY (`MEMBER_ID`) REFERENCES `mem_member` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MEM_MEMBER_ROLE_TO_MEM_ROLE` FOREIGN KEY (`ROLE_ID`) REFERENCES `mem_role` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='会员与会员角色的中间表';

-- ----------------------------
-- Records of mem_member_role
-- ----------------------------

-- ----------------------------
-- Table structure for `mem_role`
-- ----------------------------
DROP TABLE IF EXISTS `mem_role`;
CREATE TABLE `mem_role` (
  `ID` varchar(32) NOT NULL,
  `NAME` varchar(32) DEFAULT NULL,
  `CODE` varchar(32) DEFAULT NULL,
  `STATUS` int(11) DEFAULT NULL,
  `TYPE` int(11) DEFAULT NULL,
  `IS_LOCKED` int(11) DEFAULT '0',
  `IS_VALID` int(11) DEFAULT '1',
  `SORT_NUM` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增序号',
  `CREATE_BY` varchar(32) DEFAULT NULL,
  `UPDATE_BY` varchar(32) DEFAULT NULL,
  `CREATE_TIME` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UPDATE_TIME` timestamp NULL DEFAULT NULL,
  `ICON` varchar(512) DEFAULT NULL,
  `DESCRIPTION` varchar(512) DEFAULT NULL,
  `DEPT_ID` varchar(32) DEFAULT NULL COMMENT '会员用户的部门ID，表明角色是属于哪个部门',
  PRIMARY KEY (`ID`),
  KEY `SORT_INDEX` (`SORT_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='会员角色';

-- ----------------------------
-- Records of mem_role
-- ----------------------------

-- ----------------------------
-- Table structure for `system_attament`
-- ----------------------------
DROP TABLE IF EXISTS `system_attament`;
CREATE TABLE `system_attament` (
  `ID` varchar(32) NOT NULL,
  `NAME` varchar(32) DEFAULT NULL,
  `CODE` varchar(32) DEFAULT NULL,
  `STATUS` int(11) DEFAULT NULL,
  `TYPE` int(11) DEFAULT NULL,
  `IS_LOCKED` int(11) DEFAULT '0',
  `IS_VALID` int(11) DEFAULT '1',
  `SORT_NUM` int(11) DEFAULT NULL,
  `CREATE_BY` varchar(32) DEFAULT NULL,
  `UPDATE_BY` varchar(32) DEFAULT NULL,
  `CREATE_TIME` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UPDATE_TIME` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `ICON` varchar(512) DEFAULT NULL,
  `PATH` varchar(512) DEFAULT NULL COMMENT '物理路径',
  `URL` varchar(512) DEFAULT NULL COMMENT 'web路径',
  `USER_ID` varchar(32) DEFAULT NULL COMMENT '用户ID',
  PRIMARY KEY (`ID`),
  KEY `USER_ID` (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='系统附件表';

-- ----------------------------
-- Records of system_attament
-- ----------------------------

-- ----------------------------
-- Table structure for `system_dept`
-- ----------------------------
DROP TABLE IF EXISTS `system_dept`;
CREATE TABLE `system_dept` (
  `ID` varchar(32) NOT NULL,
  `NAME` varchar(32) DEFAULT NULL,
  `CODE` varchar(32) DEFAULT NULL,
  `STATUS` int(11) DEFAULT NULL,
  `TYPE` int(11) DEFAULT NULL,
  `IS_LOCKED` int(11) DEFAULT '0',
  `IS_VALID` int(11) DEFAULT '1',
  `SORT_NUM` int(11) NOT NULL AUTO_INCREMENT,
  `CREATE_BY` varchar(32) DEFAULT NULL,
  `UPDATE_BY` varchar(32) DEFAULT NULL,
  `CREATE_TIME` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UPDATE_TIME` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `ICON` varchar(512) DEFAULT NULL,
  `PARENT_ID` varchar(32) DEFAULT NULL COMMENT '父类ID',
  `LEVEL` int(11) DEFAULT '0' COMMENT '层级',
  `IS_LEAF` tinyint(4) DEFAULT '1' COMMENT '是否为叶子',
  PRIMARY KEY (`ID`),
  KEY `FK_SYSTEM_DEPT_TO_SYSTEM_DEPT_idx` (`PARENT_ID`),
  KEY `SORT_INDEX` (`SORT_NUM`),
  CONSTRAINT `FK_SYSTEM_DEPT_TO_SYSTEM_DEPT` FOREIGN KEY (`PARENT_ID`) REFERENCES `system_dept` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='组织';

-- ----------------------------
-- Records of system_dept
-- ----------------------------

-- ----------------------------
-- Table structure for `system_log`
-- ----------------------------
DROP TABLE IF EXISTS `system_log`;
CREATE TABLE `system_log` (
  `ID` varchar(32) NOT NULL,
  `NAME` varchar(32) DEFAULT NULL,
  `SORT_NUM` int(11) NOT NULL AUTO_INCREMENT,
  `CREATE_BY` varchar(32) DEFAULT NULL,
  `UPDATE_BY` varchar(32) DEFAULT NULL,
  `CREATE_TIME` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UPDATE_TIME` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `DESCRIPTION` varchar(1024) DEFAULT NULL,
  `OPE_METHOD` varchar(45) DEFAULT NULL COMMENT '操作方法',
  `CONTENT` varchar(4096) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `SORT_INDEX` (`SORT_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='管理员系统操作日志';

-- ----------------------------
-- Records of system_log
-- ----------------------------

-- ----------------------------
-- Table structure for `system_resource`
-- ----------------------------
DROP TABLE IF EXISTS `system_resource`;
CREATE TABLE `system_resource` (
  `ID` varchar(32) NOT NULL,
  `NAME` varchar(32) DEFAULT NULL,
  `CODE` varchar(32) DEFAULT NULL,
  `STATUS` int(11) DEFAULT NULL,
  `TYPE` int(11) DEFAULT NULL,
  `IS_LOCKED` int(11) DEFAULT '0' COMMENT '0表示不锁定，1表示锁定',
  `IS_VALID` int(11) DEFAULT '1' COMMENT '0表示删除，1表示可用',
  `SORT_NUM` int(11) NOT NULL AUTO_INCREMENT,
  `CREATE_BY` varchar(32) DEFAULT NULL,
  `UPDATE_BY` varchar(32) DEFAULT NULL,
  `CREATE_TIME` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UPDATE_TIME` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `PARENT_ID` varchar(32) DEFAULT NULL COMMENT '父类ID',
  `ICON` varchar(512) DEFAULT NULL COMMENT '缩略图',
  `LEVEL` int(11) DEFAULT '0' COMMENT '层级',
  `IS_LEAF` tinyint(4) DEFAULT '1' COMMENT '是否为叶子',
  PRIMARY KEY (`ID`),
  KEY `SORT_INDEX` (`SORT_NUM`),
  KEY `FK_TB_RESOURCE_PARENT_ID_TO_TB_RESOURCE_idx` (`PARENT_ID`),
  CONSTRAINT `FK_SYSTEM_RESOURCE_TO_SYSTEM_RESOURCE` FOREIGN KEY (`PARENT_ID`) REFERENCES `system_resource` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COMMENT='系统资源';

-- ----------------------------
-- Records of system_resource
-- ----------------------------
INSERT INTO `system_resource` VALUES ('1', '1', null, null, null, '0', '1', '1', null, null, '2018-12-10 17:09:22', null, null, null, '0', '1');

-- ----------------------------
-- Table structure for `system_role`
-- ----------------------------
DROP TABLE IF EXISTS `system_role`;
CREATE TABLE `system_role` (
  `ID` varchar(32) NOT NULL,
  `NAME` varchar(32) DEFAULT NULL,
  `CODE` varchar(32) DEFAULT NULL,
  `STATUS` int(11) DEFAULT NULL,
  `TYPE` int(11) DEFAULT NULL,
  `IS_LOCKED` int(11) DEFAULT '0' COMMENT '0表示不锁定，1表示锁定',
  `IS_VALID` int(11) DEFAULT '1' COMMENT '0表示删除，1表示可用',
  `SORT_NUM` int(11) NOT NULL AUTO_INCREMENT,
  `CREATE_BY` varchar(32) DEFAULT NULL,
  `UPDATE_BY` varchar(32) DEFAULT NULL,
  `CREATE_TIME` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UPDATE_TIME` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `ICON` varchar(512) DEFAULT NULL COMMENT '缩略图',
  PRIMARY KEY (`ID`),
  KEY `sort_index` (`SORT_NUM`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COMMENT='角色';

-- ----------------------------
-- Records of system_role
-- ----------------------------
INSERT INTO `system_role` VALUES ('1', '1', null, null, null, '0', '1', '1', null, null, '2018-12-10 17:09:10', null, null);

-- ----------------------------
-- Table structure for `system_role_resource`
-- ----------------------------
DROP TABLE IF EXISTS `system_role_resource`;
CREATE TABLE `system_role_resource` (
  `ID` varchar(32) NOT NULL,
  `NAME` varchar(32) DEFAULT NULL,
  `CODE` varchar(32) DEFAULT NULL,
  `STATUS` int(11) DEFAULT NULL,
  `TYPE` int(11) DEFAULT NULL,
  `IS_LOCKED` int(11) DEFAULT NULL,
  `IS_VALID` int(11) DEFAULT '1' COMMENT '0表示删除，1表示可用',
  `SORT_NUM` int(11) DEFAULT NULL,
  `CREATE_BY` varchar(32) DEFAULT NULL,
  `UPDATE_BY` varchar(32) DEFAULT NULL,
  `CREATE_TIME` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UPDATE_TIME` timestamp NULL DEFAULT NULL,
  `ROLE_ID` varchar(32) DEFAULT NULL COMMENT '角色ID',
  `RESOURCE_ID` varchar(32) DEFAULT NULL COMMENT '角色ID',
  PRIMARY KEY (`ID`),
  KEY `FK_TB_ROLE_RESOURCE_RESOURCE_ID_TO_TB_RESOURCE_idx` (`RESOURCE_ID`),
  KEY `FK_TB_ROLE_RESOURCE_ROLE_ID_TO_TB_ROLE_idx` (`ROLE_ID`),
  CONSTRAINT `FK_TB_ROLE_RESOURCE_RESOURCE_ID_TO_TB_RESOURCE` FOREIGN KEY (`RESOURCE_ID`) REFERENCES `system_resource` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_TB_ROLE_RESOURCE_ROLE_ID_TO_TB_ROLE` FOREIGN KEY (`ROLE_ID`) REFERENCES `system_role` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='角色资源中间表';

-- ----------------------------
-- Records of system_role_resource
-- ----------------------------
INSERT INTO `system_role_resource` VALUES ('1', null, null, null, null, null, '1', null, null, null, '2018-12-10 17:09:36', null, '1', '1');

-- ----------------------------
-- Table structure for `system_user`
-- ----------------------------
DROP TABLE IF EXISTS `system_user`;
CREATE TABLE `system_user` (
  `ID` varchar(32) NOT NULL COMMENT '系统ID标识符',
  `NAME` varchar(32) DEFAULT NULL COMMENT '姓名',
  `CODE` varchar(32) DEFAULT NULL COMMENT '代码',
  `STATUS` varchar(32) DEFAULT NULL COMMENT '状态，待定',
  `TYPE` int(11) DEFAULT NULL COMMENT '类型',
  `IS_LOCKED` int(11) DEFAULT '0' COMMENT '是否被锁定，0不是，1是，默认不锁定',
  `IS_VALID` int(11) DEFAULT '1' COMMENT '是否删除，1是，0否',
  `SORT_NUM` int(11) NOT NULL AUTO_INCREMENT COMMENT '序号自增',
  `CREATE_BY` varchar(32) DEFAULT NULL COMMENT '创建人',
  `UPDATE_BY` varchar(32) DEFAULT NULL COMMENT '编辑人',
  `CREATE_TIME` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `UPDATE_TIME` datetime DEFAULT NULL COMMENT '编辑时间',
  `LOGIN_NAME` varchar(32) DEFAULT NULL COMMENT '登录名',
  `PASSWORD` varchar(64) DEFAULT NULL COMMENT '密码',
  `EMAIL` varchar(45) DEFAULT NULL COMMENT '邮箱',
  `ICON` varchar(512) DEFAULT NULL COMMENT '缩略图',
  `MOBILE` varchar(45) DEFAULT NULL COMMENT '电话',
  PRIMARY KEY (`ID`),
  KEY `SORT_INDEX` (`SORT_NUM`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COMMENT='系统用户';

-- ----------------------------
-- Records of system_user
-- ----------------------------
INSERT INTO `system_user` VALUES ('1', 'admin', null, null, null, '0', '1', '1', null, null, '2018-11-19 11:08:50', null, 'admin', '$2a$10$z94ioqXJvEcacuOxVJ2kG.RfcPczjuRgoYanQigPtGJ4kkr/Vl54W', null, null, '13926205227');

-- ----------------------------
-- Table structure for `system_user_role`
-- ----------------------------
DROP TABLE IF EXISTS `system_user_role`;
CREATE TABLE `system_user_role` (
  `ID` varchar(32) NOT NULL,
  `NAME` varchar(32) DEFAULT NULL,
  `CODE` varchar(32) DEFAULT NULL,
  `STATUS` int(11) DEFAULT NULL,
  `TYPE` int(11) DEFAULT NULL,
  `IS_LOCKED` int(11) DEFAULT '0',
  `IS_VALID` int(11) DEFAULT '1' COMMENT '0表示删除，1表示可用',
  `SORT_NUM` int(11) DEFAULT NULL,
  `CREATE_BY` varchar(32) DEFAULT NULL,
  `UPDATE_BY` varchar(32) DEFAULT NULL,
  `CREATE_TIME` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UPDATE_TIME` timestamp NULL DEFAULT NULL,
  `USER_ID` varchar(32) DEFAULT NULL COMMENT '用户ID',
  `ROLE_ID` varchar(32) DEFAULT NULL COMMENT '角色ID',
  PRIMARY KEY (`ID`),
  KEY `FK_USER_ID_TO_TB_USER_idx` (`USER_ID`),
  KEY `FK_ROLE_ID_TO_TB_ROLE_idx` (`ROLE_ID`),
  CONSTRAINT `FK_TB_USER_ROLE_ROLE_ID_TO_TB_ROLE` FOREIGN KEY (`ROLE_ID`) REFERENCES `system_role` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_TB_USER_ROLE_USER_ID_TO_TB_USER` FOREIGN KEY (`USER_ID`) REFERENCES `system_user` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='用户角色中间表';

-- ----------------------------
-- Records of system_user_role
-- ----------------------------
INSERT INTO `system_user_role` VALUES ('1', null, null, null, null, '0', '1', null, null, null, '2018-12-10 17:09:47', null, '1', '1');

-- ----------------------------
-- Function structure for `getArtCategoryChildren`
-- ----------------------------
DROP FUNCTION IF EXISTS `getArtCategoryChildren`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getArtCategoryChildren`(rootId varchar(1000)) RETURNS varchar(1000) CHARSET latin1
BEGIN
DECLARE sTemp VARCHAR(1000);

  DECLARE sTempChd VARCHAR(1000);

  SET sTemp = '$';

  SET sTempChd =cast(rootId as CHAR);

  WHILE sTempChd is not null DO

    SET sTemp = concat(sTemp,',',sTempChd);

SELECT 
    GROUP_CONCAT(id)
INTO sTempChd FROM
    Art_Category
WHERE
    FIND_IN_SET(parent_id, sTempChd) > 0; 
 
  END WHILE;

  RETURN sTemp;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `getArtCategoryParentList`
-- ----------------------------
DROP FUNCTION IF EXISTS `getArtCategoryParentList`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getArtCategoryParentList`(rootId varchar(1000)) RETURNS varchar(1000) CHARSET latin1
BEGIN
DECLARE sTemp VARCHAR(1000);

  DECLARE sTempChd VARCHAR(1000);

  SET sTemp = '$';

  SET sTempChd =cast(rootId as CHAR);

  WHILE sTempChd is not null DO

    SET sTemp = concat(sTemp,',',sTempChd);

    SELECT group_concat(parent_id) INTO sTempChd FROM Art_Category where FIND_IN_SET(id,sTempChd)>0;

  END WHILE;

  RETURN sTemp;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `getCmsCategoryChildren`
-- ----------------------------
DROP FUNCTION IF EXISTS `getCmsCategoryChildren`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getCmsCategoryChildren`(rootId varchar(1000)) RETURNS varchar(1000) CHARSET latin1
BEGIN
DECLARE sTemp VARCHAR(1000);

  DECLARE sTempChd VARCHAR(1000);

  SET sTemp = '$';

  SET sTempChd =cast(rootId as CHAR);

  WHILE sTempChd is not null DO

    SET sTemp = concat(sTemp,',',sTempChd);

SELECT 
    GROUP_CONCAT(id)
INTO sTempChd FROM
    Cms_Category
WHERE
    FIND_IN_SET(parent_id, sTempChd) > 0; 
 
  END WHILE;

  RETURN sTemp;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `getCmsCategoryParentList`
-- ----------------------------
DROP FUNCTION IF EXISTS `getCmsCategoryParentList`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getCmsCategoryParentList`(rootId varchar(1000)) RETURNS varchar(1000) CHARSET latin1
BEGIN
DECLARE sTemp VARCHAR(1000);

  DECLARE sTempChd VARCHAR(1000);

  SET sTemp = '$';

  SET sTempChd =cast(rootId as CHAR);

  WHILE sTempChd is not null DO

    SET sTemp = concat(sTemp,',',sTempChd);

    SELECT group_concat(parent_id) INTO sTempChd FROM Cms_Category where FIND_IN_SET(id,sTempChd)>0;

  END WHILE;

  RETURN sTemp;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `getDeptChildren`
-- ----------------------------
DROP FUNCTION IF EXISTS `getDeptChildren`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getDeptChildren`(rootId varchar(1000)) RETURNS varchar(1000) CHARSET latin1
BEGIN
DECLARE sTemp VARCHAR(1000);

  DECLARE sTempChd VARCHAR(1000);

  SET sTemp = '$';

  SET sTempChd =cast(rootId as CHAR);

  WHILE sTempChd is not null DO

    SET sTemp = concat(sTemp,',',sTempChd);

SELECT 
    GROUP_CONCAT(id)
INTO sTempChd FROM
    system_dept
WHERE
    FIND_IN_SET(parent_id, sTempChd) > 0; 
 
  END WHILE;

  RETURN sTemp;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `getDeptParentList`
-- ----------------------------
DROP FUNCTION IF EXISTS `getDeptParentList`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getDeptParentList`(rootId varchar(1000)) RETURNS varchar(1000) CHARSET latin1
BEGIN
DECLARE sTemp VARCHAR(1000);

  DECLARE sTempChd VARCHAR(1000);

  SET sTemp = '$';

  SET sTempChd =cast(rootId as CHAR);

  WHILE sTempChd is not null DO

    SET sTemp = concat(sTemp,',',sTempChd);

    SELECT group_concat(parent_id) INTO sTempChd FROM system_dept where FIND_IN_SET(id,sTempChd)>0;

  END WHILE;

  RETURN sTemp;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `getMemDeptChildren`
-- ----------------------------
DROP FUNCTION IF EXISTS `getMemDeptChildren`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getMemDeptChildren`(rootId varchar(1000)) RETURNS varchar(1000) CHARSET latin1
BEGIN
DECLARE sTemp VARCHAR(1000);

  DECLARE sTempChd VARCHAR(1000);

  SET sTemp = '$';

  SET sTempChd =cast(rootId as CHAR);

  WHILE sTempChd is not null DO

    SET sTemp = concat(sTemp,',',sTempChd);

SELECT 
    GROUP_CONCAT(id)
INTO sTempChd FROM
    Mem_Dept
WHERE
    FIND_IN_SET(parent_id, sTempChd) > 0; 
 
  END WHILE;

  RETURN sTemp;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `getMemDeptParentList`
-- ----------------------------
DROP FUNCTION IF EXISTS `getMemDeptParentList`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getMemDeptParentList`(rootId varchar(1000)) RETURNS varchar(1000) CHARSET latin1
BEGIN
DECLARE sTemp VARCHAR(1000);

  DECLARE sTempChd VARCHAR(1000);

  SET sTemp = '$';

  SET sTempChd =cast(rootId as CHAR);

  WHILE sTempChd is not null DO

    SET sTemp = concat(sTemp,',',sTempChd);

    SELECT group_concat(parent_id) INTO sTempChd FROM Mem_Dept where FIND_IN_SET(id,sTempChd)>0;

  END WHILE;

  RETURN sTemp;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `getProCategoryChildren`
-- ----------------------------
DROP FUNCTION IF EXISTS `getProCategoryChildren`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getProCategoryChildren`(rootId varchar(1000)) RETURNS varchar(1000) CHARSET latin1
BEGIN
DECLARE sTemp VARCHAR(1000);

  DECLARE sTempChd VARCHAR(1000);

  SET sTemp = '$';

  SET sTempChd =cast(rootId as CHAR);

  WHILE sTempChd is not null DO

    SET sTemp = concat(sTemp,',',sTempChd);

SELECT 
    GROUP_CONCAT(id)
INTO sTempChd FROM
    pro_category
WHERE
    FIND_IN_SET(parent_id, sTempChd) > 0; 
 
  END WHILE;

  RETURN sTemp;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `getProCategoryParentList`
-- ----------------------------
DROP FUNCTION IF EXISTS `getProCategoryParentList`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getProCategoryParentList`(rootId varchar(1000)) RETURNS varchar(1000) CHARSET latin1
BEGIN
DECLARE sTemp VARCHAR(1000);

  DECLARE sTempChd VARCHAR(1000);

  SET sTemp = '$';

  SET sTempChd =cast(rootId as CHAR);

  WHILE sTempChd is not null DO

    SET sTemp = concat(sTemp,',',sTempChd);

    SELECT group_concat(parent_id) INTO sTempChd FROM Pro_Category where FIND_IN_SET(id,sTempChd)>0;

  END WHILE;

  RETURN sTemp;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `getResourceChildren`
-- ----------------------------
DROP FUNCTION IF EXISTS `getResourceChildren`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getResourceChildren`(rootId varchar(1000)) RETURNS varchar(1000) CHARSET latin1
BEGIN
DECLARE sTemp VARCHAR(1000);

  DECLARE sTempChd VARCHAR(1000);

  SET sTemp = '$';

  SET sTempChd =cast(rootId as CHAR);

  WHILE sTempChd is not null DO

    SET sTemp = concat(sTemp,',',sTempChd);

SELECT 
    GROUP_CONCAT(id)
INTO sTempChd FROM
    system_resource
WHERE
    FIND_IN_SET(parent_id, sTempChd) > 0; 
 
  END WHILE;

  RETURN sTemp;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `getResourceParentList`
-- ----------------------------
DROP FUNCTION IF EXISTS `getResourceParentList`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getResourceParentList`(rootId varchar(1000)) RETURNS varchar(1000) CHARSET latin1
BEGIN
DECLARE sTemp VARCHAR(1000);

  DECLARE sTempChd VARCHAR(1000);

  SET sTemp = '$';

  SET sTempChd =cast(rootId as CHAR);

  WHILE sTempChd is not null DO

    SET sTemp = concat(sTemp,',',sTempChd);

    SELECT group_concat(parent_id) INTO sTempChd FROM system_resource where FIND_IN_SET(id,sTempChd)>0;

  END WHILE;

  RETURN sTemp;
END
;;
DELIMITER ;

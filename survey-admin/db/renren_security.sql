/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 80016
Source Host           : localhost:3306
Source Database       : renren_security

Target Server Type    : MYSQL
Target Server Version : 80016
File Encoding         : 65001

Date: 2019-06-17 13:58:26
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for answers
-- ----------------------------
DROP TABLE IF EXISTS `answers`;
CREATE TABLE `answers` (
  `answers_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '答题ID',
  `tests_id` bigint(20) NOT NULL COMMENT '测试ID',
  `questions_id` bigint(20) NOT NULL COMMENT '题目ID',
  `ansnumber` bigint(20) DEFAULT NULL COMMENT '所选答案',
  `anstime` varchar(50) DEFAULT NULL COMMENT '答题时间',
  PRIMARY KEY (`answers_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='答题管理';

-- ----------------------------
-- Records of answers
-- ----------------------------
INSERT INTO `answers` VALUES ('1', '1', '1', '11', 't1');
INSERT INTO `answers` VALUES ('2', '1', '2', '11', 't2');
INSERT INTO `answers` VALUES ('3', '2', '3', '1', 't3');
INSERT INTO `answers` VALUES ('4', '2', '4', '4', 't4');
INSERT INTO `answers` VALUES ('5', '3', '5', '4', null);
INSERT INTO `answers` VALUES ('6', '3', '6', '4', null);
INSERT INTO `answers` VALUES ('7', '4', '7', '44', null);
INSERT INTO `answers` VALUES ('8', '4', '8', '777', null);

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `BLOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `SCHED_NAME` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `CALENDAR_NAME` varchar(200) NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`CALENDAR_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `CRON_EXPRESSION` varchar(120) NOT NULL,
  `TIME_ZONE_ID` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------
INSERT INTO `qrtz_cron_triggers` VALUES ('RenrenScheduler', 'TASK_1', 'DEFAULT', '0 0/30 * * * ?', 'Asia/Shanghai');

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `ENTRY_ID` varchar(95) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `FIRED_TIME` bigint(13) NOT NULL,
  `SCHED_TIME` bigint(13) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) NOT NULL,
  `JOB_NAME` varchar(200) DEFAULT NULL,
  `JOB_GROUP` varchar(200) DEFAULT NULL,
  `IS_NONCONCURRENT` varchar(1) DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`ENTRY_ID`),
  KEY `IDX_QRTZ_FT_TRIG_INST_NAME` (`SCHED_NAME`,`INSTANCE_NAME`),
  KEY `IDX_QRTZ_FT_INST_JOB_REQ_RCVRY` (`SCHED_NAME`,`INSTANCE_NAME`,`REQUESTS_RECOVERY`),
  KEY `IDX_QRTZ_FT_J_G` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_FT_JG` (`SCHED_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_FT_T_G` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_FT_TG` (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) NOT NULL,
  `IS_DURABLE` varchar(1) NOT NULL,
  `IS_NONCONCURRENT` varchar(1) NOT NULL,
  `IS_UPDATE_DATA` varchar(1) NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) NOT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_J_REQ_RECOVERY` (`SCHED_NAME`,`REQUESTS_RECOVERY`),
  KEY `IDX_QRTZ_J_GRP` (`SCHED_NAME`,`JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------
INSERT INTO `qrtz_job_details` VALUES ('RenrenScheduler', 'TASK_1', 'DEFAULT', null, 'io.sipaimodules.job.utils.ScheduleJob', '0', '0', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B45597372002E696F2E72656E72656E2E6D6F64756C65732E6A6F622E656E746974792E5363686564756C654A6F62456E7469747900000000000000010200074C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7870740008746573745461736B7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000016ADEBB45007874000E3020302F3330202A202A202A203F7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000000000000174000672656E72656E74000CE58F82E695B0E6B58BE8AF95737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E0013000000007800);

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `LOCK_NAME` varchar(40) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`LOCK_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
INSERT INTO `qrtz_locks` VALUES ('RenrenScheduler', 'STATE_ACCESS');
INSERT INTO `qrtz_locks` VALUES ('RenrenScheduler', 'TRIGGER_ACCESS');

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`INSTANCE_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------
INSERT INTO `qrtz_scheduler_state` VALUES ('RenrenScheduler', 'RL-20190516XMQS1560731938394', '1560751107275', '15000');

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(10) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `STR_PROP_1` varchar(512) DEFAULT NULL,
  `STR_PROP_2` varchar(512) DEFAULT NULL,
  `STR_PROP_3` varchar(512) DEFAULT NULL,
  `INT_PROP_1` int(11) DEFAULT NULL,
  `INT_PROP_2` int(11) DEFAULT NULL,
  `LONG_PROP_1` bigint(20) DEFAULT NULL,
  `LONG_PROP_2` bigint(20) DEFAULT NULL,
  `DEC_PROP_1` decimal(13,4) DEFAULT NULL,
  `DEC_PROP_2` decimal(13,4) DEFAULT NULL,
  `BOOL_PROP_1` varchar(1) DEFAULT NULL,
  `BOOL_PROP_2` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) NOT NULL,
  `TRIGGER_TYPE` varchar(8) NOT NULL,
  `START_TIME` bigint(13) NOT NULL,
  `END_TIME` bigint(13) DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) DEFAULT NULL,
  `MISFIRE_INSTR` smallint(2) DEFAULT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_T_J` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_T_JG` (`SCHED_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_T_C` (`SCHED_NAME`,`CALENDAR_NAME`),
  KEY `IDX_QRTZ_T_G` (`SCHED_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_T_STATE` (`SCHED_NAME`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_N_STATE` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_N_G_STATE` (`SCHED_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_NEXT_FIRE_TIME` (`SCHED_NAME`,`NEXT_FIRE_TIME`),
  KEY `IDX_QRTZ_T_NFT_ST` (`SCHED_NAME`,`TRIGGER_STATE`,`NEXT_FIRE_TIME`),
  KEY `IDX_QRTZ_T_NFT_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`),
  KEY `IDX_QRTZ_T_NFT_ST_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_NFT_ST_MISFIRE_GRP` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------
INSERT INTO `qrtz_triggers` VALUES ('RenrenScheduler', 'TASK_1', 'DEFAULT', 'TASK_1', 'DEFAULT', null, '1560751200000', '1560749400000', '5', 'WAITING', 'CRON', '1558516315000', '0', null, '2', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B45597372002E696F2E72656E72656E2E6D6F64756C65732E6A6F622E656E746974792E5363686564756C654A6F62456E7469747900000000000000010200074C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7870740008746573745461736B7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000016ADEBB45007874000E3020302F3330202A202A202A203F7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000000000000174000672656E72656E74000CE58F82E695B0E6B58BE8AF95737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E0013000000007800);

-- ----------------------------
-- Table structure for questions
-- ----------------------------
DROP TABLE IF EXISTS `questions`;
CREATE TABLE `questions` (
  `questions_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '题目ID',
  `grade` varchar(50) DEFAULT NULL COMMENT '等级',
  `mainclass` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '分类',
  `subclass` varchar(50) DEFAULT NULL COMMENT '子域名称',
  `subweight` decimal(10,2) DEFAULT NULL COMMENT '子域权重',
  `question` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '题目名称',
  `quweight` decimal(10,2) DEFAULT NULL COMMENT '题目权重',
  `option1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '答案1',
  `option2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '答案2',
  `option3` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '答案3',
  `option4` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '答案4',
  PRIMARY KEY (`questions_id`)
) ENGINE=InnoDB AUTO_INCREMENT=220 DEFAULT CHARSET=utf8 COMMENT='题库管理';

-- ----------------------------
-- Records of questions
-- ----------------------------
INSERT INTO `questions` VALUES ('1', '规划级', '人员', '组织战略', '0.03', '企业是否有发展智能制造的战略愿景？', '0.50', '1', '2', '3', '4');
INSERT INTO `questions` VALUES ('2', '规划级', '人员', '组织战略', '0.03', '企业在发展智能制造方面的投资情况？', '0.50', '1', '2', '3', '4');
INSERT INTO `questions` VALUES ('3', '规划级', '人员', '人员技能', '0.03', '企业如何确认发展智能制造所需要的雇员能力？', '0.50', '1', '2', '3', '4');
INSERT INTO `questions` VALUES ('4', '规划级', '人员', '人员技能', '0.03', '企业内部雇员对于发展智能制造的意识？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('5', '规划级', '技术', '数据', '0.05', '企业数据的采集与分析方式？', '1.00', '选项 One', '选项 Two', '选项 Three', '选项 Four');
INSERT INTO `questions` VALUES ('6', '规划级', '技术', '集成', '0.03', '企业是否有系统集成的意识和需求？', '1.00', null, null, null, null);
INSERT INTO `questions` VALUES ('7', '规划级', '技术', '信息安全', '0.03', '企业是否建立信息安全制度、措施？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('8', '规划级', '技术', '信息安全', '0.03', '企业是否建立安全协调小组？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('9', '规划级', '资源', '装备', '0.03', '企业自动化设备的应用情况？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('10', '规划级', '资源', '装备', '0.03', '企业的关键工序设备是否形成了技改方案？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('11', '规划级', '资源', '网络', '0.03', '企业内办公网络覆盖比率是多少？', '1.00', null, null, null, null);
INSERT INTO `questions` VALUES ('12', '规划级', '设计', '产品设计', '0.05', '产品设计是否在计算机辅助设计平台上完成？', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('13', '规划级', '设计', '产品设计', '0.05', '产品设计环节是否具有相关标准规范？', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('14', '规划级', '设计', '产品设计', '0.05', '是否对产品设计进行推理验证？', '0.34', null, null, null, null);
INSERT INTO `questions` VALUES ('15', '规划级', '设计', '工艺设计', '0.05', '企业开展工艺规划及工艺设计的方式?', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('16', '规划级', '设计', '工艺设计', '0.05', '如何确保工艺设计和产品设计数据的一致性？', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('17', '规划级', '设计', '工艺设计', '0.05', '如何确保工艺设计的合理性和有效性？', '0.34', null, null, null, null);
INSERT INTO `questions` VALUES ('18', '规划级', '生产', '采购', '0.05', '是否具有采购基础流程和采购计划？', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('19', '规划级', '生产', '采购', '0.05', '是否具有采购订单、采购合同以及跟踪记录？', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('20', '规划级', '生产', '采购', '0.05', '是否建立合格供应商评选机制？', '0.34', null, null, null, null);
INSERT INTO `questions` VALUES ('21', '规划级', '生产', '计划与调度', '0.06', '主生产计划的编制是否基于销售订单和预测等信息？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('22', '规划级', '生产', '计划与调度', '0.06', '如何制定详细的生产作业计划？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('23', '规划级', '生产', '生产作业', '0.06', '企业是否具有生产作业相关工艺文件和作业指导书？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('24', '规划级', '生产', '生产作业', '0.06', '是否实现生产过程中关键件、关键工艺信息以及过程信息可采集？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('25', '规划级', '生产', '设备管理', '0.05', '设备管理制度？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('26', '规划级', '生产', '设备管理', '0.05', '设备点检与巡检方式？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('27', '规划级', '生产', '安全与环保', '0.05', '企业是否制定了安全管理机制和环保管理机制， 具备安全和环保操作规程？', '1.00', null, null, null, null);
INSERT INTO `questions` VALUES ('28', '规划级', '生产', '仓储与配送', '0.05', '是否具有仓库管理系统实现出入库管理、盘点和安全库存等功能？', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('29', '规划级', '生产', '仓储与配送', '0.05', '是否具有管理分类和认证规范实现仓储合理管理？', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('30', '规划级', '生产', '仓储与配送', '0.05', '是否能跟踪记录原材料和中间产品配送？', '0.34', null, null, null, null);
INSERT INTO `questions` VALUES ('31', '规划级', '生产', '能源管理', '0.05', '企业是否建立了能源管理制度？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('32', '规划级', '生产', '能源管理', '0.05', '企业是否对主要能源数据进行采集和计量？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('33', '规划级', '物流', '物流', '0.10', '是否通过信息化手段管理运输计划和配置调度？', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('34', '规划级', '物流', '物流', '0.10', '是否实现对物流信息的简单跟踪？', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('35', '规划级', '物流', '物流', '0.10', '是否对车辆和驾驶员进行统一管理（车辆基础信息、维修保养信息、驾驶员信息）？', '0.34', null, null, null, null);
INSERT INTO `questions` VALUES ('36', '规划级', '销售', '销售', '0.10', '是否通过信息化手段统计分销计划，形成销售计划？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('37', '规划级', '销售', '销售', '0.10', '否通过信息系统实现对销售订单、分销商和客户静态信息管理？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('38', '规划级', '服务', '客户服务', '0.05', '是否设立客户服务部门，制定客户信息收集、处理的程序和方法？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('39', '规划级', '服务', '客户服务', '0.05', '是否通过信息化手段记录客户服务过程？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('40', '规划级', '服务', '产品服务', '0.05', '是否设立产品服务部门，提供现场服务？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('41', '规划级', '服务', '产品服务', '0.05', '是否通过信息化手段记录维修服务过程？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('42', '规范级', '人员', '组织战略', '0.03', '企业有关智能制造发展战略的规划？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('43', '规范级', '人员', '组织战略', '0.03', '企业是否建立发展智能制造的责任部分和岗位责任人？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('44', '规范级', '人员', '人员技能', '0.03', '企业是否具备发展智能制造所需的人员队伍和人才储备？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('45', '规范级', '人员', '人员技能', '0.03', '企业如何开展智能制造人员的培训与考核工作？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('46', '规范级', '技术', '数据', '0.05', '企业数据的采集与分析方式？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('47', '规范级', '技术', '数据', '0.05', '企业业务数据在本部门内传递和共享方式？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('48', '规范级', '技术', '集成', '0.03', '是否有完整的系统集成架构规划方案？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('49', '规范级', '技术', '集成', '0.03', '是否实现应用软件间的集成？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('50', '规范级', '技术', '信息安全', '0.03', '是否定期开展信息系统的安全风险评估？', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('51', '规范级', '技术', '信息安全', '0.03', '是否制定针对工控主机的安全管理方法？', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('52', '规范级', '技术', '信息安全', '0.03', '是否制定并定期更新系统维护仿真策略与规程？', '0.34', null, null, null, null);
INSERT INTO `questions` VALUES ('53', '规范级', '资源', '装备', '0.03', '企业数字化设备的应用情况', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('54', '规范级', '资源', '装备', '0.03', '企业关键工序设备是够具备设备联网条件？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('55', '规范级', '资源', '网络', '0.03', '企业工业控制网络和生产区域网络覆盖率是多少？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('56', '规范级', '资源', '网络', '0.03', '企业对网络的管理方式？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('57', '规范级', '设计', '产品设计', '0.05', '产品设计是否实现计算机辅助三维设计？', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('58', '规范级', '设计', '产品设计', '0.05', '设计过程中对产品数据或文档的结构化管理和数据共享如何实现？', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('59', '规范级', '设计', '产品设计', '0.05', '是否建立产品设计内部（组件之间或者专业之间）协同机制？', '0.34', null, null, null, null);
INSERT INTO `questions` VALUES ('60', '规范级', '设计', '工艺设计', '0.05', '是否具有工艺设计规范和标准，可指导计算机辅助工艺规划及工艺设计？', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('61', '规范级', '设计', '工艺设计', '0.05', '是否有产品的典型工艺模板？', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('62', '规范级', '设计', '工艺设计', '0.05', '工艺设计与工装设计、工具设计等内部协同的应用情况?', '0.34', null, null, null, null);
INSERT INTO `questions` VALUES ('63', '规范级', '生产', '采购', '0.05', '采购流程是否规范化管理，基于生产计划和物料需求计划制定采购计划？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('64', '规范级', '生产', '采购', '0.05', '是否通过信息系统实现采购管理和供应商信息管理？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('65', '规范级', '生产', '计划与调度', '0.06', '是否用信息系统生成主生产计划？', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('66', '规范级', '生产', '计划与调度', '0.06', '是否实现MRP（物料需求计划）运算？', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('67', '规范级', '生产', '计划与调度', '0.06', '如何编制详细生产作业计划？', '0.34', null, null, null, null);
INSERT INTO `questions` VALUES ('68', '规范级', '生产', '生产作业', '0.06', '是否能够通过信息技术手段及时传输和下发与生产相关的图纸、工艺文件、作业指导书、配方等图文资料到各生产单元？', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('69', '规范级', '生产', '生产作业', '0.06', '是否实现了生产过程中对关键物料、设备（MES系统）、人员等资源信息自动采集，并上传到信息系统？', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('70', '规范级', '生产', '生产作业', '0.06', '关键工位生产工序是否利用自动化监测设备，产品关键过程的质量数据是否可以进行追溯？', '0.34', null, null, null, null);
INSERT INTO `questions` VALUES ('71', '规范级', '生产', '设备管理', '0.05', '企业如何进行设备维修保养和维修过程管理？', '1.00', null, null, null, null);
INSERT INTO `questions` VALUES ('72', '规范级', '生产', '安全与环保', '0.05', '是否采用信息化手段对员工职业健康和安全作业进行全面管理？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('73', '规范级', '生产', '安全与环保', '0.05', '企业污染物排放点是否在线实时监控?', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('74', '规范级', '生产', '仓储与配送', '0.05', '是否具有统一条码管理标识货物，使用网络设备实现自动和半自动出入库管理？', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('75', '规范级', '生产', '仓储与配送', '0.05', '具有仓储管理系统、货物管理模型，比如ABC算法模型？', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('76', '规范级', '生产', '仓储与配送', '0.05', '能否基于信息系统实现实际物料情况发起配送请求并提示及时配送？', '0.34', null, null, null, null);
INSERT INTO `questions` VALUES ('77', '规范级', '生产', '能源管理', '0.05', '是否建立起能源供应、转换、输配和消耗的能流体系？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('78', '规范级', '生产', '能源管理', '0.05', '是否具备建设能源介质主要生产、输送、消耗环节进行监测和预警的能力？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('79', '规范级', '物流', '物流', '0.10', '是否采用信息系统管理物流运输订单？', '0.25', null, null, null, null);
INSERT INTO `questions` VALUES ('80', '规范级', '物流', '物流', '0.10', '是否通过信息系统管理运输计划和调度管理？', '0.25', null, null, null, null);
INSERT INTO `questions` VALUES ('81', '规范级', '物流', '物流', '0.10', '是否实现对关键节点物流信息的跟踪？', '0.25', null, null, null, null);
INSERT INTO `questions` VALUES ('82', '规范级', '物流', '物流', '0.10', '是否通过信息系统实现运力资源管理等功能？', '0.25', null, null, null, null);
INSERT INTO `questions` VALUES ('83', '规范级', '销售', '销售', '0.10', '是否采用信息系统实现分销计划、销售计划的管理？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('84', '规范级', '销售', '销售', '0.10', '是否通过信息系统实现销售管理、分销管理和客户关系管理？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('85', '规范级', '服务', '客户服务', '0.05', '是否建立规范化服务体系，设立客户反馈渠道，建立服务满意度评价制度？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('86', '规范级', '服务', '客户服务', '0.05', '是否建立客户服务平台，实现客户服务管理？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('87', '规范级', '服务', '产品服务', '0.05', '是否建立规范化产品服务制度，提供线上线下远程指导服务？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('88', '规范级', '服务', '产品服务', '0.05', '是否建立信息平台，实现产品服务管理？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('89', '集成级', '人员', '组织战略', '0.03', '企业战略实施过程中是否进行战略评审？', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('90', '集成级', '人员', '组织战略', '0.03', '在发展智能制造过程中，企业是否对现有岗位结构和职责进行管理与调整？', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('91', '集成级', '人员', '组织战略', '0.03', '企业内部实施创新管理的情况？', '0.34', null, null, null, null);
INSERT INTO `questions` VALUES ('92', '集成级', '人员', '人员技能', '0.03', '为使企业员工具有持续创新精神，企业如何进行技术创新和管理创新？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('93', '集成级', '人员', '人员技能', '0.03', '如何对人员的经验和知识进行管理？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('94', '集成级', '技术', '数据', '0.05', '是否建立统一数据平台管理数据？', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('95', '集成级', '技术', '数据', '0.05', '企业对数据的采集与分析方式？', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('96', '集成级', '技术', '数据', '0.05', '企业业务数据跨部门间的传递和共享方式？', '0.34', null, null, null, null);
INSERT INTO `questions` VALUES ('97', '集成级', '技术', '集成', '0.03', '设备层现场设备是否通过信息系统集成？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('98', '集成级', '技术', '集成', '0.03', '应用软件间的集成方式？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('99', '集成级', '技术', '信息安全', '0.03', '企业的工业控制网络是否具有边界防护能力？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('100', '集成级', '技术', '信息安全', '0.03', '企业的工业控制设备的远程访问是否具有安全管理和加固？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('101', '集成级', '资源', '装备', '0.03', '企业设备是否具备良好了人机交互界面和远程配置能力？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('102', '集成级', '资源', '装备', '0.03', '企业对关键工序的设备三维模型库是否建立？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('103', '集成级', '资源', '网络', '0.03', '网络是否支持灵活扩展、升级？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('104', '集成级', '资源', '网络', '0.03', '企业如何进行网络安全防护？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('105', '集成级', '设计', '产品设计', '0.05', '是否有产品组件的标准库？', '0.20', null, null, null, null);
INSERT INTO `questions` VALUES ('106', '集成级', '设计', '产品设计', '0.05', '是否有产品设计的知识库？', '0.20', null, null, null, null);
INSERT INTO `questions` VALUES ('107', '集成级', '设计', '产品设计', '0.05', '三维模型是否集成产品设计信息（尺寸、公差、工程说明、材料需求等）（可取舍）', '0.20', null, null, null, null);
INSERT INTO `questions` VALUES ('108', '集成级', '设计', '产品设计', '0.05', '是否建立三维仿真模型，并进行仿真优化？', '0.20', null, null, null, null);
INSERT INTO `questions` VALUES ('109', '集成级', '设计', '产品设计', '0.05', '产品设计过程中是否与工艺协同？', '0.20', null, null, null, null);
INSERT INTO `questions` VALUES ('110', '集成级', '设计', '工艺设计', '0.05', '工艺设计关键要素的知识库建立及应用情况', '0.25', null, null, null, null);
INSERT INTO `questions` VALUES ('111', '集成级', '设计', '工艺设计', '0.05', '工艺设计与管理系统的应用情况', '0.25', null, null, null, null);
INSERT INTO `questions` VALUES ('112', '集成级', '设计', '工艺设计', '0.05', '是否实现基于三维模型的制造工艺关键环节的仿真优化？', '0.25', null, null, null, null);
INSERT INTO `questions` VALUES ('113', '集成级', '设计', '工艺设计', '0.05', '是否实现工艺设计和产品设计协同？', '0.25', null, null, null, null);
INSERT INTO `questions` VALUES ('114', '集成级', '生产', '采购', '0.05', '是否通过企业级系统与车间级、仓库级系统的集成，实现采购计划自动生成，计划、流水、库存、单据的同步？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('115', '集成级', '生产', '采购', '0.05', '是否通过信息系统开展供应商量化评价？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('116', '集成级', '生产', '计划与调度', '0.06', '系统是否能自动生成详细生产作业计划？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('117', '集成级', '生产', '计划与调度', '0.06', '系统能否自动预警和分析调度排产后的异常（如：生产延时、产能不足）情况，系统并并支持人工方法对异常的调整？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('118', '集成级', '生产', '生产作业', '0.06', '是否有生产单元电子看板（自动获取并显示相关的图纸、工艺文件、作业指导书、配方等图文资料）？', '0.25', null, null, null, null);
INSERT INTO `questions` VALUES ('119', '集成级', '生产', '生产作业', '0.06', '生产过程是否全流程数据记录并可追溯？（通过对作业数据收集的完整性）', '0.25', null, null, null, null);
INSERT INTO `questions` VALUES ('120', '集成级', '生产', '生产作业', '0.06', '是否能够实时分析生产过程结果报告，并在电子看板中显示？', '0.25', null, null, null, null);
INSERT INTO `questions` VALUES ('121', '集成级', '生产', '生产作业', '0.06', '自动化监测设备与现有系统集成情况，对质量的数据的分析利用程度？', '0.25', null, null, null, null);
INSERT INTO `questions` VALUES ('122', '集成级', '生产', '设备管理', '0.05', '设备数据是否进行采集与分析？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('123', '集成级', '生产', '设备管理', '0.05', '企业在设备故障闭环管理的工作情况?', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('124', '集成级', '生产', '安全与环保', '0.05', '是否建立典型安全技能培训、风险管理、职业健康等知识库？', '0.25', null, null, null, null);
INSERT INTO `questions` VALUES ('125', '集成级', '生产', '安全与环保', '0.05', '是否通过移动技术实现安全作业现场管理？', '0.25', null, null, null, null);
INSERT INTO `questions` VALUES ('126', '集成级', '生产', '安全与环保', '0.05', '是否集中展示企业污染物排放点信息？', '0.25', null, null, null, null);
INSERT INTO `questions` VALUES ('127', '集成级', '生产', '安全与环保', '0.05', '是否引用典型应急指挥中心实现对突发及时响应？', '0.25', null, null, null, null);
INSERT INTO `questions` VALUES ('128', '集成级', '生产', '仓储与配送', '0.05', '是否具有数字化仓储设备能够根据实际生产计划实现无人或少人化自动出入库管理？', '0.25', null, null, null, null);
INSERT INTO `questions` VALUES ('129', '集成级', '生产', '仓储与配送', '0.05', '仓库管理系统是否与ERP、MES、供应链管理系统实现数据同步？', '0.25', null, null, null, null);
INSERT INTO `questions` VALUES ('130', '集成级', '生产', '仓储与配送', '0.05', '是否有电子看板系统实时显示仓位、分拣和配送情况？', '0.25', null, null, null, null);
INSERT INTO `questions` VALUES ('131', '集成级', '生产', '仓储与配送', '0.05', '是否有数字化设备（AGV、桁车等）或配送人员和信息系统集成实施关键件及时配送？', '0.25', null, null, null, null);
INSERT INTO `questions` VALUES ('132', '集成级', '生产', '能源管理', '0.05', '是否具备实现能流、能耗的动态监控及能源集中统一管理，以便优化利用的能力？', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('133', '集成级', '生产', '能源管理', '0.05', '是否有优化方案及实操效益报告？', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('134', '集成级', '生产', '能源管理', '0.05', '是否实现活动数据计算、碳排统计信息化管理？', '0.34', null, null, null, null);
INSERT INTO `questions` VALUES ('135', '集成级', '物流', '物流', '0.10', '是否将运输管理系统与仓储管理系统集成，整合出库和运输过程？', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('136', '集成级', '物流', '物流', '0.10', '是否支持拼单、拆单等功能并实现多式联运？', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('137', '集成级', '物流', '物流', '0.10', '是否实现对关键节点物流信息的实时跟踪？', '0.34', null, null, null, null);
INSERT INTO `questions` VALUES ('138', '集成级', '销售', '销售', '0.10', '是否将销售系统与仓储管理系统、生产系统集成，实现客户需求预测/客户实际需求拉动生产、采购和物流计划？', '1.00', null, null, null, null);
INSERT INTO `questions` VALUES ('139', '集成级', '服务', '客户服务', '0.05', '是否建立客户服务知识库、云平台并与客户关系管理系统集成？', '1.00', null, null, null, null);
INSERT INTO `questions` VALUES ('140', '集成级', '服务', '产品服务', '0.05', '是否建立客户服务知识库、云平台并与客户关系管理系统集成？', '1.00', null, null, null, null);
INSERT INTO `questions` VALUES ('141', '优化级', '人员', '人员技能', '0.03', '企业如何对员工的知识、经验进行管理？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('142', '优化级', '人员', '人员技能', '0.03', '企业如何管理培训文档、资料和人员经验知识？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('143', '优化级', '技术', '数据', '0.05', '企业对数据的统一管理程度？', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('144', '优化级', '技术', '数据', '0.05', '企业对数据模型的应用程度', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('145', '优化级', '技术', '数据', '0.05', '是否建立数据模型对不同业务环节（研发设计、生产制造、产品服务等）的数据（如业务环节数据、机器数据、外部互联网数据等）进行管理？', '0.34', null, null, null, null);
INSERT INTO `questions` VALUES ('146', '优化级', '技术', '集成', '0.03', '是否建立企业服务总线和操作数据存储系统，实现企业内纵向的实时共享与交互协作？ ', '1.00', null, null, null, null);
INSERT INTO `questions` VALUES ('147', '优化级', '技术', '信息安全', '0.03', '是否部署了对工业控制系统安全防护设备？', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('148', '优化级', '技术', '信息安全', '0.03', '是否建立离线的测试环境，对工业控制设备进行安全性测试？', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('149', '优化级', '技术', '信息安全', '0.03', '是否采用了自学习、自优化功能的安全防护措施？', '0.34', null, null, null, null);
INSERT INTO `questions` VALUES ('150', '优化级', '资源', '装备', '0.03', '关键工序设备是否具备预测性维护功能？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('151', '优化级', '资源', '装备', '0.03', '企业是否建立了设备级的信息物理系统（CPS）？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('152', '优化级', '资源', '网络', '0.03', '企业在网络智能化建设方面工作成果？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('153', '优化级', '资源', '网络', '0.03', '网络资源的服务化情况？ ', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('154', '优化级', '设计', '产品设计', '0.05', '产品设计是否实现参数化、模块化？', '0.25', null, null, null, null);
INSERT INTO `questions` VALUES ('155', '优化级', '设计', '产品设计', '0.05', '将产品的全生命周期信息（设计信息、制造信息、检验信息、运维信息、销售信息、服务信息）集成于产品的三维数字化模型中？ ', '0.25', null, null, null, null);
INSERT INTO `questions` VALUES ('156', '优化级', '设计', '产品设计', '0.05', '是否实现对产品外观、结构、性能等全维度的仿真优化？', '0.25', null, null, null, null);
INSERT INTO `questions` VALUES ('157', '优化级', '设计', '产品设计', '0.05', '是否实现设计、制造、检验、物流、销售、服务等业务之间的协同？', '0.25', null, null, null, null);
INSERT INTO `questions` VALUES ('158', '优化级', '设计', '工艺设计', '0.05', '基于三维模型集成的工艺信息范围', '0.25', null, null, null, null);
INSERT INTO `questions` VALUES ('159', '优化级', '设计', '工艺设计', '0.05', '知识库在工艺规划及工艺设计中的应用情况', '0.25', null, null, null, null);
INSERT INTO `questions` VALUES ('160', '优化级', '设计', '工艺设计', '0.05', '是否实现基于三维模型的制造工艺全流程仿真优化？', '0.25', null, null, null, null);
INSERT INTO `questions` VALUES ('161', '优化级', '设计', '工艺设计', '0.05', '是否实现工艺设计和制造协同？', '0.25', null, null, null, null);
INSERT INTO `questions` VALUES ('162', '优化级', '生产', '采购', '0.05', '是否建立电子商务平台，并与企业级系统和供货商管理系统集成，实现采购交易可视化?', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('163', '优化级', '生产', '采购', '0.05', '与重要合作企业实现了部分的数据共享，进行联合预测补货?', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('164', '优化级', '生产', '采购', '0.05', '是否通过数据模型开展供应商量化评价？', '0.34', null, null, null, null);
INSERT INTO `questions` VALUES ('165', '优化级', '生产', '计划与调度', '0.06', '系统是否能够通过建立数学模型，采用先进排产调度的算法，自动给出满足多种约束条件、优化的排产方案，形成最优的详细生产作业计划？', '1.00', null, null, null, null);
INSERT INTO `questions` VALUES ('166', '优化级', '生产', '生产作业', '0.06', '生产作业是否通过信息系统集成查看三维作业指导书、数字化设备能根据下发指令自动完成生产并反馈过程信息到信息系统？', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('167', '优化级', '生产', '生产作业', '0.06', '生产作业过程是否能够通过自动采集作业数据优化过程模型并调整生产作业？ ', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('168', '优化级', '生产', '生产作业', '0.06', '是否能够向相关人员提供现场管理决策（如：错误提醒、分析报表以及资质培训建议等）？', '0.34', null, null, null, null);
INSERT INTO `questions` VALUES ('169', '优化级', '生产', '设备管理', '0.05', '设备采集数据的分析利用程度？', '1.00', null, null, null, null);
INSERT INTO `questions` VALUES ('170', '优化级', '生产', '安全与环保', '0.05', '是否应用数据分析模型开展排放分析和预测预警？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('171', '优化级', '生产', '安全与环保', '0.05', '是否通过信息系统实现安全作业与风险管控综合管理？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('172', '优化级', '生产', '仓储与配送', '0.05', '是否有定制化工装实现原材料、中间品、成品自动识别和出入库？', '0.25', null, null, null, null);
INSERT INTO `questions` VALUES ('173', '优化级', '生产', '仓储与配送', '0.05', '是否有自动化和信息化系统实现材料、中间品、成品防呆防错？', '0.25', null, null, null, null);
INSERT INTO `questions` VALUES ('174', '优化级', '生产', '仓储与配送', '0.05', '是否有通过信息系统集成实现生产计划、采购管理、成本管理等信息共享，实现人工、成本和时间最优决策，通过电子看板展现优化结果？', '0.25', null, null, null, null);
INSERT INTO `questions` VALUES ('175', '优化级', '生产', '仓储与配送', '0.05', '是否实现关键工位根据实际生产计划”拉式”物料配送？', '0.25', null, null, null, null);
INSERT INTO `questions` VALUES ('176', '优化级', '生产', '能源管理', '0.05', '是否实现能源管理各个环节的闭环管理？ ', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('177', '优化级', '生产', '能源管理', '0.05', '是否有能源管理体系？', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('178', '优化级', '生产', '能源管理', '0.05', '是否实现碳资产各个环节的闭环管理？ ', '0.34', null, null, null, null);
INSERT INTO `questions` VALUES ('179', '优化级', '物流', '物流', '0.10', '是否对订单作业每一个环节进行时效设定、时效监控以及KPI分析考核？', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('180', '优化级', '物流', '物流', '0.10', '是否根据模型优化引擎算出最佳配送线路？', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('181', '优化级', '物流', '物流', '0.10', '是否实现对货物的实时定位与监测？', '0.34', null, null, null, null);
INSERT INTO `questions` VALUES ('182', '优化级', '销售', '销售', '0.10', '是否建立电子商务平台，并与企业级信息系统集成？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('183', '优化级', '销售', '销售', '0.10', '是否通过客户知识挖掘、预测分析和机器学习等优化销售预测？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('184', '优化级', '服务', '客户服务', '0.05', '是否提供移动客户端等客服方式？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('185', '优化级', '服务', '客户服务', '0.05', '是否实现面向客户的精细化知识管理？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('186', '优化级', '服务', '产品服务', '0.05', '是否实现面向客户的精细化知识管理？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('187', '优化级', '服务', '产品服务', '0.05', '是否提供移动客户端等客服方式？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('188', '引领级', '技术', '数据', '0.05', '是否对现有数据模型进行实时优化与更新？', '1.00', null, null, null, null);
INSERT INTO `questions` VALUES ('189', '引领级', '设计', '产品设计', '0.05', '是否具备个性化定制的接口与能力？', '0.25', null, null, null, null);
INSERT INTO `questions` VALUES ('190', '引领级', '设计', '产品设计', '0.05', '是否针对产品全生命周期的不同环节构建相应的三维业务模型？', '0.25', null, null, null, null);
INSERT INTO `questions` VALUES ('191', '引领级', '设计', '产品设计', '0.05', '能否基于产品标准库和设计知识库的实现全维度（外观、结构、性能等）产品自动优化设计？', '0.25', null, null, null, null);
INSERT INTO `questions` VALUES ('192', '引领级', '设计', '产品设计', '0.05', '能否基于云服务平台，进行产品设计周期动态管理，实现与用户实时交互、协同？', '0.25', null, null, null, null);
INSERT INTO `questions` VALUES ('193', '引领级', '设计', '工艺设计', '0.05', '是否实现基于知识库辅助工艺创新推理及在线自主优化？', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('194', '引领级', '设计', '工艺设计', '0.05', '是否实现设计、工艺、制造、检验、运维等信息动态协同？', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('195', '引领级', '设计', '工艺设计', '0.05', '是否实现多领域、多区域、跨平台的全面协同？', '0.34', null, null, null, null);
INSERT INTO `questions` VALUES ('196', '引领级', '生产', '采购', '0.05', '新一代信息技术在采购业务的应用情况？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('197', '引领级', '生产', '采购', '0.05', '是否与所有供应链合作企业实现数据共享?', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('198', '引领级', '生产', '计划与调度', '0.06', '是否建立基于智能算法并融合人工智能动态调整算法的新一代高级计划与高级排产系统？', '1.00', null, null, null, null);
INSERT INTO `questions` VALUES ('199', '引领级', '生产', '生产作业', '0.06', '能否基于云计算和大数据技术实现生产作业全过程虚拟化生产，满足个性化、柔性化生产需求？', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('200', '引领级', '生产', '生产作业', '0.06', '是否具有生产指挥中心可视化监控生产作业现场和指导生产作业？，', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('201', '引领级', '生产', '生产作业', '0.06', '能否利用智能设备、互联网、云计算和大数据技术实现生产作业全过程无人化或少人化生产？', '0.34', null, null, null, null);
INSERT INTO `questions` VALUES ('202', '引领级', '生产', '设备管理', '0.05', '设备智能化管理技术的应用', '1.00', null, null, null, null);
INSERT INTO `questions` VALUES ('203', '引领级', '生产', '安全与环保', '0.05', '是否基于知识库支持安全作业分析与决策，实现安全作业与风险管控一体化管理？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('204', '引领级', '生产', '安全与环保', '0.05', '是否应用数据模型实现对生产排放方案的优化和执行？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('205', '引领级', '生产', '仓储与配送', '0.05', '是否实现实际生产实现全流程自主实时物料分拣和配送？', '0.17', null, null, null, null);
INSERT INTO `questions` VALUES ('206', '引领级', '生产', '仓储与配送', '0.05', '是否能够运用大数据和云计算技术实现与计划和排产、生产作业、供应链集成优化，实现最优库存或即时供货？', '0.17', null, null, null, null);
INSERT INTO `questions` VALUES ('207', '引领级', '生产', '仓储与配送', '0.05', '是否有核心分拣算法和智能物流算法优化满足个性化、柔性化生产实时配送需求？', '0.17', null, null, null, null);
INSERT INTO `questions` VALUES ('208', '引领级', '生产', '仓储与配送', '0.05', '是否实现能流的人工智能自动运行？', '0.16', null, null, null, null);
INSERT INTO `questions` VALUES ('209', '引领级', '生产', '仓储与配送', '0.05', '是否实现自动分析预警，并给出智能优化方案？', '0.16', null, null, null, null);
INSERT INTO `questions` VALUES ('210', '引领级', '生产', '仓储与配送', '0.05', '是否实现对主要设备的排放量和排放强度超标进行主动的预测预警能力？', '0.17', null, null, null, null);
INSERT INTO `questions` VALUES ('211', '引领级', '生产', '能源管理', '0.05', '是否实现能流的人工智能自动运行？', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('212', '引领级', '生产', '能源管理', '0.05', '是否实现自动分析预警，并给出智能优化方案？', '0.33', null, null, null, null);
INSERT INTO `questions` VALUES ('213', '引领级', '生产', '能源管理', '0.05', '是否实现对主要设备的排放量和排放强度超标进行主动的预测预警能力？', '0.34', null, null, null, null);
INSERT INTO `questions` VALUES ('214', '引领级', '物流', '物流', '0.10', '是否实现无人机等运输方式？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('215', '引领级', '物流', '物流', '0.10', '是否实现物流过程全程全方位可视化？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('216', '引领级', '销售', '销售', '0.10', '是否应用大数据、云计算等技术，对电子商务平台数据进行建模分析？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('217', '引领级', '销售', '销售', '0.10', '电子商务平台是否具有个性化营销功能？', '0.50', null, null, null, null);
INSERT INTO `questions` VALUES ('218', '引领级', '服务', '客户服务', '0.05', '是否具有智能客服机器人？', '1.00', null, null, null, null);
INSERT INTO `questions` VALUES ('219', '引领级', '服务', '产品服务', '0.05', '是否具有智能客服机器人？', '1.00', null, null, null, null);

-- ----------------------------
-- Table structure for schedule_job
-- ----------------------------
DROP TABLE IF EXISTS `schedule_job`;
CREATE TABLE `schedule_job` (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务id',
  `bean_name` varchar(200) DEFAULT NULL COMMENT 'spring bean名称',
  `params` varchar(2000) DEFAULT NULL COMMENT '参数',
  `cron_expression` varchar(100) DEFAULT NULL COMMENT 'cron表达式',
  `status` tinyint(4) DEFAULT NULL COMMENT '任务状态  0：正常  1：暂停',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='定时任务';

-- ----------------------------
-- Records of schedule_job
-- ----------------------------
INSERT INTO `schedule_job` VALUES ('1', 'testTask', 'sipai', '0 0/30 * * * ?', '0', '参数测试', '2019-05-22 16:49:36');

-- ----------------------------
-- Table structure for schedule_job_log
-- ----------------------------
DROP TABLE IF EXISTS `schedule_job_log`;
CREATE TABLE `schedule_job_log` (
  `log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志id',
  `job_id` bigint(20) NOT NULL COMMENT '任务id',
  `bean_name` varchar(200) DEFAULT NULL COMMENT 'spring bean名称',
  `params` varchar(2000) DEFAULT NULL COMMENT '参数',
  `status` tinyint(4) NOT NULL COMMENT '任务状态    0：成功    1：失败',
  `error` varchar(2000) DEFAULT NULL COMMENT '失败信息',
  `times` int(11) NOT NULL COMMENT '耗时(单位：毫秒)',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`log_id`),
  KEY `job_id` (`job_id`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8 COMMENT='定时任务日志';

-- ----------------------------
-- Records of schedule_job_log
-- ----------------------------
INSERT INTO `schedule_job_log` VALUES ('1', '1', 'testTask', 'sipai', '0', null, '1', '2019-05-22 17:30:00');
INSERT INTO `schedule_job_log` VALUES ('2', '1', 'testTask', 'sipai', '0', null, '4', '2019-05-22 23:00:00');
INSERT INTO `schedule_job_log` VALUES ('3', '1', 'testTask', 'sipai', '0', null, '8', '2019-05-24 11:00:00');
INSERT INTO `schedule_job_log` VALUES ('4', '1', 'testTask', 'sipai', '0', null, '10', '2019-05-24 11:30:00');
INSERT INTO `schedule_job_log` VALUES ('5', '1', 'testTask', 'sipai', '0', null, '2', '2019-05-24 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('6', '1', 'testTask', 'sipai', '0', null, '2', '2019-05-24 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('7', '1', 'testTask', 'sipai', '0', null, '2', '2019-05-24 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('8', '1', 'testTask', 'sipai', '0', null, '1', '2019-05-24 13:30:00');
INSERT INTO `schedule_job_log` VALUES ('9', '1', 'testTask', 'sipai', '0', null, '1', '2019-05-24 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('10', '1', 'testTask', 'sipai', '0', null, '2', '2019-05-24 14:30:00');
INSERT INTO `schedule_job_log` VALUES ('11', '1', 'testTask', 'sipai', '0', null, '2', '2019-05-24 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('12', '1', 'testTask', 'sipai', '0', null, '1', '2019-05-24 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('13', '1', 'testTask', 'sipai', '0', null, '1', '2019-05-24 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('14', '1', 'testTask', 'sipai', '0', null, '2', '2019-05-24 16:30:00');
INSERT INTO `schedule_job_log` VALUES ('15', '1', 'testTask', 'sipai', '0', null, '0', '2019-05-24 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('16', '1', 'testTask', 'sipai', '0', null, '1', '2019-05-24 17:30:00');
INSERT INTO `schedule_job_log` VALUES ('17', '1', 'testTask', 'sipai', '0', null, '1', '2019-05-24 18:00:00');
INSERT INTO `schedule_job_log` VALUES ('18', '1', 'testTask', 'sipai', '0', null, '4', '2019-05-24 22:30:00');
INSERT INTO `schedule_job_log` VALUES ('19', '1', 'testTask', 'sipai', '0', null, '4', '2019-05-24 23:00:00');
INSERT INTO `schedule_job_log` VALUES ('20', '1', 'testTask', 'sipai', '0', null, '3', '2019-05-24 23:30:00');
INSERT INTO `schedule_job_log` VALUES ('21', '1', 'testTask', 'sipai', '0', null, '4', '2019-05-25 23:00:00');
INSERT INTO `schedule_job_log` VALUES ('22', '1', 'testTask', 'sipai', '0', null, '5', '2019-05-26 23:00:00');
INSERT INTO `schedule_job_log` VALUES ('23', '1', 'testTask', 'sipai', '0', null, '2', '2019-05-27 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('24', '1', 'testTask', 'sipai', '0', null, '1', '2019-05-27 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('25', '1', 'testTask', 'sipai', '0', null, '1', '2019-05-27 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('26', '1', 'testTask', 'sipai', '0', null, '2', '2019-05-27 22:30:00');
INSERT INTO `schedule_job_log` VALUES ('27', '1', 'testTask', 'sipai', '0', null, '13', '2019-05-28 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('28', '1', 'testTask', 'sipai', '0', null, '2', '2019-05-28 17:30:00');
INSERT INTO `schedule_job_log` VALUES ('29', '1', 'testTask', 'sipai', '0', null, '2', '2019-05-28 18:00:00');
INSERT INTO `schedule_job_log` VALUES ('30', '1', 'testTask', 'sipai', '0', null, '4', '2019-05-28 23:30:00');
INSERT INTO `schedule_job_log` VALUES ('31', '1', 'testTask', 'sipai', '0', null, '15', '2019-05-29 00:00:00');
INSERT INTO `schedule_job_log` VALUES ('32', '1', 'testTask', 'sipai', '0', null, '1', '2019-05-29 08:00:00');
INSERT INTO `schedule_job_log` VALUES ('33', '1', 'testTask', 'sipai', '0', null, '1', '2019-05-29 08:30:00');
INSERT INTO `schedule_job_log` VALUES ('34', '1', 'testTask', 'sipai', '0', null, '1', '2019-05-29 09:00:00');
INSERT INTO `schedule_job_log` VALUES ('35', '1', 'testTask', 'sipai', '0', null, '0', '2019-05-29 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('36', '1', 'testTask', 'sipai', '0', null, '2', '2019-05-29 13:30:00');
INSERT INTO `schedule_job_log` VALUES ('37', '1', 'testTask', 'sipai', '0', null, '4', '2019-05-29 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('38', '1', 'testTask', 'sipai', '0', null, '2', '2019-05-29 14:30:00');
INSERT INTO `schedule_job_log` VALUES ('39', '1', 'testTask', 'sipai', '0', null, '1', '2019-05-29 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('40', '1', 'testTask', 'sipai', '0', null, '2', '2019-05-29 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('41', '1', 'testTask', 'sipai', '0', null, '0', '2019-05-30 02:30:00');
INSERT INTO `schedule_job_log` VALUES ('42', '1', 'testTask', 'sipai', '0', null, '4', '2019-05-30 09:00:00');
INSERT INTO `schedule_job_log` VALUES ('43', '1', 'testTask', 'sipai', '0', null, '3', '2019-05-30 09:30:00');
INSERT INTO `schedule_job_log` VALUES ('44', '1', 'testTask', 'sipai', '0', null, '7', '2019-05-30 10:00:00');
INSERT INTO `schedule_job_log` VALUES ('45', '1', 'testTask', 'sipai', '0', null, '2', '2019-05-30 23:00:00');
INSERT INTO `schedule_job_log` VALUES ('46', '1', 'testTask', 'sipai', '0', null, '1', '2019-05-30 23:30:00');
INSERT INTO `schedule_job_log` VALUES ('47', '1', 'testTask', 'sipai', '0', null, '2', '2019-05-31 10:00:00');
INSERT INTO `schedule_job_log` VALUES ('48', '1', 'testTask', 'sipai', '0', null, '4', '2019-05-31 10:30:00');
INSERT INTO `schedule_job_log` VALUES ('49', '1', 'testTask', 'sipai', '0', null, '2', '2019-05-31 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('50', '1', 'testTask', 'sipai', '0', null, '1', '2019-05-31 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('51', '1', 'testTask', 'sipai', '0', null, '2', '2019-05-31 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('52', '1', 'testTask', 'sipai', '0', null, '1', '2019-05-31 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('53', '1', 'testTask', 'sipai', '0', null, '2', '2019-05-31 16:30:00');
INSERT INTO `schedule_job_log` VALUES ('54', '1', 'testTask', 'sipai', '0', null, '3', '2019-05-31 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('55', '1', 'testTask', 'sipai', '0', null, '1', '2019-05-31 17:30:00');
INSERT INTO `schedule_job_log` VALUES ('56', '1', 'testTask', 'sipai', '0', null, '2', '2019-05-31 18:00:00');
INSERT INTO `schedule_job_log` VALUES ('57', '1', 'testTask', 'sipai', '0', null, '3', '2019-05-31 18:30:00');
INSERT INTO `schedule_job_log` VALUES ('58', '1', 'testTask', 'sipai', '0', null, '3', '2019-06-17 09:00:00');
INSERT INTO `schedule_job_log` VALUES ('59', '1', 'testTask', 'sipai', '0', null, '6', '2019-06-17 09:30:00');
INSERT INTO `schedule_job_log` VALUES ('60', '1', 'testTask', 'sipai', '0', null, '6', '2019-06-17 10:00:00');
INSERT INTO `schedule_job_log` VALUES ('61', '1', 'testTask', 'sipai', '0', null, '8', '2019-06-17 10:30:00');
INSERT INTO `schedule_job_log` VALUES ('62', '1', 'testTask', 'sipai', '0', null, '5', '2019-06-17 11:00:00');
INSERT INTO `schedule_job_log` VALUES ('63', '1', 'testTask', 'sipai', '0', null, '5', '2019-06-17 11:30:00');
INSERT INTO `schedule_job_log` VALUES ('64', '1', 'testTask', 'sipai', '0', null, '5', '2019-06-17 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('65', '1', 'testTask', 'sipai', '0', null, '5', '2019-06-17 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('66', '1', 'testTask', 'sipai', '0', null, '5', '2019-06-17 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('67', '1', 'testTask', 'sipai', '0', null, '6', '2019-06-17 13:30:00');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `param_key` varchar(50) DEFAULT NULL COMMENT 'key',
  `param_value` varchar(2000) DEFAULT NULL COMMENT 'value',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态   0：隐藏   1：显示',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `param_key` (`param_key`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='系统配置信息表';

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES ('1', 'CLOUD_STORAGE_CONFIG_KEY', '{\"aliyunAccessKeyId\":\"\",\"aliyunAccessKeySecret\":\"\",\"aliyunBucketName\":\"\",\"aliyunDomain\":\"\",\"aliyunEndPoint\":\"\",\"aliyunPrefix\":\"\",\"qcloudBucketName\":\"\",\"qcloudDomain\":\"\",\"qcloudPrefix\":\"\",\"qcloudSecretId\":\"\",\"qcloudSecretKey\":\"\",\"qiniuAccessKey\":\"NrgMfABZxWLo5B-YYSjoE8-AZ1EISdi1Z3ubLOeZ\",\"qiniuBucketName\":\"ios-app\",\"qiniuDomain\":\"http://7xqbwh.dl1.z0.glb.clouddn.com\",\"qiniuPrefix\":\"upload\",\"qiniuSecretKey\":\"uIwJHevMRWU0VLxFvgy0tAcOdGqasdtVlJkdy6vV\",\"type\":1}', '0', '云存储配置信息');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept` (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) DEFAULT NULL COMMENT '上级部门ID，一级部门为0',
  `name` varchar(50) DEFAULT NULL COMMENT '部门名称',
  `order_num` int(11) DEFAULT NULL COMMENT '排序',
  `del_flag` tinyint(4) DEFAULT '0' COMMENT '是否删除  -1：已删除  0：正常',
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='部门管理';

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES ('1', '0', '人人开源集团', '0', '0');
INSERT INTO `sys_dept` VALUES ('2', '1', '长沙分公司', '1', '0');
INSERT INTO `sys_dept` VALUES ('3', '1', '上海分公司', '2', '0');
INSERT INTO `sys_dept` VALUES ('4', '3', '技术部', '0', '0');
INSERT INTO `sys_dept` VALUES ('5', '3', '销售部', '1', '0');

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT '字典名称',
  `type` varchar(100) NOT NULL COMMENT '字典类型',
  `code` varchar(100) NOT NULL COMMENT '字典码',
  `value` varchar(1000) NOT NULL COMMENT '字典值',
  `order_num` int(11) DEFAULT '0' COMMENT '排序',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `del_flag` tinyint(4) DEFAULT '0' COMMENT '删除标记  -1：已删除  0：正常',
  PRIMARY KEY (`id`),
  UNIQUE KEY `type` (`type`,`code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='数据字典表';

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES ('1', '性别', 'sex', '0', '女', '0', null, '0');
INSERT INTO `sys_dict` VALUES ('2', '性别', 'sex', '1', '男', '1', null, '0');
INSERT INTO `sys_dict` VALUES ('3', '性别', 'sex', '2', '未知', '3', null, '0');

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL COMMENT '用户名',
  `operation` varchar(50) DEFAULT NULL COMMENT '用户操作',
  `method` varchar(200) DEFAULT NULL COMMENT '请求方法',
  `params` varchar(5000) DEFAULT NULL COMMENT '请求参数',
  `time` bigint(20) NOT NULL COMMENT '执行时长(毫秒)',
  `ip` varchar(64) DEFAULT NULL COMMENT 'IP地址',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='系统日志';

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES ('1', 'admin', '保存用户', 'io.sipaimodules.sys.controller.SysUserController.save()', '{\"userId\":2,\"username\":\"Test1\",\"password\":\"3e39aec0a3b349f38e16ec2bdbf3a7a798ee725a436f355b5f2b994053b5c7c2\",\"salt\":\"dV2oNbMXiS70mvESp4bo\",\"email\":\"123456@126.com\",\"mobile\":\"13612345678\",\"status\":1,\"roleIdList\":[],\"createTime\":\"May 24, 2019, 10:38:26 PM\",\"deptId\":3,\"deptName\":\"上海分公司\"}', '107', '0:0:0:0:0:0:0:1', '2019-05-24 22:38:27');
INSERT INTO `sys_log` VALUES ('2', 'admin', '保存角色', 'io.sipaimodules.sys.controller.SysRoleController.save()', '{\"roleId\":1,\"roleName\":\"测试人员\",\"deptId\":3,\"deptName\":\"上海分公司\",\"menuIdList\":[1,46,47],\"deptIdList\":[],\"createTime\":\"May 24, 2019, 10:39:18 PM\"}', '106', '0:0:0:0:0:0:0:1', '2019-05-24 22:39:19');
INSERT INTO `sys_log` VALUES ('3', 'admin', '修改用户', 'io.sipaimodules.sys.controller.SysUserController.update()', '{\"userId\":2,\"username\":\"Test1\",\"salt\":\"dV2oNbMXiS70mvESp4bo\",\"email\":\"123456@126.com\",\"mobile\":\"13612345678\",\"status\":1,\"roleIdList\":[1],\"createTime\":\"May 24, 2019, 10:38:27 PM\",\"deptId\":3,\"deptName\":\"上海分公司\"}', '47', '0:0:0:0:0:0:0:1', '2019-05-24 22:39:31');
INSERT INTO `sys_log` VALUES ('4', 'admin', '修改角色', 'io.sipaimodules.sys.controller.SysRoleController.update()', '{\"roleId\":1,\"roleName\":\"测试人员\",\"deptId\":3,\"menuIdList\":[1,92,93,94,95,96],\"deptIdList\":[],\"createTime\":\"May 24, 2019, 10:39:18 PM\"}', '97', '0:0:0:0:0:0:0:1', '2019-05-30 23:31:36');
INSERT INTO `sys_log` VALUES ('5', 'admin', '修改角色', 'io.sipaimodules.sys.controller.SysRoleController.update()', '{\"roleId\":1,\"roleName\":\"测试人员\",\"deptId\":3,\"deptName\":\"上海分公司\",\"menuIdList\":[1,92,93,95],\"deptIdList\":[],\"createTime\":\"May 24, 2019, 10:39:18 PM\"}', '96', '0:0:0:0:0:0:0:1', '2019-05-31 19:02:17');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) DEFAULT NULL COMMENT '父菜单ID，一级菜单为0',
  `name` varchar(50) DEFAULT NULL COMMENT '菜单名称',
  `url` varchar(200) DEFAULT NULL COMMENT '菜单URL',
  `perms` varchar(500) DEFAULT NULL COMMENT '授权(多个用逗号分隔，如：user:list,user:create)',
  `type` int(11) DEFAULT NULL COMMENT '类型   0：目录   1：菜单   2：按钮',
  `icon` varchar(50) DEFAULT NULL COMMENT '菜单图标',
  `order_num` int(11) DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8 COMMENT='菜单管理';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('1', '0', '系统管理', null, null, '0', 'fa fa-cog', '0');
INSERT INTO `sys_menu` VALUES ('2', '1', '管理员管理', 'modules/sys/user.html', null, '1', 'fa fa-user', '1');
INSERT INTO `sys_menu` VALUES ('3', '1', '角色管理', 'modules/sys/role.html', null, '1', 'fa fa-user-secret', '2');
INSERT INTO `sys_menu` VALUES ('4', '1', '菜单管理', 'modules/sys/menu.html', null, '1', 'fa fa-th-list', '3');
INSERT INTO `sys_menu` VALUES ('5', '1', 'SQL监控', 'druid/sql.html', null, '1', 'fa fa-bug', '4');
INSERT INTO `sys_menu` VALUES ('6', '1', '定时任务', 'modules/job/schedule.html', null, '1', 'fa fa-tasks', '5');
INSERT INTO `sys_menu` VALUES ('7', '6', '查看', null, 'sys:schedule:list,sys:schedule:info', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('8', '6', '新增', null, 'sys:schedule:save', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('9', '6', '修改', null, 'sys:schedule:update', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('10', '6', '删除', null, 'sys:schedule:delete', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('11', '6', '暂停', null, 'sys:schedule:pause', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('12', '6', '恢复', null, 'sys:schedule:resume', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('13', '6', '立即执行', null, 'sys:schedule:run', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('14', '6', '日志列表', null, 'sys:schedule:log', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('15', '2', '查看', null, 'sys:user:list,sys:user:info', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('16', '2', '新增', null, 'sys:user:save,sys:role:select', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('17', '2', '修改', null, 'sys:user:update,sys:role:select', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('18', '2', '删除', null, 'sys:user:delete', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('19', '3', '查看', null, 'sys:role:list,sys:role:info', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('20', '3', '新增', null, 'sys:role:save,sys:menu:perms', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('21', '3', '修改', null, 'sys:role:update,sys:menu:perms', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('22', '3', '删除', null, 'sys:role:delete', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('23', '4', '查看', null, 'sys:menu:list,sys:menu:info', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('24', '4', '新增', null, 'sys:menu:save,sys:menu:select', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('25', '4', '修改', null, 'sys:menu:update,sys:menu:select', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('26', '4', '删除', null, 'sys:menu:delete', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('27', '1', '参数管理', 'modules/sys/config.html', 'sys:config:list,sys:config:info,sys:config:save,sys:config:update,sys:config:delete', '1', 'fa fa-sun-o', '6');
INSERT INTO `sys_menu` VALUES ('29', '1', '系统日志', 'modules/sys/log.html', 'sys:log:list', '1', 'fa fa-file-text-o', '7');
INSERT INTO `sys_menu` VALUES ('30', '1', '文件上传', 'modules/oss/oss.html', 'sys:oss:all', '1', 'fa fa-file-image-o', '6');
INSERT INTO `sys_menu` VALUES ('31', '1', '部门管理', 'modules/sys/dept.html', null, '1', 'fa fa-file-code-o', '1');
INSERT INTO `sys_menu` VALUES ('32', '31', '查看', null, 'sys:dept:list,sys:dept:info', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('33', '31', '新增', null, 'sys:dept:save,sys:dept:select', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('34', '31', '修改', null, 'sys:dept:update,sys:dept:select', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('35', '31', '删除', null, 'sys:dept:delete', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('36', '1', '字典管理', 'modules/sys/dict.html', null, '1', 'fa fa-bookmark-o', '6');
INSERT INTO `sys_menu` VALUES ('37', '36', '查看', null, 'sys:dict:list,sys:dict:info', '2', null, '6');
INSERT INTO `sys_menu` VALUES ('38', '36', '新增', null, 'sys:dict:save', '2', null, '6');
INSERT INTO `sys_menu` VALUES ('39', '36', '修改', null, 'sys:dict:update', '2', null, '6');
INSERT INTO `sys_menu` VALUES ('40', '36', '删除', null, 'sys:dict:delete', '2', null, '6');
INSERT INTO `sys_menu` VALUES ('77', '1', '答题管理', 'modules/sys/answers.html', null, '1', 'fa fa-file-code-o', '6');
INSERT INTO `sys_menu` VALUES ('78', '77', '查看', null, 'sys:answers:list,sys:answers:info', '2', null, '6');
INSERT INTO `sys_menu` VALUES ('79', '77', '新增', null, 'sys:answers:save', '2', null, '6');
INSERT INTO `sys_menu` VALUES ('80', '77', '修改', null, 'sys:answers:update', '2', null, '6');
INSERT INTO `sys_menu` VALUES ('81', '77', '删除', null, 'sys:answers:delete', '2', null, '6');
INSERT INTO `sys_menu` VALUES ('82', '1', '题库管理', 'modules/sys/questions.html', null, '1', 'fa fa-file-code-o', '6');
INSERT INTO `sys_menu` VALUES ('83', '82', '查看', null, 'sys:questions:list,sys:questions:info', '2', null, '6');
INSERT INTO `sys_menu` VALUES ('84', '82', '新增', null, 'sys:questions:save', '2', null, '6');
INSERT INTO `sys_menu` VALUES ('85', '82', '修改', null, 'sys:questions:update', '2', null, '6');
INSERT INTO `sys_menu` VALUES ('86', '82', '删除', null, 'sys:questions:delete', '2', null, '6');
INSERT INTO `sys_menu` VALUES ('87', '1', '测试管理', 'modules/sys/tests.html', null, '1', 'fa fa-file-code-o', '6');
INSERT INTO `sys_menu` VALUES ('88', '87', '查看', null, 'sys:tests:list,sys:tests:info', '2', null, '6');
INSERT INTO `sys_menu` VALUES ('89', '87', '新增', null, 'sys:tests:save', '2', null, '6');
INSERT INTO `sys_menu` VALUES ('90', '87', '修改', null, 'sys:tests:update', '2', null, '6');
INSERT INTO `sys_menu` VALUES ('91', '87', '删除', null, 'sys:tests:delete', '2', null, '6');
INSERT INTO `sys_menu` VALUES ('92', '1', '用户答题', 'modules/sys/useranswer.html', null, '1', 'fa fa-file-code-o', '6');
INSERT INTO `sys_menu` VALUES ('93', '92', '查看', null, 'sys:useranswer:list,sys:useranswer:info', '2', null, '6');
INSERT INTO `sys_menu` VALUES ('94', '92', '新增', null, 'sys:useranswer:save', '2', null, '6');
INSERT INTO `sys_menu` VALUES ('95', '92', '修改', null, 'sys:useranswer:update', '2', null, '6');
INSERT INTO `sys_menu` VALUES ('96', '92', '删除', null, 'sys:useranswer:delete', '2', null, '6');

-- ----------------------------
-- Table structure for sys_oss
-- ----------------------------
DROP TABLE IF EXISTS `sys_oss`;
CREATE TABLE `sys_oss` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `url` varchar(200) DEFAULT NULL COMMENT 'URL地址',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文件上传';

-- ----------------------------
-- Records of sys_oss
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(100) DEFAULT NULL COMMENT '角色名称',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `dept_id` bigint(20) DEFAULT NULL COMMENT '部门ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='角色';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '测试人员', null, '3', '2019-05-24 22:39:18');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色ID',
  `dept_id` bigint(20) DEFAULT NULL COMMENT '部门ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色与部门对应关系';

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色ID',
  `menu_id` bigint(20) DEFAULT NULL COMMENT '菜单ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='角色与菜单对应关系';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES ('10', '1', '1');
INSERT INTO `sys_role_menu` VALUES ('11', '1', '92');
INSERT INTO `sys_role_menu` VALUES ('12', '1', '93');
INSERT INTO `sys_role_menu` VALUES ('13', '1', '95');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `password` varchar(100) DEFAULT NULL COMMENT '密码',
  `salt` varchar(20) DEFAULT NULL COMMENT '盐',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `mobile` varchar(100) DEFAULT NULL COMMENT '手机号',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态  0：禁用   1：正常',
  `dept_id` bigint(20) DEFAULT NULL COMMENT '部门ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='系统用户';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', 'admin', 'e1153123d7d180ceeb820d577ff119876678732a68eef4e6ffc0b1f06a01f91b', 'YzcmCZNvbXocrsz9dm8e', 'root@sipai.io', '13612345678', '1', '1', '2016-11-11 11:11:11');
INSERT INTO `sys_user` VALUES ('2', 'Test1', '3e39aec0a3b349f38e16ec2bdbf3a7a798ee725a436f355b5f2b994053b5c7c2', 'dV2oNbMXiS70mvESp4bo', '123456@126.com', '13612345678', '1', '3', '2019-05-24 22:38:27');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='用户与角色对应关系';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('1', '2', '1');

-- ----------------------------
-- Table structure for tests
-- ----------------------------
DROP TABLE IF EXISTS `tests`;
CREATE TABLE `tests` (
  `tests_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '测试ID',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `teststatus` bigint(20) NOT NULL COMMENT '测试状态',
  `testtime` varchar(50) DEFAULT NULL COMMENT '测试时间',
  PRIMARY KEY (`tests_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='测试管理';

-- ----------------------------
-- Records of tests
-- ----------------------------
INSERT INTO `tests` VALUES ('1', '2', '0', '2019-5-24');
INSERT INTO `tests` VALUES ('2', '2', '1', '2019-5-24');
INSERT INTO `tests` VALUES ('3', '1', '1', '2019-5-24');
INSERT INTO `tests` VALUES ('4', '1', '0', '2019-5-24');

-- ----------------------------
-- Table structure for useranswer_del
-- ----------------------------
DROP TABLE IF EXISTS `useranswer_del`;
CREATE TABLE `useranswer_del` (
  `answers_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '答题ID',
  `ansnumber` bigint(20) DEFAULT NULL COMMENT '所选答案',
  `anstime` varchar(50) DEFAULT NULL COMMENT '答题时间',
  `question` varchar(255) DEFAULT NULL COMMENT '题目名称',
  `option1` varchar(255) DEFAULT NULL COMMENT '选项1',
  `option2` varchar(255) DEFAULT NULL COMMENT '选项2',
  `option3` varchar(255) DEFAULT NULL COMMENT '选项3',
  `option4` varchar(255) DEFAULT NULL COMMENT '选项4',
  PRIMARY KEY (`answers_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户答题';

-- ----------------------------
-- Records of useranswer_del
-- ----------------------------

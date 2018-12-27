-- 用户表
CREATE TABLE `t_user` (
  `user_id` varchar(128) NOT NULL DEFAULT '' COMMENT '用户ID',
  `user_password` varchar(256) NOT NULL DEFAULT '' COMMENT '用户密码',
  `user_name` varchar(256) NOT NULL DEFAULT '' COMMENT '用户名',
  `contact` varchar(64) NOT NULL DEFAULT '' COMMENT '联系人',
  `building_info` varchar(2048) NOT NULL DEFAULT '' COMMENT '建筑物信息',
  `dept_info` varchar(2048) NOT NULL DEFAULT '' COMMENT '部门信息',
  `mobile_phone` varchar(64) NOT NULL DEFAULT '' COMMENT '移动电话',
  `platform_id` varchar(128) NOT NULL DEFAULT '' COMMENT '平台ID',
  `platform_name` VARCHAR(32) NOT NULL DEFAULT '' COMMENT '平台名称',
  `update_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `create_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建时间',    
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 MAX_ROWS=10000 AVG_ROW_LENGTH=5000;

-- 空调型号表
CREATE TABLE `t_air_condition` (
  `air_id` VARCHAR(128) NOT NULL DEFAULT '' COMMENT 'ID' ,
  `air_model` VARCHAR(256) NOT NULL DEFAULT '' COMMENT '空调型号' ,
  `air_name` VARCHAR(256) NOT NULL DEFAULT ''  COMMENT '空调名称' ,
  `pi` INT NOT NULL DEFAULT 0 COMMENT '空调匹数',
  `power` INT NOT NULL DEFAULT 0 COMMENT '空调功率' ,
  `brand` VARCHAR(128)  NOT NULL DEFAULT '' COMMENT '空调品牌' ,
  `factory` VARCHAR(512) NOT NULL DEFAULT '' COMMENT '空调制造商',
  `description` VARCHAR(2048) NOT NULL DEFAULT '' COMMENT '备注',
  `platform_id` varchar(128) NOT NULL DEFAULT '' COMMENT '平台ID',
  `platform_name` VARCHAR(32) NOT NULL DEFAULT '' COMMENT '平台名称',
  `update_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `create_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建时间',    
  PRIMARY KEY (`air_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 MAX_ROWS=10000 AVG_ROW_LENGTH=4000;

-- 建筑物表
CREATE TABLE `t_building` (
  `building_id` VARCHAR(128) NOT NULL DEFAULT '' COMMENT 'ID' ,
  `building_name` VARCHAR(256) NOT NULL DEFAULT ''  COMMENT '建筑物名称' ,
  `parent_id` varchar(128) NOT NULL DEFAULT '' COMMENT '父建筑物ID',
  `building_level` INT NOT NULL DEFAULT '0' COMMENT '层级',
  `building_f_tree` varchar(2048) NOT NULL DEFAULT '' COMMEMT '建筑树',
  `description` VARCHAR(2048) NOT NULL DEFAULT '' COMMENT '备注',
  `platform_id` varchar(128) NOT NULL DEFAULT '' '平台ID',
  `platform_name` VARCHAR(32) NOT NULL DEFAULT '' COMMENT '平台名称',
  `update_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `create_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建时间',    
  PRIMARY KEY (`building_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 MAX_ROWS=10000 AVG_ROW_LENGTH=4000;

-- 部门表
CREATE TABLE `t_dept` (
  `dept_id` VARCHAR(128) NOT NULL DEFAULT '' COMMENT 'ID' ,
  `dept_name` VARCHAR(256) NOT NULL DEFAULT ''  COMMENT '部门名称' ,
  `parent_id` varchar(128) NOT NULL DEFAULT '' COMMENT '父部门ID',
  `dept_level` INT NOT NULL DEFAULT '0' COMMENT '层级',
  `dept_f_tree` varchar(2048) NOT NULL DEFAULT '' COMMEMT '部门树',
  `description` VARCHAR(2048) NOT NULL DEFAULT '' COMMENT '备注',
  `platform_id` varchar(128) NOT NULL DEFAULT '' COMMENT '平台ID',
  `platform_name` VARCHAR(32) NOT NULL DEFAULT '' COMMENT '平台名称',
  `update_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `create_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建时间',    
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 MAX_ROWS=10000 AVG_ROW_LENGTH=4000;

-- 设备表
CREATE TABLE `t_terminal` (
  `terminal_id` VARCHAR(128) NOT NULL DEFAULT '' COMMENT 'ID' ,
  `terminal_name` VARCHAR(128) NOT NULL DEFAULT '' COMMENT '设备名称',
  `device_id` INT NOT NULL UNIQUE DEFAULT 0 COMMENT '设备id' ,
  `etc_id` VARCHAR(128) NOT NULL DEFAULT '' COMMENT '配置id' ,
  `rule_id` VARCHAR(128) NOT NULL DEFAULT '' COMMENT '规则id',
  `air_id` VARCHAR(128) NOT NULL DEFAULT '' COMMENT '空调id',
  `air_buy_date` bigint NOT NULL DEFAULT 0 COMMENT '购买日期' ,
  `building_id` VARCHAR(128) NOT NULL DEFAULT '' COMMENT '建筑物id',
  `dept_id` VARCHAR(128) NOT NULL DEFAULT '' COMMENT '部门id' , 
  `maintenance_records` text NOT NULL  COMMENT '维修记录',
  `terminal_sn` varchar(128) NOT NULL DEFAULT '' COMMENT '设备序列号',
  `terminal_version` varchar(32) NOT NULL DEFAULT '' COMMENT '设备版本号',
  `description` VARCHAR(2048) NOT NULL DEFAULT '' COMMENT '备注',
  `platform_id` varchar(128) NOT NULL DEFAULT '' COMMENT '平台ID',
  `platform_name` VARCHAR(32) NOT NULL DEFAULT '' COMMENT '平台名称',
  `update_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `create_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建时间',    
  PRIMARY KEY (`terminal_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 MAX_ROWS=1000000 AVG_ROW_LENGTH=4000;

-- 规则表
CREATE TABLE `t_rule` (
  `rule_id` VARCHAR(128) NOT NULL DEFAULT '' COMMENT 'ID' ,
  `rule_name` VARCHAR(256) NOT NULL DEFAULT ''  COMMENT '规则名称' ,
  `rule_content` VARCHAR(2048) NOT NULL DEFAULT '' COMMENT '规则内容',
  `description` VARCHAR(2048) NOT NULL DEFAULT '' COMMENT '备注',
  `platform_id` varchar(128) NOT NULL DEFAULT '' COMMENT '平台ID',
  `platform_name` VARCHAR(32) NOT NULL DEFAULT '' COMMENT '平台名称',
  `update_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `create_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建时间',    
  PRIMARY KEY (`rule_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 MAX_ROWS=10000 AVG_ROW_LENGTH=5000;

-- 配置表
CREATE TABLE `t_etc` (
  `etc_id` VARCHAR(128) NOT NULL DEFAULT '' COMMENT 'ID' ,
  `etc_name` VARCHAR(256) NOT NULL DEFAULT ''  COMMENT '配置名称' ,
  `max_heat` INT NOT NULL DEFAULT 0 COMMENT '制热最高温度' , 
  `min_heat` INT NOT NULL DEFAULT 0 COMMENT '制热最低温度' ,
  `mid_heat` INT NOT NULL DEFAULT 0 COMMENT '制热中间温度' , 
  `max_cool` INT NOT NULL DEFAULT 0 COMMENT '制冷最高温度' , 
  `min_cool` INT NOT NULL DEFAULT 0 COMMENT '制冷最低温度' , 
  `mid_cool` INT NOT NULL DEFAULT 0 COMMENT '制冷中间温度' , 
  `max_humidity` INT NOT NULL DEFAULT 0 COMMENT '除湿最高值' , 
  `min_humidity` INT NOT NULL DEFAULT 0 COMMENT '除湿最低值' ,
  `etc_mode` varchar(64) NOT NULL DEFAULT '' COMMENT '空调模式' ,
  `description` VARCHAR(2048) NOT NULL DEFAULT '' COMMENT '备注',
  `platform_id` varchar(128) NOT NULL DEFAULT '' COMMENT '平台ID',
  `platform_name` VARCHAR(32) NOT NULL DEFAULT '' COMMENT '平台名称',
  `update_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `create_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建时间',    
  PRIMARY KEY (`etc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 MAX_ROWS=10000 AVG_ROW_LENGTH=4000;

-- 状态表
CREATE TABLE `t_status` (
  `device_id` INT NOT NULL DEFAULT '0' COMMENT '设备id',
  `run_mode` TINYINT NOT NULL DEFAULT 0 COMMENT '工作模式 0 自动模式， 1 手动模式' ,
  `running` TINYINT NOT NULL DEFAULT 0 COMMENT '是否运行',
  `temp` TINYINT NOT NULL DEFAULT 0 COMMENT '温度' , 
  `window` TINYINT NOT NULL DEFAULT 0 COMMENT '窗户开关' ,
  `human` TINYINT NOT NULL DEFAULT 0 COMMENT '是否有人' ,
  `door` TINYINT NOT NULL DEFAULT 0 COMMENT '门开关' ,
  `consumption` INT NOT NULL DEFAULT 0 COMMENT '能耗' , 
  `total_consumption` INT NOT NULL DEFAULT 0 COMMENT '总能耗' ,
  `humidity` TINYINT NOT NULL DEFAULT 0 COMMENT '湿度' ,
  `status_time` bigint NOT NULL DEFAULT 0 COMMENT '状态时间',
  `platform_id` varchar(128) NOT NULL DEFAULT '' COMMENT '平台ID',
  `platform_name` VARCHAR(32) NOT NULL DEFAULT '' COMMENT '平台名称',
  `update_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `create_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建时间',    
  PRIMARY KEY (`device_id`, `status_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 MAX_ROWS=1000000 AVG_ROW_LENGTH=1000;

-- 实时状态表
CREATE TABLE `t_real_status` (
  `device_id` INT NOT NULL DEFAULT '0' COMMENT '设备id',
  `run_mode` TINYINT NOT NULL DEFAULT 0 COMMENT '工作模式 0 自动模式， 1 手动模式' ,
  `running` TINYINT NOT NULL DEFAULT 0 COMMENT '是否运行',
  `temp` TINYINT NOT NULL DEFAULT 0 COMMENT '温度' , 
  `window` TINYINT NOT NULL DEFAULT 0 COMMENT '窗户开关' ,
  `human` TINYINT NOT NULL DEFAULT 0 COMMENT '是否有人' ,
  `door` TINYINT NOT NULL DEFAULT 0 COMMENT '门开关' ,
  `consumption` INT NOT NULL DEFAULT 0 COMMENT '能耗' , 
  `total_consumption` INT NOT NULL DEFAULT 0 COMMENT '总能耗' ,
  `humidity` TINYINT NOT NULL DEFAULT 0 COMMENT '湿度' ,
  `status_time` bigint NOT NULL DEFAULT 0 COMMENT '状态时间',
  `platform_id` varchar(128) NOT NULL DEFAULT '' COMMENT '平台ID',
  `platform_name` VARCHAR(32) NOT NULL DEFAULT '' COMMENT '平台名称',
  `update_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `create_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建时间',    
  PRIMARY KEY (`device_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 MAX_ROWS=1000000 AVG_ROW_LENGTH=1000;

-- 告警表
CREATE TABLE `t_alarm` (
  `device_id` INT NOT NULL DEFAULT '0' COMMENT '设备id',
  `run_mode` TINYINT NOT NULL DEFAULT 0 COMMENT '工作模式 0 自动模式， 1 手动模式' ,
  `running` TINYINT NOT NULL DEFAULT 0 COMMENT '是否运行',
  `temp` TINYINT NOT NULL DEFAULT 0 COMMENT '温度' , 
  `window` TINYINT NOT NULL DEFAULT 0 COMMENT '窗户开关' ,
  `human` TINYINT NOT NULL DEFAULT 0 COMMENT '是否有人' ,
  `door` TINYINT NOT NULL DEFAULT 0 COMMENT '门开关' ,
  `consumption` INT NOT NULL DEFAULT 0 COMMENT '能耗' , 
  `total_consumption` INT NOT NULL DEFAULT 0 COMMENT '总能耗' ,
  `humidity` TINYINT NOT NULL DEFAULT 0 COMMENT '湿度' ,
  `alarm_time` bigint NOT NULL DEFAULT 0 COMMENT '告警时间',
  `platform_id` varchar(128) NOT NULL DEFAULT '' COMMENT '平台ID',
  `platform_name` VARCHAR(32) NOT NULL DEFAULT '' COMMENT '平台名称',
  `update_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `create_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建时间',    
  PRIMARY KEY (`device_id`, `alarm_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 MAX_ROWS=10000 AVG_ROW_LENGTH=1000;

-- 统计表
CREATE TABLE `t_status_stat` (
  `device_id` INT NOT NULL DEFAULT '0' COMMENT '设备id',
  `stat` text NOT NULL COMMENT '统计数据,推荐格式为json',
  `running_time` int NOT NULL DEFAULT 0 COMMENT '一天运行时间' ,
  `human_time` int NOT NULL DEFAULT 0 COMMENT '一天空调运行有人时间' ,
  `door_time` int NOT NULL DEFAULT 0 COMMENT '一天空调运行开门时间' ,
  `window_time` int NOT NULL DEFAULT 0 COMMENT '一天空调运行开窗时间' ,
  `temp` int NOT NULL DEFAULT 0 COMMENT '一天空调运行平均温度' ,
  `humidity` INT NOT NULL DEFAULT 0 COMMENT '一天平均湿度',
  `consumption` int NOT NULL DEFAULT 0 COMMENT '一天能耗' ,
  `hour_consumption` int NOT NULL DEFAULT 0 COMMENT '单位小时能耗' ,
  `stat_time` bigint NOT NULL DEFAULT 0 COMMENT '统计时间' ,
  `total_consumption` INT NOT NULL DEFAULT 0 COMMENT '总能耗' ,
  `platform_id` varchar(128) NOT NULL DEFAULT '' COMMENT '平台ID',
  `platform_name` VARCHAR(32) NOT NULL DEFAULT '' COMMENT '平台名称',
  `update_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `create_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建时间',    
  PRIMARY KEY (`device_id`, `stat_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 MAX_ROWS=1000000 AVG_ROW_LENGTH=8000;

-- 状态统计
CREATE TABLE `t_running_stat` (
  `id` INT  NOT NULL AUTO_INCREMENT  COMMENT 'id',
  `running` INT NOT NULL DEFAULT 0 COMMENT '运行设备数量',
  `close` INT NOT NULL DEFAULT 0 COMMENT '关闭设备数量' ,
  `online` INT NOT NULL DEFAULT 0 COMMENT '在线设备数量' ,
  `offline` INT NOT NULL DEFAULT 0 COMMENT '离线设备数量' ,
  `platform_id` varchar(128) NOT NULL DEFAULT '' COMMENT '平台ID',
  `platform_name` VARCHAR(32) NOT NULL DEFAULT '' COMMENT '平台名称',
  `update_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `create_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建时间',    
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 MAX_ROWS=100000 AVG_ROW_LENGTH=1000;


-- 楼宇统计表
CREATE TABLE `t_building_stat` (
  `building_id` varchar(128) NOT NULL DEFAULT '' COMMENT '建筑id',
  `building_name` varchar(128) NOT NULL DEFAULT '' COMMENT '建筑名称',
  `running_time` int NOT NULL DEFAULT 0 COMMENT '一天运行时间' ,
  `human_time` int NOT NULL DEFAULT 0 COMMENT '一天空调运行有人时间' ,
  `door_time` int NOT NULL DEFAULT 0 COMMENT '一天空调运行开门时间' ,
  `window_time` int NOT NULL DEFAULT 0 COMMENT '一天空调运行开窗时间' ,
  `temp` int NOT NULL DEFAULT 0 COMMENT '一天空调运行平均温度' ,
  `humidity` INT NOT NULL DEFAULT 0 COMMENT '一天平均湿度',
  `consumption` int NOT NULL DEFAULT 0 COMMENT '一天能耗' ,
  `hour_consumption` int NOT NULL DEFAULT 0 COMMENT '单位小时能耗' ,
  `stat_time` bigint NOT NULL DEFAULT 0 COMMENT '统计时间' ,
  `total_consumption` INT NOT NULL DEFAULT 0 COMMENT '总能耗' ,
  `platform_id` varchar(128) NOT NULL DEFAULT '' COMMENT '平台ID',
  `platform_name` VARCHAR(32) NOT NULL DEFAULT '' COMMENT '平台名称',
  `update_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `create_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建时间',    
  PRIMARY KEY (`building_id`, `stat_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 MAX_ROWS=1000000 AVG_ROW_LENGTH=8000;

-- 部门统计表
CREATE TABLE `t_dept_stat` (
  `dept_id` varchar(128) NOT NULL DEFAULT '' COMMENT '部门id',
  `dept_name` varchar(128) NOT NULL DEFAULT '' COMMENT '部门名称',
  `running_time` int NOT NULL DEFAULT 0 COMMENT '一天运行时间' ,
  `human_time` int NOT NULL DEFAULT 0 COMMENT '一天空调运行有人时间' ,
  `door_time` int NOT NULL DEFAULT 0 COMMENT '一天空调运行开门时间' ,
  `window_time` int NOT NULL DEFAULT 0 COMMENT '一天空调运行开窗时间' ,
  `temp` int NOT NULL DEFAULT 0 COMMENT '一天空调运行平均温度' ,
  `humidity` INT NOT NULL DEFAULT 0 COMMENT '一天平均湿度',
  `consumption` int NOT NULL DEFAULT 0 COMMENT '一天能耗' ,
  `hour_consumption` int NOT NULL DEFAULT 0 COMMENT '单位小时能耗' ,
  `stat_time` bigint NOT NULL DEFAULT 0 COMMENT '统计时间' ,
  `total_consumption` INT NOT NULL DEFAULT 0 COMMENT '总能耗' ,
  `platform_id` varchar(128) NOT NULL DEFAULT '' COMMENT '平台ID',
  `platform_name` VARCHAR(32) NOT NULL DEFAULT '' COMMENT '平台名称',
  `update_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `create_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建时间',    
  PRIMARY KEY (`dept_id`, `stat_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 MAX_ROWS=1000000 AVG_ROW_LENGTH=8000;

-- 能耗参考标准
CREATE TABLE `t_energy_reference` (
  `id` VARCHAR(128) NOT NULL DEFAULT '' COMMENT 'ID',
  `level5` INT NOT NULL DEFAULT '0' COMMENT '最差',
  `level4` INT NOT NULL DEFAULT '0' COMMENT '较差',
  `level3` INT NOT NULL DEFAULT '0' COMMENT '中间',
  `level2` INT NOT NULL DEFAULT '0' COMMENT '较好',
  `level1` INT NOT NULL DEFAULT '0' COMMENT '最好',
  `platform_id` varchar(128) NOT NULL DEFAULT '' COMMENT '平台ID',
  `platform_name` VARCHAR(32) NOT NULL DEFAULT '' COMMENT '平台名称',
  `update_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `create_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建时间',    
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 MAX_ROWS=1000000 AVG_ROW_LENGTH=8000;

-- 控制表
CREATE TABLE `t_control` (
  `control_id` VARCHAR(128) NOT NULL DEFAULT '' COMMENT 'id',
  `terminal_id` VARCHAR(128) NOT NULL DEFAULT '' COMMENT '设备id',
  `command` tinyint NOT NULL DEFAULT 0 COMMENT '1 开 2 关 3 下发参数设置 4 下发系统设置' ,
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '0 not send 1 sending 2 execute success 3 execute failed' ,
  `platform_id` varchar(128) NOT NULL DEFAULT '' COMMENT '平台ID',
  `platform_name` VARCHAR(32) NOT NULL DEFAULT '' COMMENT '平台名称',
  `update_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `create_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建时间',    
  PRIMARY KEY (`control_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 MAX_ROWS=100000 AVG_ROW_LENGTH=1000;

-- 系统参数表
CREATE TABLE `t_system_param` (
  `platform_domain` varchar(512) NOT NULL DEFAULT '' COMMENT '平台域名',
  `ip` varchar(128) NOT NULL DEFAULT '' COMMENT '平台IP',
  `back_ip` varchar(128) NOT NULL DEFAULT '' COMMENT '备IP' ,
  `port` int NOT NULL DEFAULT 10000 COMMENT '服务端口',
  `ssid` varchar(128) NOT NULL DEFAULT '' COMMENT 'WIFI SSID名称',
  `ssid_password` varchar(128) NOT NULL DEFAULT '' COMMENT 'WIFI 密码',
  `status_interval` INT NOT NULL DEFAULT 0 COMMENT '状态发送间隔' ,
  `description` VARCHAR(2048) NOT NULL DEFAULT '' COMMENT '备注',
  `platform_id` varchar(128) NOT NULL DEFAULT '' COMMENT '平台ID',
  `platform_name` VARCHAR(32) NOT NULL DEFAULT '' COMMENT '平台名称',
  `update_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `create_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建时间',    
  PRIMARY KEY (`platform_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 MAX_ROWS=10000 AVG_ROW_LENGTH=5000;

#################################################################################################################
DELIMITER &&
CREATE VIEW `v_terminal_info` AS SELECT  t_terminal.terminal_name as terminal_name,
                                    t_terminal.terminal_id as terminal_id, t_terminal.device_id as device_id,
                                    t_air_condition.air_id as air_id, t_air_condition.air_name as air_name,
                                    t_air_condition.pi as air_pi, t_air_condition.power as air_power,
                                    t_air_condition.brand as air_brand, t_air_condition.factory as air_factory,
                                    t_air_condition.air_model as air_model,
                                    t_building.building_id as building_id, t_building.building_name as building_name,
                                    t_building.parent_id as building_parent_id,
                                    t_dept.dept_id as dept_id, t_dept.dept_name as dept_name,
                                    t_dept.parent_id as dept_parent_id,
                                    t_terminal.air_buy_date as air_buy_date, t_terminal.maintenance_records as maintenance_records,
                                    t_terminal.description as description,
                                    t_terminal.terminal_sn as terminal_sn, t_terminal.terminal_version as terminal_version,
                                    t_etc.etc_id as etc_id, t_etc.etc_name as etc_name,
                                    t_etc.max_heat as max_heat,
                                    t_etc.min_heat as min_heat, t_etc.mid_heat as mid_heat,
                                    t_etc.max_cool as max_cool, t_etc.min_cool as min_cool,
                                    t_etc.mid_cool as mid_cool,
                                    t_etc.max_humidity as max_humidity, t_etc.min_humidity as min_humidity,
                                    t_etc.etc_mode as etc_mode,
                                    t_rule.rule_id as rule_id, t_rule.rule_name as rule_name,
                                    t_rule.rule_content as rule_content,
                                    t_terminal.platform_id as platform_id, t_terminal.platform_name as platform_name,
                                    t_terminal.update_time as update_time, t_terminal.create_time as create_time,
                                    t_system_param.platform_domain as platform_domain, t_system_param.ip as ip, t_system_param.port as port,
                                    t_system_param.back_ip as back_ip, t_system_param.ssid as ssid,
                                    t_system_param.ssid_password as ssid_password,
                                    t_system_param.status_interval as status_interval
                          FROM t_terminal, t_air_condition, t_building, t_dept, t_etc, t_rule, t_system_param
                          WHERE (t_terminal.air_id = t_air_condition.air_id)
                                and (t_building.building_id = t_terminal.building_id)
                                and (t_dept.dept_id = t_terminal.dept_id)
                                and (t_etc.etc_id = t_terminal.etc_id)
                                and (t_rule.rule_id = t_terminal.rule_id)
                                and (t_system_param.platform_id = t_terminal.platform_id)
&&
DELIMITER;

DELIMITER &&
CREATE VIEW `v_control` AS SELECT  t_terminal.terminal_name as terminal_name,
                                    t_terminal.terminal_id as terminal_id, t_terminal.device_id as device_id,
                                    t_air_condition.air_id as air_id, t_air_condition.air_name as air_name,
                                    t_air_condition.pi as air_pi, t_air_condition.power as air_power,
                                    t_air_condition.brand as air_brand, t_air_condition.factory as air_factory,
                                    t_air_condition.air_model as air_model,
                                    t_building.building_id as building_id, t_building.building_name as building_name,
                                    t_building.parent_id as building_parent_id,
                                    t_dept.dept_id as dept_id, t_dept.dept_name as dept_name,
                                    t_dept.parent_id as dept_parent_id,
                                    t_terminal.air_buy_date as air_buy_date, t_terminal.maintenance_records as maintenance_records,
                                    t_terminal.description as description,
                                    t_terminal.terminal_sn as terminal_sn, t_terminal.terminal_version as terminal_version,
                                    t_terminal.platform_id as platform_id, t_terminal.platform_name as platform_name,
                                    t_terminal.update_time as update_time, t_terminal.create_time as create_time,
                                    t_control.command as command, t_control.status as control_status,
                                    t_control.control_id as control_id
                          FROM t_terminal, t_air_condition, t_building, t_dept, t_control
                          WHERE t_terminal.air_id = t_air_condition.air_id
                                and t_building.building_id = t_terminal.building_id
                                and t_dept.dept_id = t_terminal.dept_id
                                and t_control.terminal_id = t_terminal.terminal_id
&&
DELIMITER ;

DELIMITER &&
CREATE VIEW `v_terminal_alarm` AS SELECT  t_terminal.terminal_name as terminal_name,
                                    t_terminal.terminal_id as terminal_id, t_terminal.device_id as device_id,
                                    t_air_condition.air_id as air_id, t_air_condition.air_name as air_name,
                                    t_air_condition.pi as air_pi, t_air_condition.power as air_power,
                                    t_air_condition.brand as air_brand, t_air_condition.factory as air_factory,
                                    t_air_condition.air_model as air_model,
                                    t_building.building_id as building_id, t_building.building_name as building_name,
                                    t_building.parent_id as building_parent_id,
                                    t_dept.dept_id as dept_id, t_dept.dept_name as dept_name,
                                    t_dept.parent_id as dept_parent_id,
                                    t_terminal.air_buy_date as air_buy_date, t_terminal.maintenance_records as maintenance_records,
                                    t_terminal.description as description,
                                    t_terminal.terminal_sn as terminal_sn, t_terminal.terminal_version as terminal_version,
                                    t_terminal.platform_id as platform_id, t_terminal.platform_name as platform_name,
                                    t_terminal.update_time as update_time, t_terminal.create_time as create_time,
                                    t_alarm.run_mode as run_mode, t_alarm.running as running,
                                    t_alarm.temp as temp, t_alarm.window as window, t_alarm.human as human,
                                    t_alarm.door as door, t_alarm.consumption as consumption,
                                    t_alarm.total_consumption as total_consumption,
                                    t_alarm.humidity as humidity,
                                    t_alarm.alarm_time as alarm_time
                          FROM t_terminal, t_air_condition, t_building, t_dept, t_alarm
                          WHERE t_terminal.air_id = t_air_condition.air_id
                                and t_building.building_id = t_terminal.building_id
                                and t_dept.dept_id = t_terminal.dept_id
                                and t_alarm.device_id = t_terminal.device_id
&&
DELIMITER ;

DELIMITER &&
CREATE VIEW `v_terminal_real_status` AS SELECT  t_terminal.terminal_name as terminal_name,
                                    t_terminal.terminal_id as terminal_id, t_terminal.device_id as device_id,
                                    t_air_condition.air_id as air_id, t_air_condition.air_name as air_name,
                                    t_air_condition.pi as air_pi, t_air_condition.power as air_power,
                                    t_air_condition.brand as air_brand, t_air_condition.factory as air_factory,
                                    t_air_condition.air_model as air_model,
                                    t_building.building_id as building_id, t_building.building_name as building_name,
                                    t_building.parent_id as building_parent_id,
                                    t_dept.dept_id as dept_id, t_dept.dept_name as dept_name,
                                    t_dept.parent_id as dept_parent_id,
                                    t_terminal.air_buy_date as air_buy_date, t_terminal.maintenance_records as maintenance_records,
                                    t_terminal.description as description,
                                    t_terminal.terminal_sn as terminal_sn, t_terminal.terminal_version as terminal_version,
                                    t_terminal.platform_id as platform_id, t_terminal.platform_name as platform_name,
                                    t_terminal.update_time as update_time, t_terminal.create_time as create_time,
                                    t_etc.etc_id as etc_id, t_etc.etc_name as etc_name,
                                    t_etc.max_heat as max_heat,
                                    t_etc.min_heat as min_heat, t_etc.mid_heat as mid_heat,
                                    t_etc.max_cool as max_cool, t_etc.min_cool as min_cool,
                                    t_etc.mid_cool as mid_cool,
                                    t_etc.max_humidity as max_humidity, t_etc.min_humidity as min_humidity,
                                    t_etc.etc_mode as etc_mode,                                    
                                    t_rule.rule_id as rule_id, t_rule.rule_name as rule_name,
                                    t_rule.rule_content as rule_content,
                                    t_real_status.run_mode as run_mode, t_real_status.running as running,
                                    t_real_status.temp as temp, t_real_status.window as window, t_real_status.human as human,
                                    t_real_status.door as door, t_real_status.consumption as consumption,
                                    t_real_status.total_consumption as total_consumption,
                                    t_real_status.humidity as humidity, t_real_status.status_time as status_time
                          FROM t_terminal, t_air_condition, t_building, t_dept, t_real_status, t_etc, t_rule
                          WHERE (t_terminal.air_id = t_air_condition.air_id)
                                and (t_building.building_id = t_terminal.building_id)
                                and (t_dept.dept_id = t_terminal.dept_id)
                                and (t_real_status.device_id = t_terminal.device_id)
                                and (t_etc.etc_id = t_terminal.etc_id)
                                and (t_rule.rule_id = t_terminal.rule_id)
&&
DELIMITER ;

DELIMITER &&
CREATE VIEW `v_terminal_status_stat` AS SELECT  t_terminal.terminal_name as terminal_name,
                                    t_terminal.terminal_id as terminal_id, t_terminal.device_id as device_id,
                                    t_air_condition.air_id as air_id, t_air_condition.air_name as air_name,
                                    t_air_condition.pi as air_pi, t_air_condition.power as air_power,
                                    t_air_condition.brand as air_brand, t_air_condition.factory as air_factory,
                                    t_air_condition.air_model as air_model,
                                    t_building.building_id as building_id, t_building.building_name as building_name,
                                    t_building.parent_id as building_parent_id,
                                    t_dept.dept_id as dept_id, t_dept.dept_name as dept_name,
                                    t_dept.parent_id as dept_parent_id,
                                    t_terminal.air_buy_date as air_buy_date, t_terminal.maintenance_records as maintenance_records,
                                    t_terminal.description as description,
                                    t_terminal.terminal_sn as terminal_sn, t_terminal.terminal_version as terminal_version,
                                    t_terminal.platform_id as platform_id, t_terminal.platform_name as platform_name,
                                    t_terminal.update_time as update_time, t_terminal.create_time as create_time,
                                    t_etc.etc_id as etc_id, t_etc.etc_name as etc_name,
                                    t_rule.rule_id as rule_id, t_rule.rule_name as rule_name,
                                    t_status_stat.stat as stat, t_status_stat.running_time as running_time,
                                    t_status_stat.human_time as human_time, t_status_stat.window_time as window_time,
                                    t_status_stat.door_time as door_time, t_status_stat.consumption as consumption,
                                    t_status_stat.total_consumption as total_consumption,
                                    t_status_stat.humidity as humidity, t_status_stat.stat_time as stat_time,
                                    t_status_stat.temp as temp, t_status_stat.hour_consumption as hour_consumption
                          FROM t_terminal, t_air_condition, t_building, t_dept, t_status_stat, t_etc, t_rule
                          WHERE (t_terminal.air_id = t_air_condition.air_id)
                                and (t_building.building_id = t_terminal.building_id)
                                and (t_dept.dept_id = t_terminal.dept_id)
                                and (t_status_stat.device_id = t_terminal.device_id)
                                and (t_etc.etc_id = t_terminal.etc_id)
                                and (t_rule.rule_id = t_terminal.rule_id)
&&
DELIMITER ;

#################################################################################################################
# CREATE TRIGGER FOR TABLE t_terminal
DELIMITER &&
CREATE TRIGGER ADD_REAL_STATUS_FOR_TERMINAL
after INSERT ON t_terminal
FOR each row
BEGIN
  INSERT INTO t_real_status(device_id,run_mode,running,temp,window,human,door,consumption,total_consumption,humidity,status_time,platform_id,platform_name,update_time,create_time) value(NEW.device_id, 0, 0, 0, 0, 0, 0, 0, 0, 0, NEW.create_time, NEW.platform_id, NEW.platform_name, NEW.update_time, NEW.create_time) ON DUPLICATE KEY UPDATE device_id=NEW.device_id;
END
&&
DELIMITER ;

#################################################################################################################

# CREATE TRIGGER FOR TABLE t_status
DELIMITER &&
CREATE TRIGGER ADD_REAL_STATUS_FOR_STATUS
after INSERT ON t_status
FOR each row
BEGIN
  INSERT INTO t_real_status(device_id, run_mode, running, temp, window, human, door, consumption, total_consumption, humidity, status_time, update_time) value(NEW.device_id, NEW.run_mode, NEW.running,NEW.temp, NEW.window,NEW.human,NEW.door,NEW.consumption,NEW.total_consumption,NEW.humidity,NEW.status_time,NEW.update_time) ON DUPLICATE KEY UPDATE device_id=NEW.device_id;
END
&&
DELIMITER ;

#################################################################################################################

DELIMITER &&
CREATE TRIGGER ADD_DEPT_FOR_SYSTEM
before INSERT ON t_dept
FOR each row
BEGIN
  DECLARE var_dept_id                varchar(128);
  DECLARE var_dept_f_tree            varchar(1024);

  IF NEW.dept_level > 1 THEN
     SELECT dept_f_tree,dept_id INTO var_dept_f_tree,var_dept_id FROM t_dept WHERE dept_id = NEW.parent_id;
     SET NEW.dept_f_tree = CONCAT(var_dept_f_tree, "-", var_dept_id);
  END IF;
  IF NEW.dept_level = 1 THEN
    SET NEW.dept_f_tree = NEW.parent_id;
  END IF;
END
&&
DELIMITER ;

#################################################################################################################

DELIMITER &&
CREATE TRIGGER ADD_BUILDING_FOR_SYSTEM
before INSERT ON t_building
FOR each row
BEGIN
  DECLARE var_building_id                varchar(128);
  DECLARE var_building_f_tree            varchar(1024);

  IF NEW.building_level > 1 THEN
     SELECT building_f_tree,building_id INTO var_building_f_tree,var_building_id FROM t_building WHERE building_id = NEW.parent_id;
     SET NEW.building_f_tree = CONCAT(var_building_f_tree, "-", var_building_id);
  END IF;
  IF NEW.building_level = 1 THEN
    SET NEW.building_f_tree = NEW.parent_id;
  END IF;
END
&&
DELIMITER ;

#################################################################################################################

DELIMITER &&
CREATE TRIGGER ADD_CONTROL_FOR_SYSTEM
before INSERT ON t_control
FOR each row
BEGIN
  DECLARE var_device_id                varchar(128);

  SELECT device_id INTO var_device_id FROM t_terminal WHERE terminal_id = NEW.terminal_id;
  SET NEW.device_id = var_device_id;
END
&&
DELIMITER ;

#################################################################################################################
#insert into t_alarm(device_id,run_mode,running,temp,window,human,door,consumption,humidity,alarm_time,platform_id,update_time,create_time) values('1', 1, 1, 26, 1, 1, 1, 1200, 75, 1494662203, 1, 1494662203, 1494662203);
#insert into t_status(device_id,run_mode,running,temp,window,human,door,consumption,humidity,status_time,platform_id,platform_name,update_time,create_time) values('1', 1, 1, 26, 1, 1, 1, 1200, 75, 1494662203, 1, "tointel", 1494662203, 1494662203);

#insert into t_dept_stat value('D36024639F2604B59CB5FD1D1FBE4712C', '教务处', 6, 6, 0, 0, 25, 60, 8, 1, 1520956800, 68, 1, 'tointel', 1511069442, 1511069442);
#insert into t_dept_stat value('D36024639F2604B59CB5FD1D1FBE4712C', '教务处', 6, 6, 0, 0, 25, 60, 8, 1, 1520870400, 68, 1, 'tointel', 1511069442, 1511069442);

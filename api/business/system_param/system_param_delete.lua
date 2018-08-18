-- *********************************************************************************************************
-- author: zhouchangyue
-- QQ:   23199412
-- 文件实现了业务数据的逻辑检查,并调用数据库访问接口,将记录数据持久化到数据库
-- 函数命名必须为小写字母加下划线区分功能单词 例:do_action

-- 表t_system_param结构
-- CREATE TABLE `t_system_param` (
-- `platform_domain` varchar(512) NOT NULL DEFAULT '' COMMENT '平台域名',
-- `ip` varchar(128) NOT NULL DEFAULT '' COMMENT '平台IP',
-- `back_ip` varchar(128) NOT NULL DEFAULT '' COMMENT '备IP' ,
-- `port` int NOT NULL DEFAULT 10000 COMMENT '服务端口',
-- `ssid` varchar(128) NOT NULL DEFAULT '' COMMENT 'WIFI SSID名称',
-- `ssid_password` varchar(128) NOT NULL DEFAULT '' COMMENT 'WIFI 密码',
-- `status_interval` INT NOT NULL DEFAULT 0 COMMENT '状态发送间隔' ,
-- `description` VARCHAR(2048) NOT NULL DEFAULT '' COMMENT '备注',
-- `platform_id` varchar(128) NOT NULL DEFAULT '' COMMENT '平台ID',
-- `platform_name` VARCHAR(32) NOT NULL DEFAULT '' COMMENT '平台名称',
-- `update_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新时间',
-- `create_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建时间',
-- PRIMARY KEY (`platform_id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 MAX_ROWS=10000 AVG_ROW_LENGTH=5000;
-- *********************************************************************************************************

local business = {}

-- #########################################################################################################
-- 函数名: do_action
-- 函数功能: 删除多条记录
-- 参数定义:
-- ids: 删除对象ID List
-- 返回值:
-- result: bool 函数成功或者失败
-- errmsg: 失败是,返回失败描述信息
-- #########################################################################################################
function business:do_action()

    local configure = require "configure"
    -- 删除记录
    local sql = "delete from t_system_param where platform_id = '" .. configure.PLATFORM.ID .. "'"
    local dao = require "dao"
    local LOG = require "log"
    LOG:DEBUG("delete table:t_system_param" .. " sql:" .. sql)
    local result,errmsg = dao:execute_by_sql(configure.DBCService, sql)

    return result, errmsg
end

return business
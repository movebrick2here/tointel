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
-- 函数名: name_is_exists
-- 函数功能: 查询名称是否存在
-- 参数定义:
-- name: 名称
-- 返回值:
-- result: bool true存在,false不存在
-- #########################################################################################################
function business:name_is_exists(name)
    local configure = require "configure"
    local sql = "select platform_id from t_system_param where platform_name='" .. name .. "'"
    local dao = require "dao"
    local LOG = require "log"
    local cjson = require "cjson"
    LOG:DEBUG("check sql:" .. sql)
    local result,info = dao:query_by_sql(configure.DBCService, sql)
    if false == result then
        return false, info
    end
    if nil ~= info then
        LOG:DEBUG("check response:" .. cjson.encode(info))
    else
        LOG:DEBUG("check response is nil")
    end
    if nil == info or nil == info.list or 0 >= #info.list then
        return false
    end

    return true
end

return business


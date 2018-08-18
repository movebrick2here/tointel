-- *********************************************************************************************************
-- author: zhouchangyue
-- QQ:   23199412
-- 文件实现了业务数据的逻辑检查,并调用数据库访问接口,将记录数据持久化到数据库
-- 函数命名必须为小写字母加下划线区分功能单词 例:do_action

-- 表t_terminal结构
-- CREATE TABLE `t_terminal` (
-- `terminal_id` VARCHAR(128) NOT NULL DEFAULT '' COMMENT 'ID' ,
-- `terminal_name` VARCHAR(128) NOT NULL DEFAULT '' COMMENT '设备名称',
-- `device_id` INT NOT NULL UNIQUE DEFAULT 0 COMMENT '设备id' ,
-- `terminal_id` VARCHAR(128) NOT NULL DEFAULT '' COMMENT '配置id' ,
-- `rule_id` VARCHAR(128) NOT NULL DEFAULT '' COMMENT '规则id',
-- `air_id` VARCHAR(128) NOT NULL DEFAULT '' COMMENT '空调id',
-- `air_buy_date` bigint NOT NULL DEFAULT 0 COMMENT '购买日期' ,
-- `building_id` VARCHAR(128) NOT NULL DEFAULT '' COMMENT '建筑物id',
-- `dept_id` VARCHAR(128) NOT NULL DEFAULT '' COMMENT '部门id' ,
-- `maintenance_records` text NOT NULL  COMMENT '维修记录',
-- `terminal_sn` varchar(128) NOT NULL DEFAULT '' COMMENT '设备序列号',
-- `terminal_version` varchar(32) NOT NULL DEFAULT '' COMMENT '设备版本号',
-- `description` VARCHAR(2048) NOT NULL DEFAULT '' COMMENT '备注',
-- `platform_id` varchar(128) NOT NULL DEFAULT '' COMMENT '平台ID',
-- `platform_name` VARCHAR(32) NOT NULL DEFAULT '' COMMENT '平台名称',
-- `update_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新时间',
-- `create_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建时间',
-- PRIMARY KEY (`terminal_id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 MAX_ROWS=1000000 AVG_ROW_LENGTH=4000;
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
    local sql = "select terminal_id from t_terminal where terminal_name='" .. name .. "'"
    local dao = require "dao"
    local configure = require "configure"
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


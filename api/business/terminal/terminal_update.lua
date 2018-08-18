-- *********************************************************************************************************
-- author: zhouchangyue
-- QQ:   23199412
-- 文件实现了业务数据的逻辑检查,并调用数据库访问接口,将数记录据持久化到数据库
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
-- 函数名: add_timestamp
-- 函数功能: 添加表中更新时间戳
-- 参数定义:
-- tbl: table对象 记录值,key-value形式对
-- 返回值:
-- 无
-- #########################################################################################################
function business:add_timestamp(tbl)
    local math = require "math"
    local time_obj = require "socket"
    tbl.update_time = math.ceil(time_obj.gettime())
end

-- #########################################################################################################
-- 函数名: covert_array_to_string
-- 函数功能:
-- 参数定义:
-- tbl: array
-- 返回值:
-- 无
-- #########################################################################################################
function business:covert_array_to_string(tbl)
    local cjson = require "cjson"
    return cjson.encode(tbl)
end

-- #########################################################################################################
-- 函数名: make_conditions
-- 函数功能: 封装条件对象
-- 参数定义:
-- tbl: table对象 记录值,key-value形式对
-- 返回值:
-- conditions
-- #########################################################################################################
function business:make_conditions(tbl)
    local conditions = { item_tbl = {}, op_tbl = {} }
    conditions.item_tbl.terminal_id = tbl.terminal_id
    return conditions
end

-- #########################################################################################################
-- 函数名: do_action
-- 函数功能: 修改记录
-- 参数定义:
-- tbl: table对象 记录值,key-value形式对
-- 返回值:
-- result: bool 函数成功或者失败
-- errmsg: 失败是,返回失败描述信息
-- #########################################################################################################
function business:do_action(tbl)
    if nil ~= tbl.terminal_name then
        -- 检查名称是否重复
        local check = require "terminal_check"
        local result,errmsg = check:name_is_exists(tbl.terminal_name)
        if true == result then
            return false, "数据库中已有名称:".. tbl.terminal_name .. "的记录"
        end

        if false == result and nil ~= errmsg then
            return false, errmsg
        end
    end

    -- 添加时间戳
    business:add_timestamp(tbl)
    local conditions = business:make_conditions(tbl)
    tbl.terminal_id = nil
    if nil ~= tbl.maintenance_records then
        tbl.maintenance_records = business:covert_array_to_string(tbl.maintenance_records)
    end
    -- 修改记录
    local configure = require "configure"
    local dao = require "dao"
    local table_name = configure.DBCService.DB .. ".t_terminal"
    local LOG = require "log"
    local cjson = require "cjson"
    LOG:DEBUG("update table:" .. table_name .. " value:" .. cjson.encode(tbl))
    local result,errmsg = dao:update(configure.DBCService, table_name, tbl, conditions)
    if false == result then
        LOG:ERROR("update table:" .. table_name .. " value:" .. cjson.encode(tbl) .. " failed msg:" .. errmsg)
    end

    return result, errmsg
end

return business
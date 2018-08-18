-- *********************************************************************************************************
-- author: zhouchangyue
-- QQ:   23199412
-- 文件实现了业务数据的逻辑检查,并调用数据库访问接口,将数记录据持久化到数据库
-- 函数命名必须为小写字母加下划线区分功能单词 例:do_action

-- 表t_rule结构
-- CREATE TABLE `t_rule` (
-- `rule_id` VARCHAR(128) NOT NULL DEFAULT '' COMMENT 'ID' ,
-- `rule_name` VARCHAR(256) NOT NULL DEFAULT ''  COMMENT '规则名称' ,
-- `rule_content` INT NOT NULL DEFAULT 0 COMMENT '规则内容',
-- `description` VARCHAR(2048) NOT NULL DEFAULT '' COMMENT '备注',
-- `platform_id` INT NOT NULL DEFAULT 0 COMMENT '平台ID',
-- `platform_name` VARCHAR(32) NOT NULL DEFAULT '' COMMENT '平台名称',
-- `update_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新时间',
-- `create_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建时间',
-- PRIMARY KEY (`rule_id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 MAX_ROWS=10000 AVG_ROW_LENGTH=4000;
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
-- 函数名: make_conditions
-- 函数功能: 封装条件对象
-- 参数定义:
-- tbl: table对象 记录值,key-value形式对
-- 返回值:
-- conditions
-- #########################################################################################################
function business:make_conditions(tbl)
    local conditions = { item_tbl = {}, op_tbl = {} }
    conditions.item_tbl.rule_id = tbl.rule_id
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
    if nil ~= tbl.rule_name then
        -- 检查名称是否重复
        local check = require "rule_check"
        local result,errmsg = check:name_is_exists(tbl.rule_name)
        if true == result then
            return false, "数据库中已有名称:".. tbl.rule_name .. "的记录"
        end

        if false == result and nil ~= errmsg then
            return false, errmsg
        end
    end

    -- 添加时间戳
    business:add_timestamp(tbl)
    local conditions = business:make_conditions(tbl)
    tbl.rule_id = nil

    -- 修改记录
    local configure = require "configure"
    local dao = require "dao"
    local table_name = configure.DBCService.DB .. ".t_rule"
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
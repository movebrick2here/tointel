-- *********************************************************************************************************
-- author: zhouchangyue
-- QQ:   23199412
-- 文件实现了业务数据的逻辑检查,并调用数据库访问接口,将记录数据持久化到数据库
-- 函数命名必须为小写字母加下划线区分功能单词 例:do_action

-- 表t_control结构
-- CREATE TABLE `t_control` (
-- `control_id` VARCHAR(128) NOT NULL DEFAULT '' COMMENT 'id',
-- `terminal_id` VARCHAR(128) NOT NULL DEFAULT '' COMMENT '设备id',
-- `command` tinyint NOT NULL DEFAULT 0 COMMENT '1 开 2 关 3 下发参数设置 4 下发系统设置' ,
-- `status` tinyint NOT NULL DEFAULT 0 COMMENT '0 not send 1 sending 2 execute success 3 execute failed' ,
-- `platform_id` varchar(128) NOT NULL DEFAULT '' COMMENT '平台ID',
-- `platform_name` VARCHAR(32) NOT NULL DEFAULT '' COMMENT '平台名称',
-- `update_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新时间',
-- `create_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建时间',
-- PRIMARY KEY (`control_id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 MAX_ROWS=100000 AVG_ROW_LENGTH=1000;
-- *********************************************************************************************************

local business = {}

-- #########################################################################################################
-- 函数名: results_string_to_number
-- 函数功能: 记录中字符字段转换为整型字段
-- 参数定义:
-- info: 查询对象信息
-- 返回值:
-- 无
-- #########################################################################################################
function business:results_string_to_number(info)
    if nil == info or nil == info.list then
        return
    end
    local num = #info.list
    local cjson = require "cjson"
    for i = 1, num do
        if ( nil ~= info.list[i].device_id) then
            info.list[i]["device_id"] = tonumber(info.list[i].device_id)
        end

        if ( nil ~= info.list[i].command) then
            info.list[i]["command"] = tonumber(info.list[i].command)
        end
        if ( nil ~= info.list[i].control_status) then
            info.list[i]["control_status"] = tonumber(info.list[i].control_status)
        end
        if ( nil ~= info.list[i].create_time) then
            info.list[i]["create_time"] = tonumber(info.list[i].create_time)
        end
        if ( nil ~= info.list[i].update_time) then
            info.list[i]["update_time"] = tonumber(info.list[i].update_time)
        end
    end
end

-- #########################################################################################################
-- 函数名: make_conditions
-- 函数功能: 封装条件对象
-- 参数定义:
-- id: 对象ID
-- 返回值:
-- conditions
-- #########################################################################################################
function business:make_conditions(tbl)
    local conditions = { item_tbl = {}, op_tbl = {} }

    if nil ~= tbl.terminal_id then
        conditions.item_tbl.terminal_id = tbl.terminal_id
    end

    if nil ~= tbl.device_id then
        conditions.item_tbl.device_id = tbl.device_id
    end    

    if nil ~= tbl.terminal_name then
        conditions.item_tbl.terminal_name = tbl.terminal_name .. " LIKE"
    end

    if nil ~= tbl.air_id then
        conditions.item_tbl.air_id = tbl.air_id
    end

    if nil ~= tbl.air_name then
        conditions.item_tbl.air_name = tbl.air_name .. " LIKE"
    end

    if nil ~= tbl.dept_id then
        conditions.item_tbl.dept_id = tbl.dept_id
    end

    if nil ~= tbl.dept_name then
        conditions.item_tbl.dept_name = tbl.dept_name .. " LIKE"
    end

    if nil ~= tbl.building_id then
        conditions.item_tbl.building_id = tbl.building_id
    end

    if nil ~= tbl.building_name then
        conditions.item_tbl.building_name = tbl.building_name .. " LIKE"
    end

    local util = require "util"
    local num = util:table_length(conditions.item_tbl)
    if 0 >= num then
        conditions.item_tbl = nil
        conditions.op_tbl = nil
        return
    end

    for i = 1, (num - 1) do
        conditions.op_tbl[i] = 1
    end

    return conditions
end

-- #########################################################################################################
-- 函数名: do_action
-- 函数功能: 查询单条记录
-- 参数定义:
-- tbl: table对象 记录值,key-value形式对
-- 返回值:
-- result: bool 函数成功或者失败
-- errmsg: 失败是,返回失败描述信息
-- info: 成功时返回,对象信息
-- #########################################################################################################
function business:do_action(tbl)
    -- 封装条件
    local conditions = business:make_conditions(tbl)

    -- 查询记录
    local columns = { "control_id", "terminal_id", "device_id", "building_id", "building_name", "dept_id", "dept_name",
        "air_id", "air_name", "command", "control_status",  "create_time", "update_time" }

    local configure = require "configure"
    local dao = require "dao"
    local table_name = configure.DBCService.DB .. ".v_control"
    local LOG = require "log"
    local cjson = require "cjson"
    LOG:DEBUG("query table:" .. table_name .. " condition:" .. cjson.encode(tbl))
    local result,info = dao:query(configure.DBCService, table_name, columns, conditions)
    if false == result then
        LOG:ERROR("query table:" .. table_name .. " condition:" .. cjson.encode(tbl) .. " failed msg:" .. info)
        return false,info
    end

    LOG:DEBUG("query table:" .. table_name .. " condition:" .. cjson.encode(tbl) .. " response:" .. cjson.encode(info))
    if nil == info or nil == info.list or 0 >= #info.list then
        return false, "数据库无记录"
    end

    business:results_string_to_number(info)

    return true, info.list
end

return business
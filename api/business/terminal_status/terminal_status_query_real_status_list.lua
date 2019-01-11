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
        if (nil ~= info.list[i].maintenance_records and 0 < string.len(info.list[i].maintenance_records)) then
            info.list[i].maintenance_records = cjson.decode(info.list[i].maintenance_records)
        end

        if ( nil ~= info.list[i].door) then
            info.list[i]["door"] = tonumber(info.list[i].door)
        end
        if ( nil ~= info.list[i].consumption) then
            info.list[i]["consumption"] = tonumber(info.list[i].consumption)
        end
        if ( nil ~= info.list[i].total_consumption) then
            info.list[i]["total_consumption"] = tonumber(info.list[i].total_consumption)
        end
        if ( nil ~= info.list[i].humidity) then
            info.list[i]["humidity"] = tonumber(info.list[i].humidity)
        end
        if ( nil ~= info.list[i].status_time) then
            info.list[i]["status_time"] = tonumber(info.list[i].status_time)
        end

        local math = require "math"
        local time_obj = require "socket"
    
        local configure = require "configure"
        if (nil == info.list[i]["status_time"]) or 
            (info.list[i]["status_time"] < math.ceil(time_obj.gettime()) - configure.OFFLINE) then
            info.list[i]["status"] = 2
        else
            info.list[i]["status"] = 1
        end


        if ( nil ~= info.list[i].running) then
            info.list[i]["running"] = tonumber(info.list[i].running)
            if info.list[i]["running"] ~= 1 then
                info.list[i]["running"] = 2
            end
        end
        if ( nil ~= info.list[i].temp) then
            info.list[i]["temp"] = tonumber(info.list[i].temp)
        end

        if ( nil ~= info.list[i].window) then
            info.list[i]["window"] = tonumber(info.list[i].window)
        end

        if ( nil ~= info.list[i].human) then
            info.list[i]["human"] = tonumber(info.list[i].human)
        end

        if ( nil ~= info.list[i].run_mode) then
            info.list[i]["run_mode"] = tonumber(info.list[i].run_mode)
        end

        if ( nil ~= info.list[i].max_heat) then
            info.list[i]["max_heat"] = tonumber(info.list[i].max_heat)
        end
        if ( nil ~= info.list[i].mid_heat) then
            info.list[i]["mid_heat"] = tonumber(info.list[i].mid_heat)
        end
        if ( nil ~= info.list[i].min_heat) then
            info.list[i]["min_heat"] = tonumber(info.list[i].min_heat)
        end
        if ( nil ~= info.list[i].max_cool) then
            info.list[i]["max_cool"] = tonumber(info.list[i].max_cool)
        end
        if ( nil ~= info.list[i].mid_cool) then
            info.list[i]["mid_cool"] = tonumber(info.list[i].mid_cool)
        end
        if ( nil ~= info.list[i].min_cool) then
            info.list[i]["min_cool"] = tonumber(info.list[i].min_cool)
        end
        if ( nil ~= info.list[i].max_humidity) then
            info.list[i]["max_humidity"] = tonumber(info.list[i].max_humidity)
        end
        if ( nil ~= info.list[i].min_humidity) then
            info.list[i]["min_humidity"] = tonumber(info.list[i].min_humidity)
        end
                

        if ( nil ~= info.list[i].device_id) then
            info.list[i]["device_id"] = tonumber(info.list[i].device_id)
        end

        if ( nil ~= info.list[i].air_buy_date) then
            info.list[i]["air_buy_date"] = tonumber(info.list[i].air_buy_date)
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
-- tbl: table对象 记录值,key-value形式对
-- 返回值:
-- conditions
-- #########################################################################################################
function business:make_conditions(tbl)
    local conditions = { item_tbl = {}, op_tbl = {} }
    if nil ~= tbl.terminal_id then
        conditions.item_tbl.terminal_id = tbl.terminal_id
    end

    if nil ~= tbl.terminal_name then
        conditions.item_tbl.terminal_name = tbl.terminal_name .. " LIKE"
    end

    if nil ~= tbl.device_id then
        conditions.item_tbl.device_id = tbl.device_id
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
        local query = require "building_children"
        local result, names = query:query_building_children(tbl.building_name)

        if false == result then
            conditions.item_tbl.building_name = tbl.building_name .. " LIKE"
        else
            local LOG = require "log"
            LOG:DEBUG(" *****************************: " .. names)

            conditions.item_tbl.building_name = names .. " IN"
        end
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
-- 函数名: make_order
-- 函数功能: 封装排序对象
-- 参数定义:
-- 无:
-- 返回值:
-- order: 排序对象,包含需要排序的字段和升降序
-- #########################################################################################################
function business:make_order()
    local order = {}
    -- 设置按时间排序 1 DES 2 ASC
    order.update_time = 1
    order.device_id = 2
    return order
end

-- #########################################################################################################
-- 函数名: make_pages
-- 函数功能: 封装分页对象
-- 参数定义:
-- tbl: table对象 记录值,key-value形式对
-- 返回值:
-- pages: 分页对象,包含分页码和页大小
-- #########################################################################################################
function business:make_pages(tbl)
    local pages = {}
    pages.page_number = tbl.page_number
    pages.page_size = tbl.page_size
    return pages
end

-- #########################################################################################################
-- 函数名: do_action
-- 函数功能: 查询列表信息
-- 参数定义:
-- tbl: table对象 记录值,key-value形式对
-- 返回值:
-- result: bool 函数成功或者失败
-- errmsg: 失败是,返回失败描述信息
-- info: 成功时返回,对象信息
-- #########################################################################################################
function business:do_action(tbl)
    -- 封装查询条件和排序字段以及分页
    local columns = { "terminal_id", "terminal_name", "device_id", "air_id", "air_name", "air_model",
        "building_id", "building_name", "dept_id", "dept_name",
        "run_mode", "running", "temp", "window", "human", "door", "consumption", "total_consumption",
        "humidity", "status_time", "max_heat", "mid_heat", "min_heat", "max_cool", "mid_cool", "min_cool", "max_humidity", "min_humidity",
        "etc_mode", "rule_content", "etc_id", "etc_name", "rule_id", "rule_name",
        "maintenance_records", "terminal_sn", "terminal_version", "description",  "create_time", "update_time" }
    local conditions = business:make_conditions(tbl)
    local order = business:make_order()
    local pages = business:make_pages(tbl)

    -- 查询
    local configure = require "configure"
    local dao = require "dao"
    local table_name = configure.DBCService.DB .. ".v_terminal_real_status"
    local LOG = require "log"
    local cjson = require "cjson"
    LOG:DEBUG("query table:" .. table_name .. " value:" .. cjson.encode(tbl))
    local result,info = dao:query(configure.DBCService, table_name, columns, conditions, pages, order)
    if false == result then
        LOG:ERROR("query table:" .. table_name .. " value:" .. cjson.encode(tbl) .. " failed msg:" .. info)
        return false,info
    end

    LOG:DEBUG("query table:" .. table_name .. " value:" .. cjson.encode(tbl) .. " response:" .. cjson.encode(info))
    if nil == info or nil == info.list or 0 >= #info.list then
        return false, "数据库无记录"
    end

    business:results_string_to_number(info)

    return true, info
end

return business


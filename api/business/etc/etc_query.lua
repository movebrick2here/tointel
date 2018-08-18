-- *********************************************************************************************************
-- author: zhouchangyue
-- QQ:   23199412
-- 文件实现了业务数据的逻辑检查,并调用数据库访问接口,将记录数据持久化到数据库
-- 函数命名必须为小写字母加下划线区分功能单词 例:do_action

-- 表t_etc结构
-- CREATE TABLE `t_etc` (
-- `etc_id` VARCHAR(128) NOT NULL DEFAULT '' COMMENT 'ID' ,
-- `etc_name` VARCHAR(256) NOT NULL DEFAULT ''  COMMENT '配置名称' ,
-- `max_heat` INT NOT NULL DEFAULT 0 COMMENT '制热最高温度' ,
-- `min_heat` INT NOT NULL DEFAULT 0 COMMENT '制热最低温度' ,
-- `mid_heat` INT NOT NULL DEFAULT 0 COMMENT '制热中间温度' ,
-- `max_cool` INT NOT NULL DEFAULT 0 COMMENT '制冷最高温度' ,
-- `min_cool` INT NOT NULL DEFAULT 0 COMMENT '制冷最低温度' ,
-- `mid_cool` INT NOT NULL DEFAULT 0 COMMENT '制冷中间温度' ,
-- `max_humidity` INT NOT NULL DEFAULT 0 COMMENT '除湿最高值' ,
-- `min_humidity` INT NOT NULL DEFAULT 0 COMMENT '除湿最低值' ,
-- `etc_mode` varchar(64) NOT NULL DEFAULT '' COMMENT '空调模式' ,
-- `description` VARCHAR(2048) NOT NULL DEFAULT '' COMMENT '备注',
-- `platform_id` varchar(128) NOT NULL DEFAULT '' COMMENT '平台ID',
-- `platform_name` VARCHAR(32) NOT NULL DEFAULT '' COMMENT '平台名称',
-- `update_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新时间',
-- `create_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建时间',
-- PRIMARY KEY (`etc_id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 MAX_ROWS=10000 AVG_ROW_LENGTH=4000;
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
function business:make_conditions(id)
    local conditions = { item_tbl = {}, op_tbl = {} }
    conditions.item_tbl.etc_id = id
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
function business:do_action(id)
    -- 封装条件
    local conditions = business:make_conditions(id)

    -- 查询记录
    local columns = { "etc_id", "etc_name", "max_heat", "min_heat","mid_heat", "max_cool", "min_cool","mid_cool",
        "max_humidity", "min_humidity", "etc_mode", "description",  "create_time", "update_time" }

    local configure = require "configure"
    local dao = require "dao"
    local table_name = configure.DBCService.DB .. ".t_etc"
    local LOG = require "log"
    local cjson = require "cjson"
    LOG:DEBUG("query table:" .. table_name .. " etc_id:" .. id)
    local result,info = dao:query(configure.DBCService, table_name, columns, conditions)
    if false == result then
        LOG:ERROR("query table:" .. table_name .. " etc_id:" .. id .. " failed msg:" .. info)
        return false,info
    end

    LOG:DEBUG("query table:" .. table_name .. " id:" .. id .. " response:" .. cjson.encode(info))
    if nil == info or nil == info.list or 0 >= #info.list then
        return false, "数据库无记录"
    end

    business:results_string_to_number(info)

    return true, info.list[1]
end

return business
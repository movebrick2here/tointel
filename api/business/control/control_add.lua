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
-- 函数名: add_timestamp
-- 函数功能: 添加表中更新时间戳和创建时间戳
-- 参数定义:
-- tbl: table对象 记录值,key-value形式对
-- 返回值:
-- 无
-- #########################################################################################################
function business:add_timestamp(tbl)
    local math = require "math"
    local time_obj = require "socket"
    tbl.update_time = math.ceil(time_obj.gettime())
    tbl.create_time = math.ceil(time_obj.gettime())

    local uuid = require "uuid"
    local time_obj = require "socket"
    uuid.seed(time_obj.gettime()*10000)

    local configure = require "configure"

    local records_tbl = {}
    for i=1, #tbl.terminal_id do
        local item = {}
        item.control_id = "C".. string.upper(uuid()) .. tostring(i)
        item.terminal_id = tbl.terminal_id[i]
        item.command = tbl.command
        item.status = 0
        item.platform_id = configure.PLATFORM.ID
        item.platform_name = configure.PLATFORM.NAME
        item.create_time = math.ceil(time_obj.gettime())
        item.update_time = math.ceil(time_obj.gettime())
        table.insert(records_tbl, item)
    end

    return records_tbl
end

-- #########################################################################################################
-- 函数名: do_action
-- 函数功能: 添加记录到数据库
-- 参数定义:
-- tbl: table对象 记录值,key-value形式对
-- 返回值:
-- result: bool 函数成功或者失败
-- errmsg: 失败是,返回失败描述信息
-- #########################################################################################################
function business:do_action(tbl)

    -- 添加时间戳
    local record_tbl = business:add_timestamp(tbl)

    -- 添加记录到数据库
    local configure = require "configure"
    local dao = require "dao"

    local table_name = configure.DBCService.DB .. ".t_control"
    local result,errmsg = dao:add(configure.DBCService, table_name, record_tbl)

    local LOG = require "log"
    local cjson = require "cjson"
    LOG:DEBUG("add table:" .. table_name .. " value:" .. cjson.encode(tbl))
    if false == result then
        LOG:ERROR("add table:" .. table_name .. " value:" .. cjson.encode(tbl) .. " failed msg:" .. errmsg)
        return result, errmsg
    end
    LOG:DEBUG("add table:" .. table_name .. " value:" .. cjson.encode(tbl) .. " success")

    return true
end

return business
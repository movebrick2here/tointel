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
        if ( nil ~= info.list[i].port) then
            info.list[i]["port"] = tonumber(info.list[i].port)
        end
        if ( nil ~= info.list[i].status_interval) then
            info.list[i]["status_interval"] = tonumber(info.list[i].status_interval)
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
-- 返回值:
-- conditions
-- #########################################################################################################
function business:make_conditions()
    local configure = require "configure"
    local conditions = { item_tbl = {}, op_tbl = {} }
    conditions.item_tbl.platform_id = configure.PLATFORM.ID
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
function business:do_action()
    -- 封装条件
    local conditions = business:make_conditions()

    -- 查询记录
    local columns = { "platform_domain", "ip", "back_ip", "port", "ssid", "ssid_password", "status_interval",
        "description",  "create_time", "update_time" }

    local configure = require "configure"
    local dao = require "dao"
    local table_name = configure.DBCService.DB .. ".t_system_param"
    local LOG = require "log"
    local cjson = require "cjson"
    LOG:DEBUG("query table:" .. table_name .. " platform_id:" .. configure.PLATFORM.ID)
    local result,info = dao:query(configure.DBCService, table_name, columns, conditions)
    if false == result then
        LOG:ERROR("query table:" .. table_name .. " platform_id:" .. configure.PLATFORM.ID .. " failed msg:" .. info)
        return false,info
    end

    LOG:DEBUG("query table:" .. table_name .. " platform_id:" .. configure.PLATFORM.ID .. " response:" .. cjson.encode(info))
    if nil == info or nil == info.list or 0 >= #info.list then
        return false, "数据库无记录"
    end

    business:results_string_to_number(info)

    return true, info.list[1]
end

return business
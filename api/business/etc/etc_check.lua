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
-- 函数名: name_is_exists
-- 函数功能: 查询名称是否存在
-- 参数定义:
-- name: 名称
-- 返回值:
-- result: bool true存在,false不存在
-- #########################################################################################################
function business:name_is_exists(name)
    local sql = "select etc_id from t_etc where etc_name='" .. name .. "'"
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


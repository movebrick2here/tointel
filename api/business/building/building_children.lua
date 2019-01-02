-- *********************************************************************************************************
-- author: zhouchangyue
-- QQ:   23199412
-- 文件实现了业务数据的逻辑检查,并调用数据库访问接口,将记录数据持久化到数据库
-- 函数命名必须为小写字母加下划线区分功能单词 例:do_action

-- 表t_building结构
-- CREATE TABLE `t_building` (
-- `building_id` VARCHAR(128) NOT NULL DEFAULT '' COMMENT 'ID' ,
-- `building_name` VARCHAR(256) NOT NULL DEFAULT ''  COMMENT '建筑物名称' ,
-- `parent_id` INT NOT NULL DEFAULT 0 COMMENT '父建筑物ID',
-- `description` VARCHAR(2048) NOT NULL DEFAULT '' COMMENT '备注',
-- `platform_id` INT NOT NULL DEFAULT 0 COMMENT '平台ID',
-- `platform_name` VARCHAR(32) NOT NULL DEFAULT '' COMMENT '平台名称',
-- `update_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新时间',
-- `create_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建时间',
-- PRIMARY KEY (`building_id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 MAX_ROWS=10000 AVG_ROW_LENGTH=4000;
-- *********************************************************************************************************

local business = {}

-- #########################################################################################################
-- 函数名: query_building_id
-- 函数功能: 校验建筑是否含有设备
-- 参数定义:
-- id: 建筑ID LIST
-- 返回值:
-- result: bool true存在,false不存在
-- #########################################################################################################
function business:query_building_id(name)
    local sql = "select building_id from t_building where building_name = '" .. name .. "'"
    local dao = require "dao"
    local configure = require "configure"
    local LOG = require "log"
    local cjson = require "cjson"
    LOG:DEBUG("check sql:" .. sql)
    local result,info = dao:query_by_sql(configure.DBCService, sql)
    if nil == info or nil == info.list or 0 >= #info.list then
        return false
    end

    return true,info.list[1].building_id
end

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
        return ""
    end
    local names = ""

    local num = #info.list
    local cjson = require "cjson"
    for i = 1, num do
        if ( nil ~= info.list[i].building_name) then
            names = names  .. info.list[i].building_name
        end

        if i ~= num then
          names = names .. ","
        end
    end

    return names
end


-- #########################################################################################################
-- 函数名: query_building_children
-- 函数功能: 记录中字符字段转换为整型字段
-- 参数定义:
-- info: 查询对象信息
-- 返回值:
-- 无
-- #########################################################################################################

function business:query_building_children(name)
    local result,id = business:query_building_id(name)
    if false == result then
      return false, ""
    end

    local sql = "select building_name from t_building where building_f_tree like '%" .. id .. "%'"
    local dao = require "dao"
    local configure = require "configure"
    local LOG = require "log"
    local cjson = require "cjson"
    LOG:DEBUG("check sql:" .. sql)
    local result,info = dao:query_by_sql(configure.DBCService, sql)
    if nil == info or nil == info.list or 0 >= #info.list then
        return false
    end

    local names = business:results_string_to_number(info)

    return true, names
end

return business
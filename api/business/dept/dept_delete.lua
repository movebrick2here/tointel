-- *********************************************************************************************************
-- author: zhouchangyue
-- QQ:   23199412
-- 文件实现了业务数据的逻辑检查,并调用数据库访问接口,将记录数据持久化到数据库
-- 函数命名必须为小写字母加下划线区分功能单词 例:do_action

-- 表t_dept结构
-- CREATE TABLE `t_dept` (
-- `dept_id` VARCHAR(128) NOT NULL DEFAULT '' COMMENT 'ID' ,
-- `dept_name` VARCHAR(256) NOT NULL DEFAULT ''  COMMENT '部门名称' ,
-- `parent_id` INT NOT NULL DEFAULT 0 COMMENT '父部门ID',
-- `description` VARCHAR(2048) NOT NULL DEFAULT '' COMMENT '备注',
-- `platform_id` INT NOT NULL DEFAULT 0 COMMENT '平台ID',
-- `platform_name` VARCHAR(32) NOT NULL DEFAULT '' COMMENT '平台名称',
-- `update_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新时间',
-- `create_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建时间',
-- PRIMARY KEY (`dept_id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 MAX_ROWS=10000 AVG_ROW_LENGTH=4000;
-- *********************************************************************************************************

local business = {}

-- #########################################################################################################
-- 函数名: array_to_string
-- 函数功能: 数组列表转换为字符串
-- 参数定义:
-- ids: id数组列表
-- 返回值:
-- ids_list: 返回字符串形式的id list,格式为:"1,2,3,4"
-- #########################################################################################################
function business:array_to_string(ids)
    local id_list = ""
    local parent_like_conditions = ""
    local num = #ids
    for i = 1, num do
        id_list = id_list .. "'" .. tostring(ids[i]) .. "'"
        parent_like_conditions = parent_like_conditions .. "dept_f_tree like '%" .. tostring(ids[i]) .. "%'"
        if i ~= num then
            id_list = id_list .. ","
            parent_like_conditions = parent_like_conditions .. " and "
        end
    end

    return id_list,parent_like_conditions
end

-- #########################################################################################################
-- 函数名: id_array_to_string
-- 函数功能: 数组列表转换为字符串
-- 参数定义:
-- ids: id数组列表
-- 返回值:
-- ids_list: 返回字符串形式的id list,格式为:"1,2,3,4"
-- #########################################################################################################
function business:id_array_to_string(ids)
    local id_list = ""
    local num = #ids
    for i = 1, num do
        id_list = id_list .. "'" .. tostring(ids[i]) .. "'"
        if i ~= num then
            id_list = id_list .. ","
        end
    end

    return id_list
end

-- #########################################################################################################
-- 函数名: query_children_list
-- 函数功能: 查询子部门
-- 参数定义:
-- ids: id数组列表
-- 返回值:
-- ids_list: 返回ID数组
-- #########################################################################################################
function business:query_children_list(ids)
    -- 数组转换字符串
    local ids_list, parent_like_conditions = business:array_to_string(ids)

    -- 查询记录
    local sql = "select dept_id from t_dept where dept_id in (" .. ids_list .. ") or " .. parent_like_conditions
    local configure = require "configure"
    local dao = require "dao"
    local LOG = require "log"
    LOG:DEBUG("query table:t_dept" .. " sql:" .. sql)
    local result,info = dao:query_by_sql(configure.DBCService, sql)

    local cjson = require "cjson"
    if false == result then
        LOG:ERROR("query table:t_dept " .. " value:" .. cjson.encode(tbl) .. " failed msg:" .. info)
        return false,info
    end

    LOG:DEBUG("query table: t_dept " .. " value:" .. cjson.encode(tbl) .. " response:" .. cjson.encode(info))
    if nil == info or nil == info.list or 0 >= #info.list then
        return false, "数据库无记录"
    end

    local id_array = {}

    for i = 1, #info.list do
        table.insert(id_array, info.list[i].dept_id)
    end    

    return true, id_array
end

-- #########################################################################################################
-- 函数名: do_action
-- 函数功能: 删除多条记录
-- 参数定义:
-- ids: 删除对象ID List
-- 返回值:
-- result: bool 函数成功或者失败
-- errmsg: 失败是,返回失败描述信息
-- #########################################################################################################
function business:do_action(ids)
    local result,children_list = business:query_children_list(ids)
    if false == result then
        return true
    end

    local children_list_str = business:id_array_to_string(children_list)
    local check = require "dept_check"
    local result = check:check_dept_has_device(children_list_str)
    if true == result then
        return false, "部门已经有设备关联，无法删除"
    end

    -- 数组转换字符串
    local ids_list, parent_like_conditions = business:array_to_string(ids)

    -- 删除记录
    local sql = "delete from t_dept where dept_id in (" .. ids_list .. ") or " .. parent_like_conditions
    local configure = require "configure"
    local dao = require "dao"
    local LOG = require "log"
    LOG:DEBUG("delete table:t_dept" .. " sql:" .. sql)
    local result,errmsg = dao:execute_by_sql(configure.DBCService, sql)

    return result, errmsg
end

return business
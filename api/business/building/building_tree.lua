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
-- 函数名: split
-- 函数功能: 拆分字符串为数组
-- 参数定义:
-- sep: 分隔符
-- 返回值:
-- array: 字符数组
-- #########################################################################################################
function string:split(sep)
    local sep, fields = sep or ":", {}
    local pattern = string.format("([^%s]+)", sep)
    self:gsub(pattern, function (c) fields[#fields + 1] = c end)
    return fields
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
        return
    end
    local num = #info.list
    local cjson = require "cjson"
    for i = 1, num do
        if ( nil ~= info.list[i].building_level) then
            info.list[i]["building_level"] = tonumber(info.list[i].building_level)
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
    conditions.item_tbl.building_id = id
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
    -- order.update_time = 1
    order.building_name = 2
    return order
end

-- #########################################################################################################
-- 函数名: get_parent_id
-- 函数功能: 获取父ID
-- 参数定义:
-- f_tree: 建筑树
-- 返回值:
-- result: bool 函数成功或者失败
-- errmsg: 失败是,返回失败描述信息
-- id: 成功时返回,ID信息
-- #########################################################################################################
function business:get_parent_id(f_tree)
    local array = f_tree:split("-")
    local num = #array
    if num < 2 then
        local LOG = require "log"
        LOG:DEBUG("f_tree:" .. f_tree .. " is invalid")
        return ""
    end

    return array[num]
end

-- #########################################################################################################
-- 函数名: create_tree
-- 函数功能: 创建数
-- 参数定义:
-- array: 建筑物数组
-- 返回值:
-- result: bool 函数成功或者失败
-- errmsg: 失败是,返回失败描述信息
-- info: 成功时返回,对象信息
-- #########################################################################################################
function business:create_tree(array)
    local list = array

    while true do
        local num = #list
        local max_level = 0;
        for i = 1, #list do
            if list[i].building_level > max_level then
                max_level = list[i].building_level;
            end
        end

        for i = 1, num do
            if nil ~= list[i] and list[i].building_level == max_level then
                local parent_id = list[i].building_f_tree
                if 2 <= max_level then
                    parent_id = business:get_parent_id(list[i].building_f_tree)
                end
                for j = 1, num do
                    if nil ~= list[j] and parent_id == list[j].building_id then
                        if nil == list[j].children then
                            list[j].children = {}
                        end

                        table.insert(list[j].children, list[i])
                        table.remove(list, i)
                    end
                end
            end
        end

        max_level = 0
        num = #list
        for i = 1, num do
            if list[i].building_level > 0 then
                max_level = 1;
            end
        end

        if 0 >= max_level then
            break;
        end
    end

    return list
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
    -- 查询记录
    local columns = { "building_id", "building_name", "parent_id", "building_level", "building_f_tree", "description",  "create_time", "update_time" }

    local order = business:make_order()

    local configure = require "configure"
    local dao = require "dao"
    local table_name = configure.DBCService.DB .. ".t_building"
    local LOG = require "log"
    local cjson = require "cjson"
    LOG:DEBUG("query table:" .. table_name .. " trees")
    local result,info = dao:query(configure.DBCService, table_name, columns, nil, nil, order)
    if false == result then
        LOG:ERROR("query table:" .. table_name .. " building trees failed msg:" .. info)
        return false,info
    end

    LOG:DEBUG("query table:" .. table_name .. " trees response:" .. cjson.encode(info))
    if nil == info or nil == info.list or 0 >= #info.list then
        return false, "数据库无记录"
    end

    business:results_string_to_number(info)

    local tree = business:create_tree(info.list)

    return true, tree
end

return business
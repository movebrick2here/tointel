-- *********************************************************************************************************
-- author: zhouchangyue
-- QQ:   23199412
-- 文件实现了业务数据的逻辑检查,并调用数据库访问接口,将记录数据持久化到数据库
-- 函数命名必须为小写字母加下划线区分功能单词 例:do_action

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
        if ( nil ~= info.list[i].running) then
            info.list[i]["running"] = tonumber(info.list[i].running)
        end
        if ( nil ~= info.list[i].running_time) then
            info.list[i]["running_time"] = tonumber(info.list[i].running_time)
        end
        
        if ( nil ~= info.list[i].consumption) then
            info.list[i]["consumption"] = tonumber(info.list[i].consumption)
        end

        if ( nil ~= info.list[i].hour_consumption) then
            info.list[i]["hour_consumption"] = tonumber(info.list[i].hour_consumption)
        end   

        if ( nil ~= info.list[i].total_consumption) then
            info.list[i]["total_consumption"] = tonumber(info.list[i].total_consumption)
        end

        if ( nil ~= info.list[i].begin_time) then
            info.list[i]["begin_time"] = tonumber(info.list[i].begin_time)
        end
        if ( nil ~= info.list[i].end_time) then
            info.list[i]["end_time"] = tonumber(info.list[i].end_time)
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
    if nil ~= tbl.building_id then
        conditions.item_tbl.building_id = tbl.building_id
    end

    if nil ~= tbl.building_name then
        conditions.item_tbl.building_name = tbl.building_name .. " LIKE"
    end

    conditions.item_tbl.stat_time = tostring(tbl.begin_time) .. " EGT"
    conditions.item_tbl.stat_time = tostring(tbl.end_time) .. " ELT"

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
    order.stat_time = 1
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
--    info.page_number = tbl.page_number
--    info.page_size = tbl.page_size
--    info.total_number = 1

--    info.list = {}

    local item = {}

    item.building_id = ""
    item.building_name = ""
    
    item.running = 6
    item.running_time = 100
    item.hour_consumption = 5
    item.consumption = 20
    item.total_consumption = 80
    item.begin_time = tbl.begin_time
    item.end_time = tbl.end_time

--    table.insert(info.list, item)

    return true, item
end

return business


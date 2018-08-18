-- *********************************************************************************************************
-- author: zhouchangyue
-- QQ:   23199412
-- 文件实现了业务数据的逻辑检查,并调用数据库访问接口,将记录数据持久化到数据库
-- 函数命名必须为小写字母加下划线区分功能单词 例:do_action

-- 表t_air_condition结构
-- CREATE TABLE `t_air_condition` (
-- `air_id` VARCHAR(128) NOT NULL DEFAULT '' COMMENT 'ID' ,
-- `air_model` VARCHAR(256) NOT NULL DEFAULT '' COMMENT '空调型号' ,
-- `air_name` VARCHAR(256) NOT NULL DEFAULT ''  COMMENT '空调名称' ,
-- `pi` INT NOT NULL DEFAULT 0 COMMENT '空调匹数',
-- `power` INT NOT NULL DEFAULT 0 COMMENT '空调功率' ,
-- `brand` VARCHAR(128)  NOT NULL DEFAULT '' COMMENT '空调品牌' ,
-- `factory` VARCHAR(512) NOT NULL DEFAULT '' COMMENT '空调制造商',
-- `description` VARCHAR(2048) NOT NULL DEFAULT '' COMMENT '备注',
-- `platform_id` varchar(128) NOT NULL DEFAULT '' COMMENT '平台ID',
-- `platform_name` VARCHAR(32) NOT NULL DEFAULT '' COMMENT '平台名称',
-- `update_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新时间',
-- `create_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建时间',
-- PRIMARY KEY (`air_id`)
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
-- 函数名: do_action
-- 函数功能: 删除多条记录
-- 参数定义:
-- ids: 删除对象ID List
-- 返回值:
-- result: bool 函数成功或者失败
-- errmsg: 失败是,返回失败描述信息
-- #########################################################################################################
function business:do_action(ids)
    -- 数组转换字符串
    local ids_list = business:array_to_string(ids)

    -- 删除记录
    local sql = "delete from t_air_condition where air_id in (" .. ids_list .. ")"
    local configure = require "configure"
    local dao = require "dao"
    local LOG = require "log"
    LOG:DEBUG("delete table:t_air" .. " sql:" .. sql)
    local result,errmsg = dao:execute_by_sql(configure.DBCService, sql)

    return result, errmsg
end

return business
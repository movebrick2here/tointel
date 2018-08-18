-- *********************************************************************************************************
-- author: zhouchangyue
-- QQ:   23199412
-- 文件实现了业务数据的逻辑检查,并调用数据库访问接口,将记录数据持久化到数据库
-- 函数命名必须为小写字母加下划线区分功能单词 例:do_action

-- 表t_user结构
-- CREATE TABLE `t_user` (
-- `user_id` varchar(128) NOT NULL DEFAULT '' COMMENT '用户ID',
-- `user_password` varchar(256) NOT NULL DEFAULT '' COMMENT '用户密码',
-- `user_name` varchar(256) NOT NULL DEFAULT '' COMMENT '用户名',
-- `contact` varchar(64) NOT NULL DEFAULT '' COMMENT '联系人',
-- `building_info` varchar(2048) NOT NULL DEFAULT '' COMMENT '建筑物信息',
-- `dept_info` varchar(2048) NOT NULL DEFAULT '' COMMENT '部门信息',
-- `mobile_phone` varchar(64) NOT NULL DEFAULT '' COMMENT '移动电话',
-- `update_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新时间',
-- `create_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建时间',
-- PRIMARY KEY (`user_id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 MAX_ROWS=10000 AVG_ROW_LENGTH=2000;
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
    local sql = "delete from t_user where user_id in (" .. ids_list .. ")"
    local configure = require "configure"
    local dao = require "dao"
    local LOG = require "log"
    LOG:DEBUG("delete table:t_user" .. " sql:" .. sql)
    local result,errmsg = dao:execute_by_sql(configure.DBCService, sql)

    return result, errmsg
end

return business
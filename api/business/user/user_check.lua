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
-- 函数名: name_is_exists
-- 函数功能: 查询名称是否存在
-- 参数定义:
-- name: 名称
-- 返回值:
-- result: bool true存在,false不存在
-- #########################################################################################################
function business:name_is_exists(name)
    local sql = "select user_id from t_user where user_name='" .. name .. "'"
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


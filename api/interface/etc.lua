-- *********************************************************************************************************
-- author: zhouchangyue
-- QQ:   23199412
-- 文件实现了 Restful风格API的参数检查(检查参数的必填属性和参数数据类型)
-- 该文件无需落地日志,错误信息直接返回给浏览器,方便定位
-- 函数命名必须为小写字母加下划线区分功能单词 例:check_add_params

-- Nginx HTTP SERVICE 配置中增加路径指向该文件
-- 格式:
-- location ^~/interface/etc/ {
--     default_type 'text/plain';
--     content_by_lua_file ${HOME_DIR}/interface/etc.lua;
-- }
-- 浏览器请求的地址是 http://${DOMAIN}/interface/etc/${OP}
-- DOMAIN 服务器部署的域名
-- OP的值取决于代码中的实现

-- 基本的OP包括 add,update,query,delete,query_list,stat_by_date
-- add:        实现数据记录添加操作
-- update:     实现数据记录修改操作
-- query:      实现数据记录查询操作
-- delete:     实现数据记录删除操作
-- query_list: 实现数据记录列表查询操作
-- stat_by_date: 实现按日期统计记录数
-- 扩展的OP包括各种统计查询的接口 例如 member_stat, fans_stat等自定义的值

-- 针对以上OP的值必须添加参数校验函数,函数名称格式 check_${OP}_params(tbl)
-- check_${OP}_params(tbl) 函数名称,例子 check_add_params(tbl)
-- check_${OP}_params(tbl) 函数返回值:
-- result: bool 表示函数校验成功或者失败
-- errmsg: string 表示函数失败的原因,函数校验成功时无需返回该值

-- RESTFUL API定义格式见 https://github.com/changyuezhou/api_base/blob/master/doc/etc.md
-- *********************************************************************************************************

-- #########################################################################################################
-- 函数名: check_pages_params
-- 函数功能: 检查分页参数
-- 参数定义:
-- tbl: POST请求过来的JSON数据,已经用cjson库转换成LUA TABLE
-- 返回值:
-- result: bool 表示函数成功或者失败
-- errmsg: string 表示函数失败的原因,函数校验成功时无需返回该值
-- #########################################################################################################
function check_pages_params(tbl)
    if nil == tbl then
        return false, "POST数据格式错误"
    end

    if (nil == tbl["page_number"]) or
            ("number" ~= type(tbl["page_number"])) then
        return false, "请检查参数page_number.为必填且必须为整型"
    end

    if (nil == tbl["page_size"]) or
            ("number" ~= type(tbl["page_size"])) then
        return false, "请检查参数page_size.为必填且必须为整型"
    end

    return true
end

-- #########################################################################################################
-- 函数名: check_query_time_params
-- 函数功能: 检查时间参数
-- 参数定义:
-- tbl: POST请求过来的JSON数据,已经用cjson库转换成LUA TABLE
-- 返回值:
-- result: bool 表示函数成功或者失败
-- errmsg: string 表示函数失败的原因,函数校验成功时无需返回该值
-- #########################################################################################################
function check_query_time_params(tbl)
    if nil == tbl then
        return false, "POST数据格式错误"
    end

    if (nil == tbl["begin_time"]) or
            ("number" ~= type(tbl["begin_time"])) then
        return false, "请检查参数begin_time.为必填且必须为整型"
    end

    if (nil == tbl["end_time"]) or
            ("number" ~= type(tbl["end_time"])) then
        return false, "请检查参数end_time.为必填且必须为整型"
    end

    return true
end

-- #########################################################################################################
-- 函数名: check_add_params
-- 函数功能: 校验接口 add 的参数
-- 参数定义:
-- tbl: POST请求过来的JSON数据,已经用cjson库转换成LUA TABLE
-- 返回值:
-- result: bool 表示函数成功或者失败
-- errmsg: string 表示函数失败的原因,函数校验成功时无需返回该值
-- #########################################################################################################
function check_add_params(tbl)
    if nil == tbl then
        return false, "POST数据格式错误"
    end

    if (nil == tbl["etc_name"]) or
            ("string" ~= type(tbl["etc_name"])) then
        return false, "请检查参数etc_name.为必填且必须为字符型"
    end

    if (nil == tbl["max_heat"]) or
            ("number" ~= type(tbl["max_heat"])) then
        return false, "请检查参数max_heat.为必填且必须为整型"
    end

    if (nil == tbl["mid_heat"]) or
            ("number" ~= type(tbl["mid_heat"])) then
        return false, "请检查参数mid_heat.为必填且必须为整型"
    end

    if (nil == tbl["min_heat"]) or
            ("number" ~= type(tbl["min_heat"])) then
        return false, "请检查参数min_heat.为必填且必须为整型"
    end

    if (nil == tbl["max_cool"]) or
            ("number" ~= type(tbl["max_cool"])) then
        return false, "请检查参数max_cool.为必填且必须为整型"
    end

    if (nil == tbl["mid_cool"]) or
            ("number" ~= type(tbl["mid_cool"])) then
        return false, "请检查参数mid_cool.为必填且必须为整型"
    end

    if (nil == tbl["min_cool"]) or
            ("number" ~= type(tbl["min_cool"])) then
        return false, "请检查参数min_cool.为必填且必须为整型"
    end

    if (nil == tbl["max_humidity"]) or
            ("number" ~= type(tbl["max_humidity"])) then
        return false, "请检查参数max_humidity.为必填且必须为整型"
    end

    if (nil == tbl["min_humidity"]) or
            ("number" ~= type(tbl["min_humidity"])) then
        return false, "请检查参数min_humidity.为必填且必须为整型"
    end

    if (nil == tbl["etc_mode"]) or
            ("string" ~= type(tbl["etc_mode"])) then
        return false, "请检查参数etc_mode.为必填且必须为字符型"
    end

    if (nil == tbl["description"]) or
            ("string" ~= type(tbl["description"])) then
        return false, "请检查参数description.为必填且必须为字符型"
    end

    return true
end

-- #########################################################################################################
-- 函数名: check_update_params
-- 函数功能: 校验接口 update 的参数
-- 参数定义:
-- tbl: POST请求过来的JSON数据,已经用cjson库转换成LUA TABLE
-- 返回值:
-- result: bool 表示函数成功或者失败
-- errmsg: string 表示函数失败的原因,函数校验成功时无需返回该值
-- #########################################################################################################
function check_update_params(tbl)
    if nil == tbl then
        return false, "POST数据格式错误"
    end

    if (nil == tbl["etc_id"]) or
            ("string" ~= type(tbl["etc_id"])) then
        return false, "请检查参数etc_id.为必填且必须为字符型"
    end

    if (nil ~= tbl["etc_name"]) and
            ("string" ~= type(tbl["etc_name"])) then
        return false, "请检查参数etc_name.为必填且必须为字符型"
    end

    if (nil ~= tbl["max_heat"]) and
            ("number" ~= type(tbl["max_heat"])) then
        return false, "请检查参数max_heat.为必填且必须为整型"
    end

    if (nil ~= tbl["mid_heat"]) and
            ("number" ~= type(tbl["mid_heat"])) then
        return false, "请检查参数mid_heat.为必填且必须为整型"
    end

    if (nil ~= tbl["min_heat"]) and
            ("number" ~= type(tbl["min_heat"])) then
        return false, "请检查参数min_heat.为必填且必须为整型"
    end

    if (nil ~= tbl["max_cool"]) and
            ("number" ~= type(tbl["max_cool"])) then
        return false, "请检查参数max_cool.为必填且必须为整型"
    end

    if (nil ~= tbl["mid_cool"]) and
            ("number" ~= type(tbl["mid_cool"])) then
        return false, "请检查参数mid_cool.为必填且必须为整型"
    end

    if (nil ~= tbl["min_cool"]) and
            ("number" ~= type(tbl["min_cool"])) then
        return false, "请检查参数min_cool.为必填且必须为整型"
    end

    if (nil ~= tbl["max_humidity"]) and
            ("number" ~= type(tbl["max_humidity"])) then
        return false, "请检查参数max_humidity.为必填且必须为整型"
    end

    if (nil ~= tbl["min_humidity"]) and
            ("number" ~= type(tbl["min_humidity"])) then
        return false, "请检查参数min_humidity.为必填且必须为整型"
    end

    if (nil ~= tbl["etc_mode"]) and
            ("string" ~= type(tbl["etc_mode"])) then
        return false, "请检查参数etc_mode.为必填且必须为字符型"
    end

    if (nil ~= tbl["description"]) and
            ("string" ~= type(tbl["description"])) then
        return false, "请检查参数description.为必填且必须为字符型"
    end

    return true
end

-- #########################################################################################################
-- 函数名: check_query_params
-- 函数功能: 校验接口 query 的参数
-- 参数定义:
-- tbl: POST请求过来的JSON数据,已经用cjson库转换成LUA TABLE
-- 返回值:
-- result: bool 表示函数成功或者失败
-- errmsg: string 表示函数失败的原因,函数校验成功时无需返回该值
-- #########################################################################################################
function check_query_params(tbl)
    if nil == tbl then
        return false, "POST数据格式错误"
    end

    if (nil == tbl["etc_id"]) or
            ("string" ~= type(tbl["etc_id"])) then
        return false, "请检查参数etc_id.为必填且必须为字符型"
    end

    return true
end

-- #########################################################################################################
-- 函数名: check_delete_params
-- 函数功能: 校验接口 delete 的参数
-- 参数定义:
-- tbl: POST请求过来的JSON数据,已经用cjson库转换成LUA TABLE
-- 返回值:
-- result: bool 表示函数成功或者失败
-- errmsg: string 表示函数失败的原因,函数校验成功时无需返回该值
-- #########################################################################################################
function check_delete_params(tbl)
    if nil == tbl then
        return false, "POST数据格式错误"
    end

    if (nil == tbl["etc_id"]) or
            ("table" ~= type(tbl["etc_id"])) then
        return false, "请检查参数etc_id.为必填且必须为字符数组"
    end

    return true
end

-- #########################################################################################################
-- 函数名: check_query_list_params
-- 函数功能: 校验接口 query_list 的参数
-- 参数定义:
-- tbl: POST请求过来的JSON数据,已经用cjson库转换成LUA TABLE
-- 返回值:
-- result: bool 表示函数成功或者失败
-- errmsg: string 表示函数失败的原因,函数校验成功时无需返回该值
-- #########################################################################################################
function check_query_list_params(tbl)
    if nil == tbl then
        return false, "POST数据格式错误"
    end

    local ret,errmsg = check_pages_params(tbl)

    return ret,errmsg
end

-- #########################################################################################################
-- 函数名: check_stat_by_date_params
-- 函数功能: 校验接口 stat_by_date 的参数
-- 参数定义:
-- tbl: POST请求过来的JSON数据,已经用cjson库转换成LUA TABLE
-- 返回值:
-- result: bool 表示函数成功或者失败
-- errmsg: string 表示函数失败的原因,函数校验成功时无需返回该值
-- #########################################################################################################
function check_stat_by_date_params(tbl)
    if nil == tbl then
        return false, "POST数据格式错误"
    end

    local ret,errmsg = check_pages_params(tbl)
    if false == ret then
        return ret, errmsg
    end

    ret,errmsg = check_query_time_params(tbl)

    return ret,errmsg
end

-- #########################################################################################################
-- 函数名: check_http_request_is_post
-- 函数功能: 校验接口是否为POST请求方式
-- 参数定义:
-- 无
-- 返回值:
-- result: bool 表示函数成功或者失败
-- #########################################################################################################
function check_http_request_is_post()
    local request_method = ngx.var.request_method
    if "POST" == request_method then
        return true
    end

    return false
end

-- #########################################################################################################
-- 函数名: check_http_request_is_get
-- 函数功能: 校验接口是否为GET请求方式
-- 参数定义:
-- 无
-- 返回值:
-- result: bool 表示函数成功或者失败
-- #########################################################################################################
function check_http_request_is_get()
    local request_method = ngx.var.request_method
    if "GET" == request_method then
        return true
    end

    return false
end

-- #########################################################################################################
-- 函数名: get_etc_info
-- 函数功能: 获取用户认证信息
-- 参数定义:
-- 无
-- 返回值:
-- result: bool 表示函数成功或者失败
-- etc: table 用户信息对象(包含用户ID, 组ID等),失败时为nil
-- redirect_url: string 用户登录页面URL
-- #########################################################################################################
function get_etc_info()
    local auth_api = require "authorization"
    local result,etc,redirect_url = auth_api:do_auth()
    return result,etc,redirect_url
end

-- #########################################################################################################
-- 函数名: post_data_to_table
-- 函数功能: POST请求数据转换成TABLE
-- 参数定义:
-- 无
-- 返回值:
-- result: bool 表示函数成功或者失败
-- data: table POST数据对象,失败时无该值
-- errmsg: string 表示函数失败的原因,函数成功时无需返回该值
-- #########################################################################################################
function post_data_to_table()
    ngx.req.read_body()
    local data = ngx.req.get_body_data()
    if nil == data then
        return false, "POST数据为空"
    end
    local cjson = require "cjson"
    local ok, tbl = pcall(cjson.decode, data)
    if (not ok) then
        return false, "POST数据格式不对,请求数据为:" .. data
    end
    return true, tbl
end

-- #########################################################################################################
-- 函数名: get_request_op
-- 函数功能: 获取 restful api 的OP值
-- 参数定义:
-- 无
-- 返回值:
-- op: string OP值
-- 例子:
-- 浏览器请求URL:http://${DOMAIN}/interface/etc/add
-- 该函数返回 add
-- #########################################################################################################
function get_request_op()
    local uri = ngx.var.uri
    local op = string.match(uri, ".+/([^/]*%w+)$")

    return op
end

-----------------------------------------------------------------------------------------------------------

local response = {}
response.code = 0
response.msg = ""
local cjson = require "cjson"
local ERR = require "err"

-- ########################################################################################################
-- 检查段
-- 检查用户登录态
--[[
local etc_check_result,etc_info,redirect_url = get_etc_info()
if false == etc_check_result then
    response.code = 302
    response.redirect_url = redirect_url
    ngx.say(cjson.encode(response))
    ngx.exit(ngx.HTTP_OK)
end
--]]
-- 检查接口请求是否为POST方式
if false == check_http_request_is_post() then
    response.code = ERR.USERINPUTFORMAT
    response.msg = "系统只支持POST请求方式"
    ngx.say(cjson.encode(response))
    ngx.exit(ngx.HTTP_OK)
end

-- POST 数据转换为 TABLE
local post_data_result, tbl = post_data_to_table()
if false == post_data_result then
    response.code = ERR.USERINPUTFORMAT
    response.msg = tbl
    ngx.say(cjson.encode(response))
    ngx.exit(ngx.HTTP_OK)
end

-- ########################################################################################################

-- 获取接口并处理
local OP = get_request_op()
if OP == "add" then
    local result,errmsg = check_add_params(tbl)
    if true == result then
        local business = require "etc_add"
        local result, etc_id = business:do_action(tbl)
        if false == result then
            response.code = ERR.USERINPUTLOGICAL
            response.msg = etc_id
        else
            response.data = {}
            response.data.etc_name = tbl.etc_name
            response.data.etc_id = etc_id
        end
    else
        response.code = ERR.USERINPUTFORMAT
        response.msg = errmsg
    end
elseif OP == "update" then
    local result,errmsg = check_update_params(tbl)
    if true == result then
        local business = require "etc_update"
        local result,errmsg = business:do_action(tbl)
        if false == result then
            response.code = ERR.USERINPUTLOGICAL
            response.msg = errmsg
        end
    else
        response.code = ERR.USERINPUTFORMAT
        response.msg = errmsg
    end
elseif OP == "query" then
    local result,errmsg = check_query_params(tbl)
    if true == result then
        local business = require "etc_query"
        local result,info = business:do_action(tbl.etc_id)
        if false == result then
            response.code = ERR.USERINPUTLOGICAL
            response.msg = info
        else
            response.data = info
        end
    else
        response.code = ERR.USERINPUTFORMAT
        response.msg = errmsg
    end
elseif OP == "delete" then
    local result,errmsg = check_delete_params(tbl)
    if true == result then
        local business = require "etc_delete"
        local result,errmsg = business:do_action(tbl.etc_id)
        if false == result then
            response.code = ERR.USERINPUTLOGICAL
            response.msg = errmsg
        end
    else
        response.code = ERR.USERINPUTFORMAT
        response.msg = errmsg
    end
elseif OP == "query_list" then
    local result,errmsg = check_query_list_params(tbl)
    if true == result then
        local business = require "etc_query_list"
        local result,info = business:do_action(tbl)
        if false == result then
            response.code = ERR.USERINPUTLOGICAL
            response.msg = info
        else
            response.data = info
        end
    else
        response.code = ERR.USERINPUTFORMAT
        response.msg = errmsg
    end
else
    response.code = ERR.USERINPUTFORMAT
    response.msg = "无效的请求命令:" .. OP
end

-- 返回数据
ngx.say(cjson.encode(response))
ngx.exit(ngx.HTTP_OK)
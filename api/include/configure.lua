-- *********************************************************************************************************
-- author: zhouchangyue
-- QQ:   23199412
-- 配置文件定义
-- DBService 配置Database Proxy Service地址
-- *********************************************************************************************************

local Configure = {}

Configure.DBCService = {}
Configure.DBCService.IP = "127.0.0.1"
Configure.DBCService.PORT = "10089"
Configure.DBCService.DB = "db_ecp_v2"

Configure.PLATFORM = {}
Configure.PLATFORM.ID = "1"
Configure.PLATFORM.NAME = "tointel"

Configure.OFFLINE = 1800

Configure.mysql = {}
Configure.mysql.HOST = "127.0.0.1"
Configure.mysql.PORT = "3306"
Configure.mysql.DATABASE = "db_ecp_v2"
Configure.mysql.USER = "root"
Configure.mysql.PASSWORD = "ecp888888"

return Configure
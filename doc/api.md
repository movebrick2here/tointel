#  开发人员API参考手册
-------------------
## [1 关于文档](#about_doc)
## [2 背景知识](#background)
## [3 API请求](#api_request)
## [4 API响应](#api_response)
## [5 用户管理](#user_manage)
### [5.1 用户增加](#user_add)
### [5.2 用户修改](#user_update)
### [5.3 用户删除](#user_delete)
### [5.4 用户查询](#user_query)
### [5.5 用户列表](#user_query_list)
## [6 空调管理](#air_manage)
### [6.1 空调增加](#air_add)
### [6.2 空调修改](#air_update)
### [6.3 空调删除](#air_delete)
### [6.4 空调查询](#air_query)
### [6.5 空调列表](#air_query_list)
## [7 建筑管理](#building_manage)
### [7.1 建筑增加](#building_add)
### [7.2 建筑修改](#building_update)
### [7.3 建筑删除](#building_delete)
### [7.4 建筑查询](#building_query)
### [7.5 建筑列表](#building_query_list)
### [7.6 建筑树](#building_tree)
## [8 部门管理](#dept_manage)
### [8.1 部门增加](#dept_add)
### [8.2 部门修改](#dept_update)
### [8.3 部门删除](#dept_delete)
### [8.4 部门查询](#dept_query)
### [8.5 部门列表](#dept_query_list)
### [8.6 部门树](#dept_tree)
## [9 终端管理](#terminal_manage)
### [9.1 终端增加](#terminal_add)
### [9.2 终端修改](#terminal_update)
### [9.3 终端删除](#terminal_delete)
### [9.4 终端查询](#terminal_query)
### [9.5 终端列表](#terminal_query_list)
## [10 规则管理](#rule_manage)
### [10.1 规则增加](#rule_add)
### [10.2 规则修改](#rule_update)
### [10.3 规则删除](#rule_delete)
### [10.4 规则查询](#rule_query)
### [10.5 规则列表](#rule_query_list)
## [11 配置管理](#etc_manage)
### [11.1 配置增加](#etc_add)
### [11.2 配置修改](#etc_update)
### [11.3 配置删除](#etc_delete)
### [11.4 配置查询](#etc_query)
### [11.5 配置列表](#etc_query_list)
## [12 控制管理](#control_manage)
### [12.1 控制终端](#control_add)
### [12.2 控制查询](#control_query)
## [13 告警管理](#alarm_manage)
### [13.1 告警查询](#alarm_query)
## [14 状态管理](#terminal_status_manage)
### [14.1 在线终端](#online_terminal)
### [14.2 离线终端](#offline_terminal)
### [14.3 实时状态](#real_status_terminal)
### [14.4 未注册终端](#unregister_terminal)
### [14.5 状态分布](#status_stat_terminal)
### [14.6 注册设备](#register)
## [15 能效管理](#energy_manage)
### [15.1 能效告警](#energy_alarm)
### [15.2 能效查询](#energy_query_list)
### [15.3 能效排名](#energy_ranking)
## [16 统计管理](#status_stat_manage)
### [16.1 日统计](#day_stat)
### [16.2 建筑统计](#building_day_stat)
### [16.3 部门统计](#dept_day_stat)
### [16.4 部门平均能耗](#dept_mean_consumption)
### [16.5 建筑平均能耗](#building_mean_consumption)
### [16.6 总能耗](#total_consumption)
### [16.7 状态统计](#status_stat)
## [17 系统参数管理](#system_param_manage)
### [17.1 系统参数增加](#system_param_add)
### [17.2 系统参数修改](#system_param_update)
### [17.3 系统参数删除](#system_param_delete)
### [17.4 系统参数查询](#system_param_query)
## [18 状态码](#status_code)
-------------------
## 1. 关于文档 <a name="about_doc"/>
   本文档作为管理系统与前端WEB UI进行联调的指引文档。主要包括以下几个个部分：
   管理端 API：阅读对象为产品和WEB UI开发人员,以及相关测试人员。该部分详细描述了管理系统相关的接口

## 2. 背景知识 <a name="background"/>
   本API文档所涉及接口均遵循HTTP和HTTPS协议，请求和响应数据格式如无特殊说明均为JSON，您可以使用任何支持HTTP和HTTPS协议和JSON格式的编程
   语言开发应用程序。有关标准HTTP和HTTPS协议，可参考RFC2616和RFC2818或维基百科-HTTP,HTTPS相关介绍。有关JSON数据格式，可参考JSON.ORG
   或维基百科–JSON相关介绍

## 3. API请求 <a name="api_request"/>
   HTTP Method
   调用方应设置HTTP Method为POST。
   HTTP Header
   调用方应遵循HTTP协议设置相应的Header，目前支持的Header有：Content-Type，Content-Type用于指定数据格式。本章节中Content-Type应为
   application/json

## 4. API响应 <a name="api_response"/>
* HTTP状态码，支持HTTP标准状态码，具体如下：

| 状态码  | 名称 | 描述 |
| :--------| ----:| :--- |
| 200 |  成功或者失败  |  当API 请求被正确处理，且能按设计获取结果时，返回该状态码；亦适用于批量接口返回部分结果，如果失败，亦包括失败信息 |

* HTTP Body响应的JSON数据中包含三部分内容，分别为返回码、返回信息和数据，如下表所示：

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 |  返回码：见状态码的定义  |
| msg |  string  | 是 |  返回信息：若有错误，此字段为详细的错误信息 |
| data |  json array 或json object | 否 |  返回结果：针对批量接口，若无特殊说明，结果将按请求数组的顺序全量返回  |

## 5.用户管理 <a name="user_manage"/>
### 5.1 用户增加 add <a name="user_add"/>
* 请求URL:http://${DOMAIN}/interface/user/add
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| user_name | string | 是 | 用户名称 |
| contact | string | 是 | 联系人 |
| mobile_phone | string | 是 | 电话号码 |
| user_password | string | 是 | 初始密码(MD5(PASSWORD)) |
| building_info | array(object) | 是 | 建筑物 |
| dept_info | array(object) | 是 | 部门 |

* building_info

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| id |  string| 是 | 建筑物ID |
| name |  string  | 否 | 建筑物名称  |

* dept_info 

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| id |  string| 是 | 部门ID |
| name |  string  | 否 | 部门名称  |

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |
| data |  json object  | 是 | 对象 |

* 应答data字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| user_id |  string  | 是 | id |
| user_name |  string  | 是 | 名称 |

* 请求示例
   >{
	   "user_name": "admin@system.com",
	   "contact": "张帅",
	   "mobile_phone": "13800000000",
	   "user_password": "f447b20a7fcbf53a5d5be013ea0b15af",
	   "building_info": [{"id":"B96E79218965EB72C92A549DD5A330113","name":"教学楼一楼"},{"id":"B86E79218965EB72C92A549DD5A330112","name":"教学楼二楼"}],
	   "dept_info": [{"id":"D76E79218965EB72C92A549DD5A330116","name":"财务科"}, {"id":"D96E79218965EB72C92A549DD5A330113","name":"教务处"}]
	}

* 应答示例
  >{
	  "msg": "",
	  "code": 0,
	  "data": {
		"user_id": "U96E79218965EB72C92A549DD5A330112",
		"user_name": "admin@system.com"
	  }
	}
	
### 5.2 用户修改 update <a name="user_update"/>
* 请求URL:http://${DOMAIN}/interface/user/update
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| user_id |  string  | 是 | id |
| user_name | string | 否 | 用户名称 |
| contact | string | 否 | 联系人 |
| mobile_phone | string | 否 | 电话号码 |
| user_password | string | 否 | 初始密码(MD5(PASSWORD)) |
| building_info | array(object) | 否 | 建筑物 |
| dept_info | array(object) | 否 | 部门 |

* building_info

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| id |  string| 是 | 建筑物ID |
| name |  string  | 否 | 建筑物名称  |

* dept_info 

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| id |  string| 是 | 部门ID |
| name |  string  | 否 | 部门名称  |

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |


* 请求示例
   >{
       "user_id": "U96E79218965EB72C92A549DD5A330112",
	   "user_name": "admin@system.com",
	   "contact": "张帅",
	   "mobile_phone": "13800000000",
	   "user_password": "f447b20a7fcbf53a5d5be013ea0b15af",
	   "building_info": [{"id":"B96E79218965EB72C92A549DD5A330113","name":"教学楼一楼"},{"id":"B86E79218965EB72C92A549DD5A330112","name":"教学楼二楼"}],
	   "dept_info": [{"id":"D76E79218965EB72C92A549DD5A330116","name":"财务科"}, {"id":"D96E79218965EB72C92A549DD5A330113","name":"教务处"}]	   
	}

* 应答示例
  >{
	   "msg": "",
	   "code": 0
   }

### 5.3 用户删除 delete <a name="user_delete"/>
* 请求URL:http://${DOMAIN}/interface/user/delete
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| user_id |  array  | 是 | id数组 |

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |


* 请求示例
   >{
       "user_id": ["U96E79218965EB72C92A549DD5A330112", "U76E79218965EB72C92A549DD5A330116", "U86E79218965EB72C92A549DD5A330115"]
	}

* 应答示例
  >{
	   "msg": "",
	   "code": 0
   }
   
### 5.4 用户查询 query <a name="user_query"/>
* 请求URL:http://${DOMAIN}/interface/user/query
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| user_id |  string  | 是 | 用户id |

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |
| data |  json object  | 是 | 对象 |

* 应答data字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| user_id |  string  | 是 | id |
| user_name | string | 是 | 用户名称 |
| contact | string | 是 | 联系人 |
| mobile_phone | string | 是 | 电话号码 |
| user_password | string | 是 | 初始密码(MD5(PASSWORD)) |
| building_info | array(object) | 是 | 建筑物 |
| dept_info | array(object) | 是 | 部门 |
| building_name | array(string) | 是 | 建筑物名称,顺序和ID一致 |
| dept_name | array(string) | 是 | 部门名称,顺序和ID一致 |
| update_time | int | 是 | 更新时间 |
| create_time | int | 是 | 创建时间 |

* building_info

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| id |  string| 是 | 建筑物ID |
| name |  string  | 否 | 建筑物名称  |

* dept_info 

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| id |  string| 是 | 部门ID |
| name |  string  | 否 | 部门名称  |

* 请求示例
   >{
	   "user_id": "U96E79218965EB72C92A549DD5A330112"
	}

* 应答示例
  >{
	  "msg": "",
	  "code": 0,
	  "data": {
       "user_id": "U96E79218965EB72C92A549DD5A330112",
	   "user_name": "admin@system.com",
	   "contact": "张帅",
	   "mobile_phone": "13800000000",
	   "user_password": "f447b20a7fcbf53a5d5be013ea0b15af",
	   "building_info": [{"id":"B96E79218965EB72C92A549DD5A330113","name":"教学楼一楼"},{"id":"B86E79218965EB72C92A549DD5A330112","name":"教学楼二楼"}],
	   "dept_info": [{"id":"D76E79218965EB72C92A549DD5A330116","name":"财务科"}, {"id":"D96E79218965EB72C92A549DD5A330113","name":"教务处"}]  	   
	   "create_time": 1590688989,
	   "update_time": 1590688989
	  }
    }
    
### 5.5 用户列表 query_list <a name="user_query_list"/>
* 请求URL:http://${DOMAIN}/interface/user/query_list
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| user_id |  string  | 否 | id |
| user_name | string | 否 | 用户名称 |
| page_number | int  | 是 |  页码  |
| page_size | int  | 是 |  每页记录条数 |

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |
| data |  json object  | 是 | 对象信息 |

* data字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| page_number | int  | 是 | 页码  |
| page_size | int  | 是 | 每页记录条数 |
| total_number |  int | 是 | 总记录条数  |
| list |  json array  | 是 | 对象数组 |

* list数组单个元素字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| user_id |  string  | 是 | id |
| user_name | string | 是 | 用户名称 |
| contact | string | 是 | 联系人 |
| mobile_phone | string | 是 | 电话号码 |
| user_password | string | 是 | 初始密码(MD5(PASSWORD)) |
| building_info | array(object) | 是 | 建筑物 |
| dept_info | array(object) | 是 | 部门 |
| building_name | array(string) | 是 | 建筑物名称,顺序和ID一致 |
| dept_name | array(string) | 是 | 部门名称,顺序和ID一致 |
| update_time | int | 是 | 更新时间 |
| create_time | int | 是 | 创建时间 |

* building_info

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| id |  string| 是 | 建筑物ID |
| name |  string  | 否 | 建筑物名称  |

* dept_info 

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| id |  string| 是 | 部门ID |
| name |  string  | 否 | 部门名称  |

* 请求示例
   >{
	   "user_id": "U96E79218965EB72C92A549DD5A330112",
	   "user_name": "admin@system.com",
	   "page_number": 1,
	   "page_size": 10
	}

* 应答示例
  >{
	"msg": "",
	"code": 0,
	"data": {
		"page_number": 1,
	    "page_size": 10,
	    "total_number": 2,
	    "list":[
		   {
              "user_id": "U96E79218965EB72C92A549DD5A330112",
	          "user_name": "admin@system.com",
	          "contact": "张帅",
	          "mobile_phone": "13800000000",
	          "user_password": "f447b20a7fcbf53a5d5be013ea0b15af",
	          "building_info": [{"id":"B96E79218965EB72C92A549DD5A330113","name":"教学楼一楼"},{"id":"B86E79218965EB72C92A549DD5A330112","name":"教学楼二楼"}],
	          "dept_info": [{"id":"D76E79218965EB72C92A549DD5A330116","name":"财务科"}, {"id":"D96E79218965EB72C92A549DD5A330113","name":"教务处"}] 	          
	          "create_time": 1590688989,
	          "update_time": 1590688989
		   },
		   {
              "user_id": "U86E79218965EB72C92A549DD5A330115",
	          "user_name": "user@system.com",
	          "contact": "李帅",
	          "mobile_phone": "13800000000",
	          "user_password": "f447b20a7fcbf53a5d5be013ea0b15af",
	          "building_info": [{"id":"B96E79218965EB72C92A549DD5A330113","name":"教学楼一楼"},{"id":"B86E79218965EB72C92A549DD5A330112","name":"教学楼二楼"}],
	          "dept_info": [{"id":"D76E79218965EB72C92A549DD5A330116","name":"财务科"}, {"id":"D96E79218965EB72C92A549DD5A330113","name":"教务处"}]          
	          "create_time": 1590688989,
	          "update_time": 1590688989
		   }]
	 }
   }
      
## 6.空调管理 <a name="air_manage"/>
### 6.1 空调增加 add <a name="air_add"/>
* 请求URL:http://${DOMAIN}/interface/air/add
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| air_name | string | 是 | 空调名称 |
| air_model | string | 是 | 空调型号 |
| pi | int | 是 | 空调匹数 |
| power | int | 是 | 空调能耗 |
| brand | string | 是 | 空调品牌 |
| factory | string | 是 | 空调制造商 |
| description | string | 是 | 备注 |

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |
| data |  json object  | 是 | 对象 |

* 应答data字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| air_id |  string  | 是 | id |
| air_name |  string  | 是 | 名称 |

* 请求示例
   >{
	   "air_name": "大金立式空调",
	   "air_model": "A20171009",
	   "pi": 2,
	   "power": 1000,
	   "brand": "大金",
	   "factory": "上海青浦大金空调制造厂",
	   "description": "智能空调"
	}

* 应答示例
  >{
	  "msg": "",
	  "code": 0,
	  "data": {
		"air_id": "A86E79218965EB72C92A549DD5A330115",
		"air_name": "大金立式空调"
	  }
	}
	
### 6.2 空调修改 update <a name="air_update"/>
* 请求URL:http://${DOMAIN}/interface/air/update
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| air_id |  string  | 是 | id |
| air_name | string | 否 | 空调名称 |
| air_model | string | 否 | 空调型号 |
| pi | int | 否 | 空调匹数 |
| power | int | 否 | 空调能耗 |
| brand | string | 否 | 空调品牌 |
| factory | string | 否 | 空调制造商 |
| description | string | 否 | 备注 |


* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |


* 请求示例
   >{
       "air_id": "A86E79218965EB72C92A549DD5A330115",
	   "air_name": "大金立式空调",
	   "air_model": "A20171009",
	   "pi": 2,
	   "power": 1000,
	   "brand": "大金",
	   "factory": "上海青浦大金空调制造厂",
	   "description": "智能空调"
	}

* 应答示例
  >{
	   "msg": "",
	   "code": 0
   }

### 6.3 空调删除 delete <a name="air_delete"/>
* 请求URL:http://${DOMAIN}/interface/air/delete
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| air_id |  array(string)  | 是 | id数组 |

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |


* 请求示例
   >{
       "air_id": ["A86E79218965EB72C92A549DD5A330115", "A96E79218965EB72C92A549DD5A330112"]
	}

* 应答示例
  >{
	   "msg": "",
	   "code": 0
   }
   
### 6.4 空调查询 query <a name="air_query"/>
* 请求URL:http://${DOMAIN}/interface/air/query
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| air_id |  string  | 是 | 空调id |

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |
| data |  json object  | 是 | 对象 |

* 应答data字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| air_id |  string  | 是 | 空调id |
| air_name | string | 是 | 空调名称 |
| air_model | string | 是 | 空调型号 |
| pi | int | 是 | 空调匹数 |
| power | int | 是 | 空调能耗 |
| brand | string | 是 | 空调品牌 |
| factory | string | 是 | 空调制造商 |
| description | string | 是 | 备注 |
| update_time | int | 是 | 更新时间 |
| create_time | int | 是 | 创建时间 |

* 请求示例
   >{
	   "air_id": "A86E79218965EB72C92A549DD5A330115"
	}

* 应答示例
  >{
	  "msg": "",
	  "code": 0,
	  "data": {
          "air_id": "A86E79218965EB72C92A549DD5A330115",
	      "air_name": "大金立式空调",
	      "air_model": "A20171009",
	      "pi": 2,
	      "power": 1000,
	      "brand": "大金",
	      "factory": "上海青浦大金空调制造厂",
	      "description": "智能空调",
	      "create_time": 1590688989,
	      "update_time": 1590688989
	  }
    }
    
### 6.5 空调列表 query_list <a name="air_query_list"/>
* 请求URL:http://${DOMAIN}/interface/air/query_list
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| air_id |  string  | 否 | id |
| air_name | string | 否 | 空调名称 |
| air_model | string | 否 | 空调型号 |
| brand | string | 否 | 空调品牌 |
| factory | string | 否 | 空调制造商 |
| page_number | int  | 是 |  页码  |
| page_size | int  | 是 |  每页记录条数 |

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |
| data |  json object  | 是 | 对象信息 |

* data字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| page_number | int  | 是 | 页码  |
| page_size | int  | 是 | 每页记录条数 |
| total_number |  int | 是 | 总记录条数  |
| list |  json array  | 是 | 对象数组 |

* list数组单个元素字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| air_id |  string  | 是 | 空调id |
| air_name | string | 是 | 空调名称 |
| air_model | string | 是 | 空调型号 |
| pi | int | 是 | 空调匹数 |
| power | int | 是 | 空调能耗 |
| brand | string | 是 | 空调品牌 |
| factory | string | 是 | 空调制造商 |
| description | string | 是 | 备注 |
| update_time | int | 是 | 更新时间 |
| create_time | int | 是 | 创建时间 |

* 请求示例
   >{
       "air_id": "A86E79218965EB72C92A549DD5A330115",
	   "air_name": "大金立式空调",
	   "air_model": "A20171009",
	   "brand": "大金",
	   "factory": "上海青浦大金空调制造厂",
	   "page_number": 1,
	   "page_size": 10
	}

* 应答示例
  >{
	"msg": "",
	"code": 0,
	"data": {
		"page_number": 1,
	    "page_size": 10,
	    "total_number": 2,
	    "list":[
		   {
              "air_id": "A86E79218965EB72C92A549DD5A330115",
	          "air_name": "大金立式空调",
	          "air_model": "A20171009",
	          "pi": 2,
	          "power": 1000,
	          "brand": "大金",
	          "factory": "上海青浦大金空调制造厂",
	          "description": "智能空调",
	          "create_time": 1590688989,
	          "update_time": 1590688989	      
		   },
		   {
              "air_id": "A96E79218965EB72C92A549DD5A330112",
	          "air_name": "格力立式空调",
	          "air_model": "G20171009",
	          "pi": 2,
	          "power": 1000,
	          "brand": "格力",
	          "factory": "上海金山格力空调制造厂",
	          "description": "智能空调",
	          "create_time": 1590688989,
	          "update_time": 1590688989	   		      
		   }]
	 }
   }
   
## 7.建筑物管理 <a name="building_manage"/>
### 7.1 建筑物增加 add <a name="building_add"/>
* 请求URL:http://${DOMAIN}/interface/building/add
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| building_name | string | 是 | 建筑物名称 |
| parent_id | string | 是 | 父建筑物ID |
| description | string | 是 | 备注 |

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |
| data |  json object  | 是 | 对象 |

* 应答data字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| building_id |  string  | 是 | id |
| building_name |  string  | 是 | 名称 |

* 请求示例
   >{
	   "building_name": "教学一楼",
	   "parent_id": "B96E79218965EB72C92A549DD5A330113",
	   "description": "教学一楼"
	}

* 应答示例
  >{
	  "msg": "",
	  "code": 0,
	  "data": {
		"building_id": "B96E79218965EB72C92A549DD5A330112",
		"building_name": "教学一楼"
	  }
	}
	
### 7.2 建筑物修改 update <a name="building_update"/>
* 请求URL:http://${DOMAIN}/interface/building/update
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| building_id |  string  | 是 | id |
| building_name | string | 否 | 名称 |
| parent_id | string | 否 | 父建筑物ID |
| description | string | 否 | 备注 |

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |

* 请求示例
   >{
       "building_id": "B96E79218965EB72C92A549DD5A330112",
	   "building_name": "教学一楼",
	   "parent_id": "B96E79218965EB72C92A549DD5A330113",
	   "description": "教学一楼"
	}

* 应答示例
  >{
	   "msg": "",
	   "code": 0
   }

### 7.3 建筑物删除 delete <a name="building_delete"/>
* 请求URL:http://${DOMAIN}/interface/building/delete
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| building_id |  array  | 是 | id数组 |

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |


* 请求示例
   >{
       "building_id": ["B96E79218965EB72C92A549DD5A330112", "B86E79218965EB72C92A549DD5A330113", "B76E79218965EB72C92A549DD5A330116"]
	}

* 应答示例
  >{
	   "msg": "",
	   "code": 0
   }
   
### 7.4 建筑物查询 query <a name="building_query"/>
* 请求URL:http://${DOMAIN}/interface/building/query
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| building_id |  string  | 是 | 建筑物id |

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |
| data |  json object  | 是 | 对象 |

* 应答data字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| building_id |  string  | 是 | 建筑物id |
| building_name | string | 是 | 建筑物名称 |
| parent_id | string | 是 | 父建筑物ID |
| description | string | 是 | 备注 |
| update_time | int | 是 | 更新时间 |
| create_time | int | 是 | 创建时间 |

* 请求示例
   >{
       "building_id": "B96E79218965EB72C92A549DD5A330112"
	}

* 应答示例
  >{
	  "msg": "",
	  "code": 0,
	  "data": {
       "building_id": "B96E79218965EB72C92A549DD5A330112",
	   "building_name": "教学一楼",
	   "parent_id": "B96E79218965EB72C92A549DD5A330113",
	   "description": "教学一楼"
	   "create_time": 1590688989,
	   "update_time": 1590688989	 
	  }
    }
    
### 7.5 建筑物列表 query_list <a name="building_query_list"/>
* 请求URL:http://${DOMAIN}/interface/building/query_list
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| building_id |  string  | 否 | 建筑物id |
| building_name | string | 否 | 建筑物名称 |
| parent_id | string | 否 | 父建筑物ID |
| page_number | int  | 是 |  页码  |
| page_size | int  | 是 |  每页记录条数 |

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |
| data |  json object  | 是 | 对象信息 |

* data字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| page_number | int  | 是 | 页码  |
| page_size | int  | 是 | 每页记录条数 |
| total_number |  int | 是 | 总记录条数  |
| list |  json array  | 是 | 对象数组 |

* list数组单个元素字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| building_id |  string  | 是 | 建筑物id |
| building_name | string | 是 | 建筑物名称 |
| parent_id | string | 是 | 父建筑物ID |
| description | string | 是 | 备注 |
| update_time | int | 是 | 更新时间 |
| create_time | int | 是 | 创建时间 |

* 请求示例
   >{
       "building_id": "B96E79218965EB72C92A549DD5A330112",
	   "building_name": "教学一楼",
	   "parent_id": "B96E79218965EB72C92A549DD5A330113",
	   "page_number": 1,
	   "page_size": 10
	}

* 应答示例
  >{
	"msg": "",
	"code": 0,
	"data": {
		"page_number": 1,
	    "page_size": 10,
	    "total_number": 2,
	    "list":[
		   {
              "building_id": "B96E79218965EB72C92A549DD5A330112",
	          "building_name": "教学一楼",
	          "parent_id": "B96E79218965EB72C92A549DD5A330113",
	          "description": "教学一楼"
	          "create_time": 1590688989,
	          "update_time": 1590688989
		   },
		   {
              "building_id": "B86E79218965EB72C92A549DD5A330116",
	          "building_name": "教学二楼",
	          "parent_id": "B96E79218965EB72C92A549DD5A330113",
	          "description": "教学二楼"
	          "create_time": 1590688989,
	          "update_time": 1590688989
		   }]
	 }
   }
   
### 7.6 建筑树 tree <a name="building_tree"/>
* 请求URL:http://${DOMAIN}/interface/building/tree
* 请求字段:无

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |
| data |  json object  | 是 | 对象信息 |

* data字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| list |  json array  | 是 | 对象数组 |

* list数组单个元素字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| building_id |  string  | 是 | 建筑物id |
| building_name | string | 是 | 建筑物名称 |
| parent_id | string | 是 | 父建筑物ID |
| children | array(object) | 否 | 子建筑物 |
| description | string | 是 | 备注 |
| update_time | int | 是 | 更新时间 |
| create_time | int | 是 | 创建时间 |

* children 对象字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| building_id |  string  | 是 | 建筑物id |
| building_name | string | 是 | 建筑物名称 |
| parent_id | string | 是 | 父建筑物ID |
| children | array(object) | 否 | 子建筑物 |
| description | string | 是 | 备注 |
| update_time | int | 是 | 更新时间 |
| create_time | int | 是 | 创建时间 |

* 请求示例
   >{
	}
	
* 应答示例
  >{
	"msg": "",
	"code": 0,
	"data": {
	    "list":[
		   {
              "building_id": "B96E79218965EB72C92A549DD5A330112",
	          "building_name": "教学一楼",
	          "parent_id": "B96E79218965EB72C92A549DD5A330113",
	          "children":[
	            {
                   "building_id": "B86E79218965EB72C92A549DD5A330116",
	               "building_name": "教学二楼",
	               "parent_id": "B96E79218965EB72C92A549DD5A330113",
	               "description": "教学二楼"
	               "create_time": 1590688989,
	               "update_time": 1590688989	            
	            }
	          ],
	          "description": "教学一楼"
	          "create_time": 1590688989,
	          "update_time": 1590688989
		   },
		   {
              "building_id": "B86E79218965EB72C92A549DD5A330116",
	          "building_name": "教学二楼",
	          "parent_id": "B96E79218965EB72C92A549DD5A330113",
	          "description": "教学二楼"
	          "create_time": 1590688989,
	          "update_time": 1590688989
		   }]
	 }
   }	
        
## 8.部门管理 <a name="dept_manage"/>
### 8.1 部门增加 add <a name="dept_add"/>
* 请求URL:http://${DOMAIN}/interface/dept/add
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| dept_name | string | 是 | 部门名称 |
| parent_id | string | 是 | 父部门ID |
| description | string | 是 | 备注 |

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |
| data |  json object  | 是 | 对象 |

* 应答data字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| dept_id |  string  | 是 | id |
| dept_name |  string  | 是 | 名称 |

* 请求示例
   >{
	   "dept_name": "财务科",
	   "parent_id": "B96E89218965EB82C92A549DD5A330113",
	   "description": "财务科"
	}

* 应答示例
  >{
	  "msg": "",
	  "code": 0,
	  "data": {
		"dept_id": "B96E89218965EB82C92A549DD5A330112",
		"dept_name": "财务科"
	  }
	}
	
### 8.2 部门修改 update <a name="dept_update"/>
* 请求URL:http://${DOMAIN}/interface/dept/update
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| dept_id |  string  | 是 | id |
| dept_name | string | 否 | 名称 |
| parent_id | string | 否 | 父部门ID |
| description | string | 否 | 备注 |

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |

* 请求示例
   >{
       "dept_id": "B96E89218965EB82C92A549DD5A330112",
	   "dept_name": "财务科",
	   "parent_id": "B96E89218965EB82C92A549DD5A330113",
	   "description": "财务科"
	}

* 应答示例
  >{
	   "msg": "",
	   "code": 0
   }

### 8.3 部门删除 delete <a name="dept_delete"/>
* 请求URL:http://${DOMAIN}/interface/dept/delete
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| dept_id |  array  | 是 | id数组 |

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |


* 请求示例
   >{
       "dept_id": ["B96E89218965EB82C92A549DD5A330112", "B86E89218965EB82C92A549DD5A330113", "B86E89218965EB82C92A549DD5A330116"]
	}

* 应答示例
  >{
	   "msg": "",
	   "code": 0
   }
   
### 8.4 部门查询 query <a name="dept_query"/>
* 请求URL:http://${DOMAIN}/interface/dept/query
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| dept_id |  string  | 是 | 部门id |

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |
| data |  json object  | 是 | 对象 |

* 应答data字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| dept_id |  string  | 是 | 部门id |
| dept_name | string | 是 | 部门名称 |
| parent_id | string | 是 | 父部门ID |
| description | string | 是 | 备注 |
| update_time | int | 是 | 更新时间 |
| create_time | int | 是 | 创建时间 |

* 请求示例
   >{
       "dept_id": "B96E89218965EB82C92A549DD5A330112"
	}

* 应答示例
  >{
	  "msg": "",
	  "code": 0,
	  "data": {
       "dept_id": "B96E89218965EB82C92A549DD5A330112",
	   "dept_name": "财务科",
	   "parent_id": "B96E89218965EB82C92A549DD5A330113",
	   "description": "财务科"
	   "create_time": 1590688989,
	   "update_time": 1590688989	 
	  }
    }
    
### 8.5 部门列表 query_list <a name="dept_query_list"/>
* 请求URL:http://${DOMAIN}/interface/dept/query_list
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| dept_id |  string  | 否 | 部门id |
| dept_name | string | 否 | 部门名称 |
| parent_id | string | 否 | 父部门ID |
| page_number | int  | 是 |  页码  |
| page_size | int  | 是 |  每页记录条数 |

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |
| data |  json object  | 是 | 对象信息 |

* data字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| page_number | int  | 是 | 页码  |
| page_size | int  | 是 | 每页记录条数 |
| total_number |  int | 是 | 总记录条数  |
| list |  json array  | 是 | 对象数组 |

* list数组单个元素字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| dept_id |  string  | 是 | 部门id |
| dept_name | string | 是 | 部门名称 |
| parent_id | string | 是 | 父部门ID |
| description | string | 是 | 备注 |
| update_time | int | 是 | 更新时间 |
| create_time | int | 是 | 创建时间 |

* 请求示例
   >{
       "dept_id": "B96E89218965EB82C92A549DD5A330112",
	   "dept_name": "财务科",
	   "parent_id": "B96E89218965EB82C92A549DD5A330113",
	   "page_number": 1,
	   "page_size": 10
	}

* 应答示例
  >{
	"msg": "",
	"code": 0,
	"data": {
		"page_number": 1,
	    "page_size": 10,
	    "total_number": 2,
	    "list":[
		   {
              "dept_id": "B96E89218965EB82C92A549DD5A330112",
	          "dept_name": "财务科",
	          "parent_id": "B96E89218965EB82C92A549DD5A330113",
	          "description": "财务科"
	          "create_time": 1590688989,
	          "update_time": 1590688989
		   },
		   {
              "dept_id": "B86E89218965EB82C92A549DD5A330116",
	          "dept_name": "教务处",
	          "parent_id": "B96E89218965EB82C92A549DD5A330113",
	          "description": "教务处"
	          "create_time": 1590688989,
	          "update_time": 1590688989
		   }]
	 }
   }

### 8.6 部门树 tree <a name="dept_tree"/>
* 请求URL:http://${DOMAIN}/interface/dept/tree
* 请求字段:无

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |
| data |  json object  | 是 | 对象信息 |

* data字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| list |  json array  | 是 | 对象数组 |

* list数组单个元素字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| dept_id |  string  | 是 | 部门id |
| dept_name | string | 是 | 部门名称 |
| parent_id | string | 是 | 父部门ID |
| children | array(object) | 否 | 父部门ID |
| description | string | 是 | 备注 |
| update_time | int | 是 | 更新时间 |
| create_time | int | 是 | 创建时间 |

* children 数组单个元素字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| dept_id |  string  | 是 | 部门id |
| dept_name | string | 是 | 部门名称 |
| parent_id | string | 是 | 父部门ID |
| children | array(object) | 否 | 父部门ID |
| description | string | 是 | 备注 |
| update_time | int | 是 | 更新时间 |
| create_time | int | 是 | 创建时间 |

* 请求示例
   >{
	}

* 应答示例
  >{
	"msg": "",
	"code": 0,
	"data": {
	    "list":[
		   {
              "dept_id": "B96E89218965EB82C92A549DD5A330112",
	          "dept_name": "财务科",
	          "parent_id": "B96E89218965EB82C92A549DD5A330113",
	          "children":[
	            {
                    "dept_id": "B86E89218965EB82C92A549DD5A330116",
	                "dept_name": "教务处",
	                "parent_id": "B96E89218965EB82C92A549DD5A330113",
	                "description": "教务处"
	                "create_time": 1590688989,
	                "update_time": 1590688989	            
	            }
	          ],
	          "description": "财务科"
	          "create_time": 1590688989,
	          "update_time": 1590688989
		   },
		   {
              "dept_id": "B86E89218965EB82C92A549DD5A330116",
	          "dept_name": "教务处",
	          "parent_id": "B96E89218965EB82C92A549DD5A330113",
	          "description": "教务处"
	          "create_time": 1590688989,
	          "update_time": 1590688989
		   }]
	 }
   }
     
## 9.终端管理 <a name="terminal_manage"/>
### 9.1 终端增加 add <a name="terminal_add"/>
* 请求URL:http://${DOMAIN}/interface/terminal/add
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| terminal_name | string | 是 | 终端名称 |
| device_id | int | 否 | 设备ID |
| etc_id | string | 否 | 配置ID |
| rule_id | string | 否 | 规则ID |
| air_id | string | 否 | 空调ID |
| building_id | string | 是 | 建筑物ID |
| dept_id | string | 是 | 部门ID |
| air_buy_date | int | 是 | 购买日期 |
| maintenance_records | array(object) | 是 | 维保记录 |
| terminal_sn | string | 是 | 终端序列号 |
| description | string | 是 | 备注 |

* maintenance_records 字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| item |  string  | 是 | 维修保养项目 |
| date |  int  | 是 | 时间 |
| description |  string  | 是 | 备注 |

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |
| data |  json object  | 是 | 对象 |

* 应答data字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| terminal_id |  string  | 是 | id |
| terminal_name |  string  | 是 | 名称 |

* 请求示例
   >{
	   "terminal_name": "财务科一室",
	   "device_id": 1,
	   "etc_id": "E96E79218969EB72C92A949DD9A330113",
	   "rule_id": "R96E79218969EB72C92A949DD9A330113",
	   "air_id": "A96E79218969EB72C92A949DD9A330113",
	   "building_id": "B96E79218969EB72C92A949DD9A330113",
	   "dept_id": "D96E79218969EB72C92A949DD9A330113",
	   "air_buy_date": 1590688989,
	   "terminal_sn": "D90889223424567",
	   "maintenance_records": [{
	       "item": "清洗风扇",
	       "date": 1590688900,
	       "description": ""
	   }],
	   "description": "财务科"
	}

* 应答示例
  >{
	  "msg": "",
	  "code": 0,
	  "data": {
		"terminal_id": "T96E79218969EB72C92A949DD9A330112",
		"terminal_name": "财务科一室"
	  }
	}
	
### 9.2 终端修改 update <a name="terminal_update"/>
* 请求URL:http://${DOMAIN}/interface/terminal/update
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| terminal_id |  string  | 是 | id |
| terminal_name | string | 否 | 终端名称 |
| device_id | int | 否 | 设备ID |
| etc_id | string | 否 | 配置ID |
| rule_id | string | 否 | 规则ID |
| air_id | string | 否 | 空调ID |
| building_id | string | 否 | 建筑物ID |
| dept_id | string | 否 | 部门ID |
| air_buy_date | int | 否 | 购买日期 |
| maintenance_records | array(object) | 否 | 维保记录 |
| terminal_sn | string | 否 | 终端序列号 |
| description | string | 否 | 备注 |

* maintenance_records 字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| item |  string  | 是 | 维修保养项目 |
| date |  int  | 是 | 时间 |
| description |  string  | 是 | 备注 |

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |


* 请求示例
   >{
       "terminal_id": "T96E79218969EB72C92A949DD9A330112",
	   "terminal_name": "财务科一室",
	   "device_id": 1,
	   "etc_id": "E96E79218969EB72C92A949DD9A330113",
	   "rule_id": "R96E79218969EB72C92A949DD9A330113",
	   "air_id": "A96E79218969EB72C92A949DD9A330113",
	   "building_id": "B96E79218969EB72C92A949DD9A330113",
	   "dept_id": "D96E79218969EB72C92A949DD9A330113",
	   "air_buy_date": 1590688989,
	   "terminal_sn": "D90889223424567",
	   "maintenance_records": [{
	       "item": "清洗风扇",
	       "date": 1590688900,
	       "description": ""
	   }],
	   "description": "财务科"   
	}

* 应答示例
  >{
	   "msg": "",
	   "code": 0
   }

### 9.3 终端删除 delete <a name="terminal_delete"/>
* 请求URL:http://${DOMAIN}/interface/terminal/delete
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| terminal_id |  array  | 是 | id数组 |

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |


* 请求示例
   >{
       "terminal_id": ["T96E79218969EB72C92A949DD9A330112", "T76E79218969EB72C92A949DD9A330113", "T76E79218969EB72C92A949DD9A330116"]
	}

* 应答示例
  >{
	   "msg": "",
	   "code": 0
   }
   
### 9.4 终端查询 query <a name="terminal_query"/>
* 请求URL:http://${DOMAIN}/interface/terminal/query
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| terminal_id |  string  | 是 | 终端id |

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |
| data |  json object  | 是 | 对象 |

* 应答data字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| terminal_id |  string  | 是 | id |
| terminal_name | string | 是 | 终端名称 |
| device_id | int | 是 | 设备ID |
| etc_id | string | 是 | 配置ID |
| etc_name | string | 是 | 配置名称 |
| rule_id | string | 是 | 规则ID |
| rule_name | string | 是 | 规则名称 |
| air_id | string | 是 | 空调ID |
| air_name | string | 是 | 空调名称 |
| air_model | string | 是 | 空调型号 |
| building_id | string | 是 | 建筑物ID |
| building_name | string | 是 | 建筑物名称 |
| dept_id | string | 是 | 部门ID |
| dept_name | string | 是 | 部门名称 |
| air_buy_date | int | 是 | 购买日期 |
| maintenance_records | array(object) | 是 | 维保记录 |
| terminal_sn | string | 是 | 终端序列号 |
| terminal_version | string | 是 | 终端软件版本 |
| description | string | 是 | 备注 |
| update_time | int | 是 | 更新时间 |
| create_time | int | 是 | 创建时间 |

* maintenance_records 字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| item |  string  | 是 | 维修保养项目 |
| date |  int  | 是 | 时间 |
| description |  string  | 是 | 备注 |

* 请求示例
   >{
	   "terminal_id": "T96E79218969EB72C92A949DD9A330112"
	}

* 应答示例
  >{
	  "msg": "",
	  "code": 0,
	  "data": {
       "terminal_id": "T96E79218969EB72C92A949DD9A330112",
	   "terminal_name": "财务科一室",
	   "device_id": 1,
	   "etc_id": "E96E79218969EB72C92A949DD9A330113",
	   "etc_name": "食堂配置",
	   "rule_id": "R96E79218969EB72C92A949DD9A330113",
	   "rule_name": "食堂规则",
	   "air_id": "A96E79218969EB72C92A949DD9A330113",
	   "air_name": "大金立式空调",
	   "air_model": "A20171009",	   
	   "building_id": "B96E79218969EB72C92A949DD9A330113",
	   "building_name": "教学一楼",
	   "dept_id": "D96E79218969EB72C92A949DD9A330113",
	   "dept_name": "财务科",
	   "air_buy_date": 1590688989,
	   "terminal_sn": "D90889223424567",
	   "terminal_version": "001",
	   "maintenance_records": [{
	       "item": "清洗风扇",
	       "date": 1590688900,
	       "description": ""
	   }],
	   "description": "财务科",
	   "create_time": 1590688989,
	   "update_time": 1590688989	    
	  }
    }
    
### 9.5 终端列表 query_list <a name="terminal_query_list"/>
* 请求URL:http://${DOMAIN}/interface/terminal/query_list
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| terminal_id |  string  | 否 | id |
| device_id | int | 否 | 设备ID |
| air_id | string | 否 | 空调ID |
| building_id | string | 否 | 建筑物ID |
| dept_id | string | 否 | 部门ID |
| terminal_name | string | 否 | 终端名称 |
| air_name | string | 否 | 空调名称 |
| dept_name | string | 否 | 部门名称 |
| building_name | string | 否 | 建筑名称 |
| page_number | int  | 是 |  页码  |
| page_size | int  | 是 |  每页记录条数 |

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |
| data |  json object  | 是 | 对象信息 |

* data字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| page_number | int  | 是 | 页码  |
| page_size | int  | 是 | 每页记录条数 |
| total_number |  int | 是 | 总记录条数  |
| list |  json array  | 是 | 对象数组 |

* list数组单个元素字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| terminal_id |  string  | 是 | id |
| terminal_name | string | 是 | 终端名称 |
| device_id | int | 是 | 设备ID |
| etc_id | string | 是 | 配置ID |
| etc_name | string | 是 | 配置名称 |
| rule_id | string | 是 | 规则ID |
| rule_name | string | 是 | 规则名称 |
| air_id | string | 是 | 空调ID |
| air_name | string | 是 | 空调名称 |
| air_model | string | 是 | 空调型号 |
| building_id | string | 是 | 建筑物ID |
| building_name | string | 是 | 建筑物名称 |
| dept_id | string | 是 | 部门ID |
| dept_name | string | 是 | 部门名称 |
| air_buy_date | int | 是 | 购买日期 |
| maintenance_records | array(object) | 是 | 维保记录 |
| terminal_sn | string | 是 | 终端序列号 |
| terminal_version | string | 是 | 终端软件版本 |
| description | string | 是 | 备注 |
| update_time | int | 是 | 更新时间 |
| create_time | int | 是 | 创建时间 |

* maintenance_records 字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| item |  string  | 是 | 维修保养项目 |
| date |  int  | 是 | 时间 |
| description |  string  | 是 | 备注 |

* 请求示例
   >{
	   "terminal_id": "T96E79218969EB72C92A949DD9A330112",
	   "terminal_name": "财务科一室",
	   "device_id": 1,
	   "air_id": "A96E79218969EB72C92A949DD9A330113",
	   "air_name": "大金空调",
	   "building_id": "B96E79218969EB72C92A949DD9A330113",
	   "building_name": "教学楼"
	   "dept_id": "D96E79218969EB72C92A949DD9A330113",
	   "dept_name": "财务科",
	   "page_number": 1,
	   "page_size": 10
	}

* 应答示例
  >{
	"msg": "",
	"code": 0,
	"data": {
		"page_number": 1,
	    "page_size": 10,
	    "total_number": 2,
	    "list":[
		   {
              "terminal_id": "T96E79218969EB72C92A949DD9A330112",
	          "terminal_name": "食堂",
	          "device_id": 1,
	          "etc_id": "E96E79218969EB72C92A949DD9A330113",
	          "etc_name": "食堂配置",
	          "rule_id": "R96E79218969EB72C92A949DD9A330113",
	          "rule_name": "食堂规则",
	          "air_id": "A96E79218969EB72C92A949DD9A330113",
	          "air_name": "大金立式空调",
	          "air_model": "A20171009",	   
	          "building_id": "B96E79218969EB72C92A949DD9A330113",
	          "building_name": "教学一楼",
	          "dept_id": "D96E79218969EB72C92A949DD9A330113",
	          "dept_name": "财务科",
	          "air_buy_date": 1590688989,
	          "terminal_sn": "D90889223424567",
	          "terminal_version": "001",
	          "maintenance_records": [{
	             "item": "清洗风扇",
	             "date": 1590688900,
	             "description": ""
	          }],
	          "description": "财务科",
	          "create_time": 1590688989,
	          "update_time": 1590688989
		   },
		   {
              "terminal_id": "T86E79218969EB72C92A949DD9A330116",
	          "terminal_name": "教务处一室",
	          "device_id": 2,
	          "etc_id": "E96E79218969EB72C92A949DD9A330113",
	          "etc_name": "办公配置",
	          "rule_id": "R96E79218969EB72C92A949DD9A330113",
	          "rule_name": "办公规则",
	          "air_id": "A96E79218969EB72C92A949DD9A330113",
	          "air_name": "大金立式空调",
	          "air_model": "A20171009",	   
	          "building_id": "B96E79218969EB72C92A949DD9A330113",
	          "building_name": "教学一楼",
	          "dept_id": "D96E79218969EB72C92A949DD9A330113",
	          "dept_name": "财务科",
	          "air_buy_date": 1590688989,
	          "terminal_sn": "D90889223424567",
	          "terminal_version": "001",
	          "maintenance_records": [{
	             "item": "清洗风扇",
	             "date": 1590688900,
	             "description": ""
	          }],
	          "description": "教务处一室",
	          "create_time": 1590688989,
	          "update_time": 1590688989
		   }]
	 }
   }

## 10.规则管理 <a name="rule_manage"/>
### 10.1 规则增加 add <a name="rule_add"/>
* 请求URL:http://${DOMAIN}/interface/rule/add
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| rule_name | string | 是 | 规则名称 |
| rule_content | string | 是 | 规则内容 |
| description | string | 是 | 备注 |

* rule_content 内容格式
  >{
      15分钟为粒度，一天分96个粒度，0 关，1 开，15分钟粒度之间用","隔开,天和天之间用"|"隔开
      周一
      0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|
      周二
      0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|
      周三
      0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|
      周四
      0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|
      周五
      0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|
      周六
      0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|
      周日
      1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  }

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |
| data |  json object  | 是 | 对象 |

* 应答data字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| rule_id |  string  | 是 | id |
| rule_name |  string  | 是 | 名称 |

* 请求示例
   >{
	   "rule_name": "食堂规则",
	   "rule_content": "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0",
	   "description": "食堂"
	}

* 应答示例
  >{
	  "msg": "",
	  "code": 0,
	  "data": {
		"rule_id": "R96E109218965EB102C92A549DD5A330112",
		"rule_name": "食堂规则"
	  }
	}
	
### 10.2 规则修改 update <a name="rule_update"/>
* 请求URL:http://${DOMAIN}/interface/rule/update
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| rule_id |  string  | 是 | id |
| rule_name | string | 否 | 名称 |
| rule_content | string | 否 | 规则内容 |
| description | string | 否 | 备注 |

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |

* 请求示例
   >{
       "rule_id": "R96E109218965EB102C92A549DD5A330112",
	   "rule_name": "食堂规则",
	   "rule_content": "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0",
	   "description": "食堂规则"
	}

* 应答示例
  >{
	   "msg": "",
	   "code": 0
   }

### 10.3 规则删除 delete <a name="rule_delete"/>
* 请求URL:http://${DOMAIN}/interface/rule/delete
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| rule_id |  array  | 是 | id数组 |

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |


* 请求示例
   >{
       "rule_id": ["R96E109218965EB102C92A549DD5A330112", "R86E109218965EB102C92A549DD5A330115", "R76E109218965EB102C92A549DD5A330116"]
	}

* 应答示例
  >{
	   "msg": "",
	   "code": 0
   }
   
### 10.4 规则查询 query <a name="rule_query"/>
* 请求URL:http://${DOMAIN}/interface/rule/query
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| rule_id |  string  | 是 | 规则id |

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |
| data |  json object  | 是 | 对象 |

* 应答data字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| rule_id |  string  | 是 | 规则id |
| rule_name | string | 是 | 规则名称 |
| rule_content | string | 是 | 规则内容 |
| description | string | 是 | 备注 |
| update_time | int | 是 | 更新时间 |
| create_time | int | 是 | 创建时间 |

* 请求示例
   >{
       "rule_id": "R96E109218965EB102C92A549DD5A330112"
	}

* 应答示例
  >{
	  "msg": "",
	  "code": 0,
	  "data": {
       "rule_id": "R96E109218965EB102C92A549DD5A330112",
	   "rule_name": "食堂规则",
	   "rule_content": "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0",
	   "description": "食堂规则"
	   "create_time": 1590688989,
	   "update_time": 1590688989	 
	  }
    }
    
### 10.5 规则列表 query_list <a name="rule_query_list"/>
* 请求URL:http://${DOMAIN}/interface/rule/query_list
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| rule_id |  string  | 否 | 规则id |
| rule_name | string | 否 | 规则名称 |
| page_number | int  | 是 |  页码  |
| page_size | int  | 是 |  每页记录条数 |

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |
| data |  json object  | 是 | 对象信息 |

* data字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| page_number | int  | 是 | 页码  |
| page_size | int  | 是 | 每页记录条数 |
| total_number |  int | 是 | 总记录条数  |
| list |  json array  | 是 | 对象数组 |

* list数组单个元素字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| rule_id |  string  | 是 | 规则id |
| rule_name | string | 是 | 规则名称 |
| rule_content | string | 是 | 规则内容 |
| description | string | 是 | 备注 |
| update_time | int | 是 | 更新时间 |
| create_time | int | 是 | 创建时间 |

* 请求示例
   >{
       "rule_id": "B96E109218965EB102C92A549DD5A330112",
	   "rule_name": "食堂规则",
	   "page_number": 1,
	   "page_size": 10
	}

* 应答示例
  >{
	"msg": "",
	"code": 0,
	"data": {
		"page_number": 1,
	    "page_size": 10,
	    "total_number": 2,
	    "list":[
		   {
              "rule_id": "R96E109218965EB102C92A549DD5A330112",
	          "rule_name": "食堂规则",
	          "rule_content": "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0",
	          "description": "食堂规则"
	          "create_time": 1590688989,
	          "update_time": 1590688989
		   },
		   {
              "rule_id": "R86E109218965EB102C92A549DD5A330116",
	          "rule_name": "办公规则",
	          "rule_content": "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0",
	          "description": "办公规则"
	          "create_time": 1590688989,
	          "update_time": 1590688989
		   }]
	 }
   }
       
## 11.配置管理 <a name="etc_manage"/>
### 11.1 配置增加 add <a name="etc_add"/>
* 请求URL:http://${DOMAIN}/interface/etc/add
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| etc_name | string | 是 | 配置名称 |
| max_heat | int | 是 | 制热最高温度 |
| mid_heat | int | 是 | 制热中间温度 |
| min_heat | int | 是 | 制热最低温度 |
| max_cool | int | 是 | 制冷最高温度 |
| max_cool | int | 是 | 制冷中间温度 |
| max_cool | int | 是 | 制冷最低温度 |
| max_humidity | int | 是 | 除湿最高值 |
| min_humidity | int | 是 | 除湿最低值 |
| etc_mode | string | 是 | 空调模式 |
| description | string | 是 | 备注 |

* etc_mode
 > {
    0 关， 1 开
    第一位  人感控制，第二位  时间段控制，第三位 温度控制，第四位 窗户控制，第五位 门控制， 第六位 遥控器控制，第七位 湿度控制
    0,1,1,0,0,0,0,0
 }

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |
| data |  json object  | 是 | 对象 |

* 应答data字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| etc_id |  string  | 是 | id |
| etc_name |  string  | 是 | 名称 |

* 请求示例
   >{
	   "etc_name": "大金立式配置",
	   "max_heat": 30,
	   "mid_heat": 26,
	   "min_heat": 22,
	   "max_cool": 26,
	   "mid_cool": 24,
	   "min_cool": 22,	   
	   "max_humidity": 80,
	   "min_humidity": 60,
	   "etc_mode": "0,1,1,0,0,0,0,0",
	   "description": "智能配置"
	}

* 应答示例
  >{
	  "msg": "",
	  "code": 0,
	  "data": {
		"etc_id": "E811E792189115EB72C92A549DD5A330115",
		"etc_name": "食堂配置"
	  }
	}
	
### 11.2 配置修改 update <a name="etc_update"/>
* 请求URL:http://${DOMAIN}/interface/etc/update
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| etc_id |  string  | 是 | id |
| etc_name | string | 否 | 配置名称 |
| max_heat | int | 否 | 制热最高温度 |
| mid_heat | int | 否 | 制热中间温度 |
| min_heat | int | 否 | 制热最低温度 |
| max_cool | int | 否 | 制冷最高温度 |
| max_cool | int | 否 | 制冷中间温度 |
| max_cool | int | 否 | 制冷最低温度 |
| max_humidity | int | 否 | 除湿最高值 |
| min_humidity | int | 否 | 除湿最低值 |
| etc_mode | string | 否 | 空调模式 |
| description | string | 否 | 备注 |


* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |


* 请求示例
   >{
       "etc_id": "E811E792189115EB72C92A549DD5A330115",
	   "etc_name": "大金立式配置",
	   "max_heat": 30,
	   "mid_heat": 26,
	   "min_heat": 22,
	   "max_cool": 26,
	   "mid_cool": 24,
	   "min_cool": 22,	   
	   "max_humidity": 80,
	   "min_humidity": 60,
	   "etc_mode": "0,1,1,0,0,0,0,0",
	   "description": "智能配置"
	}

* 应答示例
  >{
	   "msg": "",
	   "code": 0
   }

### 11.3 配置删除 delete <a name="etc_delete"/>
* 请求URL:http://${DOMAIN}/interface/etc/delete
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| etc_id |  array(string)  | 是 | id数组 |

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |


* 请求示例
   >{
       "id": ["E811E792189115EB72C92A549DD5A330115", "E911E792189115EB72C92A549DD5A330112"]
	}

* 应答示例
  >{
	   "msg": "",
	   "code": 0
   }
   
### 11.4 配置查询 query <a name="etc_query"/>
* 请求URL:http://${DOMAIN}/interface/etc/query
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| etc_id |  string  | 是 | 配置id |

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |
| data |  json object  | 是 | 对象 |

* 应答data字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| etc_id |  string  | 是 | 配置id |
| etc_name | string | 是 | 配置名称 |
| max_heat | int | 是 | 制热最高温度 |
| mid_heat | int | 是 | 制热中间温度 |
| min_heat | int | 是 | 制热最低温度 |
| max_cool | int | 是 | 制冷最高温度 |
| max_cool | int | 是 | 制冷中间温度 |
| max_cool | int | 是 | 制冷最低温度 |
| max_humidity | int | 是 | 除湿最高值 |
| min_humidity | int | 是 | 除湿最低值 |
| etc_mode | string | 是 | 空调模式 |
| description | string | 是 | 备注 |
| update_time | int | 是 | 更新时间 |
| create_time | int | 是 | 创建时间 |

* 请求示例
   >{
	   "id": "E811E792189115EB72C92A549DD5A330115"
	}

* 应答示例
  >{
	  "msg": "",
	  "code": 0,
	  "data": {
          "etc_id": "E811E792189115EB72C92A549DD5A330115",
	      "etc_name": "大金立式配置",
	      "max_heat": 30,
	      "mid_heat": 26,
	      "min_heat": 22,
	      "max_cool": 26,
	      "mid_cool": 24,
	      "min_cool": 22,	   
	      "max_humidity": 80,
	      "min_humidity": 60,
	      "etc_mode": "0,1,1,0,0,0,0,0",
	      "description": "智能配置"
	      "create_time": 15901188989,
	      "update_time": 15901188989
	  }
    }
    
### 11.5 配置列表 query_list <a name="etc_query_list"/>
* 请求URL:http://${DOMAIN}/interface/etc/query_list
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| etc_id |  string  | 否 | id |
| etc_name | string | 否 | 配置名称 |
| page_number | int  | 是 |  页码  |
| page_size | int  | 是 |  每页记录条数 |

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |
| data |  json object  | 是 | 对象信息 |

* data字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| page_number | int  | 是 | 页码  |
| page_size | int  | 是 | 每页记录条数 |
| total_number |  int | 是 | 总记录条数  |
| list |  json array  | 是 | 对象数组 |

* list数组单个元素字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| etc_id |  string  | 是 | 配置id |
| etc_name | string | 是 | 配置名称 |
| max_heat | int | 是 | 制热最高温度 |
| mid_heat | int | 是 | 制热中间温度 |
| min_heat | int | 是 | 制热最低温度 |
| max_cool | int | 是 | 制冷最高温度 |
| max_cool | int | 是 | 制冷中间温度 |
| max_cool | int | 是 | 制冷最低温度 |
| max_humidity | int | 是 | 除湿最高值 |
| min_humidity | int | 是 | 除湿最低值 |
| etc_mode | string | 是 | 空调模式 |
| description | string | 是 | 备注 |
| update_time | int | 是 | 更新时间 |
| create_time | int | 是 | 创建时间 |

* 请求示例
   >{
       "etc_id": "E811E792189115EB72C92A549DD5A330115",
	   "etc_name": "配置",
	   "page_number": 1,
	   "page_size": 10
	}

* 应答示例
  >{
	"msg": "",
	"code": 0,
	"data": {
		"page_number": 1,
	    "page_size": 10,
	    "total_number": 2,
	    "list":[
		   {
               "etc_id": "E811E792189115EB72C92A549DD5A330115",
	           "etc_name": "食堂配置",
	           "max_heat": 30,
	           "mid_heat": 26,
	           "min_heat": 22,
	           "max_cool": 26,
	           "mid_cool": 24,
	           "min_cool": 22,	   
	           "max_humidity": 80,
	           "min_humidity": 60,
	           "etc_mode": "0,1,1,0,0,0,0,0",
	           "description": "智能配置"
	           "create_time": 15901188989,
	           "update_time": 15901188989	      
		   },
		   {
               "etc_id": "E911E792189115EB72C92A549DD5A330112",
	           "etc_name": "办公配置",
	           "max_heat": 30,
	           "mid_heat": 26,
	           "min_heat": 22,
	           "max_cool": 26,
	           "mid_cool": 24,
	           "min_cool": 22,	   
	           "max_humidity": 80,
	           "min_humidity": 60,
	           "etc_mode": "0,1,1,0,0,0,0,0",
	           "description": "智能配置"
	           "create_time": 15901188989,
	           "update_time": 15901188989		   		      
		   }]
	 }
   }
      
## 12.控制管理 <a name="control_manage"/>
### 12.1 控制终端 add <a name="control_add"/>
* 请求URL:http://${DOMAIN}/interface/control/add
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| terminal_id | array(string) | 是 | 终端ID数组 |
| command | int | 是 | 命令 |

* command
  > {
     1 开空调  2  关空调  3  运行参数  4  系统参数  
  }

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |


* 请求示例
   >{
	   "terminal_id": ["T96E79218969EB72C92A949DD9A330112", "T76E79218969EB72C92A949DD9A330113", "T76E79218969EB72C92A949DD9A330116"],
	   "command": 1
	}

* 应答示例
  >{
	  "msg": "",
	  "code": 0
	}
	
### 12.2 控制查询 query <a name="control_query"/>
* 请求URL:http://${DOMAIN}/interface/control/query
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| terminal_id | array(string) | 否 | 终端ID数组 |
| terminal_name | string | 否 | 终端名称 |
| device_id | int | 否 | 设备ID |
| air_id | string | 否 | 空调ID |
| air_name | string | 否 | 空调名称 |
| building_id | string | 否 | 建筑物 |
| building_name | string | 否 | 建筑物名称 |
| dept_id | string | 否 | 部门ID |
| dept_name | string | 否 | 部门名称 |
| control_status | int | 否 | 命令状态 |
| page_number | int  | 是 |  页码  |
| page_size | int  | 是 |  每页记录条数 |

* status
  >{
     0 未发送 1 已发送未回复 2 已发送已回复成功  3 已发送已回复失败  4 规定时间内未响应
  }

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |
| data |  json object  | 是 | 对象信息 |

* data字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| page_number | int  | 是 | 页码  |
| page_size | int  | 是 | 每页记录条数 |
| total_number |  int | 是 | 总记录条数  |
| list |  json array  | 是 | 对象数组 |

* list数组单个元素字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| terminal_id |  string  | 是 | 终端id |
| terminal_name | string | 是 | 终端名称 |
| device_id | int | 否 | 设备ID |
| air_id |  string  | 是 | 空调id |
| air_name | string | 是 | 空调名称 |
| building_id |  string  | 是 | 建筑id |
| building_name | string | 是 | 建筑名称 |
| dept_id |  string  | 是 | 部门id |
| dept_name | string | 是 | 部门名称 |
| command | int | 是 | 命令 |
| control_status | int | 是 | 状态 |
| update_time | int | 是 | 更新时间 |
| create_time | int | 是 | 创建时间 |


* 请求示例
   >{
	   "terminal_id": ["T96E79218969EB72C92A949DD9A330112", "T76E79218969EB72C92A949DD9A330113", "T76E79218969EB72C92A949DD9A330116"],
     "device_id": 20,
	   "status": 1,
	   "terminal_name": "财务室",
	   "building_id": "B96E79218969EB72C92A949DD9A330112",
	   "building_name": "教学楼一楼",
	   "dept_id": "D96E79218969EB72C92A949DD9A330112",
	   "dept_name": "财务室",
	   "page_number": 1,
	   "page_size": 10
	}

* 应答示例
  >{
	"msg": "",
	"code": 0,
	"data": {
		"page_number": 1,
	    "page_size": 10,
	    "total_number": 2,
	    "list":[
		   {
             "terminal_id": "T96E79218969EB72C92A949DD9A330112",
	           "terminal_name": "财务室",
             "device_id": 20,
	           "command": 1,
	           "status": 2,
	           "create_time": 15901188989,
	           "update_time": 15901188989	      
		   },
		   {
             "terminal_id": "T76E79218969EB72C92A949DD9A330113",
	           "terminal_name": "财务室",
             "device_id": 20,
	           "command": 1,
	           "status": 2,
	           "create_time": 15901188989,
	           "update_time": 15901188989	   	   		      
		   }]
	 }
   }
   
## 13.告警管理 <a name="alarm_manage"/>  
### 13.1 告警查询 query <a name="alarm_query"/>
* 请求URL:http://${DOMAIN}/interface/alarm/query
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| terminal_id | string | 否 | 终端ID |
| terminal_name | string | 否 | 终端名称 |
| device_id | int | 否 | 设备ID |
| air_id | string | 否 | 空调ID |
| air_name | string | 否 | 空调名称 |
| building_id | string | 否 | 建筑物 |
| building_name | string | 否 | 建筑物名称 |
| dept_id | string | 否 | 部门ID |
| dept_name | string | 否 | 部门名称 |
| page_number | int  | 是 |  页码  |
| page_size | int  | 是 |  每页记录条数 |

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |
| data |  json object  | 是 | 对象信息 |

* data字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| page_number | int  | 是 | 页码  |
| page_size | int  | 是 | 每页记录条数 |
| total_number |  int | 是 | 总记录条数  |
| list |  json array  | 是 | 对象数组 |

* list数组单个元素字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| terminal_id |  string  | 是 | 终端id |
| terminal_name | string | 是 | 终端名称 |
| device_id | int | 否 | 设备ID |
| air_id | string | 是 | 空调ID |
| air_name | string | 是 | 空调名称 |
| building_id | string | 否 | 建筑物 |
| building_name | string | 否 | 建筑物名称 |
| dept_id | string | 否 | 部门ID |
| dept_name | string | 否 | 部门名称 |
| run_mode | int | 是 | 工作模式 |
| running | int | 是 | 是否运行 |
| temp | int | 是 | 温度 |
| window | int | 是 | 窗户开关 |
| human | int | 是 | 是否有人 |
| door | int | 是 | 门开关 |
| consumption | int | 是 | 能耗 |
| total_consumption | int | 是 | 总能耗 |
| humidity | int | 是 | 湿度 |
| alarm_time | int | 是 | 告警时间 |
| update_time | int | 是 | 更新时间 |
| create_time | int | 是 | 创建时间 |

  
* 请求示例
   >{
	   "terminal_id": "T96E79218969EB72C92A949DD9A330112",
	   "terminal_name": "财务室",
     "device_id": 20,
	   "air_id": "A96E79218969EB72C92A949DD9A330112",
	   "air_name": "空调",	   
	   "building_id": "B96E79218969EB72C92A949DD9A330112",
	   "building_name": "教学楼一楼",
	   "dept_id": "D96E79218969EB72C92A949DD9A330112",
	   "dept_name": "财务室",
	   "page_number": 1,
	   "page_size": 10
	}

* 应答示例
  >{
	"msg": "",
	"code": 0,
	"data": {
		"page_number": 1,
	    "page_size": 10,
	    "total_number": 2,
	    "list":[
		   {
             "terminal_id": "T96E79218969EB72C92A949DD9A330112",
	           "terminal_name": "财务室",
             "device_id": 20,
	           "air_id": "A96E79218969EB72C92A949DD9A330112",
	           "air_name": "大金空调",	           
	           "building_id": "B96E79218969EB72C92A949DD9A330112",
	           "building_name": "教学楼一楼",
	           "dept_id": "D96E79218969EB72C92A949DD9A330112",
	           "dept_name": "财务科",	  
	           "run_mode": 1,
	           "running": 1,
	           "temp": 24,
	           "window": 1,
	           "human": 1,
	           "door": 1,
	           "consumption": 12,
	           "total_consumption": 397,
	           "humidity": 80,
	           "alarm_time": 15901188989     
		   },
		   {
             "terminal_id": "T76E79218969EB72C92A949DD9A330113",
	           "terminal_name": "教务处",
             "device_id": 20,
	           "air_id": "A96E79218969EB72C92A949DD9A330113",
	           "air_name": "格力空调",		           
	           "building_id": "B96E79218969EB72C92A949DD9A330112",
	           "building_name": "教学楼一楼",
	           "dept_id": "D86E79218969EB72C92A949DD9A330116",
	           "dept_name": "教务处",	  	           
	           "run_mode": 1,
	           "running": 1,
	           "temp": 24,
	           "window": 1,
	           "human": 1,
	           "door": 1,
	           "consumption": 12,
	           "total_consumption": 397,
	           "humidity": 80,
	           "alarm_time": 15901188989   	   	   		      
		   }]
	 }
   } 
	      
## 14.状态管理 <a name="terminal_status_manage"/>  
### 14.1 在线终端 online <a name="online_terminal"/>
* 请求URL:http://${DOMAIN}/interface/terminal/online
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| terminal_id | string | 否 | 终端ID |
| terminal_name | string | 否 | 终端名称 |
| device_id | int | 否 | 设备ID |
| building_id | string | 否 | 建筑物 |
| building_name | string | 否 | 建筑物名称 |
| dept_id | string | 否 | 部门ID |
| dept_name | string | 否 | 部门名称 |
| page_number | int  | 是 |  页码  |
| page_size | int  | 是 |  每页记录条数 |

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |
| data |  json object  | 是 | 对象信息 |

* data字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| page_number | int  | 是 | 页码  |
| page_size | int  | 是 | 每页记录条数 |
| total_number |  int | 是 | 总记录条数  |
| list |  json array  | 是 | 对象数组 |

* list数组单个元素字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| terminal_id |  string  | 是 | 终端id |
| terminal_name | string | 是 | 终端名称 |
| device_id | int | 否 | 设备ID |
| building_id | string | 否 | 建筑物 |
| building_name | string | 否 | 建筑物名称 |
| dept_id | string | 否 | 部门ID |
| dept_name | string | 否 | 部门名称 |
| run_mode | int | 是 | 工作模式 |
| running | int | 是 | 是否运行 |
| temp | int | 是 | 温度 |
| window | int | 是 | 窗户开关 |
| human | int | 是 | 是否有人 |
| door | int | 是 | 门开关 |
| consumption | int | 是 | 能耗 |
| total_consumption | int | 是 | 总能耗 |
| humidity | int | 是 | 湿度 |
| status_time | int | 是 | 状态时间 |
| update_time | int | 是 | 更新时间 |
| create_time | int | 是 | 创建时间 |

  
* 请求示例
   >{
	   "terminal_id": "T96E79218969EB72C92A949DD9A330112",
	   "terminal_name": "财务室",
     "device_id": 20,
	   "building_id": "B96E79218969EB72C92A949DD9A330112",
	   "building_name": "教学楼一楼",
	   "dept_id": "D96E79218969EB72C92A949DD9A330112",
	   "dept_name": "财务室",
	   "page_number": 1,
	   "page_size": 10
	}

* 应答示例
  >{
	"msg": "",
	"code": 0,
	"data": {
		"page_number": 1,
	    "page_size": 10,
	    "total_number": 2,
	    "list":[
		   {
               "terminal_id": "T96E79218969EB72C92A949DD9A330112",
	           "terminal_name": "财务室",
             "device_id": 20,
	           "building_id": "B96E79218969EB72C92A949DD9A330112",
	           "building_name": "教学楼一楼",
	           "dept_id": "D96E79218969EB72C92A949DD9A330112",
	           "dept_name": "财务科",	  
	           "run_mode": 1,
	           "running": 1,
	           "temp": 24,
	           "window": 1,
	           "human": 1,
	           "door": 1,
	           "consumption": 12,
	           "total_consumption": 397,
	           "humidity": 80,
	           "status_time": 15901188989     
		   },
		   {
               "terminal_id": "T76E79218969EB72C92A949DD9A330113",
	           "terminal_name": "教务处",
             "device_id": 20,
	           "building_id": "B96E79218969EB72C92A949DD9A330112",
	           "building_name": "教学楼一楼",
	           "dept_id": "D86E79218969EB72C92A949DD9A330116",
	           "dept_name": "教务处",	  	           
	           "run_mode": 1,
	           "running": 1,
	           "temp": 24,
	           "window": 1,
	           "human": 1,
	           "door": 1,
	           "consumption": 12,
	           "total_consumption": 397,
	           "humidity": 80,
	           "status_time": 15901188989   	   	   		      
		   }]
	 }
   } 

### 14.2 离线终端 offline <a name="offline_terminal"/>
* 请求URL:http://${DOMAIN}/interface/terminal/offline
* 请求字段:
	        
| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| terminal_id | string | 否 | 终端ID |
| terminal_name | string | 否 | 终端名称 |
| device_id | int | 否 | 设备ID |
| building_id | string | 否 | 建筑物 |
| building_name | string | 否 | 建筑物名称 |
| dept_id | string | 否 | 部门ID |
| dept_name | string | 否 | 部门名称 |
| page_number | int  | 是 |  页码  |
| page_size | int  | 是 |  每页记录条数 |

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |
| data |  json object  | 是 | 对象信息 |

* data字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| page_number | int  | 是 | 页码  |
| page_size | int  | 是 | 每页记录条数 |
| total_number |  int | 是 | 总记录条数  |
| list |  json array  | 是 | 对象数组 |

* list数组单个元素字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| terminal_id |  string  | 是 | 终端id |
| terminal_name | string | 是 | 终端名称 |
| device_id | int | 否 | 设备ID |
| building_id | string | 否 | 建筑物 |
| building_name | string | 否 | 建筑物名称 |
| dept_id | string | 否 | 部门ID |
| dept_name | string | 否 | 部门名称 |
| run_mode | int | 是 | 工作模式 |
| running | int | 是 | 是否运行 |
| temp | int | 是 | 温度 |
| window | int | 是 | 窗户开关 |
| human | int | 是 | 是否有人 |
| door | int | 是 | 门开关 |
| consumption | int | 是 | 能耗 |
| total_consumption | int | 是 | 总能耗 |
| humidity | int | 是 | 湿度 |
| status_time | int | 是 | 状态时间 |
| update_time | int | 是 | 更新时间 |
| create_time | int | 是 | 创建时间 |

  
* 请求示例
   >{
	   "terminal_id": "T96E79218969EB72C92A949DD9A330112",
	   "terminal_name": "财务室",
     "device_id": 20,
	   "building_id": "B96E79218969EB72C92A949DD9A330112",
	   "building_name": "教学楼一楼",
	   "dept_id": "D96E79218969EB72C92A949DD9A330112",
	   "dept_name": "财务室",
	   "page_number": 1,
	   "page_size": 10
	}

* 应答示例
  >{
	"msg": "",
	"code": 0,
	"data": {
		"page_number": 1,
	    "page_size": 10,
	    "total_number": 2,
	    "list":[
		   {
               "terminal_id": "T96E79218969EB72C92A949DD9A330112",
	           "terminal_name": "财务室",
             "device_id": 20,
	           "building_id": "B96E79218969EB72C92A949DD9A330112",
	           "building_name": "教学楼一楼",
	           "dept_id": "D96E79218969EB72C92A949DD9A330112",
	           "dept_name": "财务科",	  
	           "run_mode": 1,
	           "running": 1,
	           "temp": 24,
	           "window": 1,
	           "human": 1,
	           "door": 1,
	           "consumption": 12,
	           "total_consumption": 397,
	           "humidity": 80,
	           "status_time": 15901188989     
		   },
		   {
               "terminal_id": "T76E79218969EB72C92A949DD9A330113",
	           "terminal_name": "教务处",
             "device_id": 20,
	           "building_id": "B96E79218969EB72C92A949DD9A330112",
	           "building_name": "教学楼一楼",
	           "dept_id": "D86E79218969EB72C92A949DD9A330116",
	           "dept_name": "教务处",	  	           
	           "run_mode": 1,
	           "running": 1,
	           "temp": 24,
	           "window": 1,
	           "human": 1,
	           "door": 1,
	           "consumption": 12,
	           "total_consumption": 397,
	           "humidity": 80,
	           "status_time": 15901188989   	   	   		      
		   }]
	 }
   } 
   
### 14.3 实时状态 real_status <a name="real_status_terminal"/>
* 请求URL:http://${DOMAIN}/interface/terminal/real_status
* 请求字段:
	        
| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| terminal_id | string | 否 | 终端ID |
| terminal_name | string | 否 | 终端名称 |
| device_id | int | 否 | 设备ID |
| building_id | string | 否 | 建筑物 |
| building_name | string | 否 | 建筑物名称 |
| dept_id | string | 否 | 部门ID |
| dept_name | string | 否 | 部门名称 |
| page_number | int  | 是 |  页码  |
| page_size | int  | 是 |  每页记录条数 |

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |
| data |  json object  | 是 | 对象信息 |

* data字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| page_number | int  | 是 | 页码  |
| page_size | int  | 是 | 每页记录条数 |
| total_number |  int | 是 | 总记录条数  |
| list |  json array  | 是 | 对象数组 |

* list数组单个元素字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| terminal_id |  string  | 是 | 终端id |
| terminal_name | string | 是 | 终端名称 |
| device_id | int | 否 | 设备ID |
| building_id | string | 否 | 建筑物 |
| building_name | string | 否 | 建筑物名称 |
| dept_id | string | 否 | 部门ID |
| dept_name | string | 否 | 部门名称 |
| run_mode | int | 是 | 工作模式 |
| running | int | 是 | 是否运行 |
| temp | int | 是 | 温度 |
| window | int | 是 | 窗户开关 |
| human | int | 是 | 是否有人 |
| door | int | 是 | 门开关 |
| consumption | int | 是 | 能耗 |
| total_consumption | int | 是 | 总能耗 |
| humidity | int | 是 | 湿度 |
| status_time | int | 是 | 状态时间 |
| update_time | int | 是 | 更新时间 |
| create_time | int | 是 | 创建时间 |

  
* 请求示例
   >{
	   "terminal_id": "T96E79218969EB72C92A949DD9A330112",
	   "terminal_name": "财务室",
     "device_id": 20,
	   "building_id": "B96E79218969EB72C92A949DD9A330112",
	   "building_name": "教学楼一楼",
	   "dept_id": "D96E79218969EB72C92A949DD9A330112",
	   "dept_name": "财务室",
	   "page_number": 1,
	   "page_size": 10
	}

* 应答示例
  >{
	"msg": "",
	"code": 0,
	"data": {
		"page_number": 1,
	    "page_size": 10,
	    "total_number": 2,
	    "list":[
		   {
               "terminal_id": "T96E79218969EB72C92A949DD9A330112",
	           "terminal_name": "财务室",
             "device_id": 20,
	           "building_id": "B96E79218969EB72C92A949DD9A330112",
	           "building_name": "教学楼一楼",
	           "dept_id": "D96E79218969EB72C92A949DD9A330112",
	           "dept_name": "财务科",	  
	           "run_mode": 1,
	           "running": 1,
	           "temp": 24,
	           "window": 1,
	           "human": 1,
	           "door": 1,
	           "consumption": 12,
	           "total_consumption": 397,
	           "humidity": 80,
	           "status_time": 15901188989     
		   },
		   {
               "terminal_id": "T76E79218969EB72C92A949DD9A330113",
	           "terminal_name": "教务处",
             "device_id": 20,
	           "building_id": "B96E79218969EB72C92A949DD9A330112",
	           "building_name": "教学楼一楼",
	           "dept_id": "D86E79218969EB72C92A949DD9A330116",
	           "dept_name": "教务处",	  	           
	           "run_mode": 1,
	           "running": 1,
	           "temp": 24,
	           "window": 1,
	           "human": 1,
	           "door": 1,
	           "consumption": 12,
	           "total_consumption": 397,
	           "humidity": 80,
	           "status_time": 15901188989   	   	   		      
		   }]
	 }
   }   
   
### 14.4 未注册终端 unregister <a name="unregister_terminal"/>
* 请求URL:http://${DOMAIN}/interface/terminal/unregister
* 请求字段:  

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| page_number | int  | 是 |  页码  |
| page_size | int  | 是 |  每页记录条数 |

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |
| data |  json object  | 是 | 对象信息 |

* data字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| page_number | int  | 是 | 页码  |
| page_size | int  | 是 | 每页记录条数 |
| total_number |  int | 是 | 总记录条数  |
| list |  json array  | 是 | 对象数组 |

* list数组单个元素字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| terminal_id |  string  | 是 | 终端id |
| terminal_name | string | 是 | 终端名称 |
| device_id | int | 是 | 设备ID |
| terminal_sn | string | 是 | 终端SN |
| terminal_version | string | 是 | 终端版本 |
| update_time | int | 是 | 更新时间 |
| create_time | int | 是 | 创建时间 |

* 请求示例
   >{
	   "page_number": 1,
	   "page_size": 10
	}

* 应答示例
  >{
	"msg": "",
	"code": 0,
	"data": {
		"page_number": 1,
	    "page_size": 10,
	    "total_number": 2,
	    "list":[
		   {
               "terminal_id": "T96E79218969EB72C92A949DD9A330112",
	           "terminal_name": "财务室",
	           "device_id": 1,
	           "terminal_sn": "D96E79218969EB72C92A949DD9A330112",
	           "terminal_version": "001",
	           "update_time": 15901188989,
	           "create_time": 15901188989  
		   },
		   {
               "terminal_id": "T76E79218969EB72C92A949DD9A330113",
	           "terminal_name": "教务处",
	           "device_id": 2,
	           "terminal_sn": "D96E79218969EB72C92A949DD9A330118",
	           "terminal_version": "001",
	           "update_time": 15901188989,
	           "create_time": 15901188989  	   	   		      
		   }]
	 }
   } 
   
### 14.5 状态分布 status_stat <a name="status_stat_terminal"/>
* 请求URL:http://${DOMAIN}/interface/terminal/status_stat
* 请求字段:  

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |
| data |  json object  | 是 | 对象信息 |

* data字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| running | int  | 是 | 开启数量  |
| close | int  | 是 | 关闭数量 |
| offline |  int | 是 | 离线数量  |


* 请求示例
   >{
	}

* 应答示例
  >{
	"msg": "",
	"code": 0,
	"data": {
		"running": 10,
	    "close": 10,
	    "offline": 4
	 }
   }    
   
### 14.6 设备注册 register <a name="register"/>
* 请求URL:http://${DOMAIN}/interface/terminal/register
* 请求字段: 


| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| terminal_id | string | 是 | 终端ID |
| terminal_name | string | 是 | 终端名称 |
| etc_id | string | 否 | 配置ID |
| rule_id | string | 否 | 规则ID |
| air_id | string | 否 | 空调ID |
| building_id | string | 是 | 建筑物ID |
| dept_id | string | 是 | 部门ID |
| air_buy_date | int | 是 | 购买日期 |
| description | string | 是 | 备注 |

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |


* 请求示例
   >{
       "terminal_id": "T00000000000000000000000000000000001",
	   "terminal_name": "财务科一室",
	   "etc_id": "E96E79218969EB72C92A949DD9A330113",
	   "rule_id": "R96E79218969EB72C92A949DD9A330113",
	   "air_id": "A96E79218969EB72C92A949DD9A330113",
	   "building_id": "B96E79218969EB72C92A949DD9A330113",
	   "dept_id": "D96E79218969EB72C92A949DD9A330113",
	   "air_buy_date": 1590688989,
	   "description": "财务科"
	}

* 应答示例
  >{
	  "msg": "",
	  "code": 0
	}   
   
## 15.能效管理 <a name="status_stat_manage"/>    
### 15.1 能效告警 alarm <a name="energy_alarm"/>
* 请求URL:http://${DOMAIN}/interface/energy/alarm
* 请求字段: 

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| terminal_id | string | 否 | 终端ID |
| terminal_name | string | 否 | 终端名称 |
| device_id | int | 否 | 设备ID |
| building_id | string | 否 | 建筑物 |
| building_name | string | 否 | 建筑物名称 |
| dept_id | string | 否 | 部门ID |
| dept_name | string | 否 | 部门名称 |
| page_number | int  | 是 |  页码  |
| page_size | int  | 是 |  每页记录条数 |

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |
| data |  json object  | 是 | 对象信息 |

* data字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| page_number | int  | 是 | 页码  |
| page_size | int  | 是 | 每页记录条数 |
| total_number |  int | 是 | 总记录条数  |
| list |  json array  | 是 | 对象数组 |

* list数组单个元素字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| terminal_id |  string  | 是 | 终端id |
| terminal_name | string | 是 | 终端名称 |
| device_id | int | 是 | 设备ID |
| terminal_sn | string | 是 | 终端SN |
| terminal_version | string | 是 | 终端版本 |
| running_time | int | 是 | 累计运行时间小时 |
| threshold_consumption | int | 是 | 单位小时能耗阈值 |
| hour_consumption | int | 是 | 单位小时能耗 |
| update_time | int | 是 | 更新时间 |
| create_time | int | 是 | 创建时间 |

* 请求示例
   >{
	   "terminal_id": "T96E79218969EB72C92A949DD9A330112",
	   "terminal_name": "财务室",
	   "device_id": 20,
	   "building_id": "B96E79218969EB72C92A949DD9A330112",
	   "building_name": "教学楼一楼",
	   "dept_id": "D96E79218969EB72C92A949DD9A330112",
	   "dept_name": "财务室",   
	   "page_number": 1,
	   "page_size": 10
	}

* 应答示例
  >{
	"msg": "",
	"code": 0,
	"data": {
		"page_number": 1,
	    "page_size": 10,
	    "total_number": 2,
	    "list":[
		   {
               "terminal_id": "T96E79218969EB72C92A949DD9A330112",
	           "terminal_name": "财务室",
	           "device_id": 1,
	           "terminal_sn": "D96E79218969EB72C92A949DD9A330112",
	           "terminal_version": "001",
	           "running_time": 3600,
	           "threshold_consumption": 1000,
	           "hour_consumption": 1500,
	           "update_time": 15901188989,
	           "create_time": 15901188989  
		   },
		   {
               "terminal_id": "T76E79218969EB72C92A949DD9A330113",
	           "terminal_name": "教务处",
	           "device_id": 2,
	           "terminal_sn": "D96E79218969EB72C92A949DD9A330118",
	           "terminal_version": "001",
	           "running_time": 3600,
	           "threshold_consumption": 1000,
	           "hour_consumption": 1500,	           
	           "update_time": 15901188989,
	           "create_time": 15901188989  	   	   		      
		   }]
	 }
   } 

### 15.2 能效查询 query_list <a name="energy_query_list"/>
* 请求URL:http://${DOMAIN}/interface/energy/query_list
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| terminal_id | string | 否 | 终端ID |
| terminal_name | string | 否 | 终端名称 |
| device_id | int | 否 | 设备ID |
| building_id | string | 否 | 建筑物 |
| building_name | string | 否 | 建筑物名称 |
| dept_id | string | 否 | 部门ID |
| dept_name | string | 否 | 部门名称 |
| page_number | int  | 是 |  页码  |
| page_size | int  | 是 |  每页记录条数 |

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |
| data |  json object  | 是 | 对象信息 |

* data字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| page_number | int  | 是 | 页码  |
| page_size | int  | 是 | 每页记录条数 |
| total_number |  int | 是 | 总记录条数  |
| list |  json array  | 是 | 对象数组 |

* list数组单个元素字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| terminal_id |  string  | 是 | 终端id |
| terminal_name | string | 是 | 终端名称 |
| device_id | int | 是 | 设备ID |
| terminal_sn | string | 是 | 终端SN |
| terminal_version | string | 是 | 终端版本 |
| running_time | int | 是 | 累计运行时间小时 |
| consumption | int | 是 | 一天能耗 |
| hour_consumption | int | 是 | 单位小时能耗 |
| total_consumption | int | 是 | 总能耗 |
| stat_time | int | 是 | 统计时间 |
| update_time | int | 是 | 更新时间 |
| create_time | int | 是 | 创建时间 |

* 请求示例
   >{
	   "terminal_id": "T96E79218969EB72C92A949DD9A330112",
	   "terminal_name": "财务室",
	   "device_id": 20,
	   "building_id": "B96E79218969EB72C92A949DD9A330112",
	   "building_name": "教学楼一楼",
	   "dept_id": "D96E79218969EB72C92A949DD9A330112",
	   "dept_name": "财务室",   
	   "page_number": 1,
	   "page_size": 10
	}

* 应答示例
  >{
	"msg": "",
	"code": 0,
	"data": {
		"page_number": 1,
	    "page_size": 10,
	    "total_number": 2,
	    "list":[
		   {
               "terminal_id": "T96E79218969EB72C92A949DD9A330112",
	           "terminal_name": "财务室",
	           "device_id": 1,
	           "terminal_sn": "D96E79218969EB72C92A949DD9A330112",
	           "terminal_version": "001",
	           "running_time": 3600,
	           "consumption": 1500,
	           "hour_consumption": 1500,
	           "total_consumption": 1500,
	           "update_time": 15901188989,
	           "create_time": 15901188989  
		   },
		   {
               "terminal_id": "T76E79218969EB72C92A949DD9A330113",
	           "terminal_name": "教务处",
	           "device_id": 2,
	           "terminal_sn": "D96E79218969EB72C92A949DD9A330118",
	           "terminal_version": "001",
	           "running_time": 3600,
	           "consumption": 1500,
	           "hour_consumption": 1500,
	           "total_consumption": 1500,	           
	           "update_time": 15901188989,
	           "create_time": 15901188989  	   	   		      
		   }]
	 }
   } 

### 15.3 能效排名 ranking <a name="energy_ranking"/>
* 请求URL:http://${DOMAIN}/interface/energy/ranking
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| building_id | string | 否 | 建筑物 |
| building_name | string | 否 | 建筑物名称 |
| dept_id | string | 否 | 部门ID |
| dept_name | string | 否 | 部门名称 |
| page_number | int  | 是 |  页码  |
| page_size | int  | 是 |  每页记录条数 |

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |
| data |  json object  | 是 | 对象信息 |

* data字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| page_number | int  | 是 | 页码  |
| page_size | int  | 是 | 每页记录条数 |
| total_number |  int | 是 | 总记录条数  |
| list |  json array  | 是 | 对象数组 |

* list数组单个元素字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| terminal_id |  string  | 是 | 终端id |
| terminal_name | string | 是 | 终端名称 |
| device_id | int | 是 | 设备ID |
| terminal_sn | string | 是 | 终端SN |
| terminal_version | string | 是 | 终端版本 |
| running_time | int | 是 | 累计运行时间 |
| consumption | int | 是 | 一天能耗 |
| hour_consumption | int | 是 | 单位小时能耗 |
| total_consumption | int | 是 | 总能耗 |
| score | int | 是 | 评分 |
| update_time | int | 是 | 更新时间 |
| create_time | int | 是 | 创建时间 |

* 请求示例
   >{
	   "building_id": "B96E79218969EB72C92A949DD9A330112",
	   "building_name": "教学楼一楼",
	   "dept_id": "D96E79218969EB72C92A949DD9A330112",
	   "dept_name": "财务室",   
	   "page_number": 1,
	   "page_size": 10
	}

* 应答示例
  >{
	"msg": "",
	"code": 0,
	"data": {
		"page_number": 1,
	    "page_size": 10,
	    "total_number": 2,
	    "list":[
		   {
               "terminal_id": "T96E79218969EB72C92A949DD9A330112",
	           "terminal_name": "财务室",
	           "device_id": 1,
	           "terminal_sn": "D96E79218969EB72C92A949DD9A330112",
	           "terminal_version": "001",
	           "running_time": 3600,
	           "consumption": 1500,
	           "hour_consumption": 1500,
	           "total_consumption": 1500,
	           "update_time": 15901188989,
	           "create_time": 15901188989  
		   },
		   {
               "terminal_id": "T76E79218969EB72C92A949DD9A330113",
	           "terminal_name": "教务处",
	           "device_id": 2,
	           "terminal_sn": "D96E79218969EB72C92A949DD9A330118",
	           "terminal_version": "001",
	           "running_time": 3600,
	           "consumption": 1500,
	           "hour_consumption": 1500,
	           "total_consumption": 1500,	           
	           "update_time": 15901188989,
	           "create_time": 15901188989  	   	   		      
		   }]
	 }
   } 
   
## 16.统计管理 <a name="status_stat_manage"/>
### 16.1 日统计 day_stat <a name="day_stat"/>
* 请求URL:http://${DOMAIN}/interface/stat/day_stat
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| terminal_id | string | 否 | 终端ID |
| terminal_name | string | 否 | 终端名称 |
| device_id | int | 否 | 设备ID |
| building_id | string | 否 | 建筑物 |
| building_name | string | 否 | 建筑物名称 |
| dept_id | string | 否 | 部门ID |
| dept_name | string | 否 | 部门名称 |
| begin_time | int | 是 | 统计开始时间 |
| end_time | int | 是 | 统计结束时间 |
| page_number | int  | 是 |  页码  |
| page_size | int  | 是 |  每页记录条数 |

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |
| data |  json object  | 是 | 对象信息 |

* data字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| page_number | int  | 是 | 页码  |
| page_size | int  | 是 | 每页记录条数 |
| total_number |  int | 是 | 总记录条数  |
| list |  json array  | 是 | 对象数组 |

* list数组单个元素字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| terminal_id |  string  | 是 | 终端id |
| terminal_name | string | 是 | 终端名称 |
| device_id | int | 是 | 设备ID |
| terminal_sn | string | 是 | 终端SN |
| terminal_version | string | 是 | 终端版本 |
| running_time | int | 是 | 累计运行时间小时 |
| hour_consumption | int | 是 | 单位小时能耗 |
| consumption | int | 是 | 一天能耗 |
| total_consumption | int | 是 | 总能耗 |
| detail | array(object) | 是 | 一天运行详情，半小时为一段 |
| date | int | 是 | 日期时间戳 |
| update_time | int | 是 | 更新时间 |
| create_time | int | 是 | 创建时间 |

* detail数组单个元素字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| rm | int | 是 | 空调运行模式 1 自动，2 手动 |
| ri | int | 是 | 空调运行标识 1 运行 2 停止 |
| tp | int | 是 | 平均温度 |
| wd | int | 是 | 窗户标识 1 开， 2 关 |
| hm | int | 是 | 人标识 1 有人， 2 无 |
| dr | int | 是 | 门标识 1 开， 2 关 |
| hd | int | 是 | 平均湿度 |
| cp | int | 是 | 半小时能耗 |
| ix | int | 是 | 时间序号：1 第一个半小时，2 第二个半小时，...... 48 第48个半小时 |

* 请求示例
   >{
	   "terminal_id": "T96E79218969EB72C92A949DD9A330112",
	   "terminal_name": "财务室",
	   "device_id": 20,
	   "building_id": "B96E79218969EB72C92A949DD9A330112",
	   "building_name": "教学楼一楼",
	   "dept_id": "D96E79218969EB72C92A949DD9A330112",
	   "dept_name": "财务室",  
	   "begin_time": 15000000000,
	   "end_time": 16000000000, 
	   "page_number": 1,
	   "page_size": 10
	}

* 应答示例
  >{
	"msg": "",
	"code": 0,
	"data": {
		"page_number": 1,
	    "page_size": 10,
	    "total_number": 2,
	    "list":[
		   {
               "terminal_id": "T96E79218969EB72C92A949DD9A330112",
	           "terminal_name": "财务室",
	           "device_id": 1,
	           "terminal_sn": "D96E79218969EB72C92A949DD9A330112",
	           "terminal_version": "001",
	           "running_time": 3600,
	           "consumption": 1500,
	           "hour_consumption": 1500,
	           "total_consumption": 20000,
	           "detail":[{
	                "rm": 0,
	                "ri": 1,
	                "tp": 26,
	                "wd": 1,
	                "hm": 1,
	                "dr": 0,
	                "hd": 70,
	                "cp": 100,
	                "ix": 1
	             },{
	                "rm": 0,
	                "ri": 1,
	                "tp": 26,
	                "wd": 1,
	                "hm": 1,
	                "dr": 0,
	                "hd": 70,
	                "cp": 100,
	                "ix": 2	             
	             }
	           ],
	           "date": 14966880000,
	           "update_time": 15901188989,
	           "create_time": 15901188989  
		   },
		   {
               "terminal_id": "T76E79218969EB72C92A949DD9A330113",
	           "terminal_name": "教务处",
	           "device_id": 2,
	           "terminal_sn": "D96E79218969EB72C92A949DD9A330118",
	           "terminal_version": "001",
	           "running_time": 3600,
	           "consumption": 1500,
	           "hour_consumption": 1500,	     
	           "total_consumption": 20000,
	           "detail":[{
	                "rm": 0,
	                "ri": 1,
	                "tp": 26,
	                "wd": 1,
	                "hm": 1,
	                "dr": 0,
	                "hd": 70,
	                "cp": 100,
	                "ix": 1
	             },{
	                "rm": 0,
	                "ri": 1,
	                "tp": 26,
	                "wd": 1,
	                "hm": 1,
	                "dr": 0,
	                "hd": 70,
	                "cp": 100,
	                "ix": 2	             
	             }
	           ],
	           "date": 14966880000,	                 
	           "update_time": 15901188989,
	           "create_time": 15901188989  	   	   		      
		   }]
	 }
   }

### 16.2 建筑统计 building_day_stat <a name="building_day_stat"/>
* 请求URL:http://${DOMAIN}/interface/stat/building_day_stat
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| building_id | string | 否 | 建筑物 |
| building_name | string | 否 | 建筑物名称 |
| begin_time | int | 是 | 统计开始时间 |
| end_time | int | 是 | 统计结束时间 |
| page_number | int  | 是 |  页码  |
| page_size | int  | 是 |  每页记录条数 |

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |
| data |  json object  | 是 | 对象信息 |

* data字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| page_number | int  | 是 | 页码  |
| page_size | int  | 是 | 每页记录条数 |
| total_number |  int | 是 | 总记录条数  |
| list |  json array  | 是 | 对象数组 |

* list数组单个元素字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| building_id |  string  | 是 | 建筑id |
| building_name | string | 是 | 建筑名称 |
| running_time | int | 是 | 累计运行时间小时 |
| hour_consumption | int | 是 | 单位小时能耗 |
| consumption | int | 是 | 一天能耗 |
| total_consumption | int | 是 | 总能耗 |
| date | int | 是 | 日期时间戳 |
| update_time | int | 是 | 更新时间 |
| create_time | int | 是 | 创建时间 |

* 请求示例
   >{
	   "building_id": "B96E79218969EB72C92A949DD9A330112",
	   "building_name": "教学楼一楼",
	   "begin_time": 15000000000,
	   "end_time": 16000000000, 
	   "page_number": 1,
	   "page_size": 10
	}

* 应答示例
  >{
	"msg": "",
	"code": 0,
	"data": {
		"page_number": 1,
	    "page_size": 10,
	    "total_number": 2,
	    "list":[
		   {
	           "building_id": "B96E79218969EB72C92A949DD9A330112",
	           "building_name": "教学楼一楼",
	           "running_time": 3600,
	           "consumption": 1500,
	           "hour_consumption": 1500,
	           "total_consumption": 20000,
	           "date": 14966880000,
	           "update_time": 15901188989,
	           "create_time": 15901188989  
		   },
		   {
               "building_id": "B76E79218969EB72C92A949DD9A330113",
	           "building_name": "教学楼二楼",
	           "running_time": 3600,
	           "consumption": 1500,
	           "hour_consumption": 1500,	     
	           "total_consumption": 20000,
	           "date": 14966880000,	                 
	           "update_time": 15901188989,
	           "create_time": 15901188989  	   	   		      
		   }]
	 }
   }
   
### 16.3 部门统计 dept_day_stat <a name="dept_day_stat"/>
* 请求URL:http://${DOMAIN}/interface/stat/dept_day_stat
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| dept_id | string | 否 | 部门ID |
| dept_name | string | 否 | 部门名称 |
| begin_time | int | 是 | 统计开始时间 |
| end_time | int | 是 | 统计结束时间 |
| page_number | int  | 是 |  页码  |
| page_size | int  | 是 |  每页记录条数 |

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |
| data |  json object  | 是 | 对象信息 |

* data字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| page_number | int  | 是 | 页码  |
| page_size | int  | 是 | 每页记录条数 |
| total_number |  int | 是 | 总记录条数  |
| list |  json array  | 是 | 对象数组 |

* list数组单个元素字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| dept_id |  string  | 是 | 部门id |
| dept_name | string | 是 | 部门名称 |
| running_time | int | 是 | 累计运行时间小时 |
| hour_consumption | int | 是 | 单位小时能耗 |
| consumption | int | 是 | 一天能耗 |
| total_consumption | int | 是 | 总能耗 |
| date | int | 是 | 日期时间戳 |
| update_time | int | 是 | 更新时间 |
| create_time | int | 是 | 创建时间 |

* 请求示例
   >{
	   "dept_id": "D96E79218969EB72C92A949DD9A330112",
	   "dept_name": "财务科",
	   "begin_time": 15000000000,
	   "end_time": 16000000000, 
	   "page_number": 1,
	   "page_size": 10
	}

* 应答示例
  >{
	"msg": "",
	"code": 0,
	"data": {
		"page_number": 1,
	    "page_size": 10,
	    "total_number": 2,
	    "list":[
		   {
               "dept_id": "D96E79218969EB72C92A949DD9A330112",
	           "dept_name": "财务室",
	           "running_time": 3600,
	           "consumption": 1500,
	           "hour_consumption": 1500,
	           "total_consumption": 20000,
	           "date": 14966880000,
	           "update_time": 15901188989,
	           "create_time": 15901188989  
		   },
		   {
               "dept_id": "D76E79218969EB72C92A949DD9A330113",
	           "dept_name": "教务处",
	           "running_time": 3600,
	           "consumption": 1500,
	           "hour_consumption": 1500,	     
	           "total_consumption": 20000,
	           "date": 14966880000,	                 
	           "update_time": 15901188989,
	           "create_time": 15901188989  	   	   		      
		   }]
	 }
   }
   
### 16.4 部门平均能耗 dept_mean_consumption <a name="dept_mean_consumption"/>
* 请求URL:http://${DOMAIN}/interface/stat/dept_mean_consumption
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| begin_time | int | 是 | 统计开始时间 |
| end_time | int | 是 | 统计结束时间 |
| dept_id | int | 是 | 部门ID |
| dept_name | string | 是 | 部门名称 |


* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |
| data |  json object  | 是 | 对象信息 |

* data字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| running | int | 是 | 开启数量 |
| running_time | int | 是 | 累计运行时间小时 |
| hour_consumption | int | 是 | 单位小时能耗 |
| consumption | int | 是 | 一天能耗 |
| total_consumption | int | 是 | 总能耗 |
| begin_time | int | 是 | 统计开始时间 |
| end_time | int | 是 | 统计结束时间 |

* 请求示例
   >{
	   "begin_time": 15000000000,
	   "end_time": 16000000000
	}

* 应答示例
  >{
	"msg": "",
	"code": 0,
	"data": {
		"running": 10,
	    "running_time": 100000,
	    "hour_consumption": 200,
	    "consumption": 20000,
	    "total_consumption": 300000,
	    "begin_time": 15901188989,
	    "end_time": 15901188989	    
	 }
   }   
   
### 16.5 建筑平均能耗 building_mean_consumption <a name="building_mean_consumption"/>
* 请求URL:http://${DOMAIN}/interface/stat/building_mean_consumption
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| begin_time | int | 是 | 统计开始时间 |
| end_time | int | 是 | 统计结束时间 |
| building_id | int | 是 | 建筑ID |
| building_name | string | 是 | 建筑名称 |


* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |
| data |  json object  | 是 | 对象信息 |

* data字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| running | int | 是 | 开启数量 |
| running_time | int | 是 | 累计运行时间小时 |
| hour_consumption | int | 是 | 单位小时能耗 |
| consumption | int | 是 | 一天能耗 |
| total_consumption | int | 是 | 总能耗 |
| begin_time | int | 是 | 统计开始时间 |
| end_time | int | 是 | 统计结束时间 |

* 请求示例
   >{
	   "begin_time": 15000000000,
	   "end_time": 16000000000
	}

* 应答示例
  >{
	"msg": "",
	"code": 0,
	"data": {
		"running": 10,
	    "running_time": 100000,
	    "hour_consumption": 200,
	    "consumption": 20000,
	    "total_consumption": 300000,
	    "begin_time": 15901188989,
	    "end_time": 15901188989	    
	 }
   }   
   
### 16.6 总能耗 total_consumption <a name="total_consumption"/>
* 请求URL:http://${DOMAIN}/interface/stat/total_consumption
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |


* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |
| data |  json object  | 是 | 对象信息 |

* data字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| total_consumption | int | 是 | 总能耗 |

* 请求示例
   >{
	}

* 应答示例
  >{
	"msg": "",
	"code": 0,
	"data": {
	    "total_consumption": 300000
	 }
   }    


### 16.7 状态统计 status_stat <a name="status_stat"/>        
* 请求URL:http://${DOMAIN}/interface/stat/status_stat
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |


* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |
| data |  json object  | 是 | 对象信息 |

* data字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| close | int | 是 | 关闭数量 |
| running | int | 是 | 运行数量 |
| offline | int | 是 | 离线数量 |
| online | int | 是 | 在线数量 |

* 请求示例
   >{
  }

* 应答示例
  >{
  "msg": "",
  "code": 0,
  "data":
      {"close":497,"running":27,"offline":470,"online":81}
   }    

## 17.系统参数管理 <a name="system_param_manage"/>
### 17.1 系统参数增加 add <a name="system_param_add"/>
* 请求URL:http://${DOMAIN}/interface/system_param/add
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| platform_domain | string | 是 | 平台域名 |
| ip | string | 是 | ip地址 |
| back_ip | string | 是 | 备份ip地址 |
| port | int | 是 | 服务器端口 |
| ssid | string | 否 | WIFI SSID |
| ssid_password | string | 否 | WIFI 密码 |
| status_interval | int | 是 | 终端发送状态间隔 |
| description | string | 是 | 备注 |

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |

* 请求示例
   >{
	   "platform_domain": "www.system.com",
	   "ip": "127.0.0.1",
	   "back_ip": "127.0.0.1",
	   "port": 10000,
	   "ssid": "WIFI",
	   "ssid_password": "123456",
	   "status_interval": 60,
	   "description": "智能系统参数"
	}

* 应答示例
  >{
	  "msg": "",
	  "code": 0
	}
	
### 17.2 系统参数修改 update <a name="system_param_update"/>
* 请求URL:http://${DOMAIN}/interface/system_param/update
* 请求字段:

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| platform_domain | string | 否 | 平台域名 |
| ip | string | 否 | ip地址 |
| back_ip | string | 否 | 备份ip地址 |
| port | int | 否 | 服务器端口 |
| ssid | string | 否 | WIFI SSID |
| ssid_password | string | 否 | WIFI 密码 |
| status_interval | int | 否 | 终端发送状态间隔 |
| description | string | 否 | 备注 |


* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |


* 请求示例
   >{
	   "platform_domain": "www.system.com",
	   "ip": "127.0.0.1",
	   "back_ip": "127.0.0.1",
	   "port": 10000,
	   "ssid": "WIFI",
	   "ssid_password": "123456",
	   "status_interval": 60,
	   "description": "智能系统参数"
	}

* 应答示例
  >{
	   "msg": "",
	   "code": 0
   }

### 17.3 系统参数删除 delete <a name="system_param_delete"/>
* 请求URL:http://${DOMAIN}/interface/system_param/delete
* 请求字段:无

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |


* 请求示例
   >{
	}

* 应答示例
  >{
	   "msg": "",
	   "code": 0
   } 
   
### 17.4 系统参数查询 query <a name="system_param_query"/>
* 请求URL:http://${DOMAIN}/interface/system_param/query
* 请求字段:无

* 应答字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| code |  int  | 是 | 状态码 |
| msg |  string  | 否 | 失败时的提示信息 |
| data |  json object  | 是 | 对象 |

* 应答data字段

| 名称  | 类型 | 必填 | 描述 |
| :--------| ----:| ----:| :--- |
| platform_domain | string | 是 | 平台域名 |
| ip | string | 是 | ip地址 |
| back_ip | string | 是 | 备份ip地址 |
| port | int | 是 | 服务器端口 |
| ssid | string | 是 | WIFI SSID |
| ssid_password | string | 是 | WIFI 密码 |
| status_interval | int | 是 | 终端发送状态间隔 |
| description | string | 是 | 备注 |
| update_time | int | 是 | 更新时间 |
| create_time | int | 是 | 创建时间 |

* 请求示例
   >{
	}

* 应答示例
  >{
	  "msg": "",
	  "code": 0,
	  "data": {
	      "platform_domain": "www.system.com",
	      "ip": "127.0.0.1",
	      "back_ip": "127.0.0.1",
	      "port": 10000,
	      "ssid": "WIFI",
	      "ssid_password": "123456",
	      "status_interval": 60,
	      "description": "智能系统参数"
	      "create_time": 15901688989,
	      "update_time": 15901688989
	  }
    }
      	                      
## 18.状态码 <a name="status_code"/> 

| 值  | 描述 |
| :--------| ----:|
| -100100 |  用户输入错误  |
| -100200 |  用户输入逻辑错误  |
| -100300 |  服务后台错误  |
| -100301 |  系统错误  |
| -100400 |  数据库读写错误  |
| -100401 |  数据库逻辑错误  |
| -100500 |  认证失败  |
| -100600 |  系统繁忙  |

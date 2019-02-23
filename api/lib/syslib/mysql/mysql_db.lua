local mysql = require "mysql"

local business = {}

function business:initial(host, port, database, user, password)
  local db, err = mysql:new()
  if not db then
      ngx.log(ngx.ERR, "failed to instantiate mysql:" .. err .. " host:" ..
        host .. " port:" .. port .. " database:" .. database .. 
        " user:" .. user .. " password:" .. password)
      return false
  end

  ngx.log(ngx.DEBUG, "create mysql instance success ...") 

  local ok, err, errcode, sqlstate = db:connect({
        host = host,
        port = port,
        database = database,
        user = user,
        password = password})

  if not ok then
    ngx.log(ngx.ERR, "failed to instantiate mysql:" .. err .. " host:" ..
            host .. " port:" .. port .. " database:" .. database .. 
            " user:" .. user .. " password:" .. password)
    return false
  end  

  ngx.log(ngx.DEBUG, "connect to mysql service success ...") 

  -- put it into the connection pool of size 10,
  -- with 10 seconds max idle timeout

  local ok, err = db:set_keepalive(10000, 10)
  if not ok then
    ngx.log(ngx.ERR, "failed to set keepalive: " .. err)
    return false
  end

  ngx.log(ngx.DEBUG, "set mysql connect pool success ...") 

  return true
end

function business:execute(host, port, database, user, password, sql)
  local db, err = mysql:new()
  if not db then
      ngx.log(ngx.ERR, "failed to instantiate mysql:" .. err .. " host:" ..
        host .. " port:" .. port .. " database:" .. database .. 
        " user:" .. user .. " password:" .. password)
      return false
  end

  ngx.log(ngx.DEBUG, "create mysql instance success ...") 

  local ok, err, errcode, sqlstate = db:connect({
        host = host,
        port = port,
        database = database,
        user = user,
        password = password})

  if not ok then
    ngx.log(ngx.ERR, "failed to instantiate mysql:" .. err .. " host:" ..
            host .. " port:" .. port .. " database:" .. database .. 
            " user:" .. user .. " password:" .. password)
    return false
  end  

  ngx.log(ngx.DEBUG, "connect to mysql service success ...") 

  local res, err, errcode, sqlstate = db:query(sql)
  if not res then
    ngx.log(ngx.ERR, "execute sql: " .. sql .. "failed err msg: " .. err .. " err code:" .. errcode .. " err:" .. sqlstate)
    return false
  end

  local ok, err = db:close()
  if not ok then
    ngx.log(ngx.ERR, "failed to close: " .. err)
    return
  end  

  return true
end

function business:query(host, port, database, user, password, sql)
  local db, err = mysql:new()
  if not db then
      ngx.log(ngx.ERR, "failed to instantiate mysql:" .. err .. " host:" ..
        host .. " port:" .. port .. " database:" .. database .. 
        " user:" .. user .. " password:" .. password)
      return false
  end

  ngx.log(ngx.DEBUG, "create mysql instance success ...") 

  local ok, err, errcode, sqlstate = db:connect({
        host = host,
        port = port,
        database = database,
        user = user,
        password = password})

  if not ok then
    ngx.log(ngx.ERR, "failed to instantiate mysql:" .. err .. " host:" ..
            host .. " port:" .. port .. " database:" .. database .. 
            " user:" .. user .. " password:" .. password)
    return false
  end  

  ngx.log(ngx.DEBUG, "connect to mysql service success ...") 

  -- put it into the connection pool of size 10,
  -- with 10 seconds max idle timeout

  -- local ok, err = db:set_keepalive(10000, 10)
  -- if not ok then
  --   ngx.log(ngx.ERR, "failed to set keepalive: " .. err)
  --   return false
  -- end

  -- ngx.log(ngx.DEBUG, "set mysql connect pool success ...") 

  local res, err, errcode, sqlstate = db:query(sql)
  if not res then
    ngx.log(ngx.ERR, "query sql: " .. sql .. " failed err msg: " .. sqlstate .. " err:" .. err .. " errcode:" .. errcode)
    return false
  end

  local ok, err = db:close()
  if not ok then
    ngx.log(ngx.ERR, "failed to close: " .. err)
    return
  end  

  local cjson = require "cjson"

  ngx.log(ngx.DEBUG, "query sql:" .. sql .. " result:" .. cjson.encode(res) .. "")

  return true, res
end

function business:close()
  local ok, err = business.db:close()
  if not ok then
    ngx.log(ngx.ERR, "failed to close: " .. err)
    return
  end

  
end

return business
function IntToIPString(n)
    return string.format("%d.%d.%d.%d",
        (n >> 24) & 255,
        (n >> 16) & 255,
        (n >> 8) & 255,
        (n >> 0) & 255)
end

function OnHttpRequest()
    local path = GetPath()
    if path == "/ip" then
        Route(GetHost(), "/ip.lua")
    elseif path == "/summary" then
        Route(GetHost(), "/summary.lua")
    elseif path == "/claim" then
        Route(GetHost(), "/claim.lua")
    else
        Route()
    end
end

function Setup()
    local sqlite3 = require "lsqlite3"
    local db = sqlite3.open("db.sqlite3", sqlite3.OPEN_CREATE)
    db:exec[[
        CREATE TABLE "land" (
            ip INTEGER PRIMARY KEY,
            nick TEXT NOT NULL CHECK (length(nick) = 8),
            created_at TEXT DEFAULT (STRFTIME('%Y-%m-%d %H:%M:%f', 'NOW'))
        );
    ]]
end

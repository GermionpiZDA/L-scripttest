-- main.lua
-- Загрузчик для меню GermionpiZDA

local success, err = pcall(function()
    local MenuScript = game:HttpGet("https://raw.githubusercontent.com/GermionpiZDA/L-scripttest/refs/heads/main/scripttest/menu.lua")
    loadstring(MenuScript)()
end)

if not success then
    warn("❌ Ошибка загрузки меню: " .. err)
else
    print("✅ Меню успешно загружено!")
end
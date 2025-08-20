-- menu.lua
-- Основной скрипт меню для GermionpiZDA

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- Конфигурация
local TOGGLE_KEY = Enum.KeyCode.L
local IMAGE_URL = "https://raw.githubusercontent.com/GermionpiZDA/L-scripttest/refs/heads/main/scripttest/images/background.jpg"

-- Переменные
local menuOpen = false
local mainFrame = nil
local connection = nil

-- Создание интерфейса
function CreateMenu()
    -- Экранная гуи
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "GermionpiMenu"
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.ResetOnSpawn = false
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Основной фрейм
    mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 400, 0, 500)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.BorderSizePixel = 0
    mainFrame.Visible = false
    mainFrame.Parent = screenGui

    -- Скругление углов
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = mainFrame

    -- Тень/обводка
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(80, 80, 80)
    stroke.Thickness = 2
    stroke.Parent = mainFrame

    -- Заголовок
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    title.Text = "🎮 МЕНЮ GermionpiZDA 🎮"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 18
    title.Font = Enum.Font.GothamBold
    title.BorderSizePixel = 0
    title.Parent = mainFrame

    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 8)
    titleCorner.Parent = title

    -- Контейнер для изображения
    local imageContainer = Instance.new("Frame")
    imageContainer.Size = UDim2.new(1, -20, 0, 200)
    imageContainer.Position = UDim2.new(0, 10, 0, 50)
    imageContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    imageContainer.BorderSizePixel = 0
    imageContainer.Parent = mainFrame

    local imageCorner = Instance.new("UICorner")
    imageCorner.CornerRadius = UDim.new(0, 6)
    imageCorner.Parent = imageContainer

    -- Загрузка изображения
    local success, image = pcall(function()
        local imageLabel = Instance.new("ImageLabel")
        imageLabel.Size = UDim2.new(1, 0, 1, 0)
        imageLabel.Position = UDim2.new(0, 0, 0, 0)
        imageLabel.BackgroundTransparency = 1
        imageLabel.Image = IMAGE_URL
        imageLabel.ScaleType = Enum.ScaleType.Crop
        imageLabel.Parent = imageContainer
        return imageLabel
    end)

    if not success then
        local errorLabel = Instance.new("TextLabel")
        errorLabel.Size = UDim2.new(1, 0, 1, 0)
        errorLabel.Text = "❌ Ошибка загрузки изображения"
        errorLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        errorLabel.BackgroundTransparency = 1
        errorLabel.Parent = imageContainer
    end

    -- Контейнер для кнопок
    local buttonsFrame = Instance.new("Frame")
    buttonsFrame.Size = UDim2.new(1, -20, 0, 200)
    buttonsFrame.Position = UDim2.new(0, 10, 0, 260)
    buttonsFrame.BackgroundTransparency = 1
    buttonsFrame.Parent = mainFrame

    -- Пример кнопок
    local buttons = {
        {"🔧 Настройки", function() print("Настройки открыты!") end},
        {"⚡ Фарм", function() print("Фарм запущен!") end},
        {"🎯 Аим", function() print("Аим активирован!") end},
        {"🔄 Обновить", function() 
            print("Меню обновляется...")
            DestroyMenu()
            wait(0.5)
            CreateMenu()
            mainFrame.Visible = true
        end},
        {"🚫 Закрыть", function() ToggleMenu() end}
    }

    for i, buttonData in ipairs(buttons) do
        local buttonName, buttonFunc = buttonData[1], buttonData[2]
        
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, 0, 0, 40)
        button.Position = UDim2.new(0, 0, 0, (i-1) * 45)
        button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        button.Text = buttonName
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.TextSize = 14
        button.Font = Enum.Font.Gotham
        button.BorderSizePixel = 0
        button.Parent = buttonsFrame

        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 6)
        buttonCorner.Parent = button

        -- Анимация наведения
        button.MouseEnter:Connect(function()
            game:GetService("TweenService"):Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(70, 70, 70)}):Play()
        end)

        button.MouseLeave:Connect(function()
            game:GetService("TweenService"):Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
        end)

        button.MouseButton1Click:Connect(buttonFunc)
    end

    return screenGui
end

-- Функция переключения меню
function ToggleMenu()
    menuOpen = not menuOpen
    
    if menuOpen then
        if not mainFrame then
            CreateMenu()
        end
        
        mainFrame.Visible = true
        mainFrame.Size = UDim2.new(0, 0, 0, 0)
        
        local tween = TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 400, 0, 500)
        })
        tween:Play()
    else
        if mainFrame then
            local tween = TweenService:Create(mainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                Size = UDim2.new(0, 0, 0, 0)
            })
            
            tween.Completed:Connect(function()
                if mainFrame then
                    mainFrame.Visible = false
                end
            end)
            tween:Play()
        end
    end
end

-- Обработчик нажатия клавиши
function OnInput(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == TOGGLE_KEY and input.UserInputType == Enum.UserInputType.Keyboard then
        ToggleMenu()
    end
end

-- Инициализация
connection = UserInputService.InputBegan:Connect(OnInput)

-- Сообщение об успешной загрузке
print("🔓 Меню GermionpiZDA загружено! Нажмите L для открытия")

-- Функция для удаления меню
function DestroyMenu()
    if connection then
        connection:Disconnect()
    end
    if mainFrame and mainFrame.Parent then
        mainFrame.Parent:Destroy()
    end
    menuOpen = false
    mainFrame = nil
end

return {
    ToggleMenu = ToggleMenu,
    DestroyMenu = DestroyMenu

}


return function()
    -- Roblox GUI Menu by L
    -- Чистое меню без функционала

    local Players = game:GetService("Players")
    local CoreGui = game:GetService("CoreGui")
    local TweenService = game:GetService("TweenService")
    local UserInputService = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")

    local player = Players.LocalPlayer
    local mouse = player:GetMouse()

    -- Анти-детект функции
    local function safeCreate(instanceType, properties)
        local success, result = pcall(function()
            local instance = Instance.new(instanceType)
            for property, value in pairs(properties) do
                pcall(function()
                    instance[property] = value
                end)
            end
            return instance
        end)
        return success and result or nil
    end

    -- Создание основного контейнера
    local ScreenGui = safeCreate("ScreenGui", {
        Name = "LMenuGui_" .. tostring(math.random(10000, 99999)),
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder = 10
    })

    if ScreenGui then
        ScreenGui.Parent = CoreGui
    else
        return
    end

    -- Функция для создания закругленных углов
    local function createRoundedCorner(radius)
        local corner = safeCreate("UICorner", {
            CornerRadius = UDim.new(0, radius)
        })
        return corner
    end

    -- Функция для создания обводки
    local function createStroke(thickness, color, transparency)
        local stroke = safeCreate("UIStroke", {
            Thickness = thickness,
            Color = color,
            Transparency = transparency or 0,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        })
        return stroke
    end

    -- Создание кнопки меню
    local menuButton = safeCreate("TextButton", {
        Name = "LMenuButton",
        Size = UDim2.new(0, 40, 0, 40),
        Position = UDim2.new(1, -50, 0.5, -20),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        Text = "L",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 20,
        Font = Enum.Font.GothamBold,
        AutoButtonColor = false,
        Active = true,
        Draggable = false,
        Selectable = true,
        ZIndex = 10
    })

    if menuButton then
        menuButton.Parent = ScreenGui
        
        createRoundedCorner(8).Parent = menuButton
        createStroke(1, Color3.fromRGB(255, 255, 255)).Parent = menuButton
        
        menuButton.MouseEnter:Connect(function()
            local tween = TweenService:Create(
                menuButton,
                TweenInfo.new(0.2),
                {BackgroundColor3 = Color3.fromRGB(20, 20, 20)}
            )
            tween:Play()
        end)
        
        menuButton.MouseLeave:Connect(function()
            local tween = TweenService:Create(
                menuButton,
                TweenInfo.new(0.2),
                {BackgroundColor3 = Color3.fromRGB(0, 0, 0)}
            )
            tween:Play()
        end)
    end

    -- Создание меню
    local menuFrame = safeCreate("Frame", {
        Name = "LMenuFrame",
        Size = UDim2.new(0, 500, 0, 350),
        Position = UDim2.new(0.5, -250, 0.5, -175),
        BackgroundColor3 = Color3.fromRGB(15, 15, 15),
        Visible = false,
        ZIndex = 5,
        ClipsDescendants = true
    })

    if menuFrame then
        menuFrame.Parent = ScreenGui
        
        createRoundedCorner(6).Parent = menuFrame
        createStroke(1, Color3.fromRGB(50, 50, 50)).Parent = menuFrame
        
        -- Верхняя панель
        local topBar = safeCreate("Frame", {
            Name = "TopBar",
            Size = UDim2.new(1, 0, 0, 30),
            Position = UDim2.new(0, 0, 0, 0),
            BackgroundColor3 = Color3.fromRGB(25, 25, 25),
            BorderSizePixel = 0,
            ZIndex = 6
        })
        
        if topBar then
            topBar.Parent = menuFrame
            createRoundedCorner(6).Parent = topBar
            
            local title = safeCreate("TextLabel", {
                Name = "Title",
                Size = UDim2.new(0, 200, 1, 0),
                Position = UDim2.new(0, 10, 0, 0),
                BackgroundTransparency = 1,
                Text = "Elysium PROJECT",
                TextColor3 = Color3.fromRGB(220, 220, 220),
                TextSize = 14,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 7
            })
            
            if title then
                title.Parent = topBar
            end
            
            local keyTime = safeCreate("TextLabel", {
                Name = "KeyTime",
                Size = UDim2.new(0, 150, 1, 0),
                Position = UDim2.new(1, -180, 0, 0),
                BackgroundTransparency = 1,
                Text = "Key Time: 00:00:00",
                TextColor3 = Color3.fromRGB(180, 180, 180),
                TextSize = 12,
                Font = Enum.Font.Gotham,
                TextXAlignment = Enum.TextXAlignment.Right,
                ZIndex = 7
            })
            
            if keyTime then
                keyTime.Parent = topBar
                
                local startTime = os.time()
                local timeConnection
                timeConnection = RunService.Heartbeat:Connect(function()
                    if menuFrame and menuFrame.Parent then
                        local elapsed = os.time() - startTime
                        local hours = math.floor(elapsed / 3600)
                        local minutes = math.floor((elapsed % 3600) / 60)
                        local seconds = elapsed % 60
                        keyTime.Text = string.format("Key Time: %02d:%02d:%02d", hours, minutes, seconds)
                    else
                        timeConnection:Disconnect()
                    end
                end)
            end
        end
        
        local separator = safeCreate("Frame", {
            Name = "Separator",
            Size = UDim2.new(1, 0, 0, 1),
            Position = UDim2.new(0, 0, 0, 30),
            BackgroundColor3 = Color3.fromRGB(50, 50, 50),
            BorderSizePixel = 0,
            ZIndex = 6
        })
        
        if separator then
            separator.Parent = menuFrame
        end
        
        local bottomBar = safeCreate("Frame", {
            Name = "BottomBar",
            Size = UDim2.new(1, 0, 0, 20),
            Position = UDim2.new(0, 0, 1, -20),
            BackgroundColor3 = Color3.fromRGB(25, 25, 25),
            BorderSizePixel = 0,
            ZIndex = 6
        })
        
        if bottomBar then
            bottomBar.Parent = menuFrame
            createRoundedCorner(6).Parent = bottomBar
            
            local status = safeCreate("TextLabel", {
                Name = "Status",
                Size = UDim2.new(0, 100, 1, 0),
                Position = UDim2.new(0, 10, 0, 0),
                BackgroundTransparency = 1,
                Text = "Ready",
                TextColor3 = Color3.fromRGB(100, 200, 100),
                TextSize = 12,
                Font = Enum.Font.Gotham,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 7
            })
            
            if status then
                status.Parent = bottomBar
            end
        end
        
        local tabsContainer = safeCreate("Frame", {
            Name = "TabsContainer",
            Size = UDim2.new(0, 100, 1, -55),
            Position = UDim2.new(0, 10, 0, 35),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ZIndex = 6
        })
        
        if tabsContainer then
            tabsContainer.Parent = menuFrame
            
            local uiListLayout = safeCreate("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 5)
            })
            
            if uiListLayout then
                uiListLayout.Parent = tabsContainer
            end
        end
        
        local tabSeparator = safeCreate("Frame", {
            Name = "TabSeparator",
            Size = UDim2.new(0, 1, 1, -55),
            Position = UDim2.new(0, 115, 0, 35),
            BackgroundColor3 = Color3.fromRGB(50, 50, 50),
            BorderSizePixel = 0,
            ZIndex = 6
        })
        
        if tabSeparator then
            tabSeparator.Parent = menuFrame
        end
        
        local contentContainer = safeCreate("Frame", {
            Name = "ContentContainer",
            Size = UDim2.new(1, -130, 1, -55),
            Position = UDim2.new(0, 125, 0, 35),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ZIndex = 6
        })
        
        if contentContainer then
            contentContainer.Parent = menuFrame
        end
        
        local closeButton = safeCreate("TextButton", {
            Name = "CloseButton",
            Size = UDim2.new(0, 20, 0, 20),
            Position = UDim2.new(1, -25, 0, 5),
            BackgroundColor3 = Color3.fromRGB(40, 40, 40),
            Text = "×",
            TextColor3 = Color3.fromRGB(200, 200, 200),
            TextSize = 16,
            Font = Enum.Font.GothamBold,
            AutoButtonColor = false,
            ZIndex = 7
        })
        
        if closeButton then
            closeButton.Parent = menuFrame
            createRoundedCorner(4).Parent = closeButton
            
            closeButton.MouseButton1Click:Connect(function()
                menuFrame.Visible = false
            end)
            
            closeButton.MouseEnter:Connect(function()
                local tween = TweenService:Create(
                    closeButton,
                    TweenInfo.new(0.2),
                    {BackgroundColor3 = Color3.fromRGB(200, 50, 50)}
                )
                tween:Play()
            end)
            
            closeButton.MouseLeave:Connect(function()
                local tween = TweenService:Create(
                    closeButton,
                    TweenInfo.new(0.2),
                    {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}
                )
                tween:Play()
            end)
        end
    end

    -- Функционал перетаскивания
    local draggingButton = false
    local dragInput, dragStart, startPos

    local function updateButtonPosition(input)
        local delta = input.Position - dragStart
        if menuButton then
            menuButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end

    if menuButton then
        menuButton.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                draggingButton = true
                dragStart = input.Position
                startPos = menuButton.Position
                
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        draggingButton = false
                    end
                end)
            end
        end)

        menuButton.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and draggingButton and menuButton then
                updateButtonPosition(input)
            end
        end)
    end

    local draggingMenu = false
    local menuDragInput, menuDragStart, menuStartPos

    local function updateMenuPosition(input)
        local delta = input.Position - menuDragStart
        if menuFrame then
            menuFrame.Position = UDim2.new(menuStartPos.X.Scale, menuStartPos.X.Offset + delta.X, menuStartPos.Y.Scale, menuStartPos.Y.Offset + delta.Y)
        end
    end

    if menuFrame then
        local topBar = menuFrame:FindFirstChild("TopBar")
        if topBar then
            topBar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    draggingMenu = true
                    menuDragStart = input.Position
                    menuStartPos = menuFrame.Position
                    
                    input.Changed:Connect(function()
                        if input.UserInputState == Enum.UserInputState.End then
                            draggingMenu = false
                        end
                    end)
                end
            end)

            topBar.InputChanged:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                    menuDragInput = input
                end
            end)
        end
    end

    UserInputService.InputChanged:Connect(function(input)
        if input == menuDragInput and draggingMenu and menuFrame then
            updateMenuPosition(input)
        end
    end)

    -- Открытие/закрытие меню
    if menuButton and menuFrame then
        menuButton.MouseButton1Click:Connect(function()
            menuFrame.Visible = not menuFrame.Visible
        end)
    end

    -- Функция для создания переключателя
    local function createToggle(name, defaultValue, callback)
        local toggleFrame = safeCreate("Frame", {
            Name = name .. "Toggle",
            Size = UDim2.new(1, 0, 0, 30),
            BackgroundTransparency = 1,
            ZIndex = 7
        })
        
        local toggleLabel = safeCreate("TextLabel", {
            Name = "Label",
            Size = UDim2.new(0.7, 0, 1, 0),
            Position = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1,
            Text = name,
            TextColor3 = Color3.fromRGB(220, 220, 220),
            TextSize = 14,
            Font = Enum.Font.Gotham,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 7
        })
        
        local toggleButton = safeCreate("TextButton", {
            Name = "ToggleButton",
            Size = UDim2.new(0, 40, 0, 20),
            Position = UDim2.new(1, -40, 0.5, -10),
            BackgroundColor3 = defaultValue and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(50, 50, 50),
            Text = "",
            AutoButtonColor = false,
            ZIndex = 7
        })
        
        local toggleKnob = safeCreate("Frame", {
            Name = "Knob",
            Size = UDim2.new(0, 16, 0, 16),
            Position = UDim2.new(0, defaultValue and 22 or 2, 0.5, -8),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            ZIndex = 8
        })
        
        if toggleFrame and toggleLabel and toggleButton and toggleKnob then
            toggleLabel.Parent = toggleFrame
            toggleButton.Parent = toggleFrame
            toggleKnob.Parent = toggleButton
            
            createRoundedCorner(10).Parent = toggleButton
            createRoundedCorner(8).Parent = toggleKnob
            
            local isToggled = defaultValue
            
            toggleButton.MouseButton1Click:Connect(function()
                isToggled = not isToggled
                
                local tween = TweenService:Create(
                    toggleKnob,
                    TweenInfo.new(0.2),
                    {Position = UDim2.new(0, isToggled and 22 or 2, 0.5, -8)}
                )
                tween:Play()
                
                local colorTween = TweenService:Create(
                    toggleButton,
                    TweenInfo.new(0.2),
                    {BackgroundColor3 = isToggled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(50, 50, 50)}
                )
                colorTween:Play()
                
                if callback then
                    callback(isToggled)
                end
            end)
            
            return toggleFrame
        end
        return nil
    end

    -- Функция для создания слайдера
    local function createSlider(name, minValue, maxValue, defaultValue, callback)
        local sliderFrame = safeCreate("Frame", {
            Name = name .. "Slider",
            Size = UDim2.new(1, 0, 0, 40),
            BackgroundTransparency = 1,
            ZIndex = 7
        })
        
        local sliderLabel = safeCreate("TextLabel", {
            Name = "Label",
            Size = UDim2.new(1, 0, 0, 20),
            Position = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1,
            Text = name .. ": " .. defaultValue,
            TextColor3 = Color3.fromRGB(220, 220, 220),
            TextSize = 14,
            Font = Enum.Font.Gotham,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 7
        })
        
        local sliderTrack = safeCreate("Frame", {
            Name = "Track",
            Size = UDim2.new(1, -10, 0, 6),
            Position = UDim2.new(0, 5, 0, 25),
            BackgroundColor3 = Color3.fromRGB(60, 60, 60),
            ZIndex = 7
        })
        
        local sliderFill = safeCreate("Frame", {
            Name = "Fill",
            Size = UDim2.new((defaultValue - minValue) / (maxValue - minValue), 0, 1, 0),
            Position = UDim2.new(0, 0, 0, 0),
            BackgroundColor3 = Color3.fromRGB(0, 170, 0),
            ZIndex = 8
        })
        
        local sliderButton = safeCreate("TextButton", {
            Name = "SliderButton",
            Size = UDim2.new(0, 16, 0, 16),
            Position = UDim2.new((defaultValue - minValue) / (maxValue - minValue), -8, 0, -5),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Text = "",
            AutoButtonColor = false,
            ZIndex = 9
        })
        
        if sliderFrame and sliderLabel and sliderTrack and sliderFill and sliderButton then
            sliderLabel.Parent = sliderFrame
            sliderTrack.Parent = sliderFrame
            sliderFill.Parent = sliderTrack
            sliderButton.Parent = sliderTrack
            
            createRoundedCorner(3).Parent = sliderTrack
            createRoundedCorner(3).Parent = sliderFill
            createRoundedCorner(8).Parent = sliderButton
            
            local isDragging = false
            
            local function updateSlider(value)
                local clampedValue = math.clamp(value, minValue, maxValue)
                local fillSize = (clampedValue - minValue) / (maxValue - minValue)
                
                sliderFill.Size = UDim2.new(fillSize, 0, 1, 0)
                sliderButton.Position = UDim2.new(fillSize, -8, 0, -5)
                sliderLabel.Text = name .. ": " .. math.floor(clampedValue)
                
                if callback then
                    callback(clampedValue)
                end
            end
            
            sliderButton.MouseButton1Down:Connect(function()
                isDragging = true
            end)
            
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    isDragging = false
                end
            end)
            
            UserInputService.InputChanged:Connect(function(input)
                if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    local mousePosition = UserInputService:GetMouseLocation()
                    local trackAbsolutePosition = sliderTrack.AbsolutePosition
                    local trackAbsoluteSize = sliderTrack.AbsoluteSize
                    
                    local relativeX = (mousePosition.X - trackAbsolutePosition.X) / trackAbsoluteSize.X
                    local value = minValue + relativeX * (maxValue - minValue)
                    
                    updateSlider(value)
                end
            end)
            
            return sliderFrame
        end
        return nil
    end

    -- Функция для создания вкладки
    local function createTab(name)
        if not menuFrame then return nil end
        
        local tabsContainer = menuFrame:FindFirstChild("TabsContainer")
        local contentContainer = menuFrame:FindFirstChild("ContentContainer")
        if not tabsContainer or not contentContainer then return nil end
        
        local tabButton = safeCreate("TextButton", {
            Name = name .. "TabButton",
            Size = UDim2.new(1, 0, 0, 30),
            BackgroundColor3 = Color3.fromRGB(30, 30, 30),
            Text = name,
            TextColor3 = Color3.fromRGB(180, 180, 180),
            TextSize = 14,
            Font = Enum.Font.Gotham,
            AutoButtonColor = false,
            ZIndex = 7
        })
        
        local tabContent = safeCreate("ScrollingFrame", {
            Name = name .. "TabContent",
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 4,
            ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80),
            CanvasSize = UDim2.new(0, 0, 0, 0),
            Visible = false,
            ZIndex = 7
        })
        
        local uiListLayout = safeCreate("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 8)
        })
        
        if tabButton and tabContent and uiListLayout then
            tabButton.Parent = tabsContainer
            tabContent.Parent = contentContainer
            uiListLayout.Parent = tabContent
            
            createRoundedCorner(4).Parent = tabButton
            createStroke(1, Color3.fromRGB(60, 60, 60)).Parent = tabButton
            
            uiListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                tabContent.CanvasSize = UDim2.new(0, 0, 0, uiListLayout.AbsoluteContentSize.Y)
            end)
            
            local function activateTab()
                for _, child in ipairs(contentContainer:GetChildren()) do
                    if child:IsA("ScrollingFrame") and child.Name:find("TabContent") then
                        child.Visible = false
                    end
                end
                
                for _, child in ipairs(tabsContainer:GetChildren()) do
                    if child:IsA("TextButton") and child.Name:find("TabButton") then
                        local tween = TweenService:Create(
                            child,
                            TweenInfo.new(0.2),
                            {
                                BackgroundColor3 = Color3.fromRGB(30, 30, 30),
                                TextColor3 = Color3.fromRGB(180, 180, 180)
                            }
                        )
                        tween:Play()
                    end
                end
                
                tabContent.Visible = true
                local tween = TweenService:Create(
                    tabButton,
                    TweenInfo.new(0.2),
                    {
                        BackgroundColor3 = Color3.fromRGB(40, 40, 40),
                        TextColor3 = Color3.fromRGB(255, 255, 255)
                    }
                )
                tween:Play()
            end
            
            tabButton.MouseButton1Click:Connect(activateTab)
            
            tabButton.MouseEnter:Connect(function()
                if not tabContent.Visible then
                    local tween = TweenService:Create(
                        tabButton,
                        TweenInfo.new(0.2),
                        {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}
                    )
                    tween:Play()
                end
            end)
            
            tabButton.MouseLeave:Connect(function()
                if not tabContent.Visible then
                    local tween = TweenService:Create(
                        tabButton,
                        TweenInfo.new(0.2),
                        {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}
                    )
                    tween:Play()
                end
            end)
            
            local function addElement(element)
                element.LayoutOrder = #tabContent:GetChildren()
                element.Parent = tabContent
            end
            
            return {
                addElement = addElement,
                activate = activateTab
            }
        end
        
        return nil
    end

    -- Создаем вкладки
    local farmTab = createTab("Farm")
    local espTab = createTab("Esp")
    local aimTab = createTab("Aim")
    local extraTab = createTab("Extra")

    if espTab then
        espTab.activate()
    end

    -- Добавляем элементы на вкладки (заглушки)
    if farmTab then
        local farmLabel = safeCreate("TextLabel", {
            Size = UDim2.new(1, 0, 0, 20),
            BackgroundTransparency = 1,
            Text = "Farm Functions",
            TextColor3 = Color3.fromRGB(220, 220, 220),
            TextSize = 16,
            Font = Enum.Font.GothamBold,
            ZIndex = 7
        })
        
        farmTab.addElement(farmLabel)
        
        local autoPickupToggle = createToggle("Auto Pickup Gun", false, function(state)
            print("Auto Pickup:", state)
        end)
        
        if autoPickupToggle then
            farmTab.addElement(autoPickupToggle)
        end
    end

    if espTab then
        local espLabel = safeCreate("TextLabel", {
            Size = UDim2.new(1, 0, 0, 20),
            BackgroundTransparency = 1,
            Text = "ESP Functions",
            TextColor3 = Color3.fromRGB(220, 220, 220),
            TextSize = 16,
            Font = Enum.Font.GothamBold,
            ZIndex = 7
        })
        
        espTab.addElement(espLabel)
        
        local espToggle = createToggle("Player ESP", false, function(state)
            print("ESP:", state)
        end)
        
        if espToggle then
            espTab.addElement(espToggle)
        end
    end

    if aimTab then
        local aimLabel = safeCreate("TextLabel", {
            Size = UDim2.new(1, 0, 0, 20),
            BackgroundTransparency = 1,
            Text = "Aim Functions",
            TextColor3 = Color3.fromRGB(220, 220, 220),
            TextSize = 16,
            Font = Enum.Font.GothamBold,
            ZIndex = 7
        })
        
        aimTab.addElement(aimLabel)
        
        local aimbotToggle = createToggle("Aimbot", false, function(state)
            print("Aimbot:", state)
        end)
        
        if aimbotToggle then
            aimTab.addElement(aimbotToggle)
        end
        
        local wallhackToggle = createToggle("Through Walls", false, function(state)
            print("Wallhack:", state)
        end)
        
        if wallhackToggle then
            aimTab.addElement(wallhackToggle)
        end
        
        local fovSlider = createSlider("Aimbot FOV", 50, 300, 100, function(value)
            print("FOV:", value)
        end)
        
        if fovSlider then
            aimTab.addElement(fovSlider)
        end
    end

    if extraTab then
        local extraLabel = safeCreate("TextLabel", {
            Size = UDim2.new(1, 0, 0, 20),
            BackgroundTransparency = 1,
            Text = "Extra Functions",
            TextColor3 = Color3.fromRGB(220, 220, 220),
            TextSize = 16,
            Font = Enum.Font.GothamBold,
            ZIndex = 7
        })
        
        extraTab.addElement(extraLabel)
        
        local speedToggle = createToggle("Speed Hack", false, function(state)
            print("Speed:", state)
        end)
        
        if speedToggle then
            extraTab.addElement(speedToggle)
        end
        
        local speedSlider = createSlider("Speed Value", 16, 100, 25, function(value)
            print("Speed Value:", value)
        end)
        
        if speedSlider then
            extraTab.addElement(speedSlider)
        end
        
        local highJumpToggle = createToggle("High Jump", false, function(state)
            print("High Jump:", state)
        end)
        
        if highJumpToggle then
            extraTab.addElement(highJumpToggle)
        end
        
        local jumpSlider = createSlider("Jump Power", 50, 200, 100, function(value)
            print("Jump Power:", value)
        end)
        
        if jumpSlider then
            extraTab.addElement(jumpSlider)
        end
        
        local noclipToggle = createToggle("Noclip", false, function(state)
            print("Noclip:", state)
        end)
        
        if noclipToggle then
            extraTab.addElement(noclipToggle)
        end
    end

    -- Защита
    local protectionConnection
    protectionConnection = RunService.Heartbeat:Connect(function()
        if math.random(1, 1000) <= 1 then
            -- Редкие проверки безопасности
        end
    end)

    UserInputService.WindowFocusReleased:Connect(function()
        if menuFrame and menuFrame.Visible then
            menuFrame.Visible = false
        end
    end)

    -- Очистка
    game:GetService("Players").PlayerRemoving:Connect(function(removingPlayer)
        if removingPlayer == player then
            if protectionConnection then protectionConnection:Disconnect() end
            
            if ScreenGui then
                ScreenGui:Destroy()
            end
        end
    end)

    print("L Menu успешно загружен! Нажмите на кнопку L в правой части экрана.")
end

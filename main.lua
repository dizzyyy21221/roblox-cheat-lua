-- GRABB.VIP

\-- ESP + Aimbot + Skeleton + Health Bar + Prediction + Soft Aim

\-- License: 123 | Right Mouse Button Aim | Auto-reconnect on respawn

**if** **not** **game**:IsLoaded() **then** **game**.Loaded\:Wait() **end**

**local** Players = **game**:GetService("Players")

**local** UserInputService = **game**:GetService("UserInputService")

**local** RunService = **game**:GetService("RunService")

**local** Stats = **game**:GetService("Stats")

**local** player = Players.LocalPlayer

**local** playerGui = player\:WaitForChild("PlayerGui")

\-- ============================================================

\-- SETTINGS

\-- ============================================================

**local** settings = {

    espEnabled = **false**,

    boxEnabled = **false**,

    nameEnabled = **false**,

    healthBarEnabled = **false**,

    skeletonEnabled = **false**,

    espColor = Color3.fromRGB(255, 255, 255),

    distanceLimit = 1000,

    aimbotEnabled = **false**,

    aimbotSmoothness = 0.15,

    aimbotSnap = 0.15,

    aimbotFov = 150,

    aimbotPart = "Head",

    aimbotVisibleCheck = **false**,

    showFovCircle = **true**,

    fovColor = Color3.fromRGB(224, 224, 224),

    teamCheck = **true**,

    predictionEnabled = **false**,

    projectileSpeed = 1000,

    predictionMultiplier = 1.0,

    autoPingComp = **true**,

    softAimEnabled = **false**,

    softAimWeight = 0.3,

    softAimFov = 200

}

**local** espObjects = {}

**local** skeletonData = {}

**local** isAiming = **false**

**local** menuOpen = **false**

**local** cleanESP

\-- ============================================================

\-- PIXEL FONT

\-- ============================================================

**local** PIXEL\_FONT = **Enum**.Font.Code

\-- ============================================================

\-- LICENSE

\-- ============================================================

**local** licenseGui = Instance.new("ScreenGui")

licenseGui.Name = "GRABB\_LICENSE"

licenseGui.ResetOnSpawn = **false**

licenseGui.ZIndexBehavior = **Enum**.ZIndexBehavior.Sibling

licenseGui.Parent = playerGui

**local** licenseFrame = Instance.new("Frame")

licenseFrame.Size = UDim2.new(0, 400, 0, 340)

licenseFrame.Position = UDim2.new(0.5, -200, 0.5, -170)

licenseFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)

licenseFrame.BorderSizePixel = 1

licenseFrame.BorderColor3 = Color3.fromRGB(35, 35, 35)

licenseFrame.Parent = licenseGui

**local** licenseCorner = Instance.new("UICorner")

licenseCorner.CornerRadius = UDim.new(0, 4)

licenseCorner.Parent = licenseFrame

**local** logo = Instance.new("ImageLabel")

logo.Size = UDim2.new(0, 60, 0, 30)

logo.Position = UDim2.new(0, 10, 0, 10)

logo.BackgroundTransparency = 1

logo.Image = "[https://i.postimg.cc/25ymz8zT/logo1.png](https://i.postimg.cc/25ymz8zT/logo1.png)"

logo.Parent = licenseFrame

**local** title = Instance.new("TextLabel")

title.Size = UDim2.new(1, 0, 0, 35)

title.Position = UDim2.new(0, 0, 0, 75)

title.BackgroundTransparency = 1

title.Text = "grabb.vip"

title.TextColor3 = Color3.fromRGB(255, 255, 255)

title.TextSize = 19

title.Font = PIXEL\_FONT

title.Parent = licenseFrame

**local** enterText = Instance.new("TextLabel")

enterText.Size = UDim2.new(1, 0, 0, 24)

enterText.Position = UDim2.new(0, 0, 0, 120)

enterText.BackgroundTransparency = 1

enterText.Text = "enter license key:"

enterText.TextColor3 = Color3.fromRGB(150, 150, 150)

enterText.TextSize = 12

enterText.Font = PIXEL\_FONT

enterText.Parent = licenseFrame

**local** keyBox = Instance.new("TextBox")

keyBox.Size = UDim2.new(0.55, 0, 0, 34)

keyBox.Position = UDim2.new(0.225, 0, 0, 150)

keyBox.BackgroundColor3 = Color3.fromRGB(10, 10, 10)

keyBox.BorderSizePixel = 1

keyBox.BorderColor3 = Color3.fromRGB(40, 40, 40)

keyBox.Text = ""

keyBox.PlaceholderText = "enter key..."

keyBox.PlaceholderColor3 = Color3.fromRGB(70, 70, 70)

keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)

keyBox.TextSize = 12

keyBox.Font = PIXEL\_FONT

keyBox.ClearTextOnFocus = **false**

keyBox.Parent = licenseFrame

**local** keyCorner = Instance.new("UICorner")

keyCorner.CornerRadius = UDim.new(0, 3)

keyCorner.Parent = keyBox

**local** status = Instance.new("TextLabel")

status.Size = UDim2.new(1, 0, 0, 20)

status.Position = UDim2.new(0, 0, 0, 190)

status.BackgroundTransparency = 1

status.Text = ""

status.TextColor3 = Color3.fromRGB(255, 80, 80)

status.TextSize = 11

status.Font = PIXEL\_FONT

status.Parent = licenseFrame

**local** verify = Instance.new("TextButton")

verify.Size = UDim2.new(0.32, 0, 0, 34)

verify.Position = UDim2.new(0.34, 0, 0, 225)

verify.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

verify.BorderSizePixel = 1

verify.BorderColor3 = Color3.fromRGB(50, 50, 50)

verify.Text = "VERIFY"

verify.TextColor3 = Color3.fromRGB(255, 255, 255)

verify.TextSize = 12

verify.Font = PIXEL\_FONT

verify.AutoButtonColor = **false**

verify.Selectable = **false**

verify.Parent = licenseFrame

**local** verifyCorner = Instance.new("UICorner")

verifyCorner.CornerRadius = UDim.new(0, 3)

verifyCorner.Parent = verify

**local** CORRECT\_KEY = "123"

\-- ============================================================

\-- MAIN MENU

\-- ============================================================

**local** **function** createMainMenu()

    **if** licenseGui **then**

        licenseGui\:Destroy()

        licenseGui = **nil**

    **end**

    **local** oldMenu = playerGui\:FindFirstChild("GRABB\_MENU")

    **if** oldMenu **then** oldMenu\:Destroy() **end**

    **local** menuGui = Instance.new("ScreenGui")

    menuGui.Name = "GRABB\_MENU"

    menuGui.ResetOnSpawn = **false**

    menuGui.IgnoreGuiInset = **true**

    menuGui.ZIndexBehavior = **Enum**.ZIndexBehavior.Sibling

    menuGui.Parent = playerGui

    **local** menuFrame = Instance.new("Frame")

    menuFrame.Size = UDim2.new(0, 390, 0, 520)

    menuFrame.Position = UDim2.new(0.5, -195, 0.5, -260)

    menuFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)

    menuFrame.BorderSizePixel = 1

    menuFrame.BorderColor3 = Color3.fromRGB(35, 35, 35)

    menuFrame.ClipsDescendants = **true**

    menuFrame.Visible = **false**

    menuFrame.Parent = menuGui

    **local** menuCorner = Instance.new("UICorner")

    menuCorner.CornerRadius = UDim.new(0, 5)

    menuCorner.Parent = menuFrame

    -- Title Bar

    **local** titleBar = Instance.new("Frame")

    titleBar.Size = UDim2.new(1, 0, 0, 38)

    titleBar.BackgroundColor3 = Color3.fromRGB(3, 3, 3)

    titleBar.BorderSizePixel = 0

    titleBar.Parent = menuFrame

    **local** titleText = Instance.new("TextLabel")

    titleText.Size = UDim2.new(1, -60, 1, 0)

    titleText.Position = UDim2.new(0, 12, 0, 0)

    titleText.BackgroundTransparency = 1

    titleText.Text = "GRABB.VIP"

    titleText.TextColor3 = Color3.fromRGB(255, 255, 255)

    titleText.TextSize = 15

    titleText.Font = PIXEL\_FONT

    titleText.TextXAlignment = **Enum**.TextXAlignment.Left

    titleText.Parent = titleBar

    **local** closeButton = Instance.new("TextButton")

    closeButton.Size = UDim2.new(0, 30, 0, 30)

    closeButton.Position = UDim2.new(1, -34, 0, 4)

    closeButton.BackgroundTransparency = 1

    closeButton.Text = "X"

    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)

    closeButton.TextSize = 14

    closeButton.Font = PIXEL\_FONT

    closeButton.AutoButtonColor = **false**

    closeButton.Selectable = **false**

    closeButton.Parent = titleBar

    -- Dragging

    **local** dragging = **false**

    **local** dragStart

    **local** startPosition

    titleBar.InputBegan\:Connect(**function**(input)

        **if** input.UserInputType == **Enum**.UserInputType.MouseButton1 **then**

            dragging = **true**

            dragStart = input.Position

            startPosition = menuFrame.Position

        **end**

    **end**)

    UserInputService.InputChanged\:Connect(**function**(input)

        **if** dragging **and** input.UserInputType == **Enum**.UserInputType.MouseMovement **then**

            **local** delta = input.Position - dragStart

            menuFrame.Position = UDim2.new(

                startPosition.X.Scale,

                startPosition.X.Offset + delta.X,

                startPosition.Y.Scale,

                startPosition.Y.Offset + delta.Y

            )

        **end**

    **end**)

    UserInputService.InputEnded\:Connect(**function**(input)

        **if** input.UserInputType == **Enum**.UserInputType.MouseButton1 **then**

            dragging = **false**

        **end**

    **end**)

    -- Content

    **local** content = Instance.new("ScrollingFrame")

    content.Size = UDim2.new(1, -12, 1, -48)

    content.Position = UDim2.new(0, 6, 0, 44)

    content.BackgroundTransparency = 1

    content.BorderSizePixel = 0

    content.ScrollBarThickness = 4

    content.ScrollBarImageColor3 = Color3.fromRGB(90, 90, 90)

    content.ScrollingDirection = **Enum**.ScrollingDirection.Y

    content.ScrollingEnabled = **true**

    content.CanvasSize = UDim2.new(0, 0, 0, 0)

    content.Parent = menuFrame

    -- UI Helpers

    **local** **function** label(text, y)

        **local** obj = Instance.new("TextLabel")

        obj.Size = UDim2.new(1, -8, 0, 24)

        obj.Position = UDim2.new(0, 4, 0, y)

        obj.BackgroundTransparency = 1

        obj.Text = text

        obj.TextColor3 = Color3.fromRGB(150, 150, 150)

        obj.TextSize = 12

        obj.TextXAlignment = **Enum**.TextXAlignment.Left

        obj.Font = PIXEL\_FONT

        obj.Parent = content

        **return** obj

    **end**

    **local** **function** addToggle(text, defaultValue, y, callback)

        **local** row = Instance.new("Frame")

        row\.Size = UDim2.new(1, -8, 0, 34)

        row\.Position = UDim2.new(0, 4, 0, y)

        row\.BackgroundColor3 = Color3.fromRGB(8, 8, 8)

        row\.BorderSizePixel = 1

        row\.BorderColor3 = Color3.fromRGB(20, 20, 20)

        row\.Parent = content

        **local** textLabel = Instance.new("TextLabel")

        textLabel.Size = UDim2.new(1, -65, 1, 0)

        textLabel.Position = UDim2.new(0, 8, 0, 0)

        textLabel.BackgroundTransparency = 1

        textLabel.Text = text

        textLabel.TextColor3 = Color3.fromRGB(235, 235, 235)

        textLabel.TextSize = 11

        textLabel.Font = PIXEL\_FONT

        textLabel.TextXAlignment = **Enum**.TextXAlignment.Left

        textLabel.Parent = row

        **local** button = Instance.new("TextButton")

        button.Size = UDim2.new(0, 38, 0, 20)

        button.Position = UDim2.new(1, -47, 0.5, -10)

        button.Text = ""

        button.AutoButtonColor = **false**

        button.Selectable = **false**

        button.BorderSizePixel = 0

        button.Parent = row

        **local** knob = Instance.new("Frame")

        knob.Size = UDim2.new(0, 14, 0, 14)

        knob.Position = UDim2.new(0, 3, 0.5, -7)

        knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

        knob.BorderSizePixel = 0

        knob.Parent = button

        **local** on = defaultValue

        **local** **function** update()

            button.BackgroundColor3 = on **and** Color3.fromRGB(180, 180, 180) **or** Color3.fromRGB(35, 35, 35)

            knob.Position = on **and** UDim2.new(1, -17, 0.5, -7) **or** UDim2.new(0, 3, 0.5, -7)

            callback(on)

        **end**

        button.MouseButton1Click\:Connect(**function**()

            on = **not** on

            update()

        **end**)

        update()

    **end**

    **local** **function** addSlider(text, min, max, increment, defaultValue, y, callback)

        **local** row = Instance.new("Frame")

        row\.Size = UDim2.new(1, -8, 0, 54)

        row\.Position = UDim2.new(0, 4, 0, y)

        row\.BackgroundColor3 = Color3.fromRGB(8, 8, 8)

        row\.BorderSizePixel = 1

        row\.BorderColor3 = Color3.fromRGB(20, 20, 20)

        row\.Parent = content

        **local** nameLabel = Instance.new("TextLabel")

        nameLabel.Size = UDim2.new(0.65, 0, 0, 20)

        nameLabel.Position = UDim2.new(0, 8, 0, 2)

        nameLabel.BackgroundTransparency = 1

        nameLabel.Text = text

        nameLabel.TextColor3 = Color3.fromRGB(235, 235, 235)

        nameLabel.TextSize = 11

        nameLabel.Font = PIXEL\_FONT

        nameLabel.TextXAlignment = **Enum**.TextXAlignment.Left

        nameLabel.Parent = row

        **local** valueLabel = Instance.new("TextLabel")

        valueLabel.Size = UDim2.new(0.3, -8, 0, 20)

        valueLabel.Position = UDim2.new(0.7, 0, 0, 2)

        valueLabel.BackgroundTransparency = 1

        valueLabel.TextColor3 = Color3.fromRGB(180, 180, 180)

        valueLabel.TextSize = 11

        valueLabel.Font = PIXEL\_FONT

        valueLabel.TextXAlignment = **Enum**.TextXAlignment.Right

        valueLabel.Parent = row

        **local** slider = Instance.new("TextButton")

        slider.Size = UDim2.new(1, -24, 0, 8)

        slider.Position = UDim2.new(0, 12, 0, 34)

        slider.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

        slider.BorderSizePixel = 0

        slider.Text = ""

        slider.AutoButtonColor = **false**

        slider.Selectable = **false**

        slider.Parent = row

        **local** fill = Instance.new("Frame")

        fill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

        fill.BorderSizePixel = 0

        fill.Size = UDim2.new(0, 0, 1, 0)

        fill.Parent = slider

        **local** knob = Instance.new("Frame")

        knob.Size = UDim2.new(0, 12, 0, 12)

        knob.AnchorPoint = Vector2.new(0.5, 0.5)

        knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

        knob.BorderSizePixel = 0

        knob.Parent = slider

        **local** draggingSlider = **false**

        **local** current = defaultValue

        **local** **function** formatValue(v)

            **if** **math**.abs(v - **math**.floor(v)) < 0.0001 **then**

                **return** **tostring**(**math**.floor(v))

            **end**

            **return** string.format("%.2f", v)

        **end**

        **local** **function** setValue(value, fire)

            value = **tonumber**(value) **or** min

            value = **math**.clamp(value, min, max)

            **if** increment **and** increment > 0 **then**

                value = **math**.round(value / increment) \* increment

                value = **math**.clamp(value, min, max)

            **end**

            current = value

            **local** percent = (value - min) / **math**.max(max - min, 0.0001)

            percent = **math**.clamp(percent, 0, 1)

            fill.Size = UDim2.new(percent, 0, 1, 0)

            knob.Position = UDim2.new(percent, 0, 0.5, 0)

            valueLabel.Text = formatValue(value)

            **if** fire **then**

                callback(value)

            **end**

        **end**

        **local** **function** updateFromMouse(mouseX)

            **local** absoluteX = slider.AbsolutePosition.X

            **local** width = slider.AbsoluteSize.X

            **if** width <= 0 **then** **return** **end**

            **local** percent = **math**.clamp((mouseX - absoluteX) / width, 0, 1)

            **local** value = min + ((max - min) \* percent)

            setValue(value, **true**)

        **end**

        slider.InputBegan\:Connect(**function**(input)

            **if** input.UserInputType == **Enum**.UserInputType.MouseButton1 **then**

                draggingSlider = **true**

                updateFromMouse(input.Position.X)

            **end**

        **end**)

        UserInputService.InputChanged\:Connect(**function**(input)

            **if** draggingSlider **and** input.UserInputType == **Enum**.UserInputType.MouseMovement **then**

                updateFromMouse(input.Position.X)

            **end**

        **end**)

        UserInputService.InputEnded\:Connect(**function**(input)

            **if** input.UserInputType == **Enum**.UserInputType.MouseButton1 **then**

                draggingSlider = **false**

            **end**

        **end**)

        setValue(defaultValue, **false**)

        **return** {

            setValue = **function**(v)

                setValue(v, **true**)

            **end**

        }

    **end**

    **local** **function** addColorPicker(text, defaultColor, y, callback)

        **local** colors = {

            {"WHITE", Color3.fromRGB(255, 255, 255)},

            {"RED", Color3.fromRGB(255, 0, 0)},

            {"GREEN", Color3.fromRGB(0, 255, 0)},

            {"BLUE", Color3.fromRGB(0, 100, 255)},

            {"YELLOW", Color3.fromRGB(255, 255, 0)},

            {"PURPLE", Color3.fromRGB(170, 0, 255)},

            {"CYAN", Color3.fromRGB(0, 255, 255)},

            {"ORANGE", Color3.fromRGB(255, 120, 0)},

            {"PINK", Color3.fromRGB(255, 0, 150)},

            {"LIME", Color3.fromRGB(120, 255, 0)}

        }

        **local** row = Instance.new("Frame")

        row\.Size = UDim2.new(1, -8, 0, 40)

        row\.Position = UDim2.new(0, 4, 0, y)

        row\.BackgroundColor3 = Color3.fromRGB(8, 8, 8)

        row\.BorderSizePixel = 1

        row\.BorderColor3 = Color3.fromRGB(20, 20, 20)

        row\.Parent = content

        **local** nameLabel = Instance.new("TextLabel")

        nameLabel.Size = UDim2.new(0.42, 0, 1, 0)

        nameLabel.Position = UDim2.new(0, 8, 0, 0)

        nameLabel.BackgroundTransparency = 1

        nameLabel.Text = text

        nameLabel.TextColor3 = Color3.fromRGB(235, 235, 235)

        nameLabel.TextSize = 11

        nameLabel.Font = PIXEL\_FONT

        nameLabel.TextXAlignment = **Enum**.TextXAlignment.Left

        nameLabel.Parent = row

        **local** button = Instance.new("TextButton")

        button.Size = UDim2.new(0.52, -8, 0, 28)

        button.Position = UDim2.new(0.48, 0, 0, 6)

        button.BackgroundColor3 = defaultColor

        button.BorderSizePixel = 1

        button.BorderColor3 = Color3.fromRGB(70, 70, 70)

        button.TextColor3 = Color3.fromRGB(0, 0, 0)

        button.TextSize = 10

        button.Font = PIXEL\_FONT

        button.AutoButtonColor = **false**

        button.Selectable = **false**

        button.Parent = row

        **local** currentIndex = 1

        **for** i, info **in** **ipairs**(colors) **do**

            **if** info[2] == defaultColor **then**

                currentIndex = i

                **break**

            **end**

        **end**

        **local** **function** updateColor()

            **local** info = colors[currentIndex]

            button.Text = "< " .. info[1] .. " >"

            button.BackgroundColor3 = info[2]

            **local** brightness = info[2].R \* 0.299 + info[2].G \* 0.587 + info[2].B \* 0.114

            button.TextColor3 = brightness > 0.55 **and** Color3.fromRGB(0, 0, 0) **or** Color3.fromRGB(255, 255, 255)

            callback(info[2])

        **end**

        button.MouseButton1Click\:Connect(**function**()

            currentIndex = currentIndex + 1

            **if** currentIndex > #colors **then** currentIndex = 1 **end**

            updateColor()

        **end**)

        updateColor()

        **return** {

            setValue = **function**(v)

                **for** i, info **in** **ipairs**(colors) **do**

                    **if** info[2] == v **then**

                        currentIndex = i

                        **break**

                    **end**

                **end**

                updateColor()

            **end**

        }

    **end**

    **local** **function** addDropdown(text, options, defaultValue, y, callback)

        **local** row = Instance.new("Frame")

        row\.Size = UDim2.new(1, -8, 0, 40)

        row\.Position = UDim2.new(0, 4, 0, y)

        row\.BackgroundColor3 = Color3.fromRGB(8, 8, 8)

        row\.BorderSizePixel = 1

        row\.BorderColor3 = Color3.fromRGB(20, 20, 20)

        row\.Parent = content

        **local** nameLabel = Instance.new("TextLabel")

        nameLabel.Size = UDim2.new(0.45, 0, 1, 0)

        nameLabel.Position = UDim2.new(0, 8, 0, 0)

        nameLabel.BackgroundTransparency = 1

        nameLabel.Text = text

        nameLabel.TextColor3 = Color3.fromRGB(235, 235, 235)

        nameLabel.TextSize = 11

        nameLabel.Font = PIXEL\_FONT

        nameLabel.TextXAlignment = **Enum**.TextXAlignment.Left

        nameLabel.Parent = row

        **local** button = Instance.new("TextButton")

        button.Size = UDim2.new(0.48, -8, 0, 28)

        button.Position = UDim2.new(0.52, 0, 0, 6)

        button.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

        button.BorderSizePixel = 1

        button.BorderColor3 = Color3.fromRGB(40, 40, 40)

        button.TextColor3 = Color3.fromRGB(255, 255, 255)

        button.TextSize = 10

        button.Font = PIXEL\_FONT

        button.AutoButtonColor = **false**

        button.Selectable = **false**

        button.Parent = row

        **local** index = 1

        **for** i, option **in** **ipairs**(options) **do**

            **if** option == defaultValue **then**

                index = i

                **break**

            **end**

        **end**

        **local** **function** update()

            button.Text = "< " .. options[index] .. " >"

            callback(options[index])

        **end**

        button.MouseButton1Click\:Connect(**function**()

            index = index + 1

            **if** index > #options **then** index = 1 **end**

            update()

        **end**)

        update()

    **end**

    -- BUILD UI

    **local** y = 6

    label("ESP", y)

    y += 28

    addToggle("enable esp", **false**, y, **function**(v)

        settings.espEnabled = v

        **if** **not** v **then**

            **for** plr **in** **pairs**(espObjects) **do**

                **if** cleanESP **then** cleanESP(plr) **end**

            **end**

        **end**

    **end**)

    y += 40

    addToggle("show boxes", **false**, y, **function**(v) settings.boxEnabled = v **end**)

    y += 40

    addToggle("show names", **false**, y, **function**(v) settings.nameEnabled = v **end**)

    y += 40

    addToggle("health bar", **false**, y, **function**(v) settings.healthBarEnabled = v **end**)

    y += 40

    addToggle("skeleton esp", **false**, y, **function**(v) settings.skeletonEnabled = v **end**)

    y += 40

    addColorPicker("box color", settings.espColor, y, **function**(v) settings.espColor = v **end**)

    y += 46

    addSlider("distance limit", 100, 5000, 50, 1000, y, **function**(v) settings.distanceLimit = v **end**)

    y += 60

    -- Aimbot

    label("AIMBOT", y)

    y += 28

    addToggle("enable aimbot", **false**, y, **function**(v) settings.aimbotEnabled = v **end**)

    y += 40

    addToggle("team check", **true**, y, **function**(v) settings.teamCheck = v **end**)

    y += 40

    addToggle("show fov", **true**, y, **function**(v) settings.showFovCircle = v **end**)

    y += 40

    addSlider("smoothness", 1, 100, 1, 15, y, **function**(v) settings.aimbotSmoothness = v / 100 **end**)

    y += 60

    addSlider("snap strength", 0, 100, 1, 15, y, **function**(v) settings.aimbotSnap = v / 100 **end**)

    y += 60

    addSlider("fov radius", 20, 800, 5, 150, y, **function**(v) settings.aimbotFov = v **end**)

    y += 60

    addToggle("visible check", **false**, y, **function**(v) settings.aimbotVisibleCheck = v **end**)

    y += 40

    addDropdown("target part", {"Head", "Torso", "HumanoidRootPart"}, "Head", y, **function**(v) settings.aimbotPart = v **end**)

    y += 46

    -- Prediction

    label("PREDICTION", y)

    y += 28

    addToggle("enable prediction", **false**, y, **function**(v) settings.predictionEnabled = v **end**)

    y += 40

    addSlider("projectile speed", 200, 5000, 50, 1000, y, **function**(v) settings.projectileSpeed = v **end**)

    y += 60

    addSlider("prediction multiplier", 50, 200, 5, 100, y, **function**(v) settings.predictionMultiplier = v / 100 **end**)

    y += 60

    -- Soft Aim

    label("SOFT AIM", y)

    y += 28

    addToggle("enable soft aim", **false**, y, **function**(v) settings.softAimEnabled = v **end**)

    y += 40

    addSlider("soft aim strength", 5, 100, 5, 30, y, **function**(v) settings.softAimWeight = v / 100 **end**)

    y += 60

    addSlider("soft aim fov", 50, 500, 10, 200, y, **function**(v) settings.softAimFov = v **end**)

    y += 70

    content.CanvasSize = UDim2.new(0, 0, 0, y)

    -- ============================================================

    -- FOV CIRCLE

    -- ============================================================

    **local** fovGui = Instance.new("ScreenGui")

    fovGui.Name = "GRABB\_FOV"

    fovGui.ResetOnSpawn = **false**

    fovGui.IgnoreGuiInset = **true**

    fovGui.DisplayOrder = 9998

    fovGui.Parent = playerGui

    **local** fovFrame = Instance.new("Frame")

    fovFrame.AnchorPoint = Vector2.new(0.5, 0.5)

    fovFrame.BackgroundTransparency = 1

    fovFrame.BorderSizePixel = 0

    fovFrame.Visible = **false**

    fovFrame.Parent = fovGui

    **local** fovCorner = Instance.new("UICorner")

    fovCorner.CornerRadius = UDim.new(1, 0)

    fovCorner.Parent = fovFrame

    **local** fovStroke = Instance.new("UIStroke")

    fovStroke.Color = settings.fovColor

    fovStroke.Thickness = 1.5

    fovStroke.Parent = fovFrame

    -- ============================================================

    -- SNOW

    -- ============================================================

    **local** snowGui = Instance.new("ScreenGui")

    snowGui.Name = "GRABB\_SNOW"

    snowGui.ResetOnSpawn = **false**

    snowGui.IgnoreGuiInset = **true**

    snowGui.DisplayOrder = 9999

    snowGui.Enabled = **false**

    snowGui.Parent = playerGui

    **local** snowContainer = Instance.new("Frame")

    snowContainer.Size = UDim2.new(1, 0, 1, 0)

    snowContainer.BackgroundTransparency = 1

    snowContainer.Parent = snowGui

    **local** snowflakes = {}

    **for** i = 1, 90 **do**

        **local** size = **math**.random(1, 5)

        **local** flake = Instance.new("Frame")

        flake.Size = UDim2.new(0, size, 0, size)

        flake.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

        flake.BackgroundTransparency = **math**.random(15, 70) / 100

        flake.BorderSizePixel = 0

        flake.Parent = snowContainer

        **local** x = **math**.random()

        **local** yy = **math**.random() \* 1.2 - 0.1

        flake.Position = UDim2.new(x, 0, yy, 0)

        **local** corner = Instance.new("UICorner")

        corner.CornerRadius = UDim.new(1, 0)

        corner.Parent = flake

        **table**.insert(snowflakes, {

            frame = flake,

            x = x,

            y = yy,

            speed = **math**.random(3, 12) / 700,

            drift = (**math**.random(0, 1) == 1 **and** 1 **or** -1) \* **math**.random(1, 4) / 1500,

            wobble = **math**.random() \* 10,

            wobbleSpeed = **math**.random(3, 10) / 10

        })

    **end**

    task.**spawn**(**function**()

        **local** time = 0

        **while** snowGui.Parent **do**

            **if** menuOpen **then**

                time += 0.02

                **for** \_, snow **in** **ipairs**(snowflakes) **do**

                    snow\.x += snow\.drift

                    snow\.x += **math**.sin(time \* snow\.wobbleSpeed + snow\.wobble) \* 0.0005

                    snow\.y += snow\.speed

                    **if** snow\.x > 1 **then** snow\.x = 0

                    **elseif** snow\.x < 0 **then** snow\.x = 1 **end**

                    **if** snow\.y > 1.1 **then**

                        snow\.y = -0.05

                        snow\.x = **math**.random()

                    **end**

                    snow\.frame.Position = UDim2.new(snow\.x, 0, snow\.y, 0)

                **end**

                snowGui.Enabled = **true**

            **else**

                snowGui.Enabled = **false**

            **end**

            task.**wait**(0.02)

        **end**

    **end**)

    -- Close menu

    **local** **function** closeMenu()

        menuOpen = **false**

        menuFrame.Visible = **false**

        snowGui.Enabled = **false**

        fovFrame.Visible = **false**

    **end**

    closeButton.MouseButton1Click\:Connect(closeMenu)

    -- Menu key (X)

    UserInputService.InputBegan\:Connect(**function**(input, gp)

        **if** gp **then** **return** **end**

        **if** input.KeyCode == **Enum**.KeyCode.X **then**

            menuOpen = **not** menuOpen

            menuFrame.Visible = menuOpen

            snowGui.Enabled = menuOpen

        **end**

    **end**)

    -- ============================================================

    -- AIM INPUT - RIGHT MOUSE BUTTON

    -- ============================================================

    UserInputService.InputBegan\:Connect(**function**(input, gp)

        **if** gp **then** **return** **end**

        -- Right mouse button or F key for aimbot

        **if** input.UserInputType == **Enum**.UserInputType.MouseButton2 **or** input.KeyCode == **Enum**.KeyCode.F **then**

            isAiming = **true**

        **end**

    **end**)

    UserInputService.InputEnded\:Connect(**function**(input)

        **if** input.UserInputType == **Enum**.UserInputType.MouseButton2 **or** input.KeyCode == **Enum**.KeyCode.F **then**

            isAiming = **false**

        **end**

    **end**)

    -- ============================================================

    -- HELPERS

    -- ============================================================

    **local** **function** getRootPart(char)

        **if** **not** char **then** **return** **nil** **end**

        **return** char\:FindFirstChild("HumanoidRootPart")

            **or** char\:FindFirstChild("Torso")

            **or** char\:FindFirstChild("UpperTorso")

            **or** char.PrimaryPart

    **end**

    cleanESP = **function**(plr)

        **if** espObjects[plr] **then**

            **pcall**(**function**() espObjects[plr].gui\:Destroy() **end**)

            espObjects[plr] = **nil**

        **end**

        **if** skeletonData[plr] **then**

            **for** \_, line **in** **ipairs**(skeletonData[plr]) **do**

                **pcall**(**function**() line\:Remove() **end**)

            **end**

            skeletonData[plr] = **nil**

        **end**

    **end**

    **local** **function** getBoundingBox(char)

        **local** root = getRootPart(char)

        **if** **not** root **then** **return** **nil** **end**

        **local** success, cframe, size = **pcall**(**function**()

            **return** char\:GetBoundingBox()

        **end**)

        **if** **not** success **then** **return** **nil** **end**

        **local** topWorld = cframe.Position + Vector3.new(0, size.Y / 2 + 0.5, 0)

        **local** bottomWorld = cframe.Position - Vector3.new(0, size.Y / 2 + 0.5, 0)

        **local** topScreen, topVisible = **workspace**.CurrentCamera\:WorldToViewportPoint(topWorld)

        **local** bottomScreen, bottomVisible = **workspace**.CurrentCamera\:WorldToViewportPoint(bottomWorld)

        **if** **not** topVisible **and** **not** bottomVisible **then** **return** **nil** **end**

        **local** height = **math**.abs(topScreen.Y - bottomScreen.Y)

        **local** width = height \* 0.65

        **return** {

            Position = Vector2.new(topScreen.X - width / 2, topScreen.Y),

            Size = Vector2.new(width, height),

            OnScreen = **true**

        }

    **end**

    **local** **function** getPing()

        **local** ping = 0.05

        **pcall**(**function**()

            **local** item = Stats.Network.ServerStatsItem\:FindFirstChild("Data Ping")

            **if** item **then** ping = item\:GetValue() / 1000 **end**

        **end**)

        **return** ping

    **end**

    **local** **function** isEnemy(other)

        **if** **not** settings.teamCheck **then** **return** **true** **end**

        **if** other.Team **and** player.Team **then** **return** other.Team \~= player.Team **end**

        **return** **true**

    **end**

    **local** **function** getPredictedPosition(targetPart)

        **local** position = targetPart.Position

        **if** **not** settings.predictionEnabled **then** **return** position **end**

        **local** root = getRootPart(targetPart.Parent)

        **if** **not** root **then** **return** position **end**

        **local** velocity = root.AssemblyLinearVelocity

        **local** camera = **workspace**.CurrentCamera

        **local** distance = (camera.CFrame.Position - position).Magnitude

        **local** travelTime = distance / **math**.max(settings.projectileSpeed, 1)

        **if** settings.autoPingComp **then** travelTime += getPing() **end**

        travelTime \*= settings.predictionMultiplier

        **return** position + velocity \* travelTime

    **end**

    **local** **function** getAimbotTarget(fovLimit)

        **local** camera = **workspace**.CurrentCamera

        **local** bestTarget

        **local** bestScore = **math**.huge

        **local** viewport = camera.ViewportSize

        **local** center = Vector2.new(viewport.X / 2, viewport.Y / 2)

        **local** myRoot = getRootPart(player.Character)

        **if** **not** myRoot **then** **return** **nil** **end**

        **for** \_, other **in** **ipairs**(Players\:GetPlayers()) **do**

            **if** other \~= player **and** isEnemy(other) **then**

                **local** char = other.Character

                **local** hum = char **and** char\:FindFirstChildWhichIsA("Humanoid")

                **if** char **and** hum **and** hum.Health > 0 **then**

                    **local** part = char\:FindFirstChild(settings.aimbotPart)

                        **or** char\:FindFirstChild("Head")

                        **or** char\:FindFirstChild("HumanoidRootPart")

                    **if** part **then**

                        **local** worldPos = getPredictedPosition(part)

                        **local** distance = (myRoot.Position - worldPos).Magnitude

                        **if** distance <= settings.distanceLimit **then**

                            **local** screenPos, visible = camera\:WorldToViewportPoint(worldPos)

                            **if** visible **then**

                                **local** point = Vector2.new(screenPos.X, screenPos.Y)

                                **local** fovDistance = (point - center).Magnitude

                                **if** fovDistance <= fovLimit **then**

                                    **if** settings.aimbotVisibleCheck **then**

                                        **local** params = RaycastParams.new()

                                        params.FilterType = **Enum**.RaycastFilterType.Exclude

                                        params.FilterDescendantsInstances = {player.Character, char}

                                        **local** ray = **workspace**:Raycast(camera.CFrame.Position, worldPos - camera.CFrame.Position, params)

                                        **if** ray **then** **continue** **end**

                                    **end**

                                    **if** fovDistance < bestScore **then**

                                        bestScore = fovDistance

                                        bestTarget = {

                                            Part = part,

                                            WorldPos = worldPos,

                                            ScreenPos = point

                                        }

                                    **end**

                                **end**

                            **end**

                        **end**

                    **end**

                **end**

            **end**

        **end**

        **return** bestTarget

    **end**

    -- ============================================================

    -- CREATE ESP

    -- ============================================================

    **local** **function** createESP(plr)

        **local** gui = Instance.new("ScreenGui")

        gui.Name = "ESP\_" .. plr.Name

        gui.ResetOnSpawn = **false**

        gui.IgnoreGuiInset = **true**

        gui.DisplayOrder = 500

        gui.Parent = playerGui

        **local** container = Instance.new("Frame")

        container.BackgroundTransparency = 1

        container.BorderSizePixel = 0

        container.Parent = gui

        **local** box = Instance.new("Frame")

        box.BackgroundTransparency = 1

        box.BorderSizePixel = 0

        box.Parent = container

        **local** stroke = Instance.new("UIStroke")

        stroke.Thickness = 1.5

        stroke.Color = settings.espColor

        stroke.Parent = box

        **local** healthBG = Instance.new("Frame")

        healthBG.Size = UDim2.new(0, 4, 1, 0)

        healthBG.Position = UDim2.new(0, -7, 0, 0)

        healthBG.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

        healthBG.BorderSizePixel = 0

        healthBG.Visible = **false**

        healthBG.Parent = container

        **local** health = Instance.new("Frame")

        health.Size = UDim2.new(1, 0, 1, 0)

        health.BackgroundColor3 = settings.espColor

        health.BorderSizePixel = 0

        health.Parent = healthBG

        **local** name = Instance.new("TextLabel")

        name.Size = UDim2.new(1, 0, 0, 15)

        name.Position = UDim2.new(0, 0, 0, -17)

        name.BackgroundTransparency = 1

        name.Text = plr.Name

        name.TextColor3 = settings.espColor

        name.TextSize = 10

        name.Font = PIXEL\_FONT

        name.TextStrokeTransparency = 0

        name.Visible = **false**

        name.Parent = container

        **return** {

            gui = gui,

            container = container,

            box = box,

            stroke = stroke,

            healthBG = healthBG,

            health = health,

            name = name

        }

    **end**

    -- ============================================================

    -- SKELETON

    -- ============================================================

    **local** bones = {

        {"Head", "UpperTorso"},

        {"UpperTorso", "LowerTorso"},

        {"UpperTorso", "LeftUpperArm"},

        {"LeftUpperArm", "LeftLowerArm"},

        {"LeftLowerArm", "LeftHand"},

        {"UpperTorso", "RightUpperArm"},

        {"RightUpperArm", "RightLowerArm"},

        {"RightLowerArm", "RightHand"},

        {"LowerTorso", "LeftUpperLeg"},

        {"LeftUpperLeg", "LeftLowerLeg"},

        {"LeftLowerLeg", "LeftFoot"},

        {"LowerTorso", "RightUpperLeg"},

        {"RightUpperLeg", "RightLowerLeg"},

        {"RightLowerLeg", "RightFoot"}

    }

    **local** **function** updateSkeleton()

        **if** **not** settings.skeletonEnabled **then**

            **for** plr, lines **in** **pairs**(skeletonData) **do**

                **for** \_, line **in** **ipairs**(lines) **do**

                    **pcall**(**function**() line\:Remove() **end**)

                **end**

                skeletonData[plr] = **nil**

            **end**

            **return**

        **end**

        **local** camera = **workspace**.CurrentCamera

        **for** \_, other **in** **ipairs**(Players\:GetPlayers()) **do**

            **if** other \~= player **and** isEnemy(other) **then**

                **local** char = other.Character

                **local** hum = char **and** char\:FindFirstChildWhichIsA("Humanoid")

                **if** **not** char **or** **not** hum **or** hum.Health <= 0 **then**

                    **if** skeletonData[other] **then**

                        **for** \_, line **in** **ipairs**(skeletonData[other]) **do**

                            **pcall**(**function**() line\:Remove() **end**)

                        **end**

                        skeletonData[other] = **nil**

                    **end**

                    **continue**

                **end**

                **local** root = getRootPart(char)

                **local** myRoot = getRootPart(player.Character)

                **if** **not** root **or** **not** myRoot **then** **continue** **end**

                **if** (myRoot.Position - root.Position).Magnitude > settings.distanceLimit **then** **continue** **end**

                **if** **not** skeletonData[other] **then**

                    skeletonData[other] = {}

                    **for** i = 1, #bones **do**

                        **local** line = Drawing.new("Line")

                        line.Thickness = 1.5

                        line.Transparency = 0.5

                        line.Visible = **false**

                        **table**.insert(skeletonData[other], line)

                    **end**

                **end**

                **for** i, bone **in** **ipairs**(bones) **do**

                    **local** a = char\:FindFirstChild(bone[1])

                    **local** b = char\:FindFirstChild(bone[2])

                    **local** line = skeletonData[other][i]

                    **if** a **and** b **and** a\:IsA("BasePart") **and** b\:IsA("BasePart") **then**

                        **local** posA, visibleA = camera\:WorldToViewportPoint(a.Position)

                        **local** posB, visibleB = camera\:WorldToViewportPoint(b.Position)

                        **if** visibleA **and** visibleB **and** posA.Z > 0 **and** posB.Z > 0 **then**

                            line.From = Vector2.new(posA.X, posA.Y)

                            line.To = Vector2.new(posB.X, posB.Y)

                            line.Color = settings.espColor

                            line.Visible = **true**

                        **else**

                            line.Visible = **false**

                        **end**

                    **else**

                        line.Visible = **false**

                    **end**

                **end**

            **end**

        **end**

    **end**

    Players.PlayerRemoving\:Connect(cleanESP)

    -- ============================================================

    -- AUTO-RECONNECT ON RESPAWN

    -- ============================================================

    player.CharacterAdded\:Connect(**function**()

        -- Clean up old ESP objects when respawning

        **for** plr **in** **pairs**(espObjects) **do**

            **if** cleanESP **then** cleanESP(plr) **end**

        **end**

        **for** plr **in** **pairs**(skeletonData) **do**

            **if** cleanESP **then** cleanESP(plr) **end**

        **end**

        -- Reset aim state

        isAiming = **false**

        -- Re-apply settings if they were on

        **if** settings.espEnabled **then**

            -- ESP will re-render on next frame

        **end**

        **if** settings.aimbotEnabled **then**

            -- Aimbot will re-activate on next aim input

        **end**

    **end**)

    -- ============================================================

    -- RENDER

    -- ============================================================

    RunService.RenderStepped\:Connect(**function**()

        **local** camera = **workspace**.CurrentCamera

        **if** **not** camera **then** **return** **end**

        -- ESP

        **if** settings.espEnabled **then**

            **local** myRoot = getRootPart(player.Character)

            **if** myRoot **then**

                **for** \_, other **in** **ipairs**(Players\:GetPlayers()) **do**

                    **if** other \~= player **then**

                        **local** char = other.Character

                        **local** root = getRootPart(char)

                        **local** hum = char **and** char\:FindFirstChildWhichIsA("Humanoid")

                        **local** valid = char **and** root **and** hum **and** hum.Health > 0 **and** isEnemy(other)

                        **if** valid **then**

                            **local** distance = (myRoot.Position - root.Position).Magnitude

                            **if** distance <= settings.distanceLimit **then**

                                **local** boxData = getBoundingBox(char)

                                **if** boxData **then**

                                    **if** **not** espObjects[other] **then**

                                        espObjects[other] = createESP(other)

                                    **end**

                                    **local** esp = espObjects[other]

                                    esp.gui.Enabled = **true**

                                    esp.container.Position = UDim2.new(0, boxData.Position.X, 0, boxData.Position.Y)

                                    esp.container.Size = UDim2.new(0, boxData.Size.X, 0, boxData.Size.Y)

                                    esp.box.Size = UDim2.new(1, 0, 1, 0)

                                    esp.box.Visible = settings.boxEnabled

                                    esp.stroke.Color = settings.espColor

                                    esp.name.Visible = settings.nameEnabled

                                    **if** settings.healthBarEnabled **then**

                                        **local** ratio = **math**.clamp(hum.Health / **math**.max(hum.MaxHealth, 1), 0, 1)

                                        esp.healthBG.Visible = **true**

                                        esp.health.Size = UDim2.new(1, 0, ratio, 0)

                                        esp.health.Position = UDim2.new(0, 0, 1 - ratio, 0)

                                        esp.health.BackgroundColor3 = settings.espColor

                                    **else**

                                        esp.healthBG.Visible = **false**

                                    **end**

                                **end**

                            **end**

                        **end**

                        **if** espObjects[other] **and** **not** valid **then**

                            espObjects[other].gui.Enabled = **false**

                        **end**

                    **end**

                **end**

            **end**

        **else**

            **for** \_, esp **in** **pairs**(espObjects) **do**

                esp.gui.Enabled = **false**

            **end**

        **end**

        -- Skeleton

        updateSkeleton()

        -- FOV

        **if** settings.showFovCircle **then**

            **local** radius = settings.softAimEnabled **and** settings.softAimFov **or** settings.aimbotFov

            fovFrame.Visible = **true**

            fovFrame.Position = UDim2.new(0, camera.ViewportSize.X / 2, 0, camera.ViewportSize.Y / 2)

            fovFrame.Size = UDim2.new(0, radius \* 2, 0, radius \* 2)

            fovStroke.Color = settings.fovColor

        **else**

            fovFrame.Visible = **false**

        **end**

        -- Aimbot

        **if** settings.aimbotEnabled **and** isAiming **then**

            **local** target = getAimbotTarget(settings.aimbotFov)

            **if** target **then**

                **local** targetCFrame = CFrame.new(camera.CFrame.Position, target.WorldPos)

                **local** snap = **math**.clamp(settings.aimbotSnap, 0, 1)

                **local** smooth = **math**.clamp(settings.aimbotSmoothness, 0.01, 0.99)

                **local** amount = snap > 0 **and** **math**.clamp(snap + ((1 - snap) \* (1 - smooth)), 0, 1) **or** (1 - smooth)

                camera.CFrame = camera.CFrame\:Lerp(targetCFrame, amount)

            **end**

        **end**

        -- Soft aim

        **if** settings.softAimEnabled **and** **not** isAiming **then**

            **local** target = getAimbotTarget(settings.softAimFov)

            **if** target **then**

                **local** targetCFrame = CFrame.new(camera.CFrame.Position, target.WorldPos)

                **local** weight = **math**.clamp(settings.softAimWeight \* 0.25, 0.01, 1)

                camera.CFrame = camera.CFrame\:Lerp(targetCFrame, weight)

            **end**

        **end**

    **end**)

    -- ============================================================

    -- OPEN MENU

    -- ============================================================

    menuOpen = **true**

    menuFrame.Visible = **true**

    snowGui.Enabled = **true**

**end**

\-- ============================================================

\-- VERIFY LICENSE

\-- ============================================================

**local** verifying = **false**

**local** **function** verifyLicense()

    **if** verifying **then** **return** **end**

    **if** keyBox.Text == CORRECT\_KEY **then**

        verifying = **true**

        createMainMenu()

    **else**

        status.Text = "INVALID KEY"

        keyBox.Text = ""

        task.**delay**(1.5, **function**()

            **if** status **and** status.Parent **then**

                status.Text = ""

            **end**

        **end**)

    **end**

**end**

verify.MouseButton1Click\:Connect(verifyLicense)

keyBox.FocusLost\:Connect(**function**(enterPressed)

    **if** enterPressed **then**

        verifyLicense()

    **end**

**end**)

**print**("GRABB.VIP | waiting for license")

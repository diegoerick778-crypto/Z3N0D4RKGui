local Config = {}

-- Configurações de Cores
Config.Colors = {
	MAIN_BG = Color3.fromRGB(25, 25, 25),
	TOP_BG = Color3.fromRGB(18, 18, 18),
	BTN_BG = Color3.fromRGB(35, 35, 35),
	BORDER_COLOR = Color3.fromRGB(70, 70, 70),
	TEXT_WHITE = Color3.fromRGB(255, 255, 255),
	LIGHT_GREEN = Color3.fromRGB(120, 255, 120)
}

-- Funções de Design
function Config.addCorner(parent, radius)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, radius)
	corner.Parent = parent
end

function Config.addStroke(parent, color, thickness)
	local stroke = Instance.new("UIStroke")
	stroke.Color = color
	stroke.Thickness = thickness
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	stroke.Parent = parent
end

function Config.AddAnim(btn, TS)
	local orig = btn.BackgroundColor3
	btn.MouseButton1Down:Connect(function() TS:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play() end)
	btn.MouseButton1Up:Connect(function() TS:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = orig}):Play() end)
	btn.MouseLeave:Connect(function() TS:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = orig}):Play() end)
end

return Config

local SidePanelModule = {}

function SidePanelModule.Create(Main, HG, Config, TS, EditorBox, executarCodigo)
	local Colors = Config.Colors

	local sidePanel = Instance.new("Frame", Main)
	sidePanel.Name, sidePanel.Size, sidePanel.Position = "SidePanel", UDim2.new(0, 160, 1, 0), UDim2.new(1, 8, 0, 0)
	sidePanel.BackgroundColor3, sidePanel.BorderSizePixel = Color3.fromRGB(15, 15, 15), 0
	Config.addCorner(sidePanel, 8) Config.addStroke(sidePanel, Colors.LIGHT_GREEN, 1)

	local sideTitle = Instance.new("TextLabel", sidePanel)
	sideTitle.Size, sideTitle.BackgroundTransparency = UDim2.new(1, 0, 0, 38), 1
	sideTitle.Text, sideTitle.TextColor3, sideTitle.Font, sideTitle.TextSize = "UPLOADS / SALVOS", Colors.LIGHT_GREEN, Enum.Font.Code, 12

	local scrollFrame = Instance.new("ScrollingFrame", sidePanel)
	scrollFrame.Size, scrollFrame.Position = UDim2.new(1, -10, 1, -90), UDim2.new(0, 5, 0, 42)
	scrollFrame.BackgroundColor3, scrollFrame.BackgroundTransparency, scrollFrame.BorderSizePixel = Color3.fromRGB(20, 20, 20), 0.3, 0
	scrollFrame.ScrollBarThickness, scrollFrame.ScrollBarImageColor3 = 5, Colors.BORDER_COLOR
	Config.addCorner(scrollFrame, 4)

	local uiListLayout = Instance.new("UIListLayout", scrollFrame)
	uiListLayout.Padding, uiListLayout.SortOrder = UDim.new(0, 5), Enum.SortOrder.LayoutOrder
	uiListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		scrollFrame.CanvasSize = UDim2.new(0, 0, 0, uiListLayout.AbsoluteContentSize.Y + 10)
	end)

	local addScriptBtn = Instance.new("TextButton", sidePanel)
	addScriptBtn.Size, addScriptBtn.Position, addScriptBtn.BackgroundColor3 = UDim2.new(1, -10, 0, 35), UDim2.new(0, 5, 1, -43), Colors.BTN_BG
	addScriptBtn.Text, addScriptBtn.TextColor3, addScriptBtn.Font, addScriptBtn.TextSize = "[+ ADD SCRIPT]", Colors.LIGHT_GREEN, Enum.Font.Code, 12
	Config.addCorner(addScriptBtn, 6) Config.addStroke(addScriptBtn, Colors.BORDER_COLOR, 1) Config.AddAnim(addScriptBtn, TS)

	local function adicionarScriptPreSalvo(nome, codigo)
		local scriptBtn = Instance.new("TextButton", scrollFrame)
		scriptBtn.Size, scriptBtn.BackgroundColor3 = UDim2.new(1, -10, 0, 30), Color3.fromRGB(25, 25, 25)
		scriptBtn.Text, scriptBtn.TextColor3, scriptBtn.Font, scriptBtn.TextSize = nome, Colors.TEXT_WHITE, Enum.Font.Code, 11
		Config.addCorner(scriptBtn, 4) Config.addStroke(scriptBtn, Colors.BORDER_COLOR, 1) Config.AddAnim(scriptBtn, TS)
		scriptBtn.MouseButton1Click:Connect(function() EditorBox.Text = codigo executarCodigo(codigo) end)
	end

	adicionarScriptPreSalvo("Dex Explorer plus", 'loadstring(game:HttpGet("https://github.com"))()')

	addScriptBtn.MouseButton1Click:Connect(function()
		if HG:FindFirstChild("InputFrame") then HG.InputFrame:Destroy() end
		local iFrame = Instance.new("Frame", HG)
		iFrame.Name, iFrame.Size, iFrame.Position = "InputFrame", UDim2.new(0, 300, 0, 160), UDim2.new(0.5, -150, 0.5, -80)
		iFrame.BackgroundColor3, iFrame.BorderSizePixel = Color3.fromRGB(15, 15, 15), 0
		Config.addCorner(iFrame, 8) Config.addStroke(iFrame, Colors.LIGHT_GREEN, 1)

		local nameInput = Instance.new("TextBox", iFrame)
		nameInput.Size, nameInput.Position, nameInput.BackgroundColor3 = UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, 15), Color3.fromRGB(25, 25, 25)
		nameInput.TextColor3, nameInput.PlaceholderText, nameInput.Text, nameInput.Font, nameInput.TextSize = Colors.TEXT_WHITE, "Nome do Script", "", Enum.Font.Code, 12
		Config.addCorner(nameInput, 4) Config.addStroke(nameInput, Colors.BORDER_COLOR, 1)

		local linkInput = Instance.new("TextBox", iFrame)
		linkInput.Size, linkInput.Position, linkInput.BackgroundColor3 = UDim2.new(1, -20, 0, 50), UDim2.new(0, 10, 0, 55), Color3.fromRGB(25, 25, 25)
		linkInput.TextColor3, linkInput.PlaceholderText, linkInput.Text, linkInput.MultiLine, linkInput.Font, linkInput.TextSize = Color3.fromRGB(200, 255, 200), "Cole o link aqui...", "", true, Enum.Font.Code, 12
		Config.addCorner(linkInput, 4) Config.addStroke(linkInput, Colors.BORDER_COLOR, 1)

		local saveBtn = Instance.new("TextButton", iFrame)
		saveBtn.Size, saveBtn.Position, saveBtn.BackgroundColor3 = UDim2.new(0, 100, 0, 30), UDim2.new(0.5, -50, 0, 115), Color3.fromRGB(30, 30, 30)
		saveBtn.Text, saveBtn.TextColor3, saveBtn.Font = "SALVAR", Colors.LIGHT_GREEN, Enum.Font.RobotoMono
		Config.addCorner(saveBtn, 4) Config.addStroke(saveBtn, Colors.BORDER_COLOR, 1) Config.AddAnim(saveBtn, TS)

		saveBtn.MouseButton1Click:Connect(function()
			if nameInput.Text ~= "" and linkInput.Text ~= "" then
				adicionarScriptPreSalvo(nameInput.Text, linkInput.Text) iFrame:Destroy()
			end
		end)
	end)
end

return SidePanelModule

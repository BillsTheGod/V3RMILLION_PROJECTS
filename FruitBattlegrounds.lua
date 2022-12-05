if game.PlaceId ~= 9224601490 or shared.FruitBattlegrounds then return end;

shared.FruitBattlegrounds = true;

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;

local MainData = LocalPlayer:WaitForChild("MAIN_DATA")
local CurrentData = MainData:WaitForChild("Fruits"):WaitForChild(MainData:WaitForChild("Slots")[MainData:WaitForChild("Slot").Value].Value);

local FruitMoves = {};

while shared.FruitBattlegrounds do
	wait(0.25);

	if PlayerGui:FindFirstChild("UI") and not PlayerGui.UI.HUD.Visible then return end;
	if LocalPlayer.Character.Stats:GetAttribute("Stamina") <= 50 then return end;

	if #FruitMoves == 0 then
		for i,v in pairs(LocalPlayer.Backpack:GetChildren()) do
			if v.ClassName == "Tool" and CurrentData.Level.Value >= v:GetAttribute("Level") then
				FruitMoves[#FruitMoves + 1] = string.gsub(v.Name, " ", "");
			end
		end
	else
		LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1317.05322, 696.182251, -985.855286, -0.608514786, 4.99603416e-08, -0.793542504, -1.55696291e-08, 1, 7.48979332e-08, 0.793542504, 5.79316612e-08, -0.608514786);

		for i,v in pairs(FruitMoves) do
			if not LocalPlayer.Cooldowns:FindFirstChild(v) then
				ReplicatedStorage.Replicator:InvokeServer(CurrentData.Name, v, {});
			end
		end
	end
end;

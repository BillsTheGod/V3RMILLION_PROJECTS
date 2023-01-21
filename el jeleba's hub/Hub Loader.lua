if not syn then game:GetService("Players").LocalPlayer:Kick("Your exploit is not supported !") end;

local GameIDs = {
	[1359573625] = "Deepwoken",
	[2132098792] = "Hollow Abyss"
};

if GameIDs[game.GameId] then
	loadstring(game:HttpGet(("https://raw.githubusercontent.com/BillsTheGod/V3RMILLION_PROJECTS/main/el%20jeleba's%20hub/" .. string.gsub(GameIDs[game.GameId], " ", "%20") .. ".lua")))()
end

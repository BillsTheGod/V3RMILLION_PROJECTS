repeat wait() until game:IsLoaded();

-- // SETTINGS \\ --

local SECRET_KEY = "secret key here"; --https://beta.openai.com/account/api-keys
local PROMPTS_SUGGESTIONS = {
	START = {"A cute", "A futuristic", "An old", "A scary", "A big", "A small", "A sick"},
	MIDDLE = {"baby", "photo", "cyborg", "car", "house", "cat", "dog", "person", "elevator", "visual"},
	TYPE = {", 3D render", ", abstract oil paiting", ", high quality", ", cartoon", ", futuristic neon"},
};

-- // DO NOT CHANGE BELOW \\ --

if SECRET_KEY == "secret key here" then return end;

local Players = game:GetService("Players");
local HttpService = game:GetService("HttpService");
local LocalPlayer = Players.LocalPlayer;

local function MakeRequest(Prompt)
	return syn.request({
		Url = "https://api.openai.com/v1/images/generations", 
		Method = "POST",
		Headers = {
			["Content-Type"] = "application/json",
			["Authorization"] =  "Bearer " .. SECRET_KEY
		},
		Body = HttpService:JSONEncode({
			prompt = Prompt,
			n = 1,
			size = "1024x1024",
		});
	});
end

local Random = PROMPTS_SUGGESTIONS.START[math.random(1, #PROMPTS_SUGGESTIONS.START)] .. " " .. PROMPTS_SUGGESTIONS.MIDDLE[math.random(1, #PROMPTS_SUGGESTIONS.MIDDLE)] .. PROMPTS_SUGGESTIONS.TYPE[math.random(1, #PROMPTS_SUGGESTIONS.TYPE)];
local Requested = HttpService:JSONDecode(MakeRequest(Random).Body);

print(Random);
setclipboard(Requested.data[1].url);

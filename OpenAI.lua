repeat wait() until game:IsLoaded();

-- // SETTINGS \\ --

local SECRET_KEY = "secret key here"; --https://beta.openai.com/account/api-keys
local MESSAGE_SETTINGS = {
	["MINIMUM_CHARACTERS"] = 15,
	["MAXIMUM_CHARACTERS"] = 50,
};

_G.WHITELISTED = {
	["seem2006"] = true,
};

-- // DO NOT CHANGE BELOW \\ --

if _G.OpenAI or SECRET_KEY == "secret key here" then return end;

_G.OpenAI = true;

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local HttpService = game:GetService("HttpService");
local Players = game:GetService("Players");
local SayMessageRequest = ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest");
local Debounce = false;

local function MakeRequest(Prompt)
	return syn.request({
		Url = "https://api.openai.com/v1/completions", 
		Method = "POST",
		Headers = {
			["Content-Type"] = "application/json",
			["Authorization"] =  "Bearer " .. SECRET_KEY
		},
		Body = HttpService:JSONEncode({
			model = "text-davinci-002",
			prompt = Prompt,
			temperature = 0.9,
  			max_tokens = 47, --150
  			top_p = 1,
  			frequency_penalty = 0.0,
  			presence_penalty = 0.6,
  			stop = {" Human:", " AI:"}
		});
	});
end

local function ConnectFunction(Instance)
	Instance.Chatted:Connect(function(Message)
		if not _G.WHITELISTED[Instance.Name] or Debounce or #Message < MESSAGE_SETTINGS["MINIMUM_CHARACTERS"] or #Message > MESSAGE_SETTINGS["MAXIMUM_CHARACTERS"] then return end;
			
		Debounce = true;

		local HttpRequest = MakeRequest("Human: " .. Message .. "\n\nAI:");
		local Response = string.gsub(string.sub(HttpService:JSONDecode(HttpRequest["Body"]).choices[1].text, 2), "[%p%c]", "");

		if #Response < 200 then
			SayMessageRequest:FireServer(Response, "All");
			wait(5);
			Debounce = false;
		else
			warn("Response (> 200): " .. Response);
			SayMessageRequest:FireServer("Sorry I didn't understand your question very well.", "All");
			wait(2.5);
			Debounce = false;
		end
	end)
end

for i,v in pairs(Players:GetPlayers()) do
	if v.Name ~= Players.LocalPlayer.Name then
		ConnectFunction(v);
	end
end

Players.PlayerAdded:Connect(function(Player)
	ConnectFunction(Player);
end)

warn("Script has been executed with success.");

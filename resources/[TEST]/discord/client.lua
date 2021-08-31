Citizen.CreateThread(function()
	while true do
        -- This is the Application ID (Replace this with you own)
		SetDiscordAppId(874724269165248593)

        -- Here you will have to put the image name for the "large" icon.
		SetDiscordRichPresenceAsset('logo_name')
        
        -- (11-11-2018) New Natives:

        -- Here you can add hover text for the "large" icon.
        SetDiscordRichPresenceAssetText('God\'s country RP')
       


        -- (26-02-2021) New Native:

        --[[ 
            Here you can add buttons that will display in your Discord Status,
            First paramater is the button index (0 or 1), second is the title and 
            last is the url (this has to start with "fivem://connect/" or "https://") 
        ]]--
        SetDiscordRichPresenceAction(0, "Rejoindre", "redm://connect/localhost:30120")
        SetDiscordRichPresenceAction(1, "Discord", "https://discord.com/invite/mrrrtVv4UM")

        -- It updates every minute just in case.
		Citizen.Wait(60000)
	end
end)
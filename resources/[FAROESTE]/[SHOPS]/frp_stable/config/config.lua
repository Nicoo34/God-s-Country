Config = {}

Config.Stables = {
	Valentine = {	   
		Pos = {x=-367.73, y=787.72, z=116.26},
		Name = 'Ecurie',
        Heading = -30.65,
		SpawnPoint = {
			Pos = {x=-372.43, y=791.79, z=116.13},
			CamPos = {x=1, y=-3, z=0},
			Heading = 182.3
        }
	},
	BlackWater = {
		Pos = {x=-873.167, y=-1366.040, z=43.531},
		Name = 'Ecurie',
        Heading = 266.84,
		SpawnPoint = {
			Pos = {x=-864.373, y=-1361.485, z=43.702},
			CamPos = {x=-1.2, y=-3, z=0},
			Heading = 181.91
        }
    },
	Saint_Denis = {
		Pos = {x=2503.153, y=-1442.725, z=46.312},
		Name = 'Ecurie',
        Heading = 169.45,
		SpawnPoint = {
			Pos = {x=2508.822, y=-1449.949, z=46.402},
			CamPos = {x=-3, y=3, z=0},
			Heading = 93.13
        }
    },
}

Config.Horses = {
	{
		name = "Chevaux de labeur",
		["A_C_Horse_AmericanPaint_SplashedWhite"] = {"American Paint à robe Balzane", 20, 50},
		["A_C_Horse_AmericanPaint_Overo"] = {"American Paint à robe Overo", 21, 55},
		["A_C_Horse_AmericanPaint_Greyovero"] = {"American Paint à robe Overo gris", 20, 50},
		["A_C_Horse_AmericanPaint_Tobiano"] = {"American Paint à robe Tobiano", 21, 55},
		["A_C_Horse_Appaloosa_BrownLeopard"] = {"Appaloosa à robe Léopard brun", 20, 50},
		["A_C_Horse_Appaloosa_Blanket"] = {"Appaloosa à robe Capée", 21, 55},
		["A_C_Horse_Appaloosa_LeopardBlanket"] = {"Appaloosa à robe Capé léopard", 20, 50},
		["A_C_Horse_Appaloosa_Leopard"] = {"Appaloosa à robe Léopard", 21, 55},
		["A_C_Horse_Appaloosa_FewSpotted_PC"] = {"Appaloosa tachés", 21, 55},
		["A_C_Horse_DutchWarmblood_SootyBuckskin"] = {"Hollandais à sang chaud à robe Isabelle souty", 20, 50},
		["A_C_Horse_DutchWarmblood_SealBrown"] = {"Hollandais à sang chaud à robe Noir pangaré", 21, 55},
		["A_C_Horse_DutchWarmblood_ChocolateRoan"] = {"Hollandais à sang chaud à robe Rouan chocolat", 21, 55},
	},
	{
		name = "Chevaux de qualité supérieure",
		["A_C_Horse_Arabian_Black"] = {"Pur-sang arabe à robe Noire", 5, 17},
		["A_C_Horse_Arabian_Grey"] = {"Pur-sang arabe à robe Grise", 20, 50},
		["A_C_Horse_Arabian_RedChestnut"] = {"Pur-sang arabe à robe Alezan Rouge", 21, 55},
		["A_C_Horse_Arabian_RoseGreyBay"] = {"Pur-sang arabe à robe Alezan gris pommelé", 20, 50},
		["A_C_Horse_Arabian_White"] = {"Pur-sang arabe à robe blanche", 21, 55},
		["A_C_Horse_Arabian_WarpedBrindle_PC"] = {"Cheval arabe bringé déformé", 21, 55},
	},
	{
		name = "Chevaux de selle",
		["A_C_HORSEMULE_01"] = {"Mula", 5, 17},
		["A_C_Horse_KentuckySaddle_Black"] = {"Kentucky à robe Noire", 20, 50},
		["A_C_Horse_KentuckySaddle_ButterMilkBuckskin_PC"] = {"Kentucky à robe blanche", 21, 55},
		["A_C_Horse_KentuckySaddle_ChestnutPinto"] = {"Kentucky à robe Azelan pinto", 20, 50},
		["A_C_Horse_KentuckySaddle_Grey"] = {"Kentucky à robe Grise", 21, 55},
		["A_C_Horse_KentuckySaddle_SilverBay"] = {"Kentucky à robe Bai silver", 20, 50},
		["A_C_Horse_Morgan_Bay"] = {"Morgan à robe Baie", 21, 55},
		["A_C_Horse_Morgan_BayRoan"] = {"Tennessee Walker à robe Rouan crains lavés", 20, 50},
		["A_C_Horse_Morgan_FlaxenChestnut"] = {"Morgan à robe Azelan crins lavés", 21, 55},
		["A_C_Horse_Morgan_LiverChestnut_PC"] = {"Morgan à robe Azelan sombre", 20, 50},
		["A_C_Horse_Morgan_Palomino"] = {"Tennessee Walker à robe Bai pommelé", 21, 55},
	},
	{
		name = "Chevaux polyvalents",
		["A_C_Horse_Breton_MealyDappleBay"] = {"Breton à robe Bai pommelé pangaré", 5, 17},
		["A_C_Horse_Breton_SteelGrey"] = {"Breton à robe Gris fer", 20, 50},
		["A_C_Horse_Breton_GrulloDun"] = {"Breton à robe Grullo", 21, 55},
		["A_C_Horse_Breton_SealBrown"] = {"Breton à robe Noir pangaré", 21, 55},
		["A_C_Horse_Breton_Sorrel"] = {"Breton à robe Oseille", 21, 55},
		["A_C_Horse_Breton_RedRoan"] = {"Breton à robe Rubican", 21, 55},
		["A_C_Horse_GypsyCob_SplashedPiebald"] = {"Cob Gypsy à robe Pie balzan", 5, 17},
		["A_C_Horse_GypsyCob_Skewbald"] = {"Cob Gypsy à robe Skewbald", 20, 50},
		["A_C_Horse_GypsyCob_Piebald"] = {"Cob Gypsy à robe Pie", 21, 55},
		["A_C_Horse_GypsyCob_PalominoBlagdon"] = {"Cob Gypsy à robe Blagdon palomino", 21, 55},
		["A_C_Horse_GypsyCob_SplashedBay"] = {"Cob Gypsy à robe Bai balzan", 21, 55},
		["A_C_Horse_GypsyCob_WhiteBlagdon"] = {"Cob Gypsy à robe Blagdon blanc", 21, 55},
		["A_C_Horse_Criollo_BayBrindle"] = {"Criollo à robe Bai bringé", 5, 17},
		["A_C_Horse_Criollo_BayFrameOvero"] = {"Criollo à robe Bai frame overo", 20, 50},
		["A_C_Horse_Criollo_SorrelOvero"] = {"Criollo à robe Overo oseille", 21, 55},
		["A_C_Horse_Criollo_Dun"] = {"Criollo à robe Dun", 21, 55},
		["A_C_Horse_Criollo_BlueRoanOvero"] = {"Criollo à robe Overo noir rouanné", 21, 55},
		["A_C_Horse_Criollo_MarbleSabino"] = {"Criollo à robe Sabino marmoré", 21, 55},
		["A_C_Horse_Kladruber_Black"] = {"Kladruber à robe Noire", 5, 17},
		["A_C_Horse_Kladruber_DappleRoseGrey"] = {"Kladruber à robe Alezan grisonnant pommelé", 20, 50},
		["A_C_Horse_Kladruber_White"] = {"Kladruber à robe Blanche", 21, 55},
		["A_C_Horse_Kladruber_Grey"] = {"Kladruber à robe Grise", 21, 55},
		["A_C_Horse_Kladruber_Cremello"] = {"Kladruber à robe Cremello", 21, 55},
		["A_C_Horse_Kladruber_Silver"] = {"Kladruber à robe Argentée", 21, 55},
		["A_C_Horse_MissouriFoxtrotter_SilverDapplePinto"] = {"Missouri Fox Trotter à robe Pinto pommelé silver", 5, 17},
		["A_C_Horse_MissouriFoxTrotter_AmberChampagne"] = {"Missouri Fox Trotter à robe Champagne ambre", 20, 50},
		["A_C_Horse_Mustang_TigerStripedBay"] = {"Mustang à robe Bai tigré", 21, 55},
		["A_C_Horse_Mustang_Buckskin"] = {"Mustang à robe Trullo", 21, 55},
		["A_C_Horse_Mustang_Wildbay"] = {"Mustang à robe Bai sauvage", 21, 55},
		["A_C_Horse_NorfolkRoadster_RoseGrey"] = {"Norfolk Roadster à robe Alezan grisonnant", 21, 55},
		["A_C_Horse_NorfolkRoadster_SpeckledGrey"] = {"Norfolk Roadster à robe Grise tachetée", 5, 17},
		["A_C_Horse_NorfolkRoadster_Black"] = {"Norfolk Roadster à robe Noire", 20, 50},
		["A_C_Horse_NorfolkRoadster_SpottedTricolor"] = {"Norfolk Roadster à robe Capé tâché tricolore", 21, 55},
		["A_C_Horse_NorfolkRoadster_PieBaldRoan"] = {"Norfolk Roadster à robe Pie rouanné", 21, 55},
		["A_C_Horse_NorfolkRoadster_DappledBuckSkin"] = {"Norfolk Roadster à robe Isabelle pommelé", 21, 55},
		["A_C_Horse_Turkoman_Gold"] = {"Turkoman à robe Dorée", 21, 55},
		["A_C_Horse_Turkoman_DarkBai"] = {"Turkoman à robe Bai brun", 21, 55},
		["A_C_Horse_Turkoman_Silver"] = {"Turkoman à robe Argentée", 21, 55},

	},
	{
		name = "Chevaux de course",
		["A_C_Horse_Nokota_BlueRoan"] = {"Nokota à robe Noir rouanné", 47, 130},
		["A_C_Horse_Nokota_ReverseDappleRoan"] = {"Nokota à robe Rouan pommelé inversé.", 135, 450},
		["A_C_Horse_Nokota_WhiteRoan"] = {"Nokota à robe Rouan blanc", 47, 130},
		["A_C_Horse_Thoroughbred_Brindle"] = {"Pur-sang à robe Bringée", 47, 130},
		["A_C_Horse_Thoroughbred_DappleGrey"] = {"Pur-sang à robe Gris pommelé", 47, 130},
		["A_C_Horse_Thoroughbred_BlackChestnut"] = {"Pur-sang Châtaignier Noir", 47, 130},
		["A_C_Horse_Thoroughbred_BloodBay"] = {"Pur-sang à robe Bai acajou", 135, 450},
		["A_C_Horse_Thoroughbred_ReverseDappleBlack"] = {"Pur-sang noir pommelé", 47, 130},
		["A_C_Horse_AmericanStandardbred_PalominoDapple"] = {"Trotteur américain à robe Palomino pommelé", 47, 130},
		["A_C_Horse_AmericanStandardbred_Black"] = {"Trotteur américain à robe Noire", 47, 130},
		["A_C_Horse_AmericanStandardbred_Buckskin"] = {"Trotteur américain à robe Isabelle", 47, 130},
		["A_C_Horse_AmericanStandardbred_SilverTailBuckskin"] = {"Trotteur américain à robe Isabelle queue argentée", 47, 130},


	},
	{
		name = "Chevaux de guerre",
		["A_C_Horse_Andalusian_DarkBay"] = {"Andalou à robe Bai brun", 50, 140},
		["A_C_Horse_Andalusian_Perlino"] = {"Andalou à robe Perlino", 50, 140},
		["A_C_Horse_Andalusian_RoseGray"] = {"Andalou à robe Alezan grisonnant", 50, 140},
		["A_C_Horse_Ardennes_BayRoan"] = {"Ardennais à robe Bai rouanné", 50, 140},
		["A_C_Horse_Ardennes_IronGreyRoan"] = {"Ardennais à robe Grise", 50, 140},
		["A_C_Horse_Ardennes_StrawberryRoan"] = {"Ardennais à robe Rouan fraise", 50, 140},
		["A_C_Horse_HungarianHalfbred_DarkDappleGrey"] = {"Demi-sang hongrois à robe Gris pommelé foncé", 50, 140},
		["A_C_Horse_HungarianHalfbred_FlaxenChestnut"] = {"Demi-sang hongrois Alezan à crins lavés", 50, 140},
		["A_C_Horse_HungarianHalfbred_LiverChestnut"] = {"Demi-sang hongrois Alezan à crins clair", 50, 140},
		["A_C_Horse_HungarianHalfbred_PiebaldTobiano"] = {"Demi-sang hongrois à robe Pie tobiano", 50, 140},
	},
	{
		name = "Chevaux de trait",
		["A_C_Horse_Belgian_BlondChestnut"] = {"Belge à robe Alezan clair", 47, 130},
		["A_C_Horse_Belgian_MealyChestnut"] = {"Belge à robe Alezan pangaré", 50, 140},
		["A_C_Horse_Shire_DarkBay"] = {"Shire à robe Bai brun", 73, 200}, 
		["A_C_Horse_Shire_LightGrey"] = {"Shire à robe Gris clair", 47, 130},
		["A_C_Horse_Shire_RavenBlack"] = {"Shire à robe noir", 50, 140},
		["A_C_Horse_SuffolkPunch_RedChestnut"] = {"Suffolk Punch à robe Oseille", 73, 200},     
		["A_C_Horse_SuffolkPunch_Sorrel"] = {"Suffolk Punch à robe Alezan doré", 73, 200},       
	},
}



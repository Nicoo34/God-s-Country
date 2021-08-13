Quests = {
    ['carteiro'] = {
        name = "Livrer des lettres",
        helptext = "Mission conçue pour livrer des lettres aux endroits appropriés marqués sur la carte.",
        need = {
            cartas = 15,
            needReturn = true
        },
        rewards = {
            money = math.random(10.1, 35.9),
            exp = 100
        }
    },
    ['entregador'] = {
        name = "Livrer des cargaisons",
        helptext = "Mission visant à livrer la cargaison aux endroits appropriés marqués sur la carte.",
        need = {
            cargas = 1,
            needReturn = true
        },
        rewards = {
            money = math.random(10.1, 35.9),
            exp = 100
        }
    },
    ['pescador'] = {
        name = "on va à la pêche? Hé? on va à la pêche?",
        helptext = "Rendez-vous sur l'un des lacs indiqués sur votre carte pour pouvoir utiliser votre canne à pêche, car personne n'utilise KKKK.",
        need = {
            peixes = 25,
            needReturn = true
        },
        rewards = {
            money = math.random(10.1, 45.9),
            exp = 75
        }
    },
    ['cacadorderecompensas'] = {
        name = "Chasseur de prime",
        helptext = "Parlez à un représentant de la loi afin de trouver l'emplacement de l'un des dangereux criminels de cette ville..",
        need = {
            criminoso = 1,
            needReturn = true
        },
        rewards = {
            money = math.random(50.1, 95.9),
            exp = 250
        }
    },
    ['mineradordecobre'] = {
        name = "Mine de cuivre",
        helptext = "Trouvez une mine près de l'emplacement marqué sur la carte, ce point n'est pas un endroit exact, partez à la recherche du point!",
        need = {
            cobre = 1000,
            needReturn = true
        },
        rewards = {
            money = math.random(10.1, 25.9),
            exp = 250
        }
    },
    ['mineradordeprata'] = {
        name = "Mine d'argent",
        helptext = "Trouvez une mine près de l'emplacement marqué sur la carte, ce point n'est pas un endroit exact, partez à la recherche du point!",
        need = {
            prata = 1000,
            needReturn = true
        },
        rewards = {
            money = math.random(25.1, 35.9),
            exp = 250
        }
    },
    ['mineradordeouro'] = {
        name = "Mine d'or",
        helptext = "Trouvez une mine près de l'emplacement marqué sur la carte, ce point n'est pas un endroit exact, partez à la recherche du point!",
        need = {
            ouro = 1000,
            needReturn = true
        },
        rewards = {
            money = math.random(35.1, 55.9),
            exp = 250
        }
    },
}
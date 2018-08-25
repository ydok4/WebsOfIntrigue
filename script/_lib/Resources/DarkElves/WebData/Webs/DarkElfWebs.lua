DarkElfWebs = {
  Naggaroth = {
    Name = "Naggaroth",
    Type = "Continent",
    Population = 0,
    SupportedBackgrounds = {},
    ExtraCareers = {},
    ExtraFactions = {},
    RulingFaction = {},
    SocialClassModifier = 0,
    ChildWebs = { "wh2_main_the_black_flood", }, --"wh2_main_iron_mountains", "wh2_main_the_chill_road",
    Districts = {},
  },
  
  
  wh2_main_iron_mountains = {
    Name = "Naggarond Province",
    Type = "Province",
    Population = 0,
    SupportedBackgrounds = {},
    ExtraCareers = {},
    ExtraFactions = {},
    RulingFaction = {},
    SocialClassModifier = 0,
    ChildWebs = {"wh2_main_iron_mountains_naggarond", },
    Districts = {"TheBlackHighway", },
  },
  wh2_main_iron_mountains_naggarond = {
    Name = "Naggarond",
    Type = "ProvincalCapital",
    Population = 5,
    SupportedBackgrounds = {"Nobility", "Mercantile", "Rural", "Slave",},
    ExtraCareers = {},
    ExtraFactions = { },
    RulingFaction = { },
    SocialClassModifier = 30,
    ChildWebs = {},
    Districts = {"TheBlackTower", "BlackGuardTowers", "HarbourDistrict", "NobleDistrict", "SlaveDistrict", "TempleOfKhaineDistrict", "GuildsDistrict", },
  },
  ---------------------------------
  wh2_main_the_chill_road = {
    Name = "The Chill Road",
    Type = "Province",
    Population = 0,
    SupportedBackgrounds = {},
    ExtraCareers = {},
    ExtraFactions = {},
    RulingFaction = {},
    SocialClassModifier = 0,
    ChildWebs = {"wh2_main_the_chill_road_ghrond", },
    Districts = {"TheBlackHighway", },
  },
  wh2_main_the_chill_road_ghrond = {
    Name = "Ghrond",
    Type = "ProvincalCapital",
    Population = 5,
    SupportedBackgrounds = {"Nobility", "Mercantile", "Urban", "Slave"},
    ExtraCareers = {},
    ExtraFactions = {"MajorCityGovernmentFaction", },
    RulingFaction = {},
    SocialClassModifier = 25,
    ChildWebs = {},
    Districts = {},
  },
  ----------------------------------
  wh2_main_the_black_flood = {
    Name = "The Black Flood",
    Type = "Province",
    Population = 0,
    SupportedBackgrounds = {},
    ExtraCareers = {},
    ExtraFactions = {},
    RulingFaction = {},
    SocialClassModifier = 0,
    ChildWebs = {"wh2_main_the_black_flood_hag_graef", },
    Districts = {},
  },
  wh2_main_the_black_flood_hag_graef = {
    Name = "Hag Graef",
    Type = "ProvincalCapital",
    Population = 5,
    SupportedBackgrounds = {"Nobility", "Mercantile", "Urban", "Slave"},
    ExtraCareers = {},
    ExtraFactions = {"MajorCityGovernmentFaction",},
    RulingFaction = {"MajorCityGovernmentFaction"},
    SocialClassModifier = 25,
    ChildWebs = {},
    Districts = {"NobleDistrict", "HarbourDistrict",},
  },
}
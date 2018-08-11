DarkElfWebs = {
  Naggaroth = {
    Name = "Naggaroth",
    Type = "Continent",
    Population = 0,
    SupportedBackgrounds = {},
    SupportedCareers = {},
    ActiveFactions = {},
    RulingFaction = {},
    SocialClassModifier = 0,
    ChildWebs = {"NaggarondProvince", "TheChillRoad",},
    InternalWebs = {},
  },
  
  
  NaggarondProvince = {
    Name = "Naggarond Province",
    Type = "Province",
    Population = 0,
    SupportedBackgrounds = {},
    SupportedCareers = {},
    ActiveFactions = {},
    RulingFaction = {},
    SocialClassModifier = 0,
    ChildWebs = {"Naggarond", },
    InternalWebs = {"TheBlackHighway", },
  },
  Naggarond = {
    Name = "Naggarond",
    Type = "ProvincalCapital",
    Population = 5,
    SupportedBackgrounds = {"Nobility", "Mercantile", "Rural", "Slave",},
    SupportedCareers = {},
    ActiveFactions = {},
    RulingFaction = {"TheBlackCouncil" },
    SocialClassModifier = 30,
    ChildWebs = {},
    InternalWebs = {"BlackGuardTowers", "Harbour", "BlackGuardTowers", "NobleDistrict", "SlaveDistrict", "TempleOfKhaine", "GuildsDistrict", },
  },
  
  BlackGuardTowers = {
    Name = "Black Guard Towers",
    Type = "District",
    Population = 1,
    SupportedBackgrounds = {"Urban", },
    SupportedCareers = {"Servant", "Slave", },
    ActiveFactions = {"BlackGuardFaction", },
    RulingFaction = {"BlackGuardFaction" },
    SocialClassModifier = 20,
    ChildWebs = {},
    InternalWebs = {},
  },
  
  TheChillRoad = {
    Name = "The Chill Road",
    Type = "Province",
    Population = 0,
    SupportedBackgrounds = {},
    SupportedCareers = {},
    ActiveFactions = {},
    RulingFaction = {},
    SocialClassModifier = 0,
    ChildWebs = {"Ghrond", },
    InternalWebs = {"TheBlackHighway", },
  },
  Ghrond = {
    Name = "Ghrond",
    Type = "ProvincalCapital",
    Population = 5,
    SupportedBackgrounds = {"Nobility", "Mercantile", "Urban", "Slave"},
    SupportedCareers = {},
    ActiveFactions = {"MajorCityNobility", },
    RulingFaction = {},
    SocialClassModifier = 25,
    ChildWebs = {},
    InternalWebs = {},
  },
  
  -- Generic webs
  Barracks = {
    Name = "Barracks",
    Type = "Building",
    Population = 1,
    SupportedBackgrounds = {"Military", "Nobility", "Slave",},
    SupportedCareers = {},
    ActiveFactions = {"BarracksFaction",},
    RulingFaction = {"BarracksFaction",},
    SocialClassModifier = 0,
    ChildWebs = {},
    InternalWebs = {},
  },
  Harbour = {
    Name = "Harbour",
    Type = "District",
    Population = 3,
    SupportedBackgrounds = {"Military", "Mercantile", "Slave", "Servant", "Nobility",},
    SupportedCareers = {},
    ActiveFactions = {"HarbourFaction", },
    RulingFaction = {"HarbourFaction",},
    SocialClassModifier = 0,
    ChildWebs = {},
    InternalWebs = {"Barracks",},
  },
  NobleDistrict = {
    Name = "Noble District",
    Type = "District",
    Population = 3,
    SupportedBackgrounds = {"Military", "Mercantile", "Slave", "Servant", "Nobility", },
    SupportedCareers = {},
    ActiveFactions = {"NobilityFaction",},
    RulingFaction = {"NobilityFaction",},
    SocialClassModifier = 25,
    ChildWebs = {},
    InternalWebs = {"Barracks",},
  },
  SlaveDistrict = {
    Name = "Slave District",
    Type = "District",
    Population = 3,
    SupportedBackgrounds = {"Military", "Mercantile", "Slave", "Servant", "Nobility", },
    SupportedCareers = {},
    ActiveFactions = {"SlaversFaction",},
    RulingFaction = {"SlaversFaction",},
    SocialClassModifier = 25,
    ChildWebs = {},
    InternalWebs = {"Barracks",},
  },
  TempleOfKhaine = {
    Name = "Temple Of Khaine",
    Type = "District",
    Population = 3,
    SupportedBackgrounds = {"Military", "Slave", "Servant", "Nobility", },
    SupportedCareers = {},
    ActiveFactions = {},
    RulingFaction = {},
    SocialClassModifier = 25,
    ChildWebs = {},
    InternalWebs = {},
  },
  GuildsDistrict = {
    Name = "Guilds District",
    Type = "District",
    Population = 3,
    SupportedBackgrounds = {"Military", "Mercantile", "Slave", "Servant", "Nobility",},
    SupportedCareers = {},
    ActiveFactions = {"GuildFactions",},
    RulingFaction = {"GuildFactions",},
    SocialClassModifier = 25,
    ChildWebs = {},
    InternalWebs = {"Barracks",},
  },
  TheBlackHighway = {
    Name = "The Black Highway",
    Type = "District",
    Population = 3,
    SupportedBackgrounds = {"Rural", "Wanderer",},
    SupportedCareers = {},
    ActiveFactions = {},
    RulingFaction = {},
    SocialClassModifier = 25,
    ChildWebs = {},
    InternalWebs = {},
  },
}
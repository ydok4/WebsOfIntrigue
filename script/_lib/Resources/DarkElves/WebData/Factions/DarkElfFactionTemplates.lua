DarkElfFactionTemplates = {

        SlaversFaction = {
        NamePool = {"The Slave Traders", },
        PregeneratedAmount = 1,
        Ranks = {
          {
            Name = "Slave Master",
            Careers = {"Merchant",},
            Limit = 5,
            Ordinal = 0,
            StealthValue = 100,
            Gender = "",
          },
          {
            Name = "Slave Auctioneer",
            Careers = {"Merchant",},
            Limit = 0,
            Ordinal = 1,
            StealthValue = 100,
            Gender = "",
          },
          {
            Name = "Slaver",
            Careers = {"Merchant",},
            Limit = 0,
            Ordinal = 2,
            StealthValue = 100,
            Gender = "",
          },
        },
      },
      
      MajorCityGovernmentFaction = {
        NamePool = {"Rulers of WEBNAME", },
        PregeneratedAmount = 1,
        RelatedDistrict = "NobleDistrict",
        Ranks = {
          {
            Name = "Drachau",
            AdditionalMemberships = {
              {
                Faction = "NobilityFaction",
                OrdinalRank = 0,
              },
            },
            Careers = {"Drachau", },
            Limit = 1,
            Ordinal = 0,
            StealthValue = 100,
            Gender = "",
          },
          {
            Name = "Vaulkhar",
            AdditionalMemberships = {
              {
                Faction = "NobilityFaction",
                OrdinalRank = 0,
              },
            },
            Careers = {"Vaulkhar", },
            Limit = 1,
            Ordinal = 1,
            StealthValue = 100,
            Gender = "",
          },
        },
      },

      
      NobilityFaction = {
        NamePool = {"Nobility of WEBNAME", "Nobles of WEBNAME", },
        PregeneratedAmount = 1,
        Ranks = {
          {
            Name = "Estate Owner",
            AdditionalMemberships = {
              {
                Faction = "NobleFamilyFaction",
                OrdinalRank = 0,
              },
            },
            Careers = {"Noble",},
            Limit = 2,
            Ordinal = 0,
            StealthValue = 100,
            Gender = "",
          },
          {
            Name = "Residence Owner",
            AdditionalMemberships = {
              {
                Faction = "NobleFamilyFaction",
                OrdinalRank = 0,
              },
            },
            Careers = {"Noble",},
            Limit = 4,
            Ordinal = 1,
            StealthValue = 100,
            Gender = "",
          },
          {
            Name = "Manor Owner",
            AdditionalMemberships = {
              {
                Faction = "NobleFamilyFaction",
                OrdinalRank = 0,
              },
            },
            Careers = {"Noble",},
            Limit = 5,
            Ordinal = 2,
            StealthValue = 100,
            Gender = "",
          },
          --[[{
            Name = "Noble",
            AdditionalMemberships = {
              {
                Faction = "NobleFamilyFaction",
                OrdinalRank = -1,
              },
            },
            Careers = {"Noble",},
            Limit = 0,
            Ordinal = 3,
            StealthValue = 100,
            Gender = "",
          },--]]
        },
      },

      NobleFamilyFaction = {
        NamePool = {"The SURNAMEs of WEBNAME", "The SURNAMEs", "The house of SURNAME", 
        "The ADJECTIVE of house SURNAME", "House SURNAME", },
        PregeneratedAmount = 11,
        GrantedNameOverride = {
          TitlePrefix = nil,
          FirstName = nil,
          Surname = "RANDOM",
          TitleSuffix = nil,
        },
        Ranks = {
          {
            Name = "Mother",
            Careers = {"Noble",},
            Limit = 1,
            Ordinal = 0,
            StealthValue = 100,
            Gender = "Female",
          },
          {
            Name = "Father",
            Careers = {"Noble",},
            Limit = 1,
            Ordinal = 0,
            StealthValue = 100,
            Gender = "Male",
          },
          {
            Name = "Son",
            Careers = {"Noble",},
            Limit = 3,
            Ordinal = 1,
            StealthValue = 100,
            Gender = "Male",
          },
          {
            Name = "Daughter",
            Careers = {"Noble",},
            Limit = 3,
            Ordinal = 1,
            StealthValue = 100,
            Gender = "Female",
          },
          {
            Name = "Servant",
            Careers = {"Servant",},
            Limit = 0,
            Ordinal = 1,
            StealthValue = 100,
            Gender = "",
          },
          {
            Name = "Retainer",
            Careers = {"Retainer",},
            Limit = 0,
            Ordinal = 1,
            StealthValue = 100,
            Gender = "",
          },
          {
            Name = "Slave",
            Careers = {"Slave",},
            Limit = 0,
            Ordinal = 2,
            StealthValue = 100,
            Gender = "",
          },
        },
      },
      
      GuildFactions = {
        NamePool = {"The Guilds", },
        PregeneratedAmount = 3,
        Ranks = {
          {
            Name = "Guild Masters",
            Careers = {"Merchant",},
            Limit = 5,
            Ordinal = 0,
            StealthValue = 100,
            Gender = "",
          },
          {
            Name = "Guild Members",
            Careers = {"Merchant",},
            Limit = 0,
            Ordinal = 1,
            StealthValue = 100,
            Gender = "",
          },
          {
            Name = "Guild Initiate",
            Careers = {"Merchant",},
            Limit = 0,
            Ordinal = 2,
            StealthValue = 100,
            Gender = "",
          },
        },
      },
      
      BarracksFaction = {
        NamePool = {"The Barracks Faction", },
        PregeneratedAmount = 1,
        Ranks = {
          {
            Name = "Lordling",
            Careers = {"Noble", "Dreadspear", "Bleaksword", "Darkshard",},
            Limit = 1,
            Ordinal = 0,
            StealthValue = 100,
            Gender = "",
          },
          {
            Name = "Standard Bearer",
            Careers = {"Noble", "Dreadspear", "Bleaksword", "Darkshard",},
            Limit = 1,
            Ordinal = 1,
            StealthValue = 100,
            Gender = "",
          },
          {
            Name = "Musician",
            Careers = {"Noble", "Dreadspear", "Bleaksword", "Darkshard",},
            Limit = 1,
            Ordinal = 1,
            StealthValue = 100,
            Gender = "",
          },
          {
            Name = "Militia Member",
            Careers = {"Dreadspear", "Bleaksword", "Darkshard",},
            Limit = 0,
            Ordinal = 2,
            StealthValue = 100,
            Gender = "",
          },
        },
      },
      
      HarbourFaction = {
        NamePool = {"The Harbour Faction", },
        PregeneratedAmount = 1,
        Ranks = {
          {
            Name = "Harbour Master",
            Careers = {"Noble", },
            Limit = 1,
            Ordinal = 0,
            StealthValue = 100,
            Gender = "",
          },
          {
            Name = "Ship Captain",
            Careers = {"Noble", "Reaver", "Corsair", },
            Limit = 0,
            Ordinal = 1,
            StealthValue = 100,
            Gender = "",
          },
          {
            Name = "Sailor",
            Careers = {"Noble", "Corsair", "Dreadspear", "Bleaksword", "Darkshard",},
            Limit = 0,
            Ordinal = 2,
            StealthValue = 100,
            Gender = "",
          },
        },
      },
}
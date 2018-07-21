DarkElfCareers = {
  -- Civilian careers
  Retainer = {
    Name = "Retainer",
    Archetype = "Civilian",
    CareerLevel = 1,
    GrantedMemberships = {},
    
    Actions = {"Guard", "Spy", "Serve",},
    Traits = {"ContractualLoyalty", },
    
    ExitCareers = {"VeteranRetainer", "Bodyguard", },
    Goals = {"ObeyLoyaltyOwner", "KillLoyaltyOwner", "Survive"}, 
    
    Backgrounds = {"Any" },
    ExcludedBackgrounds = {"Slave" },
    SocialClasses = {"Gold", "Silver", "Bronze", },
    ExcludedGender = "",
  },
  Servant = {
    Name = "Servant",
    Archetype = "Civilian",
    CareerLevel = 1,
    GrantedMemberships = {},
    
    Actions = {"Serve", "Spy",},
    Traits = {"EyesAndEars", "FaceInTheCrowd",},
    
    ExitCareers = {"Concubine", "Steward", },
    Goals = {"ObeyLoyaltyOwner", "KillLoyaltyOwner", "Survive"}, 
    
    Backgrounds = {"Any" },
    ExcludedBackgrounds = {"Slave" },
    SocialClasses = {"Gold", "Silver", "Bronze", },
    ExcludedGender = "",
  },
  Slave = {
    Name = "Slave",
    Archetype = "Civilian",
    CareerLevel = 1,
    GrantedMemberships = {},
    
    Actions = {"Serve", },
    Traits = {"Rebel", },
    
    ExitCareers = {},
    Goals = {"ObeyLoyaltyOwner", "KillLoyaltyOwner", "Survive"}, 
    
    Backgrounds = {"Slave" },
    ExcludedBackgrounds = {},
    SocialClasses = {"Slave", },
    ExcludedGender = "",
  },
  
  -- Religious Careers 
  CultistOfKhaine = {
    Name = "Cultist of Khaine",
    Archetype = "Religious",
    CareerLevel = 1,
    GrantedMemberships = {"CultOfKaine", },
    
    Actions = {"WorshipKhaine", "RitualisticSacrificeKhaine", },
    Traits = {"Bloodthirsty", "Zealot", "LoyalToKhaine"},
    
    ExitCareers = {"WitchElf", "PriestOfKhaine"},
    Goals = {"ServeKhaine", }, 
    
    Backgrounds = {"Any" },
    ExcludedBackgrounds = {"Slave",},
    SocialClasses = {"Gold", "Silver", "Bronze",},
    ExcludedGender = "",
  },
  
  -- Military Careers
  Dreadspear = {
    Name = "Dreadspear",
    Archetype = "Military",
    CareerLevel = 1,
    GrantedMemberships = {},
    
    Actions = {"Serve", "Train",},
    Traits = {"MurderousProwess", "Disciplined", },
    
    ExitCareers = {"Lordling", "Musician", "StandardBearer", },
    Goals = {"AdvanceCareer", "Survive"}, 
    
    Backgrounds = {"Any" },
    ExcludedBackgrounds = {"Slave" },
    SocialClasses = {"Gold", "Silver", "Bronze", },
    ExcludedGender = "",
  },
  Bleaksword = {
    Name = "Bleaksword",
    Archetype = "Military",
    CareerLevel = 1,
    GrantedMemberships = {},
    
    Actions = {"Serve", "Train",},
    Traits = {"MurderousProwess", "Arrogant", },
    
    ExitCareers = {"Lordling", "Musician", "StandardBearer", },
    Goals = {"AdvanceCareer", "Survive"}, 
    
    Backgrounds = {"Any" },
    ExcludedBackgrounds = {"Slave" },
    SocialClasses = {"Gold", "Silver", "Bronze", },
    ExcludedGender = "",
  },
  Darkshard = {
    Name = "Darkshard",
    Archetype = "Military",
    CareerLevel = 1,
    GrantedMemberships = {},
    
    Actions = {"Serve", "Train",},
    Traits = {"MurderousProwess", "Sadistic", },
    
    ExitCareers = {"Guardmaster", "Musician", "StandardBearer", },
    Goals = {"AdvanceCareer", "Survive"}, 
    
    Backgrounds = {"Any" },
    ExcludedBackgrounds = {"Slave" },
    SocialClasses = {"Gold", "Silver", "Bronze", },
    ExcludedGender = "",
  },
  BlackGuard = {
    Name = "Black Guard",
    Archetype = "Military",
    CareerLevel = 1,
    GrantedMemberships = {},
    
    Actions = {"ServeMalekith", "Train", "ObeyLoyaltyOwner", "KillLoyaltyOwner"},
    Traits = {"MurderousProwess", "Fearless", },
    
    ExitCareers = {"BlackGuardTowerMaster", "Musician", "StandardBearer", },
    Goals = {"AdvanceCareer", "Survive"}, 
    
    Backgrounds = {"Any" },
    ExcludedBackgrounds = {"Slave" },
    SocialClasses = {"Gold", "Silver", "Bronze", },
    ExcludedGender = "Female",
  },
  BlackGuardTowerMaster = {
    Name = "Black Guard Tower Master",
    Archetype = "Military",
    CareerLevel = 2,
    GrantedMemberships = {},
    
    Actions = {"ServeMalekith", "Train", "ObeyLoyaltyOwner", "KillLoyaltyOwner"},
    Traits = {"MurderousProwess", "Fearless", },
    
    ExitCareers = {"BlackGuardCaptain", },
    Goals = {"Survive"}, 
    
    Backgrounds = {"Any" },
    ExcludedBackgrounds = {"Slave" },
    SocialClasses = {"Gold", "Silver", "Bronze", },
    ExcludedGender = "Female",
  },
}
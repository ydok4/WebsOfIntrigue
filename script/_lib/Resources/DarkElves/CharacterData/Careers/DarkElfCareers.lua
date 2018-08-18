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
  Noble = {
    Name = "Noble",
    Archetype = "Civilian",
    CareerLevel = 1,
    GrantedMemberships = {},
    
    Actions = {"Serve", },
    Traits = {"Arrogant", },
    
    ExitCareers = {},
    Goals = {"ObeyLoyaltyOwner", "KillLoyaltyOwner", "Survive"}, 
    
    Backgrounds = {"Noble" },
    ExcludedBackgrounds = {"Slave", },
    SocialClasses = {"Gold", },
    ExcludedGender = "",
  },
  Merchant = {
    Name = "Merchant",
    Archetype = "Civilian",
    CareerLevel = 1,
    GrantedMemberships = {},
    
    Actions = {"Serve", },
    Traits = {"Arrogant", },
    
    ExitCareers = {},
    Goals = {"ObeyLoyaltyOwner", "KillLoyaltyOwner", "Survive"}, 
    
    Backgrounds = {"Noble", "Urban", },
    ExcludedBackgrounds = {"Slave", },
    SocialClasses = {"Gold", "Silver",},
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
  Drachau = {
    Name = "Drachau",
    Archetype = "Military",
    CareerLevel = 4,
    GrantedMemberships = {},
    
    Actions = {"Rule", },
    Traits = {"", },
    
    ExitCareers = {},
    Goals = {"ObeyLoyaltyOwner", "KillLoyaltyOwner", "Survive"}, 
    
    Backgrounds = {"Noble" },
    ExcludedBackgrounds = {"Slave", },
    SocialClasses = {"Gold", },
    ExcludedGender = "",
  },
  Vaulkhar = {
    Name = "Vaulkhar",
    Archetype = "Military",
    CareerLevel = 4,
    GrantedMemberships = {},
    
    Actions = {"Rule", },
    Traits = {"", },
    
    ExitCareers = {},
    Goals = {"ObeyLoyaltyOwner", "KillLoyaltyOwner", "Survive"}, 
    
    Backgrounds = {"Noble" },
    ExcludedBackgrounds = {"Slave", },
    SocialClasses = {"Gold", },
    ExcludedGender = "",
  },
  DreadLord = {
    Name = "Dread Lord",
    Archetype = "Military",
    CareerLevel = 3,
    GrantedMemberships = {},
    
    Actions = {"Rule", },
    Traits = {"", },
    
    ExitCareers = {},
    Goals = {"ObeyLoyaltyOwner", "KillLoyaltyOwner", "Survive"}, 
    
    Backgrounds = {"Noble" },
    ExcludedBackgrounds = {"Slave", },
    SocialClasses = {"Gold", },
    ExcludedGender = "",
  },
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
    ExcludedBackgrounds = {"Slave", },
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
    ExcludedBackgrounds = {"Slave", },
    SocialClasses = {"Gold", "Silver", "Bronze", },
    ExcludedGender = "",
  },
  Corsair = {
    Name = "Corsair",
    Archetype = "Military",
    CareerLevel = 1,
    GrantedMemberships = {},
    
    Actions = {"Serve", "Train",},
    Traits = {"MurderousProwess", "Sadistic", },
    
    ExitCareers = {"Reaver", "Musician", "StandardBearer", },
    Goals = {"AdvanceCareer", "Survive"}, 
    
    Backgrounds = {"Any" },
    ExcludedBackgrounds = {"Slave", },
    SocialClasses = {"Gold", "Silver", "Bronze", },
    ExcludedGender = "",
  },
  Reaver = {
    Name = "Reaver",
    Archetype = "Military",
    CareerLevel = 1,
    GrantedMemberships = {},
    
    Actions = {"Serve", "Train",},
    Traits = {"MurderousProwess", "Sadistic", },
    
    ExitCareers = {"FleetMaster", "Musician", "StandardBearer", },
    Goals = {"AdvanceCareer", "Survive"}, 
    
    Backgrounds = {"Any" },
    ExcludedBackgrounds = {"Slave", },
    SocialClasses = {"Gold", "Silver", "Bronze", },
    ExcludedGender = "",
  },
  FleetMaster = {
    Name = "Darkshard",
    Archetype = "Military",
    CareerLevel = 1,
    GrantedMemberships = {},
    
    Actions = {"Serve", "Train",},
    Traits = {"MurderousProwess", "Sadistic", },
    
    ExitCareers = {"FleetMaster", "Musician", "StandardBearer", },
    Goals = {"AdvanceCareer", "Survive"},
    
    Backgrounds = {"Any" },
    ExcludedBackgrounds = {"Slave", },
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
    ExcludedBackgrounds = {"Slave", },
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
    ExcludedBackgrounds = {"Slave", },
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
    
    ExitCareers = {"CaptainOfTheBlackGuard", },
    Goals = {"Survive"}, 
    
    Backgrounds = {"Any" },
    ExcludedBackgrounds = {"Slave", },
    SocialClasses = {"Gold", "Silver", "Bronze", },
    ExcludedGender = "Female",
  },
  CaptainOfTheBlackGuard = {
    Name = "Captain of the Black Guard",
    Archetype = "Military",
    CareerLevel = 3,
    GrantedMemberships = {},
    
    Actions = {"ServeMalekith", "Train", "ObeyLoyaltyOwner", "KillLoyaltyOwner"},
    Traits = {"MurderousProwess", "Fearless", },
    
    ExitCareers = {"", },
    Goals = {"Survive"}, 
    
    Backgrounds = {"Any" },
    ExcludedBackgrounds = {"Slave", },
    SocialClasses = {"Gold", "Silver", "Bronze", },
    ExcludedGender = "Female",
  },
}
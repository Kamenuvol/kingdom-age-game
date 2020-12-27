-- @docconsts @{

ACCOUNT_TYPE_NORMAL = 1
ACCOUNT_TYPE_TUTOR = 2
ACCOUNT_TYPE_SENIORTUTOR = 3
ACCOUNT_TYPE_GAMEMASTER = 4
ACCOUNT_TYPE_GOD = 5

FloorHigher = 0
FloorLower = 15

CreatureTypePlayer = 0
CreatureTypeMonster = 1
CreatureTypeNpc = 2
CreatureTypeSummonOwn = 3
CreatureTypeSummonOther = 4

SkullNone = 0
SkullYellow = 1
SkullGreen = 2
SkullWhite = 3
SkullRed = 4
SkullBlack = 5
SkullOrange = 6
SkullProtected = 7

ShieldNone = 0
ShieldWhiteYellow = 1
ShieldWhiteBlue = 2
ShieldBlue = 3
ShieldYellow = 4
ShieldBlueSharedExp = 5
ShieldYellowSharedExp = 6
ShieldBlueNoSharedExpBlink = 7
ShieldYellowNoSharedExpBlink = 8
ShieldBlueNoSharedExp = 9
ShieldYellowNoSharedExp = 10
ShieldGray = 11
ShieldStr =
{
  [ShieldNone] = 'None',
  [ShieldWhiteYellow] = 'Inviter',
  [ShieldWhiteBlue] = 'Invitee',
  [ShieldBlue] = 'Partner',
  [ShieldYellow] = 'Leader',
  [ShieldGray] = 'Other member',
}
ShieldStr[ShieldBlueSharedExp] = ShieldStr[ShieldBlue]
ShieldStr[ShieldYellowSharedExp] = ShieldStr[ShieldYellow]
ShieldStr[ShieldBlueNoSharedExpBlink] = ShieldStr[ShieldBlue]
ShieldStr[ShieldYellowNoSharedExpBlink] = ShieldStr[ShieldYellow]
ShieldStr[ShieldBlueNoSharedExp] = ShieldStr[ShieldBlue]
ShieldStr[ShieldYellowNoSharedExp] = ShieldStr[ShieldYellow]
ShieldHierarchy = -- From most to less important
{
  [ShieldYellow]                 = 1,
  [ShieldYellowSharedExp]        = 2,
  [ShieldYellowNoSharedExpBlink] = 3,
  [ShieldYellowNoSharedExp]      = 4,
  [ShieldWhiteYellow]            = 5,

  [ShieldBlue]                   = 6,
  [ShieldBlueSharedExp]          = 7,
  [ShieldBlueNoSharedExpBlink]   = 8,
  [ShieldBlueNoSharedExp]        = 9,
  [ShieldWhiteBlue]              = 10,

  [ShieldGray]                   = 11,
  [ShieldNone]                   = 12,
}

EmblemNone = 0
EmblemGreen = 1
EmblemRed = 2
EmblemBlue = 3
EmblemMember = 4
EmblemOther = 5

VocationLearner = 0
VocationKnight = 1
VocationPaladin = 2
VocationArcher = 3
VocationAssassin = 4
VocationWizard = 5
VocationBard = 6
VocationStr =
{
  [VocationLearner] = 'Learner',
  [VocationKnight] = 'Knight',
  [VocationPaladin] = 'Paladin',
  [VocationArcher] = 'Archer',
  [VocationAssassin] = 'Assassin',
  [VocationWizard] = 'Wizard',
  [VocationBard] = 'Bard',
}

NpcIconNone = 0
NpcIconChat = 1
NpcIconTrade = 2
NpcIconQuest = 3
NpcIconTradeQuest = 4

SpecialIconNone = 0
SpecialIconWanted = 1

VipIconFirst = 0
VipIconLast = 10

Directions = {
  North = 0,
  East = 1,
  South = 2,
  West = 3,
  NorthEast = 4,
  SouthEast = 5,
  SouthWest = 6,
  NorthWest = 7
}

Skill = {
  Fist = 0,
  Club = 1,
  Sword = 2,
  Axe = 3,
  Distance = 4,
  Shielding = 5,
  Fishing = 6,
  CriticalChance = 7,
  CriticalDamage = 8,
  LifeLeechChance = 9,
  LifeLeechAmount = 10,
  ManaLeechChance = 11,
  ManaLeechAmount = 12
}

North = Directions.North
East = Directions.East
South = Directions.South
West = Directions.West
NorthEast = Directions.NorthEast
SouthEast = Directions.SouthEast
SouthWest = Directions.SouthWest
NorthWest = Directions.NorthWest

FightOffensive = 1
FightBalanced = 2
FightDefensive = 3

DontChase = 0
ChaseOpponent = 1

PVPWhiteDove = 0
PVPWhiteHand = 1
PVPYellowHand = 2
PVPRedFist = 3

GameProtocolChecksum = 1
GameAccountNames = 2
GameChallengeOnLogin = 3
GamePenalityOnDeath = 4
GameNameOnNpcTrade = 5
GameDoubleFreeCapacity = 6
GameDoubleExperience = 7
GameTotalCapacity = 8
GameSkillsBase = 9
GamePlayerRegenerationTime = 10
GameChannelPlayerList = 11
GamePlayerMounts = 12
GameEnvironmentEffect = 13
GameCreatureEmblems = 14
GameItemAnimationPhase = 15
GameMagicEffectU16 = 16
GamePlayerMarket = 17
GameSpritesU32 = 18
GameChargeableItems = 19
GameOfflineTrainingTime = 20
GamePurseSlot = 21
GameFormatCreatureName = 22
GameSpellList = 23
GameClientPing = 24
-- 25 free
GameDoubleHealth = 26
GameDoubleSkills = 27
GameChangeMapAwareRange = 28
GameMapMovePosition = 29
GameAttackSeq = 30
GameDiagonalAnimatedText = 31
GameLoginPending = 32
GameNewSpeedLaw = 33
GameForceFirstAutoWalkStep = 34
GameMinimapRemove = 35
GameDoubleShopSellAmount = 36
GameContainerPagination = 37
GameThingMarks = 38
GameLooktypeU16 = 39
GamePlayerStamina = 40
GamePlayerAddons = 41
GameMessageStatements = 42
GameMessageLevel = 43
GameNewFluids = 44
GamePlayerStateU16 = 45
GameNewOutfitProtocol = 46
GamePVPMode = 47
GameWritableDate = 48
GameAdditionalVipInfo = 49
GameSpritesAlphaChannel = 50
GamePremiumExpiration = 51
GameBrowseField = 52
GameEnhancedAnimations = 53
GameOGLInformation = 54
GameMessageSizeCheck = 55
GamePreviewState = 56
GameLoginPacketEncryption = 57
GameClientVersion = 58
GameContentRevision = 59
GameExperienceBonus = 60
GameAuthenticator = 61
GameUnjustifiedPointsPacket = 62
GameSessionKey = 63
GameDeathType = 64
GameIdleAnimations = 65
GameKeepUnawareTiles = 66
GameIngameStore = 67
GameIngameStoreHighlights = 68
GameIngameStoreServiceType = 69
GameAdditionalSkills = 70
GameBaseSkillU16 = 71
GameCreatureIcons = 72
GameHideNpcNames = 73

TextColors = {
  red         = '#f55e5e', --'#c83200'
  orange      = '#f36500', --'#c87832'
  lightYellow = '#e6db74',
  yellow      = '#ffff00', --'#e6c832'
  green       = '#00eb00', --'#3fbe32'
  lightblue   = '#5ff7f7',
  blue        = '#9f9dfd',
  --blue1     = '#6e50dc',
  --blue2     = '#3264c8',
  --blue3     = '#0096c8',
  white       = '#ffffff', --'#bebebe'
}

MessageModes = {
  None                    = 0,
  Say                     = 1,
  Whisper                 = 2,
  Yell                    = 3,
  PrivateFrom             = 4,
  PrivateTo               = 5,
  ChannelManagement       = 6,
  Channel                 = 7,
  ChannelHighlight        = 8,
  Spell                   = 9,
  NpcFrom                 = 10,
  NpcTo                   = 11,
  GamemasterBroadcast     = 12,
  GamemasterChannel       = 13,
  GamemasterPrivateFrom   = 14,
  GamemasterPrivateTo     = 15,
  Login                   = 16,
  Warning                 = 17,
  Game                    = 18,
  Failure                 = 19,
  Look                    = 20,
  DamageDealed            = 21,
  DamageReceived          = 22,
  Heal                    = 23,
  Exp                     = 24,
  DamageOthers            = 25,
  HealOthers              = 26,
  ExpOthers               = 27,
  Status                  = 28,
  Loot                    = 29,
  TradeNpc                = 30,
  Guild                   = 31,
  PartyManagement         = 32,
  Party                   = 33,
  BarkLow                 = 34,
  BarkLoud                = 35,
  Report                  = 36,
  HotkeyUse               = 37,
  TutorialHint            = 38,
  Thankyou                = 39,
  Market                  = 40,
  Mana                    = 41,
  BeyondLast              = 42,
  MonsterYell             = 43,
  MonsterSay              = 44,
  Red                     = 45,
  Blue                    = 46,
  --RVRChannel              = 47, -- Deprecated
  --RVRAnswer               = 48, -- Deprecated
  --RVRContinue             = 49, -- Deprecated
  GameHighlight           = 50,
  NpcFromStartBlock       = 51,
  Last                    = 52,
  MessageGameBigTop       = 53,
  MessageGameBigCenter    = 54,
  MessageGameBigBottom    = 55,
  Invalid                 = 255,
}

OTSERV_RSA  = "1091201329673994292788609605089955415282375029027981291234687579" ..
              "3726629149257644633073969600111060390723088861007265581882535850" ..
              "3429057592827629436413108566029093628212635953836686562675849720" ..
              "6207862794310902180176810615217550567108238764764442605581471797" ..
              "07119674283982419152118103759076030616683978566631413"

CIPSOFT_RSA = "1321277432058722840622950990822933849527763264961655079678763618" ..
              "4334395343554449668205332383339435179772895415509701210392836078" ..
              "6959821132214473291575712138800495033169914814069637740318278150" ..
              "2907336840325241747827401343576296990629870233111328210165697754" ..
              "88792221429527047321331896351555606801473202394175817"

-- set to the latest Tibia.pic signature to make otclient compatible with official tibia
PIC_SIGNATURE = 0x56C5DDE7

OsTypes = {
  Linux = 1,
  Windows = 2,
  Flash = 3,
  OtclientLinux = 10,
  OtclientWindows = 11,
  OtclientMac = 12,
}

PathFindResults = {
  Ok = 0,
  Position = 1,
  Impossible = 2,
  TooFar = 3,
  NoWay = 4,
}

PathFindFlags = {
  AllowNullTiles = 1,
  AllowCreatures = 2,
  AllowNonPathable = 4,
  AllowNonWalkable = 8,
}

VipState = {
  Offline = 0,
  Online = 1,
  Pending = 2,
}

ExtendedIds = {
  Activate = 0,
  Locale = 1,
  Ping = 2,
  Sound = 3,
  Game = 4,
  Particles = 5,
  MapShader = 6,
  NeedsUpdate = 7
}

PreviewState = {
  Default = 0,
  Inactive = 1,
  Active = 2
}

Blessings = {
  None = 0,
  Adventurer = 1,
  SpiritualShielding = 2,
  EmbraceOfTibia = 4,
  FireOfSuns = 8,
  WisdomOfSolitude = 16,
  SparkOfPhoenix = 32
}

DeathType = {
  Regular = 0,
  Blessed = 1
}

ProductType = {
  Other = 0,
  NameChange = 1
}

StoreErrorType = {
  NoError = -1,
  PurchaseError = 0,
  NetworkError = 1,
  HistoryError = 2,
  TransferError = 3,
  Information = 4
}

StoreState = {
  None = 0,
  New = 1,
  Sale = 2,
  Timed = 3
}

ChannelEvent = {
  Join = 0,
  Leave = 1,
  Invite = 2,
  Exclude = 3,
}

-- @}

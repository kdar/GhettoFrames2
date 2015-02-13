local frame = CreateFrame("FRAME")
frame:RegisterEvent("GROUP_ROSTER_UPDATE")
frame:RegisterEvent("PLAYER_TARGET_CHANGED")
frame:RegisterEvent("PLAYER_FOCUS_CHANGED")
frame:RegisterEvent("UNIT_FACTION")
LoadAddOn("Blizzard_ArenaUI")

local function eventHandler(self, event, ...)
  TargetFrameNameBackground:SetVertexColor(0, 0, 0, 0.0)
  TargetFrameNameBackground:SetHeight(18)
  FocusFrameNameBackground:SetVertexColor(0, 0, 0, 0.0)
  FocusFrameNameBackground:SetHeight(18)
  TargetFrameBackground:SetHeight(41)
  FocusFrameBackground:SetHeight(41)
end

frame:SetScript("OnEvent", eventHandler)
PlayerFrameTexture:SetTexture("Interface\\AddOns\\GhettoFrames2\\TargetingFrame\\UI-TargetingFrame")
hooksecurefunc ("TargetFrame_CheckClassification", function(self, forceNormalTexture)
  local classification = UnitClassification(self.unit) ;
  --[[
  self.nameBackground:Show();
  self.manabar:Show();
  self.manabar.TextString:Show();
  self.threatIndicator:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Flash");
  ]]--
  if (forceNormalTexture) then
    self.borderTexture:SetTexture("Interface\\AddOns\\GhettoFrames2\\TargetingFrame\\UI-TargetingFrame") ;
  elseif (classification == "minus") then
    self.borderTexture:SetTexture("Interface\\AddOns\\GhettoFrames2\\TargetingFrame\\UI-TargetingFrame-Minus") ;
    self.nameBackground:Hide() ;
    self.manabar:Hide() ;
    self.manabar.TextString:Hide() ;
    forceNormalTexture = true;
  elseif (classification == "worldboss" or classification == "elite") then
    self.borderTexture:SetTexture("Interface\\AddOns\\GhettoFrames2\\TargetingFrame\\UI-TargetingFrame-Elite") ;
  elseif (classification == "rareelite") then
    self.borderTexture:SetTexture("Interface\\AddOns\\GhettoFrames2\\TargetingFrame\\UI-TargetingFrame-Rare-Elite") ;
  elseif (classification == "rare") then
    self.borderTexture:SetTexture("Interface\\AddOns\\GhettoFrames2\\TargetingFrame\\UI-TargetingFrame-Rare") ;
  else
    self.borderTexture:SetTexture("Interface\\AddOns\\GhettoFrames2\\TargetingFrame\\UI-TargetingFrame") ;
    forceNormalTexture = true;
  end
end)

--TEST Pet
hooksecurefunc("PetFrame_Update", function(self, override)
  if ((not PlayerFrame.animating) or (override)) then
    if (UnitIsVisible(self.unit) and PetUsesPetFrame() and not PlayerFrame.vehicleHidesPet) then
      if (self:IsShown()) then
        UnitFrame_Update(self) ;
      else
        self:Show() ;
      end
      --self.flashState = 1;
      --self.flashTimer = PET_FLASH_ON_TIME;
      if (UnitPowerMax(self.unit) == 0) then
        PetFrameTexture:SetTexture("Interface\\AddOns\\GhettoFrames2\\TargetingFrame\\UI-SmallTargetingFramex-NoMana") ;
        PetFrameManaBarText:Hide() ;
      else
        PetFrameTexture:SetTexture("Interface\\AddOns\\GhettoFrames2\\TargetingFrame\\UI-SmallTargetingFramex") ;
      end
      PetAttackModeTexture:Hide() ;

      RefreshDebuffs(self, self.unit, nil, nil, true) ;
    else
      self:Hide() ;
    end
  end
end)

--castbar
--[[
CastingBarFrame:ClearAllPoints()
CastingBarFrame:SetPoint("CENTER",UIParent,"CENTER", 0, -250)
CastingBarFrame.SetPoint = function() end
]]--
--Hideshit

PetName:ClearAllPoints()
PetName:SetPoint("CENTER", PetFrame, "CENTER", 14, 19)
PetName.SetPoint = function() end

PlayerPVPIcon:SetAlpha(0)
TargetFrameTextureFramePVPIcon:SetAlpha(0)
FocusFrameTextureFramePVPIcon:SetAlpha(0)

hooksecurefunc(PlayerPVPTimerText, "SetFormattedText", function(self)
  self.timeLeft = nil
  self:Hide()
end)

local noop = function() return end
for _, objname in ipairs({
    "PlayerAttackGlow",
    "PetAttackModeTexture",
    "PlayerRestGlow",
    "PlayerRestIcon",
    "PlayerStatusGlow",
    "PlayerStatusTexture",
    "PlayerAttackBackground",
    "PlayerFrameGroupIndicator",
    "PlayerFrameFlash",
    "TargetFrameFlash",
    "FocusFrameFlash",
    "PetFrameFlash",
    "PlayerFrameRoleIcon",

  }) do
  local obj = _G[objname]
  if obj then
    obj:Hide()
    obj.Show = noop
  end
end

--ToT move
TargetFrameToT:ClearAllPoints()
TargetFrameToT:SetPoint("CENTER", TargetFrame, "CENTER", 60, -45)

FocusFrameToT:ClearAllPoints()
FocusFrameToT:SetPoint("CENTER", FocusFrame, "CENTER", 60, -45)

--Names
TargetFrame.name:ClearAllPoints()
TargetFrame.name:SetPoint("CENTER", TargetFrame, "CENTER", -50, 35)
TargetFrame.name.SetPoint = function() end
FocusFrame.name:ClearAllPoints()
FocusFrame.name:SetPoint("CENTER", FocusFrame, "CENTER", -45, 35)
FocusFrame.name.SetPoint = function() end

--bars
--Player bars
PlayerFrameHealthBar:SetHeight(27)
PlayerFrameHealthBar:ClearAllPoints()
PlayerFrameHealthBar:SetPoint("CENTER", PlayerFrame, "CENTER", 50, 14)
PlayerFrameHealthBar.SetPoint = function() end

PlayerFrameManaBar:ClearAllPoints()
PlayerFrameManaBar:SetPoint("CENTER", PlayerFrame, "CENTER", 51, -7)
PlayerFrameManaBar.SetPoint = function() end

--Player Pet bars
PetFrameHealthBar:SetHeight(13)
PetFrameHealthBar:ClearAllPoints()
PetFrameHealthBar:SetPoint("CENTER", PetFrame, "CENTER", 16, 5)
PetFrameHealthBar.SetPoint = function() end

PetFrameManaBar:ClearAllPoints()
PetFrameManaBar:SetPoint("CENTER", PetFrame, "CENTER", 16, -7)
PetFrameManaBar.SetPoint = function() end

PetFrameHealthBar.TextString:ClearAllPoints()
PetFrameHealthBar.TextString:SetPoint("CENTER", PetFrameHealthBar, "CENTER", 0, 0)
PetFrameHealthBar.TextString.SetPoint = function() end
PetFrameManaBar.TextString:ClearAllPoints()
PetFrameManaBar.TextString:SetPoint("CENTER", PetFrameManaBar, "CENTER", 0, 0)
PetFrameManaBar.TextString.SetPoint = function() end

--Target bars
TargetFrameHealthBar:SetHeight(27)
TargetFrameHealthBar:ClearAllPoints()
TargetFrameHealthBar:SetPoint("CENTER", TargetFrame, "CENTER", -50, 14)
TargetFrameHealthBar.SetPoint = function() end

TargetFrameTextureFrameDeadText:ClearAllPoints()
TargetFrameTextureFrameDeadText:SetPoint("CENTER", TargetFrameHealthBar, "CENTER", 0, 0)
TargetFrameTextureFrameDeadText.SetPoint = function() end

TargetFrameManaBar:ClearAllPoints()
TargetFrameManaBar:SetPoint("CENTER", TargetFrame, "CENTER", -51, -7)
TargetFrameManaBar.SetPoint = function() end

TargetFrameNumericalThreat:SetScale(0.9)
TargetFrameNumericalThreat:ClearAllPoints()
TargetFrameNumericalThreat:SetPoint("CENTER", TargetFrame, "CENTER", 44, 48)
TargetFrameNumericalThreat.SetPoint = function() end

--Focus bars
FocusFrameHealthBar:SetHeight(27)
FocusFrameHealthBar:ClearAllPoints()
FocusFrameHealthBar:SetPoint("CENTER", FocusFrame, "CENTER", -50, 14)
FocusFrameHealthBar.SetPoint = function() end

FocusFrameTextureFrameDeadText:ClearAllPoints()
FocusFrameTextureFrameDeadText:SetPoint("CENTER", FocusFrameHealthBar, "CENTER", 0, 0)
FocusFrameTextureFrameDeadText.SetPoint = function() end

FocusFrameManaBar:ClearAllPoints()
FocusFrameManaBar:SetPoint("CENTER", FocusFrame, "CENTER", -51, -7)
FocusFrameManaBar.SetPoint = function() end

FocusFrameNumericalThreat:ClearAllPoints()
FocusFrameNumericalThreat:SetPoint("CENTER", FocusFrame, "CENTER", 44, 48)
FocusFrameNumericalThreat.SetPoint = function() end

--Textstrings
--Fonts
PlayerFrameHealthBar.TextString:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE")
TargetFrameHealthBar.TextString:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE")
FocusFrameHealthBar.TextString:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE")
TargetFrameManaBar.TextString:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE")
PlayerFrameManaBar.TextString:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE")
FocusFrameManaBar.TextString:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE")

TargetFrameHealthBar.TextString:ClearAllPoints()
TargetFrameHealthBar.TextString:SetPoint("CENTER", TargetFrame, "CENTER", -53, 12)
TargetFrameHealthBar.TextString.SetPoint = function() end

PlayerFrameHealthBar.TextString:ClearAllPoints()
PlayerFrameHealthBar.TextString:SetPoint("CENTER", PlayerFrame, "CENTER", 53, 12)
PlayerFrameHealthBar.TextString.SetPoint = function() end

FocusFrameHealthBar.TextString:ClearAllPoints()
FocusFrameHealthBar.TextString:SetPoint("CENTER", FocusFrame, "CENTER", -53, 12)
FocusFrameHealthBar.TextString.SetPoint = function() end

PlayerFrameManaBar.TextString:ClearAllPoints()
PlayerFrameManaBar.TextString:SetPoint("CENTER", PlayerFrame, "CENTER", 53, -7)
PlayerFrameManaBar.TextString.SetPoint = function() end

TargetFrameManaBar.TextString:ClearAllPoints()
TargetFrameManaBar.TextString:SetPoint("CENTER", TargetFrame, "CENTER", -50, -7)
TargetFrameManaBar.TextString.SetPoint = function() end

FocusFrameManaBar.TextString:ClearAllPoints()
FocusFrameManaBar.TextString:SetPoint("CENTER", FocusFrame, "CENTER", -50, -7)
FocusFrameManaBar.TextString.SetPoint = function() end

--Resource Format
FrameList = {"Target", "Focus", "Player"}
hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", function(statusFrame, textString, value, valueMin, valueMax)
  for i = 1, select("#", unpack(FrameList)) do
    local FrameName = (select(i, unpack(FrameList)))
    if (UnitPowerType(FrameName) == 0) then --mana
      _G[FrameName .. "FrameManaBar"].TextString:SetText(string.format("%.0f%%", (UnitMana(FrameName) / UnitManaMax(FrameName)) * 100))
    elseif (UnitPowerType(FrameName) == 1 or UnitPowerType(FrameName) == 2 or UnitPowerType(FrameName) == 3 or UnitPowerType(FrameName) == 6) then
      _G[FrameName .. "FrameManaBar"].TextString:SetText(AbbreviateLargeNumbers(UnitMana(FrameName)))
    end
    if (UnitManaMax(FrameName) == 0) then
      _G[FrameName .. "FrameManaBar"].TextString:SetText(" ")
    end
  end

end)

GhettoFrames2 = {};
GhettoFrames2.panel = CreateFrame("Frame", "GhettoFrames2", UIParent) ;
GhettoFrames2.panel.name = "GhettoFrames2";
InterfaceOptions_AddCategory(GhettoFrames2.panel) ;

GhettoFrames2.childpanel = CreateFrame("Frame", "General", GhettoFrames2.panel) ;
GhettoFrames2.childpanel.name = "General";
GhettoFrames2.childpanel.parent = GhettoFrames2.panel.name;
InterfaceOptions_AddCategory(GhettoFrames2.childpanel) ;

GhettoFrames2.childpanel = CreateFrame("Frame", "GhettoPlayerFrame", GhettoFrames2.panel) ;
GhettoFrames2.childpanel.name = "Player Frame Settings";
GhettoFrames2.childpanel.parent = GhettoFrames2.panel.name;
InterfaceOptions_AddCategory(GhettoFrames2.childpanel) ;

GhettoFrames2.childpanel = CreateFrame("Frame", "TargetCastbar", GhettoFrames2.panel) ;
GhettoFrames2.childpanel.name = "Target Frame Settings";
GhettoFrames2.childpanel.parent = GhettoFrames2.panel.name;
InterfaceOptions_AddCategory(GhettoFrames2.childpanel) ;

GhettoFrames2.childpanel = CreateFrame("Frame", "GhettoFocusFrame", GhettoFrames2.panel) ;
GhettoFrames2.childpanel.name = "Focus Frame Settings";
GhettoFrames2.childpanel.parent = GhettoFrames2.panel.name;
InterfaceOptions_AddCategory(GhettoFrames2.childpanel) ;

GhettoFrames2.childpanel = CreateFrame("Frame", "GhettoPetFrame", GhettoFrames2.panel) ;
GhettoFrames2.childpanel.name = "Pet Frame Settings";
GhettoFrames2.childpanel.parent = GhettoFrames2.panel.name;
InterfaceOptions_AddCategory(GhettoFrames2.childpanel) ;

GhettoFrames2.childpanel = CreateFrame("Frame", "GhettoArenaFrame", GhettoFrames2.panel) ;
GhettoFrames2.childpanel.name = "Arena Frames Settings";
GhettoFrames2.childpanel.parent = GhettoFrames2.panel.name;
InterfaceOptions_AddCategory(GhettoFrames2.childpanel) ;

GhettoFrames2.childpanel = CreateFrame("Frame", "GhettoPartyFrame", GhettoFrames2.panel) ;
GhettoFrames2.childpanel.name = "Party Frames Settings";
GhettoFrames2.childpanel.parent = GhettoFrames2.panel.name;
InterfaceOptions_AddCategory(GhettoFrames2.childpanel) ;

SlashCmdList.GhettoFrames2 = function()
  InterfaceOptionsFrame_OpenToCategory(GhettoFrames2.panel)
  InterfaceOptionsFrame_OpenToCategory(GhettoFrames2.panel)
end
SLASH_GhettoFrames21 = "/ghettoframes"
SLASH_GhettoFrames21 = "/gf"

-----------------------------
---##ADDON RELATED STUFF##---
-----------------------------

GhettoFrames2SaveX = {
  ["castby"] = 55,
  ["fcastbx"] = -195,
  ["palaspecialx"] = 0,
  ["targetoffocus"] = true,
  ["classcolorttot"] = true,
  ["classcolorftot"] = true,
  ["castbx"] = -15,
  ["classcolorparty"] = true,
  ["playername"] = true,
  ["palaspecialy"] = 0,
  ["fcastby"] = 0,
  ["classcolortarget"] = true,
  ["framescaletarget"] = 1.176947474479675,
  ["specialx"] = 0,
  ["framescalefocus"] = 1.176947474479675,
  ["classcolorFocus"] = true,
  ["specialy"] = 0,
  ["monkspecialx"] = 0,
  ["framescaleplayer"] = 1.176947474479675,
  ["targetoftarget"] = true,
  ["classcolorarena"] = true,
  ["monkspecialy"] = 0,
  ["classcolor"] = true,
  ["playerspecialbar"] = true,
  ["classportraits"] = false,
  ["playerhitindi"] = true,
  ["bartex"] = 4,
  ["classcolorplayer"] = true,
  ["darkentextures"] = 0.9,
  ["hformat"] = 5,
  ["buffsy"] = 10
}

GhettoFrames2SaveX.darkentextures = 0.9;

unserAddon = {}

-- function to initialize when addon has loaded
function unserAddon:Init(event, addon)
  if (event == "ADDON_LOADED" and addon == "GhettoFrames2") then

    print("|cff71C671GhettoFrames2|cffbbbbbb loaded. Options: |cff71C671/gf")

    unserAddon:CreateGUI(unserFrameAddon)
    if (GhettoFrames2SaveX.castbx ~= 0 or GhettoFrames2SaveX.castby ~= 0) then
      TargetFrameSpellBar:ClearAllPoints()
      TargetFrameSpellBar:SetPoint("CENTER", TargetFrame, "CENTER", GhettoFrames2SaveX.castbx, GhettoFrames2SaveX.castby)
      TargetFrameSpellBar.SetPoint = function() end
    end
    if (GhettoFrames2SaveX.framescaletarget and GhettoFrames2SaveX.framescaletarget ~= 1) then
      TargetFrame:SetScale(GhettoFrames2SaveX.framescaletarget)
    end
    if (GhettoFrames2SaveX.framescalefocus and GhettoFrames2SaveX.framescalefocus ~= 1) then
      FocusFrame:SetScale(GhettoFrames2SaveX.framescalefocus)
    end
    if (GhettoFrames2SaveX.framescaleplayer and GhettoFrames2SaveX.framescaleplayer ~= 1) then
      PlayerFrame:SetScale(GhettoFrames2SaveX.framescaleplayer)
    end
    if (GhettoFrames2SaveX.darkentextures and GhettoFrames2SaveX.darkentextures ~= 1) then

      for i, v in pairs({PlayerFrameTexture, TargetFrameTextureFrameTexture, PetFrameTexture, PartyMemberFrame1Texture, PartyMemberFrame2Texture, PartyMemberFrame3Texture, PartyMemberFrame4Texture,
          PartyMemberFrame1PetFrameTexture, PartyMemberFrame2PetFrameTexture, PartyMemberFrame3PetFrameTexture, PartyMemberFrame4PetFrameTexture, FocusFrameTextureFrameTexture,
          TargetFrameToTTextureFrameTexture, FocusFrameToTTextureFrameTexture
        }) do
        v:SetVertexColor(GhettoFrames2SaveX.darkentextures, GhettoFrames2SaveX.darkentextures, GhettoFrames2SaveX.darkentextures)
      end
    end

    if (GhettoFrames2SaveX.fcastbx ~= 0 or GhettoFrames2SaveX.fcastby ~= 0) then
      FocusFrameSpellBar:ClearAllPoints()
      FocusFrameSpellBar:SetPoint("CENTER", FocusFrame, "CENTER", GhettoFrames2SaveX.fcastbx, GhettoFrames2SaveX.fcastby)
      FocusFrameSpellBar.SetPoint = function() end
    end
    if (GhettoFrames2SaveX.specialx ~= 0 or GhettoFrames2SaveX.specialy ~= 0 or GhettoFrames2SaveX.monkspecialy ~= 0 or GhettoFrames2SaveX.monkspecialx ~= 0 or GhettoFrames2SaveX.palaspecialy ~= 0 or GhettoFrames2SaveX.palaspecialx ~= 0) then
      --[[ShardBarFrame:ClearAllPoints()
      ShardBarFrame:SetPoint("CENTER", PlayerFrame, "CENTER", GhettoFrames2SaveX.specialx,GhettoFrames2SaveX.specialy)
      ShardBarFrame.SetPoint = function() end
      PriestBarFrame:ClearAllPoints()
      PriestBarFrame:SetPoint("CENTER", PlayerFrame, "CENTER", GhettoFrames2SaveX.monkspecialx,GhettoFrames2SaveX.specialy)
      PriestBarFrame.SetPoint = function() end
      MonkHarmonyBar:ClearAllPoints()
      MonkHarmonyBar:SetPoint("CENTER", PlayerFrame, "CENTER", GhettoFrames2SaveX.monkspecialx,GhettoFrames2SaveX.monkspecialy)
      MonkHarmonyBar.SetPoint = function() end
      PaladinPowerBar:ClearAllPoints()
      PaladinPowerBar:SetPoint("CENTER", PlayerFrame, "CENTER", GhettoFrames2SaveX.palaspecialx,GhettoFrames2SaveX.palaspecialy)
      PaladinPowerBar.SetPoint = function() end
      --]]

      PetFrame:ClearAllPoints()
      PetFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", 80, -65) ;
      PetFrame.SetPoint = function() end
      PlayerName:ClearAllPoints()
      PlayerName:SetPoint("CENTER", PlayerFrame, "CENTER", 45, 60)
      PlayerName.SetPoint = function() end
      -- Following part is taken from Spyro_'s "ResourcesOnTop"
      local function yOffset(Frame, Offset)
        local P = {Frame:GetPoint()}
        Frame:SetPoint(P[1], P[2], P[3], P[4], Offset)
      end
      local function yInvertTexture(Texture)
        local Left, Top, _, Bottom, Right = Texture:GetTexCoord()
        Texture:SetTexCoord(Left, Right, Bottom, Top) -- Swapping parameters 3 & 4 (top & bottom)
      end
      local function yInvertAllTextures(Frame)
        for _, Region in pairs({Frame:GetRegions()}) do
          if Region:GetObjectType() == "Texture" then yInvertTexture(Region) end
        end
      end

      -- Evento PLAYER_LOGIN
      -- Fires after PLAYER_ENTERING_WORLD after logging in and after /reloadui.

      -- Paladin Holy Power
      yOffset(PaladinPowerBar, 111)
      yOffset(PaladinPowerBarRune1, -5)
      yOffset(PaladinPowerBarRune4, 3)
      yOffset(PaladinPowerBarRune5, 3)
      yOffset(PaladinPowerBarBankBG, 7)
      yInvertAllTextures(PaladinPowerBar)
      yInvertTexture(PaladinPowerBarGlowBGTexture)
      for i = 1, 5 do yInvertTexture(_G["PaladinPowerBarRune" .. i .. "Texture"]) end

      -- Priest Shadow Orbs
      yOffset(PriestBarFrame, 131)
      yOffset(PriestBarFrameOrb1, -16)
      yInvertAllTextures(PriestBarFrame)
      for i = 1, 3 do
        yInvertAllTextures(_G["PriestBarFrameOrb" .. i])
        yOffset(_G["PriestBarFrameOrb" .. i].highlight, 8)
      end

      -- Warlock Shards
      yOffset(ShardBarFrame, 69)
      for i = 1, 4 do
        yInvertAllTextures(_G["ShardBarFrameShard" .. i])
        yOffset(_G["ShardBarFrameShard" .. i].shardFill, -5)
      end

      -- Warlock Burning Embers
      yOffset(BurningEmbersBarFrame, 63)
      yOffset(BurningEmbersBarFrameEmber1, 14)
      yInvertTexture(BurningEmbersBarFrame.background)
      for i = 1, 4 do yInvertAllTextures(_G["BurningEmbersBarFrameEmber" .. i]) end

      -- Warlock Demonic Fury
      yOffset(DemonicFuryBarFrame, 82)

      -- DK Runes
      yOffset(RuneFrame, 99)

      -- Druid Eclipse
      yOffset(EclipseBarFrame, 108)

      -- Druid/Monk AlternatePowerBar
      yInvertAllTextures(PlayerFrameAlternateManaBar)
      yOffset(PlayerFrameAlternateManaBar, 79)
      yOffset(PlayerFrameAlternateManaBar.DefaultBorder, 4)
      yOffset(PlayerFrameAlternateManaBar.MonkBorder, 4)
      yOffset(PlayerFrameAlternateManaBar.MonkBackground, 4)
      local Offset = 79
      if MonkHarmonyBar:IsShown() then Offset = 100 end
      hooksecurefunc(PlayerFrameAlternateManaBar, "SetPoint", function(Bar) yOffset(Bar, Offset) end)

      -- Monk Chi
      yOffset(MonkHarmonyBar, 20)
      yInvertAllTextures(MonkHarmonyBar)
      for i = 1, 4 do yInvertAllTextures(_G["MonkHarmonyBarLightEnergy" .. i]) end

      -- Monk Stagger Bar
      yOffset(MonkStaggerBarText, -4)
      yInvertAllTextures(MonkStaggerBar)
      hooksecurefunc(MonkStaggerBar, "SetPoint", function(Bar) yOffset(Bar, 104) end)

      -- Shaman Totems / Warrior Banners
      yOffset(TotemFrame, 112)
      for i = 1, 4 do
        yOffset(_G["TotemFrameTotem" .. i .. "Duration"], 44)
        yInvertTexture(select(2, _G["TotemFrameTotem" .. i]:GetChildren()):GetRegions())
      end
    else
      PlayerName:ClearAllPoints()
      PlayerName:SetPoint("CENTER", PlayerFrame, "CENTER", 50, 35)
      PlayerName.SetPoint = function() end
    end

    if (GhettoFrames2SaveX.percentcolorplayer) then
      PlayerPercentcolorcheck:SetChecked(true)
    end
    if (GhettoFrames2SaveX.percentcolortarget) then
      TargetPercentcolorcheck:SetChecked(true)
    end
    if (GhettoFrames2SaveX.percentcolorfocus) then
      FocusPercentcolorcheck:SetChecked(true)
    end
    if (GhettoFrames2SaveX.percentcolorarena) then
      ArenaPercentcolorcheck:SetChecked(true)
    end
    if (GhettoFrames2SaveX.percentcolorparty) then
      PartyPercentcolorcheck:SetChecked(true)
    end
    if (GhettoFrames2SaveX.percentcolorpet) then
      PetPercentcolorcheck:SetChecked(true)
    end
    if (GhettoFrames2SaveX.percentcolortargettot) then
      TargetToTPercentcolorcheck:SetChecked(true)
    end
    if (GhettoFrames2SaveX.percentcolorfocustot) then
      FocusToTPercentcolorcheck:SetChecked(true)
    end

    if (GhettoFrames2SaveX.classcolor) then
      classcolorcheck:SetChecked(true)

      local function colour(statusbar, unit)
        if (unit ~= mouseover) then
          local _, class, c

          local value = UnitHealth(unit) ;
          local min, max = statusbar:GetMinMaxValues() ;

          local r, g, b;

          if ((value < min) or (value > max)) then
            return;
          end
          if ((max - min) > 0) then
            value = (value - min) / (max - min) ;
          else
            value = 0;
          end
          if(value > 0.5) then
            r = (1.0 - value) * 2;
            g = 1.0;
          else
            r = 1.0;
            g = value * 2;
          end
          b = 0.0;

          if (UnitIsPlayer(unit) and UnitIsConnected(unit) and unit == statusbar.unit and UnitClass(unit)) then

            _, class = UnitClass(unit)
            c = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class] or RAID_CLASS_COLORS[class]
            statusbar:SetStatusBarColor(c.r, c.g, c.b)
            if (not GhettoFrames2SaveX.classcolortarget) then
              if (GhettoFrames2SaveX.percentcolortarget) then
                if (statusbar == TargetFrameHealthBar) then
                  TargetFrameHealthBar:SetStatusBarColor(r, g, b) ;
                end
              else
                if (statusbar == TargetFrameHealthBar) then
                  if (not UnitIsFriend("player", unit)) then
                    if (GhettoFrames2SaveX.colorpickfriendr and GhettoFrames2SaveX.colorpickfriendg and GhettoFrames2SaveX.colorpickfriendb) then
                      TargetFrameHealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickfriendr, GhettoFrames2SaveX.colorpickfriendg, GhettoFrames2SaveX.colorpickfriendb)
                    else
                      TargetFrameHealthBar:SetStatusBarColor(1, 0, 0)
                    end
                  end
                  if (UnitIsFriend("player", unit)) then
                    if (GhettoFrames2SaveX.colorpickenemyr and GhettoFrames2SaveX.colorpickenemyg and GhettoFrames2SaveX.colorpickenemyb) then
                      TargetFrameHealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickenemyr, GhettoFrames2SaveX.colorpickenemyg, GhettoFrames2SaveX.colorpickenemyb)
                    else
                      TargetFrameHealthBar:SetStatusBarColor(0, 1, 0)
                    end
                  end
                end
              end
            else
              targetclasscolorcheck:SetChecked(true)
            end
            if (not GhettoFrames2SaveX.classcolorplayer) then
              if (GhettoFrames2SaveX.percentcolorplayer) then

                if (statusbar == PlayerFrameHealthBar) then
                  PlayerFrameHealthBar:SetStatusBarColor(r, g, b) ;
                end
              else
                if (statusbar == PlayerFrameHealthBar) then
                  if (GhettoFrames2SaveX.colorpickenemyr and GhettoFrames2SaveX.colorpickenemyg and GhettoFrames2SaveX.colorpickenemyb) then
                    PlayerFrameHealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickenemyr, GhettoFrames2SaveX.colorpickenemyg, GhettoFrames2SaveX.colorpickenemyb)
                  else
                    PlayerFrameHealthBar:SetStatusBarColor(0, 1, 0)
                  end
                end
              end

            else
              PlayerClasscolorcheck:SetChecked(true)
            end

            if (not GhettoFrames2SaveX.classcolorFocus) then
              if (GhettoFrames2SaveX.percentcolorfocus) then

                if (statusbar == FocusFrameHealthBar) then
                  FocusFrameHealthBar:SetStatusBarColor(r, g, b) ;
                end
              else
                if (statusbar == FocusFrameHealthBar) then
                  if (not UnitIsFriend("player", unit)) then
                    if (GhettoFrames2SaveX.colorpickfriendr and GhettoFrames2SaveX.colorpickfriendg and GhettoFrames2SaveX.colorpickfriendb) then
                      FocusFrameHealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickfriendr, GhettoFrames2SaveX.colorpickfriendg, GhettoFrames2SaveX.colorpickfriendb)
                    else
                      FocusFrameHealthBar:SetStatusBarColor(1, 0, 0)
                    end
                  end
                  if (UnitIsFriend("player", unit)) then
                    if (GhettoFrames2SaveX.colorpickenemyr and GhettoFrames2SaveX.colorpickenemyg and GhettoFrames2SaveX.colorpickenemyb) then
                      FocusFrameHealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickenemyr, GhettoFrames2SaveX.colorpickenemyg, GhettoFrames2SaveX.colorpickenemyb)
                    else
                      FocusFrameHealthBar:SetStatusBarColor(0, 1, 0)
                    end
                  end
                end
              end
            else
              focusclasscolorcheck:SetChecked(true)
            end
            if (not GhettoFrames2SaveX.classcolorarena) then
              if (GhettoFrames2SaveX.percentcolorarena) then

                if (statusbar == ArenaEnemyFrame1HealthBar) then
                  ArenaEnemyFrame1HealthBar:SetStatusBarColor(r, g, b) ;
                end
                if (statusbar == ArenaEnemyFrame2HealthBar) then
                  ArenaEnemyFrame2HealthBar:SetStatusBarColor(r, g, b) ;
                end
                if (statusbar == ArenaEnemyFrame3HealthBar) then
                  ArenaEnemyFrame3HealthBar:SetStatusBarColor(r, g, b) ;
                end
                if (statusbar == ArenaEnemyFrame4HealthBar) then
                  ArenaEnemyFrame4HealthBar:SetStatusBarColor(r, g, b) ;
                end
                if (statusbar == ArenaEnemyFrame5HealthBar) then
                  ArenaEnemyFrame5HealthBar:SetStatusBarColor(r, g, b) ;
                end

              else
                if (GhettoFrames2SaveX.colorpickfriendr and GhettoFrames2SaveX.colorpickfriendg and GhettoFrames2SaveX.colorpickfriendb) then
                  if (statusbar == ArenaEnemyFrame1HealthBar) then
                    ArenaEnemyFrame1HealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickfriendr, GhettoFrames2SaveX.colorpickfriendg, GhettoFrames2SaveX.colorpickfriendb)
                  end
                  if (statusbar == ArenaEnemyFrame2HealthBar) then
                    ArenaEnemyFrame2HealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickfriendr, GhettoFrames2SaveX.colorpickfriendg, GhettoFrames2SaveX.colorpickfriendb)
                  end
                  if (statusbar == ArenaEnemyFrame3HealthBar) then
                    ArenaEnemyFrame3HealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickfriendr, GhettoFrames2SaveX.colorpickfriendg, GhettoFrames2SaveX.colorpickfriendb)
                  end
                  if (statusbar == ArenaEnemyFrame4HealthBar) then
                    ArenaEnemyFrame4HealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickfriendr, GhettoFrames2SaveX.colorpickfriendg, GhettoFrames2SaveX.colorpickfriendb)
                  end
                  if (statusbar == ArenaEnemyFrame5HealthBar) then
                    ArenaEnemyFrame5HealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickfriendr, GhettoFrames2SaveX.colorpickfriendg, GhettoFrames2SaveX.colorpickfriendb)
                  end
                else
                  if (statusbar == ArenaEnemyFrame1HealthBar) then
                    ArenaEnemyFrame1HealthBar:SetStatusBarColor(1, 0, 0)
                  end
                  if (statusbar == ArenaEnemyFrame2HealthBar) then
                    ArenaEnemyFrame2HealthBar:SetStatusBarColor(1, 0, 0)
                  end
                  if (statusbar == ArenaEnemyFrame3HealthBar) then
                    ArenaEnemyFrame3HealthBar:SetStatusBarColor(1, 0, 0)
                  end
                  if (statusbar == ArenaEnemyFrame4HealthBar) then
                    ArenaEnemyFrame4HealthBar:SetStatusBarColor(1, 0, 0)
                  end
                  if (statusbar == ArenaEnemyFrame5HealthBar) then
                    ArenaEnemyFrame5HealthBar:SetStatusBarColor(1, 0, 0)
                  end
                end
              end
            else
              arenaclasscolorcheck:SetChecked(true)
            end

            if (not GhettoFrames2SaveX.classcolorparty) then
              if (GhettoFrames2SaveX.percentcolorparty) then

                if (statusbar == PartyMemberFrame1HealthBar) then
                  PartyMemberFrame1HealthBar:SetStatusBarColor(r, g, b) ;
                end
                if (statusbar == PartyMemberFrame2HealthBar) then
                  PartyMemberFrame2HealthBar:SetStatusBarColor(r, g, b) ;
                end
                if (statusbar == PartyMemberFrame3HealthBar) then
                  PartyMemberFrame3HealthBar:SetStatusBarColor(r, g, b) ;
                end
                if (statusbar == PartyMemberFrame4HealthBar) then
                  PartyMemberFrame4HealthBar:SetStatusBarColor(r, g, b) ;
                end
                if (statusbar == PartyMemberFrame5HealthBar) then
                  PartyMemberFrame5HealthBar:SetStatusBarColor(r, g, b) ;
                end

              else
                if (GhettoFrames2SaveX.colorpickenemyr and GhettoFrames2SaveX.colorpickenemyr and GhettoFrames2SaveX.colorpickenemyr) then
                  if (statusbar == PartyMemberFrame1HealthBar) then
                    PartyMemberFrame1HealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickenemyr, GhettoFrames2SaveX.colorpickenemyr, GhettoFrames2SaveX.colorpickenemyr)
                  end
                  if (statusbar == PartyMemberFrame2HealthBar) then
                    PartyMemberFrame2HealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickenemyr, GhettoFrames2SaveX.colorpickenemyg, GhettoFrames2SaveX.colorpickenemyb)
                  end
                  if (statusbar == PartyMemberFrame3HealthBar) then
                    PartyMemberFrame3HealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickenemyr, GhettoFrames2SaveX.colorpickenemyg, GhettoFrames2SaveX.colorpickenemyb)
                  end
                  if (statusbar == PartyMemberFrame4HealthBar) then
                    PartyMemberFrame4HealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickenemyr, GhettoFrames2SaveX.colorpickenemyg, GhettoFrames2SaveX.colorpickenemyb)
                  end

                else
                  if (statusbar == PartyMemberFrame1HealthBar) then
                    PartyMemberFrame1HealthBar:SetStatusBarColor(0, 1, 0)
                  end
                  if (statusbar == PartyMemberFrame2HealthBar) then
                    PartyMemberFrame2HealthBar:SetStatusBarColor(0, 1, 0)
                  end
                  if (statusbar == PartyMemberFrame3HealthBar) then
                    PartyMemberFrame3HealthBar:SetStatusBarColor(0, 1, 0)
                  end
                  if (statusbar == PartyMemberFrame4HealthBar) then
                    PartyMemberFrame4HealthBar:SetStatusBarColor(0, 1, 0)
                  end

                end
              end
            else
              partyclasscolorcheck:SetChecked(true)
            end

            if (not GhettoFrames2SaveX.classcolorttot) then
              if (GhettoFrames2SaveX.percentcolortargettot) then

                if (statusbar == TargetFrameToTHealthBar) then
                  TargetFrameToTHealthBar:SetStatusBarColor(r, g, b) ;
                end
              else
                if (statusbar == TargetFrameToTHealthBar) then
                  if (not UnitIsFriend("player", unit)) then
                    if (GhettoFrames2SaveX.colorpickfriendr and GhettoFrames2SaveX.colorpickfriendg and GhettoFrames2SaveX.colorpickfriendb) then
                      TargetFrameToTHealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickfriendr, GhettoFrames2SaveX.colorpickfriendg, GhettoFrames2SaveX.colorpickfriendb)
                    else
                      TargetFrameToTHealthBar:SetStatusBarColor(1, 0, 0)
                    end
                  end
                  if (UnitIsFriend("player", unit)) then
                    if (GhettoFrames2SaveX.colorpickenemyr and GhettoFrames2SaveX.colorpickenemyg and GhettoFrames2SaveX.colorpickenemyb) then
                      TargetFrameToTHealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickenemyr, GhettoFrames2SaveX.colorpickenemyg, GhettoFrames2SaveX.colorpickenemyb)
                    else
                      TargetFrameToTHealthBar:SetStatusBarColor(0, 1, 0)
                    end
                  end
                end
              end
            else
              Ttotclasscolorcheck:SetChecked(true)
            end

            if (not GhettoFrames2SaveX.classcolorftot) then
              if (GhettoFrames2SaveX.percentcolorfocustot) then

                if (statusbar == FocusFrameToTHealthBar) then
                  FocusFrameToTHealthBar:SetStatusBarColor(r, g, b) ;
                end
              else
                if (statusbar == FocusFrameToTHealthBar) then
                  if (not UnitIsFriend("player", unit)) then
                    if (GhettoFrames2SaveX.colorpickfriendr and GhettoFrames2SaveX.colorpickfriendg and GhettoFrames2SaveX.colorpickfriendb) then
                      FocusFrameToTHealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickfriendr, GhettoFrames2SaveX.colorpickfriendg, GhettoFrames2SaveX.colorpickfriendb)
                    else
                      FocusFrameToTHealthBar:SetStatusBarColor(1, 0, 0)
                    end
                  end
                  if (UnitIsFriend("player", unit)) then
                    if (GhettoFrames2SaveX.colorpickenemyr and GhettoFrames2SaveX.colorpickenemyg and GhettoFrames2SaveX.colorpickenemyb) then
                      FocusFrameToTHealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickenemyr, GhettoFrames2SaveX.colorpickenemyg, GhettoFrames2SaveX.colorpickenemyb)
                    else
                      FocusFrameToTHealthBar:SetStatusBarColor(0, 1, 0)
                    end
                  end
                end
              end
            else
              Ftotclasscolorcheck:SetChecked(true)
            end

          else --no player but classcolored

            if (UnitIsConnected(unit) and unit == statusbar.unit) then
              if (GhettoFrames2SaveX.percentcolortargettot) then

                if (statusbar == TargetFrameToTHealthBar) then
                  TargetFrameToTHealthBar:SetStatusBarColor(r, g, b) ;
                end
              else
                if (statusbar == TargetFrameToTHealthBar) then
                  if (not UnitIsFriend("player", unit)) then
                    if (GhettoFrames2SaveX.colorpickfriendr and GhettoFrames2SaveX.colorpickfriendg and GhettoFrames2SaveX.colorpickfriendb) then
                      TargetFrameToTHealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickfriendr, GhettoFrames2SaveX.colorpickfriendg, GhettoFrames2SaveX.colorpickfriendb)
                    else
                      TargetFrameToTHealthBar:SetStatusBarColor(1, 0, 0)
                    end
                  end
                  if (UnitIsFriend("player", unit)) then
                    if (GhettoFrames2SaveX.colorpickenemyr and GhettoFrames2SaveX.colorpickenemyg and GhettoFrames2SaveX.colorpickenemyb) then
                      TargetFrameToTHealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickenemyr, GhettoFrames2SaveX.colorpickenemyg, GhettoFrames2SaveX.colorpickenemyb)
                    else
                      TargetFrameToTHealthBar:SetStatusBarColor(0, 1, 0)
                    end
                  end
                end
              end

              if (GhettoFrames2SaveX.percentcolorpet) then

                if (statusbar == PetFrameHealthBar) then
                  PetFrameHealthBar:SetStatusBarColor(r, g, b) ;
                end
              else
                if (statusbar == PetFrameHealthBar) then

                  if (GhettoFrames2SaveX.colorpickenemyr and GhettoFrames2SaveX.colorpickenemyg and GhettoFrames2SaveX.colorpickenemyb) then
                    PetFrameHealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickenemyr, GhettoFrames2SaveX.colorpickenemyg, GhettoFrames2SaveX.colorpickenemyb)
                  else
                    PetFrameHealthBar:SetStatusBarColor(0, 1, 0)
                  end
                end
              end

              if (GhettoFrames2SaveX.percentcolorfocustot) then

                if (statusbar == FocusFrameToTHealthBar) then
                  FocusFrameToTHealthBar:SetStatusBarColor(r, g, b) ;
                end
              else
                if (statusbar == FocusFrameToTHealthBar) then
                  if (not UnitIsFriend("player", unit)) then
                    if (GhettoFrames2SaveX.colorpickfriendr and GhettoFrames2SaveX.colorpickfriendg and GhettoFrames2SaveX.colorpickfriendb) then
                      FocusFrameToTHealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickfriendr, GhettoFrames2SaveX.colorpickfriendg, GhettoFrames2SaveX.colorpickfriendb)
                    else
                      FocusFrameToTHealthBar:SetStatusBarColor(1, 0, 0)
                    end
                  end
                  if (UnitIsFriend("player", unit)) then
                    if (GhettoFrames2SaveX.colorpickenemyr and GhettoFrames2SaveX.colorpickenemyg and GhettoFrames2SaveX.colorpickenemyb) then
                      FocusFrameToTHealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickenemyr, GhettoFrames2SaveX.colorpickenemyg, GhettoFrames2SaveX.colorpickenemyb)
                    else
                      FocusFrameToTHealthBar:SetStatusBarColor(0, 1, 0)
                    end
                  end
                end
              end

              if (GhettoFrames2SaveX.percentcolorfocus) then
                if (statusbar == FocusFrameHealthBar) then
                  FocusFrameHealthBar:SetStatusBarColor(r, g, b) ;
                end
              else
                if (statusbar == FocusFrameHealthBar) then
                  if (not UnitIsFriend("player", unit)) then
                    if (GhettoFrames2SaveX.colorpickfriendr and GhettoFrames2SaveX.colorpickfriendg and GhettoFrames2SaveX.colorpickfriendb) then
                      FocusFrameHealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickfriendr, GhettoFrames2SaveX.colorpickfriendg, GhettoFrames2SaveX.colorpickfriendb)
                    else
                      FocusFrameHealthBar:SetStatusBarColor(1, 0, 0)
                    end
                  end
                  if (UnitIsFriend("player", unit)) then
                    if (GhettoFrames2SaveX.colorpickenemyr and GhettoFrames2SaveX.colorpickenemyg and GhettoFrames2SaveX.colorpickenemyb) then
                      FocusFrameHealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickenemyr, GhettoFrames2SaveX.colorpickenemyg, GhettoFrames2SaveX.colorpickenemyb)
                    else
                      FocusFrameHealthBar:SetStatusBarColor(0, 1, 0)
                    end
                  end
                end
              end

              if (GhettoFrames2SaveX.percentcolortarget) then
                if (statusbar == TargetFrameHealthBar) then
                  TargetFrameHealthBar:SetStatusBarColor(r, g, b) ;
                end
              else
                if (statusbar == TargetFrameHealthBar) then
                  if (not UnitIsFriend("player", unit)) then
                    if (GhettoFrames2SaveX.colorpickfriendr and GhettoFrames2SaveX.colorpickfriendg and GhettoFrames2SaveX.colorpickfriendb) then
                      TargetFrameHealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickfriendr, GhettoFrames2SaveX.colorpickfriendg, GhettoFrames2SaveX.colorpickfriendb)
                    else
                      TargetFrameHealthBar:SetStatusBarColor(1, 0, 0)
                    end
                  end
                  if (UnitIsFriend("player", unit)) then
                    if (GhettoFrames2SaveX.colorpickenemyr and GhettoFrames2SaveX.colorpickenemyg and GhettoFrames2SaveX.colorpickenemyb) then
                      TargetFrameHealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickenemyr, GhettoFrames2SaveX.colorpickenemyg, GhettoFrames2SaveX.colorpickenemyb)
                    else
                      TargetFrameHealthBar:SetStatusBarColor(0, 1, 0)
                    end
                  end
                end
              end

            end
          end

        end
      end

      hooksecurefunc("UnitFrameHealthBar_Update", colour)
      hooksecurefunc("HealthBar_OnValueChanged", function(self)
          colour(self, self.unit)
        end)
    else --no classcolored

      local function colourx(statusbar, unit)
        if (unit ~= mouseover) then
          local value = UnitHealth(unit) ;
          local min, max = statusbar:GetMinMaxValues() ;

          local r, g, b;

          if ((value < min) or (value > max)) then
            return;
          end
          if ((max - min) > 0) then
            value = (value - min) / (max - min) ;
          else
            value = 0;
          end
          if(value > 0.5) then
            r = (1.0 - value) * 2;
            g = 1.0;
          else
            r = 1.0;
            g = value * 2;
          end
          b = 0.0;

          if (UnitIsConnected(unit) and unit == statusbar.unit) then
            if (GhettoFrames2SaveX.percentcolorplayer) then
              PlayerPercentcolorcheck:SetChecked(true) ;
              if (statusbar == PlayerFrameHealthBar) then
                PlayerFrameHealthBar:SetStatusBarColor(r, g, b) ;
              end
            else
              if (statusbar == PlayerFrameHealthBar) then
                if (GhettoFrames2SaveX.colorpickenemyr and GhettoFrames2SaveX.colorpickenemyg and GhettoFrames2SaveX.colorpickenemyb) then
                  PlayerFrameHealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickenemyr, GhettoFrames2SaveX.colorpickenemyg, GhettoFrames2SaveX.colorpickenemyb)
                else
                  PlayerFrameHealthBar:SetStatusBarColor(0, 1, 0)
                end
              end
            end

            if (GhettoFrames2SaveX.percentcolortargettot) then

              if (statusbar == TargetFrameToTHealthBar) then
                TargetFrameToTHealthBar:SetStatusBarColor(r, g, b) ;
              end
            else
              if (statusbar == TargetFrameToTHealthBar) then
                if (not UnitIsFriend("player", unit)) then
                  if (GhettoFrames2SaveX.colorpickfriendr and GhettoFrames2SaveX.colorpickfriendg and GhettoFrames2SaveX.colorpickfriendb) then
                    TargetFrameToTHealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickfriendr, GhettoFrames2SaveX.colorpickfriendg, GhettoFrames2SaveX.colorpickfriendb)
                  else
                    TargetFrameToTHealthBar:SetStatusBarColor(1, 0, 0)
                  end
                end
                if (UnitIsFriend("player", unit)) then
                  if (GhettoFrames2SaveX.colorpickenemyr and GhettoFrames2SaveX.colorpickenemyg and GhettoFrames2SaveX.colorpickenemyb) then
                    TargetFrameToTHealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickenemyr, GhettoFrames2SaveX.colorpickenemyg, GhettoFrames2SaveX.colorpickenemyb)
                  else
                    TargetFrameToTHealthBar:SetStatusBarColor(0, 1, 0)
                  end
                end
              end
            end

            if (GhettoFrames2SaveX.percentcolorfocustot) then

              if (statusbar == FocusFrameToTHealthBar) then
                FocusFrameToTHealthBar:SetStatusBarColor(r, g, b) ;
              end
            else
              if (statusbar == FocusFrameToTHealthBar) then
                if (not UnitIsFriend("player", unit)) then
                  if (GhettoFrames2SaveX.colorpickfriendr and GhettoFrames2SaveX.colorpickfriendg and GhettoFrames2SaveX.colorpickfriendb) then
                    FocusFrameToTHealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickfriendr, GhettoFrames2SaveX.colorpickfriendg, GhettoFrames2SaveX.colorpickfriendb)
                  else
                    FocusFrameToTHealthBar:SetStatusBarColor(1, 0, 0)
                  end
                end
                if (UnitIsFriend("player", unit)) then
                  if (GhettoFrames2SaveX.colorpickenemyr and GhettoFrames2SaveX.colorpickenemyg and GhettoFrames2SaveX.colorpickenemyb) then
                    FocusFrameToTHealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickenemyr, GhettoFrames2SaveX.colorpickenemyg, GhettoFrames2SaveX.colorpickenemyb)
                  else
                    FocusFrameToTHealthBar:SetStatusBarColor(0, 1, 0)
                  end
                end
              end
            end

            if (GhettoFrames2SaveX.percentcolorfocus) then

              if (statusbar == FocusFrameHealthBar) then
                FocusFrameHealthBar:SetStatusBarColor(r, g, b) ;
              end
            else
              if (statusbar == FocusFrameHealthBar) then
                if (not UnitIsFriend("player", unit)) then
                  if (GhettoFrames2SaveX.colorpickfriendr and GhettoFrames2SaveX.colorpickfriendg and GhettoFrames2SaveX.colorpickfriendb) then
                    FocusFrameHealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickfriendr, GhettoFrames2SaveX.colorpickfriendg, GhettoFrames2SaveX.colorpickfriendb)
                  else
                    FocusFrameHealthBar:SetStatusBarColor(1, 0, 0)
                  end
                end
                if (UnitIsFriend("player", unit)) then
                  if (GhettoFrames2SaveX.colorpickenemyr and GhettoFrames2SaveX.colorpickenemyg and GhettoFrames2SaveX.colorpickenemyb) then
                    FocusFrameHealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickenemyr, GhettoFrames2SaveX.colorpickenemyg, GhettoFrames2SaveX.colorpickenemyb)
                  else
                    FocusFrameHealthBar:SetStatusBarColor(0, 1, 0)
                  end
                end
              end
            end

            if (GhettoFrames2SaveX.percentcolortarget) then
              if (statusbar == TargetFrameHealthBar) then
                TargetFrameHealthBar:SetStatusBarColor(r, g, b) ;
              end
            else
              if (statusbar == TargetFrameHealthBar) then
                if (not UnitIsFriend("player", unit)) then
                  if (GhettoFrames2SaveX.colorpickfriendr and GhettoFrames2SaveX.colorpickfriendg and GhettoFrames2SaveX.colorpickfriendb) then
                    TargetFrameHealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickfriendr, GhettoFrames2SaveX.colorpickfriendg, GhettoFrames2SaveX.colorpickfriendb)
                  else
                    TargetFrameHealthBar:SetStatusBarColor(1, 0, 0)
                  end
                end
                if (UnitIsFriend("player", unit)) then
                  if (GhettoFrames2SaveX.colorpickenemyr and GhettoFrames2SaveX.colorpickenemyg and GhettoFrames2SaveX.colorpickenemyb) then
                    TargetFrameHealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickenemyr, GhettoFrames2SaveX.colorpickenemyg, GhettoFrames2SaveX.colorpickenemyb)
                  else
                    TargetFrameHealthBar:SetStatusBarColor(0, 1, 0)
                  end
                end
              end
            end

            if (GhettoFrames2SaveX.percentcolorpet) then

              if (statusbar == PetFrameHealthBar) then
                PetFrameHealthBar:SetStatusBarColor(r, g, b) ;
              end
            else
              if (statusbar == PetFrameHealthBar) then
                if (not UnitIsFriend("player", unit)) then
                  if (GhettoFrames2SaveX.colorpickfriendr and GhettoFrames2SaveX.colorpickfriendg and GhettoFrames2SaveX.colorpickfriendb) then
                    PetFrameHealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickfriendr, GhettoFrames2SaveX.colorpickfriendg, GhettoFrames2SaveX.colorpickfriendb)
                  else
                    PetFrameHealthBar:SetStatusBarColor(1, 0, 0)
                  end
                end
                if (UnitIsFriend("player", unit)) then
                  if (GhettoFrames2SaveX.colorpickenemyr and GhettoFrames2SaveX.colorpickenemyg and GhettoFrames2SaveX.colorpickenemyb) then
                    PetFrameHealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickenemyr, GhettoFrames2SaveX.colorpickenemyg, GhettoFrames2SaveX.colorpickenemyb)
                  else
                    PetFrameHealthBar:SetStatusBarColor(0, 1, 0)
                  end
                end
              end
            end

            if (GhettoFrames2SaveX.percentcolorparty) then

              if (statusbar == PartyMemberFrame1HealthBar) then
                PartyMemberFrame1HealthBar:SetStatusBarColor(r, g, b) ;
              end
              if (statusbar == PartyMemberFrame2HealthBar) then
                PartyMemberFrame2HealthBar:SetStatusBarColor(r, g, b) ;
              end
              if (statusbar == PartyMemberFrame3HealthBar) then
                PartyMemberFrame3HealthBar:SetStatusBarColor(r, g, b) ;
              end
              if (statusbar == PartyMemberFrame4HealthBar) then
                PartyMemberFrame4HealthBar:SetStatusBarColor(r, g, b) ;
              end

            else
              if (GhettoFrames2SaveX.colorpickenemyr and GhettoFrames2SaveX.colorpickenemyr and GhettoFrames2SaveX.colorpickenemyr) then
                if (statusbar == PartyMemberFrame1HealthBar) then
                  PartyMemberFrame1HealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickenemyr, GhettoFrames2SaveX.colorpickenemyr, GhettoFrames2SaveX.colorpickenemyr)
                end
                if (statusbar == PartyMemberFrame2HealthBar) then
                  PartyMemberFrame2HealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickenemyr, GhettoFrames2SaveX.colorpickenemyg, GhettoFrames2SaveX.colorpickenemyb)
                end
                if (statusbar == PartyMemberFrame3HealthBar) then
                  PartyMemberFrame3HealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickenemyr, GhettoFrames2SaveX.colorpickenemyg, GhettoFrames2SaveX.colorpickenemyb)
                end
                if (statusbar == PartyMemberFrame4HealthBar) then
                  PartyMemberFrame4HealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickenemyr, GhettoFrames2SaveX.colorpickenemyg, GhettoFrames2SaveX.colorpickenemyb)
                end

              else
                if (statusbar == PartyMemberFrame1HealthBar) then
                  PartyMemberFrame1HealthBar:SetStatusBarColor(0, 1, 0)
                end
                if (statusbar == PartyMemberFrame2HealthBar) then
                  PartyMemberFrame2HealthBar:SetStatusBarColor(0, 1, 0)
                end
                if (statusbar == PartyMemberFrame3HealthBar) then
                  PartyMemberFrame3HealthBar:SetStatusBarColor(0, 1, 0)
                end
                if (statusbar == PartyMemberFrame4HealthBar) then
                  PartyMemberFrame4HealthBar:SetStatusBarColor(0, 1, 0)
                end

              end
            end

            if (GhettoFrames2SaveX.percentcolorarena) then

              if (statusbar == ArenaEnemyFrame1HealthBar) then
                ArenaEnemyFrame1HealthBar:SetStatusBarColor(r, g, b) ;
              end
              if (statusbar == ArenaEnemyFrame2HealthBar) then
                ArenaEnemyFrame2HealthBar:SetStatusBarColor(r, g, b) ;
              end
              if (statusbar == ArenaEnemyFrame3HealthBar) then
                ArenaEnemyFrame3HealthBar:SetStatusBarColor(r, g, b) ;
              end
              if (statusbar == ArenaEnemyFrame4HealthBar) then
                ArenaEnemyFrame4HealthBar:SetStatusBarColor(r, g, b) ;
              end
              if (statusbar == ArenaEnemyFrame5HealthBar) then
                ArenaEnemyFrame5HealthBar:SetStatusBarColor(r, g, b) ;
              end

            else
              if (GhettoFrames2SaveX.colorpickfriendr and GhettoFrames2SaveX.colorpickfriendg and GhettoFrames2SaveX.colorpickfriendb) then
                if (statusbar == ArenaEnemyFrame1HealthBar) then
                  ArenaEnemyFrame1HealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickfriendr, GhettoFrames2SaveX.colorpickfriendg, GhettoFrames2SaveX.colorpickfriendb)
                end
                if (statusbar == ArenaEnemyFrame2HealthBar) then
                  ArenaEnemyFrame2HealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickfriendr, GhettoFrames2SaveX.colorpickfriendg, GhettoFrames2SaveX.colorpickfriendb)
                end
                if (statusbar == ArenaEnemyFrame3HealthBar) then
                  ArenaEnemyFrame3HealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickfriendr, GhettoFrames2SaveX.colorpickfriendg, GhettoFrames2SaveX.colorpickfriendb)
                end
                if (statusbar == ArenaEnemyFrame4HealthBar) then
                  ArenaEnemyFrame4HealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickfriendr, GhettoFrames2SaveX.colorpickfriendg, GhettoFrames2SaveX.colorpickfriendb)
                end
                if (statusbar == ArenaEnemyFrame5HealthBar) then
                  ArenaEnemyFrame5HealthBar:SetStatusBarColor(GhettoFrames2SaveX.colorpickfriendr, GhettoFrames2SaveX.colorpickfriendg, GhettoFrames2SaveX.colorpickfriendb)
                end
              else
                if (statusbar == ArenaEnemyFrame1HealthBar) then
                  ArenaEnemyFrame1HealthBar:SetStatusBarColor(1, 0, 0)
                end
                if (statusbar == ArenaEnemyFrame2HealthBar) then
                  ArenaEnemyFrame2HealthBar:SetStatusBarColor(1, 0, 0)
                end
                if (statusbar == ArenaEnemyFrame3HealthBar) then
                  ArenaEnemyFrame3HealthBar:SetStatusBarColor(1, 0, 0)
                end
                if (statusbar == ArenaEnemyFrame4HealthBar) then
                  ArenaEnemyFrame4HealthBar:SetStatusBarColor(1, 0, 0)
                end
                if (statusbar == ArenaEnemyFrame5HealthBar) then
                  ArenaEnemyFrame5HealthBar:SetStatusBarColor(1, 0, 0)
                end
              end
            end

          end

        end
      end

      hooksecurefunc("UnitFrameHealthBar_Update", colourx)
      hooksecurefunc("HealthBar_OnValueChanged", function(self)
          colourx(self, self.unit)
        end)
    end

    if (GhettoFrames2SaveX.playername) then
      PlayerName:Show()
      playernamecheck:SetChecked(true)
    else
      PlayerName:Hide()

    end

    if (GhettoFrames2SaveX.petname) then
      PetName:Show()
      petnamecheck:SetChecked(true)
    else
      PetName:Hide()

    end
    if (GhettoFrames2SaveX.targetoftarget) then
      TargetFrameToT:SetAlpha(100)
      targettotcheck:SetChecked(true)

    end

    if (GhettoFrames2SaveX.targetoffocus) then

      FocusFrameToT:SetAlpha(100)
      focustotcheck:SetChecked(true)

    end
    if (GhettoFrames2SaveX.playerspecialbar) then
      specialbarcheck:SetChecked(true)
    else
      local nooop = function() return end
      for _, objname in ipairs({
          "MonkHarmonyBar",
          "PriestBarFrame",
          "PaladinPowerBar",
          "ShardBarFrame",

        }) do
        local obj = _G[objname]
        if obj then
          obj:Hide()
          obj.Show = nooop
        end
      end

    end
    if (GhettoFrames2SaveX.classportraits) then
      Portraitcheck:SetChecked(true)
      hooksecurefunc("UnitFramePortrait_Update", function(self)
          if self.portrait then
            if UnitIsPlayer(self.unit) then
              local t = CLASS_ICON_TCOORDS[select(2, UnitClass(self.unit))]
              if t then
                self.portrait:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles")
                self.portrait:SetTexCoord(unpack(t))
              end
            else
              self.portrait:SetTexCoord(0, 1, 0, 1)
            end
          end
        end)
    else

    end
    if (GhettoFrames2SaveX.playerhitindi) then
      playerhitindi:SetChecked(true)
      PlayerHitIndicator:SetText(nil)
      PlayerHitIndicator.SetText = function() end
    end
    if (GhettoFrames2SaveX.pethitindi) then
      pethitindi:SetChecked(true)
      PetHitIndicator:SetText(nil)
      PetHitIndicator.SetText = function() end
    end

    if (GhettoFrames2SaveX.bartex == 1) then
      PlayerFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Ace") ;
      PlayerFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Ace") ;
      TargetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Ace") ;
      TargetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Ace") ;
      FocusFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Ace") ;
      FocusFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Ace") ;
      TargetFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Ace") ;
      TargetFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Ace") ;
      FocusFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Ace") ;
      FocusFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Ace") ;
      PetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Ace") ;
      PetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Ace") ;

    end
    if (GhettoFrames2SaveX.bartex == 2) then
      PlayerFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Aluminium") ;
      PlayerFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Aluminium") ;
      TargetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Aluminium") ;
      TargetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Aluminium") ;
      FocusFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Aluminium") ;
      FocusFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Aluminium") ;
      TargetFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Aluminium") ;
      TargetFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Aluminium") ;
      FocusFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Aluminium") ;
      FocusFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Aluminium") ;
      PetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Aluminium") ;
      PetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Aluminium") ;

    end
    if (GhettoFrames2SaveX.bartex == 3) then
      PlayerFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\banto") ;
      PlayerFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\banto") ;
      TargetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\banto") ;
      TargetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\banto") ;
      FocusFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\banto") ;
      FocusFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\banto") ;
      TargetFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\banto") ;
      TargetFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\banto") ;
      FocusFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\banto") ;
      FocusFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\banto") ;
      PetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\banto") ;
      PetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\banto") ;

    end
    if (GhettoFrames2SaveX.bartex == 4) then

    end
    if (GhettoFrames2SaveX.bartex == 5) then
      PlayerFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Charcoal") ;
      PlayerFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Charcoal") ;
      TargetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Charcoal") ;
      TargetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Charcoal") ;
      FocusFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Charcoal") ;
      FocusFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Charcoal") ;
      TargetFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Charcoal") ;
      TargetFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Charcoal") ;
      FocusFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Charcoal") ;
      FocusFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Charcoal") ;
      PetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Charcoal") ;
      PetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Charcoal") ;

    end
    if (GhettoFrames2SaveX.bartex == 6) then
      PlayerFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\glaze") ;
      PlayerFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\glaze") ;
      TargetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\glaze") ;
      TargetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\glaze") ;
      FocusFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\glaze") ;
      FocusFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\glaze") ;
      TargetFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\glaze") ;
      TargetFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\glaze") ;
      FocusFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\glaze") ;
      FocusFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\glaze") ;
      PetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\glaze") ;
      PetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\glaze") ;

    end
    if (GhettoFrames2SaveX.bartex == 7) then
      PlayerFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\LiteStep") ;
      PlayerFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\LiteStep") ;
      TargetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\LiteStep") ;
      TargetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\LiteStep") ;
      FocusFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\LiteStep") ;
      FocusFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\LiteStep") ;
      TargetFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\LiteStep") ;
      TargetFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\LiteStep") ;
      FocusFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\LiteStep") ;
      FocusFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\LiteStep") ;
      PetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\LiteStep") ;
      PetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\LiteStep") ;

    end
    if (GhettoFrames2SaveX.bartex == 8) then
      PlayerFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Minimalist") ;
      PlayerFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Minimalist") ;
      TargetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Minimalist") ;
      TargetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Minimalist") ;
      FocusFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Minimalist") ;
      FocusFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Minimalist") ;
      TargetFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Minimalist") ;
      TargetFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Minimalist") ;
      FocusFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Minimalist") ;
      FocusFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Minimalist") ;
      PetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Minimalist") ;
      PetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Minimalist") ;

    end
    if (GhettoFrames2SaveX.bartex == 9) then
      PlayerFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\otravi") ;
      PlayerFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\otravi") ;
      TargetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\otravi") ;
      TargetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\otravi") ;
      FocusFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\otravi") ;
      FocusFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\otravi") ;
      TargetFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\otravi") ;
      TargetFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\otravi") ;
      FocusFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\otravi") ;
      FocusFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\otravi") ;
      PetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\otravi") ;
      PetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\otravi") ;

    end
    if (GhettoFrames2SaveX.bartex == 10) then
      PlayerFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\perl") ;
      PlayerFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\perl") ;
      TargetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\perl") ;
      TargetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\perl") ;
      FocusFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\perl") ;
      FocusFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\perl") ;
      TargetFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\perl") ;
      TargetFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\perl") ;
      FocusFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\perl") ;
      FocusFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\perl") ;
      PetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\perl") ;
      PetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\perl") ;

    end
    if (GhettoFrames2SaveX.bartex == 11) then
      PlayerFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\smooth") ;
      PlayerFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\smooth") ;
      TargetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\smooth") ;
      TargetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\smooth") ;
      FocusFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\smooth") ;
      FocusFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\smooth") ;
      TargetFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\smooth") ;
      TargetFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\smooth") ;
      FocusFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\smooth") ;
      FocusFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\smooth") ;
      PetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\smooth") ;
      PetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\smooth") ;
    end
    if (GhettoFrames2SaveX.bartex == 12) then
      PlayerFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\striped") ;
      PlayerFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\striped") ;
      TargetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\striped") ;
      TargetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\striped") ;
      FocusFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\striped") ;
      FocusFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\striped") ;
      TargetFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\striped") ;
      TargetFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\striped") ;
      FocusFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\striped") ;
      FocusFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\striped") ;
      PetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\striped") ;
      PetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\striped") ;
    end
    if (GhettoFrames2SaveX.bartex == 13) then
      PlayerFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\swag") ;
      PlayerFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\swag") ;
      TargetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\swag") ;
      TargetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\swag") ;
      FocusFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\swag") ;
      FocusFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\swag") ;
      TargetFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\swag") ;
      TargetFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\swag") ;
      FocusFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\swag") ;
      FocusFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\swag") ;
      PetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\swag") ;
      PetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\swag") ;
    end
    if (GhettoFrames2SaveX.phformat == 1) then--percent
      local Player = "Player"
      function UpdateHealthValues(...)
        if (0 < UnitHealth(Player)) then
          local Health = UnitHealth(Player)
          local HealthMax = UnitHealthMax(Player)
          local HealthPercent = (UnitHealth(Player) / UnitHealthMax(Player)) * 100
          _G[Player .. "FrameHealthBar"].TextString:SetText(format("%.0f", HealthPercent) .. "%")
        end
      end
      hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", UpdateHealthValues)
    end
    if (GhettoFrames2SaveX.fhformat == 1) then--percent
      local Focus = "Focus"
      function UpdateHealthValues(...)
        if (0 < UnitHealth(Focus)) then
          local Health = UnitHealth(Focus)
          local HealthMax = UnitHealthMax(Focus)
          local HealthPercent = (UnitHealth(Focus) / UnitHealthMax(Focus)) * 100
          _G[Focus .. "FrameHealthBar"].TextString:SetText(format("%.0f", HealthPercent) .. "%")
        end
      end
      hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", UpdateHealthValues)
    end
    if (GhettoFrames2SaveX.thformat == 1) then--percent
      local Target = "Target"
      function UpdateHealthValues(...)
        if (0 < UnitHealth(Target)) then
          local Health = UnitHealth(Target)
          local HealthMax = UnitHealthMax(Target)
          local HealthPercent = (UnitHealth(Target) / UnitHealthMax(Target)) * 100
          _G[Target .. "FrameHealthBar"].TextString:SetText(format("%.0f", HealthPercent) .. "%")
        end
      end
      hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", UpdateHealthValues)
    end

    if (GhettoFrames2SaveX.phformat == 2) then--currenthealth
      local Player = "Player"
      function UpdateHealthValues(...)
        if (0 < UnitHealth(Player)) then
          if UnitHealth(Player) < 1000 then
            local Health = UnitHealth(Player)
            local HealthMax = UnitHealthMax(Player)
            _G[Player .. "FrameHealthBar"].TextString:SetText(Health)
          elseif (UnitHealth(Player) < 1000000) then
            local Health = (UnitHealth(Player)) / 1000
            local HealthMax = (UnitHealthMax(Player)) / 1000
            _G[Player .. "FrameHealthBar"].TextString:SetText(format("%.0f", Health) .. "k")
          elseif (1000000 <= UnitHealth(Player)) then
            local Health = (UnitHealth(Player)) / 1000000
            local HealthMax = (UnitHealthMax(Player)) / 1000000
            _G[Player .. "FrameHealthBar"].TextString:SetText(format("%.0f", Health) .. "m")
          end
        end
      end
      hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", UpdateHealthValues)
    end

    if (GhettoFrames2SaveX.thformat == 2) then--currenthealth
      local Target = "Target"
      function UpdateHealthValues(...)
        if (0 < UnitHealth(Target)) then
          if UnitHealth(Target) < 1000 then
            local Health = UnitHealth(Target)
            local HealthMax = UnitHealthMax(Target)
            _G[Target .. "FrameHealthBar"].TextString:SetText(Health)
          elseif (UnitHealth(Target) < 1000000) then
            local Health = (UnitHealth(Target)) / 1000
            local HealthMax = (UnitHealthMax(Target)) / 1000
            _G[Target .. "FrameHealthBar"].TextString:SetText(format("%.0f", Health) .. "k")
          elseif (1000000 <= UnitHealth(Target)) then
            local Health = (UnitHealth(Target)) / 1000000
            local HealthMax = (UnitHealthMax(Target)) / 1000000
            _G[Target .. "FrameHealthBar"].TextString:SetText(format("%.0f", Health) .. "m")
          end
        end
      end
      hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", UpdateHealthValues)
    end

    if (GhettoFrames2SaveX.fhformat == 2) then--currenthealth
      local Focus = "Focus"
      function UpdateHealthValues(...)
        if (0 < UnitHealth(Focus)) then
          if UnitHealth(Focus) < 1000 then
            local Health = UnitHealth(Focus)
            local HealthMax = UnitHealthMax(Focus)
            _G[Focus .. "FrameHealthBar"].TextString:SetText(Health)
          elseif (UnitHealth(Focus) < 1000000) then
            local Health = (UnitHealth(Focus)) / 1000
            local HealthMax = (UnitHealthMax(Focus)) / 1000
            _G[Focus .. "FrameHealthBar"].TextString:SetText(format("%.0f", Health) .. "k")
          elseif (1000000 <= UnitHealth(Focus)) then
            local Health = (UnitHealth(Focus)) / 1000000
            local HealthMax = (UnitHealthMax(Focus)) / 1000000
            _G[Focus .. "FrameHealthBar"].TextString:SetText(format("%.0f", Health) .. "m")
          end
        end
      end
      hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", UpdateHealthValues)
    end

    if (GhettoFrames2SaveX.phformat == 3) then --currenthealth + percent
      local Player = "Player"
      function UpdateHealthValues(...)
        if (0 < UnitHealth(Player)) then
          if UnitHealth(Player) < 1000 then
            local Health = UnitHealth(Player)
            local HealthMax = UnitHealthMax(Player)
            local HealthPercent = (UnitHealth(Player) / UnitHealthMax(Player)) * 100
            _G[Player .. "FrameHealthBar"].TextString:SetText(Health .. " (" .. format("%.0f", HealthPercent) .. "%)")
          elseif (UnitHealth(Player) < 1000000) then
            local Health = (UnitHealth(Player)) / 1000
            local HealthMax = (UnitHealthMax(Player)) / 1000
            local HealthPercent = (UnitHealth(Player) / UnitHealthMax(Player)) * 100
            _G[Player .. "FrameHealthBar"].TextString:SetText(format("%.0f", Health) .. "k (" .. format("%.0f", HealthPercent) .. "%)")
          elseif (1000000 <= UnitHealth(Player)) then
            local Health = (UnitHealth(Player)) / 1000000
            local HealthMax = (UnitHealthMax(Player)) / 1000000
            local HealthPercent = (UnitHealth(Player) / UnitHealthMax(Player)) * 100
            _G[Player .. "FrameHealthBar"].TextString:SetText(format("%.0f", Health) .. "m (" .. format("%.0f", HealthPercent) .. "%)")
          end
        end
      end
      hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", UpdateHealthValues)
    end
    if (GhettoFrames2SaveX.thformat == 3) then --currenthealth + percent
      local Target = "Target"
      function UpdateHealthValues(...)
        if (0 < UnitHealth(Target)) then
          if UnitHealth(Target) < 1000 then
            local Health = UnitHealth(Target)
            local HealthMax = UnitHealthMax(Target)
            local HealthPercent = (UnitHealth(Target) / UnitHealthMax(Target)) * 100
            _G[Target .. "FrameHealthBar"].TextString:SetText(Health .. " (" .. format("%.0f", HealthPercent) .. "%)")
          elseif (UnitHealth(Target) < 1000000) then
            local Health = (UnitHealth(Target)) / 1000
            local HealthMax = (UnitHealthMax(Target)) / 1000
            local HealthPercent = (UnitHealth(Target) / UnitHealthMax(Target)) * 100
            _G[Target .. "FrameHealthBar"].TextString:SetText(format("%.0f", Health) .. "k (" .. format("%.0f", HealthPercent) .. "%)")
          elseif (1000000 <= UnitHealth(Target)) then
            local Health = (UnitHealth(Target)) / 1000000
            local HealthMax = (UnitHealthMax(Target)) / 1000000
            local HealthPercent = (UnitHealth(Target) / UnitHealthMax(Target)) * 100
            _G[Target .. "FrameHealthBar"].TextString:SetText(format("%.0f", Health) .. "m (" .. format("%.0f", HealthPercent) .. "%)")
          end
        end
      end
      hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", UpdateHealthValues)
    end

    if (GhettoFrames2SaveX.fhformat == 3) then --currenthealth + percent
      local Focus = "Focus"
      function UpdateHealthValues(...)
        if (0 < UnitHealth(Focus)) then
          if UnitHealth(Focus) < 1000 then
            local Health = UnitHealth(Focus)
            local HealthMax = UnitHealthMax(Focus)
            local HealthPercent = (UnitHealth(Focus) / UnitHealthMax(Focus)) * 100
            _G[Focus .. "FrameHealthBar"].TextString:SetText(Health .. " (" .. format("%.0f", HealthPercent) .. "%)")
          elseif (UnitHealth(Focus) < 1000000) then
            local Health = (UnitHealth(Focus)) / 1000
            local HealthMax = (UnitHealthMax(Focus)) / 1000
            local HealthPercent = (UnitHealth(Focus) / UnitHealthMax(Focus)) * 100
            _G[Focus .. "FrameHealthBar"].TextString:SetText(format("%.0f", Health) .. "k (" .. format("%.0f", HealthPercent) .. "%)")
          elseif (1000000 <= UnitHealth(Focus)) then
            local Health = (UnitHealth(Focus)) / 1000000
            local HealthMax = (UnitHealthMax(Focus)) / 1000000
            local HealthPercent = (UnitHealth(Focus) / UnitHealthMax(Focus)) * 100
            _G[Focus .. "FrameHealthBar"].TextString:SetText(format("%.0f", Health) .. "m (" .. format("%.0f", HealthPercent) .. "%)")
          end
        end
      end
      hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", UpdateHealthValues)
    end

    if (GhettoFrames2SaveX.phformat == 4) then --current health+maxhealth
      local Player = "Player"
      function UpdateHealthValues(...)
        if (0 < UnitHealth(Player)) then
          if UnitHealth(Player) < 1000 then
            local Health = UnitHealth(Player)
            local HealthMax = UnitHealthMax(Player)
            local HealthPercent = (UnitHealth(Player) / UnitHealthMax(Player)) * 100
            if (UnitHealthMax(Player) < 1000) then
              _G[Player .. "FrameHealthBar"].TextString:SetText(Health .. " / " .. (HealthMax))
            elseif (UnitHealthMax(Player) < 1000000) then
              local HealthMax = UnitHealthMax(Player) / 1000
              _G[Player .. "FrameHealthBar"].TextString:SetText(Health .. " / " .. format("%.0f", HealthMax) .. "k")
            elseif (1000000 <= UnitHealthMax(Player)) then
              local HealthMax = UnitHealthMax(Player) / 1000000
              _G[Player .. "FrameHealthBar"].TextString:SetText(Health .. " / " .. format("%.0f", HealthMax) .. "m")
            end
          elseif (UnitHealth(Player) < 1000000) then
            local Health = (UnitHealth(Player)) / 1000
            local HealthMax = (UnitHealthMax(Player)) / 1000
            local HealthPercent = (UnitHealth(Player) / UnitHealthMax(Player)) * 100
            if (UnitHealthMax(Player) < 1000000) then
              local HealthMax = (UnitHealthMax(Player)) / 1000
              _G[Player .. "FrameHealthBar"].TextString:SetText(format("%.0f", Health) .. "k / " .. format("%.0f", HealthMax) .. "k")
            elseif (1000000 <= UnitHealthMax(Player)) then
              local HealthMax = UnitHealthMax(Player) / 1000000
              _G[Player .. "FrameHealthBar"].TextString:SetText(format("%.0f", Health) .. "k / " .. format("%.0f", HealthMax) .. "m")
            end
          elseif (1000000 <= UnitHealth(Player)) then
            local Health = (UnitHealth(Player)) / 1000000
            local HealthMax = (UnitHealthMax(Player)) / 1000000
            local HealthPercent = (UnitHealth(Player) / UnitHealthMax(Player)) * 100
            _G[Player .. "FrameHealthBar"].TextString:SetText(format("%.0f", Health) .. "m / " .. format("%.0f", HealthMax) .. "m")
          end
        end

      end
      hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", UpdateHealthValues)
    end

    if (GhettoFrames2SaveX.thformat == 4) then --current health+maxhealth
      local Target = "Target"
      function UpdateHealthValues(...)
        if (0 < UnitHealth(Target)) then
          if UnitHealth(Target) < 1000 then
            local Health = UnitHealth(Target)
            local HealthMax = UnitHealthMax(Target)
            local HealthPercent = (UnitHealth(Target) / UnitHealthMax(Target)) * 100
            if (UnitHealthMax(Target) < 1000) then
              _G[Target .. "FrameHealthBar"].TextString:SetText(Health .. " / " .. (HealthMax))
            elseif (UnitHealthMax(Target) < 1000000) then
              local HealthMax = UnitHealthMax(Target) / 1000
              _G[Target .. "FrameHealthBar"].TextString:SetText(Health .. " / " .. format("%.0f", HealthMax) .. "k")
            elseif (1000000 <= UnitHealthMax(Target)) then
              local HealthMax = UnitHealthMax(Target) / 1000000
              _G[Target .. "FrameHealthBar"].TextString:SetText(Health .. " / " .. format("%.0f", HealthMax) .. "m")
            end
          elseif (UnitHealth(Target) < 1000000) then
            local Health = (UnitHealth(Target)) / 1000
            local HealthMax = (UnitHealthMax(Target)) / 1000
            local HealthPercent = (UnitHealth(Target) / UnitHealthMax(Target)) * 100
            if (UnitHealthMax(Target) < 1000000) then
              local HealthMax = (UnitHealthMax(Target)) / 1000
              _G[Target .. "FrameHealthBar"].TextString:SetText(format("%.0f", Health) .. "k / " .. format("%.0f", HealthMax) .. "k")
            elseif (1000000 <= UnitHealthMax(Target)) then
              local HealthMax = UnitHealthMax(Target) / 1000000
              _G[Player .. "FrameHealthBar"].TextString:SetText(format("%.0f", Health) .. "k / " .. format("%.0f", HealthMax) .. "m")
            end
          elseif (1000000 <= UnitHealth(Target)) then
            local Health = (UnitHealth(Target)) / 1000000
            local HealthMax = (UnitHealthMax(Target)) / 1000000
            local HealthPercent = (UnitHealth(Target) / UnitHealthMax(Target)) * 100
            _G[Target .. "FrameHealthBar"].TextString:SetText(format("%.0f", Health) .. "m / " .. format("%.0f", HealthMax) .. "m")
          end
        end

      end
      hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", UpdateHealthValues)
    end

    if (GhettoFrames2SaveX.fhformat == 4) then --current health+maxhealth
      local Focus = "Focus"
      function UpdateHealthValues(...)
        if (0 < UnitHealth(Focus)) then
          if UnitHealth(Focus) < 1000 then
            local Health = UnitHealth(Focus)
            local HealthMax = UnitHealthMax(Focus)
            local HealthPercent = (UnitHealth(Focus) / UnitHealthMax(Focus)) * 100
            if (UnitHealthMax(Focus) < 1000) then
              _G[Focus .. "FrameHealthBar"].TextString:SetText(Health .. " / " .. (HealthMax))
            elseif (UnitHealthMax(Focus) < 1000000) then
              local HealthMax = UnitHealthMax(Focus) / 1000
              _G[Focus .. "FrameHealthBar"].TextString:SetText(Health .. " / " .. format("%.0f", HealthMax) .. "k")
            elseif (1000000 <= UnitHealthMax(Focus)) then
              local HealthMax = UnitHealthMax(Focus) / 1000000
              _G[Focus .. "FrameHealthBar"].TextString:SetText(Health .. " / " .. format("%.0f", HealthMax) .. "m")
            end
          elseif (UnitHealth(Focus) < 1000000) then
            local Health = (UnitHealth(Focus)) / 1000
            local HealthMax = (UnitHealthMax(Focus)) / 1000
            local HealthPercent = (UnitHealth(Focus) / UnitHealthMax(Focus)) * 100
            if (UnitHealthMax(Focus) < 1000000) then
              local HealthMax = (UnitHealthMax(Focus)) / 1000
              _G[Focus .. "FrameHealthBar"].TextString:SetText(format("%.0f", Health) .. "k / " .. format("%.0f", HealthMax) .. "k")
            elseif (1000000 <= UnitHealthMax(Focus)) then
              local HealthMax = UnitHealthMax(Focus) / 1000000
              _G[Player .. "FrameHealthBar"].TextString:SetText(format("%.0f", Health) .. "k / " .. format("%.0f", HealthMax) .. "m")
            end
          elseif (1000000 <= UnitHealth(Focus)) then
            local Health = (UnitHealth(Focus)) / 1000000
            local HealthMax = (UnitHealthMax(Focus)) / 1000000
            local HealthPercent = (UnitHealth(Focus) / UnitHealthMax(Focus)) * 100
            _G[Focus .. "FrameHealthBar"].TextString:SetText(format("%.0f", Health) .. "m / " .. format("%.0f", HealthMax) .. "m")
          end
        end
      end
      hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", UpdateHealthValues)
    end

    if (GhettoFrames2SaveX.phformat == 5) then --current health+maxhealth+percent
      local Player = "Player"
      function UpdateHealthValues(...)
        if (0 < UnitHealth(Player)) then
          if UnitHealth(Player) < 1000 then
            local Health = UnitHealth(Player)
            local HealthMax = UnitHealthMax(Player)
            local HealthPercent = (UnitHealth(Player) / UnitHealthMax(Player)) * 100
            if (UnitHealthMax(Player) < 1000) then
              _G[Player .. "FrameHealthBar"].TextString:SetText(Health .. " / " .. (HealthMax) .. " (" .. format("%.0f", HealthPercent) .. "%)")
            elseif (UnitHealthMax(Player) < 1000000) then
              local HealthMax = UnitHealthMax(Player) / 1000
              _G[Player .. "FrameHealthBar"].TextString:SetText(Health .. " / " .. format("%.0f", HealthMax) .. "k (" .. format("%.0f", HealthPercent) .. "%)")
            elseif (1000000 <= UnitHealthMax(Player)) then
              local HealthMax = UnitHealthMax(Player) / 1000000
              _G[Player .. "FrameHealthBar"].TextString:SetText(Health .. " / " .. format("%.0f", HealthMax) .. "m (" .. format("%.0f", HealthPercent) .. "%)")
            end
          elseif (UnitHealth(Player) < 1000000) then
            local Health = (UnitHealth(Player)) / 1000
            local HealthMax = (UnitHealthMax(Player)) / 1000
            local HealthPercent = (UnitHealth(Player) / UnitHealthMax(Player)) * 100
            if (UnitHealthMax(Player) < 1000000) then
              local HealthMax = (UnitHealthMax(Player)) / 1000
              _G[Player .. "FrameHealthBar"].TextString:SetText(format("%.0f", Health) .. "k / " .. format("%.0f", HealthMax) .. "k (" .. format("%.0f", HealthPercent) .. "%)")
            elseif (1000000 <= UnitHealthMax(Player)) then
              local HealthMax = UnitHealthMax(Player) / 1000000
              _G[Player .. "FrameHealthBar"].TextString:SetText(format("%.0f", Health) .. "k / " .. format("%.0f", HealthMax) .. "m (" .. format("%.0f", HealthPercent) .. "%)")
            end
          elseif (1000000 <= UnitHealth(Player)) then
            local Health = (UnitHealth(Player)) / 1000000
            local HealthMax = (UnitHealthMax(Player)) / 1000000
            local HealthPercent = (UnitHealth(Player) / UnitHealthMax(Player)) * 100
            _G[Player .. "FrameHealthBar"].TextString:SetText(format("%.0f", Health) .. "m / " .. format("%.0f", HealthMax) .. "m (" .. format("%.0f", HealthPercent) .. "%)")
          end
        end
      end
      hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", UpdateHealthValues)
    end

    if (GhettoFrames2SaveX.thformat == 5) then --current health+maxhealth+percent
      local Target = "Target"
      function UpdateHealthValues(...)
        if (0 < UnitHealth(Target)) then
          if UnitHealth(Target) < 1000 then
            local Health = UnitHealth(Target)
            local HealthMax = UnitHealthMax(Target)
            local HealthPercent = (UnitHealth(Target) / UnitHealthMax(Target)) * 100
            if (UnitHealthMax(Target) < 1000) then
              _G[Target .. "FrameHealthBar"].TextString:SetText(Health .. " / " .. (HealthMax) .. " (" .. format("%.0f", HealthPercent) .. "%)")
            elseif (UnitHealthMax(Target) < 1000000) then
              local HealthMax = UnitHealthMax(Target) / 1000
              _G[Target .. "FrameHealthBar"].TextString:SetText(Health .. " / " .. format("%.0f", HealthMax) .. "k (" .. format("%.0f", HealthPercent) .. "%)")
            elseif (1000000 <= UnitHealthMax(Target)) then
              local HealthMax = UnitHealthMax(Target) / 1000000
              _G[Target .. "FrameHealthBar"].TextString:SetText(Health .. " / " .. format("%.0f", HealthMax) .. "m (" .. format("%.0f", HealthPercent) .. "%)")
            end
          elseif (UnitHealth(Target) < 1000000) then
            local Health = (UnitHealth(Target)) / 1000
            local HealthMax = (UnitHealthMax(Target)) / 1000
            local HealthPercent = (UnitHealth(Target) / UnitHealthMax(Target)) * 100
            if (UnitHealthMax(Target) < 1000000) then
              local HealthMax = (UnitHealthMax(Target)) / 1000
              _G[Target .. "FrameHealthBar"].TextString:SetText(format("%.0f", Health) .. "k / " .. format("%.0f", HealthMax) .. "k (" .. format("%.0f", HealthPercent) .. "%)")
            elseif (1000000 <= UnitHealthMax(Target)) then
              local HealthMax = UnitHealthMax(Target) / 1000000
              _G[Target .. "FrameHealthBar"].TextString:SetText(format("%.0f", Health) .. "k / " .. format("%.0f", HealthMax) .. "m (" .. format("%.0f", HealthPercent) .. "%)")
            end
          elseif (1000000 <= UnitHealth(Target)) then
            local Health = (UnitHealth(Target)) / 1000000
            local HealthMax = (UnitHealthMax(Target)) / 1000000
            local HealthPercent = (UnitHealth(Target) / UnitHealthMax(Target)) * 100
            _G[Target .. "FrameHealthBar"].TextString:SetText(format("%.0f", Health) .. "m / " .. format("%.0f", HealthMax) .. "m (" .. format("%.0f", HealthPercent) .. "%)")
          end
        end
      end
      hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", UpdateHealthValues)
    end

    if (GhettoFrames2SaveX.fhformat == 5) then --current health+maxhealth+percent
      local Focus = "Focus"
      function UpdateHealthValues(...)
        if (0 < UnitHealth(Focus)) then
          if UnitHealth(Focus) < 1000 then
            local Health = UnitHealth(Focus)
            local HealthMax = UnitHealthMax(Focus)
            local HealthPercent = (UnitHealth(Focus) / UnitHealthMax(Focus)) * 100
            if (UnitHealthMax(Focus) < 1000) then
              _G[Focus .. "FrameHealthBar"].TextString:SetText(Health .. " / " .. (HealthMax) .. " (" .. format("%.0f", HealthPercent) .. "%)")
            elseif (UnitHealthMax(Focus) < 1000000) then
              local HealthMax = UnitHealthMax(Focus) / 1000
              _G[Focus .. "FrameHealthBar"].TextString:SetText(Health .. " / " .. format("%.0f", HealthMax) .. "k (" .. format("%.0f", HealthPercent) .. "%)")
            elseif (1000000 <= UnitHealthMax(Focus)) then
              local HealthMax = UnitHealthMax(Focus) / 1000000
              _G[Focus .. "FrameHealthBar"].TextString:SetText(Health .. " / " .. format("%.0f", HealthMax) .. "m (" .. format("%.0f", HealthPercent) .. "%)")
            end
          elseif (UnitHealth(Focus) < 1000000) then
            local Health = (UnitHealth(Focus)) / 1000
            local HealthMax = (UnitHealthMax(Focus)) / 1000
            local HealthPercent = (UnitHealth(Focus) / UnitHealthMax(Focus)) * 100
            if (UnitHealthMax(Focus) < 1000000) then
              local HealthMax = (UnitHealthMax(Focus)) / 1000
              _G[Focus .. "FrameHealthBar"].TextString:SetText(format("%.0f", Health) .. "k / " .. format("%.0f", HealthMax) .. "k (" .. format("%.0f", HealthPercent) .. "%)")
            elseif (1000000 <= UnitHealthMax(Focus)) then
              local HealthMax = UnitHealthMax(Focus) / 1000000
              _G[Focus .. "FrameHealthBar"].TextString:SetText(format("%.0f", Health) .. "k / " .. format("%.0f", HealthMax) .. "m (" .. format("%.0f", HealthPercent) .. "%)")
            end
          elseif (1000000 <= UnitHealth(Focus)) then
            local Health = (UnitHealth(Focus)) / 1000000
            local HealthMax = (UnitHealthMax(Focus)) / 1000000
            local HealthPercent = (UnitHealth(Focus) / UnitHealthMax(Focus)) * 100
            _G[Focus .. "FrameHealthBar"].TextString:SetText(format("%.0f", Health) .. "m / " .. format("%.0f", HealthMax) .. "m (" .. format("%.0f", HealthPercent) .. "%)")
          end
        end
      end
      hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", UpdateHealthValues)
    end

    if (GhettoFrames2SaveX.buffsizebutton) then
      buffsizebutton:SetChecked(true)
      hooksecurefunc("TargetFrame_UpdateAuraPositions", function(self, auraName, numAuras, numOppositeAuras, largeAuraList, updateFunc, maxRowWidth, offsetX, mirrorAurasVertically)
          local AURA_OFFSET_Y = 3
          local LARGE_AURA_SIZE = GhettoFrames2SaveX.buffsize * 1.421
          local SMALL_AURA_SIZE = GhettoFrames2SaveX.buffsize
          local size
          local offsetY = AURA_OFFSET_Y
          local rowWidth = 0
          local firstBuffOnRow = 1
          for i = 1, numAuras do
            if (largeAuraList[i]) then
              size = LARGE_AURA_SIZE
              offsetY = AURA_OFFSET_Y + AURA_OFFSET_Y
            else
              size = SMALL_AURA_SIZE
            end
            if (i == 1) then
              rowWidth = size
              self.auraRows = self.auraRows + 1
            else
              rowWidth = rowWidth + size + offsetX
            end
            if (rowWidth > maxRowWidth) then
              updateFunc(self, auraName, i, numOppositeAuras, firstBuffOnRow, size, offsetX, offsetY, mirrorAurasVertically)
              rowWidth = size
              self.auraRows = self.auraRows + 1
              firstBuffOnRow = i
              offsetY = AURA_OFFSET_Y
            else
              updateFunc(self, auraName, i, numOppositeAuras, i - 1, size, offsetX, offsetY, mirrorAurasVertically)
            end
          end

        end)
      hooksecurefunc('TargetFrame_UpdateAuras', function(self)
          local frameStealable
          local frameName
          local icon
          local debuffType
          local selfName = self:GetName()
          local isEnemy = UnitIsEnemy(PlayerFrame.unit, self.unit)
          for i = 1, MAX_TARGET_BUFFS do
            _, _, icon, _, debuffType = UnitBuff(self.unit, i)
            frameName = selfName .. 'Buff' .. i
            if (icon and (not self.maxBuffs or i <= self.maxBuffs)) then
              frameStealable = _G[frameName .. 'Stealable']
              if (isEnemy and debuffType == 'Magic') then
                frameStealable:Show()
                frameStealable:SetHeight(GhettoFrames2SaveX.buffsize * 1.4)
                frameStealable:SetWidth(GhettoFrames2SaveX.buffsize * 1.4)
              else
                frameStealable:Hide()
              end
            end
          end

        end)
      buffsizer:Show()
    else
      buffsizer:Hide()

    end

  end
end
-- create addon frame
local unserFrame = CreateFrame("Frame")
unserFrame:RegisterEvent("ADDON_LOADED")

unserFrame:SetScript("OnEvent", unserAddon.Init)

-----------------------------
---##GUI FUNCTIONS##---------
-----------------------------
-- CreateGUI
function unserAddon:CreateGUI(frame)
  -- General
  local title = unserAddon:CreateFont(General, "title", "General Frame Scale", 20, -15, 25)

  local generalframescaleslider = unserAddon:CreateSlider(General, "GeneralFrameScale", "General Frame Scale", 0.5, 2, 1, 60, -70)
  generalframescaleslider:SetScript("OnValueChanged", function(self, value)
      TargetFrame:SetScale(value)
      PlayerFrame:SetScale(value)
      FocusFrame:SetScale(value)
      GhettoFrames2SaveX.framescaletarget = value
      GhettoFrames2SaveX.framescaleplayer = value
      GhettoFrames2SaveX.framescalefocus = value
      getglobal(generalframescaleslider:GetName() .. 'Text'):SetText("Frame Scale: (" .. format("%.2f", value) .. ")") ;
    end)

  local title = unserAddon:CreateFont(General, "title", "Classcolored Healthbars", 20, -290, 25)

  local Unlock = CreateFrame("CheckButton", "classcolorcheck", General, "UICheckButtonTemplate")
  Unlock:ClearAllPoints()
  Unlock:SetPoint("CENTER", -280, -60)
  _G[Unlock:GetName() .. "Text"]:SetText("Classcolored Healthbars")
  function Unlock:OnClick()
    GhettoFrames2SaveX.classcolor = Unlock:GetChecked() ;
    ReloadUI() ;
  end
  Unlock:SetScript("OnClick", Unlock.OnClick)

  -- TargetFrame Settings
  local title = unserAddon:CreateFont(TargetCastbar, "title", "Target Frame Scale", 20, -15, 15)

  --targetframescaleslider
  local targetscaleslider = unserAddon:CreateSlider(TargetCastbar, "TargetScale", "TargetFrame Scale", 0.5, 2, GhettoFrames2SaveX.framescaletarget, 60, -70)
  targetscaleslider:SetScript("OnValueChanged", function(self, value)
      TargetFrame:SetScale(value)
      GhettoFrames2SaveX.framescaletarget = value
      getglobal(targetscaleslider:GetName() .. 'Text'):SetText("Target Frame Scale: (" .. format("%.2f", value) .. ")") ;
    end)

  local title = unserAddon:CreateFont(TargetCastbar, "title", "Classcolored Target Healtbar", 20, -125, 15)

  --targetclasscolorcheck
  local TargetClasscolorcheck = CreateFrame("CheckButton", "targetclasscolorcheck", TargetCastbar, "UICheckButtonTemplate")
  TargetClasscolorcheck:ClearAllPoints()
  TargetClasscolorcheck:SetPoint("CENTER", -280, 105)
  _G[TargetClasscolorcheck:GetName() .. "Text"]:SetText("Classcolored Target Healthbar")
  function TargetClasscolorcheck:OnClick()
    GhettoFrames2SaveX.classcolortarget = TargetClasscolorcheck:GetChecked() ;
    ReloadUI() ;
  end
  TargetClasscolorcheck:SetScript("OnClick", TargetClasscolorcheck.OnClick)

  local title = unserAddon:CreateFont(TargetCastbar, "title", "Target Castbar Position", 20, -285, 15)

  --tcbup
  local tcbup = unserAddon:CreateButton(TargetCastbar, "tcbup", "Up", 90, 35, 105, -320)
  tcbup:SetScript("OnClick", function() unserAddon:tcbup() end)
  --tcbdown
  local tcbdown = unserAddon:CreateButton(TargetCastbar, "tcbdown", "Down", 90, 35, 105, -380)
  tcbdown:SetScript("OnClick", function() unserAddon:tcbdown() end)
  --tcbright
  local tcbright = unserAddon:CreateButton(TargetCastbar, "tcbright", "Right", 90, 35, 190, -350)
  tcbright:SetScript("OnClick", function() unserAddon:tcbright() end)
  --tcbleft
  local tcbleft = unserAddon:CreateButton(TargetCastbar, "tcbleft", "Left", 90, 35, 20, -350)
  tcbleft:SetScript("OnClick", function() unserAddon:tcbleft() end)

  local positiontext = unserAddon:CreateFont(TargetCastbar, "positiontext", "TargetFrame", 111, -360, 12)

  --FocusFrameSettings

  local title = unserAddon:CreateFont(GhettoFocusFrame, "title", "Focus Frame Scale", 20, -15, 15)

  --focusframescaleslider
  local targetscaleslider2 = unserAddon:CreateSlider(GhettoFocusFrame, "Target2Scale", "FocusFrame Scale", 0.5, 2, GhettoFrames2SaveX.framescalefocus, 60, -70)
  targetscaleslider2:SetScript("OnValueChanged", function(self, value)
      FocusFrame:SetScale(value)
      GhettoFrames2SaveX.framescalefocus = value
      getglobal(targetscaleslider2:GetName() .. 'Text'):SetText("Focus Frame ScaleFrame Scale: (" .. format("%.2f", value) .. ")") ;
    end)

  local title = unserAddon:CreateFont(GhettoFocusFrame, "title", "Classcolored Focus Healtbar", 20, -125, 15)

  --focustclasscolorcheck
  local FocusClasscolorcheck = CreateFrame("CheckButton", "focusclasscolorcheck", GhettoFocusFrame, "UICheckButtonTemplate")
  FocusClasscolorcheck:ClearAllPoints()
  FocusClasscolorcheck:SetPoint("CENTER", -280, 105)
  _G[FocusClasscolorcheck:GetName() .. "Text"]:SetText("Classcolored Focus Healthbar")
  function FocusClasscolorcheck:OnClick()
    GhettoFrames2SaveX.classcolorFocus = FocusClasscolorcheck:GetChecked() ;
    ReloadUI() ;
  end
  FocusClasscolorcheck:SetScript("OnClick", FocusClasscolorcheck.OnClick)

  local title = unserAddon:CreateFont(GhettoFocusFrame, "title", "Focus Castbar Position", 20, -285, 15)

  --fcbup
  local fcbup = unserAddon:CreateButton(GhettoFocusFrame, "fcbup", "Up", 90, 35, 105, -320)
  fcbup:SetScript("OnClick", function() unserAddon:fcbup() end)
  --fcbdown
  local fcbdown = unserAddon:CreateButton(GhettoFocusFrame, "fcbdown", "Down", 90, 35, 105, -380)
  fcbdown:SetScript("OnClick", function() unserAddon:fcbdown() end)
  --fcbright
  local fcbright = unserAddon:CreateButton(GhettoFocusFrame, "fcbright", "Right", 90, 35, 190, -350)
  fcbright:SetScript("OnClick", function() unserAddon:fcbright() end)
  --fcbleft
  local tcbleft = unserAddon:CreateButton(GhettoFocusFrame, "fcbleft", "Left", 90, 35, 20, -350)
  fcbleft:SetScript("OnClick", function() unserAddon:fcbleft() end)

  local positiontext = unserAddon:CreateFont(GhettoFocusFrame, "positiontext", "FocusFrame", 111, -360, 12)

  --Random Settings
  local title = unserAddon:CreateFont(GhettoPlayerFrame, "title", "Show Player Name", 20, -15, 15)
  local Unlock2 = CreateFrame("CheckButton", "playernamecheck", GhettoPlayerFrame, "UICheckButtonTemplate")
  Unlock2:ClearAllPoints()
  Unlock2:SetPoint("CENTER", -280, 225)
  _G[Unlock2:GetName() .. "Text"]:SetText("Show Player Name")
  function Unlock2:OnClick()
    GhettoFrames2SaveX.playername = Unlock2:GetChecked() ;
    if (GhettoFrames2SaveX.playername) then

      PlayerName:Show()
      playernamecheck:SetChecked(true)
    else
      PlayerName:Hide()

    end
  end
  Unlock2:SetScript("OnClick", Unlock2.OnClick)

  --Random Settings
  local title = unserAddon:CreateFont(GhettoPetFrame, "title", "Show Pet Name", 20, -15, 15)
  local Unlock3 = CreateFrame("CheckButton", "petnamecheck", GhettoPetFrame, "UICheckButtonTemplate")
  Unlock3:ClearAllPoints()
  Unlock3:SetPoint("CENTER", -280, 225)
  _G[Unlock3:GetName() .. "Text"]:SetText("Show Pet Name")
  function Unlock3:OnClick()
    GhettoFrames2SaveX.petname = Unlock3:GetChecked() ;
    if (GhettoFrames2SaveX.petname) then

      PetName:Show()
      petnamecheck:SetChecked(true)
    else
      PetName:Hide()

    end
  end
  Unlock3:SetScript("OnClick", Unlock3.OnClick)

  --playerclasscolorcheck
  local title = unserAddon:CreateFont(GhettoPlayerFrame, "title", "Classcolored Player Healthbar", 20, -115, 15)
  local PlayerClasscolorcheck = CreateFrame("CheckButton", "PlayerClasscolorcheck", GhettoPlayerFrame, "UICheckButtonTemplate")
  PlayerClasscolorcheck:ClearAllPoints()
  PlayerClasscolorcheck:SetPoint("CENTER", -280, 115)
  _G[PlayerClasscolorcheck:GetName() .. "Text"]:SetText("Classcolored Player Healthbar")
  function PlayerClasscolorcheck:OnClick()
    GhettoFrames2SaveX.classcolorplayer = PlayerClasscolorcheck:GetChecked() ;
    ReloadUI() ;
  end
  PlayerClasscolorcheck:SetScript("OnClick", PlayerClasscolorcheck.OnClick)

  --playerpercentcolor
  local title = unserAddon:CreateFont(GhettoPlayerFrame, "title", "Player Healthbarcolor based on current Health", 20, -215, 15)
  local PlayerPercentcolorcheck = CreateFrame("CheckButton", "PlayerPercentcolorcheck", GhettoPlayerFrame, "UICheckButtonTemplate")
  PlayerPercentcolorcheck:ClearAllPoints()
  PlayerPercentcolorcheck:SetPoint("CENTER", -280, 25)
  _G[PlayerPercentcolorcheck:GetName() .. "Text"]:SetText("Player Healthbarcolor based on current Health")
  function PlayerPercentcolorcheck:OnClick()
    GhettoFrames2SaveX.percentcolorplayer = PlayerPercentcolorcheck:GetChecked() ;
    ReloadUI() ;
  end
  PlayerPercentcolorcheck:SetScript("OnClick", PlayerPercentcolorcheck.OnClick)

  --petpercentcolor
  local title = unserAddon:CreateFont(GhettoPetFrame, "title", "Pet Healthbarcolor based on current Health", 20, -215, 15)
  local PetPercentcolorcheck = CreateFrame("CheckButton", "PetPercentcolorcheck", GhettoPetFrame, "UICheckButtonTemplate")
  PetPercentcolorcheck:ClearAllPoints()
  PetPercentcolorcheck:SetPoint("CENTER", -280, 25)
  _G[PetPercentcolorcheck:GetName() .. "Text"]:SetText("Pet Healthbarcolor based on current Health")
  function PetPercentcolorcheck:OnClick()
    GhettoFrames2SaveX.percentcolorpet = PetPercentcolorcheck:GetChecked() ;
    ReloadUI() ;
  end
  PetPercentcolorcheck:SetScript("OnClick", PetPercentcolorcheck.OnClick)

  --targetpercentcolor
  local title = unserAddon:CreateFont(TargetCastbar, "title", "Target Healthbarcolor based on current Health", 20, -215, 15)
  local TargetPercentcolorcheck = CreateFrame("CheckButton", "TargetPercentcolorcheck", TargetCastbar, "UICheckButtonTemplate")
  TargetPercentcolorcheck:ClearAllPoints()
  TargetPercentcolorcheck:SetPoint("CENTER", -280, 25)
  _G[TargetPercentcolorcheck:GetName() .. "Text"]:SetText("Target Healthbarcolor based on current Health")
  function TargetPercentcolorcheck:OnClick()
    GhettoFrames2SaveX.percentcolortarget = TargetPercentcolorcheck:GetChecked() ;
    ReloadUI() ;
  end
  TargetPercentcolorcheck:SetScript("OnClick", TargetPercentcolorcheck.OnClick)

  --targetTOTpercentcolor

  local TargetToTPercentcolorcheck = CreateFrame("CheckButton", "TargetToTPercentcolorcheck", TargetCastbar, "UICheckButtonTemplate")
  TargetToTPercentcolorcheck:ClearAllPoints()
  TargetToTPercentcolorcheck:SetPoint("CENTER", 0, 25)
  _G[TargetToTPercentcolorcheck:GetName() .. "Text"]:SetText("Target of Target Healthbarcolor based on current Health")
  function TargetToTPercentcolorcheck:OnClick()
    GhettoFrames2SaveX.percentcolortargettot = TargetToTPercentcolorcheck:GetChecked() ;
    ReloadUI() ;
  end
  TargetToTPercentcolorcheck:SetScript("OnClick", TargetToTPercentcolorcheck.OnClick)

  --focuspercentcolor
  local title = unserAddon:CreateFont(GhettoFocusFrame, "title", "Focus Healthbarcolor based on current Health", 20, -215, 15)
  local FocusPercentcolorcheck = CreateFrame("CheckButton", "FocusPercentcolorcheck", GhettoFocusFrame, "UICheckButtonTemplate")
  FocusPercentcolorcheck:ClearAllPoints()
  FocusPercentcolorcheck:SetPoint("CENTER", -280, 25)
  _G[FocusPercentcolorcheck:GetName() .. "Text"]:SetText("Focus Healthbarcolor based on current Health")
  function FocusPercentcolorcheck:OnClick()
    GhettoFrames2SaveX.percentcolorfocus = FocusPercentcolorcheck:GetChecked() ;
    ReloadUI() ;
  end
  FocusPercentcolorcheck:SetScript("OnClick", FocusPercentcolorcheck.OnClick)

  --focusTOTpercentcolor

  local FocusToTPercentcolorcheck = CreateFrame("CheckButton", "FocusToTPercentcolorcheck", GhettoFocusFrame, "UICheckButtonTemplate")
  FocusToTPercentcolorcheck:ClearAllPoints()
  FocusToTPercentcolorcheck:SetPoint("CENTER", 0, 25)
  _G[FocusToTPercentcolorcheck:GetName() .. "Text"]:SetText("Target of Focus Healthbarcolor based on current Health")
  function FocusToTPercentcolorcheck:OnClick()
    GhettoFrames2SaveX.percentcolorfocustot = FocusToTPercentcolorcheck:GetChecked() ;
    ReloadUI() ;
  end
  FocusToTPercentcolorcheck:SetScript("OnClick", FocusToTPercentcolorcheck.OnClick)

  --arenapercentcolor
  local title = unserAddon:CreateFont(GhettoArenaFrame, "title", "Arena Healthbarcolor based on current Health", 20, -215, 15)
  local ArenaPercentcolorcheck = CreateFrame("CheckButton", "ArenaPercentcolorcheck", GhettoArenaFrame, "UICheckButtonTemplate")
  ArenaPercentcolorcheck:ClearAllPoints()
  ArenaPercentcolorcheck:SetPoint("CENTER", -280, 25)
  _G[ArenaPercentcolorcheck:GetName() .. "Text"]:SetText("Arena Healthbarcolor based on current Health")
  function ArenaPercentcolorcheck:OnClick()
    GhettoFrames2SaveX.percentcolorarena = ArenaPercentcolorcheck:GetChecked() ;
    ReloadUI() ;
  end
  ArenaPercentcolorcheck:SetScript("OnClick", ArenaPercentcolorcheck.OnClick)

  --partypercentcolor
  local title = unserAddon:CreateFont(GhettoPartyFrame, "title", "Party Healthbarcolor based on current Health", 20, -215, 15)
  local PartyPercentcolorcheck = CreateFrame("CheckButton", "PartyPercentcolorcheck", GhettoPartyFrame, "UICheckButtonTemplate")
  PartyPercentcolorcheck:ClearAllPoints()
  PartyPercentcolorcheck:SetPoint("CENTER", -280, 25)
  _G[PartyPercentcolorcheck:GetName() .. "Text"]:SetText("Player Healthbarcolor based on current Health")
  function PartyPercentcolorcheck:OnClick()
    GhettoFrames2SaveX.percentcolorparty = PartyPercentcolorcheck:GetChecked() ;
    ReloadUI() ;
  end
  PartyPercentcolorcheck:SetScript("OnClick", PartyPercentcolorcheck.OnClick)

  --ToT=?
  local title = unserAddon:CreateFont(TargetCastbar, "title", "Show Target of Target Frame", 260, -15, 15)
  local Unlock3 = CreateFrame("CheckButton", "targettotcheck", TargetCastbar, "UICheckButtonTemplate")
  Unlock3:ClearAllPoints()
  Unlock3:SetPoint("CENTER", 10, 210)
  _G[Unlock3:GetName() .. "Text"]:SetText("Show Target of Target Frame")
  function Unlock3:OnClick()
    GhettoFrames2SaveX.targetoftarget = Unlock3:GetChecked() ;
    if (GhettoFrames2SaveX.targetoftarget) then

      TargetFrameToT:SetAlpha(100)
      targettotcheck:SetChecked(true)
    else
      TargetFrameToT:SetAlpha(0)

    end
  end
  Unlock3:SetScript("OnClick", Unlock3.OnClick)

  --FocusTot
  local title = unserAddon:CreateFont(GhettoFocusFrame, "title", "Show Target of Focus Frame", 260, -15, 15)
  local Unlock4 = CreateFrame("CheckButton", "focustotcheck", GhettoFocusFrame, "UICheckButtonTemplate")
  Unlock4:ClearAllPoints()
  Unlock4:SetPoint("CENTER", 10, 210)
  _G[Unlock4:GetName() .. "Text"]:SetText("Show Target of Focus Frame")
  function Unlock4:OnClick()
    GhettoFrames2SaveX.targetoffocus = Unlock4:GetChecked() ;
    if (GhettoFrames2SaveX.targetoffocus) then
      FocusFrameToT:SetAlpha(100)
      focustotcheck:SetChecked(true)
    else
      FocusFrameToT:SetAlpha(0)

    end
  end
  Unlock4:SetScript("OnClick", Unlock4.OnClick)

  --arenaclasscolor
  local title = unserAddon:CreateFont(GhettoArenaFrame, "title", "Classcolored Arenaframe Healthbars", 20, -295, 15)
  local arenaClasscolorcheck = CreateFrame("CheckButton", "arenaclasscolorcheck", GhettoArenaFrame, "UICheckButtonTemplate")
  arenaClasscolorcheck:ClearAllPoints()
  arenaClasscolorcheck:SetPoint("CENTER", -280, -55)
  _G[arenaClasscolorcheck:GetName() .. "Text"]:SetText("Classcolored Arena Healthbar")
  function arenaClasscolorcheck:OnClick()
    GhettoFrames2SaveX.classcolorarena = arenaClasscolorcheck:GetChecked() ;
    ReloadUI() ;
  end
  arenaClasscolorcheck:SetScript("OnClick", arenaClasscolorcheck.OnClick)

  --partyclasscolor
  local title = unserAddon:CreateFont(GhettoPartyFrame, "title", "Classcolored Partyframe Healthbars", 20, -295, 15)
  local partyClasscolorcheck = CreateFrame("CheckButton", "partyclasscolorcheck", GhettoPartyFrame, "UICheckButtonTemplate")
  partyClasscolorcheck:ClearAllPoints()
  partyClasscolorcheck:SetPoint("CENTER", -280, -55)
  _G[partyClasscolorcheck:GetName() .. "Text"]:SetText("Classcolored Party Healthbar")
  function partyClasscolorcheck:OnClick()
    GhettoFrames2SaveX.classcolorparty = partyClasscolorcheck:GetChecked() ;
    ReloadUI() ;
  end
  partyClasscolorcheck:SetScript("OnClick", partyClasscolorcheck.OnClick)

  --partyclasscolor
  --local title = unserAddon:CreateFont(General, "title", "Classcolored Partyframes", 20, -195, 15)
  --local partyClasscolorcheck = CreateFrame("CheckButton", "partyclasscolorcheck", General, "UICheckButtonTemplate")
  --partyClasscolorcheck:ClearAllPoints()
  --partyClasscolorcheck:SetPoint("CENTER", -280, 35)
  --_G[partyClasscolorcheck:GetName() .. "Text"]:SetText("Classcolored Party Healthbar")
  -- function partyClasscolorcheck:OnClick()
  -- GhettoFrames2SaveX.classcolorparty=partyClasscolorcheck:GetChecked();
  -- ReloadUI();
  --end
  --partyClasscolorcheck:SetScript("OnClick", partyClasscolorcheck.OnClick)

  --targettot classcolor
  local TtotClasscolorcheck = CreateFrame("CheckButton", "Ttotclasscolorcheck", TargetCastbar, "UICheckButtonTemplate")
  TtotClasscolorcheck:ClearAllPoints()
  TtotClasscolorcheck:SetPoint("CENTER", -80, 105)
  _G[TtotClasscolorcheck:GetName() .. "Text"]:SetText("Classcolored Target of Target Healthbar")
  function TtotClasscolorcheck:OnClick()
    GhettoFrames2SaveX.classcolorttot = TtotClasscolorcheck:GetChecked() ;
    ReloadUI() ;
  end
  TtotClasscolorcheck:SetScript("OnClick", TtotClasscolorcheck.OnClick)

  --focustot classcolor
  local FtotClasscolorcheck = CreateFrame("CheckButton", "Ftotclasscolorcheck", GhettoFocusFrame, "UICheckButtonTemplate")
  FtotClasscolorcheck:ClearAllPoints()
  FtotClasscolorcheck:SetPoint("CENTER", -80, 105)
  _G[FtotClasscolorcheck:GetName() .. "Text"]:SetText("Classcolored Target of Focus Healthbar")
  function FtotClasscolorcheck:OnClick()
    GhettoFrames2SaveX.classcolorftot = FtotClasscolorcheck:GetChecked() ;
    ReloadUI() ;
  end
  FtotClasscolorcheck:SetScript("OnClick", FtotClasscolorcheck.OnClick)

  --harmonybar etc
  local title = unserAddon:CreateFont(GhettoPlayerFrame, "title", "Show Player SpecialBar", 20, -290, 15)
  local Unlock7 = CreateFrame("CheckButton", "specialbarcheck", GhettoPlayerFrame, "UICheckButtonTemplate")
  Unlock7:ClearAllPoints()
  Unlock7:SetPoint("CENTER", -280, -50)
  _G[Unlock7:GetName() .. "Text"]:SetText("Show Player SpecialBar")
  function Unlock7:OnClick()
    GhettoFrames2SaveX.playerspecialbar = Unlock7:GetChecked() ;
    if (GhettoFrames2SaveX.playerspecialbar) then
      specialbarcheck:SetChecked(true)
      ReloadUI()
    else
      local nooop = function() return end
      for _, objname in ipairs({
          "MonkHarmonyBar",
          "PriestBarFrame",
          "PaladinPowerBar",
          "ShardBarFrame",
        }) do
        local obj = _G[objname]
        if obj then
          obj:Hide()
          obj.Show = nooop
        end
      end

    end
  end
  Unlock7:SetScript("OnClick", Unlock7.OnClick)

  local title = unserAddon:CreateFont(GhettoPlayerFrame, "title", "Player Special Bar Position", 20, -375, 15)

  --move specialbar
  local specialup = unserAddon:CreateButton(GhettoPlayerFrame, "specialup", "Up", 90, 35, 75, -410)
  specialup:SetScript("OnClick", function() unserAddon:specialup() end)
  --down
  local specialdown = unserAddon:CreateButton(GhettoPlayerFrame, "fcbdown", "Down", 90, 35, 75, -460)
  specialdown:SetScript("OnClick", function() unserAddon:specialdown() end)

  --hitindicator

  local title = unserAddon:CreateFont(GhettoPlayerFrame, "title", "PlayerFrame HitIndicators", 360, -15, 15)
  local playerhitindi = CreateFrame("CheckButton", "playerhitindi", GhettoPlayerFrame, "UICheckButtonTemplate")
  playerhitindi:ClearAllPoints()
  playerhitindi:SetPoint("CENTER", 60, 225)
  _G[playerhitindi:GetName() .. "Text"]:SetText("Hide Player Hitindicator")
  function playerhitindi:OnClick()
    GhettoFrames2SaveX.playerhitindi = playerhitindi:GetChecked() ;
    ReloadUI() ;
  end
  playerhitindi:SetScript("OnClick", playerhitindi.OnClick)

  --pethitindicator

  local title = unserAddon:CreateFont(GhettoPetFrame, "title", "PetFrame HitIndicators", 360, -15, 15)
  local pethitindi = CreateFrame("CheckButton", "pethitindi", GhettoPetFrame, "UICheckButtonTemplate")
  pethitindi:ClearAllPoints()
  pethitindi:SetPoint("CENTER", 60, 225)
  _G[pethitindi:GetName() .. "Text"]:SetText("Hide Pet Hitindicator")
  function pethitindi:OnClick()
    GhettoFrames2SaveX.pethitindi = pethitindi:GetChecked() ;
    ReloadUI() ;
  end
  pethitindi:SetScript("OnClick", pethitindi.OnClick)

  --portraitclass
  local title = unserAddon:CreateFont(General, "title", "Classportraits", 20, -380, 15)
  local portraitcheck = CreateFrame("CheckButton", "Portraitcheck", General, "UICheckButtonTemplate")
  portraitcheck:ClearAllPoints()
  portraitcheck:SetPoint("CENTER", -280, -130)
  _G[portraitcheck:GetName() .. "Text"]:SetText("Classicons instead of Portraits")
  function portraitcheck:OnClick()
    GhettoFrames2SaveX.classportraits = portraitcheck:GetChecked() ;
    ReloadUI() ;
  end
  portraitcheck:SetScript("OnClick", portraitcheck.OnClick)

  --bartexture
  local title = unserAddon:CreateFont(General, "title", "Bar Texture Style", 345, -15, 25)
  --dropdowntest
  if not DropDownMenuTest then
    CreateFrame("Frame", "DropDownMenuTest", General, "UIDropDownMenuTemplate")
  end
  DropDownMenuTest:ClearAllPoints()
  DropDownMenuTest:SetPoint("CENTER", 150, 205)
  DropDownMenuTest:Show()

  local items = {
    "Ace",--1
    "Aluminium",--2
    "Banto",--3
    "Blizzard",--4
    "Charcoal",--5
    "Glaze",--6
    "LiteStep",--7
    "Minimalist",--8
    "Otravi",--9
    "Perl",--10
    "Smooth",--11
    "Striped",--12
    "Swag",--13
  }

  local function OnClick(self)
    UIDropDownMenu_SetSelectedID(DropDownMenuTest, self:GetID())
    if (UIDropDownMenu_GetSelectedID(DropDownMenuTest) == 1) then
      GhettoFrames2SaveX.bartex = 1;
      PlayerFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Ace") ;
      PlayerFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Ace") ;
      TargetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Ace") ;
      TargetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Ace") ;
      FocusFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Ace") ;
      FocusFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Ace") ;
      TargetFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Ace") ;
      TargetFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Ace") ;
      FocusFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Ace") ;
      FocusFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Ace") ;
      PetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Ace") ;
      PetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Ace") ;
    end
    if (UIDropDownMenu_GetSelectedID(DropDownMenuTest) == 2) then
      GhettoFrames2SaveX.bartex = 2;
      PlayerFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Aluminium") ;
      PlayerFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Aluminium") ;
      TargetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Aluminium") ;
      TargetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Aluminium") ;
      FocusFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Aluminium") ;
      FocusFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Aluminium") ;
      TargetFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Aluminium") ;
      TargetFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Aluminium") ;
      FocusFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Aluminium") ;
      FocusFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Aluminium") ;
      PetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Aluminium") ;
      PetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Aluminium") ;
    end
    if (UIDropDownMenu_GetSelectedID(DropDownMenuTest) == 3) then
      GhettoFrames2SaveX.bartex = 3;
      PlayerFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\banto") ;
      PlayerFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\banto") ;
      TargetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\banto") ;
      TargetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\banto") ;
      FocusFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\banto") ;
      FocusFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\banto") ;
      TargetFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\banto") ;
      TargetFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\banto") ;
      FocusFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\banto") ;
      FocusFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\banto") ;
      PetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\banto") ;
      PetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\banto") ;
    end
    if (UIDropDownMenu_GetSelectedID(DropDownMenuTest) == 4) then
      GhettoFrames2SaveX.bartex = 4;
      PlayerFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\blizzard") ;
      PlayerFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\blizzard") ;
      TargetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\blizzard") ;
      TargetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\blizzard") ;
      FocusFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\blizzard") ;
      FocusFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\blizzard") ;
      TargetFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\blizzard") ;
      TargetFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\blizzard") ;
      FocusFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\blizzard") ;
      FocusFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\blizzard") ;
      PetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\blizzard") ;
      PetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\blizzard") ;

    end
    if (UIDropDownMenu_GetSelectedID(DropDownMenuTest) == 5) then
      GhettoFrames2SaveX.bartex = 5;
      PlayerFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Charcoal") ;
      PlayerFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Charcoal") ;
      TargetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Charcoal") ;
      TargetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Charcoal") ;
      FocusFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Charcoal") ;
      FocusFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Charcoal") ;
      TargetFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Charcoal") ;
      TargetFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Charcoal") ;
      FocusFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Charcoal") ;
      FocusFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Charcoal") ;
      PetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Charcoal") ;
      PetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Charcoal") ;
    end
    if (UIDropDownMenu_GetSelectedID(DropDownMenuTest) == 6) then
      GhettoFrames2SaveX.bartex = 6;
      PlayerFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\glaze") ;
      PlayerFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\glaze") ;
      TargetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\glaze") ;
      TargetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\glaze") ;
      FocusFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\glaze") ;
      FocusFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\glaze") ;
      TargetFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\glaze") ;
      TargetFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\glaze") ;
      FocusFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\glaze") ;
      FocusFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\glaze") ;
      PetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\glaze") ;
      PetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\glaze") ;
    end
    if (UIDropDownMenu_GetSelectedID(DropDownMenuTest) == 7) then
      GhettoFrames2SaveX.bartex = 7;
      PlayerFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\LiteStep") ;
      PlayerFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\LiteStep") ;
      TargetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\LiteStep") ;
      TargetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\LiteStep") ;
      FocusFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\LiteStep") ;
      FocusFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\LiteStep") ;
      TargetFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\LiteStep") ;
      TargetFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\LiteStep") ;
      FocusFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\LiteStep") ;
      FocusFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\LiteStep") ;
      PetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\LiteStep") ;
      PetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\LiteStep") ;
    end
    if (UIDropDownMenu_GetSelectedID(DropDownMenuTest) == 8) then
      GhettoFrames2SaveX.bartex = 8;
      PlayerFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Minimalist") ;
      PlayerFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Minimalist") ;
      TargetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Minimalist") ;
      TargetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Minimalist") ;
      FocusFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Minimalist") ;
      FocusFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Minimalist") ;
      TargetFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Minimalist") ;
      TargetFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Minimalist") ;
      FocusFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Minimalist") ;
      FocusFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Minimalist") ;
      PetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Minimalist") ;
      PetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\Minimalist") ;
    end
    if (UIDropDownMenu_GetSelectedID(DropDownMenuTest) == 9) then
      GhettoFrames2SaveX.bartex = 9;
      PlayerFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\otravi") ;
      PlayerFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\otravi") ;
      TargetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\otravi") ;
      TargetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\otravi") ;
      FocusFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\otravi") ;
      FocusFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\otravi") ;
      TargetFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\otravi") ;
      TargetFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\otravi") ;
      FocusFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\otravi") ;
      FocusFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\otravi") ;
      PetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\otravi") ;
      PetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\otravi") ;
    end
    if (UIDropDownMenu_GetSelectedID(DropDownMenuTest) == 10) then
      GhettoFrames2SaveX.bartex = 10;
      PlayerFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\perl") ;
      PlayerFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\perl") ;
      TargetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\perl") ;
      TargetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\perl") ;
      FocusFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\perl") ;
      FocusFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\perl") ;
      TargetFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\perl") ;
      TargetFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\perl") ;
      FocusFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\perl") ;
      FocusFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\perl") ;
      PetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\perl") ;
      PetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\perl") ;
    end
    if (UIDropDownMenu_GetSelectedID(DropDownMenuTest) == 11) then
      GhettoFrames2SaveX.bartex = 11;
      PlayerFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\smooth") ;
      PlayerFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\smooth") ;
      TargetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\smooth") ;
      TargetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\smooth") ;
      FocusFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\smooth") ;
      FocusFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\smooth") ;
      TargetFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\smooth") ;
      TargetFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\smooth") ;
      FocusFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\smooth") ;
      FocusFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\smooth") ;
      PetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\smooth") ;
      PetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\smooth") ;
    end
    if (UIDropDownMenu_GetSelectedID(DropDownMenuTest) == 12) then
      GhettoFrames2SaveX.bartex = 12;
      PlayerFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\striped") ;
      PlayerFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\striped") ;
      TargetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\striped") ;
      TargetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\striped") ;
      FocusFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\striped") ;
      FocusFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\striped") ;
      TargetFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\striped") ;
      TargetFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\striped") ;
      FocusFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\striped") ;
      FocusFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\striped") ;
      PetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\striped") ;
      PetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\striped") ;
    end
    if (UIDropDownMenu_GetSelectedID(DropDownMenuTest) == 13) then
      GhettoFrames2SaveX.bartex = 13;
      PlayerFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\swag") ;
      PlayerFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\swag") ;
      TargetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\swag") ;
      TargetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\swag") ;
      FocusFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\swag") ;
      FocusFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\swag") ;
      TargetFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\swag") ;
      TargetFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\swag") ;
      FocusFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\swag") ;
      FocusFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\swag") ;
      PetFrameManaBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\swag") ;
      PetFrameHealthBar:SetStatusBarTexture("Interface\\AddOns\\GhettoFrames2\\Textures\\swag") ;
    end
  end

  local function initialize(self, level)
    local info = UIDropDownMenu_CreateInfo()
    for k, v in pairs(items) do
      info = UIDropDownMenu_CreateInfo()
      info.text = v
      info.value = v
      info.func = OnClick
      UIDropDownMenu_AddButton(info, level)
    end

  end

  --UIDropDownMenu_GetSelectedID(DropDownMenuTest)

  UIDropDownMenu_Initialize(DropDownMenuTest, initialize)
  UIDropDownMenu_SetWidth(DropDownMenuTest, 100) ;
  UIDropDownMenu_SetButtonWidth(DropDownMenuTest, 124)
  UIDropDownMenu_SetSelectedID(DropDownMenuTest, GhettoFrames2SaveX.bartex)
  UIDropDownMenu_JustifyText(DropDownMenuTest, "LEFT")

  --healthformat
  local title = unserAddon:CreateFont(GhettoPlayerFrame, "title", "Player Healthbar Text Format", 295, -320, 22)
  --healthformatdropdown
  if not DropDownMenuTest2 then
    CreateFrame("Frame", "DropDownMenuTest2", GhettoPlayerFrame, "UIDropDownMenuTemplate")
  end
  DropDownMenuTest2:ClearAllPoints()
  DropDownMenuTest2:SetPoint("CENTER", 150, -100)
  DropDownMenuTest2:Show()
  local items2 = {
    "Percent",--1
    "Currenthealth",--2
    "Currenhealth + Percent",--3
    "Currenhealth + Maxhealth",--4
    "Currenhealth + Maxhealth + Percent",--5
  }
  local function OnClick(self)
    UIDropDownMenu_SetSelectedID(DropDownMenuTest2, self:GetID())
    if (UIDropDownMenu_GetSelectedID(DropDownMenuTest2) == 1) then
      GhettoFrames2SaveX.phformat = 1;
      ReloadUI()
    end
    if (UIDropDownMenu_GetSelectedID(DropDownMenuTest2) == 2) then
      GhettoFrames2SaveX.phformat = 2;
      ReloadUI()
    end
    if (UIDropDownMenu_GetSelectedID(DropDownMenuTest2) == 3) then
      GhettoFrames2SaveX.phformat = 3;
      ReloadUI()
    end
    if (UIDropDownMenu_GetSelectedID(DropDownMenuTest2) == 4) then
      GhettoFrames2SaveX.phformat = 4;
      ReloadUI()
    end
    if (UIDropDownMenu_GetSelectedID(DropDownMenuTest2) == 5) then
      GhettoFrames2SaveX.phformat = 5;
      ReloadUI()
    end
  end
  local function initialize(self, level)
    local info = UIDropDownMenu_CreateInfo()
    for k, v in pairs(items2) do
      info = UIDropDownMenu_CreateInfo()
      info.text = v
      info.value = v
      info.func = OnClick
      UIDropDownMenu_AddButton(info, level)
    end
  end

  --UIDropDownMenu_GetSelectedID(DropDownMenuTest)

  UIDropDownMenu_Initialize(DropDownMenuTest2, initialize)
  UIDropDownMenu_SetWidth(DropDownMenuTest2, 100) ;
  UIDropDownMenu_SetButtonWidth(DropDownMenuTest2, 124)
  UIDropDownMenu_SetSelectedID(DropDownMenuTest2, GhettoFrames2SaveX.phformat)
  UIDropDownMenu_JustifyText(DropDownMenuTest2, "LEFT")

  --healthformat
  local title = unserAddon:CreateFont(GhettoFocusFrame, "title", "Focus Healthbar Text Format", 295, -320, 22)
  --healthformatdropdown
  if not DropDownMenuTest3 then
    CreateFrame("Frame", "DropDownMenuTest3", GhettoFocusFrame, "UIDropDownMenuTemplate")
  end
  DropDownMenuTest3:ClearAllPoints()
  DropDownMenuTest3:SetPoint("CENTER", 150, -100)
  DropDownMenuTest3:Show()
  local function OnClick(self)
    UIDropDownMenu_SetSelectedID(DropDownMenuTest3, self:GetID())
    if (UIDropDownMenu_GetSelectedID(DropDownMenuTest3) == 1) then
      GhettoFrames2SaveX.fhformat = 1;
      ReloadUI()
    end
    if (UIDropDownMenu_GetSelectedID(DropDownMenuTest3) == 2) then
      GhettoFrames2SaveX.fhformat = 2;
      ReloadUI()
    end
    if (UIDropDownMenu_GetSelectedID(DropDownMenuTest3) == 3) then
      GhettoFrames2SaveX.fhformat = 3;
      ReloadUI()
    end
    if (UIDropDownMenu_GetSelectedID(DropDownMenuTest3) == 4) then
      GhettoFrames2SaveX.fhformat = 4;
      ReloadUI()
    end
    if (UIDropDownMenu_GetSelectedID(DropDownMenuTest3) == 5) then
      GhettoFrames2SaveX.fhformat = 5;
      ReloadUI()
    end
  end
  local function initialize(self, level)
    local info = UIDropDownMenu_CreateInfo()
    for k, v in pairs(items2) do
      info = UIDropDownMenu_CreateInfo()
      info.text = v
      info.value = v
      info.func = OnClick
      UIDropDownMenu_AddButton(info, level)
    end
  end

  --UIDropDownMenu_GetSelectedID(DropDownMenuTest)

  UIDropDownMenu_Initialize(DropDownMenuTest3, initialize)
  UIDropDownMenu_SetWidth(DropDownMenuTest3, 100) ;
  UIDropDownMenu_SetButtonWidth(DropDownMenuTest3, 124)
  UIDropDownMenu_SetSelectedID(DropDownMenuTest3, GhettoFrames2SaveX.fhformat)
  UIDropDownMenu_JustifyText(DropDownMenuTest3, "LEFT")

  --healthformat
  local title = unserAddon:CreateFont(TargetCastbar, "title", "Target Healthbar Text Format", 295, -320, 22)
  --healthformatdropdown
  if not DropDownMenuTest4 then
    CreateFrame("Frame", "DropDownMenuTest4", TargetCastbar, "UIDropDownMenuTemplate")
  end
  DropDownMenuTest4:ClearAllPoints()
  DropDownMenuTest4:SetPoint("CENTER", 150, -100)
  DropDownMenuTest4:Show()
  local function OnClick(self)
    UIDropDownMenu_SetSelectedID(DropDownMenuTest4, self:GetID())
    if (UIDropDownMenu_GetSelectedID(DropDownMenuTest4) == 1) then
      GhettoFrames2SaveX.thformat = 1;
      ReloadUI()
    end
    if (UIDropDownMenu_GetSelectedID(DropDownMenuTest4) == 2) then
      GhettoFrames2SaveX.thformat = 2;
      ReloadUI()
    end
    if (UIDropDownMenu_GetSelectedID(DropDownMenuTest4) == 3) then
      GhettoFrames2SaveX.thformat = 3;
      ReloadUI()
    end
    if (UIDropDownMenu_GetSelectedID(DropDownMenuTest4) == 4) then
      GhettoFrames2SaveX.thformat = 4;
      ReloadUI()
    end
    if (UIDropDownMenu_GetSelectedID(DropDownMenuTest4) == 5) then
      GhettoFrames2SaveX.thformat = 5;
      ReloadUI()
    end
  end
  local function initialize(self, level)
    local info = UIDropDownMenu_CreateInfo()
    for k, v in pairs(items2) do
      info = UIDropDownMenu_CreateInfo()
      info.text = v
      info.value = v
      info.func = OnClick
      UIDropDownMenu_AddButton(info, level)
    end
  end

  --UIDropDownMenu_GetSelectedID(DropDownMenuTest)

  UIDropDownMenu_Initialize(DropDownMenuTest4, initialize)
  UIDropDownMenu_SetWidth(DropDownMenuTest4, 100) ;
  UIDropDownMenu_SetButtonWidth(DropDownMenuTest4, 124)
  UIDropDownMenu_SetSelectedID(DropDownMenuTest4, GhettoFrames2SaveX.thformat)
  UIDropDownMenu_JustifyText(DropDownMenuTest4, "LEFT")

  local test123
  if (GhettoFrames2SaveX.darkentextures) then test123 = GhettoFrames2SaveX.darkentextures else test123 = 1 end

  --darkenslider
  local title = unserAddon:CreateFont(General, "title", "Darken Frame Textures", 20, -105, 25)

  local darkenslider = unserAddon:CreateSliderx(General, "darkvalue", "Darken Frame Textures", 0, 1, test123 , 60, -155)
  darkenslider:SetScript("OnValueChanged", function(self, value)
      for i, v in pairs({PlayerFrameTexture, TargetFrameTextureFrameTexture, PetFrameTexture, PartyMemberFrame1Texture, PartyMemberFrame2Texture, PartyMemberFrame3Texture, PartyMemberFrame4Texture,
          PartyMemberFrame1PetFrameTexture, PartyMemberFrame2PetFrameTexture, PartyMemberFrame3PetFrameTexture, PartyMemberFrame4PetFrameTexture, FocusFrameTextureFrameTexture,
          TargetFrameToTTextureFrameTexture, FocusFrameToTTextureFrameTexture
        }) do
        v:SetVertexColor(value, value, value)
      end
      GhettoFrames2SaveX.darkentextures = value
      getglobal(darkenslider:GetName() .. 'Text'):SetText("Darken Value") ;
    end)

  --colorpicker

  function ShowColorPicker(r, g, b, changedCallback)
    ColorPickerFrame:SetColorRGB(r, g, b) ;
    ColorPickerFrame.hasOpacity = false
    ColorPickerFrame.previousValues = {r, g, b};
    ColorPickerFrame.func, ColorPickerFrame.opacityFunc, ColorPickerFrame.cancelFunc =
    changedCallback, changedCallback, changedCallback;
    ColorPickerFrame:Hide() ; -- Need to run the OnShow handler.
    ColorPickerFrame:Show() ;
  end

  local r, g, b = 1, 1, 1

  local function myColorCallback(restore)
    local newR, newG, newB
    if restore then
      -- The user bailed, we extract the old color from the table created by ShowColorPicker.
      newR, newG, newB = unpack(restore) ;
    else
      -- Something changed
      newR, newG, newB = ColorPickerFrame:GetColorRGB() ;
    end

    -- Update our internal storage.
    r, g, b = newR, newG, newB

    GhettoFrames2SaveX.colorpickfriendr = r
    GhettoFrames2SaveX.colorpickfriendg = g
    GhettoFrames2SaveX.colorpickfriendb = b

    -- And update any UI elements that use this color...
  end

  local function myColorCallbackx(restore)
    local newR, newG, newB
    if restore then
      -- The user bailed, we extract the old color from the table created by ShowColorPicker.
      newR, newG, newB = unpack(restore) ;
    else
      -- Something changed
      newR, newG, newB = ColorPickerFrame:GetColorRGB() ;
    end

    -- Update our internal storage.
    r, g, b = newR, newG, newB

    GhettoFrames2SaveX.colorpickenemyr = r
    GhettoFrames2SaveX.colorpickenemyg = g
    GhettoFrames2SaveX.colorpickenemyb = b

    -- And update any UI elements that use this color...
  end

  --friendcolor
  local title = unserAddon:CreateFont(General, "title", "Default Friendly Healthbarcolor", 335, -200, 20)
  local colorpick = unserAddon:CreateButton(General, "colorpick", "Set Color", 90, 35, 415, -330)
  colorpick:SetScript("OnClick", function(self)
      ShowColorPicker(r, g, b, myColorCallback) ;
    end)
  --enemycolor
  local title = unserAddon:CreateFont(General, "title", "Default Enemy Healthbarcolor", 335, -300, 20)
  local colorpick = unserAddon:CreateButton(General, "colorpickx", "Set Color", 90, 35, 415, -230)
  colorpickx:SetScript("OnClick", function(self)
      ShowColorPicker(r, g, b, myColorCallbackx) ;
    end)

  local title = unserAddon:CreateFont(General, "title", "Custom Target- and Focusbuffsize", 20, -200, 15)
  local buffsizebutton = CreateFrame("CheckButton", "buffsizebutton", General, "UICheckButtonTemplate")
  buffsizebutton:ClearAllPoints()
  buffsizebutton:SetPoint("CENTER", -280, 50)
  _G[buffsizebutton:GetName() .. "Text"]:SetText("Custom Buffsize")
  function buffsizebutton:OnClick()
    GhettoFrames2SaveX.buffsizebutton = buffsizebutton:GetChecked() ;
    hooksecurefunc("TargetFrame_UpdateAuraPositions", function(self, auraName, numAuras, numOppositeAuras, largeAuraList, updateFunc, maxRowWidth, offsetX, mirrorAurasVertically)
        local AURA_OFFSET_Y = 3
        local LARGE_AURA_SIZE = GhettoFrames2SaveX.buffsize * 1.421
        local SMALL_AURA_SIZE = GhettoFrames2SaveX.buffsize
        local size
        local offsetY = AURA_OFFSET_Y
        local rowWidth = 0
        local firstBuffOnRow = 1
        for i = 1, numAuras do
          if (largeAuraList[i]) then
            size = LARGE_AURA_SIZE
            offsetY = AURA_OFFSET_Y + AURA_OFFSET_Y
          else
            size = SMALL_AURA_SIZE
          end
          if (i == 1) then
            rowWidth = size
            self.auraRows = self.auraRows + 1
          else
            rowWidth = rowWidth + size + offsetX
          end
          if (rowWidth > maxRowWidth) then
            updateFunc(self, auraName, i, numOppositeAuras, firstBuffOnRow, size, offsetX, offsetY, mirrorAurasVertically)
            rowWidth = size
            self.auraRows = self.auraRows + 1
            firstBuffOnRow = i
            offsetY = AURA_OFFSET_Y
          else
            updateFunc(self, auraName, i, numOppositeAuras, i - 1, size, offsetX, offsetY, mirrorAurasVertically)
          end
        end
      end)
    hooksecurefunc('TargetFrame_UpdateAuras', function(self)
        local frameStealable
        local frameName
        local icon
        local debuffType
        local selfName = self:GetName()
        local isEnemy = UnitIsEnemy(PlayerFrame.unit, self.unit)
        for i = 1, MAX_TARGET_BUFFS do
          _, _, icon, _, debuffType = UnitBuff(self.unit, i)
          frameName = selfName .. 'Buff' .. i
          if (icon and (not self.maxBuffs or i <= self.maxBuffs)) then
            frameStealable = _G[frameName .. 'Stealable']
            if (isEnemy and debuffType == 'Magic') then
              frameStealable:Show()
              frameStealable:SetHeight(GhettoFrames2SaveX.buffsize * 1.4)
              frameStealable:SetWidth(GhettoFrames2SaveX.buffsize * 1.4)
            else
              frameStealable:Hide()
            end
          end
        end

      end)

    buffsizer:Show()
  end
  buffsizebutton:SetScript("OnClick", buffsizebutton.OnClick)

  local buffsizestart
  if (GhettoFrames2SaveX.buffsize) then buffsizestart = GhettoFrames2SaveX.buffsize else buffsizestart = 15 end

  local buffsizer = unserAddon:CreateSlidery(General, "buffsizer", "Buffsize", 10, 30, buffsizestart , 130, -235)
  buffsizer:SetScript("OnValueChanged", function(self, value)

      GhettoFrames2SaveX.buffsize = value
      getglobal(buffsizer:GetName() .. 'Text'):SetText("Buffsize: (" .. format("%.2f", value) .. ")") ;
    end)

  -- font greeting
  local title = unserAddon:CreateFont(GhettoFrames2.panel, "title", "|cff71C671GhettoFrames2", 50, -35, 25)
  local titlea = unserAddon:CreateFont(GhettoFrames2.panel, "titlea", "|cffbbbbbbby Ghettoboyy", 50, -65, 15)


  -- These next two functions fix a bug where if you have buffs on the top of the frame, they
  -- overlap the target name. I have no idea why this fixes it because this is basically the 
  -- same code blizzard uses for target frames. ::shrugs::
  hooksecurefunc('TargetFrame_UpdateBuffAnchor', function(self, buffName, index, numDebuffs, anchorIndex, size, offsetX, offsetY, mirrorVertically)
		if not mirrorVertically then
			return
		end

		local AURA_OFFSET_Y = 3

		--For mirroring vertically
		local point, relativePoint;
		local startY, auraOffsetY;
		point = "BOTTOM";
		relativePoint = "TOP";
		startY = 0;
		if ( self.threatNumericIndicator:IsShown() ) then
			startY = startY + self.threatNumericIndicator:GetHeight();
		end
		offsetY = - offsetY;
		auraOffsetY = -AURA_OFFSET_Y;
		
		local buff = _G[buffName..index];
		if ( index == 1 ) then
			if ( UnitIsFriend("player", self.unit) or numDebuffs == 0 ) then
				-- unit is friendly or there are no debuffs...buffs start on top
				buff:SetPoint(point.."LEFT", self, relativePoint.."LEFT", AURA_START_X, startY);			
			end
		end
	end)
  hooksecurefunc('TargetFrame_UpdateDebuffAnchor', function(self, debuffName, index, numBuffs, anchorIndex, size, offsetX, offsetY, mirrorVertically)
		if not mirrorVertically then
			return
		end

		local AURA_OFFSET_Y = 3

		local buff = _G[debuffName..index];
		local isFriend = UnitIsFriend("player", self.unit);
		
		--For mirroring vertically
		local point, relativePoint;
		local startY, auraOffsetY;
		point = "BOTTOM";
		relativePoint = "TOP";
		startY = 0;
		if ( self.threatNumericIndicator:IsShown() ) then
			startY = startY + self.threatNumericIndicator:GetHeight();
		end
		offsetY = - offsetY;
		auraOffsetY = -AURA_OFFSET_Y;
		
		if ( index == 1 ) then
			if not ( isFriend and numBuffs > 0 ) then
				-- unit is not friendly or there are no buffs...debuffs start on top
				buff:SetPoint(point.."LEFT", self, relativePoint.."LEFT", AURA_START_X, startY);
			end					
		end
	end)
end

-- CreateSlider
function unserAddon:CreateSlider(frame, name, text, slidermin, slidermax, slidervalue, x, y, template)
  if (template == nil) then template = "OptionsSliderTemplate"
  end
  local slider = CreateFrame("Slider", name, frame, template) slider:SetPoint("TOPLEFT", x, y) slider:SetMinMaxValues(slidermin, slidermax) slider:SetValue(slidervalue)
  getglobal(slider:GetName() .. 'Low'):SetText('0.5') ;
  getglobal(slider:GetName() .. 'High'):SetText('2') ;
  getglobal(slider:GetName() .. 'Text'):SetText("Frame Scale: (" .. format("%.2f", slidervalue) .. ")") ;
  return (slider)
end
-- createSlider2
function unserAddon:CreateSliderx(frame, name, text, slidermin, slidermax, slidervalue, x, y, template)
  if (template == nil) then template = "OptionsSliderTemplate"
  end
  local slider = CreateFrame("Slider", name, frame, template) slider:SetPoint("TOPLEFT", x, y) slider:SetMinMaxValues(slidermin, slidermax) slider:SetValue(slidervalue)
  getglobal(slider:GetName() .. 'Low'):SetText('Dark') ;
  getglobal(slider:GetName() .. 'High'):SetText('Bright') ;
  getglobal(slider:GetName() .. 'Text'):SetText("Darken Value") ;
  return (slider)
end
-- createSlider3
function unserAddon:CreateSlidery(frame, name, text, slidermin, slidermax, slidervalue, x, y, template)
  if (template == nil) then template = "OptionsSliderTemplate"
  end
  local slider = CreateFrame("Slider", name, frame, template) slider:SetPoint("TOPLEFT", x, y) slider:SetMinMaxValues(slidermin, slidermax) slider:SetValue(slidervalue)
  getglobal(slider:GetName() .. 'Low'):SetText(slidermin) ;
  getglobal(slider:GetName() .. 'High'):SetText(slidermax) ;
  getglobal(slider:GetName() .. 'Text'):SetText("Buffsize: (" .. format("%.2f", slidervalue) .. ")") ;
  return (slider)
end

-- CreateButton --
function unserAddon:CreateButton(frame, name, text, width, height, x, y, template)
  if (template == nil) then template = "OptionsButtonTemplate"
  end
  local button = CreateFrame("Button", name, frame, template) button:SetPoint("TOPLEFT", x, y) button:SetWidth(width)
  button:SetHeight(height) button:SetText(text)
  return (button)
end

-- CreateEditBox --
function unserAddon:CreateEditBox(frame, name, width, height, x, y)
  local editBox = CreateFrame("EditBox", name, frame, "InputBoxTemplate")
  editBox:SetPoint("TOPLEFT", x, y)
  editBox:SetWidth(width)
  editBox:SetHeight(height)
  editBox:SetAutoFocus(false)
  editBox:Show()
  return(editbox)
end
-- CreateFont --
function unserAddon:CreateFont(frame, name, text, x, y, size)
  if size == nil then size = 15
  end
  local fontString = frame:CreateFontString(name) fontString:SetPoint("TOPLEFT", x, y) fontString:SetFont("Fonts\\MORPHEUS.ttf", size, "") fontString:SetText(text)
  return (fontString)
end

function unserAddon:Clear()
  editbox1:SetText("")
  editbox2:SetText("")
end

--TargetCastBar
function unserAddon:tcbdown()
  GhettoFrames2SaveX.castbx = 0
  GhettoFrames2SaveX.castby = 0
  ReloadUI()
end
function unserAddon:tcbup()
  GhettoFrames2SaveX.castbx = -15
  GhettoFrames2SaveX.castby = 55
  TargetFrameSpellBar:ClearAllPoints()
  TargetFrameSpellBar:SetPoint("CENTER", TargetFrame, "CENTER", GhettoFrames2SaveX.castbx, GhettoFrames2SaveX.castby)
  TargetFrameSpellBar.SetPoint = function() end
  ReloadUI()
end
function unserAddon:tcbright()
  GhettoFrames2SaveX.castbx = 175
  GhettoFrames2SaveX.castby = 0
  TargetFrameSpellBar:ClearAllPoints()
  TargetFrameSpellBar:SetPoint("CENTER", TargetFrame, "CENTER", GhettoFrames2SaveX.castbx, GhettoFrames2SaveX.castby)
  TargetFrameSpellBar.SetPoint = function() end
  ReloadUI()
end
function unserAddon:tcbleft()
  GhettoFrames2SaveX.castbx = -195
  GhettoFrames2SaveX.castby = 0
  TargetFrameSpellBar:ClearAllPoints()
  TargetFrameSpellBar:SetPoint("CENTER", TargetFrame, "CENTER", GhettoFrames2SaveX.castbx, GhettoFrames2SaveX.castby)
  TargetFrameSpellBar.SetPoint = function() end
  ReloadUI()
end

--FocusCastBar
function unserAddon:fcbdown()
  GhettoFrames2SaveX.fcastbx = 0
  GhettoFrames2SaveX.fcastby = 0
  ReloadUI()
end
function unserAddon:fcbup()
  GhettoFrames2SaveX.fcastbx = -15
  GhettoFrames2SaveX.fcastby = 55
  FocusFrameSpellBar:ClearAllPoints()
  FocusFrameSpellBar:SetPoint("CENTER", FocusFrame, "CENTER", GhettoFrames2SaveX.fcastbx, GhettoFrames2SaveX.fcastby)
  FocusFrameSpellBar.SetPoint = function() end
  ReloadUI()
end
function unserAddon:fcbright()
  GhettoFrames2SaveX.fcastbx = 175
  GhettoFrames2SaveX.fcastby = 0
  FocusFrameSpellBar:ClearAllPoints()
  FocusFrameSpellBar:SetPoint("CENTER", TargetFrame, "CENTER", GhettoFrames2SaveX.fcastbx, GhettoFrames2SaveX.fcastby)
  FocusFrameSpellBar.SetPoint = function() end
  ReloadUI()
end
function unserAddon:fcbleft()
  GhettoFrames2SaveX.fcastbx = -195
  GhettoFrames2SaveX.fcastby = 0
  FocusFrameSpellBar:ClearAllPoints()
  FocusFrameSpellBar:SetPoint("CENTER", TargetFrame, "CENTER", GhettoFrames2SaveX.fcastbx, GhettoFrames2SaveX.fcastby)
  FocusFrameSpellBar.SetPoint = function() end
  ReloadUI()
end

--random
function unserAddon:specialup()
  GhettoFrames2SaveX.specialx = 60
  GhettoFrames2SaveX.specialy = 40
  GhettoFrames2SaveX.monkspecialx = 50
  GhettoFrames2SaveX.monkspecialy = 45
  GhettoFrames2SaveX.palaspecialx = 50
  GhettoFrames2SaveX.palaspecialy = 55
  ReloadUI()
end
function unserAddon:specialdown()
  GhettoFrames2SaveX.specialx = 0
  GhettoFrames2SaveX.specialy = 0
  GhettoFrames2SaveX.monkspecialx = 0
  GhettoFrames2SaveX.monkspecialy = 0
  GhettoFrames2SaveX.palaspecialx = 0
  GhettoFrames2SaveX.palaspecialy = 0
  ReloadUI()
end


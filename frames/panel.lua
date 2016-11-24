
local myname, ns = ...


local BACKDROP = {
  bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
  edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
  edgeSize = 16,
  insets = {left = 4, right = 4, top = 4, bottom = 4},
	tile = true,
  tileSize = 16,
}
local BG_COLOR = TOOLTIP_DEFAULT_BACKGROUND_COLOR
local COLOR = TOOLTIP_DEFAULT_COLOR


local function CreatePanel()
  local panel = CreateFrame("Frame", nil, TradeSkillFrame)
  panel:SetWidth(250)
  panel:SetPoint("TOPLEFT", TradeSkillFrame, "TOPRIGHT", -8, -21)
  panel:SetPoint("BOTTOM", 0, 21)

  panel:SetFrameLevel(TradeSkillFrame:GetFrameLevel()-1)

  panel:SetBackdrop(BACKDROP)
  panel:SetBackdropBorderColor(COLOR.r, COLOR.g, COLOR.b)
  panel:SetBackdropColor(BG_COLOR.r, BG_COLOR.g, BG_COLOR.b)

  local scroll_frame = ns.CreateScrollFrame(panel)
  scroll_frame:SetPoint("TOPLEFT", 10, -10)
  scroll_frame:SetPoint("RIGHT", -2, 0)
end


ns.RegisterCallback("_THIS_ADDON_LOADED", CreatePanel)

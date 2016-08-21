
local myname, ns = ...


local butt = ns.NewMiniButton(TradeSkillFrame, "TOPRIGHT", -30, -2)
butt:SetText("PEx")
butt:SetWidth(30)
butt:SetHeight(18)
butt:SetScript("OnClick", function()
  if ns.panel:IsShown() then
		ns.panel:Hide()
	else
		ns.panel:Show()
	end
end)

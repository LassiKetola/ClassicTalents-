local _, U = ...

table.insert(UISpecialFrames, TalentInspectFrame)

local state = {
    ["talents"] = {},
    ["talent_specs"] = {},
    ["dual_spec_info"] = {},
    ["has_dual_spec"] = false,
    ["class_name"] = "",
    ["active_dualspec"] = 0,
    ["active_talent_spec"] = ""
}

-- *****************************************
-- *****************************************
-- **************** TALENT INSPECT FRAME ->
-- *****************************************
-- *****************************************

local TalentInspectFrame = CreateFrame("Frame", "TalentInspectFrame", UIParent, "BackdropTemplate")
TalentInspectFrame:SetPoint("CENTER")
TalentInspectFrame:SetSize(220, 270)
TalentInspectFrame:RegisterEvent("INSPECT_READY")

TalentInspectFrame:SetScript("OnEvent", function(event)
    state.talents             = U.GetPlayerTalents()
    state.talent_specs        = U.GetPlayerTalentSpecs()
    state.has_dual_spec       = U.GetPlayerDualSpec()
    state.class_name          = U.GetPlayerClass("player")
    state.active_dualspec     = U.GetPlayerActiveDualSpec()
    state.active_talent_spec  = U.GetPlayerActiveTalentSpec()
    
    -- (state.class_name, state.active_talent_spec, state.active_dualspec)

    if state.has_dual_spec then
        DualSpecFrame:Show()
        state.dual_spec_info = U.GetDualSpecData()
        U.SetDualSpecTalents(state.dual_spec_info, state.active_dualspec)
    else
        DualSpecFrame:Hide()
    end

    U.ClearAllTalents()
    U.SetTalentTreeBackground(state.class_name, state.active_talent_spec)
    U.SetTalentTabs(state.talent_specs, state.active_talent_spec)
    U.SetActiveTab(state.active_talent_spec)
    U.SetNewTalents(state.talents[state.active_talent_spec])
    U.SetTalentPointsValue(
        state.active_talent_spec,
        U.GetNumTalents(state.talents[state.active_talent_spec])
    )
    
    TalentGridFrame:SetParent(InspectPaperDollFrame)
    TalentGridFrame:SetPoint("CENTER", 275, 25)
    TalentGridToggleButton:SetParent(InspectPaperDollFrame)
    TalentGridToggleButton:SetPoint("TOPRIGHT", -40, -43)
    TalentGridToggleButton:SetFrameStrata("HIGH")
    TalentGridToggleButton:SetFrameLevel(20)
    TalentGridFrame:Show()
end)

-- *****************************************
-- *****************************************
-- ************************ TALENT TABS ->
-- *****************************************
-- *****************************************

for i = 1, 3 do
    local f = CreateFrame("Button", "TAB" .. i, TalentGridFooter, "BackdropTemplate")
    f:SetBackdrop({
        bgFile = "Interface/FrameGeneral/UI-Background-TestWatermark",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize = 12,
        insets = {left = 2, right = 2, top = 2, bottom = 2}
    })
    f.text = f:CreateFontString(nil, "ARTWORK")
    f.text:SetFont("Fonts\\FRIZQT__.TTF", 8, "OUTLINE")
    f.text:SetPoint("BOTTOM", 0, 7)
    f.text:SetText(i)
    f.text:SetTextColor(100, 100, 0, 1)
    f:SetPoint("TOPLEFT", 10, -10)
    f:SetSize(f.text:GetStringWidth() + 15, 25)
    f:EnableMouse(true)
    f:SetFrameLevel(0)
    f:SetBackdropColor(0, 0, 0, 1)
    f:SetBackdropBorderColor(0.5, 0.5, 0.5, 1)

    function f:SetTabText(str)
        f.text:SetText(str)
        U.UpdateTabPosition()
    end

    function f:Toggle(spec)
        U.OnToggleTab(i)
    end

    f:SetScript("OnClick", function(self)
        f:Toggle(i)
        state.active_talent_spec = self.text:GetText()
        U.SetTalentTreeBackground(state.class_name, state.active_talent_spec)
        U.ClearAllTalents()
        U.SetNewTalents(state.talents[self.text:GetText()])
        U.SetTalentPointsValue(
            state.active_talent_spec,
            U.GetNumTalents(state.talents[self.text:GetText()])
        )
    end)

    f:SetScript("OnEnter", function()
        U.OnMouseOverTab(i)
    end)

    f:SetScript("OnLeave", function()
        U.OnMouseLeaveTab(i)
    end)
end

-- *****************************************
-- *****************************************
-- ********************* DUAL SPEC TABS ->
-- *****************************************
-- *****************************************

local DualSpecFrame = CreateFrame("Frame", "DualSpecFrame", TalentGridFrame, "BackdropTemplate")
DualSpecFrame:SetSize(30, 60)
DualSpecFrame:SetPoint("TOPRIGHT", 31, 0)

for i = 1, 2 do
    local f = CreateFrame("Button", "DUALSPEC_TAB" .. i, DualSpecFrame, "BackdropTemplate")
    f:SetBackdrop({
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize = 12,
        insets = {left = 2, right = 2, top = 2, bottom = 2}
     })
    f:SetPoint("TOPLEFT", 0, -(30 * (i - 1)))
    f:SetSize(30, 30)
    f:SetBackdropBorderColor(5, 5, 5, 1)

    local iconFrame = CreateFrame("Frame", "DUALSPEC_TAB_ICON" .. i, f)
    iconFrame:SetSize(28, 28)
    iconFrame:SetPoint("CENTER")
    iconFrame.texture = iconFrame:CreateTexture()
    iconFrame.texture:SetAllPoints(iconFrame)
    iconFrame.texture:SetTexture(134532)
    iconFrame.texture:SetDesaturated(true)

    function f:SetIcon(texture)
        iconFrame.texture:SetTexture(texture)
    end

    function f:Toggle(i)
        for x = 1, 2 do
            local f = _G["DUALSPEC_TAB_ICON" .. x]
            if x == i then
                f.texture:SetDesaturated(false)
                f:SetAlpha(1)
            else
                f.texture:SetDesaturated(true)
                f:SetAlpha(0.5)
            end
        end
    end

    f:SetScript("OnClick", function()
        state.talents = U.GetPlayerTalents(i)
        f:Toggle(i)
        U.ClearAllTalents()
        U.SetNewTalents(state.talents[state.active_talent_spec])
        U.SetActiveTab(state.active_talent_spec)
        U.SetTalentPointsValue(
            state.active_talent_spec,
            U.GetNumTalents(state.talents[state.active_talent_spec])
        )
    end)
end
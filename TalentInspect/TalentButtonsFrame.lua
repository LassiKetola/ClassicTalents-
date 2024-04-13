local _, U = ...
local GRID_WIDTH = 195
local GRID_HEIGHT = 420
local BUTTON_WIDTH = 48
local BUTTON_HEIGHT = 55

-- "Interface/Icons/INV_Misc_Rune_06" SOD RUNE

local TalentGridFrame = CreateFrame("Frame", "TalentGridFrame", TalentInspectFrame, "InsetFrameTemplate")
TalentGridFrame:SetSize(220, 270)
TalentGridFrame:SetPoint("CENTER")
TalentGridFrame:Hide()

local TalentGridToggleButton = CreateFrame("Button", "TalentGridToggleButton", TalentInspectFrame, "BackdropTemplate")
TalentGridToggleButton:SetSize(28, 28)
TalentGridToggleButton:SetBackdrop({
    bgFile = "Interface/TutorialFrame/UI-TutorialFrame-Shoot01",
    edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
    edgeSize = 2,
    insets = { left = 1, right = 1, top = 1, bottom = 1 }
})
TalentGridToggleButton:SetBackdropBorderColor(0, 0, 0, 1)
TalentGridToggleButton:EnableMouse(true)
TalentGridToggleButton:SetAlpha(0.6)

TalentGridToggleButton:SetScript("OnClick", function(self)
    if TalentGridFrame:IsVisible() then
        TalentGridFrame:Hide()
    else
        TalentGridFrame:Show()
    end
end)

TalentGridToggleButton:SetScript("OnEnter", function()
    TalentGridToggleButton:SetAlpha(1)
end)

TalentGridToggleButton:SetScript("OnLeave", function()
    TalentGridToggleButton:SetAlpha(0.8)
end)


--------********* HEADER
local TalentGridHeader = CreateFrame("Frame", "TalentGridHeader", TalentGridFrame, "HorizontalBarTemplate")
TalentGridHeader:SetSize(220, 15)
TalentGridHeader:SetPoint("TOPLEFT", 0, 15)
TalentGridHeader:SetFrameLevel(0)

--------********* HEADER TITLE
local TalentGridTitle = CreateFrame("Frame", "TalentGridHeader", TalentGridHeader, "InsetFrameTemplate")
TalentGridTitle:SetSize(220, 15)
TalentGridTitle:SetPoint("TOPLEFT", 0, 5)
TalentGridTitle:SetFrameLevel(2)
TalentGridTitle.text = TalentGridTitle:CreateFontString(nil, "ARTWORK") 
TalentGridTitle.text:SetFont("Fonts\\FRIZQT__.TTF", 9, "OUTLINE")
TalentGridTitle.text:SetPoint("CENTER")
TalentGridTitle.text:SetText("Talents")
TalentGridTitle.text:SetTextColor(100, 100, 0, 1)


--------********* FOOTER
local TalentGridFooter = CreateFrame("Frame", "TalentGridFooter", TalentGridFrame, "InsetFrameTemplate")
TalentGridFooter:SetSize(220, 15)
TalentGridFooter:SetPoint("TOPLEFT", 0, -270)
TalentGridFooter:SetFrameLevel(1)

--------********* FOOTER INFORMATION
local TalentInformationTable = CreateFrame("Frame", "TalentInformationTable", TalentGridFooter, "BackdropTemplate")
TalentInformationTable:SetSize(211, 10)
TalentInformationTable:SetPoint("TOPLEFT", 4, -3)
TalentInformationTable:SetBackdrop({
    bgFile = "Interface/Tooltips/UI-Tooltip-Background",
    edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
    edgeSize = 2
})
TalentInformationTable:SetBackdropBorderColor(100, 100, 0, 1)
TalentInformationTable:SetBackdropColor(0, 0, 0, 1)
TalentInformationTable.text = TalentInformationTable:CreateFontString(nil,"ARTWORK") 
TalentInformationTable.text:SetFont("Fonts\\FRIZQT__.TTF", 8, "OUTLINE")
TalentInformationTable.text:SetPoint("LEFT", 6, 0)
TalentInformationTable.text:SetText("Retribution Talents: 0")
TalentInformationTable.text:SetTextColor(100, 100, 0, 1)

--------********* GRID SCROLL LAYER
local TalentScrollLayer = CreateFrame("Frame", "TalentScrollLayer", TalentGridFrame, "BackdropTemplate")
TalentScrollLayer:SetSize(GRID_WIDTH, GRID_HEIGHT)
TalentScrollLayer:SetPoint("TOPLEFT")
TalentScrollLayer:SetFrameLevel(1)

-- ****************** GRID SCROLLBAR CLASS TEXTURE
TalentGridFrame.topleft = TalentGridFrame:CreateTexture()
TalentGridFrame.topleft:SetPoint("TOPLEFT", 4, -4)
TalentGridFrame.topleft:SetSize(156, 215)

TalentGridFrame.topright = TalentGridFrame:CreateTexture()
TalentGridFrame.topright:SetPoint("TOPLEFT", 160, -4)
TalentGridFrame.topright:SetSize(49, 215)

TalentGridFrame.bottomleft = TalentGridFrame:CreateTexture()
TalentGridFrame.bottomleft:SetPoint("TOPLEFT", 4, -219)
TalentGridFrame.bottomleft:SetSize(156, 80)

TalentGridFrame.bottomright = TalentGridFrame:CreateTexture()
TalentGridFrame.bottomright:SetPoint("TOPLEFT", 160, -219)
TalentGridFrame.bottomright:SetSize(49, 80)

local scrollFrame = CreateFrame("ScrollFrame", nil, TalentGridFrame, "ListScrollFrameTemplate")
scrollFrame:SetPoint("TOPLEFT", 3, -4)
scrollFrame:SetPoint("BOTTOMRIGHT", -27, 4)

FauxScrollFrame_Update(scrollFrame, 28, 4, 6)

local scrollChild = CreateFrame("Frame")
scrollFrame:SetScrollChild(TalentScrollLayer)
scrollChild:SetWidth(TalentScrollLayer:GetWidth() - 18)

-- ******************** CREATE GRID
for x = 1, 7 do
    local row = CreateFrame("Frame", "TalentRowFrame" .. x, TalentScrollLayer, "BackdropTemplate")
    row:SetPoint("TOPLEFT", 0, -((x - 1) * 55))
    row:SetSize(GRID_WIDTH, BUTTON_HEIGHT)
    row:SetFrameLevel(5)

    for y = 1, 4 do
        local cell = CreateFrame("Frame", "TalentCellFrame" .. x .. y, row, "BackdropTemplate")
        cell:EnableMouse(true)
        cell:SetSize(BUTTON_WIDTH, BUTTON_HEIGHT)
        cell:SetPoint("TOPLEFT", 48 * (y - 1), 0)

        local cellTalent = CreateFrame("Frame", nil, cell, "BackdropTemplate")
        cellTalent:SetPoint("CENTER")
        cellTalent:SetSize(32, 32)
        cellTalent.texture = cellTalent:CreateTexture()
        cellTalent.texture:SetAllPoints(cellTalent)
        cellTalent.texture:SetDesaturated(true)

        local cellTalentBorder = CreateFrame("Frame", nil, cellTalent, "BackdropTemplate")
        cellTalentBorder:SetSize(37, 37)
        cellTalentBorder:SetPoint("CENTER")

        local rankFrame = CreateFrame("Frame", nil, cellTalent, "BackdropTemplate")
        rankFrame:SetPoint("BOTTOMRIGHT", 5, -5)
        rankFrame.text = rankFrame:CreateFontString(nil,"ARTWORK") 
        rankFrame.text:SetFont("Fonts\\FRIZQT__.TTF", 8, "OUTLINE")
        rankFrame.text:SetPoint("CENTER", 1, 0)

        function cell:SetIcon(icon)
            cellTalent.texture:SetTexture(icon)
        end

        function cell:SetActive(bool)
            cellTalent.texture:SetDesaturated(bool)
        end

        function cell:ClearIcon()
            cellTalent.texture:SetTexture(0)
        end

        function cell:SetBackdropBorder(r, g, b, a)
            cellTalentBorder:SetBackdrop({
                edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                edgeSize = 10,
                insets = { left = 4, right = 4, top = 4, bottom = 4 },
            })
            cellTalentBorder:SetBackdropBorderColor(r, g, b, a)
        end

        function cell:HideRank()
            rankFrame:Hide()
        end

        function cell:SetRank(rank, maxRank)
            rankFrame:Show()
            rankFrame:SetSize(12, 12)
            rankFrame:SetBackdrop({
                bgFile = "Interface/FrameGeneral/UI-Background-Rock",
                edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                edgeSize = 4,
                insets = { left = 1, right = 1, top = 1, bottom = 1 },
            })
            rankFrame:SetBackdropBorderColor(100, 100, 0, 1)
            rankFrame:SetBackdropColor(0, 0, 0, 1)
            rankFrame:SetFrameLevel(15)
            rankFrame.text:SetText(rank)
            if rank == maxRank then
                rankFrame.text:SetTextColor(100, 100, 0, 1)
            else
                rankFrame.text:SetTextColor(0, 100, 0, 1)
            end
        end
    end
end
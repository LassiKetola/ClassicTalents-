local _, U = ...
table.insert(UISpecialFrames, TalentInspectFrame)

-- "Interface/Icons/INV_Misc_Rune_06" SOD CLASSIC RUNE
-- active "Interface/FrameGeneral/UI-Background-Marble"
-- disabled "Interface/FrameGeneral/UI-Background-TestWatermark"
-- "Interface/FrameGeneral/UIFrameIconBorder"
-- "Interface/Tooltips/UI-Tooltip-Border"

local GetNumTalents = function(talents)
    local n = 0
    for _, talent in pairs(talents) do
        n = n + talent.rank
    end
    return n
end

local SetTalentTabs = function(tabs)
    for key, value in pairs(tabs) do
        _G["TAB" .. key]:SetTabText(value)
    end
end

local SetActiveTab = function(spec)
    for i = 1, 3 do
        local f = _G["TAB" .. i]
        if f.text:GetText() == spec then
            f:Toggle(i)
        end
    end
end

local ClearAllTalents = function()
    for x = 1, 7 do
        for y = 1, 4 do
            local f = _G["TalentCellFrame" .. x .. y]
            f:ClearIcon()
            f:SetBackdropBorder(0, 0, 0, 0)
            f:SetActive(true)
            f:SetRank(0, 0)
            f:HideRank()
        end
    end
end

local SetTalent = function(talent)
    local f = _G["TalentCellFrame" .. talent.row .. talent.cell]
    if talent.name ~= nil then
        f:SetIcon(talent.icon)
        f:SetBackdropBorder(25, 25, 25, 1)
        if talent.rank ~= 0 then
            f:SetActive(false)
            f:SetBackdropBorder(100, 100, 0, 1)
            f:SetRank(talent.rank, talent.max_rank)
        end
    end
end

local SetTalentPointsValue = function(spec, value)
    _G["TalentInformationTable"].text:SetText(spec .. " Talents: " .. value)
end

local SetNewTalents = function(talents)
    for key, talent in pairs(talents) do
        SetTalent(talent)
    end
end

local SetDualSpecTalents = function(specs, specIndex)
    for idx, talents in ipairs(specs) do
        local f = _G["DUALSPEC_TAB" .. idx]
        f:SetIcon(talents.icon)
        if idx == specIndex then
            f:Toggle(idx)
        end
    end
end

function GetPlayerTalents(specIndex)
    local new_list = {}
    for x = 1, 3 do
        local active_spec
        local spec = GetTalentTabInfo(x, true, false, active_spec)
        if specIndex ~= nil then
            active_spec = specIndex
        else
            active_spec = GetActiveTalentGroup(true)
        end
        new_list[spec] = {}
        for y = 1, 28 do
            local name, icon, row, cell, rank, max_rank = GetTalentInfo(x, y, true, 1, active_spec)
            if name ~= nil then
                table.insert(new_list[spec], {
                    ["name"] = name,
                    ["icon"] = icon,
                    ["row"] = row,
                    ["cell"] = cell,
                    ["rank"] = rank,
                    ["max_rank"] = max_rank
                })
            end
        end
    end
    return new_list
end


function GetDualSpecData()
    local result = {
        [1] = {}, 
        [2] = {}
    }
    local initial_points1 = 0
    local initial_points2 = 0
    for i = 1, 3 do
        
        local spec1, icon1, points1 = GetTalentTabInfo(i, true, false, 1)
        local spec2, icon2, points2 = GetTalentTabInfo(i, true, false, 2)
        local _points1 = tonumber(points1)
        local _points2 = tonumber(points2)
        if _points1 > initial_points1 then
            initial_points1 = _points1
            result[1] = {
                ["spec"] = spec1,
                ["icon"] = icon1,
                ["points"] = points1
            }
        end
        if _points2 > initial_points2 then
            initial_points2 = _points2
            result[2] = {
                ["spec"] = spec2,
                ["icon"] = icon2,
                ["points"] = points2
            }
        end
    end
    return result
end


function GetPlayerTalentSpecs()
    local new_list = {}
    for i = 1, 3 do
        local name = GetTalentTabInfo(i, true)
        new_list[i] = name
    end
    return new_list
end

function GetPlayerClass()
    local class = UnitClass("target")
    return class
end

function GetPlayerActiveDualSpec()
    local index = GetActiveTalentGroup(true)
    return index
end

function GetPlayerActiveTalentSpec()
    local activeGroup = GetActiveTalentGroup(true) -- // true = INSPECT
    print(activeGroup)
    local activeSpec = ""
    local specPoints = 0
    for x = 1, 3 do
        print("before spec, icon, points")
        local id, name, desc, iconTexture, pointsSpent = GetTalentTabInfo(x, true, false, activeGroup)
        print(name, desc, pointsSpent)
        local _points = tonumber(pointsSpent)
        if _points > specPoints then
            activeSpec = name
            specPoints = _points
            print(activeSpec, specPoints)
            print("------------------")
        end
    end
    print(activeSpec)
    return activeSpec
end

function GetPlayerDualSpec()
    local num = GetNumTalentGroups(true)
    return num == 2
end

function UpdateTabPosition()
    local PADDING = 20
    local MARGIN_RIGHT = 2
    for i = 1, 3 do
        local tab = _G["TAB" .. i]
        local prevTab = _G["TAB" .. i - 1]
        tab:ClearAllPoints()
        if i == 1 then
            tab:SetSize(tab.text:GetStringWidth() + PADDING, 25)
            tab:SetPoint("TOPLEFT", 10, -10)
        else
            local point, relativeTo, relativePoint, xOfs, yOfs = prevTab:GetPoint(n)
            tab:SetSize(tab.text:GetStringWidth() + PADDING, 25)
            tab:SetPoint("TOPLEFT", (prevTab:GetWidth() + xOfs) + MARGIN_RIGHT, -10)
        end
    end
end

function OnToggleTab(idx)
    for i = 1, 3 do
        local f = _G["TAB" .. i]

        if i == idx then
            f:SetBackdrop({
                bgFile = "Interface/FrameGeneral/UI-Background-Rock",
                edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                edgeSize = 12,
                insets = {left = 2, right = 2, top = 2, bottom = 2}
             })
             f.text:SetTextColor(100, 100, 100, 1)

        else
            f:SetBackdrop({
                bgFile = "Interface/FrameGeneral/UI-Background-TestWatermark",
                edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                edgeSize = 12,
                insets = {left = 2, right = 2, top = 2, bottom = 2}
            })
            f.text:SetTextColor(100, 100, 0, 1)
            f:SetBackdropColor(0, 0, 0, 1)
        end
    end
end

function OnMouseOverTab(idx)
    local f = _G["TAB" .. idx]
    f:SetBackdropBorderColor(0.7, 0.7, 0.7, 1)
    f.text:SetTextColor(100, 100, 100, 1)
    
end

function OnMouseLeaveTab(idx)
    local f = _G["TAB" .. idx]
    f:SetBackdropBorderColor(0.5, 0.5, 0.5, 1)
    f.text:SetTextColor(100, 100, 0, 1)
end


U.ClearAllTalents = ClearAllTalents
U.SetNewTalents = SetNewTalents
U.SetTalentTabs = SetTalentTabs
U.SetTalentPointsValue = SetTalentPointsValue
U.SetActiveTab = SetActiveTab
U.SetDualSpecTalents = SetDualSpecTalents

U.GetNumTalents = GetNumTalents
U.GetTalentData = GetTalentData
U.GetPlayerTalents = GetPlayerTalents
U.GetPlayerTalentSpecs = GetPlayerTalentSpecs
U.GetPlayerClass = GetPlayerClass
U.GetPlayerActiveDualSpec = GetPlayerActiveDualSpec
U.GetPlayerDualSpec = GetPlayerDualSpec
U.GetPlayerActiveTalentSpec = GetPlayerActiveTalentSpec
U.GetDualSpecData = GetDualSpecData

U.UpdateTabPosition = UpdateTabPosition
U.OnToggleTab = OnToggleTab
U.OnMouseOverTab = OnMouseOverTab
U.OnMouseLeaveTab = OnMouseLeaveTab

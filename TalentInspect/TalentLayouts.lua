local _, U = ...

local TALENT_LAYOUTS = {
    ["Druid"] = {
        ["Balance"] = {
            ["topleft"] = "Interface/TalentFrame/DruidBalance-TopLeft",
            ["topright"] = "Interface/TalentFrame/DruidBalance-TopRight",
            ["bottomleft"] = "Interface/TalentFrame/DruidBalance-BottomLeft",
            ["bottomright"] = "Interface/TalentFrame/DruidBalance-BottomRight"
        },
        ["Feral Combat"] = {
            ["topleft"] = "Interface/TalentFrame/DruidFeralCombat-TopLeft",
            ["topright"] = "Interface/TalentFrame/DruidFeralCombat-TopRight",
            ["bottomleft"] = "Interface/TalentFrame/DruidFeralCombat-BottomLeft",
            ["bottomright"] = "Interface/TalentFrame/DruidFeralCombat-BottomRight"
        },
        ["Restoration"] = {
            ["topleft"] = "Interface/TalentFrame/DruidRestoration-TopLeft",
            ["topright"] = "Interface/TalentFrame/DruidRestoration-TopRight",
            ["bottomleft"] = "Interface/TalentFrame/DruidRestoration-BottomLeft",
            ["bottomright"] = "Interface/TalentFrame/DruidRestoration-BottomRight"
        }
    },
    ["Hunter"] = {
        ["Beast Mastery"] = {
            ["topleft"] = "Interface/TalentFrame/HunterBeastMastery-TopLeft",
            ["topright"] = "Interface/TalentFrame/HunterBeastMastery-TopRight",
            ["bottomleft"] = "Interface/TalentFrame/HunterBeastMastery-BottomLeft",
            ["bottomright"] = "Interface/TalentFrame/HunterBeastMastery-BottomRight"
        },
        ["Marksmanship"] = {
            ["topleft"] = "Interface/TalentFrame/HunterMarksmanship-TopLeft",
            ["topright"] = "Interface/TalentFrame/HunterMarksmanship-TopRight",
            ["bottomleft"] = "Interface/TalentFrame/HunterMarksmanship-BottomLeft",
            ["bottomright"] = "Interface/TalentFrame/HunterMarksmanship-BottomRight"
        },
        ["Survival"] = {
            ["topleft"] = "Interface/TalentFrame/HunterSurvival-TopLeft",
            ["topright"] = "Interface/TalentFrame/HunterSurvival-TopRight",
            ["bottomleft"] = "Interface/TalentFrame/HunterSurvival-BottomLeft",
            ["bottomright"] = "Interface/TalentFrame/HunterSurvival-BottomRight"
        }
    },
    ["Mage"] = {
        ["Arcane"] = {
            ["bottomleft"] = "Interface/TalentFrame/MageArcane-BottomLeft",
            ["bottomright"] = "Interface/TalentFrame/MageArcane-BottomRight",
            ["topleft"] = "Interface/TalentFrame/MageArcane-TopLeft",
            ["topright"] = "Interface/TalentFrame/MageArcane-TopRight"
        },
        ["Fire"] = {
            ["bottomleft"] = "Interface/TalentFrame/MageFire-BottomLeft",
            ["bottomright"] = "Interface/TalentFrame/MageFire-BottomRight",
            ["topleft"] = "Interface/TalentFrame/MageFire-TopLeft",
            ["topright"] = "Interface/TalentFrame/MageFire-TopRight"
        },
        ["Frost"] = {
            ["bottomleft"] = "Interface/TalentFrame/MageFrost-BottomLeft",
            ["bottomright"] = "Interface/TalentFrame/MageFrost-BottomRight",
            ["topleft"] = "Interface/TalentFrame/MageFrost-TopLeft",
            ["topright"] = "Interface/TalentFrame/MageFrost-TopRight"
        }
    },
    ["Rogue"] = {
        ["Assassination"] = {
            ["bottomleft"] = "Interface/TalentFrame/RogueAssassination-BottomLeft",
            ["bottomright"] = "Interface/TalentFrame/RogueAssassination-BottomRight",
            ["topleft"] = "Interface/TalentFrame/RogueAssassination-TopLeft",
            ["topright"] = "Interface/TalentFrame/RogueAssassination-TopRight"
        },
        ["Combat"] = {
            ["bottomleft"] = "Interface/TalentFrame/RogueCombat-BottomLeft",
            ["bottomright"] = "Interface/TalentFrame/RogueCombat-BottomRight",
            ["topleft"] = "Interface/TalentFrame/RogueCombat-TopLeft",
            ["topright"] = "Interface/TalentFrame/RogueCombat-TopRight"
        },
        ["Subtlety"] = {
            ["bottomleft"] = "Interface/TalentFrame/RogueSubtlety-BottomLeft",
            ["bottomright"] = "Interface/TalentFrame/RogueSubtlety-BottomRight",
            ["topleft"] = "Interface/TalentFrame/RogueSubtlety-TopLeft",
            ["topright"] = "Interface/TalentFrame/RogueSubtlety-TopRight"
        }
    },
    ["Warrior"] = {
        ["Arms"] = {
            ["bottomleft"] = "Interface/TalentFrame/WarriorArm-BottomLeft",
            ["bottomright"] = "Interface/TalentFrame/WarriorArm-BottomRight",
            ["topleft"] = "Interface/TalentFrame/WarriorArm-TopLeft",
            ["topright"] = "Interface/TalentFrame/WarriorArm-TopRight"
        },
        ["Fury"] = {
            ["bottomleft"] = "Interface/TalentFrame/WarriorFury-BottomLeft",
            ["bottomright"] = "Interface/TalentFrame/WarriorFury-BottomRight",
            ["topleft"] = "Interface/TalentFrame/WarriorFury-TopLeft",
            ["topright"] = "Interface/TalentFrame/WarriorFury-TopRight"
        },
        ["Protection"] = {
            ["bottomleft"] = "Interface/TalentFrame/WarriorProtection-BottomLeft",
            ["bottomright"] = "Interface/TalentFrame/WarriorProtection-BottomRight",
            ["topleft"] = "Interface/TalentFrame/WarriorProtection-TopLeft",
            ["topright"] = "Interface/TalentFrame/WarriorProtection-TopRight"
        }
    },
    ["Warlock"] = {
        ["Affliction"] = {
            ["bottomleft"] = "Interface/TalentFrame/WarlockCurses-BottomLeft",
            ["bottomright"] = "Interface/TalentFrame/WarlockCurses-BottomRight",
            ["topleft"] = "Interface/TalentFrame/WarlockCurses-TopLeft",
            ["topright"] = "Interface/TalentFrame/WarlockCurses-TopRight"
        },
        ["Destruction"] = {
            ["bottomleft"] = "Interface/TalentFrame/WarlockDestruction-BottomLeft",
            ["bottomright"] = "Interface/TalentFrame/WarlockDestruction-BottomRight",
            ["topleft"] = "Interface/TalentFrame/WarlockDestruction-TopLeft",
            ["topright"] = "Interface/TalentFrame/WarlockDestruction-TopRight"
        },
        ["Demonology"] = {
            ["bottomleft"] = "Interface/TalentFrame/WarlockSummoning-BottomLeft",
            ["bottomright"] = "Interface/TalentFrame/WarlockSummoning-BottomRight",
            ["topleft"] = "Interface/TalentFrame/WarlockSummoning-TopLeft",
            ["topright"] = "Interface/TalentFrame/WarlockSummoning-TopRight"
        }
    },
    ["Priest"] = {
        ["Discipline"] = {
            ["topleft"] = "Interface/TalentFrame/PriestDiscipline-TopLeft",
            ["topright"] = "Interface/TalentFrame/PriestDiscipline-TopRight",
            ["bottomleft"] = "Interface/TalentFrame/PriestDiscipline-BottomLeft",
            ["bottomright"] = "Interface/TalentFrame/PriestDiscipline-BottomRight"
        },
        ["Holy"] = {
            ["topleft"] = "Interface/TalentFrame/PriestHoly-TopLeft",
            ["topright"] = "Interface/TalentFrame/PriestHoly-TopRight",
            ["bottomleft"] = "Interface/TalentFrame/PriestHoly-BottomLeft",
            ["bottomright"] = "Interface/TalentFrame/PriestHoly-BottomRight"
        },
        ["Shadow"] = {
            ["topleft"] = "Interface/TalentFrame/PriestShadow-TopLeft",
            ["topright"] = "Interface/TalentFrame/PriestShadow-TopRight",
            ["bottomleft"] = "Interface/TalentFrame/PriestShadow-BottomLeft",
            ["bottomright"] = "Interface/TalentFrame/PriestShadow-BottomRight"
        }
    },
    ["Paladin"] = {
        ["Retribution"] = {
            ["topleft"] = "Interface/TalentFrame/PALADINCOMBAT-TOPLEFT",
            ["topright"] = "Interface/TalentFrame/PALADINCOMBAT-TOPRIGHT",
            ["bottomleft"] = "Interface/TalentFrame/PALADINCOMBAT-BOTTOMLEFT",
            ["bottomright"] = "Interface/TalentFrame/PALADINCOMBAT-BOTTOMRIGHT"
        },
        ["Protection"] = {
            ["topleft"] = "Interface/TalentFrame/PALADINPROTECTION-TOPLEFT",
            ["topright"] = "Interface/TalentFrame/PALADINPROTECTION-TOPRIGHT",
            ["bottomleft"] = "Interface/TalentFrame/PALADINPROTECTION-BOTTOMLEFT",
            ["bottomright"] = "Interface/TalentFrame/PALADINPROTECTION-BOTTOMRIGHT"
        },
        ["Holy"] = {
            ["topleft"] = "Interface/TalentFrame/PALADINHOLY-TOPLEFT",
            ["topright"] = "Interface/TalentFrame/PALADINHOLY-TOPRIGHT",
            ["bottomleft"] = "Interface/TalentFrame/PALADINHOLY-BOTTOMLEFT",
            ["bottomright"] = "Interface/TalentFrame/PALADINHOLY-BOTTOMRIGHT"
        }
    }
}

local SetTalentTreeBackground = function(class, spec)
    TalentGridFrame.topleft:SetTexture(TALENT_LAYOUTS[class][spec].topleft)
    TalentGridFrame.topright:SetTexture(TALENT_LAYOUTS[class][spec].topright)
    TalentGridFrame.bottomleft:SetTexture(TALENT_LAYOUTS[class][spec].bottomleft)
    TalentGridFrame.bottomright:SetTexture(TALENT_LAYOUTS[class][spec].bottomright)
end

U.SetTalentTreeBackground = SetTalentTreeBackground
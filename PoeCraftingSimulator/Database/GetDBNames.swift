//
//  GetDBNames.swift
//  PoeCraftingSimulator
//
//  Created by Markus Hyvärinen on 18/01/2018.
//  Copyright © 2018 Markus. All rights reserved.
//

import Foundation

func GetItemSlotString(level1 : Int, level2 : Int, level3 : Int)->String{
    if (level1 == 0){
        if (level2 == 0){
            switch level3 {
            case 0:
                return "One Handed Axe"
            case 1:
                return "Claw"
            case 2:
                return "One Handed Mace"
            case 3:
                return "One Handed Sword"
            case 4:
                return "Wand"
            case 5:
                return "Dagger"
            default:
                return ""
            }
        }
        if (level2 == 1){
            switch level3 {
            case 0:
                return "Two Handed Axe"
            case 1:
                return "Two Handed Mace"
            case 2:
                return "Two Handed Sword"
            case 3:
                return "Bow"
            case 4:
                return "Staff"
            default:
                return ""
            }
        }
    }
    return ""
}

func GetWeaponDBnameString(index : Int, twohanded : Int)->String{
    if (twohanded == 0){
        switch index {
        case 0:
            return "OneHandAxe"
        case 1:
            return "Claw"
        case 2:
            return "OneHandMace"
        case 3:
            return "OneHandSword"
        case 4:
            return "Wand"
        case 5:
            return "Dagger"
        default:
            return ""
        }
    }
    else{
        switch index {
        case 0:
            return "TwoHandAxe"
        case 1:
            return "TwoHandMace"
        case 2:
            return "TwoHandSword"
        case 3:
            return "Bow"
        case 4:
            return "Staff"
        default:
            return ""
        }
    }
}

func GetArmorDBnameString(index : Int)->String{
    switch index {
    case 0:
        return "BodyArmour"
    case 1:
        return "Helmet"
    case 2:
        return "Gloves"
    case 3:
        return "Boots"
    case 4:
        return "Shield"
    default:
        return ""
    }
}

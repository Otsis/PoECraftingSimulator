//
//  ArmorQuery.swift
//  PoeCraftingSimulator
//
//  Created by Markus Hyvärinen on 18/01/2018.
//  Copyright © 2018 Markus. All rights reserved.
//

import Foundation

func ArmorQuery2(index : Int, itemtype : String)->String{
    switch index {
    case 0:
        return "select * from \(itemtype) WHERE EvasionRating = 0 and EnergyShield = 0 ORDER BY \(itemtype+"ID") DESC;"
    case 1:
        return "select * from \(itemtype) WHERE Armour = 0 and EnergyShield = 0 ORDER BY \(itemtype+"ID") DESC;"
    case 2:
        return "select * from \(itemtype) WHERE EvasionRating = 0 and Armour = 0 ORDER BY \(itemtype+"ID") DESC;"
    case 3:
        return "select * from \(itemtype) WHERE EvasionRating > 0 and Armour > 0 and EnergyShield = 0 ORDER BY \(itemtype+"ID") DESC;"
    case 4:
        return "select * from \(itemtype) WHERE EvasionRating = 0 and Armour > 0 and EnergyShield > 0 ORDER BY \(itemtype+"ID") DESC;"
    case 5:
        return "select * from \(itemtype) WHERE EvasionRating > 0 and Armour = 0 and EnergyShield > 0 ORDER BY \(itemtype+"ID") DESC;"
    case 6:
        return "select * from \(itemtype) WHERE EvasionRating > 0 and Armour > 0 and EnergyShield > 0 ORDER BY \(itemtype+"ID") DESC;"
    default:
        return ""
    }
}

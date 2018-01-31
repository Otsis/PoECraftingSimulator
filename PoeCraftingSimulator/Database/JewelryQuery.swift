//
//  JewelryQuery.swift
//  PoeCraftingSimulator
//
//  Created by Markus Hyvärinen on 18/01/2018.
//  Copyright © 2018 Markus. All rights reserved.
//

import Foundation

func JewelryQuery2(index: Int)->String{
    switch index {
    case 0:
        return "select * from Belt ORDER BY BeltID DESC;"
    case 1:
        return "select * from Amulet ORDER BY AmuletID DESC;"
    default:
        return "select * from Ring ORDER BY RingID DESC;"
    }
}

//
//  WeaponQuery.swift
//  PoeCraftingSimulator
//
//  Created by Markus Hyvärinen on 18/01/2018.
//  Copyright © 2018 Markus. All rights reserved.
//

import Foundation

func WeaponQuery2(itemtype : String)->String{
    return "select * from \(itemtype) ORDER BY \(itemtype+"ID") DESC;"
}


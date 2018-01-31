//
//  CurrentItem.swift
//  PoeCraftingSimulator
//
//  Created by Markus Hyvärinen on 06/12/2017.
//  Copyright © 2017 Markus. All rights reserved.
//

import Foundation
import UIKit

struct ItemSave : Codable{
    var currentitem : ItemStats?
    var affixes : Affixes?
    var weapon : BaseWeapon?
    var armour : BaseArmour?
    var accessory : BaseAccessory?
}

struct ItemStats : Codable{
    var nameprefix : String
    var namesuffix : String
    var rarity :  String
    var quality : Int
    var suffixes : [CurrentAffixes]
    var prefixes : [CurrentAffixes]
}

struct CurrentAffixes : Codable{
    var text : String
    var lvlreq : Int
    var currentvalue1 : Int
    var currentvalue2 : Int
    var val1min : Int
    var val1max : Int
    var val2min : Int
    var val2max : Int
}

struct TextbyRow{
    let row : [TextElement]
}

struct TextElement {
    let text : String
    let color : UIColor
}


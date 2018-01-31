//
//  Affixes.swift
//  PoeCraftingSimulator
//
//  Created by Markus Hyvärinen on 21/12/2017.
//  Copyright © 2017 Markus. All rights reserved.
//

import Foundation

struct Affixes : Codable {
    var craftprefix : [Prefix]
    var masterprefix : [Prefix]
    var essenceprefix : [Prefix]
    
    var craftsuffix : [Suffix]
    var mastersuffix : [Suffix]
    var essencesuffix : [Suffix]
}

struct Prefix : Codable{
    let desc : String
    let amount : Int
    var used : Int
    let master : String
    let essence : String
    let values : [AffixVals]
}
struct Suffix : Codable{
    let desc : String
    let amount : Int
    var used : Int
    let master : String
    let essence : String
    let values : [AffixVals]
}
struct AffixVals : Codable{
    let iLvl : Int
    let name : String
    let val1 : Int
    let val2 : Int
    let val3 : Int
    let val4 : Int
}

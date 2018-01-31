//
//  DBTypes.swift
//  PoeCraftingSimulator
//
//  Created by Markus Hyvärinen on 20/12/2017.
//  Copyright © 2017 Markus. All rights reserved.
//

import Foundation

struct AffixURLs : Codable{
    let url : String
    let base: String
}


struct AffixnNamesToAdd {
    let prefixname : String
    let dbname : String
    let usagee : [Int]?
    let essencename : String
    let essenceusage : [Int]?
    let mastername : String
    let masterusage : [Int]?
}

struct AffixValsToAdd : Codable {
    let ilvl : String
    let vals : [Int]
    let name : String
    let master : Int
    let essence : Int
}

struct name: Codable {
    let imgaddress : String //change to URL?
    let item : String //Item name : Rusted Hatchet
    let lvlreq : Int //req lvl for the base item (not same as ilvl = itemlevel)
    let mindmg : Int //Weapons minimum dmg
    let maxdmg : Int //Weapons maximum dmg
    let aps : Decimal //Attacks Per Second
    let dps : Decimal // (mindmg+maxdmg)/2*aps
    //let stats : Stats //Something specific some weapons have
}

struct Stats: Codable{
    let aspd : Decimal? //8% on some weapons
    let percent : Decimal? //8% on some weapons
}

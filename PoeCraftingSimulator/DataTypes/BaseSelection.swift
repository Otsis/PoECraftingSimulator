//
//  BaseSelection.swift
//  PoeCraftingSimulator
//
//  Created by Markus Hyvärinen on 20/12/2017.
//  Copyright © 2017 Markus. All rights reserved.
//

import Foundation

struct SliderOptions : Codable {
    let ClassDisplayText : String
    let SlotName : [Slot]
}

struct Slot : Codable{
    let SlotDisplayText : String
    let TypeName : [Type]
    
}

struct Type : Codable{
    let TypeDisplayText : String
    let TypeDBName : String
    //var BaseName : [Base]
}


//Url text not null, Name text not null, Level integer not null, Armour integer not null, EvasionRating integer not null, EnergyShield integer not null, ReqStr integer not null, ReqDex integer not null, ReqInt integer not null, Implicit1 text, Implicit1val text, Implicit2 text, Implicit2val text);
struct BaseArmour : Codable {
    //let slot : String
    //let type : String
    
    let url : String
    let Name : String
    let Level : Int
    let Armour : Int
    let EvasionRating : Int
    let EnergyShield : Int
    let ReqStr : Int
    let ReqDex : Int
    let ReqInt : Int
    let Implicit1 : String
    let Implicit1val : String
    let Implicit2 : String
    let Implicit2val : String
}

struct BaseAccessory : Codable {
    //let slot : String
    //let type : String
    
    let url : String
    let Name : String
    let Level : Int
    let implicit1 : String
    let Implicit1valmin : Int
    let Implicit1valmax : Int
    let Implicit2 : String
    let Implicit2valmin : Int
    let Implicit2valmax : Int
}

struct BaseWeapon : Codable{
    let slot : String
    let type : String
    
    var crit : Double
    let url : String
    let Name : String
    let level : Int
    let DamageMin : Int
    let DamageMax : Int
    let APS : Double
    let DPS : Decimal
    let ReqStr : Int
    let ReqDex : Int
    let ReqInt : Int
    let Implicit1 : String
    let Implicit1val : String
    let Implicit2 : String
    let Implicit2val : String
}

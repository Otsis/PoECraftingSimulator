//
//  DBdataToClass.swift
//  PoeCraftingSimulator
//
//  Created by Markus Hyvärinen on 22/01/2018.
//  Copyright © 2018 Markus. All rights reserved.
//

import Foundation

func CreateBaseArmour(resultset : FMResultSet)->[BaseArmour]{
    var basearmourdata : [BaseArmour] = []
    while resultset.next() == true {
        let temp = BaseArmour(url: resultset.string(forColumn: "url")!,
                              Name: resultset.string(forColumn: "Name")!,
                              Level: Int(resultset.int(forColumn: "Level")),
                              Armour: Int(resultset.int(forColumn: "Armour")),
                              EvasionRating: Int(resultset.int(forColumn: "EvasionRating")),
                              EnergyShield: Int(resultset.int(forColumn: "EnergyShield")),
                              ReqStr: Int(resultset.int(forColumn: "ReqStr")),
                              ReqDex: Int(resultset.int(forColumn: "ReqDex")),
                              ReqInt: Int(resultset.int(forColumn: "ReqInt")),
                              Implicit1: resultset.string(forColumn: "Implicit1")!,
                              Implicit1val: resultset.string(forColumn: "Implicit1val")!,
                              Implicit2: resultset.string(forColumn: "Implicit2")!,
                              Implicit2val: resultset.string(forColumn: "Implicit2val")!)
        basearmourdata.append(temp)
    }
    
    return basearmourdata
}

func CreateBaseAccessory(resultset : FMResultSet)->[BaseAccessory]{
    
    var baseaccessorydata : [BaseAccessory] = []
    while resultset.next() == true {
        let temp = BaseAccessory(url: resultset.string(forColumn: "url")!,
                                 Name: resultset.string(forColumn: "Name")!,
                                 Level: Int(resultset.int(forColumn: "Level")),
                                 implicit1: resultset.string(forColumn: "implicit1")!,
                                 Implicit1valmin: Int(resultset.int(forColumn: "Implicit1valmin")),
                                 Implicit1valmax: Int(resultset.int(forColumn: "Implicit1valmax")),
                                 Implicit2: resultset.string(forColumn: "Implicit2")!,
                                 Implicit2valmin: Int(resultset.int(forColumn: "Implicit2valmin")),
                                 Implicit2valmax: Int(resultset.int(forColumn: "Implicit2valmax")))
        baseaccessorydata.append(temp)
    }
    return baseaccessorydata
}

func CreateBaseWeapon(resultset : FMResultSet, slot : String, itemtype : String)->[BaseWeapon]{
    var baseweapondata : [BaseWeapon] = []
    
    while resultset.next() == true {
        let temp = BaseWeapon(slot : slot,
                              type : itemtype,
                              crit : 5,
                              url: resultset.string(forColumn: "Url")!,
                              Name: resultset.string(forColumn: "Name")!,
                              level: Int(resultset.int(forColumn: "Level")),
                              DamageMin: Int(resultset.int(forColumn: "DamageMin")),
                              DamageMax: Int(resultset.int(forColumn: "DamageMax")),
                              APS: Double(resultset.double(forColumn: "APS")),
                              DPS: Decimal(resultset.double(forColumn: "DPS")),
                              ReqStr: Int(resultset.int(forColumn: "ReqStr")),
                              ReqDex: Int(resultset.int(forColumn: "ReqDex")),
                              ReqInt: Int(resultset.int(forColumn: "ReqInt")),
                              Implicit1: resultset.string(forColumn: "Implicit1")!,
                              Implicit1val: resultset.string(forColumn: "Implicit1val")!,
                              Implicit2: resultset.string(forColumn: "Implicit2")!,
                              Implicit2val: resultset.string(forColumn: "Implicit2val")!)
        baseweapondata.append(temp)
    }
    return baseweapondata
}

//
//  Delegate.swift
//  PoeCraftingSimulator
//
//  Created by Markus Hyvärinen on 24/01/2018.
//  Copyright © 2018 Markus. All rights reserved.
//

import Foundation
import UIKit

func ReceiveFromAppDelegate()->ItemSave?{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    return appDelegate.current!
}

func SendToAppDelegate(currentitem : ItemStats?, affixes : Affixes?, weapon : BaseWeapon?, armour : BaseArmour?, accessory : BaseAccessory?){
    let save : ItemSave = ItemSave(currentitem: currentitem, affixes: affixes, weapon: weapon, armour: armour, accessory: accessory)
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.current = save
}

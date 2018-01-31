//
//  MenuData.swift
//  PoeCraftingSimulator
//
//  Created by Markus Hyvärinen on 14/12/2017.
//  Copyright © 2017 Markus. All rights reserved.
//

import Foundation

func GenerateOptions()->[SliderOptions]{
    var options : [SliderOptions] = []
    
    
    var slot : [Slot] = []
    var type : [Type] = []

    

    type.append(Type(TypeDisplayText: "Axe", TypeDBName: "OneHandAxe"))
    type.append(Type(TypeDisplayText: "Claw", TypeDBName: "Claw"))
    type.append(Type(TypeDisplayText: "Mace", TypeDBName: "OneHandMace"))
    type.append(Type(TypeDisplayText: "Sceptre", TypeDBName: "Sceptre"))
    type.append(Type(TypeDisplayText: "Sword", TypeDBName: "OneHandSword"))
    type.append(Type(TypeDisplayText: "Thrusting", TypeDBName: "ThrustingOneHandSword"))
    type.append(Type(TypeDisplayText: "Wand", TypeDBName: "Wand"))
    type.append(Type(TypeDisplayText: "Dagger", TypeDBName: "Dagger"))
    slot.append(Slot(SlotDisplayText: "1-Hand Weapons", TypeName: type))
    type = []
    
    type.append(Type(TypeDisplayText: "Axe", TypeDBName: "TwoHandAxe"))
    type.append(Type(TypeDisplayText: "Mace", TypeDBName: "TwoHandMace"))
    type.append(Type(TypeDisplayText: "Sword", TypeDBName: "TwoHandSword"))
    type.append(Type(TypeDisplayText: "Bow", TypeDBName: "Bow"))
    type.append(Type(TypeDisplayText: "Staff", TypeDBName: "Staff"))

    slot.append(Slot(SlotDisplayText: "2-Hand Weapons", TypeName: type))
    type = []
    options.append(SliderOptions(ClassDisplayText: "Weapons", SlotName: slot))
    slot = []
    

    
    type.append(Type(TypeDisplayText: "AR", TypeDBName: "BodyArmour"))
    type.append(Type(TypeDisplayText: "Eva", TypeDBName: "BodyArmour"))
    type.append(Type(TypeDisplayText: "ES", TypeDBName: "BodyArmour"))
    type.append(Type(TypeDisplayText: "AR/Eva", TypeDBName: "BodyArmour"))
    type.append(Type(TypeDisplayText: "AR/ES", TypeDBName: "BodyArmour"))
    type.append(Type(TypeDisplayText: "Eva/ES", TypeDBName: "BodyArmour"))
    type.append(Type(TypeDisplayText: "AR/Eva/ES", TypeDBName: "BodyArmour"))
    slot.append(Slot(SlotDisplayText: "Body", TypeName: type))
    type = []

    type.append(Type(TypeDisplayText: "AR", TypeDBName: "Helmet"))
    type.append(Type(TypeDisplayText: "Eva", TypeDBName: "Helmet"))
    type.append(Type(TypeDisplayText: "ES", TypeDBName: "Helmet"))
    type.append(Type(TypeDisplayText: "AR/Eva", TypeDBName: "Helmet"))
    type.append(Type(TypeDisplayText: "AR/ES", TypeDBName: "Helmet"))
    type.append(Type(TypeDisplayText: "Eva/ES", TypeDBName: "Helmet"))
    slot.append(Slot(SlotDisplayText: "Helmet", TypeName: type))
    type = []

    type.append(Type(TypeDisplayText: "AR", TypeDBName: "Gloves"))
    type.append(Type(TypeDisplayText: "Eva", TypeDBName: "Gloves"))
    type.append(Type(TypeDisplayText: "ES", TypeDBName: "Gloves"))
    type.append(Type(TypeDisplayText: "AR/Eva", TypeDBName: "Gloves"))
    type.append(Type(TypeDisplayText: "AR/ES", TypeDBName: "Gloves"))
    type.append(Type(TypeDisplayText: "Eva/ES", TypeDBName: "Gloves"))
    slot.append(Slot(SlotDisplayText: "Gloves", TypeName: type))
    type = []

    type.append(Type(TypeDisplayText: "AR", TypeDBName: "Boots"))
    type.append(Type(TypeDisplayText: "Eva", TypeDBName: "Boots"))
    type.append(Type(TypeDisplayText: "ES", TypeDBName: "Boots"))
    type.append(Type(TypeDisplayText: "AR/Eva", TypeDBName: "Boots"))
    type.append(Type(TypeDisplayText: "AR/ES", TypeDBName: "Boots"))
    type.append(Type(TypeDisplayText: "Eva/ES", TypeDBName: "Boots"))
    slot.append(Slot(SlotDisplayText: "Boots", TypeName: type))
    type = []

    type.append(Type(TypeDisplayText: "AR", TypeDBName: "Shield"))
    type.append(Type(TypeDisplayText: "Eva", TypeDBName: "Shield"))
    type.append(Type(TypeDisplayText: "ES", TypeDBName: "Shield"))
    type.append(Type(TypeDisplayText: "AR/Eva", TypeDBName: "Shield"))
    type.append(Type(TypeDisplayText: "AR/ES", TypeDBName: "Shield"))
    type.append(Type(TypeDisplayText: "Eva/ES", TypeDBName: "Shield"))
    slot.append(Slot(SlotDisplayText: "Shield", TypeName: type))

    options.append(SliderOptions(ClassDisplayText: "Armours", SlotName: slot))
    type = []
    slot = []
    
    
    type.append(Type(TypeDisplayText: "Belt", TypeDBName: "Belt"))
    type.append(Type(TypeDisplayText: "Amulet", TypeDBName: "Amulet"))
    type.append(Type(TypeDisplayText: "Ring", TypeDBName: "Ring"))
    slot.append(Slot(SlotDisplayText: "Default", TypeName: type))
    options.append(SliderOptions(ClassDisplayText: "Accessories", SlotName: slot))
    
    return options
}

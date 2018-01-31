//
//  CraftingComponents.swift
//  PoeCraftingSimulator
//
//  Created by Markus Hyvärinen on 15/12/2017.
//  Copyright © 2017 Markus. All rights reserved.
//

import Foundation

struct CraftingComponent {
    let name : String
    let reqrarity : [String]
    let newrarity : String
}

func GenerateComponents()->[CraftingComponent]{
    var craftingcomponents : [CraftingComponent] = []
    craftingcomponents.append(CraftingComponent(name: "Transmute", reqrarity: ["white"], newrarity: "blue"))
    craftingcomponents.append(CraftingComponent(name: "Alchemy", reqrarity: ["white"], newrarity: "yellow"))
    craftingcomponents.append(CraftingComponent(name: "Alteration", reqrarity: ["blue"], newrarity: "blue"))
    craftingcomponents.append(CraftingComponent(name: "Chaos", reqrarity: ["yellow"], newrarity: "yellow"))
    craftingcomponents.append(CraftingComponent(name: "Regal", reqrarity: ["blue"], newrarity: "yellow"))
    craftingcomponents.append(CraftingComponent(name: "Augment", reqrarity: ["blue"], newrarity: "blue"))
    craftingcomponents.append(CraftingComponent(name: "Exalted", reqrarity: ["yellow"], newrarity: "yellow"))
    craftingcomponents.append(CraftingComponent(name: "Scouring", reqrarity: ["blue", "yellow"], newrarity: "white"))
    craftingcomponents.append(CraftingComponent(name: "Divine", reqrarity: ["blue", "yellow"], newrarity: "previous"))

    return craftingcomponents
}


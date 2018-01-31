//
//  ItemNamePrefix.swift
//  PoeCraftingSimulator
//
//  Created by Markus Hyvärinen on 27/12/2017.
//  Copyright © 2017 Markus. All rights reserved.
//

import Foundation

struct ItemName : Codable {
    let prefix : [String]
    let suffix : [ItemNameSuffix]
}




func GetItemNamePrefixes()->[String]{
    let table : [String] = ["Agony", "Apocalypse", "Armageddon", "Beast", "Behemoth", "Blight", "Blood", "Bramble", "Brimstone", "Brood", "Carrion", "Cataclysm", "Chimeric", "Corpse", "Corruption", "Damnation", "Death", "Demon", "Dire", "Dragon", "Dread", "Doom", "Dusk", "Eagle", "Empyrean", "Fate", "Foe", "Gale", "Ghoul", "Gloom", "Glyph", "Golem", "Grim", "Hate", "Havoc", "Honour", "Horror", "Hypnotic", "Kraken", "Loath", "Maelstrom", "Mind", "Miracle", "Morbid", "Oblivion", "Onslaught", "Pain", "Pandemonium", "Phoenix", "Plague", "Rage", "Rapture", "Rune", "Skull", "Sol", "Soul", "Sorrow", "Spirit", "Storm", "Tempest", "Torment", "Vengeance", "Victory", "Viper", "Vortex", "Woe", "Wrath"]
    return table
}



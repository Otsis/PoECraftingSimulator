//
//  ItemNameSuffix.swift
//  PoeCraftingSimulator
//
//  Created by Markus Hyvärinen on 28/12/2017.
//  Copyright © 2017 Markus. All rights reserved.
//

import Foundation


struct ItemNameSuffix : Codable {
    var suffix : [String: [String]]
}

func GetItemNameSuffixes()->ItemNameSuffix{
    let allvals : ItemNameSuffix = ItemNameSuffix(suffix: [
        "One Handed Axe" : ["Bane","Beak","Bite","Butcher", "Edge", "Etcher", "Gnash", "Hunger", "Mangler", "Rend", "Roar", "Sever", "Slayer", "Song", "Spawn", "Splitter", "Sunder", "Thirst"],
        "Two Handed Axe" : ["Bane","Beak","Bite","Butcher", "Edge", "Etcher", "Gnash", "Hunger", "Mangler", "Rend", "Roar", "Sever", "Slayer", "Song", "Spawn", "Splitter", "Sunder", "Thirst"],
        "One Handed Mace" : ["Bane", "Mangler", "Roar", "Batter", "Blast", "Blow", "Blunt", "Brand", "Breaker", "Burst", "Crack", "Crusher", "Grinder", "Knell", "Ram", "Ruin", "Shatter", "Smasher", "Star", "Thresher", "Wreck"],
        "Two Handed Mace" : ["Bane", "Mangler", "Roar", "Batter", "Blast", "Blow", "Blunt", "Brand", "Breaker", "Burst", "Crack", "Crusher", "Grinder", "Knell", "Ram", "Ruin", "Shatter", "Smasher", "Star", "Thresher", "Wreck"],
        "Sceptre" : ["Bane", "Roar", "Blow", "Breaker", "Crack", "Crusher", "Grinder", "Knell", "Ram", "Smasher", "Star", "Song", "Call", "Chant", "Cry", "Gnarl", "Spell", "Weaver"],
        "Staff" : ["Bane", "Roar", "Song", "Call", "Chant", "Cry", "Gnarl", "Spell", "Weaver", "Beam", "Branch", "Goad", "Mast", "Pile", "Pillar", "Pole", "Post", "Spire"],
        "One Handed Sword" : ["Bane", "Song", "Beak", "Bite", "Edge", "Hunger", "Sever", "Thirst", "Barb", "Fang", "Gutter", "Impaler", "Needle", "Razor", "Saw", "Scalpel", "Scratch", "Skewer", "Slicer", "Spike", "Spiker", "Stinger"],
        "Two Handed Sword" : ["Bane", "Song", "Beak", "Bite", "Edge", "Hunger", "Sever", "Thirst", "Barb", "Fang", "Gutter", "Impaler", "Needle", "Razor", "Saw", "Scalpel", "Scratch", "Skewer", "Slicer", "Spike", "Spiker", "Stinger"],
        "Dagger" : ["Bane", "Song", "Bite", "Edge", "Hunger", "Sever", "Thirst", "Barb", "Fang", "Gutter", "Impaler", "Needle", "Razor", "Scalpel", "Scratch", "Skewer", "Slicer", "Spike", "Stinger", "Etcher"],
        "Claw" : ["Bane", "Song", "Bite", "Edge", "Hunger", "Thirst", "Fang", "Gutter", "Impaler", "Needle", "Razor", "Scratch", "Skewer", "Slicer", "Spike", "Stinger", "Roar", "Fist", "Talons"],
        "Bow" : ["Bane", "Song", "Thirst", "Stinger", "Branch", "Blast", "Arch", "Barrage", "Breeze", "Fletch", "Guide", "Horn", "Mark", "Nock", "Rain", "Reach", "Siege", "Strike", "Thunder", "Twine", "Volley", "Wind", "Wing"],
        "Wand" : ["Bane", "Song", "Thirst", "Branch", "Bite", "Edge", "Needle", "Scratch", "Barb", "Call", "Chant", "Cry", "Gnarl", "Spell", "Weaver", "Goad", "Spire", "Charm"],
        "ESShield" : ["Ancient", "Anthem", "Call", "Chant", "Charm", "Emblem", "Guard", "Mark", "Pith", "Sanctuary", "Song", "Spell", "Star", "Ward", "Weaver", "Wish"],
        "Shield" : ["Aegis", "Badge", "Barrier", "Bastion", "Bulwark", "Duty", "Emblem", "Fend", "Guard", "Mark", "Refuge", "Rock", "Rook", "Sanctuary", "Span", "Tower", "Watch", "Wing"],
        "Body" : ["Carapace", "Cloak", "Coat", "Curtain", "Guardian", "Hide", "Jack", "Keep", "Mantle", "Pelt", "Salvation", "Sanctuary", "Shell", "Shelter", "Shroud", "Skin", "Suit", "Veil", "Ward", "Wrap"],
        "Helmet" : ["Brow", "Corona", "Cowl", "Crest", "Crown", "Dome", "Glance", "Guardian", "Halo", "Horn", "Keep", "Peak", "Salvation", "Shelter", "Star", "Veil", "Visage", "Visor", "Ward"],
        "Gloves" : ["Caress", "Claw", "Clutches", "Fingers", "Fist", "Grasp", "Grip", "Hand", "Hold", "Knuckle", "Mitts", "Nails", "Palm", "Paw", "Talons", "Touch", "Vise"],
        "Boots" : ["Dash", "Goad", "Hoof", "League", "March", "Pace", "Road", "Slippers", "Sole", "Span", "Spark", "Spur", "Stride", "Track", "Trail", "Tread", "Urge"],
        "Amulet" : ["Beads", "Braid", "Charm", "Choker", "Clasp", "Collar", "Idol", "Gorget", "Heart", "Locket", "Medallion", "Noose", "Pendant", "Rosary", "Scarab", "Talisman", "Torc"],
        "Ring" : ["Band", "Circle", "Coil", "Eye", "Finger", "Grasp", "Grip", "Gyre", "Hold", "Knot", "Knuckle", "Loop", "Nail", "Spiral", "Turn", "Twirl", "Whorl"],
        "Belt" : ["Bind", "Bond", "Buckle", "Clasp", "Cord", "Girdle", "Harness", "Lash", "Leash", "Lock", "Locket", "Shackle", "Snare", "Strap", "Tether", "Thread", "Trap", "Twine"]
        
        ])
    return allvals
}

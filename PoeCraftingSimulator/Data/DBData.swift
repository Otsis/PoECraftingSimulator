//
//  DBData.swift
//  PoeCraftingSimulator
//
//  Created by Markus Hyvärinen on 20/12/2017.
//  Copyright © 2017 Markus. All rights reserved.
//


import Foundation

func AffixURLsDataGen()->[AffixURLs]{
    var data : [AffixURLs] = []
    data.append(AffixURLs(url: "http://poeaffix.net/1h-axe.html", base: "OneHandAxe"))
    data.append(AffixURLs(url: "http://poeaffix.net/1h-claw.html", base: "Claw"))
    data.append(AffixURLs(url: "http://poeaffix.net/1h-dagger.html", base: "Dagger"))
    data.append(AffixURLs(url: "http://poeaffix.net/1h-mace.html", base: "OneHandMace"))
    data.append(AffixURLs(url: "http://poeaffix.net/1h-sceptre.html", base: "Sceptre"))
    data.append(AffixURLs(url: "http://poeaffix.net/1h-sword.html", base: "OneHandSword"))
    data.append(AffixURLs(url: "http://poeaffix.net/1h-wand.html", base: "Wand"))
    data.append(AffixURLs(url: "http://poeaffix.net/2h-axe.html", base: "TwoHandAxe"))
    data.append(AffixURLs(url: "http://poeaffix.net/2h-bow.html", base: "Bow"))
    data.append(AffixURLs(url: "http://poeaffix.net/2h-mace.html", base: "TwoHandMace"))
    data.append(AffixURLs(url: "http://poeaffix.net/2h-staff.html", base: "Staff"))
    data.append(AffixURLs(url: "http://poeaffix.net/2h-sword.html", base: "TwoHandSword"))
    
    data.append(AffixURLs(url: "http://poeaffix.net/ch-ar.html", base: "BodyArmourAr"))
    data.append(AffixURLs(url: "http://poeaffix.net/ch-ev.html", base: "BodyArmourEv"))
    data.append(AffixURLs(url: "http://poeaffix.net/ch-es.html", base: "BodyArmourEs"))
    data.append(AffixURLs(url: "http://poeaffix.net/hm-ar.html", base: "HelmetAr"))
    data.append(AffixURLs(url: "http://poeaffix.net/hm-ev.html", base: "HelmetEv"))
    data.append(AffixURLs(url: "http://poeaffix.net/hm-es.html", base: "HelmetEs"))
    data.append(AffixURLs(url: "http://poeaffix.net/gl-ar.html", base: "GlovesAr"))
    data.append(AffixURLs(url: "http://poeaffix.net/gl-ev.html", base: "GlovesEv"))
    data.append(AffixURLs(url: "http://poeaffix.net/gl-es.html", base: "GlovesEs"))
    data.append(AffixURLs(url: "http://poeaffix.net/bt-ar.html", base: "BootsAr"))
    data.append(AffixURLs(url: "http://poeaffix.net/bt-ev.html", base: "BootsEv"))
    data.append(AffixURLs(url: "http://poeaffix.net/bt-es.html", base: "BootsEs"))
    data.append(AffixURLs(url: "http://poeaffix.net/sh-ar.html", base: "ShieldAr"))
    data.append(AffixURLs(url: "http://poeaffix.net/sh-ev.html", base: "ShieldEv"))
    data.append(AffixURLs(url: "http://poeaffix.net/sh-es.html", base: "ShieldEs"))
    
    data.append(AffixURLs(url: "http://poeaffix.net/ac-amulet.html", base: "Amulet"))
    data.append(AffixURLs(url: "http://poeaffix.net/ac-belt.html", base: "Belt"))
    data.append(AffixURLs(url: "http://poeaffix.net/ac-ring.html", base: "Ring"))
    
    data.append(AffixURLs(url: "http://poeaffix.net/ch-ares.html", base: "BodyArmourArEs"))
    data.append(AffixURLs(url: "http://poeaffix.net/ch-arev.html", base: "BodyArmourArEv"))
    data.append(AffixURLs(url: "http://poeaffix.net/ch-eves.html", base: "BodyArmourEvEs"))
    data.append(AffixURLs(url: "http://poeaffix.net/ch-garb.html", base: "BodyArmourAll"))
    data.append(AffixURLs(url: "http://poeaffix.net/hm-ares.html", base: "HelmetArEs"))
    data.append(AffixURLs(url: "http://poeaffix.net/hm-arev.html", base: "HelmetArEv"))
    data.append(AffixURLs(url: "http://poeaffix.net/hm-eves.html", base: "HelmetEvEs"))
    data.append(AffixURLs(url: "http://poeaffix.net/gl-ares.html", base: "GlovesArEs"))
    data.append(AffixURLs(url: "http://poeaffix.net/gl-arev.html", base: "GlovesArEv"))
    data.append(AffixURLs(url: "http://poeaffix.net/gl-eves.html", base: "GlovesEvEs"))
    data.append(AffixURLs(url: "http://poeaffix.net/bt-ares.html", base: "BootsArEs"))
    data.append(AffixURLs(url: "http://poeaffix.net/bt-arev.html", base: "BootsArEv"))
    data.append(AffixURLs(url: "http://poeaffix.net/bt-eves.html", base: "BootsEvEs"))
    data.append(AffixURLs(url: "http://poeaffix.net/sh-ares.html", base: "ShieldArEs"))
    data.append(AffixURLs(url: "http://poeaffix.net/sh-arev.html", base: "ShieldArEv"))
    data.append(AffixURLs(url: "http://poeaffix.net/sh-eves.html", base: "ShieldEvEs"))
    
    return data
}


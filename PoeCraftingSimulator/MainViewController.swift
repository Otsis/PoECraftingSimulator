//
//  MainViewController.swift
//  PoeCraftingSimulator
//
//  Created by Markus Hyvärinen on 06/12/2017.
//  Copyright © 2017 Markus. All rights reserved.
//
/* A font by Jos Buivenga (exljbris) -> www.exljbris.com */

import UIKit

extension NSMutableAttributedString {
    
    func setColorForText(textForAttribute: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        self.addAttribute(NSAttributedStringKey.foregroundColor, value: color, range: range)
    }
    
}

class MainViewController: UIViewController {

    var craftingcomponents : [CraftingComponent] = []
    var selectedcomponent : Int = 7
    var currentitem : ItemStats = ItemStats(nameprefix : "", namesuffix : "", rarity: "white", quality: 20, suffixes: [], prefixes: [])
    var affixes : Affixes?
    var itemnameprefixes = GetItemNamePrefixes()
    var itemnamesuffixes = GetItemNameSuffixes()
    let rowheight : Int = 18
    let fontsize : CGFloat = 14
    var weapon : BaseWeapon?
    var armour : BaseArmour?
    var accessory : BaseAccessory?

    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var ItemStatsFrame: UIView!
    @IBOutlet weak var ItemNameTextFrame: UIView!
    @IBOutlet weak var ItemStatsFrameHeight: NSLayoutConstraint!
    @IBOutlet weak var ItemTextFrame: UIView!
    @IBOutlet weak var ItemNameBG: UIImageView!
    @IBOutlet weak var ItemImage: UIImageView!
    @IBOutlet weak var ItemTextFrameHeight: NSLayoutConstraint!
    
    @IBOutlet weak var OrbofTransmutation: UIImageView!
    @IBOutlet weak var OrbofAlteration: UIImageView!
    @IBOutlet weak var RegalOrb: UIImageView!
    @IBOutlet weak var ExaltedOrb: UIImageView!
    @IBOutlet weak var OrbofScouring: UIImageView!
    @IBOutlet weak var OrbofAlchemy: UIImageView!
    @IBOutlet weak var ChaosOrb: UIImageView!
    @IBOutlet weak var OrbofAugmentation: UIImageView!
    @IBOutlet weak var DivineOrb: UIImageView!
    
    @IBOutlet weak var OrbofTransmutationFrame: UIImageView!
    @IBOutlet weak var OrbofAlchemyFrame: UIImageView!
    @IBOutlet weak var DivineOrbFrame: UIImageView!
    @IBOutlet weak var ChaosOrbFrame: UIImageView!
    @IBOutlet weak var RegalOrbFrame: UIImageView!
    @IBOutlet weak var OrbofAugmentationFrame: UIImageView!
    @IBOutlet weak var OrbofScouringFrame: UIImageView!
    @IBOutlet weak var ExaltedOrbFrame: UIImageView!
    @IBOutlet weak var OrbofAlterationFrame: UIImageView!
    
    @IBOutlet weak var Prefix1image: UIImageView!
    @IBOutlet weak var Prefix2image: UIImageView!
    @IBOutlet weak var Prefix3image: UIImageView!
    @IBOutlet weak var Suffix1image: UIImageView!
    @IBOutlet weak var Suffix2image: UIImageView!
    @IBOutlet weak var Suffix3image: UIImageView!
    
    @IBOutlet var CraftItemGesture: UITapGestureRecognizer!
    
    
    
    
    
    @IBOutlet weak var Craftingcomponentsframe: UIView!
    @IBOutlet weak var Craftingcomponentsheight: NSLayoutConstraint!
    
    @IBOutlet weak var ItemNameRow1: UILabel!
    @IBOutlet weak var ItemNameRow2: UILabel!
    @IBOutlet weak var ItemNameRowOnly1: UILabel!

    
    func UpdateImage(imageurl : String){
        ItemImage.imageFromServerURL(urlString: imageurl, defaultImage: "DefaultBase")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentitem = ItemStats(nameprefix : "", namesuffix : "", rarity: "white", quality: 20, suffixes: [], prefixes: [])
        craftingcomponents = GenerateComponents()
        Craftingcomponentsheight.constant = Craftingcomponentsframe.frame.size.width*2/5

        let load : ItemSave = ReceiveFromAppDelegate()!
        weapon = load.weapon
        armour = load.armour
        accessory = load.accessory
        if (load.currentitem != nil){
            currentitem = load.currentitem!
        }
        affixes = load.affixes
        
        if (weapon != nil){
            CraftItemGesture.isEnabled = true
            UpdateImage(imageurl: (weapon?.url)!)
            GenerateItemText(weapon: weapon!)
            ChangeItemNameBGSize()
            UpdateAffixCounts()
            if (load.currentitem == nil){
                ItemNameRow2.text = weapon?.Name
            }
            selectedcomponent = -1
        }
        if (armour != nil){
            UpdateImage(imageurl: (armour?.url)!)
        }
        if (accessory != nil){
            UpdateImage(imageurl: (accessory?.url)!)
        }
        Highlightselectedcomponent(selectedcomponent: selectedcomponent)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func Highlightselectedcomponent(selectedcomponent : Int){
        switch selectedcomponent {
        case 0:
            OrbofTransmutationFrame.image = UIImage(named: "currencyframeselected")
            OrbofTransmutation.image = UIImage(named: "TransmutationOrb")
        case 1:
            OrbofAlchemyFrame.image = UIImage(named: "currencyframeselected")
            OrbofAlchemy.image = UIImage(named: "OrbofAlchemy")
        case 2:
            OrbofAlterationFrame.image = UIImage(named: "currencyframeselected")
            OrbofAlteration.image = UIImage(named: "OrbofAlteration")
        case 3:
            ChaosOrbFrame.image = UIImage(named: "currencyframeselected")
            ChaosOrb.image = UIImage(named: "ChaosOrb")
        case 4:
            RegalOrbFrame.image = UIImage(named: "currencyframeselected")
            RegalOrb.image = UIImage(named: "RegalOrb")
        case 5:
            OrbofAugmentationFrame.image = UIImage(named: "currencyframeselected")
            OrbofAugmentation.image = UIImage(named: "OrbofAugmentation")
        case 6:
            ExaltedOrbFrame.image = UIImage(named: "currencyframeselected")
            ExaltedOrb.image = UIImage(named: "ExaltedOrb")
        case 7:
            OrbofScouringFrame.image = UIImage(named: "currencyframeselected")
            OrbofScouring.image = UIImage(named: "OrbofScouring")
        case 8:
            DivineOrbFrame.image = UIImage(named: "currencyframeselected")
            DivineOrb.image = UIImage(named: "DivineOrb")
        case -1:
            OrbofTransmutation.image = OrbofTransmutation.image?.noir
            OrbofAlchemy.image = OrbofAlchemy.image?.noir
            OrbofAlteration.image = OrbofAlteration.image?.noir
            ChaosOrb.image = ChaosOrb.image?.noir
            RegalOrb.image = RegalOrb.image?.noir
            OrbofAugmentation.image = OrbofAugmentation.image?.noir
            ExaltedOrb.image = ExaltedOrb.image?.noir
            OrbofScouring.image = OrbofScouring.image?.noir
            DivineOrb.image = DivineOrb.image?.noir
        default:
            print("Error in highlighting crafting component image")
        }
    }

    func Deselectcraftingcomponent(selectedcomponent : Int) {
        switch selectedcomponent {
        case 0:
            OrbofTransmutationFrame.image = UIImage(named: "currencyframe")
            OrbofTransmutation.image = OrbofTransmutation.image?.noir
        case 1:
            OrbofAlchemyFrame.image = UIImage(named: "currencyframe")
            OrbofAlchemy.image = OrbofAlchemy.image?.noir
        case 2:
            OrbofAlterationFrame.image = UIImage(named: "currencyframe")
            OrbofAlteration.image = OrbofAlteration.image?.noir
        case 3:
            ChaosOrbFrame.image = UIImage(named: "currencyframe")
            ChaosOrb.image = ChaosOrb.image?.noir
        case 4:
            RegalOrbFrame.image = UIImage(named: "currencyframe")
            RegalOrb.image = RegalOrb.image?.noir
        case 5:
            OrbofAugmentationFrame.image = UIImage(named: "currencyframe")
            OrbofAugmentation.image = OrbofAugmentation.image?.noir
        case 6:
            ExaltedOrbFrame.image = UIImage(named: "currencyframe")
            ExaltedOrb.image = ExaltedOrb.image?.noir
        case 7:
            OrbofScouringFrame.image = UIImage(named: "currencyframe")
            OrbofScouring.image = OrbofScouring.image?.noir
        case 8:
            DivineOrbFrame.image = UIImage(named: "currencyframe")
            DivineOrb.image = DivineOrb.image?.noir
        case -1:
            print("selected component = -1")
        default:
            print("Error in deselectin crafting component image")
        }
    }
    
    @IBAction func TransmuteSelected(_ sender: UITapGestureRecognizer) {
        Deselectcraftingcomponent(selectedcomponent: selectedcomponent)
        selectedcomponent = 0
        Highlightselectedcomponent(selectedcomponent: selectedcomponent)
    }
    
    @IBAction func AlchemySelected(_ sender: UITapGestureRecognizer) {
        Deselectcraftingcomponent(selectedcomponent: selectedcomponent)
        selectedcomponent = 1
        Highlightselectedcomponent(selectedcomponent: selectedcomponent)
    }
    
    @IBAction func AlterationSelected(_ sender: UITapGestureRecognizer) {
        Deselectcraftingcomponent(selectedcomponent: selectedcomponent)
        selectedcomponent = 2
        Highlightselectedcomponent(selectedcomponent: selectedcomponent)
    }
    
    @IBAction func Chaos(_ sender: UITapGestureRecognizer) {
        Deselectcraftingcomponent(selectedcomponent: selectedcomponent)
        selectedcomponent = 3
        Highlightselectedcomponent(selectedcomponent: selectedcomponent)
    }
    
    @IBAction func Regal(_ sender: UITapGestureRecognizer) {
        Deselectcraftingcomponent(selectedcomponent: selectedcomponent)
        selectedcomponent = 4
        Highlightselectedcomponent(selectedcomponent: selectedcomponent)
    }
    
    @IBAction func Augment(_ sender: UITapGestureRecognizer) {
        Deselectcraftingcomponent(selectedcomponent: selectedcomponent)
        selectedcomponent = 5
        Highlightselectedcomponent(selectedcomponent: selectedcomponent)
    }
    
    @IBAction func Exalted(_ sender: UITapGestureRecognizer) {
        Deselectcraftingcomponent(selectedcomponent: selectedcomponent)
        selectedcomponent = 6
        Highlightselectedcomponent(selectedcomponent: selectedcomponent)
    }
    
    @IBAction func Scouring(_ sender: UITapGestureRecognizer) {
        Deselectcraftingcomponent(selectedcomponent: selectedcomponent)
        selectedcomponent = 7
        Highlightselectedcomponent(selectedcomponent: selectedcomponent)
    }
    
    @IBAction func Divine(_ sender: UITapGestureRecognizer) {
        Deselectcraftingcomponent(selectedcomponent: selectedcomponent)
        selectedcomponent = 8
        Highlightselectedcomponent(selectedcomponent: selectedcomponent)
    }
    
    
    
    func CheckCorrectCurrency()->Bool{
        if (selectedcomponent == 6 && currentitem.prefixes.count == 3 && currentitem.suffixes.count == 3){
            status.text = "Affixes are full"
            return false
        }
        for i in 0...craftingcomponents[selectedcomponent].reqrarity.count-1{
            if (craftingcomponents[selectedcomponent].reqrarity[i] == currentitem.rarity){
                status.text = ""
                return true
            }
            else{
                status.text = "Current item has to be: \(craftingcomponents[selectedcomponent].reqrarity[i])"
            }
        }
        return false
    }
    
    func resizeframe(newheight : CGFloat){
        ItemStatsFrameHeight.constant = ItemNameTextFrame.frame.size.height + newheight
        ItemStatsFrame.layoutIfNeeded()
    }
    
    func ImplicitCheck(basetexttemp : [TextbyRow])->([TextbyRow],Int){
        if (weapon?.Implicit1 != ""){
            var basetext = basetexttemp
            var element : [TextElement] = []
            element.append(TextElement(text: AddValuesToAffixes(text: (weapon?.Implicit1)!, i: 1, val1: Int((weapon?.Implicit1val)!)!, val2: Int((weapon?.Implicit1val)!)!), color: UIColor.blue))
            basetext.append(TextbyRow(row: element))
            if (weapon?.Implicit2 != ""){
                var element : [TextElement] = []
                element.append(TextElement(text: AddValuesToAffixes(text: (weapon?.Implicit2)!, i: 1, val1: Int((weapon?.Implicit2val)!)!, val2: Int((weapon?.Implicit2val)!)!), color: UIColor.blue))
                basetext.append(TextbyRow(row: element))
                return (basetext,2)
            }
            return (basetext,1)
        }
        else{
            return (basetexttemp,0)
        }
    }
    
    func WriteBaseText(basetexttemp : [TextbyRow], starty : CGFloat){
        let temp = ImplicitCheck(basetexttemp: basetexttemp)
        let basetext = temp.0
        
        let bounds = ItemTextFrame.bounds
        var startycoordinate : CGFloat = starty
        
        
        for i in 0...basetext.count-1{
            if (i == basetexttemp.count-1 || i == basetexttemp.count){
                AddLine(startycoordinate : CGFloat(i * rowheight)+startycoordinate, width: bounds.size.width)
                startycoordinate += 5
            }
            var rowtext : String = ""
            let newlabel: UILabel = UILabel()
            newlabel.frame = CGRect(x: 0, y: CGFloat(i * rowheight)+startycoordinate , width: bounds.size.width, height: CGFloat(rowheight))
            newlabel.textAlignment = NSTextAlignment.center

            
            ItemTextFrame.addSubview(newlabel)
            
            for a in 0...basetext[i].row.count-1{
                rowtext += basetext[i].row[a].text
            }
            
            let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: rowtext)
            for a in 0...basetext[i].row.count-1{
                attributedString.setColorForText(textForAttribute: basetext[i].row[a].text, withColor: basetext[i].row[a].color)
            }
            newlabel.font = UIFont(name: "Fontin-SmallCaps", size: fontsize)
            
            newlabel.attributedText = attributedString
            ItemTextFrame.addSubview(newlabel)
            if (i == basetext.count-1){
                if (currentitem.rarity != "white"){
                    AddLine(startycoordinate : CGFloat((i+1) * rowheight)+startycoordinate, width: bounds.size.width)
                    startycoordinate += 5
                }
            }
        }
        if (weapon?.Implicit1 != ""){
            startycoordinate += CGFloat(rowheight) + 5
        }
    }
    
    func WriteAffixText(affixtext : [String], starty : CGFloat){
        let bounds = ItemTextFrame.bounds
        var startycoordinate : CGFloat = starty + 10
        if (weapon?.Implicit1 != ""){
            startycoordinate += CGFloat(rowheight) + 5
        }
        if affixtext.count != 0{
            for i in 0...affixtext.count-1{
                let newlabel: UILabel = UILabel()
                newlabel.frame = CGRect(x: 0, y: CGFloat(i * rowheight)+startycoordinate , width: bounds.size.width, height: CGFloat(rowheight))
                newlabel.textColor = UIColor.blue
                newlabel.textAlignment = NSTextAlignment.center
                newlabel.font = UIFont.boldSystemFont(ofSize: fontsize)
                newlabel.text = String(affixtext[i])
                ItemTextFrame.addSubview(newlabel)
            }
        }
    }
    
    func GetDisplayedDmgValues(weapon : BaseWeapon)->(Int,Int){
        var dmgmin : Double = Double(weapon.DamageMin)
        var dmgmax : Double = Double(weapon.DamageMax)
        var multiplier : Double = 20
        
        if (currentitem.prefixes.count != 0){
            for i in 0...currentitem.prefixes.count-1{
                switch currentitem.prefixes[i].text{
                case "Adds # to # Physical Damage":
                    dmgmin += Double(currentitem.prefixes[i].currentvalue1)
                    dmgmax += Double(currentitem.prefixes[i].currentvalue2)
                case "#% increased Physical Damage / +# to Accuracy Rating":
                    multiplier += Double(currentitem.prefixes[i].currentvalue1)
                case "#% increased Physical Damage":
                    multiplier += Double(currentitem.prefixes[i].currentvalue1)
                default:
                    multiplier += 0
                }
            }
        }
        multiplier = 1+(multiplier/100)
        dmgmin = round(dmgmin*multiplier)
        dmgmax = round(dmgmax*multiplier)
        
        return (Int(dmgmin),Int(dmgmax))
    }
    
    func GetDisplayedCritValue(weapon : BaseWeapon)->String{
        var crit : Double = weapon.crit
        
        if currentitem.suffixes.count != 0{
            for i in 0...currentitem.suffixes.count-1{
                if (currentitem.suffixes[i].text == "#% increased Critical Strike Chance"){
                    crit = crit * (1+Double(currentitem.suffixes[i].currentvalue1)/100)
                }
            }
        }
        return String(crit)
    }
    
    func GetDisplayedElementalDmgValues()->[TextElement]{
        var row : [TextElement] = []
        var flag : Bool = false
        
        if (currentitem.prefixes.count != 0){
            for i in 0...currentitem.prefixes.count-1{
                if ((currentitem.prefixes[i].text == "Adds # to # Lightning Damage" || currentitem.prefixes[i].text == "Adds # to # Cold Damage" || currentitem.prefixes[i].text == "Adds # to # Fire Damage") && row.count == 0){
                    row.append(TextElement(text: "Elemental Damage: ", color: UIColor.gray))

                }
                if (currentitem.prefixes[i].text == "Adds # to # Lightning Damage"){
                    row.append(TextElement(text: String(currentitem.prefixes[i].currentvalue1), color: UIColor.yellow))
                    row.append(TextElement(text: "-", color: UIColor.gray))
                    row.append(TextElement(text: String(currentitem.prefixes[i].currentvalue2), color: UIColor.yellow))
                    flag = true
                }
                if (currentitem.prefixes[i].text == "Adds # to # Cold Damage"){
                    if (flag == true){
                        row.append(TextElement(text: ", ", color: UIColor.gray))
                    }
                    row.append(TextElement(text: String(currentitem.prefixes[i].currentvalue1), color: UIColor.blue))
                    row.append(TextElement(text: "-", color: UIColor.gray))
                    row.append(TextElement(text: String(currentitem.prefixes[i].currentvalue2), color: UIColor.blue))
                    flag = true
                }
                if (currentitem.prefixes[i].text == "Adds # to # Fire Damage"){
                    if (flag == true){
                        row.append(TextElement(text: ", ", color: UIColor.gray))
                    }
                    row.append(TextElement(text: String(currentitem.prefixes[i].currentvalue1), color: UIColor.red))
                    row.append(TextElement(text: "-", color: UIColor.gray))
                    row.append(TextElement(text: String(currentitem.prefixes[i].currentvalue2), color: UIColor.red))
                    flag = true
                }
            }
        }
        return row
    }

    func GetDisplayedAPSValue(weapon : BaseWeapon)->String{
        var aps = weapon.APS
        
        if currentitem.suffixes.count != 0{
            for i in 0...currentitem.suffixes.count-1{
                if (currentitem.suffixes[i].text == "#% increased Attack Speed"){
                    aps = aps * (1+Double(currentitem.suffixes[i].currentvalue1)/100)
                }
            }
        }
        return String(format: "%.2f", aps)
    }
    
    func GetDisplayedLevelRequirement(weapon : BaseWeapon)->String{
        let levelreq : Int = weapon.level
        /*
        if (currentitem.prefixes.count != 0){
            for i in 0...currentitem.prefixes.count-1{
                if (levelreq < currentitem.prefixes[i].lvlreq){
                    levelreq = currentitem.prefixes[i].lvlreq
                }
            }
        }
        if (currentitem.suffixes.count != 0){
            for i in 0...currentitem.suffixes.count-1{
                if (levelreq < currentitem.suffixes[i].lvlreq){
                    levelreq = currentitem.suffixes[i].lvlreq
                }
            }
        }
 */
        return String(levelreq)
    }
    
    
    func AddLine(startycoordinate : CGFloat, width : CGFloat){
        var imageName = "GrayLine"
        
        if (currentitem.rarity == "yellow"){
            imageName = "YellowLine"
        }
        if (currentitem.rarity == "blue"){
            imageName = "BlueLine"

        }

        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        
        imageView.frame = CGRect(x: 0, y: startycoordinate , width: width, height: 5)
        ItemTextFrame.addSubview(imageView)
        
    }
    
    func GenerateImplicitDisplay(weapon :BaseWeapon)->[TextbyRow]{
        let rows : [TextbyRow] = []
        //let row : [TextElement] = []
        
        if (weapon.Implicit1 != ""){
            
        }
        
        return rows
    }
    
    func GenerateBaseWeaponDisplay(weapon : BaseWeapon)->[TextbyRow]{
        var rows : [TextbyRow] = []
        var row : [TextElement] = []
        row.append(TextElement(text: weapon.type, color: UIColor.gray))
        rows.append(TextbyRow(row: row))
        row = []
        

        row.append(TextElement(text: "Quality : ", color: UIColor.gray))
        row.append(TextElement(text: "+", color: UIColor.blue))
        row.append(TextElement(text: (currentitem.quality.description), color: UIColor.blue))
        row.append(TextElement(text: "%", color: UIColor.blue))
        rows.append(TextbyRow(row: row))
        row = []
        
        let damage = GetDisplayedDmgValues(weapon : weapon)
        row.append(TextElement(text: "Physical Damage : ", color: UIColor.gray))
        row.append(TextElement(text: (String(damage.0) + "-" + String(damage.1)), color: UIColor.white))
        rows.append(TextbyRow(row: row))
        row = []
        
        
        row = GetDisplayedElementalDmgValues()
        if (row.count != 0){
            rows.append(TextbyRow(row: row))
            row = []
        }
        
        row.append(TextElement(text: "Critical Strike Chance: ", color: UIColor.gray))
        row.append(TextElement(text: GetDisplayedCritValue(weapon: weapon), color: UIColor.white))
        row.append(TextElement(text: "%", color: UIColor.white))
        rows.append(TextbyRow(row: row))
        row = []
        
        row.append(TextElement(text: "Attacks per Second: ", color: UIColor.gray))
        row.append(TextElement(text: GetDisplayedAPSValue(weapon: weapon), color: UIColor.white))
        rows.append(TextbyRow(row: row))
        row = []
        
        row.append(TextElement(text: "Weapon Range: ", color: UIColor.gray))
        row.append(TextElement(text: "9", color: UIColor.white))
        rows.append(TextbyRow(row: row))
        row = []
        
        row.append(TextElement(text: "Requires Level ", color: UIColor.gray))
        row.append(TextElement(text: "\(GetDisplayedLevelRequirement(weapon: weapon))", color: UIColor.white))
        if (weapon.ReqStr > 0){
            row.append(TextElement(text: ", ", color: UIColor.gray))
            row.append(TextElement(text: "\(String(weapon.ReqStr)) Str", color: UIColor.white))
        }
        if (weapon.ReqDex > 0){
            row.append(TextElement(text: ", ", color: UIColor.gray))
            row.append(TextElement(text: "\(String(weapon.ReqDex)) Dex", color: UIColor.white))
        }
        if (weapon.ReqInt > 0){
            row.append(TextElement(text: ", ", color: UIColor.gray))
            row.append(TextElement(text: "\(String(weapon.ReqInt)) Int", color: UIColor.white))
        }
        rows.append(TextbyRow(row: row))
        row = []
        return rows
    }
    
    func AddValuesToAffixes(text : String, i : Int, val1: Int, val2: Int)->String{
        var temp : String = text
        
        let temparray = temp.components(separatedBy: "#")
        if (temparray.count == 1){
            temp = temparray.first!
        }
        if (temparray.count == 2){
            temp = temparray.first! + String(val1) + temparray.last!
        }
        if (temparray.count == 3){
            temp = temparray.first! + String(val1) + temparray[1] + String(val2) + temparray.last!
        }
        
        return temp
    }
    
    
    func GenerateBaseAffixDisplay()->[String]{
        var rows : [String] = []
        var accuracy : Int = 0
        var physpercent : Int = 0

        if (currentitem.prefixes.count != 0){
            for i in 0...(currentitem.prefixes.count)-1{
                switch currentitem.prefixes[i].text{
                case "#% increased Physical Damage / +# to Accuracy Rating":
                    physpercent += currentitem.prefixes[i].currentvalue1
                    accuracy += currentitem.prefixes[i].currentvalue2
                case "#% increased Physical Damage":
                    physpercent += currentitem.prefixes[i].currentvalue1
                case "#% of Physical Attack Damage Leeched as Life":
                    let temp = String(Double(currentitem.prefixes[i].currentvalue1)/100) + "% of Physical Attack Damage Leeched as Life"
                    rows.append(temp)
                case "#% of Physical Attack Damage Leeched as Mana":
                    let temp = String(Double(currentitem.prefixes[i].currentvalue1)/100) + "% of Physical Attack Damage Leeched as Mana"
                    rows.append(temp)
                default:
                    let temp : String = AddValuesToAffixes(text: currentitem.prefixes[i].text, i: i, val1: currentitem.prefixes[i].currentvalue1, val2: currentitem.prefixes[i].currentvalue2)
                    rows.append(temp)
                }
            }
            if (physpercent != 0){
                let temp = String(physpercent) + "% increased Physical Damage"
                rows.insert(temp, at: 0)
            }
        }
        
        if (currentitem.suffixes.count != 0){
            for i in 0...(currentitem.suffixes.count)-1{
                switch currentitem.suffixes[i].text{
                case "+# to Accuracy Rating":
                    accuracy += currentitem.suffixes[i].currentvalue1
                case "#% increased Light Radius / +# or #% to Accuracy Rating":
                    if (currentitem.suffixes[i].currentvalue1 == 15){
                        let temp = String(currentitem.suffixes[i].currentvalue1) + "% increased Light Radius"
                        rows.append(temp)
                        let temp2 = String(currentitem.suffixes[i].currentvalue1) + "% to Accuracy Rating"
                        rows.append(temp2)
                    }
                    else{
                        let temp = String(currentitem.suffixes[i].currentvalue1) + "% increased Light Radius"
                        rows.append(temp)
                        accuracy += currentitem.suffixes[i].currentvalue2
                    }
                default:
                    let temp : String = AddValuesToAffixes(text: currentitem.suffixes[i].text, i: i, val1: currentitem.suffixes[i].currentvalue1, val2: currentitem.suffixes[i].currentvalue2)
                    rows.append(temp)
                }
            }
        }
        if (accuracy != 0){
            let temp = "+" + String(accuracy) + " to Accuracy Rating"
            rows.append(temp)
        }
        
        return rows
    }
    
    func GenerateItemText(weapon : BaseWeapon){
        ItemTextFrame.subviews.forEach({ $0.removeFromSuperview() })
        let BaseItemText : [TextbyRow] = GenerateBaseWeaponDisplay(weapon: weapon)

        let AffixText = GenerateBaseAffixDisplay()
        
        var newheight : CGFloat = CGFloat((BaseItemText.count + AffixText.count) * rowheight)+10
        var numberofimplicitmods : Int = 0
        
        if (weapon.Implicit1 != ""){
            newheight += CGFloat(rowheight) + 5
        }
        if (weapon.Implicit2 != ""){
            newheight += CGFloat(rowheight) + 5
            numberofimplicitmods += 1
        }
        resizeframe(newheight: newheight)
        
        WriteBaseText(basetexttemp: BaseItemText, starty: 0)
        WriteAffixText(affixtext: AffixText, starty: CGFloat((BaseItemText.count+numberofimplicitmods) * rowheight))
    }
    
    func GenerateItemName()->(String,String){
        var name : (String, String) = ("","")
        if (weapon != nil){
            name.0 = itemnameprefixes[Randomizer(min: 0, max: itemnameprefixes.count-1)]
            if (weapon?.type == "Thrusting"){
                let temp = itemnamesuffixes.suffix["Sword"]
                name.1 = temp![Randomizer(min: 0, max: (temp?.count)!-1)]
            }
            else{
                let temp = itemnamesuffixes.suffix[(weapon?.type)!]
                name.1 = temp![Randomizer(min: 0, max: (temp?.count)!-1)]
            }
        }
        return name
    }

    func ApplyGenerateItemName(){
        let itemname : (String, String) = GenerateItemName()
        currentitem.nameprefix = itemname.0
        currentitem.namesuffix = itemname.1
    }
    
    func ChangeItemNameBGSize(){
        var imgname : String = ""
        var color : UIColor = UIColor.black
        
        //switch craftingcomponents[selectedcomponent].newrarity {
        switch currentitem.rarity {
        case "blue":
            ItemNameRowOnly1.isHidden = false
            ItemNameRow1.isHidden = true
            ItemNameRow2.isHidden = true
            ItemNameRowOnly1.textColor = UIColor.blue
            if (weapon != nil){
                ItemNameRowOnly1.text = currentitem.nameprefix + " " + (weapon?.Name)!
            }
            imgname = "BlueBG"
            color = UIColor.blue
        case "yellow":
            ItemNameRowOnly1.isHidden = true
            ItemNameRow1.isHidden = false
            ItemNameRow2.isHidden = false
            if (weapon != nil){
                ItemNameRow1.text = currentitem.nameprefix + " " + currentitem.namesuffix
                ItemNameRow2.text = weapon?.Name
            }
            imgname = "YellowBG"
            color = UIColor.yellow
        default:
            ItemNameRowOnly1.isHidden = false
            ItemNameRow1.isHidden = true
            ItemNameRow2.isHidden = true
            ItemNameRowOnly1.textColor = UIColor.white
            if (weapon != nil){
                ItemNameRowOnly1.text = weapon?.Name
            }
            imgname = "WhiteBG"
            color = UIColor.white
        }
        ItemNameBG.image = UIImage(named: imgname)
        ItemTextFrameHeight.constant = (ItemNameBG.image?.size.height)!
        ItemNameTextFrame.layoutIfNeeded()
        resizeframe(newheight: ItemTextFrame.frame.size.height)
        ItemNameRow1.textColor = color
        ItemNameRow2.textColor = color
    }
    
    
    @IBAction func CraftItem(_ sender: UITapGestureRecognizer) {
        if CheckCorrectCurrency(){
            if (selectedcomponent != 8){
                currentitem.rarity = craftingcomponents[selectedcomponent].newrarity
            }
            status.text = ""
            WhatToAdd()
            if (weapon != nil){
                GenerateItemText(weapon: weapon!)
                if (selectedcomponent != 6 && selectedcomponent != 5){
                    ApplyGenerateItemName()
                    ChangeItemNameBGSize()
                }
            }
            if (armour != nil){
                UpdateImage(imageurl: (armour?.url)!)
            }
            if (accessory != nil){
                UpdateImage(imageurl: (accessory?.url)!)
            }
            SendToAppDelegate(currentitem: currentitem, affixes: affixes!, weapon: weapon, armour: armour, accessory: accessory)
        }
    }
    
    func WhatToAdd(){
        if (craftingcomponents[selectedcomponent].name == "Transmute"){
            let roll1 = Int(arc4random_uniform(2)+1)
            if (roll1 == 2){
                RollSuffix()
                RollPrefix()
            }
            if (roll1 == 1){
                let roll2 = Int(arc4random_uniform(2)+1)
                if (roll2 == 1){
                    RollPrefix()
                }
                if (roll2 == 2){
                    RollSuffix()
                }
            }
        }
        if (craftingcomponents[selectedcomponent].name == "Alchemy"){
            currentitem = ItemStats(nameprefix : "", namesuffix : "", rarity: "yellow", quality: 20, suffixes: [], prefixes: [])
            ClearUsedAffixes()
            
            let roll1 = 3+Int(arc4random_uniform(3)+1)
            for _ in 1...roll1{
                RollAffix(item: currentitem)
            }
        }
        if (craftingcomponents[selectedcomponent].name == "Alteration"){
            currentitem = ItemStats(nameprefix : "", namesuffix : "", rarity: "blue", quality: 20, suffixes: [], prefixes: [])
            ClearUsedAffixes()

            let roll1 = Int(arc4random_uniform(2)+1)
            if (roll1 == 2){
                RollSuffix()
                RollPrefix()
            }
            if (roll1 == 1){
                let roll2 = Int(arc4random_uniform(2)+1)
                if (roll2 == 1){
                    RollPrefix()
                }
                if (roll2 == 2){
                    RollSuffix()
                }
            }
        }
        if (craftingcomponents[selectedcomponent].name == "Chaos"){
            currentitem = ItemStats(nameprefix : "", namesuffix : "", rarity: "yellow", quality: 20, suffixes: [], prefixes: [])
            ClearUsedAffixes()
            
            let roll1 = 3+Int(arc4random_uniform(3)+1)
            for _ in 1...roll1{
                RollAffix(item: currentitem)
            }
        }
        if (craftingcomponents[selectedcomponent].name == "Regal"){
            currentitem.rarity = "yellow"
            let roll2 = Int(arc4random_uniform(2)+1)
            if (roll2 == 1){
                RollPrefix()
            }
            if (roll2 == 2){
                RollSuffix()
            }
        }
        if (craftingcomponents[selectedcomponent].name == "Augment"){
            if (currentitem.prefixes.count == 0 || currentitem.suffixes.count == 0){
                if (currentitem.prefixes.count == 1){
                    RollSuffix()
                }
                if (currentitem.suffixes.count == 1){
                    RollPrefix()
                }
            }
        }
        if (craftingcomponents[selectedcomponent].name == "Exalted"){
            if (currentitem.prefixes.count != 3 || currentitem.suffixes.count != 3){
                RollAffix(item: currentitem)
            }
        }
        if (craftingcomponents[selectedcomponent].name == "Scouring"){
            currentitem = ItemStats(nameprefix : "", namesuffix : "", rarity: "white", quality: 20, suffixes: [], prefixes: [])
            ClearUsedAffixes()
        }
        if (craftingcomponents[selectedcomponent].name == "Divine"){
            var counter : Int = (currentitem.prefixes.count)
            if (counter != 0){
                for i in 0...counter-1{
                    var temp : Int = Randomizer(min: (currentitem.prefixes[i].val1min), max: (currentitem.prefixes[i].val1max))
                    currentitem.prefixes[i].currentvalue1 = temp
                    temp = Randomizer(min: (currentitem.prefixes[i].val2min), max: (currentitem.prefixes[i].val2max))
                    currentitem.prefixes[i].currentvalue2 = temp
                }
            }

            counter = (currentitem.suffixes.count)
            if (counter != 0){
                for i in 0...counter-1{
                    var temp : Int = Randomizer(min: (currentitem.suffixes[i].val1min), max: (currentitem.suffixes[i].val1max))
                    currentitem.suffixes[i].currentvalue1 = temp
                    temp = Randomizer(min: (currentitem.suffixes[i].val2min), max: (currentitem.suffixes[i].val2max))
                    currentitem.suffixes[i].currentvalue2 = temp
                }
            }
        }
        UpdateAffixCounts()
    }
    
    //Prefix1image.contentMode = .scaleAspectFit
    //
    
    
    func UpdateAffixCounts(){
        if (currentitem.prefixes.count == 0){
            Prefix1image.image = UIImage(named: "FlameOff")
            Prefix2image.image = UIImage(named: "FlameOff")
            Prefix3image.image = UIImage(named: "FlameOff")
        }
        if (currentitem.prefixes.count == 1){
            Prefix1image.image = UIImage(named: "FlameOn")
            Prefix2image.image = UIImage(named: "FlameOff")
            Prefix3image.image = UIImage(named: "FlameOff")
        }
        if (currentitem.prefixes.count == 2){
            Prefix1image.image = UIImage(named: "FlameOn")
            Prefix2image.image = UIImage(named: "FlameOn")
            Prefix3image.image = UIImage(named: "Flameff")
        }
        if (currentitem.prefixes.count == 3){
            Prefix1image.image = UIImage(named: "FlameOn")
            Prefix2image.image = UIImage(named: "FlameOn")
            Prefix3image.image = UIImage(named: "FlameOn")
        }
        if (currentitem.suffixes.count == 0){
            Suffix1image.image = UIImage(named: "FlameOff")
            Suffix2image.image = UIImage(named: "FlameOff")
            Suffix3image.image = UIImage(named: "FlameOff")
        }
        if (currentitem.suffixes.count == 1){
            Suffix1image.image = UIImage(named: "FlameOn")
            Suffix2image.image = UIImage(named: "FlameOff")
            Suffix3image.image = UIImage(named: "FlameOff")
        }
        if (currentitem.suffixes.count == 2){
            Suffix1image.image = UIImage(named: "FlameOn")
            Suffix2image.image = UIImage(named: "FlameOn")
            Suffix3image.image = UIImage(named: "FlameOff")
        }
        if (currentitem.suffixes.count == 3){
            Suffix1image.image = UIImage(named: "FlameOn")
            Suffix2image.image = UIImage(named: "FlameOn")
            Suffix3image.image = UIImage(named: "FlameOn")
        }
    }
    

    func ClearUsedAffixes(){
        for i in 0...(affixes?.craftprefix.count)!-1{
            affixes?.craftprefix[i].used = 0
        }
        for i in 0...(affixes?.craftsuffix.count)!-1{
            affixes?.craftsuffix[i].used = 0
        }
    }
    
    func RollAffix(item : ItemStats){
        if (item.prefixes.count == 3 && item.suffixes.count == 3){
            print("Items affixes are full")
        }
        else if (item.prefixes.count == 3){
            RollSuffix()
        }
        else if (item.suffixes.count == 3){
            RollPrefix()
        }
        else{
            let numberrange = 5-item.prefixes.count+item.suffixes.count
            let num = Int(arc4random_uniform(UInt32(numberrange))+1)
            if (num <= 3-item.prefixes.count){
                RollPrefix()
            }
            else{
                RollSuffix()
            }
        }
    }
    
    func RollSuffix(){
        if let differentaffixescount = affixes?.craftsuffix.count{
            var totalrollablevariables : Int = 0
            for i in 0...differentaffixescount-1{
                if (affixes?.craftsuffix[i].used == 0){
                    totalrollablevariables += (affixes?.craftsuffix[i].amount)!
                }
            }
            var roll = Int(arc4random_uniform(UInt32(totalrollablevariables)))
            var i : Int = 0
            var flag : Bool = false
            while (flag == false){
                if (affixes?.craftsuffix[i].used == 0){
                    if (roll < (affixes?.craftsuffix[i].amount)!){
                        flag = true
                    }
                    else{
                        roll -= (affixes?.craftsuffix[i].amount)!
                        i += 1
                    }
                }
                else{
                    i += 1
                }
            }
            currentitem.suffixes.append(CurrentAffixes(text: (affixes?.craftsuffix[i].desc)!,
                                                       lvlreq : (affixes?.craftsuffix[i].values[roll].iLvl)!,
                                                        currentvalue1: Randomizer(min: (affixes?.craftsuffix[i].values[roll].val1)!, max: (affixes?.craftsuffix[i].values[roll].val2)!),
                                                        currentvalue2: Randomizer(min: (affixes?.craftsuffix[i].values[roll].val3)!, max: (affixes?.craftsuffix[i].values[roll].val4)!),
                                                        val1min: (affixes?.craftsuffix[i].values[roll].val1)!,
                                                        val1max: (affixes?.craftsuffix[i].values[roll].val2)!,
                                                        val2min: (affixes?.craftsuffix[i].values[roll].val3)!,
                                                        val2max: (affixes?.craftsuffix[i].values[roll].val4)!
            ))
            affixes?.craftsuffix[i].used = 1
        }
    }
    
    func Randomizer(min : Int, max : Int)->Int{
        let number : Int = Int(arc4random_uniform(UInt32(abs(max-min))))+min
        return number
    }
    
    func RollPrefix(){
        if let differentaffixescount = affixes?.craftprefix.count{
            var totalrollablevariables : Int = 0
            for i in 0...differentaffixescount-1{
                if (affixes?.craftprefix[i].used == 0){
                    totalrollablevariables += (affixes?.craftprefix[i].amount)!
                }
            }
            var roll = Int(arc4random_uniform(UInt32(totalrollablevariables)))
            var i : Int = 0
            var flag : Bool = false
            while (flag == false){
                if (affixes?.craftprefix[i].used == 0){
                    if (roll < (affixes?.craftprefix[i].amount)!){
                        flag = true
                    }
                    else{
                        roll -= (affixes?.craftprefix[i].amount)!
                        i += 1
                    }
                }
                else{
                    i += 1
                }
            }
            currentitem.prefixes.append(CurrentAffixes(text: (affixes?.craftprefix[i].desc)!,
                                                       lvlreq : (affixes?.craftprefix[i].values[roll].iLvl)!,
                                                        currentvalue1: Randomizer(min: (affixes?.craftprefix[i].values[roll].val1)!, max: (affixes?.craftprefix[i].values[roll].val2)!),
                                                        currentvalue2: Randomizer(min: (affixes?.craftprefix[i].values[roll].val3)!, max: (affixes?.craftprefix[i].values[roll].val4)!),
                                                        val1min: (affixes?.craftprefix[i].values[roll].val1)!,
                                                        val1max: (affixes?.craftprefix[i].values[roll].val2)!,
                                                        val2min: (affixes?.craftprefix[i].values[roll].val3)!,
                                                        val2max: (affixes?.craftprefix[i].values[roll].val4)!
            ))
            affixes?.craftprefix[i].used = 1
        }
    }
    
    func ChangeDisplayedItem(){
        ChangeItemNameBGSize()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "left" {
            let transition = CATransition()
            transition.duration = 1.0
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromLeft
            transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
            view.window!.layer.add(transition, forKey: kCATransition)
        }
        if segue.identifier == "right" {
            let transition = CATransition()
            transition.duration = 1.0
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
            view.window!.layer.add(transition, forKey: kCATransition)
        }
        if segue.destination is OptionsViewController {
            SendToAppDelegate(currentitem: currentitem, affixes: affixes!, weapon: weapon, armour: armour, accessory: accessory)
        }
    }
}


















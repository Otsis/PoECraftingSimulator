//
//  BaseSelectViewController.swift
//  PoeCraftingSimulator
//
//  Created by Markus Hyvärinen on 13/12/2017.
//  Copyright © 2017 Markus. All rights reserved.
//

import UIKit
/*
class BaseSelectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var options : [SliderOptions] = []
    var selected : Int = 0
    var selectedslot : Int = 0
    var selectedtype : Int = 0
    var selectedbase : Int = 0
    var baseweapondata : [BaseWeapon] = []
    var baseaccessorydata : [BaseAccessory] = []
    var basearmourdata : [BaseArmour] = []
    
    let connectiontoFMDB: FMDatabase = FMDatabase(path: getpath())
    
    @IBOutlet weak var BaseClassFrame: UIView!
    @IBOutlet weak var BaseSlotFrame: UIView!
    @IBOutlet weak var BaseTypeFrame: UIView!
    
    @IBOutlet weak var BaseSlotMainFrame: UIView!
    @IBOutlet weak var BaseSlotBGFrameHeight: NSLayoutConstraint!
    @IBOutlet weak var BaseTypeMainFrame: UIView!
    
    @IBOutlet weak var BaseTypeBGFrameHeight: NSLayoutConstraint!
    
    @IBOutlet weak var TableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dbpath = getpath()
        print(dbpath)
        options = GenerateOptions()
        var items : [String] = []
        

        
        
        for i in 0...options.count-1{
            items.append(options[i].ClassDisplayText)
        }
        let customSC = UISegmentedControl(items: items)
        
        let frame = BaseClassFrame.bounds
        customSC.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width+40, height: frame.height)
        customSC.addTarget(self, action: #selector(SlotFrameLoader(sender:)), for: .valueChanged)
        BaseClassFrame.addSubview(customSC)
    }
    
    @objc func SlotFrameLoader(sender: UISegmentedControl) {
        
        TableView.isHidden = true

        BaseTypeBGFrameHeight.constant = 0
        BaseTypeMainFrame.layoutIfNeeded()
        BaseTypeFrame.layoutIfNeeded()
        
        BaseSlotBGFrameHeight.constant = 60
        BaseSlotMainFrame.layoutIfNeeded()
        BaseSlotFrame.layoutIfNeeded()
        
        BaseSlotFrame.subviews.forEach({ $0.removeFromSuperview() })
        BaseTypeFrame.subviews.forEach({ $0.removeFromSuperview() })
        selected = sender.selectedSegmentIndex
        
        if (selected == 2){
            BaseSlotBGFrameHeight.constant = 0
            BaseSlotMainFrame.layoutIfNeeded()
            BaseSlotFrame.layoutIfNeeded()
            
            BaseTypeBGFrameHeight.constant = 60
            BaseTypeMainFrame.layoutIfNeeded()
            BaseTypeFrame.layoutIfNeeded()
            var items : [String] = []
            
            for i in 0...options[selected].SlotName[0].TypeName.count-1{
                items.append(options[selected].SlotName[0].TypeName[i].TypeDisplayText)
            }
            let customSC = UISegmentedControl(items: items)
            
            let frame = BaseTypeFrame.bounds
            //UILabel.appearance(whenContainedInInstancesOf: [UISegmentedControl.self]).numberOfLines = 2
            
            customSC.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: frame.height)
            customSC.addTarget(self, action: #selector(BaseFrameLoader(sender:)), for: .valueChanged)
            BaseTypeFrame.addSubview(customSC)
            
            /*
            TableView.isHidden = false
            BaseSlotBGFrameHeight.constant = 0
            BaseSlotMainFrame.layoutIfNeeded()
            BaseSlotFrame.layoutIfNeeded()
 */
        }
        else{
            var items : [String] = []
            for i in 0...options[selected].SlotName.count-1{
                items.append(options[selected].SlotName[i].SlotDisplayText)
            }
            let customSC = UISegmentedControl(items: items)
            let frame = BaseSlotFrame.bounds
            customSC.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: frame.height)
            customSC.addTarget(self, action: #selector(TypeFrameLoader(sender:)), for: .valueChanged)
            BaseSlotFrame.addSubview(customSC)
        }
    }
    
    @objc func TypeFrameLoader(sender: UISegmentedControl) {
        TableView.isHidden = true
        BaseTypeFrame.subviews.forEach({ $0.removeFromSuperview() })
        BaseTypeFrame.layoutIfNeeded()
        selectedslot = sender.selectedSegmentIndex
        var items : [String] = []
        if (options[selected].SlotName[selectedslot].TypeName.count > 5){
            BaseTypeBGFrameHeight.constant = 110
            BaseTypeMainFrame.layoutIfNeeded()
            BaseTypeFrame.layoutIfNeeded()
            
            for i in 0...options[selected].SlotName[selectedslot].TypeName.count-1{
                items.append(options[selected].SlotName[selectedslot].TypeName[i].TypeDisplayText)
            }
            let customSC = UISegmentedControl(items: items)
            //customSC.makeMultiline(numberOfLines: 2)

            let frame = BaseTypeFrame.bounds
            //UILabel.appearance(whenContainedInInstancesOf: [UISegmentedControl.self]).numberOfLines = 2
            
            customSC.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: frame.height)
            customSC.addTarget(self, action: #selector(BaseFrameLoader(sender:)), for: .valueChanged)
            BaseTypeFrame.addSubview(customSC)
        }
        else{
            BaseTypeBGFrameHeight.constant = 60
            BaseTypeMainFrame.layoutIfNeeded()
            BaseTypeFrame.layoutIfNeeded()
            for i in 0...options[selected].SlotName[selectedslot].TypeName.count-1{
                items.append(options[selected].SlotName[selectedslot].TypeName[i].TypeDisplayText)
            }
            let customSC = UISegmentedControl(items: items)
            
            let frame = BaseTypeFrame.bounds
            //UILabel.appearance(whenContainedInInstancesOf: [UISegmentedControl.self]).numberOfLines = 2
    
            customSC.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: frame.height)
            customSC.addTarget(self, action: #selector(BaseFrameLoader(sender:)), for: .valueChanged)
            BaseTypeFrame.addSubview(customSC)
        }
    }
    
    
    func ArmorQuery()->String{
        var sqlstatement : String = ""
        if (options[selected].SlotName[selectedslot].TypeName[selectedtype].TypeDisplayText == "AR"){
            sqlstatement = "select * from \(options[selected].SlotName[selectedslot].TypeName[selectedtype].TypeDBName) WHERE EvasionRating = 0 and EnergyShield = 0 ORDER BY \(options[selected].SlotName[selectedslot].TypeName[selectedtype].TypeDBName+"ID") DESC;"
        }
        if (options[selected].SlotName[selectedslot].TypeName[selectedtype].TypeDisplayText == "Eva"){
            sqlstatement = "select * from \(options[selected].SlotName[selectedslot].TypeName[selectedtype].TypeDBName) WHERE Armour = 0 and EnergyShield = 0 ORDER BY \(options[selected].SlotName[selectedslot].TypeName[selectedtype].TypeDBName+"ID") DESC;"
        }
        if (options[selected].SlotName[selectedslot].TypeName[selectedtype].TypeDisplayText == "ES"){
            sqlstatement = "select * from \(options[selected].SlotName[selectedslot].TypeName[selectedtype].TypeDBName) WHERE EvasionRating = 0 and Armour = 0 ORDER BY \(options[selected].SlotName[selectedslot].TypeName[selectedtype].TypeDBName+"ID") DESC;"
        }
        if (options[selected].SlotName[selectedslot].TypeName[selectedtype].TypeDisplayText == "AR/Eva"){
            sqlstatement = "select * from \(options[selected].SlotName[selectedslot].TypeName[selectedtype].TypeDBName) WHERE EvasionRating > 0 and Armour > 0 and EnergyShield = 0 ORDER BY \(options[selected].SlotName[selectedslot].TypeName[selectedtype].TypeDBName+"ID") DESC;"
        }
        if (options[selected].SlotName[selectedslot].TypeName[selectedtype].TypeDisplayText == "AR/ES"){
            sqlstatement = "select * from \(options[selected].SlotName[selectedslot].TypeName[selectedtype].TypeDBName) WHERE EvasionRating = 0 and Armour > 0 and EnergyShield > 0 ORDER BY \(options[selected].SlotName[selectedslot].TypeName[selectedtype].TypeDBName+"ID") DESC;"
        }
        if (options[selected].SlotName[selectedslot].TypeName[selectedtype].TypeDisplayText == "Eva/ES"){
            sqlstatement = "select * from \(options[selected].SlotName[selectedslot].TypeName[selectedtype].TypeDBName) WHERE EvasionRating > 0 and Armour = 0 and EnergyShield > 0 ORDER BY \(options[selected].SlotName[selectedslot].TypeName[selectedtype].TypeDBName+"ID") DESC;"
        }
        if (options[selected].SlotName[selectedslot].TypeName[selectedtype].TypeDisplayText == "AR/Eva/ES"){
            sqlstatement = "select * from \(options[selected].SlotName[selectedslot].TypeName[selectedtype].TypeDBName) WHERE EvasionRating > 0 and Armour > 0 and EnergyShield > 0 ORDER BY \(options[selected].SlotName[selectedslot].TypeName[selectedtype].TypeDBName+"ID") DESC;"
        }
        return sqlstatement
    }
    

    
    @objc func BaseFrameLoader(sender: UISegmentedControl) {
        TableView.isHidden = false
        selectedtype = sender.selectedSegmentIndex
        let dbpath = getpath()
        var connectiontoFMDB: FMDatabase = FMDatabase()
        connectiontoFMDB = FMDatabase(path: dbpath)
        baseweapondata = []
        baseaccessorydata = []
        basearmourdata = []
        if FileManager.default.fileExists(atPath: dbpath){
            if (connectiontoFMDB.open()){
                if (options[selected].ClassDisplayText == "Weapons"){
                    let sqlstatement = "select * from \(options[selected].SlotName[selectedslot].TypeName[selectedtype].TypeDBName) ORDER BY \(options[selected].SlotName[selectedslot].TypeName[selectedtype].TypeDBName+"ID") DESC;"
                    let resultset : FMResultSet = connectiontoFMDB.executeQuery(sqlstatement, withArgumentsIn: [])!
                    while resultset.next() == true {
                        let temp = BaseWeapon(slot : options[selected].SlotName[selectedslot].SlotDisplayText,
                                              type : options[selected].SlotName[selectedslot].TypeName[selectedtype].TypeDisplayText,
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
                }
                if (options[selected].ClassDisplayText == "Accessories"){
                    let sqlstatement = "select * from \(options[selected].SlotName[0].TypeName[selectedtype].TypeDBName) ORDER BY \(options[selected].SlotName[0].TypeName[selectedtype].TypeDBName+"ID") DESC;"
                    let resultset : FMResultSet = connectiontoFMDB.executeQuery(sqlstatement, withArgumentsIn: [])!
                    while resultset.next() == true {
                    let temp = BaseAccessory(slot : options[selected].ClassDisplayText,
                                             type : options[selected].SlotName[0].TypeName[selectedtype].TypeDisplayText,
                                             url: resultset.string(forColumn: "url")!,
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
                }
                if (options[selected].ClassDisplayText == "Armours"){
                    //let sqlstatement = "select * from \(options[selected].SlotName[selectedslot].TypeName[selectedtype].TypeDBName) ORDER BY \(options[selected].SlotName[selectedslot].TypeName[selectedtype].TypeDBName+"ID") DESC;"
                    let sqlstatement = ArmorQuery()
                    let resultset : FMResultSet = connectiontoFMDB.executeQuery(sqlstatement, withArgumentsIn: [])!
                    while resultset.next() == true {
                        let temp = BaseArmour(slot : options[selected].SlotName[selectedslot].SlotDisplayText,
                                              type : options[selected].SlotName[selectedslot].TypeName[selectedtype].TypeDisplayText,
                                              url: resultset.string(forColumn: "url")!,
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
                }
            }
        }
        connectiontoFMDB.close()
        TableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (options[selected].ClassDisplayText == "Accessories"){
            return baseaccessorydata.count
        }
        if (options[selected].ClassDisplayText == "Weapons"){
            return baseweapondata.count
        }
        if (options[selected].ClassDisplayText == "Armours"){
            return basearmourdata.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BaseItems", for: indexPath) as! BaseTableViewCell
        
        if (options[selected].ClassDisplayText == "Weapons"  && baseweapondata.count != 0){
            cell.BaseStrReq.isHidden = false
            cell.BaseDexReq.isHidden = false
            cell.BaseIntReq.isHidden = false
            cell.RowTwo.isHidden = false
            
            cell.BaseItemName.text = baseweapondata[indexPath[1]].Name
            
            cell.RowOne.text = String(baseweapondata[indexPath[1]].DamageMin) + " - " + String(baseweapondata[indexPath[1]].DamageMax)
            cell.RowTwo.text = "APS: " + String(describing: baseweapondata[indexPath[1]].APS) + "   DPS: " + String(describing: baseweapondata[indexPath[1]].DPS)
            cell.BaseStrReq.text = String(baseweapondata[indexPath[1]].ReqStr)
            cell.BaseDexReq.text = String(baseweapondata[indexPath[1]].ReqDex)
            cell.BaseIntReq.text = String(baseweapondata[indexPath[1]].ReqInt)
            
            cell.BaseImage.imageFromServerURL(urlString: baseweapondata[indexPath[1]].url, defaultImage: "DefaultBase")
        }
        
        if (options[selected].ClassDisplayText == "Armours" && basearmourdata.count != 0){
            cell.BaseStrReq.isHidden = false
            cell.BaseDexReq.isHidden = false
            cell.BaseIntReq.isHidden = false
            cell.RowTwo.isHidden = false
            
            cell.BaseItemName.text = basearmourdata[indexPath[1]].Name
            
            cell.RowOne.text = "Armour     Evasion     Energy Shield"
            cell.RowTwo.text = String(basearmourdata[indexPath[1]].Armour) + "              " + String(basearmourdata[indexPath[1]].EvasionRating) + "               " + String(basearmourdata[indexPath[1]].EnergyShield)
            cell.BaseStrReq.text = String(basearmourdata[indexPath[1]].ReqStr)
            cell.BaseDexReq.text = String(basearmourdata[indexPath[1]].ReqDex)
            cell.BaseIntReq.text = String(basearmourdata[indexPath[1]].ReqInt)
            
            cell.BaseImage.imageFromServerURL(urlString: basearmourdata[indexPath[1]].url, defaultImage: "DefaultBase")
        }
        
        if (options[selected].ClassDisplayText == "Accessories" && baseaccessorydata.count != 0){
            cell.BaseItemName.text = baseaccessorydata[indexPath[1]].Name
            
            cell.RowOne.text = baseaccessorydata[indexPath[1]].implicit1 + " " + String(baseaccessorydata[indexPath[1]].Implicit1valmin) + "-" + String(baseaccessorydata[indexPath[1]].Implicit1valmax)
            if (baseaccessorydata[indexPath[1]].Implicit2 != ""){
                cell.RowTwo.text = baseaccessorydata[indexPath[1]].Implicit2 + " " + String(baseaccessorydata[indexPath[1]].Implicit2valmin) + "-" + String(baseaccessorydata[indexPath[1]].Implicit2valmax)
            }
            else{
                cell.RowTwo.isHidden = true
            }
            cell.BaseStrReq.isHidden = true
            cell.BaseDexReq.isHidden = true
            cell.BaseIntReq.isHidden = true
            
            cell.BaseImage.imageFromServerURL(urlString: baseaccessorydata[indexPath[1]].url, defaultImage: "DefaultBase")
        }
        return cell
    }
    

    
    func AffixQuery(dbname : String, ids: [String])->String{
        var sqlstatement : String = "select * from \(dbname)"
        if (ids[0] == ""){
            sqlstatement += " where \(dbname)ID=-1"
            return sqlstatement
        }
        sqlstatement += " where \(dbname)ID=\(ids[0])"
        if (ids.count > 1){
            for i in 1...ids.count-1{
                sqlstatement += " or \(dbname)ID=\(ids[i])"
            }
        }
        sqlstatement += ";"
        return sqlstatement
    }
    
    func GetAffixes(dbname : String, arraycontent : String)-> [AffixVals]{
        var temp = arraycontent.replacingOccurrences(of: "[", with: "")
        temp = temp.replacingOccurrences(of: "]", with: "")
        let temparray = temp.components(separatedBy: ", ")
        let sqlstatement = AffixQuery(dbname: dbname, ids: temparray)
        let affixset : FMResultSet = connectiontoFMDB.executeQuery(sqlstatement, withArgumentsIn: [])!
        var vals : [AffixVals] = []
        while affixset.next() == true {
            let temp : AffixVals = AffixVals(iLvl: Int(affixset.int(forColumn: "iLvl")),
                                             name: affixset.string(forColumn: "name")!,
                                             val1: Int(affixset.int(forColumn: "val1")),
                                             val2: Int(affixset.int(forColumn: "val2")),
                                             val3: Int(affixset.int(forColumn: "val3")),
                                             val4: Int(affixset.int(forColumn: "val4")))
            vals.append(temp)
        }
        return vals
    }
    
    func GetAffixes(dbname : String)->Affixes{
        var craftableprefixes : [Prefix] = []
        var essenceableprefixes : [Prefix] = []
        var masterabeprefixes : [Prefix] = []
        
        var craftablesuffixes : [Suffix] = []
        var essenceablesuffixes : [Suffix] = []
        var masterabesuffixes : [Suffix] = []

        if FileManager.default.fileExists(atPath: getpath()){
            if (connectiontoFMDB.open()){
                var sqlstatement = "select * from \(dbname)Prefix"
                if (dbname == "ThrustingOneHandSword"){
                    sqlstatement = "select * from OneHandSwordPrefix"
                }
                let allprefixset : FMResultSet = connectiontoFMDB.executeQuery(sqlstatement, withArgumentsIn: [])!
                while allprefixset.next() == true {
                    let craft : [AffixVals] = GetAffixes(dbname: allprefixset.string(forColumn: "DBname")!, arraycontent: allprefixset.string(forColumn: "GeneralUsage")!)
    
                    craftableprefixes.append(Prefix(desc: allprefixset.string(forColumn: "Desc")!, amount: craft.count, used: 0, master: "", essence: "", values: craft))
                    
                    let essence : [AffixVals] = GetAffixes(dbname: allprefixset.string(forColumn: "DBname")!, arraycontent: allprefixset.string(forColumn: "EssenceUsage")!)
                    essenceableprefixes.append(Prefix(desc: allprefixset.string(forColumn: "Desc")!, amount: essence.count, used: 0, master: "", essence: allprefixset.string(forColumn: "EssenceName")!, values: essence))
                    
                    let master : [AffixVals] = GetAffixes(dbname: allprefixset.string(forColumn: "DBname")!, arraycontent: allprefixset.string(forColumn: "MasterUsage")!)
                    masterabeprefixes.append(Prefix(desc: allprefixset.string(forColumn: "Desc")!, amount: master.count, used: 0, master: allprefixset.string(forColumn: "MasterUsage")!, essence: "", values: master))

                }
                
                sqlstatement = "select * from \(dbname)Suffix"
                if (dbname == "ThrustingOneHandSword"){
                    sqlstatement = "select * from OneHandSwordSuffix"
                }
                let allsuffixset : FMResultSet = connectiontoFMDB.executeQuery(sqlstatement, withArgumentsIn: [])!
                while allsuffixset.next() == true {
                    let craft : [AffixVals] = GetAffixes(dbname: allsuffixset.string(forColumn: "DBname")!, arraycontent: allsuffixset.string(forColumn: "GeneralUsage")!)
                    craftablesuffixes.append(Suffix(desc: allsuffixset.string(forColumn: "Desc")!, amount: craft.count, used: 0, master: "", essence: "", values: craft))
                    
                    let essence : [AffixVals] = GetAffixes(dbname: allsuffixset.string(forColumn: "DBname")!, arraycontent: allsuffixset.string(forColumn: "EssenceUsage")!)
                    essenceablesuffixes.append(Suffix(desc: allsuffixset.string(forColumn: "Desc")!, amount: essence.count, used: 0, master: "", essence: allsuffixset.string(forColumn: "EssenceName")!, values: essence))
                    
                    let master : [AffixVals] = GetAffixes(dbname: allsuffixset.string(forColumn: "DBname")!, arraycontent: allsuffixset.string(forColumn: "MasterUsage")!)
                    masterabesuffixes.append(Suffix(desc: allsuffixset.string(forColumn: "Desc")!, amount: master.count, used: 0, master: allsuffixset.string(forColumn: "MasterUsage")!, essence: "", values: master))
                    
                }
                
            }
            connectiontoFMDB.close()
            

        }
        let affixes = Affixes(craftprefix: craftableprefixes, masterprefix: masterabeprefixes, essenceprefix: essenceableprefixes, craftsuffix: craftablesuffixes, mastersuffix: masterabesuffixes, essencesuffix: essenceablesuffixes)
        return affixes
    }
    
    func GetWeaponCrit(name : String, type : String)->Double{
        var crit : Double = 5.0
        if (type == "Thrusting"){
            switch name{
            case "Antique Rapier":
                crit = 6.5
            case "Primeval Rapier":
                crit = 6.5
            case "Vaal Rapier":
                crit = 6.5
            case "Battered Foil":
                crit = 6.0
            case "Burnished Foil":
                crit = 6.0
            case "Tempered Foil":
                crit = 6.0
            case "Thorn Rapier":
                crit = 5.7
            case "Apex Rapier":
                crit = 5.7
            case "Harpy Rapier":
                crit = 5.7
            default:
                crit = 5.5
            }
        }
        if (type == "Sceptre"){
            switch name{
            case "Shadow Sceptre":
                crit = 6.2
            case "Abyssal Sceptre":
                crit = 6.2
            case "Void Sceptre":
                crit = 6.2
            case "Crystal Sceptre":
                crit = 6.5
            case "Opal Sceptre":
                crit = 6.5
            case "Quartz Sceptre":
                crit = 6.5
            default:
                crit = 6.0
            }
        }
        if (type == "Sword"){
            switch name{
            case "Curved Blade":
                crit = 6.0
            case "Lithe Blade":
                crit = 6.0
            case "Exquisite Blade":
                crit = 6.0
            default:
                crit = 5.0
            }
        }
        if (type == "Axe"){
            switch name{
            case "Dagger Axe":
                crit = 7.5
            case "Talon Axe":
                crit = 7.5
            case "Fleshripper":
                crit = 7.5
            default:
                crit = 5.0
            }
        }
        if (type == "Dagger"){
            switch name{
            case "Glass Shank":
                crit = 6.0
            case "Carving Knife":
                crit = 6.3
            case "Boot Knife":
                crit = 6.3
            case "Flaying Knife":
                crit = 6.0
            case "Prong Dagger":
                crit = 6.2
            case "Butcher Knife":
                crit = 6.3
            case "Poignard":
                crit = 6.1
            case "Boot Blade":
                crit = 6.3
            case "Royal Skean":
                crit = 6.3
            case "Gutting Knife":
                crit = 6.0
            case "Ambusher":
                crit = 6.1
            case "Ezomyte Dagger":
                crit = 6.3
            case "Imperial Skean":
                crit = 6.3
            case "Sai":
                crit = 6.2
            default:
                crit = 6.5
            }
        }
        if (type == "Wand"){
            switch name{
            case "Sage Wand":
                crit = 8.0
            case "Omen Wand":
                crit = 8.0
            case "Prophecy Wand":
                crit = 8.0
            default:
                crit = 7.0
            }
        }
        if (type == "Dagger"){
            crit = 6.3
        }
        return crit
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MainViewController {
            let cellnum = self.TableView.indexPathsForSelectedRows![0][1]
            if (basearmourdata.count != 0){
                destination.armour = basearmourdata[cellnum]
            }
            if (baseweapondata.count != 0){
                destination.affixes = GetAffixes(dbname: options[selected].SlotName[selectedslot].TypeName[selectedtype].TypeDBName)
                baseweapondata[cellnum].crit = GetWeaponCrit(name: baseweapondata[cellnum].Name, type: baseweapondata[cellnum].type)
                destination.weapon = baseweapondata[cellnum]
            }
            if (baseaccessorydata.count != 0){
                destination.accessory = baseaccessorydata[cellnum]
            }
        }
    }
    

}
*/

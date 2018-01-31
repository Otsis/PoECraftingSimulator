//
//  BaseViewController.swift
//  PoeCraftingSimulator
//
//  Created by Markus Hyvärinen on 17/01/2018.
//  Copyright © 2018 Markus. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIViewControllerTransitioningDelegate {
    
    @IBOutlet weak var ItemType: UISegmentedControl!
    @IBOutlet weak var ItemWeapon: UISegmentedControl!
    @IBOutlet weak var ItemArmour: UISegmentedControl!
    @IBOutlet weak var ItemJewelry: UISegmentedControl!
    @IBOutlet weak var ItemWeapon1H: UISegmentedControl!
    @IBOutlet weak var ItemWeapon2H: UISegmentedControl!
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var ItemArmourType: UISegmentedControl!
    @IBOutlet weak var ItemArmourChest: UISegmentedControl!
    

    var level1 : Int = -1
    var level2 : Int = -1
    var level3 : Int = -1
    let dbpath = getpath()
    var baseweapondata : [BaseWeapon] = []
    var baseaccessorydata : [BaseAccessory] = []
    var basearmourdata : [BaseArmour] = []
    let connectiontoFMDB: FMDatabase = FMDatabase(path: getpath())

    
    
    @IBAction func ItemWeapon2HSelect(_ sender: UISegmentedControl) {
        level3 = ItemWeapon2H.selectedSegmentIndex
        LoadTableData()
    }
    
    @IBAction func ItemWeapon1HSelect(_ sender: UISegmentedControl) {
        level3 = ItemWeapon1H.selectedSegmentIndex
        LoadTableData()
    }
    
    @IBAction func ItemArmorChestSelect(_ sender: UISegmentedControl) {
        level3 = ItemArmourChest.selectedSegmentIndex
        LoadTableData()
    }
    
    @IBAction func ItemArmourTypeSelect(_ sender: UISegmentedControl) {
        level3 = ItemArmourType.selectedSegmentIndex
        LoadTableData()
    }
    
    @IBAction func ItemArmourSelect(_ sender: UISegmentedControl) {
        CheckDisplayLevel2()
    }
    
    @IBAction func ItemJewelrySelect(_ sender: UISegmentedControl) {
        CheckDisplayLevel2()
    }
    
    
    @IBAction func ItemWeaponSelect(_ sender: UISegmentedControl) {
        CheckDisplayLevel2()
    }
    
    @IBAction func ItemTypeSelect(_ sender: UISegmentedControl) {
        level1 = ItemType.selectedSegmentIndex
        CheckDisplayLevel1()
    }
    

    
    func CheckDisplayLevel1(){
        HideLevel2()
        HideLevel3()
        if (level1 == 0){
            ItemWeapon.isHidden = false
        }
        if (level1 == 1){
            ItemArmour.isHidden = false
        }
        if (level1 == 2){
            ItemJewelry.isHidden = false
        }
    }
    
    func CheckDisplayLevel2(){
        HideLevel3()
        if (level1 == 0){
            level2 = ItemWeapon.selectedSegmentIndex
            if (level2 == 0){
                ItemWeapon1H.isHidden = false
            }
            if (level2 == 1){
                ItemWeapon2H.isHidden = false
            }
        }
        if (level1 == 1){
            level2 = ItemArmour.selectedSegmentIndex
            if (level2 == 0){
                ItemArmourChest.isHidden = false
            }
            else{
                ItemArmourType.isHidden = false
            }
        }
        if (level1 == 2){
            level2 = ItemJewelry.selectedSegmentIndex
            LoadTableData()
        }
    }

    func HideLevel2(){
        ItemWeapon.isHidden = true
        ItemArmour.isHidden = true
        ItemJewelry.isHidden = true
        TableView.isHidden = true
        
        ItemWeapon.selectedSegmentIndex = UISegmentedControlNoSegment
        ItemArmour.selectedSegmentIndex = UISegmentedControlNoSegment
        ItemJewelry.selectedSegmentIndex = UISegmentedControlNoSegment
        
        level2 = -1
        level3 = -1
    }
    
    func HideLevel3(){
        ItemArmourType.isHidden = true
        ItemArmourChest.isHidden = true
        ItemWeapon1H.isHidden = true
        ItemWeapon2H.isHidden = true
        TableView.isHidden = true
        
        ItemArmourType.selectedSegmentIndex = UISegmentedControlNoSegment
        ItemArmourChest.selectedSegmentIndex = UISegmentedControlNoSegment
        ItemWeapon1H.selectedSegmentIndex = UISegmentedControlNoSegment
        ItemWeapon2H.selectedSegmentIndex = UISegmentedControlNoSegment
        
        level3 = -1
    }
    

    
    func LoadTableData(){
        TableView.isHidden = false
        if FileManager.default.fileExists(atPath: dbpath){
            if (connectiontoFMDB.open()){
                if (level1 == 0){
                    let slot : String = GetWeaponDBnameString(index: level3, twohanded: level2)
                    let sqlstatement : String = WeaponQuery2(itemtype: slot)
                    let itemtype = GetItemSlotString(level1: level1, level2: level2, level3: level3)
                    let resultset : FMResultSet = connectiontoFMDB.executeQuery(sqlstatement, withArgumentsIn: [])!
                    baseweapondata = CreateBaseWeapon(resultset: resultset, slot: slot, itemtype: itemtype)
                    
                    
                    if (itemtype == "One Handed Mace"){
                        let sqlstatement : String = WeaponQuery2(itemtype: "Sceptre")
                        let resultset : FMResultSet = connectiontoFMDB.executeQuery(sqlstatement, withArgumentsIn: [])!
                        baseweapondata += CreateBaseWeapon(resultset: resultset, slot: slot, itemtype: "Sceptre")
                    }
                    if (itemtype == "One Handed Sword"){
                        let sqlstatement : String = WeaponQuery2(itemtype: "ThrustingOneHandSword")
                        let resultset : FMResultSet = connectiontoFMDB.executeQuery(sqlstatement, withArgumentsIn: [])!
                        baseweapondata += CreateBaseWeapon(resultset: resultset, slot: slot, itemtype: itemtype)
                    }
                }
                if (level1 == 1){
                    let sqlstatement : String = ArmorQuery2(index: level3, itemtype: GetArmorDBnameString(index: level2))
                    let resultset : FMResultSet = connectiontoFMDB.executeQuery(sqlstatement, withArgumentsIn: [])!
                    basearmourdata = CreateBaseArmour(resultset: resultset)
                }
                if (level1 == 2){
                    let sqlstatement : String = JewelryQuery2(index: level2)
                    let resultset : FMResultSet = connectiontoFMDB.executeQuery(sqlstatement, withArgumentsIn: [])!
                    baseaccessorydata = CreateBaseAccessory(resultset: resultset)
                }
            }
            connectiontoFMDB.close()
        }
        TableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (level1 == 0){
            return baseweapondata.count
        }
        if (level1 == 1){
            return basearmourdata.count
        }
        if (level1 == 2){
            return baseaccessorydata.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BaseItems", for: indexPath) as! BaseTableViewCell

        if (level1 == 0 && baseweapondata.count != 0){
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
        
        if (level1 == 1 && basearmourdata.count != 0){
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
        
        if (level1 == 2 && baseaccessorydata.count != 0){
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
    
    func SetupDefaultArmorTypeMenu(){
        //AR,Eva,ES,AR/Eva,AR/ES,Eva/ES,AR/Eva/ES
        ItemArmourChest.subviews[6].backgroundColor = UIColor.red
        ItemArmourChest.subviews[5].backgroundColor = UIColor.green
        ItemArmourChest.subviews[4].backgroundColor = UIColor.blue
        ItemArmourChest.subviews[3].backgroundColor = UIColor.yellow
        ItemArmourChest.subviews[2].backgroundColor = UIColor.purple
        ItemArmourChest.subviews[1].backgroundColor = UIColor.cyan
        ItemArmourChest.subviews[0].backgroundColor = UIColor.white

        ItemArmourType.subviews[5].backgroundColor = UIColor.red
        ItemArmourType.subviews[4].backgroundColor = UIColor.green
        ItemArmourType.subviews[3].backgroundColor = UIColor.blue
        ItemArmourType.subviews[2].backgroundColor = UIColor.yellow
        ItemArmourType.subviews[1].backgroundColor = UIColor.purple
        ItemArmourType.subviews[0].backgroundColor = UIColor.cyan
    }

    override func viewDidLoad() {
        let dbpath = getpath()
        print(dbpath)
        SetupDefaultArmorTypeMenu()
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is MainViewController {
            let transition = CATransition()
            transition.duration = 1.0
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromLeft
            transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
            view.window!.layer.add(transition, forKey: kCATransition)

            if (basearmourdata.count != 0){
                let cellnum = self.TableView.indexPathsForSelectedRows![0][1]
                SendToAppDelegate(currentitem: nil, affixes: nil, weapon: nil, armour: basearmourdata[cellnum], accessory: nil)

                //destination.armour = basearmourdata[cellnum]
            }
            if (baseweapondata.count != 0){
                let cellnum = self.TableView.indexPathsForSelectedRows![0][1]
                SendToAppDelegate(currentitem: nil, affixes: GetAffixes(dbname: GetWeaponDBnameString(index: level3, twohanded: level2)), weapon: baseweapondata[cellnum], armour: nil, accessory: nil)
                
                //destination.affixes = GetAffixes(dbname: GetWeaponDBnameString(index: level3, twohanded: level2))
                //baseweapondata[cellnum].crit = GetWeaponCrit(name: baseweapondata[cellnum].Name, type: baseweapondata[cellnum].type)
                //destination.weapon = baseweapondata[cellnum]
            }
            if (baseaccessorydata.count != 0){
                let cellnum = self.TableView.indexPathsForSelectedRows![0][1]
                SendToAppDelegate(currentitem: nil, affixes: nil, weapon: nil, armour: nil, accessory: baseaccessorydata[cellnum])

                //destination.accessory = baseaccessorydata[cellnum]
            }
        }
    }

}

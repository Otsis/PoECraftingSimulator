//
//  OptionsViewController.swift
//  PoeCraftingSimulator
//
//  Created by Markus Hyvärinen on 20/12/2017.
//  Copyright © 2017 Markus. All rights reserved.
//

import UIKit



class OptionsViewController: UIViewController {

    
    var selected : Int = 0
    var webcontent : String?
    
    @IBOutlet weak var SaveSlot1Text: UIButton!
    @IBOutlet weak var SaveSlot2Text: UIButton!
    @IBOutlet weak var SaveSlot3Text: UIButton!
    @IBOutlet weak var SaveSlot4Text: UIButton!
    @IBOutlet weak var LoadSlot1Text: UIButton!
    @IBOutlet weak var LoadSlot2Text: UIButton!
    @IBOutlet weak var LoadSlot3Text: UIButton!
    @IBOutlet weak var LoadSlot4Text: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CheckifSaveFilesExist()

    }
    
    func CheckifSaveFilesExist(){
        if (Storage.fileExists("Slot1.json", in: .documents) == false){
            print("1")
            LoadSlot1Text.isEnabled = false
            LoadSlot1Text.setTitle("Free", for: .normal)
        }
        if (Storage.fileExists("Slot2.json", in: .documents) == false){
            print("2")
            LoadSlot2Text.isEnabled = false
            LoadSlot2Text.setTitle("Free", for: .normal)
        }
        if (Storage.fileExists("Slot3.json", in: .documents) == false){
            print("3")
            LoadSlot3Text.isEnabled = false
            LoadSlot3Text.setTitle("Free", for: .normal)
        }
        if (Storage.fileExists("Slot4.json", in: .documents) == false){
            print("4")
            LoadSlot4Text.isEnabled = false
            LoadSlot4Text.setTitle("Free", for: .normal)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SaveSlot1(_ sender: UIButton) {
        let savedata : ItemSave = ReceiveFromAppDelegate()!
        SaveItemToFile(filename: "Slot1", content: savedata)
        SaveSlot1Text.setTitle("Saved", for: .normal)
        LoadSlot1Text.setTitle("Slot1", for: .normal)
    }
    
    @IBAction func SaveSlot2(_ sender: UIButton) {
        let savedata : ItemSave = ReceiveFromAppDelegate()!
        SaveItemToFile(filename: "Slot2", content: savedata)
        SaveSlot2Text.setTitle("Saved", for: .normal)
        LoadSlot2Text.setTitle("Slot2", for: .normal)
    }
    
    @IBAction func SaveSlot3(_ sender: UIButton) {
        let savedata : ItemSave = ReceiveFromAppDelegate()!
        SaveItemToFile(filename: "Slot3", content: savedata)
        SaveSlot3Text.setTitle("Saved", for: .normal)
        LoadSlot3Text.setTitle("Slot3", for: .normal)
    }
    
    @IBAction func SaveSlot4(_ sender: UIButton) {
        let savedata : ItemSave = ReceiveFromAppDelegate()!
        SaveItemToFile(filename: "Slot4", content: savedata)
        SaveSlot4Text.setTitle("Saved", for: .normal)
        LoadSlot4Text.setTitle("Slot4", for: .normal)
    }
    
    @IBAction func LoadSlot1(_ sender: UIButton) {
        let loaddata : ItemSave = LoadItemFromFile(filename: "Slot1")
        SendToAppDelegate(currentitem: loaddata.currentitem, affixes: loaddata.affixes, weapon: loaddata.weapon, armour: loaddata.armour, accessory: loaddata.accessory)
    }
    
    @IBAction func LoadSlot2(_ sender: UIButton) {
        let loaddata : ItemSave = LoadItemFromFile(filename: "Slot2")
        SendToAppDelegate(currentitem: loaddata.currentitem, affixes: loaddata.affixes, weapon: loaddata.weapon, armour: loaddata.armour, accessory: loaddata.accessory)
    }
    
    @IBAction func LoadSlot3(_ sender: UIButton) {
        let loaddata : ItemSave = LoadItemFromFile(filename: "Slot3")
        SendToAppDelegate(currentitem: loaddata.currentitem, affixes: loaddata.affixes, weapon: loaddata.weapon, armour: loaddata.armour, accessory: loaddata.accessory)
    }
    
    @IBAction func LoadSlot4(_ sender: UIButton) {
        let loaddata : ItemSave = LoadItemFromFile(filename: "Slot4")
        SendToAppDelegate(currentitem: loaddata.currentitem, affixes: loaddata.affixes, weapon: loaddata.weapon, armour: loaddata.armour, accessory: loaddata.accessory)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is MainViewController {
            let transition = CATransition()
            transition.duration = 1.0
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
            view.window!.layer.add(transition, forKey: kCATransition)
        }
    }
}

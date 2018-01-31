//
//  SaveLoadManager.swift
//  PoeCraftingSimulator
//
//

import Foundation

func LoadItemFromFile(filename : String)->ItemSave{
    let content : ItemSave = Storage.retrieve("\(filename).json", from: .documents, as: ItemSave.self)
    return content
}

func SaveItemToFile(filename : String, content : ItemSave){
    print("saving")
    Storage.store(content, to: .documents, as: "\(filename).json")
}


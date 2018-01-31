//
//  DBUsage.swift
//  PoeCraftingSimulator
//
//  Created by Markus Hyvärinen on 20/12/2017.
//  Copyright © 2017 Markus. All rights reserved.
//


import Foundation

func AffixDB(dbname : String, Affixes : [AffixValsToAdd])->([Int],[Int],[Int]){
    //print(Affixes)
    var general : [Int] = []
    var essence : [Int] = []
    var master : [Int] = []
    let dbpath = getpath()
    var connectiontoFMDB: FMDatabase = FMDatabase()
    connectiontoFMDB = FMDatabase(path: dbpath)
    if (connectiontoFMDB.open()){
        connectiontoFMDB.executeStatements(CreateAffixDB(dbname: dbname, vals: Affixes[0].vals.count))
        for i in 0...Affixes.count-1{
            var statement = "Insert into \(dbname)("
            var into : String = "iLvl, name"
            var values : String = ") values('\(Affixes[i].ilvl)', '\(Affixes[i].name)'"
            var not : String = "select \(dbname + "ID") from \(dbname) where iLvl='\(Affixes[i].ilvl)' and name='\(Affixes[i].name)'"
            if (Affixes[0].vals.count != 0){
                for a in 0...Affixes[0].vals.count-1{
                    into += ", val\(a+1)"
                    values += ", '\(Affixes[i].vals[a])'"
                    not += "and val\(a+1)='\(Affixes[i].vals[a])'"
                }
            }
            statement += into
            statement += values
            statement += ");"
            not += ";"
            let resultset : FMResultSet = connectiontoFMDB.executeQuery(not, withArgumentsIn: [])!
            if resultset.next() == true{
                if (Affixes[i].master == 1){
                    master.append(Int(resultset.string(forColumn: "\(dbname)ID")!)!)
                }
                else if (Affixes[i].essence == 1){
                    essence.append(Int(resultset.string(forColumn: "\(dbname)ID")!)!)
                }
                else{
                    general.append(Int(resultset.string(forColumn: "\(dbname)ID")!)!)
                }
            }
            else{
                connectiontoFMDB.executeStatements(statement)
                if (Affixes[i].master == 1){
                    master.append(Int(connectiontoFMDB.lastInsertRowId))
                }
                else if (Affixes[i].essence == 1){
                    essence.append(Int(connectiontoFMDB.lastInsertRowId))
                }
                else{
                    general.append(Int(connectiontoFMDB.lastInsertRowId))
                }
            }
        }
    }
    connectiontoFMDB.close()
    NSLog(connectiontoFMDB.debugDescription)
    return (general, essence, master)
}
/*
func InsertToAffixConnectionDB(connections : [AffixConnections], name : String){
    let dbpath = getpath()
    var connectiontoFMDB: FMDatabase = FMDatabase()
    connectiontoFMDB = FMDatabase(path: dbpath)
    if (connectiontoFMDB.open()){
        connectiontoFMDB.executeStatements(CreateAffixConnectionDB(dbname: name))
        for i in 0...connections.count-1{
            
            let statement = "Insert into \(name)(Desc, DBname, GeneralUsage, EssenceName, EssenceUsage, MasterName, MasterUsage) values('\(connections[i].affixname)', '\(connections[i].dbname)', '\(connections[i].generalusage)', '\(connections[i].essencename)', '\(connections[i].essenceusage)', '\(connections[i].mastername)', '\(connections[i].masterusage)');"
            connectiontoFMDB.executeStatements(statement)
        }
    }
    connectiontoFMDB.close()
    NSLog(connectiontoFMDB.debugDescription)
}
*/
func CreateAffixConnectionDB(dbname : String)->String{
    let statement = "Create table if not exists \(dbname)(\(dbname + "ID") integer primary key autoincrement, Desc text not null, DBname text not null, GeneralUsage text not null, EssenceName text, EssenceUsage text, MasterName text, MasterUsage text);"
    return statement
}

func CreateAffixDB(dbname : String, vals : Int)->String{
    var statement = "Create table if not exists \(dbname)(\(dbname + "ID") integer primary key autoincrement, iLvl integer not null, name text"
    if (vals != 0){
        for i in 1...vals{
            statement += ", val\(i) integer"
        }
    }
    statement += ");"
    return statement
}


func runstatements(sqlstatement : String){
    let dbpath = getpath()
    var connectiontoFMDB: FMDatabase = FMDatabase()
    if FileManager.default.fileExists(atPath: dbpath){
        connectiontoFMDB = FMDatabase(path: dbpath)
        if (connectiontoFMDB.open()){
            connectiontoFMDB.executeStatements(sqlstatement)
        }
    }
    connectiontoFMDB.close()
    NSLog(connectiontoFMDB.debugDescription)
}

func basedatatodb(base: String, content: [[String]]){
    print(base)
    
    let dbpath = getpath()
    var connectiontoFMDB: FMDatabase = FMDatabase()
    connectiontoFMDB = FMDatabase(path: dbpath)
    if (connectiontoFMDB.open()){
        switch base {
        case "Bow", "Claw", "One Hand Axe", "One Hand Mace", "One Hand Sword", "Sceptre", "Staff", "Thrusting One Hand Sword", "Two Hand Axe", "Two Hand Mace", "Two Hand Sword", "Wand", "Dagger":
            let dbname = base.replacingOccurrences(of: " ", with: "")
            connectiontoFMDB.executeStatements(createdbweapon(dbname: dbname))
            connectiontoFMDB.executeStatements(createddbtype())
            connectiontoFMDB.executeStatements(addtocreateddbtype(content: base))
            for i in 0...(content.count - 1){
                let statement = "Insert into \(dbname)(Url, Name, Level, DamageMin, DamageMax, APS, DPS, ReqStr, ReqDex, ReqInt, Implicit1, Implicit1val, Implicit2, Implicit2val) values('\(content[i][0])', '\(content[i][1])', '\(content[i][2])', '\(content[i][3])', '\(content[i][4])', '\(content[i][5])', '\(content[i][6])', '\(content[i][7])', '\(content[i][8])', '\(content[i][9])', '\(content[i][10])', '\(content[i][11])', '\(content[i][12])', '\(content[i][13])');"
                connectiontoFMDB.executeStatements(statement)
            }
        case "Body Armour", "Boots", "Gloves", "Helmet", "Shield":
            let dbname = base.replacingOccurrences(of: " ", with: "")
            connectiontoFMDB.executeStatements(createdbarmor(dbname: dbname))
            connectiontoFMDB.executeStatements(createddbtype())
            connectiontoFMDB.executeStatements(addtocreateddbtype(content: base))
            for i in 0...(content.count - 1){
                let statement = "Insert into \(dbname)(Url, Name, Level, Armour, EvasionRating, EnergyShield , ReqStr, ReqDex, ReqInt, Implicit1, Implicit1val, Implicit2, Implicit2val) values('\(content[i][0])', '\(content[i][1])', '\(content[i][2])', '\(content[i][3])', '\(content[i][4])', '\(content[i][5])', '\(content[i][6])', '\(content[i][7])', '\(content[i][8])', '\(content[i][9])', '\(content[i][10])', '\(content[i][11])', '\(content[i][12])');"
                connectiontoFMDB.executeStatements(statement)
            }
        case "Amulet", "Belt", "Ring":
            let dbname = base.replacingOccurrences(of: " ", with: "")
            connectiontoFMDB.executeStatements(createdbjewelry(dbname: dbname))
            connectiontoFMDB.executeStatements(createddbtype())
            connectiontoFMDB.executeStatements(addtocreateddbtype(content: base))
            for i in 0...(content.count - 1){
                let statement = "Insert into \(dbname)(Url, Name, Level, Implicit1, Implicit2, Implicit1valmin, Implicit1valmax, Implicit2valmin, Implicit2valmax) values('\(content[i][0])', '\(content[i][1])', '\(content[i][2])', '\(content[i][3])', '\(content[i][4])', '\(content[i][5])', '\(content[i][6])', '\(content[i][7])', '\(content[i][8])');"
                connectiontoFMDB.executeStatements(statement)
            }
        default:
            print("---------UNID BASE---------")
        }
    }
    connectiontoFMDB.close()
    NSLog(connectiontoFMDB.debugDescription)
}

func createddbtype()->String{
    let statement = "Create table if not exists Type(typeID integer primary key autoincrement, DBname text not null, TypeDesc text not null);"
    return statement
}

func addtocreateddbtype(content: String)->String{
    let dbname = content.replacingOccurrences(of: " ", with: "")
    let statement = "Insert into Type(DBname, TypeDesc) values('\(dbname)', '\(content)');"
    return statement
}

func createdbjewelry(dbname : String)->String{
    let statement = "Create table if not exists \(dbname)(\(dbname + "ID") integer primary key autoincrement, Url text not null, Name text not null, Level integer not null, Implicit1 text, Implicit2 text, Implicit1valmin integer, Implicit1valmax integer, Implicit2valmin integer, Implicit2valmax integer);"
    return statement
}

func createdbarmor(dbname : String)->String{
    let statement = "Create table if not exists \(dbname)(\(dbname + "ID") integer primary key autoincrement, Url text not null, Name text not null, Level integer not null, Armour integer not null, EvasionRating integer not null, EnergyShield integer not null, ReqStr integer not null, ReqDex integer not null, ReqInt integer not null, Implicit1 text, Implicit1val text, Implicit2 text, Implicit2val text);"
    return statement
}

func createdbweapon(dbname : String)->String{
    let statement = "Create table if not exists \(dbname)(\(dbname + "ID") integer primary key autoincrement, Url text not null, Name text not null, Level integer not null, DamageMin integer not null, DamageMax integer not null, APS decimal(1.2) not null, DPS decimal(3.1) not null, ReqStr integer not null, ReqDex integer not null, ReqInt integer not null, Implicit1 text, Implicit1val text, Implicit2 text, Implicit2val text);"
    return statement
}

func runmultiplestatements(base: String, content : [[String]]){
    for i in 0...(content.count - 1){
        let statement = "Insert into \(base)(Url, Name, Level, DamageMin, DamageMax, APS, DPS, ReqStr, ReqDex, ReqInt, Implicit1, Implicit1val, Implicit2, Implicit2val) values('\(content[i][0])', '\(content[i][1])', '\(content[i][2])', '\(content[i][3])', '\(content[i][4])', '\(content[i][5])', '\(content[i][6])', '\(content[i][7])', '\(content[i][8])', '\(content[i][9])', '\(content[i][10])', '\(content[i][11])', '\(content[i][12])', '\(content[i][13])');"
        runstatements(sqlstatement: statement)
    }
}


func DBinit(statement : String){
    let dbpath = getpath()
    var connectiontoFMDB: FMDatabase = FMDatabase()
    print(dbpath)
    if !FileManager.default.fileExists(atPath: dbpath){
        connectiontoFMDB = FMDatabase(path: dbpath)
        if (connectiontoFMDB.open()){
            print("No DB Detected")
            print("Creating DB")
            runstatements(sqlstatement: statement)
            //createDB()
        }
        connectiontoFMDB.close()
    }
}

func getpath()->String{
    let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("PoE.db").path
    return path!
}

func createDB(){
    //let prefixes = "Create table Prefixes(prefixID integer primary key autoincrement not null, prefixname text not null, prefixdesc text not null, prefixtier integer not null, ilvl integer not null, dmgtype text not null, dmgmin integer not null, dmgmax integer not null, percent decimal(3,2), accuracy integer)"
    let Bow = "Create table Bow(BowID integer primary key autoincrement, Url text not null, Name text not null, Level integer not null, DamageMin integer not null, DamageMax integer not null, APS decimal(1.2) not null, DPS decimal(3.1) not null, ReqStr integer not null, ReqDex integer not null, ReqInt integer not null, Implicit1 text, Implicit1val text, Implicit2 text, Implicit2val text);"
    let Claw = "Create table Claw(ClawID integer primary key autoincrement, Url text not null, Name text not null, Level integer not null, DamageMin integer not null, DamageMax integer not null, APS decimal(1.2) not null, DPS decimal(3.1) not null, ReqStr integer not null, ReqDex integer not null, ReqInt integer not null, Implicit1 text, Implicit1val text, Implicit2 text, Implicit2val text);"
    runstatements(sqlstatement: Bow)
    runstatements(sqlstatement: Claw)
}


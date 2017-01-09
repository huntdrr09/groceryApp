//
//  DataManager.swift
//  grocreryApp
//
//  Created by Dante R Hunt on 11/26/16.
//  Copyright © 2016 Dante R Hunt. All rights reserved.
//

import CoreData

enum DataError: Error {
    case BadManagedObjectContext(String)
    case BadEntity(String)
}

class DataManager : Loading, Creation, Provider{

    static var shared: DataManager = DataManager()
    
    var managedObjectContext: NSManagedObjectContext?
    let format = DateFormatter()
    var listDatas: [ItemList]
    var listDataCount: Int {
        return listDatas.count
    }
    
    var itemDatas: [ItemDetails]
    var itemDataCount: Int {
        return itemDatas.count
    }
    
    var selectedListIndex: Int
    var selectedItemIndex: Int

    private init() {
        itemDatas = []
        listDatas = []
        selectedListIndex = -1
        selectedItemIndex = -1
    }
    
    func loadListData() {
        listDatas = fetch()
    }
    func loadItemData() {
        let selectedList = listDatas.value(at: selectedListIndex)
        itemDatas = selectedList?.items?.flatMap{ item in
            return item as? ItemDetails
            } ??  []
    }
    
    func getListData(from indexPath: IndexPath) -> (lName: String?, lDate: String?)?{
        guard let lItem = listDatas.value(at: indexPath.row) else{
            return nil
        }
        var dates = ""
        format.dateFormat = "MM/dd/YYYY"
        if ((lItem.listDate) != nil){
            dates = format.string(from: lItem.listDate as! Date)
        }
        return (lItem.listName, dates)
    }
    
    func getItemData(from indexPath: IndexPath) -> (iName: String?, iQunaity: Int)?{
        guard let item = itemDatas.value(at: indexPath.row) else{
            return nil
        }
        return (item.itemName, Int(item.itemQuanity))
    }
    
    
    func createItem(itemData: (itemName: String?, itemQuanity: Int)) throws {
        guard let ctx = managedObjectContext else {
            throw DataError.BadManagedObjectContext("Managed Object is NIL")
        }
        guard let entity = NSEntityDescription.entity(forEntityName: "ItemDetails", in: ctx) else{
            throw DataError.BadEntity("Entity Description was Bad")
        }
        
        let obj = ItemDetails(entity: entity, insertInto: ctx)
        obj.itemName = itemData.itemName
        obj.itemQuanity = Int16(itemData.itemQuanity)
        obj.list = listDatas.value(at: selectedListIndex)
        
        do {
            try save()
        }
        catch {
            print("Error creating item data")
            print(error)
        }
    }
    
    func createList(listNamed name : String?) throws {
        guard let ctx = managedObjectContext else {
            throw DataError.BadManagedObjectContext("Managed Object is NIL")
        }
        guard let entity = NSEntityDescription.entity(forEntityName: "ItemList", in: ctx) else{
            throw DataError.BadEntity("Entity Description was Bad")
        }
        let date = NSDate()
        let obj = ItemList(entity: entity, insertInto: ctx)
        obj.listName = name
        obj.listDate = date
        
        try? save()
        
    }

}

extension DataManager {
    func fetch<T: NSManagedObject>() -> [T] {
        var result: [T]? = nil
        managedObjectContext?.performAndWait {[weak self] in
            do {
                result = try self?.executeFetchRequest()
            }
            catch {
                print(error)
            }
        }
        return result ?? []
    }
    private func executeFetchRequest<T: NSManagedObject>() throws -> [T]? {
        let request = T.fetchRequest()
        return try request.execute() as? [T]
    }
    func save() throws{
        try managedObjectContext?.save()
        
    }
}
protocol Creation {
    func createList(listNamed name : String?) throws
    func createItem(itemData: (itemName: String?, itemQuanity: Int)) throws
}

protocol Provider {
    func getListData(from indexPath: IndexPath) -> (lName: String?, lDate: String?)?
    func getItemData(from indexPath: IndexPath) -> (iName: String?, iQunaity: Int)?
}

protocol Loading {
    func loadListData()
    func loadItemData()
}


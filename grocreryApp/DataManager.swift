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

class DataManager {
    static var shared: DataManager = DataManager()
    
    var managedObjectContext: NSManagedObjectContext?
    
    var listDatas: [GroceryListData]
    var listDataCount: Int {
        return listDatas.count
    }
    
    var itemDatas: [GroceryItemsData]
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
}

extension DataManager {
   
    func loadListData() {
        listDatas = fetch()
    }
    func create(listNamed name : String?) throws {
        guard let ctx = managedObjectContext else {
            throw DataError.BadManagedObjectContext("Managed Object is NIL")
        }
        guard let entity = NSEntityDescription.entity(forEntityName: "ItemList", in: ctx) else{
            throw DataError.BadEntity("Entity Description was Bad")
        }
        let obj = GroceryListData(entity: entity, insertInto: ctx)
        obj.itemName = name
        obj.itemNumber = Int16(itemDataCount)
        
        try? save()
        
    }
    
    func getListData(from indexPath: IndexPath) -> (lName: String?, lNumber: Int)?{
        guard let lItem = listDatas.value(at: indexPath.row) else{
            return nil
        }
        return (lItem.itemName, Int(lItem.itemNumber))        
    }
}
extension DataManager {
    func loadItemData() {
        let selectedList = listDatas.value(at: selectedListIndex)
        itemDatas = selectedList?.items?.flatMap{ item in
            return item as? GroceryItemsData
        } ??  []
    }
    func create(itemData: (itemName: String?, itemQuanity: Int)) throws {
        guard let ctx = managedObjectContext else {
            throw DataError.BadManagedObjectContext("Managed Object is NIL")
        }
        guard let entity = NSEntityDescription.entity(forEntityName: "ItemLDetail", in: ctx) else{
            throw DataError.BadEntity("Entity Description was Bad")
        }
        
        let obj = GroceryItemsData(entity: entity, insertInto: ctx)
        obj.detailName = itemData.itemName
        obj.detailQuanity = Int16(itemData.itemQuanity)
        obj.list = listDatas.value(at: selectedListIndex)
        
        try? save()
        
    }
    func getItemData(from indexPath: IndexPath) -> (iName: String?, iQunaity: Int)?{
        guard let item = itemDatas.value(at: indexPath.row) else{
            return nil
        }
        return (item.detailName, Int(item.detailQuanity))
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

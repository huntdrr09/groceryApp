//
//  Data+CoreDataProperties.swift
//  grocreryApp
//
//  Created by Dante R Hunt on 11/26/16.
//  Copyright © 2016 Dante R Hunt. All rights reserved.
//

import Foundation
import CoreData

extension GroceryListData {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<GroceryListData> {
        return NSFetchRequest<GroceryListData>(entityName: "ItemList");
    }
    @NSManaged public var itemName: String?
    @NSManaged public var itemNumber: Int16
    @NSManaged public var items: NSSet?
}

extension GroceryListData{
    
    @objc(addItemObject:)
    @NSManaged public func addToItems(_ value: ItemDetails)
    
    @objc(removeItemObject:)
    @NSManaged public func removeFromItems(_ value: ItemDetails)
    
    @objc(addItem:)
    @NSManaged public func addToItems(_ value: NSSet)
    
    @objc(removeItem:)
    @NSManaged public func removeFromItems(_ value: NSSet)
    
}

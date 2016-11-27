//
//  Data+CoreDataProperties.swift
//  grocreryApp
//
//  Created by Dante R Hunt on 11/26/16.
//  Copyright © 2016 Dante R Hunt. All rights reserved.
//

import Foundation
import CoreData

extension GroceryItemsData {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<GroceryItemsData> {
        return NSFetchRequest<GroceryItemsData>(entityName: "ItemDetails");
    }
    @NSManaged public var detailName: String?
    @NSManaged public var detailQuanity: Int16
    @NSManaged public var list: GroceryListData?
    
}

extension GroceryListData{
    
    @objc(addListObject:)
    @NSManaged public func addTolist(_ value: ItemDetails)
    
    @objc(removeItemObject:)
    @NSManaged public func removeFromList(_ value: ItemDetails)
    
    @objc(addItem:)
    @NSManaged public func addToList(_ value: NSSet)
    
    @objc(removeItem:)
    @NSManaged public func removeFromList(_ value: NSSet)
    
}

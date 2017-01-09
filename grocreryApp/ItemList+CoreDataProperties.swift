//
//  ItemList+CoreDataProperties.swift
//  grocreryApp
//
//  Created by Dante R Hunt on 12/11/16.
//  Copyright © 2016 Dante R Hunt. All rights reserved.
//

import Foundation
import CoreData


extension ItemList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemList> {
        return NSFetchRequest<ItemList>(entityName: "ItemList");
    }

    @NSManaged public var listDate: NSDate?
    @NSManaged public var listName: String?
    @NSManaged public var items: NSSet?

}

// MARK: Generated accessors for items
extension ItemList {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: ItemDetails)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: ItemDetails)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}

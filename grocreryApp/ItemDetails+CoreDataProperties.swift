//
//  ItemDetails+CoreDataProperties.swift
//  grocreryApp
//
//  Created by Dante R Hunt on 12/11/16.
//  Copyright © 2016 Dante R Hunt. All rights reserved.
//

import Foundation
import CoreData


extension ItemDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemDetails> {
        return NSFetchRequest<ItemDetails>(entityName: "ItemDetails");
    }

    @NSManaged public var itemName: String?
    @NSManaged public var itemQuanity: Int16
    @NSManaged public var list: ItemList?

}

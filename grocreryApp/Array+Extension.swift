//
//  Array+Extensions.swift
//  CoreDataTest
//
//  Created by Downey, Eric on 11/21/16.
//  Borrowed by Hunt, Dante on 11/25/16.
//  Copyright © 2016 Eric Downey. All rights reserved.
//

import Foundation

extension Array {
    func value(at index: Int) -> Element? {
        guard index >= 0 && index < endIndex else {
            return nil
        }
        return self[index]
    }
}

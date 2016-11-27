//
//  UIViewController+Extension.swift
//  CoreDataTest
//
//  Created by Downey, Eric on 11/21/16. 
//  Borrowed by Hunt, Dante on 11/25/16.
//  Copyright © 2016 Eric Downey. All rights reserved.
//

import UIKit

extension UIViewController {
    @IBAction func dimissKeyboard() {
        view.endEditing(true)
    }
}

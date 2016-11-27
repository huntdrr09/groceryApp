//
//  ViewController.swift
//  grocreryApp
//
//  Created by Dante R Hunt on 11/26/16.
//  Copyright © 2016 Dante R Hunt. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {

    
    @IBOutlet var iNameField: UITextField?
    @IBOutlet var iQuanField: UITextField?
    
    let manager = DataManager.shared
    
    @IBAction func add() {
        try? manager.create(itemData: (iNameField?.text, iQuanField?.text?.integer ?? 0))
        dismiss(animated: UIView.areAnimationsEnabled, completion: nil)
    }
}
extension String {
    var integer: Int? {
        return Int(self)
    }
}

//
//  ViewController.swift
//  grocreryApp
//
//  Created by Dante R Hunt on 11/26/16.
//  Copyright © 2016 Dante R Hunt. All rights reserved.
//

import UIKit

class AddListViewController: UIViewController {

    @IBOutlet var listNameField: UITextField?
    
    let manager = DataManager.shared
    
    @IBAction func add() {
        try? manager.createList(listNamed: listNameField?.text)
        dismiss(animated: UIView.areAnimationsEnabled, completion: nil)
    }
    @IBAction func cancel() {
        dismiss(animated: UIView.areAnimationsEnabled, completion: nil)
    }
}

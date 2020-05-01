//
//  ViewController.swift
//  CustomUIComponents
//
//  Created by Fabio Quintanilha on 4/20/20.
//  Copyright © 2020 TaskHackers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: CustomLabel!
    @IBOutlet weak var textField: CustomInputTextField!
       
    override func viewDidLoad() {
       super.viewDidLoad()
        self.textField.setType(type: .currency(.Localized))
//        self.textField.setType(type: .percentage(.regular))
       self.label.text = "89.87663"
    }
}


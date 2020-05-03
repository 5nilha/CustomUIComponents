//
//  ViewController.swift
//  CustomUIComponents
//
//  Created by Fabio Quintanilha on 4/20/20.
//  Copyright © 2020 TaskHackers. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var label: CustomLabel!
    @IBOutlet weak var textField: CustomInputTextField!
    @IBOutlet weak var entryDefaultLabel: UILabel!
    
    override func viewDidLoad() {
       super.viewDidLoad()
//        self.textField.setType(type: .currency(.Localized))
        self.textField.setType(type: .percentage(.custom(NumOfDecimals: 5)))
        self.entryDefaultLabel.text = self.textField.defaultText
        self.label.setType(type: .percentage(.regular))
        self.label.text = "89.87663"
    }
}


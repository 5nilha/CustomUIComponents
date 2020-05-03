//  Created by Fabio Quintanilha on 4/18/20.
//  Copyright © 2020 TaskHackers. All rights reserved.
//

import Foundation
import UIKit

class CustomInputTextField: UITextField, UITextFieldDelegate {
    
    public private (set) var type: CustomInputType!
    private var decorator: CustomInputDecorator!
    
    init(type: CustomInputType, frame: CGRect) {
        super.init(frame: frame)
        self.setType(type: type)
        self.commomInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setType(type: .currency(.Localized))
        self.commomInit()
        if let text = self.text, text.count > 0 {
            self.text = text
        }
    }
    
    private func commomInit() {
        self.delegate = self
        self.alignText(to: .right)
        self.keyboardType = customKeyboardConfiguration.type
        self.isSecureTextEntry = customKeyboardConfiguration.isSecretEntry
    }
    
    func setType(type: CustomInputType) {
        self.type = type
        self.decorator = CustomInputDecorator(type: self.type)
        self.placeholder = try? self.decorator.defaultPlaceholder()
    }
    
    var defaultText: String {
        return self.decorator.defaultText
    }
    
    override public var text: String? {
       didSet {
            guard let text = text else { return }
            let decoratedInput = try? self.decorator.decorate(character: text)
            if text != decoratedInput {
                 self.text = decoratedInput
            }
            layoutIfNeeded()
        }
    }

//    func settingChangedText(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        guard let delegate = self.delegate, let result = delegate.textField?(textField, shouldChangeCharactersIn: range, replacementString: string)
//         else { return true }
//
//        let decoratedInput = try? self.decorator.decorate(character: string)
//        if text != decoratedInput {
//            self.text = decoratedInput
//        }
//        return result
//    }
    
    func alignText(to position: NSTextAlignment) {
        self.textAlignment = position
    }
    
    private var customKeyboardConfiguration: (type: UIKeyboardType, isSecretEntry: Bool) {
        switch type {
        case .currency:
            return (UIKeyboardType.numberPad, false)
        case .email:
            return (UIKeyboardType.emailAddress, false)
        case .password:
            return (UIKeyboardType.default, true)
        case .percentage:
            return (UIKeyboardType.numberPad, false)
        default:
            return (UIKeyboardType.default, false)
        }
    }
    
    internal func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    internal func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxValue = self.decorator.maxValue
        print(range.location)
        if range.location <= maxValue {
            self.text = string
        }
        return false
    }
}

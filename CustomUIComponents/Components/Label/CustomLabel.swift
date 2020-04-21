//  Created by Fabio Quintanilha on 4/20/20.
//  Copyright © 2020 TaskHackers. All rights reserved.
//

import UIKit

class CustomLabel: UILabel {
    
    public private (set) var type: CustomInputType!
    private var decorator: CustomInputDecorator!
    
    init(type: CustomInputType, frame: CGRect) {
        super.init(frame: frame)
        self.setType(type: type)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setType(type: .currency(.Localized))
    }

    func setType(type: CustomInputType) {
        self.type = type
        self.decorator = CustomInputDecorator(type: self.type)
        self.text = try? self.decorator.decorate(character: self.text)
    }
    
    
    
    override public var text: String? {
        didSet {
            if let text = text {
                let decoratedInput = try? self.decorator.decorate(character: text)
                if text != decoratedInput {
                    self.text = decoratedInput
                }
            }
            layoutIfNeeded()
        }
    }
    
}

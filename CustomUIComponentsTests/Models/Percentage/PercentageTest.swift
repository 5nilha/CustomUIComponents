//
//  PercentageTest.swift
//  CustomUIComponentsTests
//
//  Created by Fabio Quintanilha on 5/1/20.
//  Copyright © 2020 TaskHackers. All rights reserved.
//

import XCTest
@testable import CustomUIComponents

class PercentageTest: XCTestCase {
    var regularPercentage: Percentage!
    var oneDecimalPercentage: Percentage!
    var twoDecimalsPercentage: Percentage!
    var customDecimalPercentage: Percentage!

    override func setUp() {
        self.regularPercentage = Percentage(type: .regular)
        self.oneDecimalPercentage = Percentage(type: .oneDigitDecimal)
        self.twoDecimalsPercentage = Percentage(type: .twoDigitsDecimal)
        self.customDecimalPercentage = Percentage(type: .custom(NumOfDecimals: 5))
    }

    override func tearDown() {
        self.regularPercentage = nil
        self.oneDecimalPercentage = nil
        self.twoDecimalsPercentage = nil
        self.customDecimalPercentage = nil
    }

    func testRegularPercentage() {
        XCTAssertEqual(try? self.regularPercentage.decorate(digitChar: "0"), "0%")
        XCTAssertEqual(try? self.regularPercentage.decorate(digitChar: "85"), "85%")
        XCTAssertEqual(try? self.regularPercentage.decorate(digitChar: "100"), "100%")
        
        do {
            _ = try self.regularPercentage.decorate(digitChar: "1,00")
        } catch {
            XCTAssertEqual(error.localizedDescription, CustomEntryError.invalidInput.description)
        }
    }
    
    func testDecimalPercentage() {
        XCTAssertEqual(try? self.oneDecimalPercentage.decorate(digitChar: "0"), "0.0%")
        XCTAssertEqual(try? self.oneDecimalPercentage.decorate(digitChar: "85.487"), "85.5%")
        XCTAssertEqual(try? self.oneDecimalPercentage.decorate(digitChar: "100.00"), "100.0%")
        
        XCTAssertEqual(try? self.twoDecimalsPercentage.decorate(digitChar: "0"), "0.0%")
        XCTAssertEqual(try? self.twoDecimalsPercentage.decorate(digitChar: "85.487"), "85.49%")
        XCTAssertEqual(try? self.twoDecimalsPercentage.decorate(digitChar: "100.00"), "100.0%")
        
        XCTAssertEqual(try? self.customDecimalPercentage.decorate(digitChar: "0"), "0.0%")
        XCTAssertEqual(try? self.customDecimalPercentage.decorate(digitChar: "85.487"), "85.487%")
        XCTAssertEqual(try? self.customDecimalPercentage.decorate(digitChar: "85.48712"), "85.48712%")
        XCTAssertEqual(try? self.customDecimalPercentage.decorate(digitChar: "100.00"), "100.0%")
    }
    
    func testConvertingNumeralValues() {
        XCTAssertEqual(try? self.regularPercentage.getNumeralValue(amount: "2.40"), 2)
        XCTAssertEqual(try? self.regularPercentage.getNumeralValue(amount: 1), 1)
        XCTAssertEqual(try? self.regularPercentage.getNumeralValue(amount: 3.5), 4)
        
        XCTAssertEqual(try? self.oneDecimalPercentage.getNumeralValue(amount: "2.40"), 2.4)
        XCTAssertEqual(try? self.oneDecimalPercentage.getNumeralValue(amount: 1), 0.1)
        XCTAssertEqual(try? self.oneDecimalPercentage.getNumeralValue(amount: 3.5), 3.5)
        
        XCTAssertEqual(try? self.twoDecimalsPercentage.getNumeralValue(amount: "2.40"), 2.4)
        XCTAssertEqual(try? self.twoDecimalsPercentage.getNumeralValue(amount: "2.44"), 2.44)
        XCTAssertEqual(try? self.twoDecimalsPercentage.getNumeralValue(amount: 1), 0.01)
        XCTAssertEqual(try? self.twoDecimalsPercentage.getNumeralValue(amount: 3.5), 3.5)
        XCTAssertEqual(try? self.twoDecimalsPercentage.getNumeralValue(amount: 3.05), 3.05)
        
        XCTAssertEqual(try? self.customDecimalPercentage.getNumeralValue(amount: "2.40"), 2.4)
        XCTAssertEqual(try? self.customDecimalPercentage.getNumeralValue(amount: "2.44123"), 2.44123)
        XCTAssertEqual(try? self.customDecimalPercentage.getNumeralValue(amount: "2.441237"), 2.44124)
        XCTAssertEqual(try? self.customDecimalPercentage.getNumeralValue(amount: 1), 0.00001)
        XCTAssertEqual(try? self.customDecimalPercentage.getNumeralValue(amount: 3.5), 3.5)
        XCTAssertEqual(try? self.customDecimalPercentage.getNumeralValue(amount: 3.0512), 3.0512)
    }
    
    func testModel() {
        var stringPercent = try? self.regularPercentage.decorate(digitChar: "2.40")
        XCTAssertEqual(stringPercent, "2%")
        XCTAssertEqual(self.regularPercentage.value as? Double, 2)
        
        stringPercent = try? self.regularPercentage.decorate(digitChar: "1")
        XCTAssertEqual(stringPercent, "1%")
        XCTAssertEqual(self.regularPercentage.value as? Double, 1)
        
        stringPercent = try? self.regularPercentage.decorate(digitChar: "3.5")
        XCTAssertEqual(stringPercent, "4%")
        XCTAssertEqual(self.regularPercentage.value as? Double, 4)
        
        stringPercent = try? self.oneDecimalPercentage.decorate(digitChar: "2.40")
        XCTAssertEqual(stringPercent, "2.4%")
        XCTAssertEqual(self.oneDecimalPercentage.value as? Double, 2.4)
        
        var stringDecimalPercent = try? self.oneDecimalPercentage.decorate(digitChar: "1")
        XCTAssertEqual(stringDecimalPercent, "0.1%")
        XCTAssertEqual(self.oneDecimalPercentage.value as? Double, 0.1)
        
        stringDecimalPercent = try? self.oneDecimalPercentage.decorate(digitChar: "3.5")
        XCTAssertEqual(stringDecimalPercent, "3.5%")
        XCTAssertEqual(self.oneDecimalPercentage.value as? Double, 3.5)
        
        stringPercent = try? self.twoDecimalsPercentage.decorate(digitChar: "2.40")
        XCTAssertEqual(stringPercent, "2.4%")
        XCTAssertEqual(self.twoDecimalsPercentage.value as? Double, 2.4)
        
        stringPercent = try? self.twoDecimalsPercentage.decorate(digitChar: "2.44")
        XCTAssertEqual(stringPercent, "2.44%")
        XCTAssertEqual(self.twoDecimalsPercentage.value as? Double, 2.44)
        
        stringPercent = try? self.twoDecimalsPercentage.decorate(digitChar: "2.456")
        XCTAssertEqual(stringPercent, "2.46%")
        XCTAssertEqual(self.twoDecimalsPercentage.value as? Double, 2.46)
        
        stringDecimalPercent = try? self.twoDecimalsPercentage.decorate(digitChar: "1")
        XCTAssertEqual(stringDecimalPercent, "0.01%")
        XCTAssertEqual(self.twoDecimalsPercentage.value as? Double, 0.01)
        
        stringDecimalPercent = try? self.twoDecimalsPercentage.decorate(digitChar: "3.5")
        XCTAssertEqual(stringDecimalPercent, "3.5%")
        XCTAssertEqual(self.twoDecimalsPercentage.value as? Double, 3.5)
        
        stringDecimalPercent = try? self.twoDecimalsPercentage.decorate(digitChar: "3.05")
        XCTAssertEqual(stringDecimalPercent, "3.05%")
        XCTAssertEqual(self.twoDecimalsPercentage.value as? Double, 3.05)
        
        stringPercent = try? self.customDecimalPercentage.decorate(digitChar: "2.40")
        XCTAssertEqual(stringPercent, "2.4%")
        XCTAssertEqual(self.customDecimalPercentage.value as? Double, 2.4)
        
        stringPercent = try? self.customDecimalPercentage.decorate(digitChar: "2.44123")
        XCTAssertEqual(stringPercent, "2.44123%")
        XCTAssertEqual(self.customDecimalPercentage.value as? Double, 2.44123)
        
        stringPercent = try? self.customDecimalPercentage.decorate(digitChar: "2.441237")
        XCTAssertEqual(stringPercent, "2.44124%")
        XCTAssertEqual(self.customDecimalPercentage.value as? Double, 2.44124)
        
        stringDecimalPercent = try? self.customDecimalPercentage.decorate(digitChar: "1")
        XCTAssertEqual(stringDecimalPercent, "0.00001%")
        XCTAssertEqual(self.customDecimalPercentage.value as? Double, 0.00001)
        
        stringDecimalPercent = try? self.customDecimalPercentage.decorate(digitChar: "3.5")
        XCTAssertEqual(stringDecimalPercent, "3.5%")
        XCTAssertEqual(self.customDecimalPercentage.value as? Double, 3.5)
        
        stringDecimalPercent = try? self.customDecimalPercentage.decorate(digitChar: "3.0512")
        XCTAssertEqual(stringDecimalPercent, "3.0512%")
        XCTAssertEqual(self.customDecimalPercentage.value as? Double, 3.0512)
        
        
    }
    
    func testPlaceholder() {
        XCTAssertEqual(self.regularPercentage.defaultPlaceholder(), "0%")
        XCTAssertEqual(self.oneDecimalPercentage.defaultPlaceholder(), "0.0%")
        XCTAssertEqual(self.twoDecimalsPercentage.defaultPlaceholder(), "0.0%")
        XCTAssertEqual(self.customDecimalPercentage.defaultPlaceholder(), "0.0%")
    }
}

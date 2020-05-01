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
    var decimalPercentage: Percentage!

    override func setUp() {
        self.regularPercentage = Percentage(type: .regular)
        self.decimalPercentage = Percentage(type: .decimal)
    }

    override func tearDown() {
        self.regularPercentage = nil
        self.decimalPercentage = nil
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
        XCTAssertEqual(try? self.decimalPercentage.decorate(digitChar: "0"), "0.0%")
        XCTAssertEqual(try? self.decimalPercentage.decorate(digitChar: "85.487"), "85.5%")
        XCTAssertEqual(try? self.decimalPercentage.decorate(digitChar: "100.00"), "100.0%")
        
        do {
            _ = try self.regularPercentage.decorate(digitChar: "1,00")
        } catch {
            XCTAssertEqual(error.localizedDescription, CustomEntryError.invalidInput.description)
        }
    }
    
    func testConvertingNumeralValues() {
        XCTAssertEqual(try? self.regularPercentage.getNumeralValue(amount: "2.40"), 2)
        XCTAssertEqual(try? self.regularPercentage.getNumeralValue(amount: 1), 1)
        XCTAssertEqual(try? self.regularPercentage.getNumeralValue(amount: 3.5), 4)
        
        XCTAssertEqual(try? self.decimalPercentage.getNumeralValue(amount: "2.40"), 2.4)
        XCTAssertEqual(try? self.decimalPercentage.getNumeralValue(amount: 1), 0.1)
        XCTAssertEqual(try? self.decimalPercentage.getNumeralValue(amount: 3.5), 3.5)
    }
    
    func testModel() {
        var stringPercent = try? self.regularPercentage.decorate(digitChar: "2.40")
        XCTAssertEqual(stringPercent, "2%")
        XCTAssertEqual(self.regularPercentage.value, 2)
        
        stringPercent = try? self.regularPercentage.decorate(digitChar: "1")
        XCTAssertEqual(stringPercent, "1%")
        XCTAssertEqual(self.regularPercentage.value, 1)
        
        stringPercent = try? self.regularPercentage.decorate(digitChar: "3.5")
        XCTAssertEqual(stringPercent, "4%")
        XCTAssertEqual(self.regularPercentage.value, 4)
        
        stringPercent = try? self.decimalPercentage.decorate(digitChar: "2.40")
        XCTAssertEqual(stringPercent, "2.4%")
        XCTAssertEqual(self.decimalPercentage.value, 2.4)
        
        var stringDecimalPercent = try? self.decimalPercentage.decorate(digitChar: "1")
        XCTAssertEqual(stringDecimalPercent, "0.1%")
        XCTAssertEqual(self.decimalPercentage.value, 0.1)
        
        stringDecimalPercent = try? self.decimalPercentage.decorate(digitChar: "3.5")
        XCTAssertEqual(stringDecimalPercent, "3.5%")
        XCTAssertEqual(self.decimalPercentage.value, 3.5)
    }
    
    func testPlaceholder() {
        XCTAssertEqual(self.regularPercentage.defaultPlaceholder(), "0%")
    }
}

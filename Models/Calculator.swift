//
//  Calculator.swift
//  Calculator-iOS
//
//  Created by Mihnea Amihailesei on 06.04.2024.
//

import Foundation

struct Calculator {
    
    private struct ArithmeticExpression: Equatable {
        var number: Decimal
        var operation: ArithmeticOperation
        
        func evaluate(with secondNumber: Decimal) -> Decimal {
            switch operation {
            case .addition:
                return number + secondNumber
            case .subtraction:
                return number - secondNumber
            case .multiplication:
                return number * secondNumber
            case .division:
                return number / secondNumber
            }
        }
    }
    
    // MARK: - PROPERTIES
    
    private var newNumber: Decimal? {
        didSet {
            guard newNumber != nil else { return }
            carryingNegative = false
            carryingDecimal = false
            carryingZeroCount = 0
            pressedClear = false
        }
    }
    
    private var pressedClear: Bool = false
    private var expression: ArithmeticExpression?
    private var result: Decimal?
    private var carryingNegative: Bool = false
    private var carryingDecimal: Bool = false
    private var carryingZeroCount: Int = 0
    
    // MARK: - COMPUTED PROPERTIES
    
    var displayText: String {
        return getNumberString(forNumber: number, withCommas: true)
    }
    
    // Current displaying number
    
    private var number: Decimal? {
        if pressedClear || carryingDecimal {
            return newNumber
        }
        return newNumber ?? expression?.number ?? result
    }
    
    private var containsDecimal: Bool {
        return getNumberString(forNumber: number).contains(".")
    }
    
    var showAllClear: Bool {
        newNumber == nil && expression == nil && result == nil || pressedClear
    }
    
    // MARK: - OPERATIONS
    
    mutating func setDigit(_ digit: Digit) {
        if containsDecimal && digit == .zero {
            carryingZeroCount += 1
        }
        else if canAddDigit(digit) {
            // 2. Convert newNumber to a String
            let numberString = getNumberString(forNumber: newNumber)
            
            // 3. Append the digit to the end of the string, convert String to decimal and assign it to newNumber
            newNumber = Decimal(string: numberString.appending("\(digit.rawValue)"))
        }
    }
    
    mutating func setOperation(_ operation: ArithmeticOperation) {
        // 1. Check if there is a number we can use (newNumber or previous result)
        guard var number = newNumber ?? result else { return }
        
        // 2. Check if there is an existingExpression
        if let existingExpression = expression {
            number = existingExpression.evaluate(with: number)
        }
        
        // 3. Assign new ArithmeticExpression with number and operation to expression
        expression = ArithmeticExpression(number: number, operation: operation)
        
        // 4. Reset newNumber
        newNumber = nil
    }
    
    mutating func toggleSign() {
        if let number = newNumber {
            newNumber = -number
            return
        }
        
        if let number = result {
            result = -number
            return
        }
        carryingNegative.toggle()
    }
    
    mutating func setPercent() {
        
        if let number = newNumber {
            newNumber = number / 100
            return
        }
        
        if let number = result {
            result = number / 100
            return
        }
    }
    
    mutating func setDecimal() {
        if containsDecimal { return }
        
        carryingDecimal = true
    }
        
    mutating func evaluate() {
        // 1.
        guard let number = newNumber, let expressionToEvaluate = expression else { return }
        
        // 2.
        result = expressionToEvaluate.evaluate(with: number)
        
        // 3.
        expression = nil
        newNumber = nil
    }
        
    mutating func allClear() {
        newNumber = nil
        expression = nil
        result = nil
        carryingNegative = false
        carryingDecimal = false
        carryingZeroCount = 0
    }
        
    mutating func clear() {
        newNumber = nil
        carryingNegative = false
        carryingDecimal = false
        carryingZeroCount = 0
        
        pressedClear = true
    }
    
    // MARK: - HELPERS
    
    func operationIsHighlighted(_ operation: ArithmeticOperation) -> Bool {
        return expression?.operation == operation && newNumber == nil
    }
    
    private func getNumberString(forNumber number: Decimal?, withCommas: Bool = false) -> String {
        var numberString = (withCommas ? number?.formatted(.number) : number.map(String.init)) ?? "0"
        
        if carryingNegative {
            numberString.insert("-", at: numberString.startIndex)
        }
        
        if carryingDecimal {
            numberString.insert(".", at: numberString.endIndex)
        }
        
        if carryingZeroCount > 0 {
            numberString.append(String(repeating: "0", count: carryingZeroCount))
        }
        
        return numberString
    }
    
    private func canAddDigit(_ digit: Digit) -> Bool {
        return number != nil || digit != .zero
    }
    
}

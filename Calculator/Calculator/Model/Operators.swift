//
//  Operator.swift
//  Calculator
//
//  Created by 잼킹 on 2021/03/26.
//

import Foundation

protocol DecimalOperation {
    func multiply(firstElement: Double, by secondElement: Double) -> String
    func divide(firstElement: Double, with secondElement: Double) throws -> String
}

protocol BinaryOperation {
    func andOperation(_ firstElement: Int, and secondElement: Int) -> String
    func nandOperation(_ firstElement: Int, nand secondElement: Int) -> String
    func orOperation(_ firstElement: Int, or secondElement: Int) -> String
    func norOperation(_ firstElement: Int, nor secondElement: Int) -> String
    func xorOperation(_ firstElement: Int, xor secondElement: Int) -> String
    func notOperation(with element: Int) -> String
    func rightShiftOperation(with element: Int) -> String
    func leftShiftOPeration(with element: Int) -> String
}

class DecimalOperator: DecimalOperation {
    func changeSign(element: String) throws -> String {
        if let intElement = Int(element) {
            return String(-intElement)
        }
        guard let doubleElement = Double(element) else { throw CalculatorError.notNumericInput }
        return String(-doubleElement)
    }
    
    func add(firstElement: Double, to secondElement: Double) -> String {
        return String(firstElement + secondElement)
    }
    
    func subtract(secondElement: Double, from firstElement: Double) -> String {
        return String(firstElement - secondElement)
    }
    
    func multiply(firstElement: Double, by secondElement: Double) -> String {
        return String(firstElement * secondElement)
    }
    
    func divide(firstElement: Double, with secondElement: Double) throws -> String {
        if secondElement == 0 { throw CalculatorError.divideByZero }
        return String(firstElement / secondElement)
    }
}

class BinaryOperator: BinaryOperation {
    func changeSign(element: Int) -> Int {
        return -element
    }
    
    func add(_ firstElement: Int, to secondElement: Int) -> String {
        return String(firstElement + secondElement)
    }
    
    func subtract(_ secondElement: Int, from firstElement: Int) -> String {
        return String(firstElement - secondElement)
    }
    
    func andOperation(_ firstElement: Int, and secondElement: Int) -> String {
        return String(firstElement & secondElement)
    }
    
    func nandOperation(_ firstElement: Int, nand secondElement: Int) -> String {
        return String(~(firstElement & secondElement))
    }
    
    func orOperation(_ firstElement: Int, or secondElement: Int) -> String {
        return String(firstElement | secondElement)
    }
    
    func norOperation(_ firstElement: Int, nor secondElement: Int) -> String {
        return String(~(firstElement | secondElement))
    }
    
    func xorOperation(_ firstElement: Int, xor secondElement: Int) -> String {
        return String(firstElement ^ secondElement)
    }
    
    func notOperation(with element: Int) -> String {
        return String(~element)
    }
    
    func rightShiftOperation(with element: Int) -> String {
        return String(element >> 1)
    }
    
    func leftShiftOPeration(with element: Int) -> String {
        return String(element << 1)
    }
}

enum operationPrecedenceTier: Int {
    case topTier = 160
    case secondTier = 140
    case thirdTier = 120
}


struct OperationPrecedenceTable {
    let precedence: [String:Int] = [
        "+" : operatorPrecedenceTier.thirdTier.rawValue,
        "-" : operatorPrecedenceTier.thirdTier.rawValue,
        "*" : operatorPrecedenceTier.topTier.rawValue,
        "/" : operatorPrecedenceTier.topTier.rawValue,
        "~" : operatorPrecedenceTier.topTier.rawValue,
        "&" : operatorPrecedenceTier.topTier.rawValue,
        "~&" : operatorPrecedenceTier.topTier.rawValue,
        "|" : operatorPrecedenceTier.thirdTier.rawValue,
        "~|" : operatorPrecedenceTier.thirdTier.rawValue,
        "^" : operatorPrecedenceTier.thirdTier.rawValue,
        "<<" : operatorPrecedenceTier.secondTier.rawValue,
        ">>" : operatorPrecedenceTier.secondTier.rawValue,
    ]
}

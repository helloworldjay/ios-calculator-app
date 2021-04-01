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

class BaseOperator {
    func calculate(firstElement: String, secondElement: String = "", method: (Double, Double) -> Double) throws -> String {
        guard let doubleFirstElement = Double(firstElement), let doubleSecondElement = Double(secondElement) else { throw CalculatorError.notNumericInput }
        return String(method(doubleFirstElement, doubleSecondElement))
    }
    
    func changeSign(element: String) throws -> String {
        if let intElement = Int(element) { return String(-intElement) }
        guard let doubleElement = Double(element) else { throw CalculatorError.notNumericInput }
        return String(-doubleElement)
    }
    
    func add(firstElement: String, secondElement: String) throws -> String {
        if let intFirstElement = Int(firstElement), let intSecondElement = Int(secondElement) { return String(intFirstElement + intSecondElement) }
        guard let doubleFirstElement = Double(firstElement), let doubleSecondElement = Double(secondElement) else { throw CalculatorError.notNumericInput }
        return String(doubleFirstElement + doubleSecondElement)
    }
    
    func subtract(firstElement: String, secondElement: String) throws -> String {
        if let intFirstElement = Int(firstElement), let intSecondElement = Int(secondElement) { return String(intFirstElement - intSecondElement) }
        guard let doubleFirstElement = Double(firstElement), let doubleSecondElement = Double(secondElement) else { throw CalculatorError.notNumericInput }
        return String(doubleFirstElement - doubleSecondElement)
    }
}

class DecimalOperator: BaseOperator, DecimalOperation {
    func multiply(firstElement: Double, by secondElement: Double) -> String {
        return String(firstElement * secondElement)
    }
    
    func divide(firstElement: Double, with secondElement: Double) throws -> String {
        if secondElement == 0 { throw CalculatorError.divideByZero }
        return String(firstElement / secondElement)
    }
}

class BinaryOperator: BaseOperator, BinaryOperation {
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

enum OperationPrecedenceTier: Int {
    case topTier = 160
    case secondTier = 140
    case thirdTier = 120
}

enum Operator {
    case add
    
    var operation: (Double, Double) -> Double {
        switch self {
        case .add: return { $0 + $1 }
        }
    }
}

struct OperationPrecedenceTable {
    let precedence: [String:Int] = [
        "+" : OperationPrecedenceTier.thirdTier.rawValue,
        "-" : OperationPrecedenceTier.thirdTier.rawValue,
        "*" : OperationPrecedenceTier.topTier.rawValue,
        "/" : OperationPrecedenceTier.topTier.rawValue,
        "~" : OperationPrecedenceTier.topTier.rawValue,
        "&" : OperationPrecedenceTier.topTier.rawValue,
        "~&" : OperationPrecedenceTier.topTier.rawValue,
        "|" : OperationPrecedenceTier.thirdTier.rawValue,
        "~|" : OperationPrecedenceTier.thirdTier.rawValue,
        "^" : OperationPrecedenceTier.thirdTier.rawValue,
        "<<" : OperationPrecedenceTier.secondTier.rawValue,
        ">>" : OperationPrecedenceTier.secondTier.rawValue,
    ]
}

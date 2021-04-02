//
//  Operator.swift
//  Calculator
//
//  Created by 잼킹 on 2021/03/26.
//

import Foundation


struct Calculator {
    func doubleCalculate(firstElement: String, secondElement: String, method: (Double, Double) -> Double) throws -> String {
        guard let doubleFirstElement = Double(firstElement), let doubleSecondElement = Double(secondElement) else { throw CalculatorError.notNumericInput }
        return String(method(doubleFirstElement, doubleSecondElement))
    }
    
    func intUnaryCalculate(element: String, method: (Int) -> Int) throws -> String {
        guard let intElement = Int(element) else { throw CalculatorError.notNumericInput }
        return String(method(intElement))
    }
    
    func intBinaryCalculate(firstElement: String, secondElement: String, method: (Int, Int) -> Int) throws -> String {
        guard let intFirstElement = Int(firstElement), let intSecondElement = Int(secondElement) else { throw CalculatorError.notNumericInput }
        return String(method(intFirstElement, intSecondElement))
    }
}

enum DoubleOperator {
    case add, subtract, multiply, divide
    
    var doubleOperation: (Double, Double) -> Double {
        switch self {
        case .add: return { $0 + $1 }
        case .subtract: return { $0 - $1 }
        case .multiply: return { $0 * $1 }
        case .divide: return { $0 / $1 }
        }
    }
}

enum IntUnaryOperator {
    case notOperation, rightShiftOperation, leftShiftOPeration
    
    var intUnaryOperation: (Int) -> Int {
        switch self {
        case .notOperation: return { ~$0 }
        case .rightShiftOperation: return { $0 >> 1 }
        case .leftShiftOPeration: return { $0 << 1 }
        }
    }
}

enum IntBinaryOperator {
    case add, subtract, andOperation, nandOperation, orOperation, norOperation, xorOperation
    
    var intBinaryOperation: (Int, Int) -> Int {
        switch self {
        case .add: return { $0 + $1 }
        case .subtract: return { $0 - $1 }
        case .andOperation: return { $0 & $1 }
        case .nandOperation: return { ~($0 & $1) }
        case .orOperation: return { $0 | $1 }
        case .norOperation: return { ~($0 | $1) }
        case .xorOperation: return { $0 ^ $1 }
        }
    }
}

enum OperationPrecedenceTier: Comparable {
    case topTier
    case secondTier
    case thirdTier
}

struct OperationPrecedenceTable {
    let precedence: [String : OperationPrecedenceTier] = [
        "+" : OperationPrecedenceTier.thirdTier,
        "-" : OperationPrecedenceTier.thirdTier,
        "*" : OperationPrecedenceTier.topTier,
        "/" : OperationPrecedenceTier.topTier,
        "~" : OperationPrecedenceTier.topTier,
        "&" : OperationPrecedenceTier.topTier,
        "~&" : OperationPrecedenceTier.topTier,
        "|" : OperationPrecedenceTier.thirdTier,
        "~|" : OperationPrecedenceTier.thirdTier,
        "^" : OperationPrecedenceTier.thirdTier,
        "<<" : OperationPrecedenceTier.secondTier,
        ">>" : OperationPrecedenceTier.secondTier,
    ]
}

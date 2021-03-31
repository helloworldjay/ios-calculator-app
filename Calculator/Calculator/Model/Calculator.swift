//
//  Calculator.swift
//  Calculator
//
//  Created by Seungjin Baek on 2021/03/25.
//

import Foundation

class DecimalCalculator {
    var accumulator = 0.0
    
    func calculateDecimal(with postfixOperation: Stack<String>) -> Double {
    // stack에서 pop해서 숫자이면 stack에 담고, 연산자이면 필요한 수만큼 꺼내서 연산
        return accumulator
    }
    
    func cutDigit() -> String {
        let accumulatorForUI = String(accumulator)
        if accumulatorForUI.hasSuffix(".0") {
            let endIndex = accumulatorForUI.index(accumulatorForUI.startIndex, offsetBy: accumulatorForUI.count-2)
            return String(accumulatorForUI[..<endIndex])
        }
        return accumulatorForUI
    }
}





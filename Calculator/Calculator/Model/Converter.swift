//
//  Converter.swift
//  Calculator
//
//  Created by Seungjin Baek on 2021/03/30.
//

import Foundation

let userInputExample = Stack<String>.init(stack: ["3", "*", "7", "+", "3", "*", "2"])
let convertedInputExample = PrefixToPostfixConverter.convertPrefixToPostfix(with: userInputExample)

class PrefixToPostfixConverter {
    static func convertPrefixToPostfix(with prefixOperation: Stack<String>) -> Stack<String> {
        // from prefix to postfix logic here
        return Stack<String>()
    }
}

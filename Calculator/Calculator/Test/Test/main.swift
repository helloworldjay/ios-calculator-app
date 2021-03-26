//
//  main.swift
//  Test
//
//  Created by Tak on 2021/03/25.
//

import Foundation

enum CodaError: Error {
    case summerUnwrapFailed
}

func bind() throws -> String {
    guard let unWrappedSummer = readLine() else {
        throw CodaError.summerUnwrapFailed
    }
}

protocol addSubtract {
    func add()
    func subtract()
}

class Calculator: addSubtract {
    func add() {
        <#code#>
    }
    
    func subtract() {
        <#code#>
    }
}

class DecimalCalculator: Calculator {
    var input: Double
    
    init(input: Double) {
        var _ = input
    }
    
    func multiple() {
        
    }
    
    func divide() {
        
    }
}

class BinaryCalculator: Calculator {
    var input: Int
    
    init(input: Int) {
        var _ = input
    }
    
    func operateAnd() {
        
    }
    
    func operateNand() {
        
    }
    
    func operateOR() {
        
    }
    
    func operateNor() {
        
    }
    
    func operateXor() {
        
    }
    
    func operateNot() {
        
    }
    
    func operateShift() {
        
    }
}



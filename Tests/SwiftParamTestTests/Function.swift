//
//  Function.swift
//  SwiftParamTestTests
//
//  Created by Yusuke Hosonuma on 2020/03/12.
//

import XCTest

func fizzBuzz(_ x: Int) -> String {
    switch (x % 3 == 0, x % 5 == 0) {
    case (true, false): return "Fizz"
    case (false, true): return "Buzz"
    case (true, true): return "FizzBuzz"
    case (false, false): return "\(x)"
    }
}

class SpyCustomAssertion<T: Equatable> {
    struct Assert<T: Equatable>: Equatable {
        var actual: T
        var expected: T
    }

    init() {}

    var args_assert: [Assert<T>] = []
    
    func assert(_ actual: T, _ expected: T, file: StaticString, line: UInt) {
        args_assert.append(Assert(actual: actual, expected: expected))

        let message = """
        
        ----
        Expected: \(expected)
        Actual: \(actual)
        ----
        """
        XCTAssert(expected == actual, message, file: file, line: line)
    }
}

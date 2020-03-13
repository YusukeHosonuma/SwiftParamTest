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

func customAssertion<T: Equatable>(_ actual: T, _ expected: T, file: StaticString, line: UInt) {
    let message = """
    
    ----
    Expected: \(expected)
    Actual: \(actual)
    ----
    """
    XCTAssert(expected == actual, message, file: file, line: line)
}

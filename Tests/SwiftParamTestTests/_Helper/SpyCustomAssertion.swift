//
//  SpyCustomAssertion.swift
//  SwiftParamTestTests
//
//  Created by Yusuke Hosonuma on 2020/03/25.
//

import XCTest

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

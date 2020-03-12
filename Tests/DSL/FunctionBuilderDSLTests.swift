//
//  DSLTests.swift
//  SwiftParamTestTests
//
//  Created by Yusuke Hosonuma on 2020/02/28.
//

import SwiftParamTest
import XCTest

class DSLTests: XCTestCase {
    override func setUp() {}

    override func tearDown() {}

    func testExample() {
        assert(to: fizzBuzz) {
            args(1, expect: "1")
            args(2, expect: "2")
            args(3, expect: "Fizz")
            args(4, expect: "4")
            args(5, expect: "Buzz")
            args(6, expect: "Fizz")
            args(7, expect: "7")
            //
            // Failed example:
            //
            // ```
            // args(7, expect: "Apple")
            // ```
            // => XCTAssertTrue failed - Expect to 'Apple' but '7'
            //
            args(8, expect: "8")
            args(9, expect: "Fizz")
            args(10, expect: "Buzz")
            args(11, expect: "11")
            args(12, expect: "Fizz")
            args(13, expect: "13")
            args(14, expect: "14")
            args(15, expect: "FizzBuzz")
        }

        assert(to: +) {
            args((1, 1), expect: 2)
            args((1, 2), expect: 3)
            args((2, 2), expect: 4)
        }
    }

    func testCustomAssertion() {
        assert(to: fizzBuzz, with: customAssertion) {
            args(1, expect: "1")
            args(2, expect: "2")
            args(3, expect: "Fizz")
            args(4, expect: "4")
            args(5, expect: "Buzz")
            args(6, expect: "Fizz")
            args(7, expect: "7")
            //
            // Failed example:
            //
            // ```
            // args(7, expect: "Apple")
            // ```
            // =>
            //
            // XCTAssertTrue failed -
            // ----
            // Expected: 7
            // Actual: Apple
            // ----
            //
            args(8, expect: "8")
            args(9, expect: "Fizz")
            args(10, expect: "Buzz")
            args(11, expect: "11")
            args(12, expect: "Fizz")
            args(13, expect: "13")
            args(14, expect: "14")
            args(15, expect: "FizzBuzz")
        }
    }
}

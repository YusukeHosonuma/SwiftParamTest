//
// ExampleTests.swift
// SwiftParamTest
//
// Created by Yusuke Hosonuma on 2020/02/28.
// Copyright (c) 2020 Yusuke Hosonuma.
//

import SwiftParamTest
import XCTest

func fizzBuzz(_ x: Int) -> String {
    switch (x % 3 == 0, x % 5 == 0) {
    case (true, false): return "Fizz"
    case (false, true): return "Buzz"
    case (true, true): return "FizzBuzz"
    case (false, false): return "\(x)"
    }
}

func indent(to target: String, size: Int) -> String {
    String(repeating: " ", count: size) + target
}

struct Calculator {
    var initialValue: Int

    func add(_ n: Int) -> Int {
        initialValue + n
    }

    func subtraction(_ n: Int) -> Int {
        initialValue - n
    }
}

class Tests: XCTestCase {
    /// Example: test for single argument function
    func testFizzBuzz() {
        assert(to: fizzBuzz).expect([
            when(1, then: "1"),
            when(2, then: "2"),
            when(3, then: "Fizz"),
            when(4, then: "4"),
            when(5, then: "Buzz"),
            when(6, then: "Fizz"),
            when(7, then: "7"),
            when(8, then: "8"),
            when(9, then: "Fizz"),
            when(10, then: "Buzz"),
            when(11, then: "11"),
            when(12, then: "Fizz"),
            when(13, then: "13"),
            when(14, then: "14"),
            when(15, then: "FizzBuzz"),
        ])
    }

    /// Example: test for two argument function
    func testIndent() {
        assert(to: indent).expect([
            when(("Hello", 0), then: "Hello"),
            when(("Hello", 2), then: "  Hello"),
            when(("Hello", 4), then: "    Hello"),
        ])
    }

    /// Example: test for operator
    func testOperator() {
        assert(to: +).expect([
            when((1, 1), then: 2),
            when((1, 2), then: 3),
            when((2, 2), then: 4),
        ])
    }

    /// Example: test for method of object
    func testObject() {
        let calc = Calculator(initialValue: 10)

        assert(to: calc.add).expect([
            when(1, then: 11),
            when(2, then: 12),
            when(3, then: 13),
        ])

        assert(to: calc.subtraction).expect([
            when(1, then: 9),
            when(2, then: 8),
            when(3, then: 7),
        ])
    }
}

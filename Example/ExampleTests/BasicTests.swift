//
// ExampleTests.swift
// SwiftParamTest
//
// Created by Yusuke Hosonuma on 2020/02/28.
// Copyright (c) 2020 Yusuke Hosonuma.
//

import SwiftParamTest
import XCTest

class Tests: XCTestCase {
    /// Example: test for single argument function
    func testFizzBuzz() {
        assert(to: fizzBuzz, expect: [
            // basic
            args(1, expect: "1"),
            args(2, expect: "2"),
            args(3, expect: "Fizz"),
            args(4, expect: "4"),
            args(5, expect: "Buzz"),
            args(6, expect: "Fizz"),
            args(7, expect: "7"),
            args(8, expect: "8"),
            args(9, expect: "Fizz"),
            args(10, expect: "Buzz"),
            args(11, expect: "11"),
            args(12, expect: "Fizz"),
            args(13, expect: "13"),
            args(14, expect: "14"),
            args(15, expect: "FizzBuzz"),

            // operator
            expect(1 ==> "1"),
            expect(2 ==> "2"),
            expect(3 ==> "Fizz"),
            expect(4 ==> "4"),
            expect(5 ==> "Buzz"),
            expect(6 ==> "Fizz"),
            expect(7 ==> "7"),
            expect(8 ==> "8"),
            expect(9 ==> "Fizz"),
            expect(10 ==> "Buzz"),
            expect(11 ==> "11"),
            expect(12 ==> "Fizz"),
            expect(13 ==> "13"),
            expect(14 ==> "14"),
            expect(15 ==> "FizzBuzz"),
        ] as [Row1<Int, String>])
    }

    /// Example: test for two argument function
    func testIndent() {
        assert(to: indent, expect: [
            // basic
            args(("Hello", 0), expect: "Hello"),
            args(("Hello", 2), expect: "  Hello"),
            args(("Hello", 4), expect: "    Hello"),

            // operator
            expect(("Hello", 0) ==> "Hello"),
            expect(("Hello", 2) ==> "  Hello"),
            expect(("Hello", 4) ==> "    Hello"),
        ])
    }

    /// Example: test for operator
    func testOperator() {
        assert(to: +, expect: [
            // basic
            args((1, 1), expect: 2),
            args((1, 2), expect: 3),
            args((2, 2), expect: 4),

            // operator
            expect((1, 1) ==> 2),
            expect((1, 2) ==> 3),
            expect((2, 2) ==> 4),
        ])
    }

    /// Example: test for method of object
    func testObject() {
        let calc = Calculator(initialValue: 10)

        assert(to: calc.add, expect: [
            // basic
            args(1, expect: 11),
            args(2, expect: 12),
            args(3, expect: 13),

            // operator
            expect(1 ==> 11),
            expect(2 ==> 12),
            expect(3 ==> 13),
        ])

        assert(to: calc.subtraction, expect: [
            // basic
            args(1, expect: 9),
            args(2, expect: 8),
            args(3, expect: 7),

            // operator
            expect(1 ==> 9),
            expect(2 ==> 8),
            expect(3 ==> 7),
        ])
    }
}

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

class Tests: XCTestCase {
    func testFizzBuzz() {
        assert(fizzBuzz).forAll([
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
}

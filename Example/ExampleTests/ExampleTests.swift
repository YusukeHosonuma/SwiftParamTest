//
//  ExampleTests.swift
//  ExampleTests
//
//  Created by Yusuke Hosonuma on 2020/02/26.
//  Copyright © 2020 Yusuke Hosonuma. All rights reserved.
//

import XCTest
import SwiftParamTest

func fizzBuzz(_ x: Int) -> String {
    return "\(x)"
}

class Tests: XCTestCase {
    func testFizzBuzz() {
        assert(fizzBuzz).forAll([
            when(1, then: "1"),
            when(2, then: "2"),
            when(3, then: "Fizz"), // failed example
            when(4, then: "4"),
            when(5, then: "Buzz"), // failed example
            when(6, then: "6"),
        ])
    }
}

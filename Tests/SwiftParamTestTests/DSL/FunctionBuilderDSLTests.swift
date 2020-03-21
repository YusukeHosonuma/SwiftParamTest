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
        // function
        assert(to: fizzBuzz, header: ["n"]) {
            args(1, expect: "1")
            args(2, expect: "2")
            args(3, expect: "Fizz")
            args(4, expect: "4")
            args(5, expect: "Buzz")
            args(6, expect: "Fizz")
            args(7, expect: "7")
            args(8, expect: "8")
            args(9, expect: "Fizz")
            args(10, expect: "Buzz")
            args(11, expect: "11")
            args(12, expect: "Fizz")
            args(13, expect: "13")
            args(14, expect: "14")
            args(15, expect: "FizzBuzz")
        }

        // operator
        assert(to: +, header: ["lhs", "rhs"]) {
            args(1, 1, expect: 2)
            args(1, 2, expect: 3)
            args(2, 2, expect: 4)
        }

        // instance method that has not argument
        assert(to: String.lowercased, header: ["string"]) {
            args("hello", expect: "hello")
            args("HELLO", expect: "hello")
        }

        // instance method that has arguments
        assert(to: String.hasPrefix, header: ["string", "prefix"]) {
            args("hello", "he", expect: true)
            args("hello", "HE", expect: false)
        }

        // instance method that receiver is fixed
        assert(
            to: "hello".hasPrefix,
            header: ["prefix"]
        ) {
            args("he", expect: true)
            args("HE", expect: false)
        }
    }
    
    func testFunctionArgs() {
        func f1(n1: Int) -> [Int] { [n1] }
        func f2(n1: Int, n2: Int) -> [Int] { [n1, n2] }
        func f3(n1: Int, n2: Int, n3: Int) -> [Int] { [n1, n2, n3] }
        func f4(n1: Int, n2: Int, n3: Int, n4: Int) -> [Int] { [n1, n2, n3, n4] }

        let expectedTable1 = """
        | Args 0 | Expected |
        |--------|----------|
        |      1 | [1]      |
        |      1 | [1]      |
        """
        
        let expectedTable2 = """
        | Args 0 | Args 1 | Expected |
        |--------|--------|----------|
        |      1 |      2 | [1, 2]   |
        |      1 |      2 | [1, 2]   |
        """
        
        let expectedTable3 = """
        | Args 0 | Args 1 | Args 2 | Expected  |
        |--------|--------|--------|-----------|
        |      1 |      2 |      3 | [1, 2, 3] |
        |      1 |      2 |      3 | [1, 2, 3] |
        """
        
        let expectedTable4 = """
        | Args 0 | Args 1 | Args 2 | Args 3 | Expected     |
        |--------|--------|--------|--------|--------------|
        |      1 |      2 |      3 |      4 | [1, 2, 3, 4] |
        |      1 |      2 |      3 |      4 | [1, 2, 3, 4] |
        """
        
        // passed as `each arguments`
        
        assertEqualLines(assert(to: f1) {
            args(1, expect: [1])
            args(1, expect: [1])
        }.table, expectedTable1)
        
        assertEqualLines(assert(to: f2) {
            args(1, 2, expect: [1, 2])
            args(1, 2, expect: [1, 2])
        }.table, expectedTable2)
        
        assertEqualLines(assert(to: f3) {
            args(1, 2, 3, expect: [1, 2, 3])
            args(1, 2, 3, expect: [1, 2, 3])
        }.table, expectedTable3)
        
        assertEqualLines(assert(to: f4) {
            args(1, 2, 3, 4, expect: [1, 2, 3, 4])
            args(1, 2, 3, 4, expect: [1, 2, 3, 4])
        }.table, expectedTable4)
        
        // passed as `tuple`
        
        assertEqualLines(assert(to: f2) {
            args((1, 2), expect: [1, 2])
            args((1, 2), expect: [1, 2])
        }.table, expectedTable2)
        
        assertEqualLines(assert(to: f3) {
            args((1, 2, 3), expect: [1, 2, 3])
            args((1, 2, 3), expect: [1, 2, 3])
        }.table, expectedTable3)
        
        assertEqualLines(assert(to: f4) {
            args((1, 2, 3, 4), expect: [1, 2, 3, 4])
            args((1, 2, 3, 4), expect: [1, 2, 3, 4])
        }.table, expectedTable4)
    }
    
    func testInstanceMethodArgs() {
        class C: CustomStringConvertible {
            var description: String = "C"
            
            func f0() -> Int { 42 }
            func f1(n1: Int) -> [Int] { [n1] }
            func f2(n1: Int, n2: Int) -> [Int] { [n1, n2] }
            func f3(n1: Int, n2: Int, n3: Int) -> [Int] { [n1, n2, n3] }
            func f4(n1: Int, n2: Int, n3: Int, n4: Int) -> [Int] { [n1, n2, n3, n4] }
        }
        
        let c = C()
        
        assertEqualLines(assert(to: C.f0) {
            args(c, expect: 42)
            args(c, expect: 42)
        }.table, """
        | Args 0 | Expected |
        |--------|----------|
        | C      |       42 |
        | C      |       42 |
        """)
        
        assertEqualLines(assert(to: C.f1) {
            args(c, 1, expect: [1])
            args(c, 1, expect: [1])
        }.table, """
        | Args 0 | Args 1 | Expected |
        |--------|--------|----------|
        | C      |      1 | [1]      |
        | C      |      1 | [1]      |
        """)
        
        assertEqualLines(assert(to: C.f2) {
            args(c, 1, 2, expect: [1, 2])
            args(c, 1, 2, expect: [1, 2])
        }.table, """
        | Args 0 | Args 1 | Args 2 | Expected |
        |--------|--------|--------|----------|
        | C      |      1 |      2 | [1, 2]   |
        | C      |      1 |      2 | [1, 2]   |
        """)
        
        assertEqualLines(assert(to: C.f3) {
            args(c, 1, 2, 3, expect: [1, 2, 3])
            args(c, 1, 2, 3, expect: [1, 2, 3])
        }.table, """
        | Args 0 | Args 1 | Args 2 | Args 3 | Expected  |
        |--------|--------|--------|--------|-----------|
        | C      |      1 |      2 |      3 | [1, 2, 3] |
        | C      |      1 |      2 |      3 | [1, 2, 3] |
        """)
        
        assertEqualLines(assert(to: C.f4) {
            args(c, 1, 2, 3, 4, expect: [1, 2, 3, 4])
            args(c, 1, 2, 3, 4, expect: [1, 2, 3, 4])
        }.table, """
        | Args 0 | Args 1 | Args 2 | Args 3 | Args 4 | Expected     |
        |--------|--------|--------|--------|--------|--------------|
        | C      |      1 |      2 |      3 |      4 | [1, 2, 3, 4] |
        | C      |      1 |      2 |      3 |      4 | [1, 2, 3, 4] |
        """)
    }
    
    func testCustomAssertion() {
        // TODO:
        assert(to: fizzBuzz, with: customAssertion) {
            args(1, expect: "1")
            args(2, expect: "2")
            args(3, expect: "Fizz")
            args(4, expect: "4")
            args(5, expect: "Buzz")
            args(6, expect: "Fizz")
            args(7, expect: "7")
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

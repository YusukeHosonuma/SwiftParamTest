//
//  BasicDSLTests.swift
//  SwiftParamTestTests
//
//  Created by Yusuke Hosonuma on 2020/03/12.
//

import SwiftParamTest
import XCTest

class BasicDSLTests: XCTestCase {
    override func setUp() {}

    override func tearDown() {}

    func testExample() {
        // function
        assertEqualLines(
            assert(to: fizzBuzz, header: ["n"], expect: [
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
            ] as [Row1<Int, String>]).table,
            """
            | n  | Expected |
            |----|----------|
            |  1 | 1        |
            |  2 | 2        |
            |  3 | Fizz     |
            |  4 | 4        |
            |  5 | Buzz     |
            |  6 | Fizz     |
            |  7 | 7        |
            |  8 | 8        |
            |  9 | Fizz     |
            | 10 | Buzz     |
            | 11 | 11       |
            | 12 | Fizz     |
            | 13 | 13       |
            | 14 | 14       |
            | 15 | FizzBuzz |
            """
        )

        // operator
        assertEqualLines(
            assert(to: +, header: ["lhs", "rhs"], expect: [
                args((1, 1), expect: 2),
                args((1, 2), expect: 3),
                args((2, 2), expect: 4),
            ]).table,
            """
            | lhs | rhs | Expected |
            |-----|-----|----------|
            |   1 |   1 |        2 |
            |   1 |   2 |        3 |
            |   2 |   2 |        4 |
            """
        )

        // instance method that has not argument
        assertEqualLines(
            assert(to: String.lowercased, header: ["string"], expect: [
                args("hello", expect: "hello"),
                args("HELLO", expect: "hello"),
            ]).table,
            """
            | string | Expected |
            |--------|----------|
            | hello  | hello    |
            | HELLO  | hello    |
            """
        )

        // instance method that has arguments
        assertEqualLines(
            assert(to: String.hasPrefix, header: ["string", "prefix"], expect: [
                args(("hello", "he"), expect: true),
                args(("hello", "HE"), expect: false),
            ]).table,
            """
            | string | prefix | Expected |
            |--------|--------|----------|
            | hello  | he     | true     |
            | hello  | HE     | false    |
            """
        )
        
        // instance method that receiver is fixed
        assertEqualLines(
            assert(to: "hello".hasPrefix, header: ["prefix"], expect: [
                args("he", expect: true),
                args("HE", expect: false),
            ]).table,
            """
            | prefix | Expected |
            |--------|----------|
            | he     | true     |
            | HE     | false    |
            """
        )
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
        
        assertEqualLines(assert(to: f1, expect: [
            args(1, expect: [1]),
            args(1, expect: [1]),
        ]).table, expectedTable1)
        
        assertEqualLines(assert(to: f2, expect: [
            args(1, 2, expect: [1, 2]),
            args(1, 2, expect: [1, 2]),
        ]).table, expectedTable2)
        
        assertEqualLines(assert(to: f3, expect: [
            args(1, 2, 3, expect: [1, 2, 3]),
            args(1, 2, 3, expect: [1, 2, 3]),
        ]).table, expectedTable3)
        
        assertEqualLines(assert(to: f4, expect: [
            args(1, 2, 3, 4, expect: [1, 2, 3, 4]),
            args(1, 2, 3, 4, expect: [1, 2, 3, 4]),
        ]).table, expectedTable4)
        
        // passed as `tuple`
        
        assertEqualLines(assert(to: f2, expect: [
            args((1, 2), expect: [1, 2]),
            args((1, 2), expect: [1, 2]),
        ]).table, expectedTable2)
        
        assertEqualLines(assert(to: f3, expect: [
            args((1, 2, 3), expect: [1, 2, 3]),
            args((1, 2, 3), expect: [1, 2, 3]),
        ]).table, expectedTable3)
        
        assertEqualLines(assert(to: f4, expect: [
            args((1, 2, 3, 4), expect: [1, 2, 3, 4]),
            args((1, 2, 3, 4), expect: [1, 2, 3, 4]),
        ]).table, expectedTable4)
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
        
        assertEqualLines(assert(to: C.f0, expect: [
            args(c, expect: 42),
            args(c, expect: 42),
        ]).table, """
        | Args 0 | Expected |
        |--------|----------|
        | C      |       42 |
        | C      |       42 |
        """)
        
        assertEqualLines(assert(to: C.f1, expect: [
            args(c, 1, expect: [1]),
            args(c, 1, expect: [1]),
        ]).table, """
        | Args 0 | Args 1 | Expected |
        |--------|--------|----------|
        | C      |      1 | [1]      |
        | C      |      1 | [1]      |
        """)
        
        assertEqualLines(assert(to: C.f2, expect: [
            args(c, 1, 2, expect: [1, 2]),
            args(c, 1, 2, expect: [1, 2]),
        ]).table, """
        | Args 0 | Args 1 | Args 2 | Expected |
        |--------|--------|--------|----------|
        | C      |      1 |      2 | [1, 2]   |
        | C      |      1 |      2 | [1, 2]   |
        """)
        
        assertEqualLines(assert(to: C.f3, expect: [
            args(c, 1, 2, 3, expect: [1, 2, 3]),
            args(c, 1, 2, 3, expect: [1, 2, 3]),
        ]).table, """
        | Args 0 | Args 1 | Args 2 | Args 3 | Expected  |
        |--------|--------|--------|--------|-----------|
        | C      |      1 |      2 |      3 | [1, 2, 3] |
        | C      |      1 |      2 |      3 | [1, 2, 3] |
        """)
        
        assertEqualLines(assert(to: C.f4, expect: [
            args(c, 1, 2, 3, 4, expect: [1, 2, 3, 4]),
            args(c, 1, 2, 3, 4, expect: [1, 2, 3, 4]),
        ]).table, """
        | Args 0 | Args 1 | Args 2 | Args 3 | Args 4 | Expected     |
        |--------|--------|--------|--------|--------|--------------|
        | C      |      1 |      2 |      3 |      4 | [1, 2, 3, 4] |
        | C      |      1 |      2 |      3 |      4 | [1, 2, 3, 4] |
        """)
    }

    func testCustomAssertion() {
        let spy = SpyCustomAssertion<Int>()
        
        assert(to: +, with: spy.assert, expect: [
            args(1, 1, expect: 2),
            args(1, 2, expect: 3),
        ])
        
        XCTAssertEqual(spy.args_assert, [
            SpyCustomAssertion.Assert(actual: 2, expected: 2),
            SpyCustomAssertion.Assert(actual: 3, expected: 3),
        ])
    }
}

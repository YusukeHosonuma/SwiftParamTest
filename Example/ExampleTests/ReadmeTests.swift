//
//  ExampleTests.swift
//  ExampleTests
//
//  Created by Yusuke Hosonuma on 2020/03/26.
//  Copyright © 2020 Yusuke Hosonuma. All rights reserved.
//

import SwiftParamTest
import XCTest

class ExampleTests: XCTestCase {
    override func setUp() {
        ParameterizedTest.option = ParameterizedTest.Option(traceTable: .markdown,
                                                            saveTableToAttachement: .markdown)
    }

    override func tearDown() {
        ParameterizedTest.option = ParameterizedTest.defaultOption
    }

    func testFunctionBuilderAPI() {
        assert(to: max) {
            args(1, 2, expect: 2)
            args(2, 1, expect: 2)
            args(4, 4, expect: 4)
        }

        // You can also use tuple (with label).
        assert(to: max) {
            args((x: 1, y: 2), expect: 2)
            args((x: 2, y: 1), expect: 2)
            args((x: 4, y: 4), expect: 4)
        }
    }

    func testLegacyAPI() {
        assert(to: max, expect: [
            args(1, 2, expect: 2),
            args(2, 1, expect: 2),
            args(4, 4, expect: 4),
        ])

        // You can also use tuple (with label).
        assert(to: max, expect: [
            args((x: 1, y: 2), expect: 2),
            args((x: 2, y: 1), expect: 2),
            args((x: 4, y: 4), expect: 4),
        ])
    }

    func testOperatorBasedAPI() {
        // Function Builder API
        assert(to: max) {
            expect((x: 1, y: 2) ==> 2)
            expect((x: 2, y: 1) ==> 2)
            expect((x: 4, y: 4) ==> 4)
        }

        // Legacy API
        assert(to: max, expect: [
            expect((x: 1, y: 2) ==> 2),
            expect((x: 2, y: 1) ==> 2),
            expect((x: 4, y: 4) ==> 4),
        ])
    }

    func testMarkdownTable() {
        assert(to: max, header: ["x", "y"]) {
            args(1, 2, expect: 2)
            args(2, 1, expect: 2)
            args(4, 4, expect: 4)
        }

        let tableString = assert(to: max, header: ["x", "y"]) {
            args(1, 2, expect: 2)
            args(2, 1, expect: 2)
            args(4, 4, expect: 4)
        }.table
        print(tableString)
        // =>
        // | x | y | Expected |
        // |---|---|----------|
        // | 1 | 2 |        2 |
        // | 2 | 1 |        2 |
        // | 4 | 4 |        4 |
    }

    func testExample() {
        // for `function`
        assert(to: abs) {
            args(0, expect: 0)
            args(2, expect: 2)
            args(-2, expect: 2)
        }

        // for `operator`
        assert(to: +) {
            args(1, 1, expect: 2)
            args(1, 2, expect: 3)
            args(2, 2, expect: 4)
        }

        // for `instance method` (when receiver is not fixed)
        assert(to: String.hasPrefix) {
            args("hello", "he", expect: true)
            args("hello", "HE", expect: false)
        }

        // for `instance method` (when receiver is fixed)
        assert(to: "hello".hasPrefix) {
            args("he", expect: true)
            args("HE", expect: false)
        }
    }

    func testFAQ() {
        // Legacy API
        assert(to: max, expect: [
            args(1, 2, expect: 2),
            args(2, 1, expect: 2),
            args(4, 4, expect: 4),
        ] as [Row2<Int, Int, Int>]) // `N` in `RowN` is arguments count

        // Function Builder API
        typealias T = Int
        assert(to: max) {
            args(1 as T, 2 as T, expect: 2)
            args(2 as T, 1 as T, expect: 2)
            args(4 as T, 4 as T, expect: 4)
        }
    }
}

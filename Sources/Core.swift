//
// Core.swift
// SwiftParamTest
//
// Created by Yusuke Hosonuma on 2020/02/28.
// Copyright (c) 2020 Yusuke Hosonuma.
//

import XCTest

public typealias CustomAssertion<T: Equatable> = (_ expected: T, _ actual: T, _ file: StaticString, _ line: UInt) -> Void

public struct Row<T, R> {
    var args: T
    var expect: R
    var file: StaticString
    var line: UInt

    init(args: T, expect: R, file: StaticString = #file, line: UInt = #line) {
        self.args = args
        self.expect = expect
        self.file = file
        self.line = line
    }
}

public struct ParameterizedTest<T, R> where R: Equatable {
    var target: (T) -> R
    var header: [String] = []
    var customAssertion: CustomAssertion<R>?
}

extension ParameterizedTest {
    public func execute(with rows: [Row<T, R>]) {
        for row in rows {
            let result = target(row.args)

            if let assertion = customAssertion {
                assertion(row.expect, result, row.file, row.line)
            } else {
                let message = "Expect to '\(row.expect)' but '\(result)'"
                XCTAssert(row.expect == result, message, file: row.file, line: row.line)
            }
        }
    }
}

//
// Core.swift
// SwiftParamTest
//
// Created by Yusuke Hosonuma on 2020/02/28.
// Copyright (c) 2020 Yusuke Hosonuma.
//

import XCTest

public typealias Assertion<T: Equatable> = (_ expected: T, _ actual: T, _ file: StaticString, _ line: UInt) -> Void

public struct Row<T, R> {
    var args: T
    var expect: R
    var file: StaticString
    var line: UInt

    init(when: T, expect: R, file: StaticString = #file, line: UInt = #line) {
        args = when
        self.expect = expect
        self.file = file
        self.line = line
    }
}

public struct Expect<T, R> where R: Equatable {
    var f: (T) -> R
    var customAssertion: Assertion<R>?
}

extension Expect {
    public func expect(_ rows: [Row<T, R>]) {
        for row in rows {
            let result = f(row.args)
            let message = "Expect to '\(row.expect)' but '\(result)'"
            if let assertion = customAssertion {
                assertion(row.expect, result, row.file, row.line)
            } else {
                XCTAssert(row.expect == result, message, file: row.file, line: row.line)
            }
        }
    }
}

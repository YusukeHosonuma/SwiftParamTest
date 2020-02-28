//
// Core.swift
// SwiftParamTest
//
// Created by Yusuke Hosonuma on 2020/02/28.
// Copyright (c) 2020 Yusuke Hosonuma.
//

import XCTest

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
}

extension Expect {
    public func forAll(_ rows: [Row<T, R>]) {
        for row in rows {
            let result = f(row.args)
            let message = "Expect to '\(row.expect)' but '\(result)'"
            XCTAssert(row.expect == result, message, file: row.file, line: row.line)
        }
    }
}

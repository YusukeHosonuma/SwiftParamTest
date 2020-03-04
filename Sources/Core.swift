//
// Core.swift
// SwiftParamTest
//
// Created by Yusuke Hosonuma on 2020/02/28.
// Copyright (c) 2020 Yusuke Hosonuma.
//

import XCTest

public typealias Assertion<T: Equatable> = (_ expected: T, _ actual: T, _ file: StaticString, _ line: UInt) -> Void

public struct Row<INPUT, EXPECT> {
    var inputParams: INPUT
    var expect: EXPECT
    var file: StaticString
    var line: UInt

    init(inputParams: INPUT, expect: EXPECT, file: StaticString = #file, line: UInt = #line) {
        self.inputParams = inputParams
        self.expect = expect
        self.file = file
        self.line = line
    }
}

public struct Expect<INPUT, RESULT> where RESULT: Equatable {
    var targetFunction: (INPUT) -> RESULT
    var customAssertion: Assertion<RESULT>?
}

extension Expect {
    public func expect(_ rows: [Row<INPUT, RESULT>]) {
        for row in rows {
            let result = targetFunction(row.inputParams)

            if let assertion = customAssertion {
                assertion(row.expect, result, row.file, row.line)
            } else {
                let message = "Expect to '\(row.expect)' but '\(result)'"
                XCTAssert(row.expect == result, message, file: row.file, line: row.line)
            }
        }
    }
}

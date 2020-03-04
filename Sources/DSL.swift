//
// DSL.swift
// SwiftParamTest
//
// Created by Yusuke Hosonuma on 2020/02/26.
// Copyright (c) 2020 Yusuke Hosonuma.
//

import XCTest

/// Create `Expect` for start parameterized-test.
/// - Parameters:
///   - targetFunction: test target function
///   - customAssertion: custom assertion function
public func assert<INPUT, RESULT: Equatable>(to targetFunction: @escaping (INPUT) -> RESULT,
                                             with customAssertion: Assertion<RESULT>? = nil) -> Expect<INPUT, RESULT> {
    Expect(targetFunction: targetFunction, customAssertion: customAssertion)
}

/// Definition test parameter and expected value.
/// - Parameters:
///   - inputParams: input parameters of test target function
///   - expect: expected value
///   - file: #file
///   - line: #line
public func when<INPUT, EXPECT>(_ inputParams: INPUT,
                                then expect: EXPECT,
                                file: StaticString = #file,
                                line: UInt = #line) -> Row<INPUT, EXPECT> {
    Row(inputParams: inputParams, expect: expect, file: file, line: line)
}

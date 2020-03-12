//
// DSL.swift
// SwiftParamTest
//
// Created by Yusuke Hosonuma on 2020/02/26.
// Copyright (c) 2020 Yusuke Hosonuma.
//

// Note:
// Function Builder is supported by Swift 5.1 or later.

// MARK: - Operators

precedencegroup ExpectRowPrecedence {
    lowerThan: FunctionArrowPrecedence
}

infix operator ==>: ExpectRowPrecedence

/// Create expectation row.
/// - Parameters:
///   - lhs: parameters of test target function
///   - rhs: expected value
@available(swift 5.1)
public func ==> <T, R>(lhs: T, rhs: R) -> ExpectRow<T, R> {
    ExpectRow(args: lhs, expect: rhs)
}

@available(swift 5.1)
public struct ExpectRow<T, R> {
    var args: T
    var expect: R
}

// MARK: - Function Builders

@available(swift 5.1)
@_functionBuilder
public struct ParameterBuilder<T, R> {
    public static func buildBlock(_ rows: Row<T, R>...) -> [Row<T, R>] {
        rows
    }
}

// MARK: - DSL

/// Create `Expect` for start parameterized-test.
/// - Parameters:
///   - targetFunction: test target function
///   - customAssertion: custom assertion function
@available(swift 5.1)
public func assert<T, R: Equatable>(
    to targetFunction: @escaping (T) -> R,
    with customAssertion: CustomAssertion<R>? = nil,
    @ParameterBuilder <T, R> rows: () -> [Row<T, R>]
) {
    ParameterizedTest(target: targetFunction, customAssertion: customAssertion).execute(with: rows())
}

@available(swift 5.1)
public func expect<T, R>(
    _ row: ExpectRow<T, R>,
    file: StaticString = #file,
    line: UInt = #line
) -> Row<T, R> {
    Row(args: row.args, expect: row.expect, file: file, line: line)
}

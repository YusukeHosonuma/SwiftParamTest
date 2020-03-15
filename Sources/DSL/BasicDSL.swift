//
//  BasicDSL.swift
//  SwiftParamTest
//
//  Created by Yusuke Hosonuma on 2020/03/12.
//

// MARK: - Basic API

/// Assert to `target` function with `rows` parameters.
/// - Parameters:
///   - target: test target function or operator
///   - customAssertion: custom assert function (default: `XCTAssertEqual`)
///   - rows: test parameteres
public func assert<T, R: Equatable>(
    to target: @escaping (T) -> R,
    with customAssertion: CustomAssertion<R>? = nil,
    expect rows: [Row<T, R>]
) {
    ParameterizedTest(target: target,
                      customAssertion: customAssertion).execute(with: rows)
}

/// Assert to `target` function with `rows` parameters.
/// - Parameters:
///   - instanceMethod: test target instance methods
///   - customAssertion: custom assert function (default: `XCTAssertEqual`)
///   - rows: test parameteres
public func assert<T, R: Equatable>(
    to instanceMethod: @escaping (T) -> () -> R,
    with customAssertion: CustomAssertion<R>? = nil,
    expect rows: [Row<T, R>]
) {
    ParameterizedTest(target: flatten(instanceMethod),
                      customAssertion: customAssertion).execute(with: rows)
}

/// Assert to `target` function with `rows` parameters.
/// - Parameters:
///   - instanceMethod: test target instance methods
///   - customAssertion: custom assert function (default: `XCTAssertEqual`)
///   - rows: test parameteres
public func assert<T1, T2, R: Equatable>(
    to instanceMethod: @escaping (T1) -> (T2) -> R,
    with customAssertion: CustomAssertion<R>? = nil,
    expect rows: [Row<(T1, T2), R>]
) {
    ParameterizedTest(target: flatten(instanceMethod),
                      customAssertion: customAssertion).execute(with: rows)
}

/// Definition test parameter and expected value.
/// - Parameters:
///   - args: parameters of test target function
///   - expect: expected value
///   - file: #file
///   - line: #line
public func args<T, R>(_ args: T,
                       expect: R,
                       file: StaticString = #file,
                       line: UInt = #line) -> Row<T, R> {
    Row(args: args, expect: expect, file: file, line: line)
}

// MARK: - Operator based API

precedencegroup ExpectRowPrecedence {
    lowerThan: FunctionArrowPrecedence
}

infix operator ==>: ExpectRowPrecedence

/// Create expectation row.
/// - Parameters:
///   - lhs: parameters of test target function
///   - rhs: expected value
public func ==> <T, R>(lhs: T, rhs: R) -> ExpectRow<T, R> {
    ExpectRow(args: lhs, expect: rhs)
}

public struct ExpectRow<T, R> {
    var args: T
    var expect: R
}

public func expect<T, R>(
    _ row: ExpectRow<T, R>,
    file: StaticString = #file,
    line: UInt = #line
) -> Row<T, R> {
    Row(args: row.args, expect: row.expect, file: file, line: line)
}

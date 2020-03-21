//
//  Operator.swift
//  SwiftParamTest
//
//  Created by Yusuke Hosonuma on 2020/03/21.
//

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

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

// MARK: - Operator

public func ==> <T1, R>(lhs: T1, rhs: R) -> Row1<T1, R> {
    Row1(args: lhs, expect: rhs, file: "", line: 0)
}

public func ==> <T1, T2, R>(lhs: (T1, T2), rhs: R) -> Row2<T1, T2, R> {
    Row2(args: lhs, expect: rhs, file: "", line: 0)
}

public func ==> <T1, T2, T3, R>(lhs: (T1, T2, T3), rhs: R) -> Row3<T1, T2, T3, R> {
    Row3(args: lhs, expect: rhs, file: "", line: 0)
}

public func ==> <T1, T2, T3, T4, R>(lhs: (T1, T2, T3, T4), rhs: R) -> Row4<T1, T2, T3, T4, R> {
    Row4(args: lhs, expect: rhs, file: "", line: 0)
}

// MARK: - expect()

public func expect<T1, R>(
    _ row: Row1<T1, R>,
    file: StaticString = #file,
    line: UInt = #line
) -> Row1<T1, R> {
    Row1(args: row.args, expect: row.expect, file: file, line: line)
}

public func expect<T1, T2, R>(
    _ row: Row2<T1, T2, R>,
    file: StaticString = #file,
    line: UInt = #line
) -> Row2<T1, T2, R> {
    Row2(args: row.args, expect: row.expect, file: file, line: line)
}

public func expect<T1, T2, T3, R>(
    _ row: Row3<T1, T2, T3, R>,
    file: StaticString = #file,
    line: UInt = #line
) -> Row3<T1, T2, T3, R> {
    Row3(args: row.args, expect: row.expect, file: file, line: line)
}

public func expect<T1, T2, T3, T4, R>(
    _ row: Row4<T1, T2, T3, T4, R>,
    file: StaticString = #file,
    line: UInt = #line
) -> Row4<T1, T2, T3, T4, R> {
    Row4(args: row.args, expect: row.expect, file: file, line: line)
}

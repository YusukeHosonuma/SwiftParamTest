//
//  Assertion.swift
//  SwiftParamTest
//
//  Created by Yusuke Hosonuma on 2020/03/29.
//

public protocol Assertion {
    func assertEqual<T: Equatable>(
        expression: () throws -> T,
        expect: T,
        header: [String]?,
        columns: [Any],
        file: StaticString,
        line: UInt
    )

    func assertThrowError<T, E: Equatable>(
        expression: () throws -> T,
        expectError: E,
        header: [String]?,
        columns: [Any],
        file: StaticString,
        line: UInt
    )
}

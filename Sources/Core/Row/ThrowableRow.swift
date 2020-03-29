//
//  ThrowableRow.swift
//  SwiftParamTest
//
//  Created by Yusuke Hosonuma on 2020/03/29.
//

import SHList

public struct ErrorRow2<T1, T2, R, E> where E: Equatable {
    public var args: HList2<T1, T2>
    public var expectError: E
    public var target: ((T1, T2) throws -> R)!
    public var file: StaticString
    public var line: UInt
}

extension ErrorRow2: ParameterRow {
    public var columns: [Any] {
        args.asArray() + [expectError]
    }

    public func evalute(assertion: Assertion, header: [String]?) {
        assertion.assertThrowError(
            expression: { () throws -> R in try args.apply(target) },
            expectError: expectError,
            header: header,
            columns: columns,
            file: file,
            line: line
        )
    }
}

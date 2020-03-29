//
//  EqualRow.swift
//  SwiftParamTest
//
//  Created by Yusuke Hosonuma on 2020/03/29.
//

import SHList

public struct ERow2<T1, T2, R>: ParameterRow where R: Equatable {
    public typealias Function = ((T1, T2) throws -> R)

    public var args: HList2<T1, T2>
    public var expect: R
    public var target: ((T1, T2) throws -> R)!
    public var file: StaticString
    public var line: UInt

    public var columns: [Any] {
        args.asArray() + [expect]
    }

    public func evalute(assertion: Assertion, header: [String]?) {
        assertion.assertEqual(
            expression: { () throws -> R in try args.apply(target) },
            expect: expect,
            header: header,
            columns: columns,
            file: file,
            line: line
        )
    }
}

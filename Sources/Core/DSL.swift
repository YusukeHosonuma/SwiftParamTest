//
//  DSL.swift
//  SwiftParamTest
//
//  Created by Yusuke Hosonuma on 2020/03/29.
//

import XCTest

@available(swift 5.1)
@_functionBuilder
public struct NewBuilder2<T1, T2, Return> {
    public static func buildBlock<R1: ParameterRow, R2: ParameterRow>(_ t1: R1, _ t2: R2) -> [AnyParameterRow<T1, T2, Return>] {
        [
            AnyParameterRow<T1, T2, Return>(evalute: t1.evalute, columns: t1.columns),
            AnyParameterRow<T1, T2, Return>(evalute: t2.evalute, columns: t2.columns),
        ]
    }
}

extension XCTestCase {
    // MARK: has 2 arguments

    @discardableResult
    @available(swift 5.1)
    public func assert2<T1, T2, Return>(
        to function: @escaping (T1, T2) throws -> Return,
        header: [String]? = nil,
        with customAssertion: Assertion? = nil,
        @NewBuilder2 <T1, T2, Return> builder: () -> [AnyParameterRow<T1, T2, Return>]
    ) -> ParameterizedTestResult where Return: Equatable {
        let evrows: [EvalutableRow3] = builder().map {
            var row = $0
            row.target = function
            return EvalutableRow3(columns: row.columns, evalute: $0.evalute)
        }

        let runner = ParameterizedTestRunner2(runner: self,
                                              header: header,
                                              assertion: customAssertion)
        return runner.execute(with: evrows)
    }
}

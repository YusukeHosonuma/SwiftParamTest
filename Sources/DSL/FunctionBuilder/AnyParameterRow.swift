//
//  AnyParameterRow.swift
//  SwiftParamTest
//
//  Created by Yusuke Hosonuma on 2020/03/29.
//

public struct AnyParameterRow<T1, T2, Return> {
    var target: ((T1, T2) throws -> Return)!
    var evalute: (Assertion, [String]?) -> Void
    var columns: [Any]
}

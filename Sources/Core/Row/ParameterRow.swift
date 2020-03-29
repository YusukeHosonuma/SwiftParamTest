//
//  ParameterRow.swift
//  SwiftParamTest
//
//  Created by Yusuke Hosonuma on 2020/03/29.
//

import Foundation

public protocol ParameterRow {
    associatedtype Function

    var columns: [Any] { get }
    var target: Function! { get }
    func evalute(assertion: Assertion, header: [String]?)
}

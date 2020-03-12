//
//  BasicDSL.swift
//  SwiftParamTest
//
//  Created by Yusuke Hosonuma on 2020/03/12.
//

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
    ParameterizedTest(target: target, customAssertion: customAssertion).execute(with: rows)
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

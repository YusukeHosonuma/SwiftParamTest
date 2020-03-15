//
// DSL.swift
// SwiftParamTest
//
// Created by Yusuke Hosonuma on 2020/02/26.
// Copyright (c) 2020 Yusuke Hosonuma.
//

// Note:
// Function Builder is supported by Swift 5.1 or later.

@available(swift 5.1)
@_functionBuilder
public struct ParameterBuilder<T, R> {
    public static func buildBlock(_ rows: Row<T, R>...) -> [Row<T, R>] {
        rows
    }
}

/// Create `Expect` for start parameterized-test.
/// - Parameters:
///   - targetFunction: test target function
///   - customAssertion: custom assertion function
@available(swift 5.1)
public func assert<T, R: Equatable>(
    to function: @escaping (T) -> R,
    with customAssertion: CustomAssertion<R>? = nil,
    @ParameterBuilder <T, R> rows: () -> [Row<T, R>]
) {
    ParameterizedTest(target: function, customAssertion:
        customAssertion).execute(with: rows())
}

/// Create `Expect` for start parameterized-test.
/// - Parameters:
///   - instanceMethod: test target instance method
///   - customAssertion: custom assertion function
@available(swift 5.1)
public func assert<T, R: Equatable>(
    to instanceMethod: @escaping (T) -> () -> R,
    with customAssertion: CustomAssertion<R>? = nil,
    @ParameterBuilder <T, R> rows: () -> [Row<T, R>]
) {
    ParameterizedTest(target: flatten(instanceMethod),
                      customAssertion: customAssertion).execute(with: rows())
}

/// Create `Expect` for start parameterized-test.
/// - Parameters:
///   - instanceMethod: test target instance method
///   - customAssertion: custom assertion function
@available(swift 5.1)
public func assert<T1, T2, R: Equatable>(
    to instanceMethod: @escaping (T1) -> (T2) -> R,
    with customAssertion: CustomAssertion<R>? = nil,
    @ParameterBuilder <(T1, T2), R> rows: () -> [Row<(T1, T2), R>]
) {
    ParameterizedTest(target: flatten(instanceMethod),
                      customAssertion: customAssertion).execute(with: rows())
}

//
//  ResultBuilderDSLAssert.swift
//  SwiftParamTest
//
//  Created by Yusuke Hosonuma on 2020/03/21.
//

import Flatten
import XCTest

extension XCTestCase {
    // MARK: has 1 arguments

    @discardableResult
    @available(swift 5.1)
    public func assert<T1, R>(
        to function: @escaping (T1) -> R,
        header: [String]? = nil,
        with customAssertion: CustomAssertion<R>? = nil,
        @ParameterBuilder1 <T1, R> builder: () -> [Row1<T1, R>]
    ) -> ParameterizedTestResult where R: Equatable {
        let rows: [Row1<T1, R>] = builder().map {
            var row = $0
            row.target = function
            row.customAssertion = customAssertion
            return row
        }
        return ParameterizedTestRunner(runner: self, header: header).execute(with: rows)
    }

    // MARK: has 2 arguments

    @discardableResult
    @available(swift 5.1)
    public func assert<T1, T2, R>(
        to function: @escaping (T1, T2) -> R,
        header: [String]? = nil,
        with customAssertion: CustomAssertion<R>? = nil,
        @ParameterBuilder2 <T1, T2, R> builder: () -> [Row2<T1, T2, R>]
    ) -> ParameterizedTestResult where R: Equatable {
        let rows: [Row2<T1, T2, R>] = builder().map {
            var row = $0
            row.target = function
            row.customAssertion = customAssertion
            return row
        }
        return ParameterizedTestRunner(runner: self, header: header).execute(with: rows)
    }

    // MARK: has 3 arguments

    @discardableResult
    @available(swift 5.1)
    public func assert<T1, T2, T3, R>(
        to function: @escaping (T1, T2, T3) -> R,
        header: [String]? = nil,
        with customAssertion: CustomAssertion<R>? = nil,
        @ParameterBuilder3 <T1, T2, T3, R> builder: () -> [Row3<T1, T2, T3, R>]
    ) -> ParameterizedTestResult where R: Equatable {
        let rows: [Row3<T1, T2, T3, R>] = builder().map {
            var row = $0
            row.target = function
            row.customAssertion = customAssertion
            return row
        }
        return ParameterizedTestRunner(runner: self, header: header).execute(with: rows)
    }

    // MARK: has 4 arguments

    @discardableResult
    @available(swift 5.1)
    public func assert<T1, T2, T3, T4, R>(
        to function: @escaping (T1, T2, T3, T4) -> R,
        header: [String]? = nil,
        with customAssertion: CustomAssertion<R>? = nil,
        @ParameterBuilder4 <T1, T2, T3, T4, R> builder: () -> [Row4<T1, T2, T3, T4, R>]
    ) -> ParameterizedTestResult where R: Equatable {
        let rows: [Row4<T1, T2, T3, T4, R>] = builder().map {
            var row = $0
            row.target = function
            row.customAssertion = customAssertion
            return row
        }
        return ParameterizedTestRunner(runner: self, header: header).execute(with: rows)
    }
}

// MARK: Instance method

extension XCTestCase {
    // MARK: has no arguments

    @discardableResult
    @available(swift 5.1)
    public func assert<V, R>(
        to function: @escaping (V) -> () -> R,
        header: [String]? = nil,
        with customAssertion: CustomAssertion<R>? = nil,
        @ParameterBuilder1 <V, R> builder: () -> [Row1<V, R>]
    ) -> ParameterizedTestResult where R: Equatable {
        let rows: [Row1<V, R>] = builder().map {
            var row = $0
            row.target = flatten(function)
            row.customAssertion = customAssertion
            return row
        }
        return ParameterizedTestRunner(runner: self, header: header).execute(with: rows)
    }

    // MARK: has 1 arguments

    @discardableResult
    @available(swift 5.1)
    public func assert<V, T1, R>(
        to function: @escaping (V) -> (T1) -> R,
        header: [String]? = nil,
        with customAssertion: CustomAssertion<R>? = nil,
        @ParameterBuilder2 <V, T1, R> builder: () -> [Row2<V, T1, R>]
    ) -> ParameterizedTestResult where R: Equatable {
        let rows: [Row2<V, T1, R>] = builder().map {
            var row = $0
            row.target = flatten(function)
            row.customAssertion = customAssertion
            return row
        }
        return ParameterizedTestRunner(runner: self, header: header).execute(with: rows)
    }

    // MARK: has 2 arguments

    @discardableResult
    @available(swift 5.1)
    public func assert<V, T1, T2, R>(
        to function: @escaping (V) -> (T1, T2) -> R,
        header: [String]? = nil,
        with customAssertion: CustomAssertion<R>? = nil,
        @ParameterBuilder3 <V, T1, T2, R> builder: () -> [Row3<V, T1, T2, R>]
    ) -> ParameterizedTestResult where R: Equatable {
        let rows: [Row3<V, T1, T2, R>] = builder().map {
            var row = $0
            row.target = flatten(function)
            row.customAssertion = customAssertion
            return row
        }
        return ParameterizedTestRunner(runner: self, header: header).execute(with: rows)
    }

    // MARK: has 3 arguments

    @discardableResult
    @available(swift 5.1)
    public func assert<V, T1, T2, T3, R>(
        to function: @escaping (V) -> (T1, T2, T3) -> R,
        header: [String]? = nil,
        with customAssertion: CustomAssertion<R>? = nil,
        @ParameterBuilder4 <V, T1, T2, T3, R> builder: () -> [Row4<V, T1, T2, T3, R>]
    ) -> ParameterizedTestResult where R: Equatable {
        let rows: [Row4<V, T1, T2, T3, R>] = builder().map {
            var row = $0
            row.target = flatten(function)
            row.customAssertion = customAssertion
            return row
        }
        return ParameterizedTestRunner(runner: self, header: header).execute(with: rows)
    }

    // MARK: has 4 arguments

    @discardableResult
    @available(swift 5.1)
    public func assert<V, T1, T2, T3, T4, R>(
        to function: @escaping (V) -> (T1, T2, T3, T4) -> R,
        header: [String]? = nil,
        with customAssertion: CustomAssertion<R>? = nil,
        @ParameterBuilder5 <V, T1, T2, T3, T4, R> builder: () -> [Row5<V, T1, T2, T3, T4, R>]
    ) -> ParameterizedTestResult where R: Equatable {
        let rows: [Row5<V, T1, T2, T3, T4, R>] = builder().map {
            var row = $0
            row.target = flatten(function)
            row.customAssertion = customAssertion
            return row
        }
        return ParameterizedTestRunner(runner: self, header: header).execute(with: rows)
    }
}

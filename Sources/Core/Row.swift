//
//  Row.swift
//  SwiftParamTest
//
//  Created by Yusuke Hosonuma on 2020/03/21.
//

public protocol EvalutableRow {
    associatedtype ReturnType: Equatable

    var expect: ReturnType { get }
    var file: StaticString { get }
    var line: UInt { get }
    var customAssertion: CustomAssertion<ReturnType>? { get }
    var columns: [Any] { get }

    func evalute() -> ReturnType
}

// MARK: - Rows

public struct Row1<T1, R> where R: Equatable {
    public var args: T1
    public var expect: R
    public var target: ((T1) -> R)!
    public var file: StaticString
    public var line: UInt
    public var customAssertion: CustomAssertion<R>?
}

public struct Row2<T1, T2, R> where R: Equatable {
    public var args: (T1, T2)
    public var expect: R
    public var target: ((T1, T2) -> R)!
    public var file: StaticString
    public var line: UInt
    public var customAssertion: CustomAssertion<R>?
}

public struct Row3<T1, T2, T3, R> where R: Equatable {
    public var args: (T1, T2, T3)
    public var expect: R
    public var target: ((T1, T2, T3) -> R)!
    public var file: StaticString
    public var line: UInt
    public var customAssertion: CustomAssertion<R>?
}

public struct Row4<T1, T2, T3, T4, R> where R: Equatable {
    public var args: (T1, T2, T3, T4)
    public var expect: R
    public var target: ((T1, T2, T3, T4) -> R)!
    public var file: StaticString
    public var line: UInt
    public var customAssertion: CustomAssertion<R>?
}

public struct Row5<T1, T2, T3, T4, T5, R> where R: Equatable {
    public var args: (T1, T2, T3, T4, T5)
    public var expect: R
    public var target: ((T1, T2, T3, T4, T5) -> R)!
    public var file: StaticString
    public var line: UInt
    public var customAssertion: CustomAssertion<R>?
}

// MARK: - Implement `EvalutableRow`

extension Row1: EvalutableRow {
    public typealias ReturnType = R

    public var columns: [Any] {
        [args, expect]
    }

    public func evalute() -> R {
        target(args)
    }
}

extension Row2: EvalutableRow {
    public typealias ReturnType = R

    public var columns: [Any] {
        [args.0, args.1, expect]
    }

    public func evalute() -> R {
        target(args.0, args.1)
    }
}

extension Row3: EvalutableRow {
    public typealias ReturnType = R

    public var columns: [Any] {
        [args.0, args.1, args.2, expect]
    }

    public func evalute() -> R {
        target(args.0, args.1, args.2)
    }
}

extension Row4: EvalutableRow {
    public typealias ReturnType = R

    public var columns: [Any] {
        [args.0, args.1, args.2, args.3, expect]
    }

    public func evalute() -> R {
        target(args.0, args.1, args.2, args.3)
    }
}

extension Row5: EvalutableRow {
    public typealias ReturnType = R

    public var columns: [Any] {
        [args.0, args.1, args.2, args.3, args.4, expect]
    }

    public func evalute() -> R {
        target(args.0, args.1, args.2, args.3, args.4)
    }
}

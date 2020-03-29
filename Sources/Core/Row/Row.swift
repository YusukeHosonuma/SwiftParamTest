//
//  Row.swift
//  SwiftParamTest
//
//  Created by Yusuke Hosonuma on 2020/03/21.
//

import SHList

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
    public var args: HList1<T1>
    public var expect: R
    public var target: ((T1) -> R)!
    public var file: StaticString
    public var line: UInt
    public var customAssertion: CustomAssertion<R>?
}

public struct Row2<T1, T2, R> where R: Equatable {
    public var args: HList2<T1, T2>
    public var expect: R
    public var target: ((T1, T2) -> R)!
    public var file: StaticString
    public var line: UInt
    public var customAssertion: CustomAssertion<R>?
}

public struct Row3<T1, T2, T3, R> where R: Equatable {
    public var args: HList3<T1, T2, T3>
    public var expect: R
    public var target: ((T1, T2, T3) -> R)!
    public var file: StaticString
    public var line: UInt
    public var customAssertion: CustomAssertion<R>?
}

public struct Row4<T1, T2, T3, T4, R> where R: Equatable {
    public var args: HList4<T1, T2, T3, T4>
    public var expect: R
    public var target: ((T1, T2, T3, T4) -> R)!
    public var file: StaticString
    public var line: UInt
    public var customAssertion: CustomAssertion<R>?
}

public struct Row5<T1, T2, T3, T4, T5, R> where R: Equatable {
    public var args: HList5<T1, T2, T3, T4, T5>
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
        args.asArray() + [expect]
    }

    public func evalute() -> R {
        args.apply(target)
    }
}

extension Row2: EvalutableRow {
    public typealias ReturnType = R

    public var columns: [Any] {
        args.asArray() + [expect]
    }

    public func evalute() -> R {
        args.apply(target)
    }
}

extension Row3: EvalutableRow {
    public typealias ReturnType = R

    public var columns: [Any] {
        args.asArray() + [expect]
    }

    public func evalute() -> R {
        args.apply(target)
    }
}

extension Row4: EvalutableRow {
    public typealias ReturnType = R

    public var columns: [Any] {
        args.asArray() + [expect]
    }

    public func evalute() -> R {
        args.apply(target)
    }
}

extension Row5: EvalutableRow {
    public typealias ReturnType = R

    public var columns: [Any] {
        args.asArray() + [expect]
    }

    public func evalute() -> R {
        args.apply(target)
    }
}

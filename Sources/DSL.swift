//
//  DSL.swift
//  SwiftParamTest
//
//  Created by Yusuke Hosonuma on 2019/04/16.
//

import XCTest

public func assert<T, R: Equatable>(_ f: @escaping (T) -> R) -> Expect<T, R> {
    return Expect(f: f)
}

public func when<T, R>(_ when: T,
                       then: R,
                       file: StaticString = #file,
                       line: UInt = #line) -> Row<T, R> {
    return Row(when: when, expect: then, file: file, line: line)
}

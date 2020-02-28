//
// DSL.swift
// SwiftParamTest
//
// Created by Yusuke Hosonuma on 2020/02/26.
// Copyright (c) 2020 Yusuke Hosonuma.
//

import XCTest

public func assert<T, R: Equatable>(_ f: @escaping (T) -> R) -> Expect<T, R> {
    Expect(f: f)
}

public func when<T, R>(_ when: T,
                       then: R,
                       file: StaticString = #file,
                       line: UInt = #line) -> Row<T, R> {
    Row(when: when, expect: then, file: file, line: line)
}

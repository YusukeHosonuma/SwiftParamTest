//
//  Core.swift
//  SwiftParamTest
//
//  Created by Yusuke Hosonuma on 2019/04/15.
//

import XCTest

public struct Row<T, R> {
    var args: T
    var expect: R
    var file: StaticString
    var line: UInt

    public init(when: T, expect: R, file: StaticString = #file, line: UInt = #line) {
        self.args = when
        self.expect = expect
        self.file = file
        self.line = line
    }
}

public struct Expect<T, R> where R: Equatable {
    public var f: (T) -> R

    public init (f: @escaping (T) -> R) {
        self.f = f
    }
    
    public func forAll(_ rows: [Row<T, R>]) {
        for row in rows {
            let result = f(row.args)
            let message = "Expect to '\(row.expect)' but got '\(result)'"
            XCTAssert(row.expect == result, message ,file: row.file, line: row.line)
        }
    }
}

public func assert<T, R: Equatable>(_ f: @escaping (T) -> R) -> Expect<T, R> {
    return Expect(f: f)
}

public func when<T, R>(_ when: T,
                       then: R,
                       file: StaticString = #file,
                       line: UInt = #line) -> Row<T, R> {
    return Row(when: when, expect: then, file: file, line: line)
}

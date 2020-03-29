//
//  XCTAssertion.swift
//  SwiftParamTest
//
//  Created by Yusuke Hosonuma on 2020/03/29.
//

import XCTest

final class XCTAssertion: Assertion {
    func assertEqual<T: Equatable>(
        expression: () throws -> T,
        expect: T,
        header: [String]?,
        columns: [Any],
        file: StaticString,
        line: UInt
    ) {
        let actual = try! expression() // TODO:

        var additionalMessage: String = ""

        if let header = header {
            additionalMessage = " (when "
                + zip(header, columns).map { "\($0): '\($1)'" }.joined(separator: ", ")
                + ")"
        }

        let message = ""
            + "Expect to '\(expect)' but '\(actual)'"
            + additionalMessage

        XCTAssert(expect == actual, message, file: file, line: line)
    }

    func assertThrowError<T, E: Equatable>(
        expression: () throws -> T,
        expectError: E,
        header _: [String]?,
        columns _: [Any],
        file: StaticString,
        line: UInt
    ) {
        do {
            let actual = try expression()
            XCTFail("error is not throw, got \(actual)", file: file, line: line)
        } catch {
            if let error = error as? E {
                XCTAssert(error == expectError, "expected \(expectError) got \(error)", file: file, line: line)
            } else {
                XCTFail("!!!") // TODO:
            }
        }
    }
}

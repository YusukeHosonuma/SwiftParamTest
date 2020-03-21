//
//  ParameterizedTestRunner.swift
//  SwiftParamTest
//
//  Created by Yusuke Hosonuma on 2020/03/21.
//

import XCTest

public class ParameterizedTestZ {
    public struct Option {
        var saveMarkdownTable: Bool
    }

    public static var option = Option(saveMarkdownTable: true) // TODO: Firebase 見習う？（あとテストする）
}

public class ParameterizedTestRunner<T: EvalutableRow> {
    let runner: XCTestCase
    let header: [String]?

    init(runner: XCTestCase, header: [String]?) {
        self.runner = runner
        self.header = header
    }

    @discardableResult
    final func execute(with rows: [T]) -> ParameterizedTestResult {
        precondition(rows.count > 0, "`rows` are empty.")
        if let header = header {
            precondition(
                rows.allSatisfy { $0.columns.count == header.count + 1 }, // not include `Expect` column in `header`
                "Columns count are not equal between `header` and `rows`."
            )
        }

        for row in rows {
            let result = row.evalute()

            if let assertion = row.customAssertion {
                assertion(row.expect, result, row.file, row.line)
            } else {
                var message: String?

                if row.expect != result {
                    var additionalMessage: String = ""

                    if let header = header {
                        additionalMessage = " (when "
                            + zip(header, row.columns).map { "\($0): '\($1)'" }.joined(separator: ", ")
                            + ")"
                    }

                    message = ""
                        + "Expect to '\(row.expect)' but '\(result)'"
                        + additionalMessage
                }

                executeAssert(row: row, result: result, message: message)
            }
        }

        let tableHeader = header ?? (0 ..< rows.first!.columns.count - 1).map { "Args \($0)" }

        let table = try! generateMarkdownTable(header: tableHeader + ["Expected"],
                                               rows: rows.map { $0.columns })

        print("🍎")
        print(table)
        saveAttachement(runner, content: table)

        return ParameterizedTestResult(table: table)
    }

    // MARK: - Overridable

    func executeAssert(row: T, result: T.ReturnType, message: String?) {
        if let message = message {
            XCTAssert(row.expect == result, message, file: row.file, line: row.line)
        } else {
            XCTAssert(row.expect == result, file: row.file, line: row.line)
        }
    }

    func saveAttachement(_ xctest: XCTestCase, content: String) {
        let attachment = XCTAttachment(string: content)
        attachment.lifetime = .keepAlways
        attachment.name = "table.md"
        xctest.add(attachment)
    }
}

public struct ParameterizedTestResult {
    public var table: String
}

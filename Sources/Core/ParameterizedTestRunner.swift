//
//  ParameterizedTestRunner.swift
//  SwiftParamTest
//
//  Created by Yusuke Hosonuma on 2020/03/21.
//

import XCTest

public class ParameterizedTestZ {
    public enum TableType {
        case none
        case markdown
    }

    public struct Option {
        var traceTable: TableType
        var saveTableToAttachement: TableType
    }

    public static let defaultOption = Option(traceTable: .none, saveTableToAttachement: .markdown)
    public static var option = defaultOption
}

public class ParameterizedTestRunner<T: EvalutableRow> {
    let runner: XCTestCase
    let header: [String]?
    let option: ParameterizedTestZ.Option

    init(
        runner: XCTestCase,
        header: [String]?,
        option: ParameterizedTestZ.Option = ParameterizedTestZ.option
    ) {
        self.runner = runner
        self.header = header
        self.option = option
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

        switch option.traceTable {
        case .none:
            break
        case .markdown:
            traceTable(content: table)
        }

        switch option.saveTableToAttachement {
        case .none:
            break
        case .markdown:
            saveAttachement(runner, content: table)
        }

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

    func traceTable(content: String) {
        print(content)
    }

    func saveAttachement(_ xctest: XCTestCase, content: String) {
        #if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
            let attachment = XCTAttachment(string: content)
            attachment.lifetime = .keepAlways
            attachment.name = "table.md"
            xctest.add(attachment)
        #endif
    }
}

public struct ParameterizedTestResult {
    public var table: String
}

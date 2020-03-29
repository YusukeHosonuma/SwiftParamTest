import SHList
import XCTest

public struct EvalutableRow3 {
    var columns: [Any]
    var evalute: (Assertion, [String]?) -> Void
}

public class ParameterizedTestRunner2 {
    let runner: XCTestCase
    let header: [String]?
    let option: ParameterizedTest.Option
    let assertion: Assertion

    init(
        runner: XCTestCase,
        header: [String]?,
        assertion: Assertion?,
        option: ParameterizedTest.Option = ParameterizedTest.option
    ) {
        self.runner = runner
        self.header = header
        self.option = option
        self.assertion = assertion ?? XCTAssertion()
    }

    @discardableResult
    final func execute(with rows: [EvalutableRow3]) -> ParameterizedTestResult {
        precondition(rows.count > 0, "`rows` are empty.")
        if let header = header {
            precondition(
                rows.allSatisfy { $0.columns.count == header.count + 1 }, // not include `Expect` column in `header`
                "Columns count are not equal between `header` and `rows`."
            )
        }

        for row in rows {
            row.evalute(assertion, header)
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

        return ParameterizedTestResult(table: "")
    }

    // MARK: - Overridable

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

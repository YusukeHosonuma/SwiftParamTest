import SHList
import XCTest

public struct AssertionFailed: Error {
    var message: String
    var file: StaticString
    var line: UInt
}

public protocol EvalutableRow2 {
    associatedtype Function

    var columns: [Any] { get }
    var target: Function! { get }
    func evalute(assertion: Assertion, header: [String]?)
}

// MARK: - normal row

public struct ERow2<T1, T2, R>: EvalutableRow2 where R: Equatable {
    public typealias Function = ((T1, T2) throws -> R)

    public var args: HList2<T1, T2>
    public var expect: R
    public var target: ((T1, T2) throws -> R)!
    public var file: StaticString
    public var line: UInt

    public var columns: [Any] {
        args.asArray() + [expect]
    }

    public func evalute(assertion: Assertion, header: [String]?) {
        let actual = try! args.apply(target)
        assertion.assertEqual(expect, actual, header: header, columns: columns, file: file, line: line)
    }
}

// MARK: - error row

public struct ErrorRow2<T1, T2, R, E> where E: Equatable {
    public var args: HList2<T1, T2>
    public var expectError: E
    public var target: ((T1, T2) throws -> R)!
    public var file: StaticString
    public var line: UInt
}

extension ErrorRow2: EvalutableRow2 {
    public var columns: [Any] {
        args.asArray() + [expectError]
    }

    public func evalute(assertion: Assertion, header: [String]?) {
        assertion.assertThrowError(
            exprettion: { () throws -> R in try args.apply(target) },
            expectError: expectError,
            header: header,
            columns: columns,
            file: file,
            line: line
        )
    }
}

// MARK: - assersions

public protocol Assertion {
    func assertEqual<T: Equatable>(_ expect: T, _ actual: T, header: [String]?, columns: [Any], file: StaticString, line: UInt)
    func assertThrowError<T, E: Equatable>(exprettion: () throws -> T, expectError: E, header: [String]?, columns: [Any], file: StaticString, line: UInt)
}

class XCTAssertion: Assertion {
    func assertEqual<T: Equatable>(_ expect: T, _ actual: T, header: [String]?, columns: [Any], file: StaticString, line: UInt) {
        guard expect != actual else { return }

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

    func assertThrowError<T, E: Equatable>(exprettion: () throws -> T, expectError: E, header _: [String]?, columns _: [Any], file: StaticString, line: UInt) {
        do {
            let actual = try exprettion()
            XCTFail("error is not throw, got \(actual)", file: file, line: line)
        } catch {
            if let error = error as? E {
                XCTAssert(error == expectError, "expected \(expectError) got \(error)", file: file, line: line)
            } else {
                XCTFail("!!!")
            }
        }
    }
}

public struct RowsWrapper<T1, T2, Return> {
    var target: ((T1, T2) throws -> Return)!
    var evalute: (Assertion, [String]?) -> Void
    var columns: [Any]
}

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
        assertion: Assertion = XCTAssertion(),
        option: ParameterizedTest.Option = ParameterizedTest.option
    ) {
        self.runner = runner
        self.header = header
        self.option = option
        self.assertion = assertion
    }

    @discardableResult
    final func execute2<T: EvalutableRow2>(with rows: T...) -> ParameterizedTestResult {
        rows.forEach {
            print("🍎 \($0)")
        }

        preconditionFailure()
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
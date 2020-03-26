//
//  CoreTests.swift
//  SwiftParamTestTests
//
//  Created by Yusuke Hosonuma on 2020/03/16.
//

import XCTest
@testable import SwiftParamTest

class CoreTests: XCTestCase {

    override func setUp() {}

    override func tearDown() {}

    var args_x: [Int] = []
    var args_y: [Int] = []

    func plus(x: Int, y: Int) -> Int {
        args_x.append(x)
        args_y.append(y)
        return x + y
    }

    func testExecute_fullSpecification() {

        // Given:
        let runner = SpyRunner<Row2<Int, Int, Int>>(
            runner: self,
            header: ["x", "y"],
            option: ParameterizedTest.Option(traceTable: .markdown, saveTableToAttachement: .markdown)
        )

        // When:
        let rows = [
            Row2(args: (1,  0), expect:   1, target: plus, file: #file, line: #line),
            Row2(args: (2, -4), expect: -20, target: plus, file: #file, line: #line) // `expect` is invalid
        ]
        
        let result = runner.execute(with: rows)
        
        // Then:

        XCTAssertEqual(args_x, [1,  2])
        XCTAssertEqual(args_y, [0, -4])
        XCTAssertEqual(runner.args_row[0].expect,   1)
        XCTAssertEqual(runner.args_row[1].expect, -20)
        XCTAssertEqual(runner.args_result, [1, -2])
        XCTAssertEqual(runner.args_message[0], nil)
        XCTAssertEqual(runner.args_message[1], "Expect to '-20' but '-2' (when x: '2', y: '-4')")

        let expectedTable = """
        | x | y  | Expected |
        |---|----|----------|
        | 1 |  0 |        1 |
        | 2 | -4 |      -20 |
        """
        assertEqualLines(result.table, expectedTable)
        assertEqualLines(runner.args_traceContent, expectedTable)
        assertEqualLines(runner.args_saveContent, expectedTable)
    }
    
    func testExecute_headerOmmitted() {

        // Given:
        let runner = SpyRunner<Row2<Int, Int, Int>>(
            runner: self,
            header: nil,
            option: ParameterizedTest.Option(traceTable: .markdown, saveTableToAttachement: .markdown)
        )

        // When:
        let rows = [
            Row2(args: (1,  0), expect:   1, target: plus, file: #file, line: #line),
            Row2(args: (2, -4), expect: -20, target: plus, file: #file, line: #line) // `expect` is invalid
        ]
        let result = runner.execute(with: rows)
        
        // Then:
        XCTAssertEqual(runner.args_message[0], nil)
        XCTAssertEqual(runner.args_message[1], "Expect to '-20' but '-2'")

        let expectedTable = """
        | Args 0 | Args 1 | Expected |
        |--------|--------|----------|
        |      1 |      0 |        1 |
        |      2 |     -4 |      -20 |
        """
        assertEqualLines(result.table, expectedTable)
        assertEqualLines(runner.args_traceContent, expectedTable)
        assertEqualLines(runner.args_saveContent, expectedTable)
    }
    
    func testExecute_option_none() {
        
        // Given:
        let runner = SpyRunner<Row2<Int, Int, Int>>(
            runner: self,
            header: nil,
            option: ParameterizedTest.Option(traceTable: .none, saveTableToAttachement: .none)
        )
        
        // When:
        let rows = [
            Row2(args: (1,  0), expect:   1, target: plus, file: #file, line: #line),
            Row2(args: (2, -4), expect: -20, target: plus, file: #file, line: #line) // `expect` is invalid
        ]
        _ = runner.execute(with: rows)
        
        // Then:
        XCTAssertEqual(runner.args_traceContent, "") // expect to not called
        XCTAssertEqual(runner.args_saveContent, "")  // expect to not called
    }
}

class SpyRunner<T: EvalutableRow>: ParameterizedTestRunner<T> {
    var args_row: [T] = []
    var args_result: [T.ReturnType] = []
    var args_message: [String?] = []
    var args_traceContent: String = ""
    var args_saveContent: String = ""

    override func executeAssert(row: T, result: T.ReturnType, message: String?) {
        self.args_row.append(row)
        self.args_result.append(result)
        self.args_message.append(message)
    }
    
    override func traceTable(content: String) {
        self.args_traceContent = content
    }
    
    override func saveAttachement(_ xctest: XCTestCase, content: String) {
        self.args_saveContent = content
    }
}

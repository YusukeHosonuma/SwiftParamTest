//
//  UtilTests.swift
//  SwiftParamTestTests
//
//  Created by Yusuke Hosonuma on 2020/03/18.
//

import XCTest
@testable import SwiftParamTest

class MarkdownTableTests: XCTestCase {

    override func setUp() {}

    override func tearDown() {}

    func testExample() throws {
        
        // one row
        assertEqualLines(try generateMarkdownTable(
             header: ["Item", "Amount"],
             rows: [
                 ["Apple", 7],
             ]),
             """
             | Item  | Amount |
             |-------|--------|
             | Apple |      7 |
             """
        )
        
        // one col
        assertEqualLines(try generateMarkdownTable(
             header: ["Item"],
             rows: [
                 ["Apple"],
                 ["Orange"],
             ]),
             """
             | Item   |
             |--------|
             | Apple  |
             | Orange |
             """
        )

        // many rows and cols
        assertEqualLines(try generateMarkdownTable(
             header: ["Item", "Amount"],
             rows: [
                 ["Apple",   7],
                 ["Orange", 42],
                 ["Banana",  5],
             ]),
             """
             | Item   | Amount |
             |--------|--------|
             | Apple  |      7 |
             | Orange |     42 |
             | Banana |      5 |
             """
        )
        
        // numeric types are align to right, other left.
        assertEqualLines(try generateMarkdownTable(
             header: ["Int", "Long", "Float", "Double", "String", "Bool"],
             rows: [
                [1 as Int, 2 as UInt, 1.0 as Float, 2.0 as Double, "42", true],
             ]),
             """
             | Int | Long | Float | Double | String | Bool |
             |-----|------|-------|--------|--------|------|
             |   1 |    2 |   1.0 |    2.0 | 42     | true |
             """
        )
    }
    
    func testThrowError() throws {
        
        // header is empty
        XCTAssertThrowsError(
            try generateMarkdownTable(
                header: [],
                rows: [
                    ["Apple"]
                ]
            )
        ) { (error) in
            XCTAssertEqual(error as? GenerateMarkdownTableError, .includeEmptyCols)
        }
        
        // include empty row
        XCTAssertThrowsError(
            try generateMarkdownTable(
                header: ["Fruit"],
                rows: [
                    ["Apple"],
                    []
                ]
            )
        ) { (error) in
            XCTAssertEqual(error as? GenerateMarkdownTableError, .includeEmptyCols)
        }
        
        // rows are empty
        XCTAssertThrowsError(
            try generateMarkdownTable(
                header: ["Fruit"],
                rows: []
            )
        ) { (error) in
            XCTAssertEqual(error as? GenerateMarkdownTableError, .emptyRows)
        }
        
        // different cols count
        XCTAssertThrowsError(
            try generateMarkdownTable(
                header: ["Fruit"],
                rows: [
                    ["Apple"],
                    ["Orange", "42"]
                ]
            )
        ) { (error) in
            XCTAssertEqual(error as? GenerateMarkdownTableError, .differentCols)
        }
    }
}

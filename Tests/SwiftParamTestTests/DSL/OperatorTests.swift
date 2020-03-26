//
//  OperatorTests.swift
//  SwiftParamTestTests
//
//  Created by Yusuke Hosonuma on 2020/03/25.
//

import SwiftParamTest
import XCTest

class OperatorTests: XCTestCase {

    override func setUp() {
        ParameterizedTest.option = ParameterizedTest.Option(traceTable: .none, saveTableToAttachement: .none)
    }

    override func tearDown() {}
    
    func testFunctionArgs() {
        func f1(n1: Int) -> [Int] { [n1] }
        func f2(n1: Int, n2: Int) -> [Int] { [n1, n2] }
        func f3(n1: Int, n2: Int, n3: Int) -> [Int] { [n1, n2, n3] }
        func f4(n1: Int, n2: Int, n3: Int, n4: Int) -> [Int] { [n1, n2, n3, n4] }

        let expectedTable1 = """
        | Args 0 | Expected |
        |--------|----------|
        |      1 | [1]      |
        |      1 | [1]      |
        """
        
        let expectedTable2 = """
        | Args 0 | Args 1 | Expected |
        |--------|--------|----------|
        |      1 |      2 | [1, 2]   |
        |      1 |      2 | [1, 2]   |
        """
        
        let expectedTable3 = """
        | Args 0 | Args 1 | Args 2 | Expected  |
        |--------|--------|--------|-----------|
        |      1 |      2 |      3 | [1, 2, 3] |
        |      1 |      2 |      3 | [1, 2, 3] |
        """
        
        let expectedTable4 = """
        | Args 0 | Args 1 | Args 2 | Args 3 | Expected     |
        |--------|--------|--------|--------|--------------|
        |      1 |      2 |      3 |      4 | [1, 2, 3, 4] |
        |      1 |      2 |      3 |      4 | [1, 2, 3, 4] |
        """
        
        assertEqualLines(assert(to: f1) {
            expect(1 ==> [1])
            expect(1 ==> [1])
        }.table, expectedTable1)
        
        assertEqualLines(assert(to: f2) {
            expect((1, 2) ==> [1, 2])
            expect((1, 2) ==> [1, 2])
        }.table, expectedTable2)
        
        assertEqualLines(assert(to: f3) {
            expect((1, 2, 3) ==> [1, 2, 3])
            expect((1, 2, 3) ==> [1, 2, 3])
        }.table, expectedTable3)
        
        assertEqualLines(assert(to: f4) {
            expect((1, 2, 3, 4) ==> [1, 2, 3, 4])
            expect((1, 2, 3, 4) ==> [1, 2, 3, 4])
        }.table, expectedTable4)
    }
}

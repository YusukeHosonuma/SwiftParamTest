import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    [
        testCase(DSLTests.allTests),
        testCase(BasicDSLTests.allTests)
    ]
}
#endif

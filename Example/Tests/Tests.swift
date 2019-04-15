import XCTest
import SwiftParamTest

func fizzBuzz(_ x: Int) -> String {
    return "\(x)"
}

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testFizzBuzz() {
        Expect(f: fizzBuzz).forAll([
            when(1, then: "1"),
            when(2, then: "2"),
            when(3, then: "Fizz"),
            when(4, then: "4"),
            when(5, then: "Buzz"),
            when(6, then: "6"),
        ])
    }
}

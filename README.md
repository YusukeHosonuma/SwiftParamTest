# SwiftParamTest

![Test](https://github.com/YusukeHosonuma/SwiftParamTest/workflows/Test/badge.svg)
[![CocoaPods](https://img.shields.io/cocoapods/v/SwiftParamTest.svg)](https://cocoapods.org/pods/SwiftParamTest)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
![SPM Compatible](https://img.shields.io/badge/SPM-compatible-4BC51D.svg?style=flat)
[![License](https://img.shields.io/github/license/YusukeHosonuma/SwiftPrettyPrint)](https://github.com/YusukeHosonuma/SwiftPrettyPrint/blob/master/LICENSE)
[![Twitter](https://img.shields.io/twitter/url?style=social&url=https%3A%2F%2Ftwitter.com%2Ftobi462)](https://twitter.com/tobi462)

![Logo](https://raw.githubusercontent.com/YusukeHosonuma/SwiftParamTest/master/Image/logo.png)

Parameterized-test for Swift. (with XCTest)

![Screenshot](https://raw.githubusercontent.com/YusukeHosonuma/SwiftParamTest/master/Image/screenshot.png)

## Code Style

SwiftParamTest supports two way of code-style dependent on Swift version.

### Function builders API (recommended)

I recommend this when you use Swift 5.1 or later (because this API uses Function builders).

```swift
assert(to: max) {
    args(1, 2, expect: 2)
    args(2, 1, expect: 2)
    args(4, 4, expect: 4)
}

// You can also use tuple (with label).
assert(to: max) {
    args((x: 1, y: 2), expect: 2)
    args((x: 2, y: 1), expect: 2)
    args((x: 4, y: 4), expect: 4)
}
```

### Legacy API

You can use array literal based API that like follwing when you use under Swift 5.1.

```swift
assert(to: max, expect: [
    args(1, 2, expect: 2),
    args(2, 1, expect: 2),
    args(4, 4, expect: 4),
])

// You can also use tuple (with label).
assert(to: max, expect: [
    args((x: 1, y: 2), expect: 2),
    args((x: 2, y: 1), expect: 2),
    args((x: 4, y: 4), expect: 4),
])
```

## Operator based API

You can specify row by use the operator `==>` that like following:

```swift
// Function Builder API
assert(to: max) {
    expect((x: 1, y: 2) ==> 2)
    expect((x: 2, y: 1) ==> 2)
    expect((x: 4, y: 4) ==> 4)
}

// Legacy API
assert(to: max, expect: [
    expect((x: 1, y: 2) ==> 2),
    expect((x: 2, y: 1) ==> 2),
    expect((x: 4, y: 4) ==> 4),
])
```

## Save or Output Markdown Table

Save or output markdown table when enabled by option (default is all disable).

```swift
override func setUp() {
    ParameterizedTest.option = ParameterizedTest.Option(
        traceTable: .markdown,            // output console is enabled
        saveTableToAttachement: .markdown // save to attachement is enabled
    )
}

override func tearDown() {
    ParameterizedTest.option = ParameterizedTest.defaultOption // restore to default
}

func testExample() {
    assert(to: max) {
        args(1, 2, expect: 2)
        args(2, 1, expect: 2)
        args(4, 4, expect: 4)
    }
    // =>
    // | Args 0 | Args 1 | Expected |
    // |--------|--------|----------|
    // |      1 |      2 |        2 |
    // |      2 |      1 |        2 |
    // |      4 |      4 |        4 |
}
```

You can also specify column header name too.

```swift
func testMarkdownTable() {
    assert(to: max, header: ["x", "y"]) { // specify `header`
        args(1, 2, expect: 2)
        args(2, 1, expect: 2)
        args(4, 4, expect: 4)
    }
    // =>
    // | x | y | Expected |
    // |---|---|----------|
    // | 1 | 2 |        2 |
    // | 2 | 1 |        2 |
    // | 4 | 4 |        4 |
}
```

![markdown table](https://raw.githubusercontent.com/YusukeHosonuma/SwiftParamTest/master/Image/markdown-table.png)

You can also retrive markdown table from result too.

```swift
let tableString = assert(to: max, header: ["x", "y"]) {
                      args(1, 2, expect: 2)
                      args(2, 1, expect: 2)
                      args(4, 4, expect: 4)
                  }.table

print(tableString)
// =>
// | x | y | Expected |
// |---|---|----------|
// | 1 | 2 |        2 |
// | 2 | 1 |        2 |
// | 4 | 4 |        4 |
```

This is useful for copy and paste the test specification table to PR or others.

![markdown table in PR](https://raw.githubusercontent.com/YusukeHosonuma/SwiftParamTest/master/Image/github-pr-markdown-table.png)

## Xcode Code Snippets

![Xcode Code Snippets](https://raw.githubusercontent.com/YusukeHosonuma/SwiftParamTest/master/Image/xcode-snippet.gif)

Copy `.codesnippet` files to the following directory from [.xcode](.xcode) directory:

```text
~/Library/Developer/Xcode/UserData/CodeSnippets/
```

and restart Xcode.

Or run the following command from the root of the repository:

```text
$ make snippets
```

## Example

```swift
import SwiftParamTest
import XCTest

class ExampleTests: XCTestCase {
    override func setUp() {
        ParameterizedTest.option = ParameterizedTest.Option(traceTable: .markdown,
                                                            saveTableToAttachement: .markdown)
    }

    override func tearDown() {
        ParameterizedTest.option = ParameterizedTest.defaultOption
    }

    func testExample() {
        // for `function`
        assert(to: abs) {
            args( 0, expect: 0)
            args( 2, expect: 2)
            args(-2, expect: 2)
        }

        // for `operator`
        assert(to: +) {
            args(1, 1, expect: 2)
            args(1, 2, expect: 3)
            args(2, 2, expect: 4)
        }

        // for `instance method` (when receiver is not fixed)
        assert(to: String.hasPrefix) {
            args("hello", "he", expect: true)
            args("hello", "HE", expect: false)
        }

        // for `instance method` (when receiver is fixed)
        assert(to: "hello".hasPrefix) {
            args("he", expect: true)
            args("HE", expect: false)
        }
    }
}
```

## Custom Assertion

SwiftParamTest uses `XCTAssertEqual()` and owns error messages by default.

But you can use custom assertion like follows.

```swift
// custom assertion
func customAssert<T: Equatable>(_ actual: T, _ expected: T, file: StaticString, line: UInt) {
    let message = """

    ----
    Expected: \(expected)
    Actual: \(actual)
    ----
    """
    XCTAssert(expected == actual, message, file: file, line: line)
}

// passed by `with` arguments
assert(to: fizzBuzz, with: customAssertion) {
    args(1, expect: "Fizz")
    // =>
    //
    // XCTAssertTrue failed -
    // ----
    // Expected: 1
    // Actual: Fizz
    // ----
    //
}
```

## Limitation

- Only up to **four** arguments are supported.

## FAQ

### Can't compile or compiler is clashed

This library use many type inference, therefore type inference are failed in sometime.
This may be resolved by explicitly specifying the type information.

for example:

```swift
// Legacy API
assert(to: max, expect: [
    args(1, 2, expect: 2),
    args(2, 1, expect: 2),
    args(4, 4, expect: 4),
] as [Row2<Int, Int, Int>]) // `N` in `RowN` is arguments count

// Function Builder API
typealias T = Int
assert(to: max) {
    args(1 as T, 2 as T, expect: 2)
    args(2 as T, 1 as T, expect: 2)
    args(4 as T, 4 as T, expect: 4)
}
```

## Installation

### CocoaPods

```ruby
pod 'SwiftParamTest'
```

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/YusukeHosonuma/SwiftParamTest.git", from: "2.1.0"),
]
```

### Carthage

Write following to `Cartfile.private`.

```text
github "YusukeHosonuma/SwiftParamTest"
```

## Author

Yusuke Hosonuma / tobi462@gmail.com

## License

SwiftParamTest is available under the MIT license. See the LICENSE file for more info.

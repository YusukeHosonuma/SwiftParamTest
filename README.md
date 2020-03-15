# SwiftParamTest

![Test](https://github.com/YusukeHosonuma/SwiftParamTest/workflows/Test/badge.svg)
[![CocoaPods](https://img.shields.io/cocoapods/v/SwiftParamTest.svg)](https://cocoapods.org/pods/SwiftParamTest)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
![SPM Compatible](https://img.shields.io/badge/SPM-compatible-4BC51D.svg?style=flat)
[![License](https://img.shields.io/github/license/YusukeHosonuma/SwiftPrettyPrint)](https://github.com/YusukeHosonuma/SwiftPrettyPrint/blob/master/LICENSE)
[![Twitter](https://img.shields.io/twitter/url?style=social&url=https%3A%2F%2Ftwitter.com%2Ftobi462)](https://twitter.com/tobi462)

Parameterized-test for Swift. (with XCTest)

![Screenshot](https://raw.githubusercontent.com/YusukeHosonuma/SwiftParamTest/master/Image/screenshot.png)

## Code Style

SwiftParamTest supports two way of code-style dependent on Swift version.

### Function builders API (recommended)

I recomend this when you use Swift 5.1 or later (because this API use Function builders).

```swift
assert(to: fizzBuzz) {
    args(1, expect: "1")
    args(2, expect: "2")
    args(3, expect: "Fizz")
    args(4, expect: "4")
    args(5, expect: "Buzz")
    ...
}
```

### Basic API

You can use following when you use under Swift 5.1.

```swift
assert(to: fizzBuzz, expect: [
    args(1, expect: "1"),
    args(2, expect: "2"),
    args(3, expect: "Fizz"),
    args(4, expect: "4"),
    args(5, expect: "Buzz"),
    ...
])
```

## Operator based API

You can use the operator `==>` API that like following:

```swift
assert(to: fizzBuzz) {
    expect(1 ==> "1")
    expect(2 ==> "2")
    expect(3 ==> "Fizz")
    expect(4 ==> "4")
    expect(5 ==> "Buzz")
    ...
}
```

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

    func testExample() {
        //
        // for `function`
        //
        assert(to: abs) {
            args( 0, expect: 0)
            args( 2, expect: 2)
            args(-2, expect: 2)
        }

        //
        // for `operator`
        //
        assert(to: +) {
            args((1, 1), expect: 2)
            args((1, 2), expect: 3)
            args((2, 2), expect: 4)
        }

        //
        // for `instance method` (when receiver is not fixed)
        //
        assert(to: String.hasPrefix, expect: [
            args(("hello", "he"), expect: true),
            args(("hello", "HE"), expect: false),
        ])

        //
        // for `instance method` (when receiver is fixed)
        //
        assert(to: "hello".hasPrefix) {
            args("he", expect: true)
            args("HE", expect: false)
        }
    }
}
```

## Custom Assertion

SwiftParamTest use `XCTAssertEqual()` and own error message by default.

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

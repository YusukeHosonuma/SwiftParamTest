# SwiftParamTest

![Test](https://github.com/YusukeHosonuma/SwiftParamTest/workflows/Test/badge.svg)
[![CocoaPods](https://img.shields.io/cocoapods/v/SwiftParamTest.svg)](https://cocoapods.org/pods/SwiftParamTest)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
![SPM Compatible](https://img.shields.io/badge/SPM-compatible-4BC51D.svg?style=flat)
[![License](https://img.shields.io/github/license/YusukeHosonuma/SwiftPrettyPrint)](https://github.com/YusukeHosonuma/SwiftPrettyPrint/blob/master/LICENSE)
[![Twitter](https://img.shields.io/twitter/url?style=social&url=https%3A%2F%2Ftwitter.com%2Ftobi462)](https://twitter.com/tobi462)

Parameterized-test for Swift. (with XCTest)

![Screenshot](https://raw.githubusercontent.com/YusukeHosonuma/SwiftParamTest/master/screenshot.png)

## Example

```swift
/// Test for single argument function
func testFizzBuzz() {
    assert(to: fizzBuzz).expect([
        when(1, then: "1"),
        when(2, then: "2"),
        when(3, then: "Fizz"),
        when(4, then: "4"),
        when(5, then: "Buzz"),
        ...
    ])
}

/// Test for two argument function
func testIndent() {
    assert(to: indent).expect([
        when(("Hello", 0), then: "Hello"),
        when(("Hello", 2), then: "  Hello"),
        when(("Hello", 4), then: "    Hello"),
    ])
}

/// Test for operator
func testOperator() {
    assert(to: +).expect([
        when((1, 1), then: 2),
        when((1, 2), then: 3),
        when((2, 2), then: 4),
    ])
}

/// Test for method of object
func testObject() {
    let calc = Calculator(initialValue: 10)

    assert(to: calc.add).expect([
        when(1, then: 11),
        when(2, then: 12),
        when(3, then: 13),
    ])

    assert(to: calc.subtraction).expect([
        when(1, then: 9),
        when(2, then: 8),
        when(3, then: 7),
    ])
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
    .package(url: "https://github.com/YusukeHosonuma/SwiftParamTest.git", from: "1.0.0"),
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

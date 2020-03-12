//
//  Assets.swift
//  ExampleTests
//
//  Created by Yusuke Hosonuma on 2020/03/12.
//  Copyright © 2020 Yusuke Hosonuma. All rights reserved.
//

func fizzBuzz(_ x: Int) -> String {
    switch (x % 3 == 0, x % 5 == 0) {
    case (true, false): return "Fizz"
    case (false, true): return "Buzz"
    case (true, true): return "FizzBuzz"
    case (false, false): return "\(x)"
    }
}

func indent(to target: String, size: Int) -> String {
    String(repeating: " ", count: size) + target
}

struct Calculator {
    var initialValue: Int

    func add(_ n: Int) -> Int {
        initialValue + n
    }

    func subtraction(_ n: Int) -> Int {
        initialValue - n
    }
}

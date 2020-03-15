//
//  Util.swift
//  SwiftParamTest
//
//  Created by Yusuke Hosonuma on 2020/03/15.
//

/// uncurry instance-method that has no arguments (e.g. `String#lowercase`)
func flatten<T, R: Equatable>(_ f: @escaping (T) -> () -> R) -> (T) -> R {
    { (t: T) -> R in f(t)() }
}

/// uncurry instance-method that has arguments (e.g. `String#hasPrefix`)
func flatten<T1, T2, R: Equatable>(_ f: @escaping (T1) -> (T2) -> R) -> ((T1, T2) -> R) {
    { (t1: T1, t2: T2) -> R in f(t1)(t2) }
}

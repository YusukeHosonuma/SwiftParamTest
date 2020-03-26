//
//  Flaten.swift
//  SwiftParamTest
//
//  Created by Yusuke Hosonuma on 2020/03/15.
//

/// uncurry instance-method that has no arguments (e.g. `String#lowercase`)
func flatten<T, R: Equatable>(_ f: @escaping (T) -> () -> R) -> (T) -> R {
    { (t: T) -> R in f(t)() }
}

/// uncurry instance-method that has arguments (e.g. `String#hasPrefix`)

func flatten<V, T1, R>(_ f: @escaping (V) -> (T1) -> R) -> ((V, T1) -> R) {
    { (v: V, t1: T1) -> R in f(v)(t1) }
}

func flatten<V, T1, T2, R>(_ f: @escaping (V) -> (T1, T2) -> R) -> (V, T1, T2) -> R {
    { (v: V, t1: T1, t2: T2) -> R in f(v)(t1, t2) }
}

func flatten<V, T1, T2, T3, R>(_ f: @escaping (V) -> (T1, T2, T3) -> R) -> (V, T1, T2, T3) -> R {
    { (v: V, t1: T1, t2: T2, t3: T3) -> R in f(v)(t1, t2, t3) }
}

func flatten<V, T1, T2, T3, T4, R>(_ f: @escaping (V) -> (T1, T2, T3, T4) -> R) -> (V, T1, T2, T3, T4) -> R {
    { (v: V, t1: T1, t2: T2, t3: T3, t4: T4) -> R in f(v)(t1, t2, t3, t4) }
}

/// uncurry instance-method that no return
func flatten<T1, T2: Equatable>(_ f: @escaping (T1) -> (T2) -> Void) -> ((T1, T2) -> Void) {
    { (t1: T1, t2: T2) -> Void in f(t1)(t2) }
}

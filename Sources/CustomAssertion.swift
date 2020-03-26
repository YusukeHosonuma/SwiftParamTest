//
// CustomAssertion.swift
// SwiftParamTest
//
// Created by Yusuke Hosonuma on 2020/02/28.
// Copyright (c) 2020 Yusuke Hosonuma.
//

public typealias CustomAssertion<T: Equatable> = (_ expected: T, _ actual: T, _ file: StaticString, _ line: UInt) -> Void

//
//  Args.swift
//  SwiftParamTest
//
//  Created by Yusuke Hosonuma on 2020/03/21.
//

import SHList

// MARK: - arguments version

// MARK: has 1 arguments

public func args<T1, R>(
    _ arg1: T1,
    expect: R,
    file: StaticString = #file,
    line: UInt = #line
) -> Row1<T1, R> {
    Row1(args: HList(arg1), expect: expect, file: file, line: line)
}

// MARK: has 2 arguments

public func args<T1, T2, R>(
    _ arg1: T1,
    _ arg2: T2,
    expect: R,
    file: StaticString = #file,
    line: UInt = #line
) -> Row2<T1, T2, R> {
    Row2(args: HList(arg1, arg2), expect: expect, file: file, line: line)
}

// MARK: has 3 arguments

public func args<T1, T2, T3, R>(
    _ arg1: T1,
    _ arg2: T2,
    _ arg3: T3,
    expect: R,
    file: StaticString = #file,
    line: UInt = #line
) -> Row3<T1, T2, T3, R> {
    Row3(args: HList(arg1, arg2, arg3), expect: expect, file: file, line: line)
}

// MARK: has 4 arguments

public func args<T1, T2, T3, T4, R>(
    _ arg1: T1,
    _ arg2: T2,
    _ arg3: T3,
    _ arg4: T4,
    expect: R,
    file: StaticString = #file,
    line: UInt = #line
) -> Row4<T1, T2, T3, T4, R> {
    Row4(args: HList(arg1, arg2, arg3, arg4), expect: expect, file: file, line: line)
}

// MARK: has 5 arguments

public func args<T1, T2, T3, T4, T5, R>(
    _ arg1: T1,
    _ arg2: T2,
    _ arg3: T3,
    _ arg4: T4,
    _ arg5: T5,
    expect: R,
    file: StaticString = #file,
    line: UInt = #line
) -> Row5<T1, T2, T3, T4, T5, R> {
    Row5(args: HList(arg1, arg2, arg3, arg4, arg5), expect: expect, file: file, line: line)
}

// MARK: - tuple version

// MARK: has 2 arguments

public func args<T1, T2, R>(
    _ args: (T1, T2),
    expect: R,
    file: StaticString = #file,
    line: UInt = #line
) -> Row2<T1, T2, R> {
    Row2(args: HList(args.0, args.1), expect: expect, file: file, line: line)
}

// MARK: has 3 arguments

public func args<T1, T2, T3, R>(
    _ args: (T1, T2, T3),
    expect: R,
    file: StaticString = #file,
    line: UInt = #line
) -> Row3<T1, T2, T3, R> {
    Row3(args: HList(args), expect: expect, file: file, line: line)
}

// MARK: has 4 arguments

public func args<T1, T2, T3, T4, R>(
    _ args: (T1, T2, T3, T4),
    expect: R,
    file: StaticString = #file,
    line: UInt = #line
) -> Row4<T1, T2, T3, T4, R> {
    Row4(args: HList(args), expect: expect, file: file, line: line)
}

// MARK: has 5 arguments

public func args<T1, T2, T3, T4, T5, R>(
    _ args: (T1, T2, T3, T4, T5),
    expect: R,
    file: StaticString = #file,
    line: UInt = #line
) -> Row5<T1, T2, T3, T4, T5, R> {
    Row5(args: HList(args), expect: expect, file: file, line: line)
}

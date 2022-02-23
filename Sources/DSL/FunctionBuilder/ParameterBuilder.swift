//
//  ParameterBuilder.swift
//  SwiftParamTest
//
//  Created by Yusuke Hosonuma on 2020/03/21.
//

@available(swift 5.1)
@resultBuilder
public struct ParameterBuilder1<T1, R> where R: Equatable {
    public typealias Row = Row1<T1, R>

    public static func buildBlock(_ rows: Row...) -> [Row] {
        rows
    }
}

@available(swift 5.1)
@resultBuilder
public struct ParameterBuilder2<T1, T2, R> where R: Equatable {
    public typealias Row = Row2<T1, T2, R>

    public static func buildBlock(_ rows: Row...) -> [Row] {
        rows
    }
}

@available(swift 5.1)
@resultBuilder
public struct ParameterBuilder3<T1, T2, T3, R> where R: Equatable {
    public typealias Row = Row3<T1, T2, T3, R>

    public static func buildBlock(_ rows: Row...) -> [Row] {
        rows
    }
}

@available(swift 5.1)
@resultBuilder
public struct ParameterBuilder4<T1, T2, T3, T4, R> where R: Equatable {
    public typealias Row = Row4<T1, T2, T3, T4, R>

    public static func buildBlock(_ rows: Row...) -> [Row] {
        rows
    }
}

@available(swift 5.1)
@resultBuilder
public struct ParameterBuilder5<T1, T2, T3, T4, T5, R> where R: Equatable {
    public typealias Row = Row5<T1, T2, T3, T4, T5, R>

    public static func buildBlock(_ rows: Row...) -> [Row] {
        rows
    }
}

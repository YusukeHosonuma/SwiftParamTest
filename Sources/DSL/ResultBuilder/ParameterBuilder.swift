//
//  ParameterBuilder.swift
//  SwiftParamTest
//
//  Created by Yusuke Hosonuma on 2020/03/21.
//

#if compiler(>=5.4)
@resultBuilder
public struct ParameterBuilder1<T1, R> where R: Equatable {
    public typealias Row = Row1<T1, R>

    public static func buildBlock(_ rows: Row...) -> [Row] {
        rows
    }
}

@resultBuilder
public struct ParameterBuilder2<T1, T2, R> where R: Equatable {
    public typealias Row = Row2<T1, T2, R>

    public static func buildBlock(_ rows: Row...) -> [Row] {
        rows
    }
}

@resultBuilder
public struct ParameterBuilder3<T1, T2, T3, R> where R: Equatable {
    public typealias Row = Row3<T1, T2, T3, R>

    public static func buildBlock(_ rows: Row...) -> [Row] {
        rows
    }
}

@resultBuilder
public struct ParameterBuilder4<T1, T2, T3, T4, R> where R: Equatable {
    public typealias Row = Row4<T1, T2, T3, T4, R>

    public static func buildBlock(_ rows: Row...) -> [Row] {
        rows
    }
}

@resultBuilder
public struct ParameterBuilder5<T1, T2, T3, T4, T5, R> where R: Equatable {
    public typealias Row = Row5<T1, T2, T3, T4, T5, R>

    public static func buildBlock(_ rows: Row...) -> [Row] {
        rows
    }
}

#elseif compiler(>=5.1)
@_functionBuilder
public struct ParameterBuilder1<T1, R> where R: Equatable {
    public typealias Row = Row1<T1, R>

    public static func buildBlock(_ rows: Row...) -> [Row] {
        rows
    }
}

@_functionBuilder
public struct ParameterBuilder2<T1, T2, R> where R: Equatable {
    public typealias Row = Row2<T1, T2, R>

    public static func buildBlock(_ rows: Row...) -> [Row] {
        rows
    }
}

@_functionBuilder
public struct ParameterBuilder3<T1, T2, T3, R> where R: Equatable {
    public typealias Row = Row3<T1, T2, T3, R>

    public static func buildBlock(_ rows: Row...) -> [Row] {
        rows
    }
}

@_functionBuilder
public struct ParameterBuilder4<T1, T2, T3, T4, R> where R: Equatable {
    public typealias Row = Row4<T1, T2, T3, T4, R>

    public static func buildBlock(_ rows: Row...) -> [Row] {
        rows
    }
}

@_functionBuilder
public struct ParameterBuilder5<T1, T2, T3, T4, T5, R> where R: Equatable {
    public typealias Row = Row5<T1, T2, T3, T4, T5, R>

    public static func buildBlock(_ rows: Row...) -> [Row] {
        rows
    }
}
#endif

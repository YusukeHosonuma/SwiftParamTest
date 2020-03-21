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

enum GenerateMarkdownTableError: Error {
    case emptyRows
    case includeEmptyCols
    case differentCols
}

private enum Align {
    case left, right

    func padding(_ value: Any, length: Int) -> String {
        switch self {
        case .left:
            return "\(value)".padding(toLength: length, withPad: " ", startingAt: 0)
        case .right:
            return String(repeating: " ", count: length - "\(value)".count) + "\(value)"
        }
    }
}

func generateMarkdownTable(header: [String], rows: [[Any]]) throws -> String {
    guard rows.count > 0 else {
        throw GenerateMarkdownTableError.emptyRows
    }

    guard header.count > 0, (rows.allSatisfy { $0.count > 0 }) else {
        throw GenerateMarkdownTableError.includeEmptyCols
    }

    guard (rows.allSatisfy { $0.count == header.count }) else {
        throw GenerateMarkdownTableError.differentCols
    }

    let maxLengthByColumn = rows.reduce(header.map { $0.count }) {
        zip($0, $1).map { max($0, "\($1)".count) }
    }

    let separator = maxLengthByColumn.map { String(repeating: "-", count: $0) }

    return ([header, separator] + rows).enumerated().map { index, columns in

        let values = columns.enumerated().map { (arg) -> String in
            let (index, value) = arg

            let align: Align

            switch value {
            case _ as String:
                align = .left

            default:
                if Int("\(value)") != nil || Double("\(value)") != nil {
                    align = .right
                } else {
                    align = .left
                }
            }

            return align.padding(value, length: maxLengthByColumn[index])
        }

        if index == 1 {
            return "|-" + values.joined(separator: "-|-") + "-|" // separator row
        } else {
            return "| " + values.joined(separator: " | ") + " |" // other rows
        }
    }.joined(separator: "\n")
}

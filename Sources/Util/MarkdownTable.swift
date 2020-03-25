//
//  MarkdownTable.swift
//  SwiftParamTest
//
//  Created by Yusuke Hosonuma on 2020/03/25.
//

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

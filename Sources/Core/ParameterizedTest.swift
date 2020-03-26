//
//  ParameterizedTest.swift
//  SwiftParamTest
//
//  Created by Yusuke Hosonuma on 2020/03/25.
//

public class ParameterizedTest {
    private init() {}

    public enum TableType {
        case none
        case markdown
    }

    public struct Option {
        public var traceTable: TableType
        public var saveTableToAttachement: TableType

        public init(
            traceTable: TableType,
            saveTableToAttachement: TableType
        ) {
            self.traceTable = traceTable
            self.saveTableToAttachement = saveTableToAttachement
        }
    }

    public static let defaultOption = Option(traceTable: .none,
                                             saveTableToAttachement: .none)

    public static var option = defaultOption
}

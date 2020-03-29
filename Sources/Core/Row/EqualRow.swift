//
//  EqualRow.swift
//  SwiftParamTest
//
//  Created by Yusuke Hosonuma on 2020/03/29.
//

import SHList

public class EqualRow<R: Equatable> {
    public var file: StaticString
    public var line: UInt
    public var expect: R

    init(
        file: StaticString,
        line: UInt,
        expect: R
    ) {
        self.file = file
        self.line = line
        self.expect = expect
    }

    var columns: [Any] {
        fatalError("should override")
    }

    func apply() throws -> R {
        fatalError("should override")
    }

    public func evalute(assertion: Assertion, header: [String]?) {
        assertion.assertEqual(
            expression: apply,
            expect: expect,
            header: header,
            columns: columns,
            file: file,
            line: line
        )
    }
}

// MARK: 2 arguments

public class ERow2<T1, T2, R>: EqualRow<R>, ParameterRow where R: Equatable {
    public typealias ARGS = HList2<T1, T2>
    public typealias TARGET = ((T1, T2) throws -> R)
    public typealias Function = TARGET

    public var args: ARGS
    public var target: TARGET!

    init(
        args: ARGS,
        expect: R,
        target: @escaping TARGET,
        file: StaticString,
        line: UInt
    ) {
        self.args = args
        self.target = target
        super.init(file: file, line: line, expect: expect)
    }

    public override var columns: [Any] {
        args.asArray() + [expect]
    }

    public override func apply() throws -> R {
        try args.apply(target)
    }
}

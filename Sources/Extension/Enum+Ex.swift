//
//  Enum+Ex.swift
//  PoppyBotPackageDescription
//
//  Created by SaitoYuta on 2017/11/03.
//

public protocol EnumExtension: AsuhaCompatible {}

private struct EnumIterator<E: Hashable & EnumExtension>: IteratorProtocol {
    var hash: Int

    init(type: E.Type) {
        hash = 0
    }

    mutating func next() -> E? {
        defer { hash += 1 }
        return E.asuha.create(hashValue: hash)
    }
}

public extension Asuha where Base: EnumExtension, Base : Hashable {
    public static var all: [Base] {
        return Array(IteratorSequence(EnumIterator(type: Base.self)))
    }

    public static func create(hashValue: Int) -> Base? {
        var hash = hashValue

        let element = withUnsafePointer(to: &hash) { UnsafeRawPointer($0) }.load(as: Base.self)

        guard element.hashValue == hashValue else {
            return nil
        }

        return element
    }

    public static func `init`(hashValue: Int) -> Base? {
        guard let element = Base.asuha.create(hashValue: hashValue) else { return nil }
        return element
    }
}

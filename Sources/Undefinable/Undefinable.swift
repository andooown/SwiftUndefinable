import Foundation

public enum Undefinable<T: RawRepresentable> {
    case defined(T)
    case undefined(T.RawValue)
}

extension Undefinable: Decodable where T: Decodable, T.RawValue: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode(T.self) {
            self = .defined(value)
        } else {
            self = .undefined(try container.decode(T.RawValue.self))
        }
    }
}

extension Undefinable: Equatable where T: Equatable, T.RawValue: Equatable {
}

public extension Undefinable where T: Equatable {
    static func ~=(lhs: T, rhs: Undefinable<T>) -> Bool {
        switch rhs {
        case .defined(let wrapped):
            return wrapped == lhs
        case .undefined:
            return false
        }
    }

    static func ==(lhs: Undefinable<T>, rhs: T) -> Bool {
        switch lhs {
        case .defined(let wrapped):
            return wrapped == rhs
        case .undefined:
            return false
        }
    }

    static func ==(lhs: T, rhs: Undefinable<T>) -> Bool {
        rhs == lhs
    }

    static func !=(lhs: Undefinable<T>, rhs: T) -> Bool {
        switch lhs {
        case .defined(let wrapped):
            return wrapped != rhs
        case .undefined:
            return false
        }
    }

    static func !=(lhs: T, rhs: Undefinable<T>) -> Bool {
        rhs != lhs
    }
}

extension Undefinable: Hashable where T: Hashable, T.RawValue: Hashable {
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .defined(let wrapped):
            hasher.combine(1 as UInt8)
            hasher.combine(wrapped)
        case .undefined(let rawValue):
            hasher.combine(0 as UInt8)
            hasher.combine(rawValue)
        }
    }
}

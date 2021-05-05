import Foundation

public enum Undefinable<T: RawRepresentable> {
    case defined(T)
    case undefined(T.RawValue)
}

extension Undefinable: Equatable where T: Equatable, T.RawValue: Equatable {
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

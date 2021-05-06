import Foundation
import XCTest

@testable import Undefinable

final class UndefinableTests: XCTestCase {
    func testInitWithWrapped() throws {
        XCTAssertEqual(Undefinable<Number>(.one), Undefinable<Number>.defined(.one))
    }

    func testInitWithRawValue() throws {
        XCTAssertEqual(Undefinable<Number>(rawValue: 1), Undefinable<Number>.defined(.one))
        XCTAssertEqual(Undefinable<Number>(rawValue: -1), Undefinable<Number>.undefined(-1))
    }

    func testRawValue() throws {
        XCTAssertEqual(Undefinable<Number>.defined(.one).rawValue, 1)
        XCTAssertEqual(Undefinable<Number>.undefined(-1).rawValue, -1)
    }

    func testMapDefined() throws {
        XCTAssertEqual(Undefinable<Number>.defined(.one).mapDefined { "\($0.rawValue)" }, "1")
        XCTAssertEqual(Undefinable<Number>.undefined(-1).mapDefined { "\($0.rawValue)" }, nil)
    }
}

extension UndefinableTests {
    enum Number: Int, Equatable {
        case one = 1
    }
}

import Foundation
import XCTest

@testable import Undefinable

final class EquatableTests: XCTestCase {
    func testEquating() throws {
        XCTAssertEqual(Undefinable<Number>.defined(.one), Undefinable<Number>.defined(.one))
        XCTAssertNotEqual(Undefinable<Number>.defined(.one), Undefinable<Number>.defined(.two))
        XCTAssertNotEqual(Undefinable<Number>.defined(.one), Undefinable<Number>.undefined(0))
        XCTAssertNotEqual(Undefinable<Number>.defined(.one), nil)
    }
}

extension EquatableTests {
    enum Number: Int, Equatable {
        case one = 1
        case two = 2
    }
}

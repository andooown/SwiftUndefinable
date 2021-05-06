import Foundation
import XCTest

@testable import Undefinable

final class EquatableTests: XCTestCase {
    func testEquating() throws {
        XCTAssertEqual(Undefinable<Number>.defined(.one), Undefinable<Number>.defined(.one))
        XCTAssertNotEqual(Undefinable<Number>.defined(.one), Undefinable<Number>.defined(.two))
        XCTAssertNotEqual(Undefinable<Number>.defined(.one), Undefinable<Number>.undefined(0))
        XCTAssertNotEqual(Undefinable<Number>.defined(.one), Undefinable<Number>.undefined(1))
        XCTAssertNotEqual(Undefinable<Number>.defined(.one), nil)
    }

    func testPatternMatchingOperator() throws {
        switch Undefinable<Number>.defined(.one) {
        case .one:
            break
        default:
            XCTFail()
        }
    }

    func testEqualToOperator() throws {
        XCTAssertTrue(Undefinable<Number>.defined(.one) == .one)
        XCTAssertTrue(.one == Undefinable<Number>.defined(.one))

        XCTAssertFalse(Undefinable<Number>.defined(.one) == .two)
        XCTAssertFalse(.two == Undefinable<Number>.defined(.one))
    }

    func testNotEqualToOperator() throws {
        XCTAssertFalse(Undefinable<Number>.defined(.one) != .one)
        XCTAssertFalse(.one != Undefinable<Number>.defined(.one))

        XCTAssertTrue(Undefinable<Number>.defined(.one) != .two)
        XCTAssertTrue(.two != Undefinable<Number>.defined(.one))
    }
}

extension EquatableTests {
    enum Number: Int, Equatable {
        case one = 1
        case two = 2
    }
}

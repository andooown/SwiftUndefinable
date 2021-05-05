import Foundation
import XCTest

@testable import Undefinable

final class HashableTests: XCTestCase {
    func testHashValue() throws {
        XCTAssertEqual(Target.defined(.one).hashValue, Target.defined(.one).hashValue)
        XCTAssertNotEqual(Target.defined(.one).hashValue, Target.defined(.two).hashValue)
        XCTAssertNotEqual(Target.defined(.one).hashValue, Target.undefined(0).hashValue)
        XCTAssertNotEqual(Target.defined(.one).hashValue, Target.undefined(1).hashValue)
    }
}

extension HashableTests {
    typealias Target = Undefinable<Number>

    enum Number: Int, Hashable {
        case one = 1
        case two = 2
    }
}

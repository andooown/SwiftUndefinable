import Foundation
import XCTest

@testable import Undefinable

final class DecodableTests: XCTestCase {
    private let decoder = JSONDecoder()

    func testExample() throws {
        let data = """
                   {
                       "breed": "siberian"
                   }
                   """.data(using: .utf8)!
        let object = try decoder.decode(Object.self, from: data)

        XCTAssertEqual(object.breed, .defined(.siberian))
    }
}

extension DecodableTests {
    enum CatBreed: String, Decodable {
        case munchkin
        case ragdoll
        case siamese
        case siberian
    }

    struct Object: Decodable {
        let breed: Undefinable<CatBreed>
    }
}

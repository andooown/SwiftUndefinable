import Foundation
import XCTest

@testable import Undefinable

final class DecodableTests: XCTestCase {
    private let decoder = JSONDecoder()

    func testDecodingDefinedValue() throws {
        let data = """
                   {
                       "breed": "siberian"
                   }
                   """.data(using: .utf8)!

        XCTAssertEqual(try decoder.decode(Container.self, from: data).breed, .defined(.siberian))
        XCTAssertEqual(try decoder.decode(OptionalContainer.self, from: data).breed, .defined(.siberian))
    }

    func testDecodingUndefinedValue() throws {
        let data = """
                   {
                       "breed": "ragdoll"
                   }
                   """.data(using: .utf8)!

        XCTAssertEqual(try decoder.decode(Container.self, from: data).breed, .undefined("ragdoll"))
        XCTAssertEqual(try decoder.decode(OptionalContainer.self, from: data).breed, .undefined("ragdoll"))
    }

    func testDecodingFailureValue() throws {
        let data = """
                   {
                       "breed": 0
                   }
                   """.data(using: .utf8)!

        XCTAssertThrowsError(try decoder.decode(Container.self, from: data))
        XCTAssertThrowsError(try decoder.decode(OptionalContainer.self, from: data))
    }

    func testDecodingNilValue() throws {
        let data = """
                   {
                       "breed": null
                   }
                   """.data(using: .utf8)!
        XCTAssertNil(try decoder.decode(OptionalContainer.self, from: data).breed)
    }

    func testDecodingNotRepresentedValue() throws {
        let data = """
                   {
                   }
                   """.data(using: .utf8)!
        XCTAssertNil(try decoder.decode(OptionalContainer.self, from: data).breed)
    }
}

extension DecodableTests {
    enum CatBreed: String, Decodable {
        case munchkin
        case siamese
        case siberian
    }

    struct Container: Decodable {
        let breed: Undefinable<CatBreed>
    }

    struct OptionalContainer: Decodable {
        let breed: Undefinable<CatBreed>?
    }
}

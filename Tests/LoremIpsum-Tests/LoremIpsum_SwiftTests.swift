import XCTest
@testable import LoremIpsum

final class LoremIpsum_SwiftTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertTrue(String.loremIpsum(paragraphs: 1).starts(with: "Lorem"))
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}

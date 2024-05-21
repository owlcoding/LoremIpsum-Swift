import XCTest
@testable import LoremIpsum

final class LoremIpsum_SwiftTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let paragraph = String.Lorem(generate: .paragraph(num: 1, startsWithFirstSentence: true))
        XCTAssertTrue(paragraph.starts(with: "Lorem ipsum"))
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}

import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(LoremIpsum_SwiftTests.allTests),
    ]
}
#endif

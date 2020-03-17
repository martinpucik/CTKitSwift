import XCTest
import Combine
@testable import CTKitSwift

final class CTKitSwiftTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(CTKitSwift().text, "Hello, World!")
    }

    func testGetToken() {
        var bag = Set<AnyCancellable>()
        let exp = expectation(description: "token")
        API.token.execute().sink(receiveCompletion: { _ in },
                                 receiveValue: { (data, response) in
                                    print(String(data: data, encoding: .utf8))
                                    exp.fulfill()
            }).store(in: &bag)
        let result = XCTWaiter().wait(for: [exp], timeout: 5)
        XCTAssertEqual(result, .completed)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}

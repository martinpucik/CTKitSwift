import XCTest
import Combine
@testable import CTKitSwift

final class CTKitSwiftTests: XCTestCase {
    func testGetToken() {
        var bag = Set<AnyCancellable>()
        let exp = expectation(description: "token")
        let req: AnyPublisher<CTKToken, Error> = API.token.execute()
        req.sink(receiveCompletion: { _ in }, receiveValue: { (token) in
            exp.fulfill()
        }).store(in: &bag)

        let result = XCTWaiter().wait(for: [exp], timeout: 5)
        XCTAssertEqual(result, .completed)
    }

    func testGetProgrammes() {
        var bag = Set<AnyCancellable>()
        let exp = expectation(description: "programmes")
        let req: AnyPublisher<[CTKProgramme], Error> = CTKit.programmes()
        req.sink(receiveCompletion: { _ in }, receiveValue: { (prog) in
            print(prog)
            exp.fulfill()
        }).store(in: &bag)

        let result = XCTWaiter().wait(for: [exp], timeout: 5)
        XCTAssertEqual(result, .completed)
    }
}

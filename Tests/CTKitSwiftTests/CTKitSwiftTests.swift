import XCTest
import Combine
@testable import CTKitSwift

final class CTKitSwiftTests: XCTestCase {
    func testGetToken() {
        var bag = Set<AnyCancellable>()
        let exp = expectation(description: "token")
        let req = NetworkingClient.request(resource: Resource.Token())
        req.sink(receiveCompletion: { result in
            switch result {
            case .failure(let error):
                XCTFail(error.localizedDescription)
            case .finished:
                break
            }
        }, receiveValue: { (tokenResponse) in
            XCTAssertEqual(tokenResponse.token, CTKDefaults.token)
            exp.fulfill()
        }) .store(in: &bag)

        let result = XCTWaiter().wait(for: [exp], timeout: 5)
        XCTAssertEqual(result, .completed)
    }

    func testGetProgrammes() {
        var bag = Set<AnyCancellable>()
        let exp = expectation(description: "programmes")
        let req = NetworkingClient.request(resource: Resource.ProgrammeList())
        req.sink(receiveCompletion: { _ in }, receiveValue: { (prog) in
            print(prog)
            exp.fulfill()
        }).store(in: &bag)

        let result = XCTWaiter().wait(for: [exp], timeout: 5)
        XCTAssertEqual(result, .completed)
    }
}

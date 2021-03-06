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
        let req = CTKit.programmes()
        req.sink(receiveCompletion: { _ in }, receiveValue: { (prog) in
            exp.fulfill()
        }).store(in: &bag)

        let result = XCTWaiter().wait(for: [exp], timeout: 5)
        XCTAssertEqual(result, .completed)
    }

    func testGetProgrammePlaylist() {
        var bag = Set<AnyCancellable>()
        let exp = expectation(description: "programme playlist")
        let req = CTKit.programmes().flatMap { programmes -> AnyPublisher<String, Error> in
            let first = programmes.first!
            return CTKit.playlist(programmeID: first.id, isVOD: first.isVOD)
        }
        req.sink(receiveCompletion: { _ in }, receiveValue: { (prog) in
            exp.fulfill()
        }).store(in: &bag)

        let result = XCTWaiter().wait(for: [exp], timeout: 5)
        XCTAssertEqual(result, .completed)
    }
}

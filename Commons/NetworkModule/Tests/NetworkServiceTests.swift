import XCTest
@testable import NetworkModule

final class NetworkServiceTests: XCTestCase {

    var sut: NetworkService!
    var session: MockURLSession!

    override func setUp() {
        session = .init()
    }

    override func tearDown() {
        session = nil
        sut = nil
    }

    func testSendRequestSuccess() async throws {
        
        // Given
        let json = """
        "posts" : [
            some Json that will be sent verbatim and won't be decoded anyway in this request
        ]
        """

        session.expectedData = json.data(using: .utf8)
        let request = URLRequest(url: URL(string: "http://api.geonames.org/")!)
        sut = OurNetworkService(session: session)

        // When
        do {
            let result = try await sut.sendRequest(request)
            // Then
            XCTAssertNotNil(result)
            XCTAssertGreaterThan(result!.count, 0)
        } catch {
            XCTFail("Error: \(error.localizedDescription)")
        }

        XCTAssertTrue(session.didCallData)
    }

    func testSendRequestFailure() async throws {

        // Given
        session.expectedData = Data()
        let request = URLRequest(url: URL(string: "wrong")!)
        sut = OurNetworkService(session: session)

        // When
        do {
            let result = try await sut.sendRequest(request)
            XCTFail("Request should fail, got result instead: \(result!.description)")
        } catch {
            // Then
            XCTAssertTrue(error is NetworkError)
            XCTAssertEqual(error as! NetworkError, .unexpected)
        }
        XCTAssertTrue(session.didCallData)
    }
}

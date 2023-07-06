import XCTest
import Models
import Utils
@testable import NetworkModule

final class NetworkClientTests: XCTestCase {
    var sut: NetworkClient!
    var networkService: MockNetworkService!
    var jsonDecoder: JSONDecoder!

    override func setUp() {
        networkService = .init()
    }

    override func tearDown() {
        networkService = nil
        sut = nil
    }

    func testGetEndpointSuccess() async throws {

        // Given
        jsonDecoder = JSONDecoderFactory.make()
        
        let json = """
        [
          {
            "userId": 3,
            "id": 21,
            "title": "asperiores ea ipsam voluptatibus modi minima quia sint",
            "body": "repellat aliquid praesentium dolorem quo"
          },
          {
            "userId": 3,
            "id": 22,
            "title": "dolor sint quo a velit explicabo quia nam",
            "body": "eos qui et ipsum ipsam suscipit aut"
          }
        ]
        """
        networkService.expectedData = json.data(using: .utf8)

        sut = OurNetworkClient(networkService: networkService, jsonDecoder: jsonDecoder)

        // When
        do {
            let result: [Post] = try await sut.get(endpoint: .mock, params: ["userId": 1])
            // Then
            XCTAssertNotNil(result)
            XCTAssertEqual(result.count, 2)
        } catch {
            XCTFail("Error: \(error.localizedDescription)")
        }

        XCTAssertTrue(networkService.didSendRequest)
    }

    func testGetEndpointDecodingError() async throws {

        // Given
        let json = """
        {
           "posts":[
              {
                 "datetime":"2011-03-11 04:46:23
        """
        networkService.expectedData = json.data(using: .utf8)
        sut = OurNetworkClient(networkService: networkService)

        // When
        do {
            let result: [Post] = try await sut.get(endpoint: .mock, params: ["userId": 1])
            XCTFail("Request should fail, got result instead: \(result)")
        } catch {
            // Then
            XCTAssertTrue(error is NetworkError)

            if case NetworkError.decodingError = error {
            } else {
                XCTFail("Should fail with decoding error")
            }
        }

        XCTAssertTrue(networkService.didSendRequest)
    }

    func testGetEndpointNoData() async throws {

        // Given
        networkService.expectedData = nil
        sut = OurNetworkClient(networkService: networkService)

        // When
        do {
            let result: [Post] = try await sut.get(endpoint: .mock, params: ["userId": 1])
            XCTFail("Request should fail, got result instead: \(result)")
        } catch {
            // Then
            XCTAssertTrue(error is NetworkError)
            XCTAssertEqual(error as! NetworkError, .noData)
        }

        XCTAssertTrue(networkService.didSendRequest)
    }
}

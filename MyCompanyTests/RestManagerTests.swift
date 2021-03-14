//
//  MyCompanyTests.swift
//  MyCompanyTests
//
//  Created by Hoang Anh Tuan on 12/20/20.
//

import XCTest
@testable import MyCompany

class RestManagerTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_makeRequest_getData() {
        let mockURL = URL(string: "https://www.google.com")!
        let urlResponse = HTTPURLResponse(url: mockURL,
                                          statusCode: 200, httpVersion: nil, headerFields: nil)
        let mockResult = RestManager.Results(withData: Data(),
                                             response: RestManager.Response(fromURLResponse: urlResponse),
                                             error: nil)
        
        let mockSession = MockSession(result: mockResult)
        let restManager = RestManager(session: mockSession)
        
        let expectation = self.expectation(description: "")
        restManager.makeRequest(toURL: mockURL, withHttpMethod: .get) { (result) in
            XCTAssertNotNil(result.data)
            XCTAssertNil(result.error)
            XCTAssertEqual(result.response?.httpStatusCode, 200)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
}

// https://www.swiftbysundell.com/articles/mocking-in-swift/

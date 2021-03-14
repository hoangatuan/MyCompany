//
//  ServiceProtocolTest.swift
//  MyCompanyTests
//
//  Created by Hoang Anh Tuan on 12/20/20.
//

import XCTest
@testable import MyCompany

class ServiceProtocolTest: XCTestCase {
    var mockURL: URL!
    
    override func setUp() {
        super.setUp()
        mockURL = URL(string: "https://www.google.com")!
    }
    
    override func tearDown() {
        mockURL = nil
        super.tearDown()
    }

    // MARK: - Helpers
    func createRestManager(statusCode: Int, data: Data?, error: Error?) -> RestManager {
        let urlResponse = HTTPURLResponse(url: mockURL,
                                          statusCode: statusCode, httpVersion: nil, headerFields: nil)
        let mockResult = RestManager.Results(withData: data,
                                             response: RestManager.Response(fromURLResponse: urlResponse),
                                             error: error)
        
        let mockSession = MockSession(result: mockResult)
        let restManager = RestManager(session: mockSession)
        
        return restManager
    }
    
    func test_PerformRequest_EqualResult(restManager: RestManager, requestError: RequestError) {
        let expectation = self.expectation(description: "")
        
        let baseService = BaseService()
        baseService.performRequest(rest: restManager, url: mockURL, httpMethod: .get) { (data: Employee) in
            XCTFail()
        } onError: { (error) in
            XCTAssertEqual(error, requestError)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.5)
    }
    
    // MARK: - Test functions
    private func test_PerformRequest_Error() {
        let rest = createRestManager(statusCode: 404, data: Data(), error: RequestError.connectToServerFailed)
        test_PerformRequest_EqualResult(restManager: rest, requestError: RequestError.connectToServerFailed)
    }
    
    private func test_PerformRequest_NoData() {
        let rest = createRestManager(statusCode: 200, data: nil, error: nil)
        test_PerformRequest_EqualResult(restManager: rest, requestError: RequestError.serverFail)
    }
    
    private func test_PerformRequest_CallbackObjectSuccess() {
        guard let path = Bundle(for: type(of: self)).url(forResource: "employees", withExtension: "json"),
              let mockData = try? Data(contentsOf: path) else {
            XCTFail()
            return
        }
        let restManager = createRestManager(statusCode: AuthenticationService.AccountType.user.rawValue,
                                            data: mockData, error: nil)
        
        let mockService = BaseService()
        mockService.performRequest(rest: restManager, url: mockURL, httpMethod: .get, completion: { (data: Employee) in
            XCTAssertNotNil(data)
        }, onError: { _ in
            XCTFail()
        })
    }
    
    private func test_PerformRequest_DecodeFail() {
        let rest = createRestManager(statusCode: 200, data: Data(), error: nil)
        test_PerformRequest_EqualResult(restManager: rest, requestError: RequestError.serverFail)
    }
}

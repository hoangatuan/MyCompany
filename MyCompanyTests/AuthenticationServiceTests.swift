//
//  AuthenticationServiceTests.swift
//  MyCompanyTests
//
//  Created by Hoang Anh Tuan on 12/20/20.
//

import XCTest
@testable import MyCompany

enum RequestErrorMock: Error {
    case error
}

class AuthenticationServiceTests: XCTestCase {
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
    
    func test_Login_Equal_LoginResult(restManager: RestManager, result: AuthenticationService.LoginResult) {
        let expectation = self.expectation(description: "")
        AuthenticationService.shared.login(rest: restManager, username: "", password: "") { (loginResult) in
            XCTAssertEqual(loginResult, result)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.5)
    }
    
    // MARK: - Test functions
    private func test_login_makeRequestError() {
        let restManager = createRestManager(statusCode: 404, data: Data(), error: RequestErrorMock.error)
        test_Login_Equal_LoginResult(restManager: restManager, result: .serverFail)
    }
    
    private func test_login_makeRequestDataNil() {
        let restManager = createRestManager(statusCode: 404, data: nil, error: nil)
        test_Login_Equal_LoginResult(restManager: restManager, result: .serverFail)
    }
    
    private func test_login_WrongUsernamePassword() {
        let restManager = createRestManager(statusCode: 444, data: Data(), error: nil)
        test_Login_Equal_LoginResult(restManager: restManager, result: .wrongInput)
    }
    
    private func test_login_AdminLoginSuccess() {
        let restManager = createRestManager(statusCode: AuthenticationService.AccountType.admin.rawValue,
                                            data: Data(), error: nil)
        test_Login_Equal_LoginResult(restManager: restManager, result: .success)
    }
    
    private func test_login_UserLoginSuccess() {
        guard let path = Bundle(for: type(of: self)).url(forResource: "employees", withExtension: "json"),
              let mockData = try? Data(contentsOf: path) else {
            XCTFail()
            return
        }
        let restManager = createRestManager(statusCode: AuthenticationService.AccountType.user.rawValue,
                                            data: mockData, error: nil)
        test_Login_Equal_LoginResult(restManager: restManager, result: .success)
    }
    
    private func test_login_UserDecodeFail() {
        let restManager = createRestManager(statusCode: AuthenticationService.AccountType.user.rawValue,
                                            data: Data(), error: nil)
        test_Login_Equal_LoginResult(restManager: restManager, result: .decodeFail)
    }
}

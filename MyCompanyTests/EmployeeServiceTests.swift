//
//  EmployeeServiceTests.swift
//  MyCompanyTests
//
//  Created by Hoang Anh Tuan on 12/20/20.
//

import XCTest

class EmployeeServiceTests: XCTestCase {
    var mockURL: URL!
    
    override func setUp() {
        super.setUp()
        mockURL = URL(string: "https://www.google.com")!
    }

    override func tearDown() {
        mockURL = nil
        super.tearDown()
    }

    // MARK: - Test functions
    private func test_GetAllEmployeeInfo_ConnectFail() {
        
    }
}

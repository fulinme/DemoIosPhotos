//
//  DemoTests.swift
//  DemoTests
//
//  Created by jack on 10/4/20.
//  Copyright © 2020 fl. All rights reserved.
//

//Test Naming Style/convention
//testAppName_contidion_assertion()
//give then then
//TDD is a process


import XCTest
@testable import Demo

class DemoTests: XCTestCase {

    var sut: URLSession!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = URLSession(configuration: .default)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        
    }
    
    func testValidCallToGetPhotosRequestCompletes() {
       
        //give
        let url = URL(string: WebServiceUrls.URL_jsonplaceholder_photos)!
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        // when
        let dataTask = sut.dataTask(with: url) { data, response, error in
            
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
    
        dataTask.resume()
        wait(for: [promise], timeout: 5)
        
        //then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
        
    }
    
    
    func testValidCallWebServiceSuccess() {
        
        let promise = expectation(description: "GetPhotos success")
        var isSuccess = false
        
        WebService.getPhotosRequest(successHandler: { photosArray in
            isSuccess = true
            promise.fulfill()
        }, failureHandler: {
            isSuccess = false
        })
        
        wait(for: [promise], timeout: 5)
        
        XCTAssertTrue(isSuccess)
        
    }
    
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

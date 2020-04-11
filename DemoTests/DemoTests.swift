//
//  DemoTests.swift
//  DemoTests
//
//  Created by jack on 10/4/20.
//  Copyright © 2020 fl. All rights reserved.
//

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
    
    func testValidCallToGetPhotosRequestHTTPStatusCode200() {
        
        let url = URL(string: WebServiceUrls.URL_jsonplaceholder_photos)!
        let promise = expectation(description: "Status code: 200")
        
        // when
        let dataTask = sut.dataTask(with: url) { data, response, error in
          // then
          if let error = error {
            XCTFail("Error: \(error.localizedDescription)")
            return
          } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
            if statusCode == 200 {
              // 2
              promise.fulfill()
            } else {
              XCTFail("Status code: \(statusCode)")
            }
          }
        }
        dataTask.resume()
        // 3
        wait(for: [promise], timeout: 5)
        
    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

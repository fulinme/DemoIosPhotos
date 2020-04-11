//
//  DemoTests.swift
//  DemoTests
//
//  Created by jack on 10/4/20.
//  Copyright © 2020 fl. All rights reserved.
//

import XCTest
@testable import Demo

class PhotosViewTests: XCTestCase {

   
    
    override func setUpWithError() throws {
         
    }

    override func tearDownWithError() throws {
        
        
    }
    
    func testValidCallGetPhotosRequest() {
        
        let promise = expectation(description: "WebService.getPhotosRequest: success")
        
        WebService.getPhotosRequest(successHandler: { photosArray in
             promise.fulfill()
        }, failureHandler: {
             XCTFail("Error: WebService.getPhotosRequest")
        })
        
        
        wait(for: [promise], timeout: 5)
        
    }
    
    
     
    
 

}

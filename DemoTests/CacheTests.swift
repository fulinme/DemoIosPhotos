//
//  CacheTests.swift
//  DemoTests
//
//  Created by jack on 13/4/20.
//  Copyright © 2020 fl. All rights reserved.
//

import XCTest
@testable import Demo

class CacheTests: XCTestCase {


    override func setUpWithError() throws {
           // Put setup code here. This method is called before the invocation of each test method in the class.
           sut = URLSession(configuration: .default)
       }

    override func tearDownWithError() throws {
           // Put teardown code here. This method is called after the invocation of each test method in the class.
           sut = nil
           
    }






}

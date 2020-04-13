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

    var sut: ImageCache!
    
    var image: UIImage!
    
    
    var thumbnailUrl = "https://via.placeholder.com/150/92c952"
    
    override func setUpWithError() throws {
        sut = ImageCache()
        
        image = UIImage(contentsOfFile: Bundle(for: type(of: self)).path(forResource: "thumbnail", ofType: "png")!)
        
        sut.deleteImage(forKey: thumbnailUrl)
    }

    override func tearDownWithError() throws {
        sut = nil
        image = nil
    }
    

    
    
    
    func testDemoCacheImageSetSuccess() {
        
        sut.setImage(image!, forKey: thumbnailUrl)
    
        XCTAssertNotNil(sut.image(forKey: thumbnailUrl))
        
    }
    
    
    






}

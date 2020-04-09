//
//  Photos.swift
//  Demo
//
//  Created by jack on 10/4/20.
//  Copyright © 2020 fl. All rights reserved.
//

import Foundation


struct photo: Codable {
    let albumID, id: Int?
    let title: String?
    let url, thumbnailURL: String?

    enum CodingKeys: String, CodingKey {
        case albumID
        case id, title, url
        case thumbnailURL
    }
}

 

typealias photos = [photo]


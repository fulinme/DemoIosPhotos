//
//  WebService.swift
//  Demo
//
//  Created by jack on 10/4/20.
//  Copyright © 2020 fl. All rights reserved.
//
import UIKit

struct WebServiceUrls {
    static let URL_jsonplaceholder_photos = "http://jsonplaceholder.typicode.com/photos"
 
}

class WebService {
    
    static let imageCache = ImageCache()
    
    static let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
        }()
    
    
    static func getPhotosRequest(successHandler: @escaping (_ photosArray: [String]) -> Void, failureHandler: @escaping () -> Void) {
    
        let url = URL(string: WebServiceUrls.URL_jsonplaceholder_photos)!
        
        let task = session.dataTask(with: url) {
               (data, response, error) -> Void in
      
            if let jsonData = data {
                let decoder = JSONDecoder()
                   do {
                       let photos = try decoder.decode([photo].self, from: jsonData)
                
                       let photosStrArray = photos.compactMap { $0.thumbnailURL }
                       
                       OperationQueue.main.addOperation {
                         successHandler(photosStrArray)
                       }
                   }
                   catch {
                     OperationQueue.main.addOperation {
                        failureHandler()
                     }
                   }
            }
            else {
                OperationQueue.main.addOperation {
                    failureHandler()
                }
            }
            
        }
        
        task.resume()
        
    }
    
    
    static func fetchImage(photoURL: String, successHandler: @escaping (UIImage) -> Void, failureHandler: @escaping () -> Void) {
        
        if let image = imageCache.image(forKey: photoURL) {
            OperationQueue.main.addOperation {
                successHandler(image)
            }
        }
        
        let task = session.dataTask(with: URL(string: photoURL)!) {
               (data, response, error) -> Void in
               
            
            if let imageData = data, let image = UIImage(data: imageData) {
                
                self.imageCache.setImage(image, forKey: photoURL)
                
                OperationQueue.main.addOperation {
                    successHandler(image)
                }
                
            }
            else {
                
                OperationQueue.main.addOperation {
                     failureHandler()
                }
               
            }
            
        }
        
        task.resume()
        
        
    }
    
    
    
}

//
//  PhotosPresenter.swift
//  Demo
//
//  Created by jack on 10/4/20.
//  Copyright © 2020 fl. All rights reserved.
//

import Foundation


protocol PhotosPresenterProtocol {
    
    func getPhotoList()
    
    func fetchPhoto(photoUrlString: String, index: Int)
}



class PhotosPresenter {
    

    weak var view: PhotosViewProtocol?
    
    let session = URLSession.shared
    
    required init(view: PhotosViewProtocol) {
        self.view = view
    }
    
    
}


extension PhotosPresenter : PhotosPresenterProtocol {
    
   
    
    func getPhotoList() {
         
      
        let url = URL(string: "http://jsonplaceholder.typicode.com/photos")
        
         //UIApplication.shared.isNetworkActivityIndicatorVisible = true
        var dataTask: URLSessionDataTask?
        
        dataTask = session.dataTask(with: url!) {
            data, response, error in
            
            
            /*DispatchQueue.main.async {
              UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }*/
            
            if let error = error {
                print(error.localizedDescription)
            } else if let httpResponse = response as? HTTPURLResponse {
            
                if httpResponse.statusCode == 200 {
                    
                    let decoder = JSONDecoder()
                    do {
                        let photos = try decoder.decode([photo].self, from: data!)
                 
                        let photosStrArray = photos.compactMap { $0.thumbnailURL }
                        
                        DispatchQueue.main.async {
                            self.view?.receivedPhotos(photosArray: photosStrArray)
                        }
                    }
                    catch {
                        print(error)
                    }
                    
                }
            }
            
        }
        
        dataTask?.resume()
        
    }
    
    
    
    func fetchPhoto(photoUrlString: String, index: Int) {
       
        WebService.fetchImage(photoURL: photoUrlString, successHandler: {
            uiImage in
            
            self.view?.receivedPhoto(uiImage: uiImage, index: index)
            
        }, failureHandler: {
                
                
        })
        
        
        
    }
    
    
}

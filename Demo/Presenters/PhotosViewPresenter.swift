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
    
    required init(view: PhotosViewProtocol) {
        self.view = view
    }
    
    
    
}


extension PhotosPresenter : PhotosPresenterProtocol {
    
    
    func getPhotoList() {
         
        WebService.getPhotosRequest(successHandler: { photos in
                self.view?.receivedPhotoList(photosArray: photos)
            }, failureHandler: {
                self.view?.failedReceivedPhotoList()
        })
        
        
    }
    
    
    
    func fetchPhoto(photoUrlString: String, index: Int) {
       
        WebService.fetchImage(photoURL: photoUrlString, successHandler: {
            uiImage in
            
            self.view?.receivedPhoto(uiImage: uiImage, index: index)
            
        }, failureHandler: {
            self.view?.failedReceivedPhoto()
                
        })
        
        
        
    }
    
    
}

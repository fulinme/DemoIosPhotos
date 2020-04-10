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
    
    func downloadPhoto()
}



class PhotosPresenter {
    

    weak var view: PhotosViewProtocol?
    

    required init(view: PhotosViewProtocol) {
        self.view = view
    }
    
    
}


extension PhotosPresenter : PhotosPresenterProtocol {
   
    
    func getPhotoList() {
         
    }
    
    
    func downloadPhoto() {
        
    }
    
    
}

//
//  ViewController.swift
//  Demo
//
//  Created by jack on 10/4/20.
//  Copyright © 2020 fl. All rights reserved.
//

import UIKit

protocol PhotosViewProtocol : AnyObject {
    
    func receivedPhotos()
    
    func receivedPhoto()
}

class PhotosViewController: UIViewController {

    fileprivate lazy var presenter : PhotosPresenter = {
        return PhotosPresenter(view: self)
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.getPhotoList()
        
        // Do any additional setup after loading the view.
    }


}



extension PhotosViewController: PhotosViewProtocol {
   
    
    func receivedPhotos() {
        
    }
    
    func receivedPhoto() {
        
    }
    
    
    
}

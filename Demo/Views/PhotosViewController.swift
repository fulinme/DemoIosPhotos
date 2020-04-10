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
    
    

    var data : [String] = ["https://via.placeholder.com/150/92c952", "https://via.placeholder.com/150/771796"]
    
    fileprivate lazy var presenter : PhotosPresenter = {
        return PhotosPresenter(view: self)
    }()
    
    
 
    @IBOutlet weak var photosUICollectionView: UICollectionView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.getPhotoList()
        
        // Do any additional setup after loading the view.
        
        photosUICollectionView.register(UINib(nibName: "PhotosUICollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotosUICollectionViewCell")
        
        
    
        photosUICollectionView.dataSource = self
        photosUICollectionView.delegate = self
 
    }


}


extension PhotosViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosUICollectionViewCell", for: indexPath) as! PhotosUICollectionViewCell
        
        cell.setData()
        
        return cell
    }
}

extension PhotosViewController: UICollectionViewDelegate {



}




extension PhotosViewController: PhotosViewProtocol {
   
    
    func receivedPhotos() {
        
    }
    
    func receivedPhoto() {
        
    }
    
    
    
}




//
//  ViewController.swift
//  Demo
//
//  Created by jack on 10/4/20.
//  Copyright © 2020 fl. All rights reserved.
//

import UIKit

protocol PhotosViewProtocol : AnyObject {
    
    func receivedPhotos(photosArray: [String])
    
    func receivedPhoto(uiImage: UIImage, index: Int)
}


class PhotosViewController: UIViewController {
    
    

    var data : [String] = []
    
    fileprivate lazy var presenter : PhotosPresenter = {
        return PhotosPresenter(view: self)
    }()
    
    
 
    @IBOutlet weak var photosUICollectionView: UICollectionView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        photosUICollectionView.register(UINib(nibName: "PhotosUICollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotosUICollectionViewCell")
        photosUICollectionView.dataSource = self
        photosUICollectionView.delegate = self
        
        
        presenter.getPhotoList()
 
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
        
        
        return cell
    }
    
    
   
    
}

extension PhotosViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
           
        let photo = data[indexPath.row]
        
        presenter.fetchPhoto(photoUrlString: photo, index: indexPath.row)
        
        
       }
    
    
    

}




extension PhotosViewController: PhotosViewProtocol {
    
    func receivedPhotos(photosArray: [String]) {
        
        print("***receivedphotos****")
        data = photosArray
       
        self.photosUICollectionView.reloadData()
        
    }
    
    
    
    func receivedPhoto(uiImage: UIImage, index: Int) {
        
        let photoIndexPath = IndexPath(item: index, section: 0)

        if let cell = self.photosUICollectionView.cellForItem(at: photoIndexPath)
          as? PhotosUICollectionViewCell {
            cell.setData(with: uiImage)
        }
        
    }
    
    
    
}




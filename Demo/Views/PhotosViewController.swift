//
//  ViewController.swift
//  Demo
//
//  Created by jack on 10/4/20.
//  Copyright © 2020 fl. All rights reserved.
//

import UIKit

protocol PhotosViewProtocol : AnyObject {
    
    func receivedPhotoList(photosArray: [String])
    func failedReceivedPhotoList()
    
    func receivedPhoto(uiImage: UIImage, index: Int)
    func failedReceivedPhoto()
}


class PhotosViewController: UIViewController {
    
    var data : [String] = []
    
    fileprivate lazy var presenter : PhotosPresenter = {
        return PhotosPresenter(view: self)
    }()
    
 
    @IBOutlet weak var photosUICollectionView: UICollectionView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        loadPhotoList()
 
    }
    
    func loadPhotoList() {
        indicatorView.startAnimating()
        presenter.getPhotoList()
    }
    
    
    func setupUI() {
        photosUICollectionView.register(PhotosUICollectionViewCell.nib(), forCellWithReuseIdentifier: PhotosUICollectionViewCell.identifier)
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosUICollectionViewCell.identifier, for: indexPath) as! PhotosUICollectionViewCell
        
        
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
  
    func receivedPhotoList(photosArray: [String]) {
        data = photosArray
        indicatorView.stopAnimating()
        self.photosUICollectionView.reloadSections(IndexSet(integer: 0))
    }
    
    func failedReceivedPhotoList() {
        indicatorView.stopAnimating()
    }
    
    
    func receivedPhoto(uiImage: UIImage, index: Int) {
        
        let photoIndexPath = IndexPath(item: index, section: 0)

        if let cell = self.photosUICollectionView.cellForItem(at: photoIndexPath)
          as? PhotosUICollectionViewCell {
            cell.update(with: uiImage)
        }
        
    }
    
    func failedReceivedPhoto() {
        
       }
    
    
    
}




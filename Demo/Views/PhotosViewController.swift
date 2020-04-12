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
    
    struct CollectionViewCfg {
         static let inset: CGFloat = 10
         static let minimumLineSpacing: CGFloat = 10
         static let minimumInteritemSpacing: CGFloat = 10
         static let cellsPerRowForPortrait = 4
         static let cellsPerRowForLandscape = 6
    }
    
    
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
      
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadPhotoList()
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if let layout = photosUICollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.invalidateLayout()
        }
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


extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           
        
        let cellsPerRow = UIApplication.shared.statusBarOrientation.isPortrait ? CollectionViewCfg.cellsPerRowForPortrait : CollectionViewCfg.cellsPerRowForLandscape
            
        
        let marginsAndInsets = CollectionViewCfg.inset * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + CollectionViewCfg.minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
        return CGSize(width: itemWidth, height: itemWidth)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: CollectionViewCfg.inset, left: CollectionViewCfg.inset, bottom: CollectionViewCfg.inset, right: CollectionViewCfg.inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CollectionViewCfg.minimumInteritemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CollectionViewCfg.minimumLineSpacing
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




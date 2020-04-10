//
//  photosUICollectionViewCell.swift
//  Demo
//
//  Created by jack on 10/4/20.
//  Copyright © 2020 fl. All rights reserved.
//

import UIKit

class PhotosUICollectionViewCell: UICollectionViewCell {

 

    @IBOutlet var uiImageView: UIImageView!
    
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setData(with: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        setData(with: nil)
    }
    
    func setData(with image: UIImage?) {
           if let imageToDisplay = image {
               indicatorView.stopAnimating()
               uiImageView.image = imageToDisplay
           } else {
               indicatorView.startAnimating()
               uiImageView.image = nil
           }
    }
    
    
     

}

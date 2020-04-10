//
//  photosUICollectionViewCell.swift
//  Demo
//
//  Created by jack on 10/4/20.
//  Copyright © 2020 fl. All rights reserved.
//

import UIKit

class PhotosUICollectionViewCell: UICollectionViewCell {

    static let identifier = "PhotosUICollectionViewCell"

    @IBOutlet var uiImageView: UIImageView!
    
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        update(with: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        update(with: nil)
    }
    
    func update(with image: UIImage?) {
           if let imageToDisplay = image {
               indicatorView.stopAnimating()
               uiImageView.image = imageToDisplay
           } else {
               indicatorView.startAnimating()
               uiImageView.image = nil
           }
    }
    
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    
     

}

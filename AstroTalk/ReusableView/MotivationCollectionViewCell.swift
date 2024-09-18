//
//  MotivationCollectionViewCell.swift
//  AstroTalk
//
//  Created by Aisha on 02.08.24.
//

import UIKit
import Kingfisher

class MotivationCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var motivationImageView: UIImageView!
 
    func configure(with message: MotivationMessage) {
            let placeholderImage = UIImage(named: "placeholderImage")
            
            if let imageUrlString = message.imageName, let imageUrl = URL(string: imageUrlString) {
                motivationImageView.kf.setImage(with: imageUrl, placeholder: placeholderImage)
            } else {
                motivationImageView.image = placeholderImage
            }
        }
    }


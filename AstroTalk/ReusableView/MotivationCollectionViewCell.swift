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
//    
//    func configure(with message: MotivationMessage) {
//            if let image = UIImage(named: message.imageName) {
//                motivationImageView.image = image
//            } else {
//                motivationImageView.image = UIImage(named: "placeholderImage")
//            }
//        }
//    }  
    func configure(with message: MotivationMessage) {
        if let imageUrl = URL(string: message.imageName) {
            motivationImageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: "placeholderImage"))
        } else {
            motivationImageView.image = UIImage(named: "placeholderImage")
        }
    }
}



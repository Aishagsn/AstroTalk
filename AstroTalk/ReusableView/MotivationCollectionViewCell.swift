//
//  MotivationCollectionViewCell.swift
//  AstroTalk
//
//  Created by Aisha on 02.08.24.
//

import UIKit

class MotivationCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var motivationImageView: UIImageView!
    
    func configure(with message: MotivationMessage) {
        motivationImageView.image = UIImage(named: message.imageName)
    }
}


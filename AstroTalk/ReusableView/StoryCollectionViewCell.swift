//
//  StoryCollectionViewCell.swift
//  AstroTalk
//
//  Created by Aisha on 02.08.24.
//

import UIKit
import Kingfisher

class StoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var zodiacSignImageView: UIImageView!
    
    override func awakeFromNib() {
            super.awakeFromNib()
            profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
            profileImageView.clipsToBounds = true
        }
        
        func configure(with story: Story) {
            if let profileImageUrl = URL(string: story.profileImageName) {
                profileImageView.kf.setImage(with: profileImageUrl)
            } else {
                profileImageView.image = UIImage(named: story.profileImageName)
            }
            if let zodiacImageUrl = URL(string: story.zodiacSignImageName) {
                zodiacSignImageView.kf.setImage(with: zodiacImageUrl)
            } else {
                zodiacSignImageView.image = UIImage(named: story.zodiacSignImageName)
            }
        }
    }

//
//  StoryCollectionViewCell.swift
//  AstroTalk
//
//  Created by Aisha on 02.08.24.
//

import UIKit

class StoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var zodiacSignImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds = true
    }
    
    func configure(with story: Story) {
        profileImageView.image = UIImage(named: story.profileImageName)
        zodiacSignImageView.image = UIImage(named: story.zodiacSignImageName)
    }
}


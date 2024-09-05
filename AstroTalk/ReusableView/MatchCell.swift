//
//  MatchCell.swift
//  AstroTalk
//
//  Created by Aisha on 30.08.24.
//

import UIKit

class MatchCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
               profileImageView.clipsToBounds = true
           }
           
           func configure(with match: Match) {
               nameLabel.text = match.name
               ageLabel.text = "\(match.age)"
              
               if let url = URL(string: match.imageUrl) {
                   profileImageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholderImage"))
               } else {
                   profileImageView.image = UIImage(named: "placeholderImage")
               }
           }
       }

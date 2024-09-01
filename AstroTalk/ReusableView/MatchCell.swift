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
        // Customize your cell UI here (e.g., round the image view)
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds = true
    }
    
    func configure(with match: Match) {
        nameLabel.text = match.name
        ageLabel.text = "\(match.age)"
        
        // Load image asynchronously
        if let url = URL(string: match.imageUrl) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    DispatchQueue.main.async {
                        self.profileImageView.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
    }
}

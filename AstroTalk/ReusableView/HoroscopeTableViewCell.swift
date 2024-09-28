//
//  HoroscopeTableViewCell.swift
//  AstroTalk
//
//  Created by Aisha on 18.09.24.
//

import UIKit
import Kingfisher

class HoroscopeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var horoscopeImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    func configure(with horoscope: Horoscope) {
//        if let imageUrlString = horoscope.image, let imageUrl = URL(string: imageUrlString) {
//            horoscopeImage.kf.setImage(with: imageUrl, placeholder: UIImage(named: "placeholderImage"))
//        } else {
//            horoscopeImage.image = UIImage(named: "placeholderImage")
//        }
//        nameLabel.text = horoscope.horoscopeName ?? "Unknown Horoscope"
//    }
    
    func configure(with horoscope: Horoscope) {
        if let imageUrlString = horoscope.image {
            let fullImageUrlString = "http://35.223.201.116:8088/files/" + imageUrlString
            if let fullImageUrl = URL(string: fullImageUrlString) {
                horoscopeImage.kf.setImage(with: fullImageUrl, placeholder: UIImage(named: "placeholderImage"))
            } else {
                horoscopeImage.image = UIImage(named: "placeholderImage")
            }
        } else {
            horoscopeImage.image = UIImage(named: "placeholderImage")
        }
        
        nameLabel.text = horoscope.horoscopeName ?? "Unknown Horoscope"
    }

}

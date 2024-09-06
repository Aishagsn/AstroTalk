//
//  PlanetTableViewCell.swift
//  AstroTalk
//
//  Created by Aisha on 06.09.24.
//

import UIKit
import Kingfisher

class PlanetTableViewCell: UITableViewCell {

    @IBOutlet weak var planetImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var informationLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    func configure(with planet: Planet) {
            nameLabel.text = planet.name
            informationLabel.text = planet.about
            
        if let url = URL(string: planet.image) {
                    planetImage.kf.setImage(with: url)
                }
            }
        }
    

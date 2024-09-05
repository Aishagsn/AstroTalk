//
//  PostTableViewCell.swift
//  AstroTalk
//
//  Created by Aisha on 02.08.24.
//

import UIKit
import Kingfisher

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postContentLabel: UILabel!
    @IBOutlet weak var postTimeLabel: UILabel!
    
    override func awakeFromNib() {
            super.awakeFromNib()
        }
        
    func configure(with post: Post) {
        postContentLabel.text = post.content
        postTimeLabel.text = post.timeAgo
        
        if let imageUrl = URL(string: post.imageName) {
            postImageView.kf.setImage(with: imageUrl)
        } else {
            postImageView.image = UIImage(named: "placeholder")
        }
    }

    }

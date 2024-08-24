//
//  PostTableViewCell.swift
//  AstroTalk
//
//  Created by Aisha on 02.08.24.
//

import UIKit

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
        postImageView.image = UIImage(named: post.imageName)
    }
}

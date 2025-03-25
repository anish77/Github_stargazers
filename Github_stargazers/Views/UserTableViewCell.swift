//
//  UserTableViewCell.swift
//  Github_stargazers
//
//  Created by Ana Cvasniuc on 24/03/25.
//

import UIKit
import SDWebImage

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellView()
    }

    func cellView() {
         
          photo.layer.cornerRadius = photo.frame.size.width / 2
          viewCell.layer.cornerRadius = 16
          
    }
    
    func configure(with userName: String, imageUrl: String) {
        
        self.userName.text = userName
        self.photo.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(systemName: "person.circle"))
    }
    
}

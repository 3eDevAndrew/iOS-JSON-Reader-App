//
//  CustomPostCell.swift
//  CodeChallenge
//
//  Created by Andrew Vasquez on 9/8/16.
//

import UIKit

class CustomPostCell: UITableViewCell {

    @IBOutlet weak var postedText: UILabel!    
    @IBOutlet weak var postName: UILabel!
    @IBOutlet weak var avatarUIImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

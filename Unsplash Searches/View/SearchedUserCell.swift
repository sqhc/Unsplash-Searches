//
//  SearchedUserCell.swift
//  Unsplash Searches
//
//  Created by 沈清昊 on 3/26/23.
//

import UIKit

class SearchedUserCell: UITableViewCell {
    @IBOutlet weak var UserProfileImageView: UIImageView!
    @IBOutlet weak var UserNameLabel: UILabel!
    @IBOutlet weak var RealNameLabel: UILabel!
    @IBOutlet weak var IDLabel: UILabel!
    @IBOutlet weak var updatedDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var cellModel: SearchedUserCellModel?{
        didSet{
            UserNameLabel.text = cellModel?.userName
            RealNameLabel.text = cellModel?.realName
            IDLabel.text = cellModel?.id
            updatedDateLabel.text = cellModel?.updatedDate
        }
    }
}

//
//  CollectionLoadingCell.swift
//  Unsplash Searches
//
//  Created by 沈清昊 on 3/29/23.
//

import UIKit

class CollectionLoadingCell: UITableViewCell {
    @IBOutlet weak var loadActivity: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

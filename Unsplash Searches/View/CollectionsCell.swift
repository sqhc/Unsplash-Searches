//
//  CollectionsCell.swift
//  Unsplash Searches
//
//  Created by 沈清昊 on 3/24/23.
//

import UIKit

class CollectionsCell: UITableViewCell {
    @IBOutlet weak var collectionTitleLabel: UILabel!
    @IBOutlet weak var collectionIDLabel: UILabel!
    @IBOutlet weak var collectionDescriptionLabel: UILabel!
    @IBOutlet weak var collectionPublishTimeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var cellViewModel: CollectionsCellViewModel?{
        didSet{
            collectionTitleLabel.text = cellViewModel?.title
            collectionIDLabel.text = cellViewModel?.id
            collectionDescriptionLabel.text = cellViewModel?.description
            collectionPublishTimeLabel.text = cellViewModel?.publishTime
        }
    }
}

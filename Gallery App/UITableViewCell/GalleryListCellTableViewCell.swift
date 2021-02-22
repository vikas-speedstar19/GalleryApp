//
//  GalleryListCellTableViewCell.swift
//  Gallery App
//
//  Created by monty on 22/02/21.
//

import UIKit

class GalleryListCellTableViewCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet weak var galleryImageView: UIImageView!
    @IBOutlet weak var imageNameLabel: UILabel!
    @IBOutlet weak var imageDateLabel: UILabel!

    // MARK: - Cell Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

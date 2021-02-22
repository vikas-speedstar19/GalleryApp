//
//  GalleryListCellCollectionViewCell.swift
//  Gallery App
//
//  Created by monty on 22/02/21.
//

import UIKit

class GalleryListCellCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets

    @IBOutlet weak var galleryImageView: UIImageView!
    @IBOutlet weak var imageNameLabel: UILabel!
    @IBOutlet weak var imageDateLabel: UILabel!

    // MARK: - Cell Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

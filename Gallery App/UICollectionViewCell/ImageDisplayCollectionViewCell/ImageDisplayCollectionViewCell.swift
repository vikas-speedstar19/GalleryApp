//
//  ImageDisplayCollectionViewCell.swift
//  Gallery App
//
//  Created by monty on 22/02/21.
//

import UIKit

class ImageDisplayCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets

    @IBOutlet weak var galleryImageView: UIImageView!

    // MARK: - Cell Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: - Cell Helper

    func generateCell(data: PhotoModel) {
        let id = data.id ?? ""
        let secret = data.secret ?? ""
        let serverId = data.server ?? ""
        let imageURL = URL(string: "https://live.staticflickr.com/\(serverId)/\(id)_\(secret)_w.jpg")
        galleryImageView.setImage(imageURL: imageURL)
    }

}

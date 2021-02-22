//
//  GalleryDataModel.swift
//  Gallery App
//
//  Created by monty on 22/02/21.
//

import Foundation

struct GalleryDataModel: Codable {

    // MARK: - Properties

    let photos: PhotosDetailModel?
    let stat: String?

    // MARK: - Coding

    enum CodingKeys: String, CodingKey {
        case photos = "photos"
        case stat = "stat"
    }

}

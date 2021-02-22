//
//  PhotoModel.swift
//  Gallery App
//
//  Created by monty on 22/02/21.
//

import Foundation

struct PhotosDetailModel: Codable {
    
    // MARK: - Properties
    
    let page: Int?
    let pages: Int?
    let perpage: Int?
    let total: String?
    let photo: [PhotoModel]?
    
    // MARK: - Coding
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case pages = "pages"
        case perpage = "perpage"
        case total = "total"
        case photo = "photo"
    }
}

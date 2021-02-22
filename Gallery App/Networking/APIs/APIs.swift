//
//  APIs.swift
//  Gallery App
//
//  Created by monty on 22/02/21.
//

import Foundation
import Alamofire

class APIs {

    static func getPhotos(pageSize: Int, pageNumber: Int, completion: @escaping (GalleryDataModel?) -> (Void)) {
        let apiKey = "bee3f30cc36b07697c9e3a94ce227233"
        let api = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&tags=cats&page=\(pageNumber)&format=json&nojsoncallback=1&per_page=\(pageSize)"
        AF.request(api).responseDecodable {
            (response: DataResponse<GalleryDataModel, AFError>) in
            let result = response.result
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }

}

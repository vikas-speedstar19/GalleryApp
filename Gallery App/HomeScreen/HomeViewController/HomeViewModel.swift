//
//  HomeViewModel.swift
//  Gallery App
//
//  Created by monty on 22/02/21.
//

import Foundation

protocol HomeViewModelDelegate: class {

    func displayPhotos()

}

class HomeViewModel {

    // MARK: - Properties

    var isMore: Bool = false
    var isWaiting: Bool = false
    var currentPageCount: Int = 0
    var currentPage: Int = 0
    var totalPageCount: Int = 0
    var pageSize: Int = 10

    private var galleryImagesData: GalleryDataModel?
    private var photos: [PhotoModel]? = []
    weak var delegate: HomeViewModelDelegate? = nil

    // MARK: - View Model Methods

    func fetchGalleryImages() {
        isWaiting = true
        APIs.getPhotos(pageSize: pageSize, pageNumber: currentPage, completion: { (photos) -> (Void) in
            self.isWaiting = false
            self.totalPageCount = photos?.photos?.pages ?? 0
            self.currentPageCount = photos?.photos?.page ?? 0
            self.galleryImagesData = photos
            self.photos?.append(contentsOf: photos?.photos?.photo ?? [])
            if self.currentPageCount < self.totalPageCount {
                self.currentPage += 1
                self.isMore = true
            } else {
                self.isMore = false
            }
            self.delegate?.displayPhotos()
        })
    }

    // MARK: - Private Helpers

    func getAllPhotos() -> [PhotoModel] {
        return photos ?? []
    }

    func configueTableCell(indexPath: IndexPath, cell: GalleryListCellTableViewCell) {
        let id = photos?[indexPath.row].id ?? ""
        let secret = photos?[indexPath.row].secret ?? ""
        let serverId = photos?[indexPath.row].server ?? ""
        let imageURL = "https://live.staticflickr.com/\(serverId)/\(id)_\(secret)_w.jpg"
        cell.galleryImageView.setImage(imageURL: URL(string: imageURL))
        cell.imageNameLabel.text = photos?[indexPath.row].title ?? "N/A"
        cell.imageDateLabel.text = "Some Date"
    }

    func configureCollectionCell(indexPath: IndexPath, cell: GalleryListCellCollectionViewCell) {
        let id = photos?[indexPath.row].id ?? ""
        let secret = photos?[indexPath.row].secret ?? ""
        let serverId = photos?[indexPath.row].server ?? ""
        let imageURL = URL(string: "https://live.staticflickr.com/\(serverId)/\(id)_\(secret)_w.jpg")
        cell.galleryImageView.setImage(imageURL: imageURL)
        cell.imageNameLabel.text = photos?[indexPath.row].title ?? "N/A"
        cell.imageDateLabel.text = "Some Date"
    }

}

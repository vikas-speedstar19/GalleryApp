//
//  ImageDisplayViewController.swift
//  Gallery App
//
//  Created by monty on 22/02/21.
//

import UIKit

class ImageDisplayViewController: UIViewController {

    // MARK: - Constants

    private let cellIdentifier = "ImageDisplayCollectionViewCell"

    // MARK: - IBOutlets

    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Properties

    var indexPath: IndexPath? = nil
    var photos: [PhotoModel] = []

    // MARK: - View Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    // MARK: - Private Helper Methods

    private func setupUI() {
        let indexPath = self.indexPath ?? IndexPath(row: 0, section: 0)
        title = photos[indexPath.row].title ?? "N/A"
        setupCollectionView()
    }

    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: self.indexPath ?? IndexPath(item: 0, section: 0),
                                             at: .centeredHorizontally,
                                             animated: false)
        }
    }

}

// MARK: - UICollectionViewDataSource

extension ImageDisplayViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ImageDisplayCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.generateCell(data: photos[indexPath.row])
        return cell
    }

}

// MARK: - UICollectionViewDelegateFlowLayout

extension ImageDisplayViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

}

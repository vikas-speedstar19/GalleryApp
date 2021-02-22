//
//  ViewController.swift
//  Gallery App
//
//  Created by monty on 22/02/21.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Constants

    private let navigationTitle = "Gallery App"
    private let tableViewCellHeight: CGFloat = 90.0
    private let tableCellIdentifier = "GalleryListCellTableViewCell"
    private let collectionCellIdentifier = "GalleryListCellCollectionViewCell"
    private let galleryItemCellSize = CGSize(width: 200.0, height: 180.0)
    private let galleryItemCellSpacing: CGFloat = 8.0
    private let listModeTitle = "Switch"
    private let gridModeTitle = "Grid Mode"
    private var isListMode: Bool = false

    // MARK: - Properties

    var viewModel: HomeViewModel? = nil

    // MARK: - IBOutlets

    @IBOutlet weak var tableViewHolder: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionViewHolder: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - View Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupViewModelAndFetchPhotos()
        showCollectionView()
    }

    // MARK: - Private Helpers

    private func setupUI() {
        setupNavigationBar()
        setupTableView()
        setupCollectionView()
    }


    private func setupNavigationBar() {
        title = navigationTitle

        let listSwitchBarButton = UIBarButtonItem(title: listModeTitle, style: .plain, target: self, action: #selector(switchGalleryMode))
        navigationItem.rightBarButtonItem = listSwitchBarButton
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: tableCellIdentifier, bundle: nil),
                           forCellReuseIdentifier: tableCellIdentifier)
        tableView.tableFooterView = UIView()
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: collectionCellIdentifier, bundle: nil), forCellWithReuseIdentifier: collectionCellIdentifier)

        let numberOfItemsPerRow: CGFloat = 3
        let screenWidth = floor((UIScreen.main.bounds.width - 40) - (numberOfItemsPerRow - 1) * galleryItemCellSpacing)
        let width: CGFloat = screenWidth / numberOfItemsPerRow
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.itemSize = CGSize(width: CGFloat(width), height: CGFloat(galleryItemCellSize.height))
        collectionViewFlowLayout.sectionInset = .zero
        collectionViewFlowLayout.minimumLineSpacing = galleryItemCellSpacing
        collectionViewFlowLayout.minimumInteritemSpacing = galleryItemCellSpacing
        collectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
    }

    private func setupViewModelAndFetchPhotos() {
        viewModel = HomeViewModel()
        viewModel?.delegate = self
        showLoadingView()
        viewModel?.fetchGalleryImages()
    }

    private func showTableView() {
        tableViewHolder.isHidden = false
        collectionViewHolder.isHidden = true
    }

    private func showCollectionView() {
        tableViewHolder.isHidden = true
        collectionViewHolder.isHidden = false
    }

    private func showLoadingView() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        tableView.isHidden = tableView.isHidden
        collectionView.isHidden = collectionView.isHidden
    }

    private func hideLoadingView() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        tableView.isHidden = tableView.isHidden
        collectionView.isHidden = collectionView.isHidden
    }

    private func displayImage(indexPath: IndexPath) {
        let vc = ImageDisplayViewController()
        vc.indexPath = indexPath
        vc.photos = viewModel?.getAllPhotos() ?? []
        navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - Actions

    @objc private func switchGalleryMode() {
        if isListMode {
            showCollectionView()
        } else {
            showTableView()
        }
        self.isListMode = !isListMode
    }

}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getAllPhotos().count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tableCellIdentifier) as? GalleryListCellTableViewCell else {
            return UITableViewCell()
        }
        viewModel?.configueTableCell(indexPath: indexPath, cell: cell)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableViewCellHeight
    }

}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        displayImage(indexPath: indexPath)
    }

}

// MARK: - UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.getAllPhotos().count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellIdentifier, for: indexPath) as? GalleryListCellCollectionViewCell else {
            return UICollectionViewCell()
        }
        viewModel?.configureCollectionCell(indexPath: indexPath, cell: cell)
        return cell
    }

}

// MARK: - UICollectionViewDelegate

extension ViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        displayImage(indexPath: indexPath)
    }

}

// MARK: - HomeViewModelDelegate

extension ViewController: HomeViewModelDelegate {

    func displayPhotos() {
        hideLoadingView()
        tableView.reloadData()
        collectionView.reloadData()
    }

}

// MARK: - UIScrollViewDelegate

extension ViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let isReachingEnd = scrollView.contentOffset.y >= 0
            && scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)
        if isReachingEnd {
            if !(viewModel?.isWaiting ?? false) && (viewModel?.isMore ?? false) {
                viewModel?.fetchGalleryImages()
            }
        }
    }

}

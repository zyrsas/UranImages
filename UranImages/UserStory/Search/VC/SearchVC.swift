//
//  SearchController.swift
//  UranImages
//
//  Created by Sasha on 21.10.2019.
//  Copyright © 2019 Sasha. All rights reserved.
//

import UIKit
import DeepDiff

class SearchVC: BaseVC {
    
    // MARK: - UI Elements
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.placeholder = "Search..."
        searchController.searchBar.keyboardAppearance = .dark
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.identity)
        return collectionView
    }()
    
    // MARK: - Variables
    
    private let viewModel = SearchVM()
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(self)
    }
    
    // MARK: - Setup Constrain
    
    override func setupConstraint() {
        view.addSubview(collectionView)
           
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
            make.left.equalToSuperview().offset(15)
        }
    }
    
    // MARK: - Setup UI
    
    override func setupUI() {
        super.setupUI()
        title = "Search"
        self.navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    @objc
    func perfomSearch(_ searchText: String) {
        viewModel.searchByQuery(searchText)
    }
}

 // MARK: - CollectionView Delegate

extension SearchVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = FullScreenVC.newInstance(photo: viewModel.getPhotoByIndexPath(indexPath))
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - CollectionView Flow Delegate

extension SearchVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.getCellSize(collectionView, indexPath: indexPath)
    }
}

// MARK: - CollectionView Data Source

extension SearchVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return viewModel.getCellInstance(collectionView, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.getNewPage(collectionView, indexPath: indexPath, query: searchController.searchBar.text ?? "")
    }
}

// MARK: - Search Delegate

extension SearchVC: UISearchBarDelegate {    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count < 3 { return }
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        perform(#selector(perfomSearch(_:)), with: searchText, afterDelay: 0.4)
    }
}

// MARK: - Base Delegate

extension SearchVC: BaseDelegate {
    func reloadDataWith(_ items: [Photo]) {
        let changes = diff(old: viewModel.getPhotos(), new: items)
        self.collectionView.reload(changes: changes, updateData: {
            viewModel.setPhotos(photos: items)
        })
    }
    
    func showAlertView(title: String, message: String) {
        showAlert(title: title, message: message)
    }
}

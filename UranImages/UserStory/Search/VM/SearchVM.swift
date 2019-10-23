//
//  SearchVM.swift
//  UranImages
//
//  Created by Sasha on 21.10.2019.
//  Copyright © 2019 Sasha. All rights reserved.
//

import UIKit

class SearchVM {
    
    // MARK: - Variables

    weak var delegate: BaseDelegate?
    private var photos: [Photo] = []
    private var currentPage = 1
    private var perPage = 30
    private var isLoading = false
    
    // MARK: - BIND
    
    public func bind(_ delegate: BaseDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Search
    
    private func searchPhotos(_ query: String = "", isNewPage: Bool = false) {
        self.delegate?.showActivityIndicator()
        NetworkAdapter.request(target: .searchPhotos(SearchKey(page: currentPage, per_page: perPage, query: query)), success: { [weak self] (response) in
            if let searchModel = try? response.mapObject(SearchModel.self) {
                let photos = searchModel.results
                if !isNewPage { self?.clearData() }
                self?.delegate?.reloadDataWith(photos)
            } else {
                self?.delegate?.showAlertView(title: "", message: "Parse Error")
            }
            self?.isLoading = false
            self?.delegate?.hideActivityIndicator()
        }, error: { (error) in
            self.delegate?.showAlertView(title: "", message: error.localizedDescription)
            self.delegate?.hideActivityIndicator()
        }, failure: { (error) in
            self.delegate?.showAlertView(title: "", message: error.localizedDescription)
            self.delegate?.hideActivityIndicator()
        })
    }
    
    //MARK: - Clear Data
    
    private func clearData() {
        photos.removeAll()
        currentPage = 1
    }
    
    // MARK: - UICollectionView methods
    
    public func numberOfItems() -> Int { return photos.count }
    
    public func getCellInstance(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.identity, for:indexPath ) as! ImageCell
        cell.setData(photo: getPhotoByIndexPath(indexPath))
        return cell
    }
    
    public func getCellSize(_ collectionView: UICollectionView, indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.width
        return CGSize(width: size, height: size)
    }
    
    public func getPhotos() -> [Photo] {
        return photos
    }
    
    public func getPhotoByIndexPath(_ indexPath: IndexPath) -> Photo {
        return photos[indexPath.row]
    }
    
    public func setPhotos(photos: [Photo]) {
        self.photos.append(contentsOf: photos)
    }
    
    public func searchByQuery(_ query: String?) {
        guard let query = query else { return }
        searchPhotos(query)
    }
    
    public func getNewPage(_ collectionView: UICollectionView, indexPath: IndexPath, query: String) {
        if indexPath.row < numberOfItems() - 2 || isLoading {
            return
        }
        isLoading = true
        currentPage += 1
        searchPhotos(query, isNewPage: true)
    }
}

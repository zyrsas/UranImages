//
//  MainVM.swift
//  UranImages
//
//  Created by Sasha on 21.10.2019.
//  Copyright © 2019 Sasha. All rights reserved.
//

import Moya_ObjectMapper

class MainVM {
    
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
    
    // MARK: - Get Photos
    
    public func getPhotos() {
        self.delegate?.showActivityIndicator()
        NetworkAdapter.request(target: .photos(PhotosKey(page: currentPage, per_page: perPage)), success: { [weak self] (response) in
            do {
                let photos = try response.mapArray(Photo.self)
                self?.delegate?.reloadDataWith(photos)
            } catch {
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
    
    // MARK: - UICollectionView methods

    public func numberOfItems() -> Int { return photos.count }
    
    public func getCellInstance(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.identity, for:indexPath ) as! ImageCell
        cell.setData(photo: getPhotoByIndexPath(indexPath))
        return cell
    }
    
    public func getAllPhotos() -> [Photo] {
        return photos
    }
    
    public func getPhotoByIndexPath(_ indexPath: IndexPath) -> Photo {
        return photos[indexPath.row]
    }
    
    public func setPhotos(photos: [Photo]) {
        self.photos.append(contentsOf: photos)
    }
    
    public func getCellSize(_ collectionView: UICollectionView, indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let space: CGFloat = 10
        let numberOfItems: CGFloat = 3
        
        let size = width / numberOfItems - space
        return CGSize(width: size, height: size)
    }
    
    public func getNewPage(_ collectionView: UICollectionView, indexPath: IndexPath) {
        if indexPath.row < numberOfItems() - 4 || isLoading {
            return
        }
        isLoading = true
        currentPage += 1
        getPhotos()
    }
}

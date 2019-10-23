//
//  MainController.swift
//  UranImages
//
//  Created by Sasha on 21.10.2019.
//  Copyright © 2019 Sasha. All rights reserved.
//

import UIKit
import DeepDiff

class MainVC: BaseVC {
    
    // MARK: - UI Elements

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
    
    private let viewModel = MainVM()

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(self)
        viewModel.getPhotos()
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
        title = "Images"
    }
}

// MARK: - CollectionView Delegate

extension MainVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = FullScreenVC.newInstance(photo: viewModel.getPhotoByIndexPath(indexPath))
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - CollectionView Flow Delegate

extension MainVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.getCellSize(collectionView, indexPath: indexPath)
    }
}

// MARK: - CollectionView Data Source

extension MainVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return viewModel.getCellInstance(collectionView, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.getNewPage(collectionView, indexPath: indexPath)
    }
}

// MARK: - Base Delegate

extension MainVC: BaseDelegate {
    func showAlertView(title: String, message: String) {
        self.showAlert(title: title, message: message)
    }
    
    func reloadDataWith(_ items: [Photo]) {
        let changes = diff(old: viewModel.getAllPhotos(), new: items)
        self.collectionView.reload(changes: changes, updateData: {
            viewModel.setPhotos(photos: items)
        })
    }
}

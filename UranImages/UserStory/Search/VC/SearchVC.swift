//
//  SearchController.swift
//  UranImages
//
//  Created by Sasha on 21.10.2019.
//  Copyright © 2019 Sasha. All rights reserved.
//

import UIKit

class SearchVC: BaseVC {
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.searchBarStyle = UISearchBar.Style.minimal
        let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.white
        let attributes:[NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: .normal)
        searchController.searchBar.placeholder = "Search..."
        searchController.searchBar.keyboardAppearance = .dark
        searchController.searchBar.showsCancelButton = true
        searchController.searchBar.delegate = self
        searchController.searchBar.backgroundColor = .lightGray
        return searchController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension SearchVC: UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
//        if self.getListTask != nil {
//            self.getListTask?.cancel()
//        }
//        self.getListTask = DispatchWorkItem.init(block: {
//            self.viewModel?.getList(searchController.searchBar.text ?? "")
//        })
//        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: self.getListTask!)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
      //  hideSearch()
    }
    
    func presentSearchController(_ searchController: UISearchController) {
        searchController.searchBar.becomeFirstResponder()
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        searchController.searchBar.becomeFirstResponder()
    }
}

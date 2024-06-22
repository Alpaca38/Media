//
//  SearchViewController.swift
//  Media
//
//  Created by 조규연 on 6/11/24.
//

import UIKit
import SnapKit
import Toast

class SearchViewController: BaseViewController {
    
    let searchView = SearchView()
    
    override func loadView() {
        super.loadView()
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
}

extension SearchViewController {
    
    func configureUI() {
        searchView.collectionView.delegate = self
        searchView.collectionView.dataSource = self
        searchView.collectionView.prefetchDataSource = self
        
        searchView.searchBar.delegate = self
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchView.list.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as! SearchCollectionViewCell
        let data = searchView.list.results[indexPath.item]
        cell.configure(data: data)
        
        return cell
    }
}

extension SearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        indexPaths.forEach {
            if searchView.list.results.count - 2 == $0.item {
                searchView.page += 1
                searchView.getSearchData(query: searchView.searchBar.text!, page: searchView.page)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchView.page = 1
        searchView.getSearchData(query: searchBar.text!, page: searchView.page)
    }
}

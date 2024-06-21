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
    
    let searchBar = UISearchBar()
    let categoryLabel = UILabel()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    var list = SearchMovie(page: 1, results: [], totalPages: 0, totalResults: 0) {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var page = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierachy()
        configureLayout()
        configureUI()
        
    }
}

extension SearchViewController: ConfigureProtocol {
    func configureHierachy() {
        view.addSubviews([searchBar, categoryLabel, collectionView])
    }
    
    func configureLayout() {
        searchBar.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(44)
        }
        
        categoryLabel.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(10)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureUI() {
        setNavigationBar(tintColor: .black, title: "영화 검색")
        collectionView.backgroundColor = .backgroundColor
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
        
        searchBar.delegate = self
        let image = UIImage()
        searchBar.backgroundImage = image
        searchBar.backgroundColor = .backgroundColor
        searchBar.placeholder = "영화 제목을 검색해보세요."
        
        categoryLabel.font = .boldTitleFont
        categoryLabel.text = "Movie"
        
    }
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 40
        layout.itemSize = CGSize(width: width/3, height: width/2)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        return layout
    }

}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as! SearchCollectionViewCell
        let data = list.results[indexPath.item]
        cell.configure(data: data)
        
        return cell
    }
}

extension SearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        indexPaths.forEach {
            if list.results.count - 2 == $0.item {
                page += 1
                getSearchData(query: searchBar.text!, page: page)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        page = 1
        getSearchData(query: searchBar.text!, page: page)
    }
}

private extension SearchViewController {
    func getSearchData(query: String, page: Int) {
        NetworkManager.shared.getSearchData(query: query, page: page) { result in
            switch result {
            case .success(let success):
                if self.page == 1 {
                    self.list = success
                    self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
                } else {
                    self.list.results.append(contentsOf: success.results)
                }
            case .failure(let failure):
                self.view.makeToast("검색결과를 받아오는데 실패했습니다. \(failure.localizedDescription)")
            }
        }
    }
}

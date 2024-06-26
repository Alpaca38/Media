//
//  SearchView.swift
//  Media
//
//  Created by 조규연 on 6/22/24.
//

import UIKit
import SnapKit
import Toast

class SearchView: UIView {
    let searchBar = UISearchBar()
    let categoryLabel = UILabel()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    var list = SearchMovie(page: 1, results: [], totalPages: 0, totalResults: 0) {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var page = 1
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierachy()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SearchView {
    func configureHierachy() {
        addSubviews([searchBar, categoryLabel, collectionView])
    }
    
    func configureLayout() {
        searchBar.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(44)
        }
        
        categoryLabel.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(10)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    func configureUI() {
        collectionView.backgroundColor = .backgroundColor
        collectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
        
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

extension SearchView {
    func getSearchData(query: String, page: Int) {
        NetworkManager.shared.getMovieData(api: .searchMovie(query: query, page: page), responseType: SearchMovie.self) { result in
            switch result {
            case .success(let success):
                if self.page == 1 {
                    self.list = success
                    if !self.list.results.isEmpty {
                        self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
                    } else {
                        self.makeToast("검색결과가 없습니다.", duration: 2, position: .center)
                    }
                } else {
                    self.list.results.append(contentsOf: success.results)
                }
            case .failure(let failure):
                self.makeToast("검색결과를 받아오는데 실패했습니다. \(failure.localizedDescription)")
            }
        }
    }
}

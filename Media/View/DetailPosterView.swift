//
//  DetailPosterView.swift
//  Media
//
//  Created by 조규연 on 6/24/24.
//

import UIKit
import SnapKit
import Toast

class DetailPosterView: UIView {
    var similarList = SimilarMovie(page: 1, results: [], totalPages: 0, totalResults: 0) {
        didSet {
            similarCollectionView.reloadData()
        }
    }
    var recommendList = MovieRecommendation(page: 1, results: [], totalPages: 0, totalResults: 0) {
        didSet {
            recommendCollectionView.reloadData()
        }
    }
    var posterList = MovieImage(backdrops: [], id: 0, logos: [], posters: []) {
        didSet {
            posterCollectionView.reloadData()
        }
    }
    lazy var titleLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 30)
        label.text = "테스트"
        self.addSubview(label)
        return label
    }()
    
    lazy var similarLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "비슷한 영화"
        self.addSubview(label)
        return label
    }()
    
    lazy var recommendLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "추천 영화"
        self.addSubview(label)
        return label
    }()
    
    lazy var posterLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "포스터"
        self.addSubview(label)
        return label
    }()
    
    lazy var similarCollectionView = {
        let view = PosterCollectionView(layout: similarCollectionViewLayout())
        self.addSubview(view)
        return view
    }()
    
    lazy var recommendCollectionView = {
        let view = PosterCollectionView(layout: similarCollectionViewLayout())
        self.addSubview(view)
        return view
    }()
    
    lazy var posterCollectionView = {
        let view = PosterCollectionView(layout: posterCollectionViewLayout())
        self.addSubview(view)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    private func configureLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
        }
        similarLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.leading.equalTo(titleLabel)
        }
        similarCollectionView.snp.makeConstraints {
            $0.top.equalTo(similarLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(self).multipliedBy(0.2)
        }
        recommendLabel.snp.makeConstraints {
            $0.top.equalTo(similarCollectionView.snp.bottom).offset(20)
            $0.leading.equalTo(titleLabel)
        }
        recommendCollectionView.snp.makeConstraints {
            $0.top.equalTo(recommendLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(self).multipliedBy(0.2)
        }
        posterLabel.snp.makeConstraints {
            $0.top.equalTo(recommendCollectionView.snp.bottom).offset(20)
            $0.leading.equalTo(titleLabel)
        }
        posterCollectionView.snp.makeConstraints {
            $0.top.equalTo(posterLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(self).multipliedBy(0.35)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func similarCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 60
        layout.itemSize = CGSize(width: width/3, height: width/2)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }
    
    private func posterCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 50
        layout.itemSize = CGSize(width: width/2, height: width/2 * 1.5)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailPosterView {
    func getSimilarMovieData(movieID: Int) {
        NetworkManager.shared.getSimilarMovieData(movieID: movieID) { result in
            switch result {
            case .success(let success):
                self.similarList = success
            case .failure(_):
                DispatchQueue.main.async {
                    self.makeToast("비슷한 영화 정보를 가져오는데 실패 했습니다.", duration: 2, position: .center)
                }
            }
        }
    }
    
    func getRecommendMovieData(movieID: Int) {
        NetworkManager.shared.getRecommendMovieData(movieID: movieID) { result in
            switch result {
            case .success(let success):
                self.recommendList = success
            case .failure(_):
                DispatchQueue.main.async {
                    self.makeToast("추천 영화 정보를 가져오는데 실패 했습니다.", duration: 2, position: .center)
                }
            }
        }
    }
    
    func getPosterData(movieID: Int) {
        NetworkManager.shared.getPosterData(movieID: movieID) { result in
            switch result {
            case .success(let success):
                self.posterList = success
            case .failure(_):
                DispatchQueue.main.async {
                    self.makeToast("포스터 정보를 가져오는데 실패 했습니다.", duration: 2, position: .center)
                }
            }
        }
    }
}

//
//  SearchCollectionViewCell.swift
//  Media
//
//  Created by 조규연 on 6/11/24.
//

import UIKit
import SnapKit
import Kingfisher

class SearchCollectionViewCell: UICollectionViewCell {
    
    let posterimageView = UIImageView()
    
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

extension SearchCollectionViewCell: ConfigureProtocol {
    func configureHierachy() {
        contentView.addSubview(posterimageView)
    }
    
    func configureLayout() {
        posterimageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configureUI() {
        posterimageView.clipsToBounds = true
        posterimageView.layer.cornerRadius = 5
        posterimageView.contentMode = .scaleAspectFill
        posterimageView.backgroundColor = .lightGray
    }
    
    func configure(data: SearchResult) {
        if let poster = data.poster_path {
            let url = URL(string: "https://image.tmdb.org/t/p/original\(poster)")
            posterimageView.kf.setImage(with: url)
        } else {
            posterimageView.backgroundColor = .lightGray
        }
        
    }
}

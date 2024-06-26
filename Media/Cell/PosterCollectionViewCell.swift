//
//  SearchCollectionViewCell.swift
//  Media
//
//  Created by 조규연 on 6/11/24.
//

import UIKit
import SnapKit
import Kingfisher

class PosterCollectionViewCell: BaseCollectionViewCell {
    
    let posterimageView = UIImageView()
    
    override func configureHierachy() {
        contentView.addSubview(posterimageView)
    }
    
    override func configureLayout() {
        posterimageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func configureUI() {
        posterimageView.clipsToBounds = true
        posterimageView.layer.cornerRadius = 5
        posterimageView.contentMode = .scaleAspectFill
        posterimageView.backgroundColor = .lightGray
    }
}

extension PosterCollectionViewCell {
    func configure(data: SearchResult) {
        if let poster = data.poster_path {
            let url = URL(string: "https://image.tmdb.org/t/p/original\(poster)")
            posterimageView.kf.setImage(with: url)
        } else {
            posterimageView.backgroundColor = .lightGray
        }
    }
    
    func configure(data: PosterData) {
        if let poster = data.path {
            let url = URL(string: "https://image.tmdb.org/t/p/original\(poster)")
            posterimageView.kf.setImage(with: url)
        } else {
            posterimageView.backgroundColor = .lightGray
        }
    }
}

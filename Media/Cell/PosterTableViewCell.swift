//
//  PosterTableViewCell.swift
//  Media
//
//  Created by 조규연 on 6/25/24.
//

import UIKit
import SnapKit

final class PosterTableViewCell: BaseTableViewCell {
    private lazy var categoryLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 20)
        view.text = "비슷한 영화" // 더미
        self.contentView.addSubview(view)
        return view
    }()
    
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout())
        view.backgroundColor = .backgroundColor
        self.contentView.addSubview(view)
        return view
    }()
    
    override func configureLayout() {
        categoryLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(20)
        }
        collectionView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.top.equalTo(categoryLabel.snp.bottom).offset(10)
        }
    }
    
    func configure(category: String) {
        categoryLabel.text = category
    }
    
    private func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 160)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }
}

//
//  PosterTableViewCell.swift
//  Media
//
//  Created by 조규연 on 6/25/24.
//

import UIKit
import SnapKit

class PosterTableViewCell: UITableViewCell {
    lazy var categoryLabel = {
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .backgroundColor
        configureLayout()
    }
    
    private func configureLayout() {
        categoryLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(20)
        }
        collectionView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.top.equalTo(categoryLabel.snp.bottom).offset(10)
        }
    }
    
    func configure(category: DetailPosterCategory.RawValue) {
        categoryLabel.text = category
    }
    
    private func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 60
        layout.itemSize = CGSize(width: width/3, height: width/2)
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

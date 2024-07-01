//
//  PosterCollectionView.swift
//  Media
//
//  Created by 조규연 on 6/24/24.
//

import UIKit

final class PosterCollectionView: UICollectionView {
    init(layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: layout)
        backgroundColor = .backgroundColor
        register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

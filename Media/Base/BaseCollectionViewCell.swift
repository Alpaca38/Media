//
//  BaseCollectionViewCell.swift
//  Media
//
//  Created by 조규연 on 6/26/24.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierachy()
        configureLayout()
        configureUI()
    }
    
    func configureHierachy() { }
    func configureLayout() { }
    func configureUI() { }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  CastTableViewCell.swift
//  Media
//
//  Created by 조규연 on 6/10/24.
//

import UIKit
import SnapKit
import Kingfisher

final class CastTableViewCell: BaseTableViewCell {
    
    private let actorImageView = UIImageView()
    private let actorNameLabel = UILabel()
    private let castNameLabel = UILabel()
    
    private lazy var nameStackView = {
        let view = UIStackView(arrangedSubviews: [actorNameLabel, castNameLabel])
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.alignment = .leading
        
        self.contentView.addSubview(view)
        return view
    }()
    
    override func configureHierachy() {
        contentView.addSubview(actorImageView)
    }
    
    override func configureLayout() {
        actorImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.verticalEdges.equalToSuperview().inset(8)
            $0.width.equalTo(50)
        }
        
        nameStackView.snp.makeConstraints {
            $0.leading.equalTo(actorImageView.snp.trailing).offset(20)
            $0.verticalEdges.trailing.equalToSuperview().inset(20)
        }
    }
    
    override func configureUI() {
        backgroundColor = .white
        
        actorImageView.clipsToBounds = true
        actorImageView.layer.cornerRadius = 10
        actorImageView.contentMode = .scaleAspectFill
        
        actorNameLabel.font = .titleFont
        actorNameLabel.textColor = .defaultColor
        actorNameLabel.numberOfLines = 0
        
        castNameLabel.font = .contentFont
        castNameLabel.textColor = .contentColor
        castNameLabel.numberOfLines = 0
    }
}

extension CastTableViewCell {
    func configure(data: Cast) {
        if data.profile_path != nil {
            let url = URL(string: "https://image.tmdb.org/t/p/original\(data.profile_path!)")
            actorImageView.kf.setImage(with: url)
        } else {
            actorImageView.backgroundColor = .lightGray
        }
        
        actorNameLabel.text = data.name
        
        castNameLabel.text = data.character
    }
}

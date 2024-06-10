//
//  CastTableViewCell.swift
//  Media
//
//  Created by 조규연 on 6/10/24.
//

import UIKit
import SnapKit
import Kingfisher

class CastTableViewCell: UITableViewCell {
    
    let actorImageView = UIImageView()
    let actorNameLabel = UILabel()
    let castNameLabel = UILabel()
    
    lazy var nameStackView = {
        let view = UIStackView(arrangedSubviews: [actorNameLabel, castNameLabel])
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.alignment = .leading
        
        self.contentView.addSubview(view)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierachy()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CastTableViewCell: ConfigureProtocol {
    func configureHierachy() {
        contentView.addSubview(actorImageView)
    }
    
    func configureLayout() {
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
    
    func configureUI() {
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

//
//  HomeTableViewCell.swift
//  Media
//
//  Created by 조규연 on 6/10/24.
//

import UIKit
import SnapKit
import Cosmos

class HomeTableViewCell: UITableViewCell {
    
    let dateLabel = UILabel()
    let categoryLabel = UILabel()
    let posterView = UIView()
    let posterImageView = UIImageView()
    let posterInfoView = UIView()
    let titleLabel = UILabel()
    let ratingView = CosmosView()
    let separatorView = UIView()
    let detailLabel = UILabel()
    let detailButton = UIButton()

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

extension HomeTableViewCell: ConfigureProtocol {
    func configureHierachy() {
        contentView.addSubviews([dateLabel, categoryLabel, posterView])
        posterView.addSubviews([posterImageView, posterInfoView])
        posterInfoView.addSubviews([titleLabel, ratingView, separatorView, detailLabel, detailButton])
    }
    
    func configureLayout() {
        dateLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
        }
        
        categoryLabel.snp.makeConstraints {
            $0.leading.equalTo(dateLabel)
            $0.top.equalTo(dateLabel.snp.bottom).offset(4)
        }
        
        posterView.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        posterImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        posterInfoView.snp.makeConstraints {
            $0.bottom.horizontalEdges.equalToSuperview()
            $0.height.equalTo(posterView).multipliedBy(0.4)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(16)
        }
        
        ratingView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(titleLabel)
        }
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(ratingView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(1)
        }
        
        detailLabel.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom).offset(16)
            $0.leading.equalTo(separatorView)
            $0.bottom.equalToSuperview().offset(-10)
        }
        
        detailButton.snp.makeConstraints {
            $0.centerY.equalTo(detailLabel)
            $0.trailing.equalTo(separatorView)
        }
        
    }
    
    func configureUI() {
        backgroundColor = .backgroundColor
        selectionStyle = .none
        
        dateLabel.font = .contentFont
        dateLabel.textColor = .contentColor
        dateLabel.text = "12/10/2020"
        
        categoryLabel.font = .boldTitleFont
        categoryLabel.textColor = .defaultColor
        categoryLabel.text = "#Mystery"
        
        posterView.clipsToBounds = true
        posterView.layer.cornerRadius = 8
        
        posterImageView.backgroundColor = .darkGray
        
        posterInfoView.backgroundColor = .white
        
        titleLabel.font = .titleFont
        titleLabel.textColor = .defaultColor
        titleLabel.text = "Alice In BorderLand"
        
        ratingView.settings.fillMode = .precise
        ratingView.settings.totalStars = 10
        ratingView.settings.starSize = 15
        ratingView.text = "평점 7.7"
        ratingView.rating = 7.7
        
        separatorView.backgroundColor = .lightGray
        
        detailLabel.font = .contentFont
        detailLabel.textColor = .defaultColor
        detailLabel.text = "자세히 보기"
        
        detailButton.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
        detailButton.tintColor = .black
        
    }
    
    
}

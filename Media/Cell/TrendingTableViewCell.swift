//
//  HomeTableViewCell.swift
//  Media
//
//  Created by 조규연 on 6/10/24.
//

import UIKit
import SnapKit
import Cosmos
import Kingfisher

final class TrendingTableViewCell: BaseTableViewCell {
    weak var delegate: TrendingTableViewCellDelegate?
    
    private let dateLabel = UILabel()
    private let categoryLabel = UILabel()
    private let posterView = UIView()
    private let posterImageView = UIImageView()
    private let posterInfoView = UIView()
    private let titleLabel = UILabel()
    private let ratingView = CosmosView()
    private let separatorView = UIView()
    private let detailLabel = UILabel()
    private let detailButton = UIButton()
    
    override func configureHierachy() {
        contentView.addSubviews([dateLabel, categoryLabel, posterView])
        posterView.addSubviews([posterImageView, posterInfoView])
        posterInfoView.addSubviews([titleLabel, ratingView, separatorView, detailLabel, detailButton])
    }
    
    override func configureLayout() {
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
            $0.height.equalTo(posterView.snp.width)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        posterImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        posterInfoView.snp.makeConstraints {
            $0.bottom.horizontalEdges.equalToSuperview()
            $0.height.equalTo(posterView).multipliedBy(0.33)
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
            $0.trailing.equalTo(detailButton.snp.leading)
        }
        
        detailButton.snp.makeConstraints {
            $0.centerY.equalTo(detailLabel)
            $0.trailing.equalTo(separatorView)
        }
        
    }
    
    override func configureUI() {
        backgroundColor = .backgroundColor
        selectionStyle = .none
        
        dateLabel.font = .contentFont
        dateLabel.textColor = .contentColor
        
        categoryLabel.font = .boldTitleFont
        categoryLabel.textColor = .defaultColor
        
        posterView.clipsToBounds = true
        posterView.layer.cornerRadius = 8
        
        posterImageView.contentMode = .scaleAspectFill
        
        posterInfoView.backgroundColor = .white
        
        titleLabel.font = .titleFont
        titleLabel.textColor = .defaultColor
        
        ratingView.settings.fillMode = .precise
        ratingView.settings.totalStars = 10
        ratingView.settings.starSize = 15
        
        separatorView.backgroundColor = .lightGray
        
        detailLabel.font = .contentFont
        detailLabel.textColor = .defaultColor
        detailLabel.text = "자세히 보기"
        
        detailButton.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
        detailButton.tintColor = .black
        detailButton.addTarget(self, action: #selector(detailButtonTapped), for: .touchUpInside)
    }
}

private extension TrendingTableViewCell {
    @objc func detailButtonTapped() {
        delegate?.didDetailButtonTapped(self)
    }
}

extension TrendingTableViewCell {
    func configure(data: TrendingResult, genreList: [Genre]) {
        dateLabel.text = data.releaseDate
        
        genreList.forEach {
            if data.genreIDS.contains($0.id) {
                categoryLabel.text = $0.genreString
            }
        }
        
        let url = URL(string: "https://image.tmdb.org/t/p/original\(data.posterPath)")
        posterImageView.kf.setImage(with: url)
        
        titleLabel.text = data.title
        
        ratingView.text = data.ratingString
        ratingView.rating = data.voteAverage
    }
}

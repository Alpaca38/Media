//
//  DetailView.swift
//  Media
//
//  Created by 조규연 on 6/22/24.
//

import UIKit
import SnapKit
import Toast

class DetailView: UIView {
    let posterImageView = UIImageView()
    let infoView = UIView()
    let titleLabel = UILabel()
    let overviewLabel = UILabel()
    let castLabel = UILabel()
    let castTableView = UITableView()

    var list: [Cast] = [] {
        didSet {
            castTableView.reloadData()
        }
    }
    
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

private extension DetailView {
    func configureHierachy() {
        addSubviews([posterImageView, infoView])
        infoView.addSubviews([titleLabel, overviewLabel, castLabel, castTableView])
    }
    
    func configureLayout() {
        posterImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        infoView.snp.makeConstraints {
            $0.top.equalTo(self.snp.centerY)
            $0.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        titleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.top.equalToSuperview().offset(20)
        }
        
        overviewLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
        
        castLabel.snp.makeConstraints {
            $0.top.equalTo(overviewLabel.snp.bottom).offset(20)
            $0.leading.equalTo(overviewLabel)
        }
        
        castTableView.snp.makeConstraints {
            $0.top.equalTo(castLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(overviewLabel)
            $0.bottom.equalToSuperview()
        }
        
    }
    
    func configureUI() {
        castTableView.register(CastTableViewCell.self, forCellReuseIdentifier: CastTableViewCell.identifier)
        castTableView.rowHeight = 80
        
        posterImageView.contentMode = .scaleAspectFill
        
        infoView.backgroundColor = .white
        infoView.clipsToBounds = true
        infoView.layer.cornerRadius = 20
        infoView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        titleLabel.font = .bigTitleFont
        titleLabel.textColor = .defaultColor
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        
        overviewLabel.font = .contentFont
        overviewLabel.textColor = .defaultColor
        overviewLabel.numberOfLines = 0
        
        castLabel.font = .boldTitleFont
        castLabel.textColor = .defaultColor
        castLabel.text = "Cast"
    }
}

extension DetailView {
    func getMovieCredit(data: SearchResult) {
        NetworkManager.shared.getMovieData(api: .movieCreidt(id: data.id), responseType: MovieCredit.self) { result in
            switch result {
            case .success(let success):
                self.list = success.cast
            case .failure(let failure):
                self.makeToast("크레딧 정보를 받아오지 못했습니다. \(failure.localizedDescription)", duration: 2, position: .bottom)
            }
        }
    }
}

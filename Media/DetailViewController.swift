//
//  DetailViewController.swift
//  Media
//
//  Created by 조규연 on 6/10/24.
//

import UIKit
import SnapKit
import Kingfisher
import Toast

class DetailViewController: BaseViewController {
    
    let posterImageView = UIImageView()
    let infoView = UIView()
    let titleLabel = UILabel()
    let overviewLabel = UILabel()
    let castLabel = UILabel()
    let castTableView = UITableView()
    
    var data: movieResult?
    
    var list: [Cast] = [] {
        didSet {
            castTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getMovieCredit()
        configureHierachy()
        configureLayout()
        configureUI()
    }

}

extension DetailViewController: ConfigureProtocol {
    func configureHierachy() {
        view.addSubviews([posterImageView, infoView])
        infoView.addSubviews([titleLabel, overviewLabel, castLabel, castTableView])
    }
    
    func configureLayout() {
        posterImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        infoView.snp.makeConstraints {
            $0.top.equalTo(view.snp.centerY)
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
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
        setNavigationBar(tintColor: .black, title: nil)
        
        castTableView.delegate = self
        castTableView.dataSource = self
        castTableView.register(CastTableViewCell.self, forCellReuseIdentifier: CastTableViewCell.identifier)
        castTableView.rowHeight = 80
        
        posterImageView.contentMode = .scaleAspectFill
        let url = URL(string: "https://image.tmdb.org/t/p/original\(data!.posterPath)")
        posterImageView.kf.setImage(with: url)
        
        infoView.backgroundColor = .white
        infoView.clipsToBounds = true
        infoView.layer.cornerRadius = 20
        infoView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        titleLabel.font = .bigTitleFont
        titleLabel.textColor = .defaultColor
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.text = data?.title
        
        overviewLabel.font = .contentFont
        overviewLabel.textColor = .defaultColor
        overviewLabel.numberOfLines = 0
        overviewLabel.text = data?.overview
        
        castLabel.font = .boldTitleFont
        castLabel.textColor = .defaultColor
        castLabel.text = "Cast"
    }

}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier, for: indexPath) as! CastTableViewCell
        let data = list[indexPath.row]
        cell.configure(data: data)
        
        return cell
    }
}

extension DetailViewController {
    func getMovieCredit() {
        NetworkManager.shared.getMovieCredit(id: data!.id) { result in
            switch result {
            case .success(let success):
                self.list = success.cast
            case .failure(let failure):
                self.view.makeToast("크레딧 정보를 받아오지 못했습니다. \(failure.localizedDescription)", duration: 2, position: .bottom)
            }
        }
    }
}

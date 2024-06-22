//
//  HomeView.swift
//  Media
//
//  Created by 조규연 on 6/22/24.
//

import UIKit
import SnapKit
import Toast

class HomeView: UIView {
    let tableView = UITableView()
    var list: [movieResult] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var genreList: [Genre] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        getTrendingMovieData()
        getMovieGenreList()
    }
    
    private func configureView() {
        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension HomeView {
    func getTrendingMovieData() {
        NetworkManager.shared.getTrendingMovieData { result in
            switch result {
            case .success(let success):
                self.list = success.results
            case .failure(let failure):
                self.makeToast("영화 정보를 받아오는데 실패 했습니다. \(failure.localizedDescription)", duration: 2, position: .center)
            }
        }
    }
    
    func getMovieGenreList() {
        NetworkManager.shared.getMovieGenreList { result in
            switch result {
            case .success(let success):
                self.genreList = success.genres
            case .failure(let failure):
                self.makeToast("장르 정보를 받아오는데 실패 했습니다. \(failure.localizedDescription)", duration: 2, position: .center)
            }
        }
    }
}

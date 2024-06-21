//
//  ViewController.swift
//  Media
//
//  Created by 조규연 on 6/10/24.
//

import UIKit
import SnapKit
import Toast

class HomeViewController: BaseViewController {
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        getTrendingMovieData()
        getMovieGenreList()
        configureHierachy()
        configureLayout()
        configureUI()
    }

}

extension HomeViewController: ConfigureProtocol {
    func configureHierachy() {
        view.addSubview(tableView)
    }
    
    func configureLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureUI() {
        setNavigationBar(tintColor: .black, title: nil)
        let listButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(listButtonTapped))
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonTapped))
        navigationItem.leftBarButtonItem = listButton
        navigationItem.rightBarButtonItem = searchButton
        navigationItem.backButtonDisplayMode = .minimal
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .backgroundColor
    }
}

extension HomeViewController {
    @objc private func listButtonTapped() {
        
    }
    
    @objc private func searchButtonTapped() {
        let vc = SearchViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell
        let data = list[indexPath.row]
        let genreList = genreList
        cell.configure(data: data, genreList: genreList)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = list[indexPath.row]
        let vc = DetailViewController()
        vc.data = data
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

private extension HomeViewController {
    func getTrendingMovieData() {
        NetworkManager.shared.getTrendingMovieData { result in
            switch result {
            case .success(let success):
                self.list = success.results
            case .failure(let failure):
                self.view.makeToast("영화 정보를 받아오는데 실패 했습니다. \(failure.localizedDescription)", duration: 2, position: .center)
            }
        }
    }
    
    func getMovieGenreList() {
        NetworkManager.shared.getMovieGenreList { result in
            switch result {
            case .success(let success):
                self.genreList = success.genres
            case .failure(let failure):
                self.view.makeToast("장르 정보를 받아오는데 실패 했습니다. \(failure.localizedDescription)", duration: 2, position: .center)
            }
        }
    }
}

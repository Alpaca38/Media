//
//  ViewController.swift
//  Media
//
//  Created by 조규연 on 6/10/24.
//

import UIKit
import SnapKit
import Alamofire

class HomeViewController: BaseViewController {
    
    let tableView = UITableView()
    var list: [Result] = []
    var genreList: [Genre] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        callTrendingMovieRequest() {
            self.callMovieGenreList {
                self.configureHierachy()
                self.configureLayout()
                self.configureUI()
            }
        }
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
        setNavigationBar(tintColor: .blue, title: nil)
        let listButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(listButtonTapped))
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonTapped))
        navigationItem.leftBarButtonItem = listButton
        navigationItem.rightBarButtonItem = searchButton
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        tableView.separatorStyle = .none
        
        
    }
}

extension HomeViewController {
    @objc func listButtonTapped() {
        
    }
    
    @objc func searchButtonTapped() {
        
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
    
    
}

extension HomeViewController {
    func callTrendingMovieRequest(completion: @escaping () -> Void) {
        let url = "https://api.themoviedb.org/3/trending/movie/week"
        
        let header: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer " + APIKey.tmdbBearerKey
        ]
        
        AF.request(url, method: .get, headers: header)
            .responseDecodable(of: Movie.self) { response in
            switch response.result {
            case .success(let value):
                self.list = value.results
            case .failure(let error):
                print(error)
            }
            completion()
        }
    }
    
    func callMovieGenreList(completion: @escaping () -> Void) {
        let url = "https://api.themoviedb.org/3/genre/movie/list"
        
        let header: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer " + APIKey.tmdbBearerKey
        ]
        
        AF.request(url, method: .get, headers: header)
            .responseDecodable(of: GenreList.self) { response in
            switch response.result {
            case .success(let value):
                self.genreList = value.genres
            case .failure(let error):
                print(error)
            }
            completion()
        }
    }
}

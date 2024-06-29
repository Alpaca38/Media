//
//  ViewController.swift
//  Media
//
//  Created by 조규연 on 6/10/24.
//

import UIKit

class HomeViewController: BaseViewController {
    
    let homeView = HomeView()

    override func loadView() {
        super.loadView()
        view = homeView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

}

extension HomeViewController {
    func configureUI() {
        setNavigationBar(tintColor: .black, title: nil)
        let listButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(listButtonTapped))
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonTapped))
        navigationItem.leftBarButtonItem = listButton
        navigationItem.rightBarButtonItem = searchButton
        navigationItem.backButtonDisplayMode = .minimal
        
        homeView.tableView.delegate = self
        homeView.tableView.dataSource = self
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
        return homeView.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell
        let data = homeView.list[indexPath.row]
        let genreList = homeView.genreList
        cell.configure(data: data, genreList: genreList)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = homeView.list[indexPath.row]
        let vc = DetailPosterViewController()
        vc.data = data
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

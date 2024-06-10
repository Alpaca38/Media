//
//  ViewController.swift
//  Media
//
//  Created by 조규연 on 6/10/24.
//

import UIKit
import SnapKit

class HomeViewController: BaseViewController {
    
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell
        
        return cell
    }
    
    
}

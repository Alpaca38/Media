//
//  ViewController.swift
//  Media
//
//  Created by 조규연 on 6/10/24.
//

import UIKit

class TrendingViewController: BaseViewController {
    
    let trendingView = TrendingView()

    override func loadView() {
        view = trendingView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

}

extension TrendingViewController {
    func configureUI() {
        setNavigationBar(tintColor: .black, title: nil)
        let listButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(listButtonTapped))
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonTapped))
        navigationItem.leftBarButtonItem = listButton
        navigationItem.rightBarButtonItem = searchButton
        navigationItem.backButtonDisplayMode = .minimal
        
        trendingView.tableView.delegate = self
        trendingView.tableView.dataSource = self
    }
}

extension TrendingViewController {
    @objc private func listButtonTapped() {
        self.view.makeToast("준비중입니다.", duration: 2, position: .center)
    }
    
    @objc private func searchButtonTapped() {
        let vc = SearchViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension TrendingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trendingView.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrendingTableViewCell.identifier, for: indexPath) as! TrendingTableViewCell
        let data = trendingView.list[indexPath.row]
        let genreList = trendingView.genreList
        cell.configure(data: data, genreList: genreList)
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = trendingView.list[indexPath.row]
        let vc = DetailPosterViewController()
        vc.data = data
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension TrendingViewController: TrendingTableViewCellDelegate {
    func didDetailButtonTapped(_ cell: UITableViewCell) {
        guard let indexPath = trendingView.tableView.indexPath(for: cell) else { return }
        let data = trendingView.list[indexPath.row]
        let vc = DetailViewController()
        vc.data = data
        navigationController?.pushViewController(vc, animated: true)
    }
}

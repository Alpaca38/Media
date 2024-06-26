//
//  DetailViewController.swift
//  Media
//
//  Created by 조규연 on 6/10/24.
//

import UIKit
import Kingfisher

class DetailViewController: BaseViewController {
    
    let detailView = DetailView()
    var data: SearchResult?
    
    override func loadView() {
        super.loadView()
        view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let data else { return }
        detailView.getMovieCredit(data: data)
        configureUI()
    }

}

extension DetailViewController {
    func configureUI() {
        setNavigationBar(tintColor: .black, title: nil)
        
        detailView.castTableView.delegate = self
        detailView.castTableView.dataSource = self
        
        guard let data else { return }
        if data.poster_path != nil {
            let url = URL(string: "https://image.tmdb.org/t/p/original\(data.poster_path!)")
            detailView.posterImageView.kf.setImage(with: url)
        } else {
            detailView.posterImageView.backgroundColor = .darkGray
        }
        
        detailView.titleLabel.text = data.original_title
        
        detailView.overviewLabel.text = data.overview
    }

}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        detailView.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier, for: indexPath) as! CastTableViewCell
        let data = detailView.list[indexPath.row]
        cell.configure(data: data)
        
        return cell
    }
}

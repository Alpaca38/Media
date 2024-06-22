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
    
    let detailView = DetailView()
    var data: movieResult?
    
    override func loadView() {
        super.loadView()
        view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        detailView.getMovieCredit(data: data!)
        configureUI()
    }

}

extension DetailViewController {
    func configureUI() {
        setNavigationBar(tintColor: .black, title: nil)
        
        detailView.castTableView.delegate = self
        detailView.castTableView.dataSource = self
        
        let url = URL(string: "https://image.tmdb.org/t/p/original\(data!.posterPath)")
        detailView.posterImageView.kf.setImage(with: url)
        
        detailView.titleLabel.text = data?.title
        
        detailView.overviewLabel.text = data?.overview
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

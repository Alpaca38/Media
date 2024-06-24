//
//  DetailPosterViewController.swift
//  Media
//
//  Created by 조규연 on 6/24/24.
//

import UIKit

class DetailPosterViewController: BaseViewController {
    var data: movieResult?
    let detailPosterView = DetailPosterView()
    
    override func loadView() {
        super.loadView()
        detailPosterView.similarCollectionView.delegate = self
        detailPosterView.similarCollectionView.dataSource = self
        detailPosterView.recommendCollectionView.delegate = self
        detailPosterView.recommendCollectionView.dataSource = self
        detailPosterView.posterCollectionView.delegate = self
        detailPosterView.posterCollectionView.dataSource = self
        view = detailPosterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let data else { return }
        detailPosterView.getSimilarMovieData(movieID: data.id)
        detailPosterView.getRecommendMovieData(movieID: data.id)
        detailPosterView.getPosterData(movieID: data.id)
        detailPosterView.titleLabel.text = data.title
    }
}

extension DetailPosterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case detailPosterView.similarCollectionView:
            return detailPosterView.similarList.results.count
        case detailPosterView.recommendCollectionView:
            return detailPosterView.recommendList.results.count
        case detailPosterView.posterCollectionView:
            return detailPosterView.posterList.posters.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as! PosterCollectionViewCell
        switch collectionView {
        case detailPosterView.similarCollectionView:
            let data = detailPosterView.similarList.results[indexPath.item]
                        cell.configure(data: data)
        case detailPosterView.recommendCollectionView:
            let data = detailPosterView.recommendList.results[indexPath.item]
            cell.configure(data: data)
        case detailPosterView.posterCollectionView:
            let data = detailPosterView.posterList.posters[indexPath.item]
            cell.configure(data: data)
        default:
            return cell
        }
        return cell
    }
}

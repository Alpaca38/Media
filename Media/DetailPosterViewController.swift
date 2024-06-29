//
//  DetailPosterViewController.swift
//  Media
//
//  Created by 조규연 on 6/24/24.
//

import UIKit
import SnapKit
import Toast

enum DetailPosterCategory: String, CaseIterable {
    case similar = "비슷한 영화"
    case recommend = "추천 영화"
    case poster = "포스터"
}

class DetailPosterViewController: BaseViewController {
    let detailPosterView = DetailPosterView()
    var data: TrendingResult?
    var list: [[PosterData]] = [
        [SimilarMovieResult(posterPath: "")],
        [SimilarMovieResult(posterPath: "")],
        [Backdrop(filePath: "")]
    ]
    
    override func loadView() {
        super.loadView()
        detailPosterView.tableView.delegate = self
        detailPosterView.tableView.dataSource = self
        view = detailPosterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let data else { return }
        detailPosterView.titleLabel.text = data.title
        getPosters()
    }
}

private extension DetailPosterViewController {
    func getPosters() {
        guard let data else { return }
        let waitGroup = DispatchGroup()
        waitGroup.enter()
        DispatchQueue.global().async(group: waitGroup) {
            NetworkManager.shared.getMovieData(api: .similarMovie(movieID: data.id), responseType: SimilarMovie.self) { result in
                switch result {
                case .success(let success):
                    self.list[0] = success.results
                case .failure(let failure):
                    self.view.makeToast("비슷한 영화 정보를 불러오는데 실패했습니다. \(failure.rawValue)", duration: 2, position: .center)
                }
                waitGroup.leave()
            }
        }
        waitGroup.enter()
        DispatchQueue.global().async(group: waitGroup) {
            NetworkManager.shared.getMovieData(api: .recommendMovie(movieID: data.id), responseType: SimilarMovie.self) { result in
                switch result {
                case .success(let success):
                    self.list[1] = success.results
                case .failure(let failure):
                    self.view.makeToast("추천 영화 정보를 불러오는데 실패했습니다. \(failure.rawValue)", duration: 2, position: .center)
                }
                waitGroup.leave()
            }
        }
        waitGroup.enter()
        DispatchQueue.global().async(group: waitGroup) {
            NetworkManager.shared.getMovieData(api: .moviePoster(movieID: data.id), responseType: MovieImage.self) { result in
                switch result {
                case .success(let success):
                    self.list[2] = success.posters
                case .failure(let failure):
                    self.view.makeToast("포스터 정보를 불러오는데 실패했습니다. \(failure.rawValue)", duration: 2, position: .center)
                }
                waitGroup.leave()
            }
        }
        waitGroup.notify(queue: .main) {
            self.detailPosterView.tableView.reloadData()
        }
    }
}

extension DetailPosterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PosterTableViewCell.identifier, for: indexPath) as! PosterTableViewCell
        cell.configure(category: DetailPosterCategory.allCases[indexPath.row].rawValue)
        cell.collectionView.dataSource = self
        cell.collectionView.delegate = self
        cell.collectionView.tag = indexPath.row
        cell.collectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
        cell.collectionView.reloadData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2 {
            return 300
        } else {
            return 200
        }
    }
}

extension DetailPosterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as! PosterCollectionViewCell
        let data = list[collectionView.tag][indexPath.item]
        cell.configure(data: data)
        return cell
    }
}

extension DetailPosterViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 2 {
            return CGSize(width: 180, height: 240)
        } else {
            return CGSize(width: 120, height: 160)
        }
    }
}

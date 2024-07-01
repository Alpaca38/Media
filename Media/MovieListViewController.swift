//
//  MovieListViewController.swift
//  Media
//
//  Created by 조규연 on 6/30/24.
//

import UIKit
import Toast

private enum MovieListCategory: String, CaseIterable {
    case nowplaying = "Now Playing"
    case popular = "Popular"
    case toprated = "Top Rated"
    case upcoming = "Upcoming"
}

final class MovieListViewController: BaseViewController {
    private let movieListView = DetailPosterView(includeWebView: false)
    var list: [[PosterData]] = [[], [], [], []]
    
    override func loadView() {
        movieListView.tableView.delegate = self
        movieListView.tableView.dataSource = self
        movieListView.tableView.rowHeight = 200
        view = movieListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieListView.configureTitleLabel()
        getMovieList()
    }
}

private extension MovieListViewController {
    func getMovieList() {
        let waitGroup = DispatchGroup()
        waitGroup.enter()
        DispatchQueue.global().async(group: waitGroup) {
            NetworkManager.shared.getMovieData(api: .nowPlayingMovie, responseType: NowPlayingMovie.self) { result in
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
            NetworkManager.shared.getMovieData(api: .popularMovie, responseType: PopularMovie.self) { result in
                switch result {
                case .success(let success):
                    self.list[1] = success.results
                case .failure(let failure):
                    self.view.makeToast("비슷한 영화 정보를 불러오는데 실패했습니다. \(failure.rawValue)", duration: 2, position: .center)
                }
                waitGroup.leave()
            }
        }
        waitGroup.enter()
        DispatchQueue.global().async(group: waitGroup) {
            NetworkManager.shared.getMovieData(api: .topRatedMovie, responseType: TopRatedMovie.self) { result in
                switch result {
                case .success(let success):
                    self.list[2] = success.results
                case .failure(let failure):
                    self.view.makeToast("비슷한 영화 정보를 불러오는데 실패했습니다. \(failure.rawValue)", duration: 2, position: .center)
                }
                waitGroup.leave()
            }
        }
        waitGroup.enter()
        DispatchQueue.global().async(group: waitGroup) {
            NetworkManager.shared.getMovieData(api: .upcomingMovie, responseType: UpcomingMovie.self) { result in
                switch result {
                case .success(let success):
                    self.list[3] = success.results
                case .failure(let failure):
                    self.view.makeToast("비슷한 영화 정보를 불러오는데 실패했습니다. \(failure.rawValue)", duration: 2, position: .center)
                }
                waitGroup.leave()
            }
        }
        waitGroup.notify(queue: .main) {
            self.movieListView.tableView.reloadData()
        }
    }
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PosterTableViewCell.identifier, for: indexPath) as! PosterTableViewCell
        cell.configure(category: MovieListCategory.allCases[indexPath.row].rawValue)
        cell.collectionView.dataSource = self
        cell.collectionView.delegate = self
        cell.collectionView.tag = indexPath.row
        cell.collectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
        cell.collectionView.reloadData()
        
        return cell
    }
}

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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

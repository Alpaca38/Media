//
//  NetworkManager.swift
//  Media
//
//  Created by 조규연 on 6/21/24.
//

import Foundation
import Alamofire

class NetworkManager {
    private init() { }
    static let shared = NetworkManager()
    
    func getTrendingMovieData(completion: @escaping (Result<Movie, Error>) -> Void) {
        let url = "https://api.themoviedb.org/3/trending/movie/week"
        
        let header: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer " + APIKey.tmdbBearerKey
        ]
        
        AF.request(url, method: .get, headers: header)
            .responseDecodable(of: Movie.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getMovieGenreList(completion: @escaping (Result<GenreList, Error>) -> Void) {
        let url = "https://api.themoviedb.org/3/genre/movie/list"
        
        let header: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer " + APIKey.tmdbBearerKey
        ]
        
        AF.request(url, method: .get, headers: header)
            .responseDecodable(of: GenreList.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getMovieCredit(id: Int, completion: @escaping (Result<MovieCredit, Error>) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/\(id)/credits"
        
        let header: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer " + APIKey.tmdbBearerKey
        ]
        
        AF.request(url, method: .get, headers: header)
            .validate()
            .responseDecodable(of: MovieCredit.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getSearchData(query: String, page: Int, completion: @escaping (Result<SearchMovie, Error>) -> Void) {
        let url = "https://api.themoviedb.org/3/search/movie"
        
        let parameters: Parameters = [
            "query": query,
            "page": page
        ]
        
        let header: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer " + APIKey.tmdbBearerKey
        ]
        
        AF.request(url,
                   method: .get,
                   parameters: parameters,
                   headers: header)
        .responseDecodable(of: SearchMovie.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getSimilarMovieData(movieID: Int, completion: @escaping (Result<SimilarMovie, Error>) -> ()) {
        let url = "https://api.themoviedb.org/3/movie/\(movieID)/similar"
        
        let header: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer " + APIKey.tmdbBearerKey
        ]
        
        AF.request(url,
                   method: .get,
                   headers: header)
        .responseDecodable(of: SimilarMovie.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getRecommendMovieData(movieID: Int, completion: @escaping (Result<SimilarMovie, Error>) -> ()) {
        let url = "https://api.themoviedb.org/3/movie/\(movieID)/recommendations"
        
        let header: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer " + APIKey.tmdbBearerKey
        ]
        
        AF.request(url,
                   method: .get,
                   headers: header)
        .responseDecodable(of: SimilarMovie.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getPosterData(movieID: Int, completion: @escaping (Result<MovieImage, Error>) -> ()) {
        let url = "https://api.themoviedb.org/3/movie/\(movieID)/images"
        
        let header: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer " + APIKey.tmdbBearerKey
        ]
        
        AF.request(url,
                   method: .get,
                   headers: header)
        .responseDecodable(of: MovieImage.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

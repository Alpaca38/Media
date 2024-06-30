//
//  TMDBAPI.swift
//  Media
//
//  Created by 조규연 on 6/26/24.
//

import Foundation
import Alamofire

enum TMDBAPI {
    case trendingMovie
    case movieGenre
    case movieCreidt(id: Int)
    case searchMovie(query: String, page: Int)
    case similarMovie(movieID: Int)
    case recommendMovie(movieID: Int)
    case moviePoster(movieID: Int)
    case upcomingMovie
    case nowPlayingMovie
    case popularMovie
    case topRatedMovie
    
    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    var endpoint: URL {
        switch self {
        case .trendingMovie:
            return URL(string: baseURL + "trending/movie/week")!
        case .movieGenre:
            return URL(string: baseURL + "genre/movie/list")!
        case .movieCreidt(let id):
            return URL(string: baseURL + "movie/\(id)/credits")!
        case .searchMovie:
            return URL(string: baseURL + "search/movie")!
        case .similarMovie(let movieID):
            return URL(string: baseURL + "movie/\(movieID)/similar")!
        case .recommendMovie(let movieID):
            return URL(string: baseURL + "movie/\(movieID)/recommendations")!
        case .moviePoster(let movieID):
            return URL(string: baseURL + "movie/\(movieID)/images")!
        case .upcomingMovie:
            return URL(string: baseURL + "movie/upcoming")!
        case .nowPlayingMovie:
            return URL(string: baseURL + "movie/now_playing")!
        case .popularMovie:
            return URL(string: baseURL + "movie/popular")!
        case .topRatedMovie:
            return URL(string: baseURL + "movie/top_rated")!
        }
    }
    
    var parameter: Parameters {
        switch self {
        case .trendingMovie, .movieGenre, .movieCreidt, .similarMovie, .recommendMovie, .upcomingMovie, .nowPlayingMovie, .popularMovie, .topRatedMovie:
            return ["language": "ko-KR"]
        case .searchMovie(let query, let page):
            return ["query": query, "page": page, "language": "ko-KR"]
        case .moviePoster:
            return [:]
        }
    }
    
    var header: HTTPHeaders {
        return [
            "accept": "application/json",
            "Authorization": "Bearer " + APIKey.tmdbBearerKey
        ]
    }
    
    var method: HTTPMethod {
        return .get
    }
}

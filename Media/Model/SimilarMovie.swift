//
//  SimilarMovie.swift
//  Media
//
//  Created by 조규연 on 6/24/24.
//

import Foundation

struct SimilarMovie: Codable {
    let page: Int
    let results: [SimilarMovieResult]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct SimilarMovieResult: Codable, PosterData {
    let posterPath: String?
    
    var path: String? {
        return posterPath
    }
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
    }
}
